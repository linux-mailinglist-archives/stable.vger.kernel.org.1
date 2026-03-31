Return-Path: <stable+bounces-231381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePAQBDChy2kUJwYAu9opvQ
	(envelope-from <stable+bounces-231381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:25:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 04932367E4F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54D003047381
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387A23E9293;
	Tue, 31 Mar 2026 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZawC1oeZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F813A9635;
	Tue, 31 Mar 2026 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952236; cv=none; b=MqpHZlJsJx62w/+EO53A+5Q8m3jecd4jYpWETxPZIEPzAVfkpF10kLRHbzLGP5vSZS5oS24WfdLXBVCCwJVT1g789k+ROragSj+rNF70HRKrPbGaCnUiQFb1DSNQxs/gnd+nsm9jRo0E1PjnM9Nsmo+DJcjK9pzSdYbq3JSud6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952236; c=relaxed/simple;
	bh=JjgUzGEmEGp0F8hHCNuzU4zVUzQ/FN3dLrsS4OVz1os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sr/e/L6XTO0hNHxOhHasOG6ACGqs+i01dckBTBdwr+drJ5naluMlIxjForr7lGDZ9VUWKWeghWNNhVefzQUQqdY+kF5rrbMoTxDkqIamNjNAyWXvugZh9YDlSzgS9xyHPNUHmkZPo27UIqMxgPXRVEK5/B/94m9ECMc+vh2s2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZawC1oeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1E1C19423;
	Tue, 31 Mar 2026 10:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774952235;
	bh=JjgUzGEmEGp0F8hHCNuzU4zVUzQ/FN3dLrsS4OVz1os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZawC1oeZQmVb3CIz5lh8JhjzGjMhZNt6ZeX3oqc5ilN1oSkW5sp7GUiT1hybjA9m9
	 ozibi1zZb4q1yqWFOj/ih99XPidU7zH6UEg1gwQ3H/wOffnQFgZw+ExTG11A2eRgeC
	 Zf+gQCz8m2oN3eOj/iCmjnKv+FRzrRX8yXf0nHow=
Date: Tue, 31 Mar 2026 12:17:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tim Chirananthavat <theemathas@gmail.com>, stable@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.19.y 2/2] rust: pin-init: replace shadowed return token
 by `unsafe`-to-create token
Message-ID: <2026033133-reroute-sugar-4d95@gregkh>
References: <20260325125734.944247-1-lossin@kernel.org>
 <20260325125734.944247-2-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325125734.944247-2-lossin@kernel.org>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231381-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,garyguo.net:email,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 04932367E4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 01:57:32PM +0100, Benno Lossin wrote:
> [ Upstream commit fdbaa9d2b78e0da9e1aeb303bbdc3adfe6d8e749 ]
> 
> We use a unit struct `__InitOk` in the closure generated by the
> initializer macros as the return value. We shadow it by creating a
> struct with the same name again inside of the closure, preventing early
> returns of `Ok` in the initializer (before all fields have been
> initialized).
> 
> In the face of Type Alias Impl Trait (TAIT) and the next trait solver,
> this solution no longer works [1]. The shadowed struct can be named
> through type inference. In addition, there is an RFC proposing to add
> the feature of path inference to Rust, which would similarly allow [2].
> 
> Thus remove the shadowed token and replace it with an `unsafe` to create
> token.
> 
> The reason we initially used the shadowing solution was because an
> alternative solution used a builder pattern. Gary writes [3]:
> 
>     In the early builder-pattern based InitOk, having a single InitOk
>     type for token is unsound because one can launder an InitOk token
>     used for one place to another initializer. I used a branded lifetime
>     solution, and then you figured out that using a shadowed type would
>     work better because nobody could construct it at all.
> 
> The laundering issue does not apply to the approach we ended up with
> today.
> 
> With this change, the example by Tim Chirananthavat in [1] no longer
> compiles and results in this error:
> 
>     error: cannot construct `pin_init::__internal::InitOk` with struct literal syntax due to private fields
>       --> src/main.rs:26:17
>        |
>     26 |                 InferredType {}
>        |                 ^^^^^^^^^^^^
>        |
>        = note: private field `0` that was not provided
>     help: you might have meant to use the `new` associated function
>        |
>     26 -                 InferredType {}
>     26 +                 InferredType::new()
>        |
> 
> Applying the suggestion of using the `::new()` function, results in
> another expected error:
> 
>     error[E0133]: call to unsafe function `pin_init::__internal::InitOk::new` is unsafe and requires unsafe block
>       --> src/main.rs:26:17
>        |
>     26 |                 InferredType::new()
>        |                 ^^^^^^^^^^^^^^^^^^^ call to unsafe function
>        |
>        = note: consult the function's documentation for information on how to avoid undefined behavior
> 
> Reported-by: Tim Chirananthavat <theemathas@gmail.com>
> Link: https://github.com/rust-lang/rust/issues/153535 [1]
> Link: https://github.com/rust-lang/rfcs/pull/3444#issuecomment-4016145373 [2]
> Link: https://github.com/rust-lang/rust/issues/153535#issuecomment-4017620804 [3]
> Fixes: fc6c6baa1f40 ("rust: init: add initialization macros")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Link: https://patch.msgid.link/20260311105056.1425041-1-lossin@kernel.org
> [ Added period as mentioned. - Miguel ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> [ Moved to declarative macro, because 6.19.y and earlier do not have
>   `syn`. - Benno ]
> Signed-off-by: Benno Lossin <lossin@kernel.org>

This commit blows up the build for me with lots of errors like:

error[E0433]: failed to resolve: could not find `init` in `$crate`
   --> rust/kernel/maple_tree.rs:393:20
    |
393 |           let tree = pin_init!(MapleTree {
    |  ____________________^
394 | |             // SAFETY: This initializes a maple tree into a pinned slot. The maple tree will be
395 | |             // destroyed in Drop before the memory location becomes invalid.
396 | |             tree <- Opaque::ffi_init(|slot| unsafe {
...   |
399 | |             _p: PhantomData,
400 | |         });
    | |__________^ could not find `init` in `$crate`
    |
    = note: this error originates in the macro `$crate::__init_internal` which comes from the expansion of the macro `pin_init` (in Nightly builds, run with -Z macro-backtrace for more info)



So I'll take patch 1 here, but not this one :(

thanks,

greg k-h

