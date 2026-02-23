Return-Path: <stable+bounces-217810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMWOOSmUnGnRJQQAu9opvQ
	(envelope-from <stable+bounces-217810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:53:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A30817B218
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 945F63058E3D
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2208F33A9F3;
	Mon, 23 Feb 2026 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQJr18d6"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD77633A714
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868907; cv=pass; b=Alg2JbQin+d92a5hsHC82oXLfObJX39fydmzpC5LHfnK1GPlZMg+dRBshySx7o11ZMOOWCvSQd4ThX+N3vfrbg7cwVDgaK5zS10WABC+A4GkZE2bvLM8pw2eZBRE0Y23sBO7xHpjnJy3BdeVpeI7HXK3EVZ0YzUxR883K/ElS7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868907; c=relaxed/simple;
	bh=AoYn0yFpwz10cwExt3RnafbWOT5+DafJvEoxrLpXtWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gs+5wAa5O7GWwdTqg89viApYc8LG1qnggHHaBsB0XWgEeOGwza4DlXbWtvQyKaZeTuRAZEOtPIcEZLsU6tdIgQ0RUE9qEZicPv9UXyeV49ZImDo4w0dc2inEEYxtdkPm2eN0r+A0+DQu/OOxhnk4Bo24ynJWwq05Asyh+ciCPac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQJr18d6; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bd801b40dbso147059eec.0
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 09:48:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771868905; cv=none;
        d=google.com; s=arc-20240605;
        b=IMpGZmTjfKnOKZNiyIq2TmCqAdn0vUrdvYpKXCnIa25c0wJVHDYW/rpZnHVYp9Huqn
         WhOW5KQJXDJdNNg0gxC55CuDpeZyttR7RAzW33AjFHfspfsWDM+s2v988kFBDcYxmbUD
         xVJf9If9Lor/WzadUrvd2IIim84CejY/4RGmT5PcdKvfma2R/ka6mM2WnGHdkKtdeQ+S
         jWIK3j1fkyycm8ilKAexWxdVoUfkjLFx7/CXHhfgwXPSIrTRYO34e8XY/T4kI5kCBR27
         ExwODG6LYjHc4Zn2pYXbfiBX6jmj0FO59tJsqd082iwPmN0ndO19ijC1Q5IscbrB4dhs
         GFhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=euw0JHqcmS+ppcTj8AUJZXArv+sJffQNQGM/GEcKb/Q=;
        fh=4Xu3bDV88u+lHwEC98v1eCSX1lzUp/G7jYwlFhcDubc=;
        b=GfFqYheUg3EfzrUfnMvmrYeMWxkHMMKtu1YSoVDZ+w1mg+ZfFiydlMA3MPdmF+hUTY
         lVcH413KnMCgs87zMJ1yT+ri0nHdAOAixU+cw4bWmgE+Vkr9AE6XE8I6DomAoK3lRrep
         54Q/QwZdoqrmevf5aVqKIs4hIl+SGghfiCpWagDX//8UDg6b1yeowlCm6L3dgCbbAkYr
         QNXPNbCOYormCjgWV/HVdsdpcYUHWZNb9lH6PsCtiaVqioKNtl/LdC76sEu3dN4jXLWk
         adkVuTDYwvbDYx+GQYFaCDGE+yz+isrngBxkWhnM/P4NfkT6YkoBF0zknfmVqmd13h18
         92Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868905; x=1772473705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euw0JHqcmS+ppcTj8AUJZXArv+sJffQNQGM/GEcKb/Q=;
        b=IQJr18d60r/F/kagqaPX7yAbanB0YegGr3fPOUknbNB+/RI4Lv+4ihbHZQfBjcH1bF
         fMLKtZhfNg90naLo9epuWGWsPK6nxKbgSlM4GpjyCkU37eKXUn3BBUU8pXsWmlxTeUP7
         68fhNTwYBA97f5Uut/vognc6ox1pjBsl2S2QewvY20oWenkzattJh+bHHlQpdPEnDqel
         as96VKthO6vMMR6R78uHGuhwZkSZZZIaQJDO+w8okAsGFz7khjWqR/0npg0mgMw2m08S
         bcBRLI/2dqyyQxrX690jHpDkf9YQxQMAxP1L7y3y6zy9+GgDF15W3LvJW7Srn2vPP+AR
         8m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868905; x=1772473705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=euw0JHqcmS+ppcTj8AUJZXArv+sJffQNQGM/GEcKb/Q=;
        b=BwAPEbnyWrxw/jjWMJmYqcrZY8daJiXZxD8HQUW/TnT/cCVtqaGDGpFW/r7XvVDqb2
         YTbAhVO1fenXOIdxh78nFIHWwXul4DDD2sNshtGAxk3QasxfBmVBl2Sw0aUw3FooGFa4
         NAfFPxc7y0WGi0c/72l8TF5RCMHFfcAHN0ZTmSCAUVf7g8JflMKUYrrAJ3v1qN/gu2E6
         el0mu9t0sKD3/dl4oKMn9QKE5jCS+jRn9geZp0GiO9J4Y5iHdG2qqGh3qWlWdZ+DeQe5
         3305rN7yroG2XB55SxP5I9MN8EOfyQ5J7S2afXXwF52LdeorjFXMqFzWwgG9p/g6S2bm
         +QBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW67cmz60R4L9SoX/zCfYUT6HnxBebZeJ4nMvDCfjkjAlBtxi+omLxtVa41zreQT13bPI1AIBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIDJ8fcYqIjjZIVS6aq53Gvte+oT3KVzXHmtSbal+UtNSv+VkC
	Vvf3m52L0D0sCQ8uHdUOTAUFgUOUUFXsj7Uv2ovQ/fNKot4OBToAbRkZB9HQ65BK08YdtMNDiLE
	MKYGsinxhAhYtkDZFF7feHcj74NjiIGA=
X-Gm-Gg: ATEYQzxIL30yFgdwQTX9BRdfjRUhdGxb9Rz0k+SPzpoaoACsuCliYXjEIJflckDHjQI
	FF58BvGSyatoM1BY3Yd1BkUvn6Lr6RH1yEylrUxx6jYdeDH2Tz55RsOfC16WF0ZNysULzUIZpJ8
	91RFQxY6dRJxvSUBckTB7aWmPM6xji9PzWefcNNjg/b6Db4KlMhqYDXoAjF6gLovRz4X6o4UVUy
	8Ncj7wUsTtsiW5NxOPR8BTjpG8qHq+dnGJsb64S3l5UIhuqD8dOV9kMWBuJ47+LYX0YMLDzLmI4
	It5Zer7n9miQOrbH1P0fxBqxaY0NjgIWpWf7PCSzjBxarBMofXZsIVyfbC2uL5aBVwM0Cz1ahIa
	a9bQsK/U19qopdV6xg5GNXzSc
X-Received: by 2002:a05:7300:e207:b0:2ab:ca55:8940 with SMTP id
 5a478bee46e88-2bd7bdaec84mr1888941eec.7.1771868904780; Mon, 23 Feb 2026
 09:48:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216131613.45344-3-phasta@kernel.org>
In-Reply-To: <20260216131613.45344-3-phasta@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Feb 2026 18:48:12 +0100
X-Gm-Features: AaiRm52IsjI6CwbLcieZsME5VB38JLQHKnKzKp5HwF2Z11wo3cc9U_53Axmcu6E
Message-ID: <CANiq72kEwVVja4u-zqk3ubqrV4WMFihKgeUAX4ey19gW6BoXpA@mail.gmail.com>
Subject: Re: [PATCH v4] rust: list: Add unsafe for container_of
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217810-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[impl_list_item_mod.rs:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4A30817B218
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 2:17=E2=80=AFPM Philipp Stanner <phasta@kernel.org>=
 wrote:
>
> impl_list_item_mod.rs calls container_of() without unsafe blocks at a
> couple of places. Since container_of() is an unsafe macro / function,
> the blocks are strictly necessary.
>
> The problem was so far not visible because the "unsafe-op-in-unsafe-fn"
> check is a linter rather than a compiler check. Rust suppresses lint
> checks triggered inside of a macro from another crate. Thus, the error
> becomes only visible once someone from without the core crate tries to
> use linked lists:
>
> error[E0133]: call to unsafe function `core::ptr::mut_ptr::<impl *mut T>:=
:byte_sub`
> is unsafe and requires unsafe block
>    --> rust/kernel/lib.rs:252:29
>     |
> 252 |           let container_ptr =3D field_ptr.byte_sub(offset).cast::<$=
Container>();
>     |                               ^^^^^^^^^^^^^^^^^^^^^^^^^^ call to un=
safe function
>     |
>    ::: rust/kernel/drm/jq.rs:98:1
>     |
> 98  | / impl_list_item! {
> 99  | |     impl ListItem<0> for BasicItem { using ListLinks { self.links=
 }; }
> 100 | | }
>     | |_- in this macro invocation
>     |
> note: an unsafe function restricts its caller, but its body is safe by de=
fault
>    --> rust/kernel/list/impl_list_item_mod.rs:216:13
>     |
> 216 |               unsafe fn view_value(me: *mut $crate::list::ListLinks=
<$num>) -> *const Self {
>     |               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^
>     |
>    ::: rust/kernel/drm/jq.rs:98:1
>     |
> 98  | / impl_list_item! {
> 99  | |     impl ListItem<0> for BasicItem { using ListLinks { self.links=
 }; }
> 100 | | }
>     | |_- in this macro invocation
>     =3D note: requested on the command line with `-D unsafe-op-in-unsafe-=
fn`
>     =3D note: this error originates in the macro `$crate::container_of` w=
hich comes
>     from the expansion of the macro `impl_list_item`
>
> Add unsafe blocks to container_of to fix the issue.
>
> Cc: stable@vger.kernel.org
> Fixes: c77f85b347dd ("rust: list: remove OFFSET constants")
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

(I said it was applied, but for completeness, let me send my usual
message here... The commit is in mainline already.).

Applied to `rust-fixes` -- thanks everyone!

    [ As discussed, let's fix the build for those that want to use the
      macro within the `kernel` crate now and we can discuss the proper
      safety comments afterwards. Thus I removed the ones from the patch.

      However, we cannot just avoid the comments with `CLIPPY=3D1`, so I
      provided placeholders for now, like we did in the past. They were
      also needed for an `unsafe impl`.

      While I am not happy about it, it isn't worse than the current
      status (the comments were meant to be there), and at least this
      shows what is missing -- our pre-existing "good first issue" [1]
      may motivate new contributors to complete them properly.

      Finally, I moved one of the existing safety comments one line down
      so that Clippy could locate it.

      Link: https://github.com/Rust-for-Linux/linux/issues/351 [1]

        - Miguel ]

    [ Fixed formatting. Reworded to fix the lint suppression
      explanation. Indent build error. - Miguel ]

Cheers,
Miguel

