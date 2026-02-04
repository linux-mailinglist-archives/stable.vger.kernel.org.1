Return-Path: <stable+bounces-213367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE0EFyMgg2nWhwMAu9opvQ
	(envelope-from <stable+bounces-213367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 11:32:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B28F0E484B
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 11:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7333C3039803
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 10:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D22E3DA7DA;
	Wed,  4 Feb 2026 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8MjBlvc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A33DA7C8
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201008; cv=none; b=pmGvcZ/ypLlF0cST5ui8vsCAXXLGfwFbhsml2Pm2n2lgteXqKkdTLlz6C//P5ku6DCssp/bv2sPIlrE+EsnuOdApxM31gQDdilS6btsPCqUE052YMuDtzg+8jcmZmaScaZGtvhJlQ0cXSEYGBZYvLWtgAVQYhWiqXP2LLiE5VxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201008; c=relaxed/simple;
	bh=2UIZKStHuem4vyD9tR6NvtzZe7OLWtG1Pj1z+tGYGA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KM7Fc7e6NgmNq/IqxXkNuFEUXZ99yVBU6aLV7xEvWrOtV7eKC1bj7UiAC9aFN551emMODSaOZaOcaQGqE4ZeksdX5y9c02IsurMM2/09lhJLoWtgFkHWR7J6fAeVfYtaL5RuvVyi56BbMVNxDTYhHARA+if0tsTwlJIMNWFodgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c8MjBlvc; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48057c39931so74078875e9.0
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 02:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770201006; x=1770805806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8XSWebpuCWegMlwjG4hS6R8tDkiXl6gBTB7fLfLRPN4=;
        b=c8MjBlvcqlQQCv3adiMbtOGJYaPrIvKhOwqvH4zpQKXxrAhCXpJwSw5pGcYEwVrYPz
         AD4kna/J70h6yiObSvQnXC9Mn/ghDyOqTHxqjiB5a9zEoSnfulEFiL+X9vHSHtMghLqU
         53sC7zgkJVF9wrOmKmBY9NrgaP9XE7fwnDrrl2gEFRuw8dXNL0Va4nrYiOGAHqZIIrXT
         bxsKMrifNHUxHXuiFHkyquc5mYMpJ1NZWEMEMeE/cpjD9SuY3wsSWqm4kmC/f2iXlWT8
         +YlqYVdyPw6UHVONkhy/F9mGr0EmO+gIvOk/ruAk+9v5mvL38RoP/iAl04+E4IcYIkQx
         g8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770201006; x=1770805806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XSWebpuCWegMlwjG4hS6R8tDkiXl6gBTB7fLfLRPN4=;
        b=EKwBulF9/BSKZocjzWUubEoV8iH0sGFzhC2BhMeR8nrJ9ik9c4QRq13FXHDhVE+FVx
         F/ls8M+8SvxbGIcdTsI0YCTrMWHs0735a7U1+rNhP2TkNZ0nj0O9zXFrRbwHyJOQwGdK
         8DFzeeupfLNywKl5urahiT4FBNtp3lXykyh5GKSEKC/JM/IyERuFUd5a8CgCdldQltIF
         fJWTHOXVXqeoasK5+3CjyZCGGt7OMxk1y4lzCYkNcnJIcmgxhBM1lQvCxdQC6OrtDQO4
         0Bah6HpIiNW4wY1w+CwFpeIjkJH3BPvnAtACAi3NJvwzZsfniGl1zirtAlqAUSyARsEF
         e1mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWukp0bwo1I1+tPfbORw55ZNoWSiIy6uVvOfrneJ2UrpbEEWduBuuZSDzV+Lf0GT8VcNr8hPCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9JMSYjeG9iCr/I15mbYJliLXgIEPhGo5QrkeCnzjpx6Ctrzjk
	F7tb3KOQULr2UCZBjewIScUvQ5owjm4HA3qNccLf/QQWqYOvtvp4a3I0URlh0bVg/pzeR38C77q
	HL/1bAQTxH+BzKaK08A==
X-Received: from wmber8.prod.google.com ([2002:a05:600c:84c8:b0:47e:e4a5:c5f2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c02:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-4830e96fb19mr35946565e9.22.1770201006224;
 Wed, 04 Feb 2026 02:30:06 -0800 (PST)
Date: Wed, 4 Feb 2026 10:30:05 +0000
In-Reply-To: <20260203081403.68733-3-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203081403.68733-2-phasta@kernel.org> <20260203081403.68733-3-phasta@kernel.org>
Message-ID: <aYMfrT_Cv2NC-MB1@google.com>
Subject: Re: [RFC PATCH 1/4] rust: list: Add unsafe for container_of
From: Alice Ryhl <aliceryhl@google.com>
To: Philipp Stanner <phasta@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, Benno Lossin <lossin@kernel.org>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213367-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,kernel.org,garyguo.net,amd.com,collabora.com,nvidia.com,vger.kernel.org,lists.freedesktop.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B28F0E484B
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 09:14:00AM +0100, Philipp Stanner wrote:
> impl_list_item_mod.rs calls container_of() without unsafe blocks at a
> couple of places. Since container_of() is an unsafe macro / function,
> the blocks are strictly necessary.
> 
> For unknown reasons, that problem was so far not visible and only gets
> visible once one utilizes the list implementation from within the core
> crate:
> 
> error[E0133]: call to unsafe function `core::ptr::mut_ptr::<impl *mut T>::byte_sub`
> is unsafe and requires unsafe block
>    --> rust/kernel/lib.rs:252:29
>     |
> 252 |           let container_ptr = field_ptr.byte_sub(offset).cast::<$Container>();
>     |                               ^^^^^^^^^^^^^^^^^^^^^^^^^^ call to unsafe function
>     |
>    ::: rust/kernel/drm/jq.rs:98:1
>     |
> 98  | / impl_list_item! {
> 99  | |     impl ListItem<0> for BasicItem { using ListLinks { self.links }; }
> 100 | | }
>     | |_- in this macro invocation
>     |
> note: an unsafe function restricts its caller, but its body is safe by default
>    --> rust/kernel/list/impl_list_item_mod.rs:216:13
>     |
> 216 |               unsafe fn view_value(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
>     |               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     |
>    ::: rust/kernel/drm/jq.rs:98:1
>     |
> 98  | / impl_list_item! {
> 99  | |     impl ListItem<0> for BasicItem { using ListLinks { self.links }; }
> 100 | | }
>     | |_- in this macro invocation
>     = note: requested on the command line with `-D unsafe-op-in-unsafe-fn`
>     = note: this error originates in the macro `$crate::container_of` which comes
>     from the expansion of the macro `impl_list_item`
> 
> Add unsafe blocks to container_of to fix the issue.
> 
> Cc: stable@vger.kernel.org # v6.17+
> Fixes: c77f85b347dd ("rust: list: remove OFFSET constants")
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

With the reason that Gary shared added to the commit message:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> ---
>  rust/kernel/list/impl_list_item_mod.rs | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
> index 202bc6f97c13..7052095efde5 100644
> --- a/rust/kernel/list/impl_list_item_mod.rs
> +++ b/rust/kernel/list/impl_list_item_mod.rs
> @@ -217,7 +217,7 @@ unsafe fn view_value(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
>                  // SAFETY: `me` originates from the most recent call to `prepare_to_insert`, so it
>                  // points at the field `$field` in a value of type `Self`. Thus, reversing that
>                  // operation is still in-bounds of the allocation.
> -                $crate::container_of!(me, Self, $($field).*)
> +                unsafe { $crate::container_of!(me, Self, $($field).*) }
>              }
>  
>              // GUARANTEES:
> @@ -242,7 +242,7 @@ unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
>                  // SAFETY: `me` originates from the most recent call to `prepare_to_insert`, so it
>                  // points at the field `$field` in a value of type `Self`. Thus, reversing that
>                  // operation is still in-bounds of the allocation.
> -                $crate::container_of!(me, Self, $($field).*)
> +                unsafe { $crate::container_of!(me, Self, $($field).*) }
>              }
>          }
>      )*};
> @@ -270,9 +270,9 @@ unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate::list::ListLinks<$nu
>                  // SAFETY: The caller promises that `me` points at a valid value of type `Self`.
>                  let links_field = unsafe { <Self as $crate::list::ListItem<$num>>::view_links(me) };
>  
> -                let container = $crate::container_of!(
> +                let container = unsafe { $crate::container_of!(
>                      links_field, $crate::list::ListLinksSelfPtr<Self, $num>, inner
> -                );
> +                ) };

It may be cleaner to write this as:

let container = unsafe {
    $crate::container_of!(
        links_field, $crate::list::ListLinksSelfPtr<Self, $num>, inner
    )
};

Rustfmt has no effect on macro definitions, but if this was not a macro,
then I believe that rustfmt would format it like the above.

>  
>                  // SAFETY: By the same reasoning above, `links_field` is a valid pointer.
>                  let self_ptr = unsafe {
> @@ -319,9 +319,9 @@ unsafe fn view_links(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
>              //   `ListArc` containing `Self` until the next call to `post_remove`. The value cannot
>              //   be destroyed while a `ListArc` reference exists.
>              unsafe fn view_value(links_field: *mut $crate::list::ListLinks<$num>) -> *const Self {
> -                let container = $crate::container_of!(
> +                let container = unsafe { $crate::container_of!(
>                      links_field, $crate::list::ListLinksSelfPtr<Self, $num>, inner
> -                );
> +                ) };

Ditto here.

Alice

