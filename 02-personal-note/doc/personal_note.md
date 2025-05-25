
<a id="0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note"></a>

# Module `0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e::personal_note`



-  [Struct `Note`](#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_Note)
-  [Resource `UserNotes`](#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_UserNotes)
-  [Constants](#@Constants_0)
-  [Function `init_user`](#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_init_user)
-  [Function `add_note`](#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_add_note)
-  [Function `view_notes`](#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_view_notes)
-  [Function `delete_note`](#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_delete_note)
-  [Function `update_note`](#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_update_note)


<pre><code><b>use</b> <a href="">0x1::signer</a>;
<b>use</b> <a href="">0x1::string</a>;
<b>use</b> <a href="">0x1::timestamp</a>;
<b>use</b> <a href="">0x1::vector</a>;
</code></pre>



<a id="0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_Note"></a>

## Struct `Note`

core data structures


<pre><code><b>struct</b> <a href="personal_note.md#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_Note">Note</a> <b>has</b> <b>copy</b>, drop, store
</code></pre>



<a id="0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_UserNotes"></a>

## Resource `UserNotes`

can't be copied or dropped so it's a resource
it is stored in the global storage


<pre><code><b>struct</b> <a href="personal_note.md#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_UserNotes">UserNotes</a> <b>has</b> key
</code></pre>



<a id="@Constants_0"></a>

## Constants


<a id="0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_ENOTE_NOT_FOUND"></a>

when note is not found
(e.g. when user tries to delete a note that does not exist)
or when user tries to get a note that does not exist)


<pre><code><b>const</b> <a href="personal_note.md#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_ENOTE_NOT_FOUND">ENOTE_NOT_FOUND</a>: u64 = 2;
</code></pre>



<a id="0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_EUSER_ALREADY_INITIALIZED"></a>

when user has already initialized their notes


<pre><code><b>const</b> <a href="personal_note.md#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_EUSER_ALREADY_INITIALIZED">EUSER_ALREADY_INITIALIZED</a>: u64 = 1;
</code></pre>



<a id="0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_EUSER_NOT_INITIALIZED"></a>

when user has not initialized their notes


<pre><code><b>const</b> <a href="personal_note.md#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_EUSER_NOT_INITIALIZED">EUSER_NOT_INITIALIZED</a>: u64 = 0;
</code></pre>



<a id="0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_init_user"></a>

## Function `init_user`



<pre><code><b>public</b> entry <b>fun</b> <a href="personal_note.md#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_init_user">init_user</a>(<a href="">account</a>: &<a href="">signer</a>)
</code></pre>



<a id="0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_add_note"></a>

## Function `add_note`



<pre><code><b>public</b> entry <b>fun</b> <a href="personal_note.md#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_add_note">add_note</a>(<a href="">account</a>: &<a href="">signer</a>, content: <a href="_String">string::String</a>)
</code></pre>



<a id="0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_view_notes"></a>

## Function `view_notes`



<pre><code>#[view]
<b>public</b> <b>fun</b> <a href="personal_note.md#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_view_notes">view_notes</a>(user_address: <b>address</b>): <a href="">vector</a>&lt;<a href="personal_note.md#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_Note">personal_note::Note</a>&gt;
</code></pre>



<a id="0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_delete_note"></a>

## Function `delete_note`



<pre><code><b>public</b> entry <b>fun</b> <a href="personal_note.md#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_delete_note">delete_note</a>(<a href="">account</a>: &<a href="">signer</a>, index: u64)
</code></pre>



<a id="0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_update_note"></a>

## Function `update_note`



<pre><code><b>public</b> entry <b>fun</b> <a href="personal_note.md#0xd251724175b2caa8a45ae4c36578b1edb3ee294f766a9efb735f3a2cf53b879e_personal_note_update_note">update_note</a>(<a href="">account</a>: &<a href="">signer</a>, index: u64, new_content: <a href="_String">string::String</a>)
</code></pre>
