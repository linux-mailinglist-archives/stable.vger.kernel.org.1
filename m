Return-Path: <stable+bounces-231427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO4fJwbSy2mILwYAu9opvQ
	(envelope-from <stable+bounces-231427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:54:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF3B36A8DA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC11D302E17F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84E3394487;
	Tue, 31 Mar 2026 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v1vlH/2n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840626BFCE;
	Tue, 31 Mar 2026 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965197; cv=none; b=k+4jbHqFF5vmhgSXjQP883v/0ihF+P/KeLiI/LRWd0mh+MnPS7ChPC39YxTG1vUtFdoIpKZ5cLGwln0d+s5ILqGt/11dC56ciHqSPjINvzduK6rMoQo4EPYbmg/TJbPZ4/qRCEnZPhgSgDdRbMo/CGkdPbzV4UFrbDVJ6fajiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965197; c=relaxed/simple;
	bh=I3dptCiiXITnmM3zzMUzpmCghO2uT7qXYnUhMpCc1+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiVBYexFg35HcD9QtSa6vdMesO3yW/XgemYTjhUQUTBapcVECrCkRdOzjpsFvEt+2ReW3CGdryGjGSATQITJGCSBk/YBSa7Wlh8uNyqc//yPTaP3vJ8zln+1dDwEiIWOtnBxdxgVAQup9WATLbEzDsrnJxuUQXlTA7/rZWC/dQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v1vlH/2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45FBC19423;
	Tue, 31 Mar 2026 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774965197;
	bh=I3dptCiiXITnmM3zzMUzpmCghO2uT7qXYnUhMpCc1+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v1vlH/2nIKqiSWgzh8gcV2x+Sc6kX0K4svFVBAiVP0yiIMySh0g5zqDy2gG9bo494
	 2U3m3GKJC255BfcjG/ltQYkuGfW+oe2jhOhA6xJCcH/+7p5ESNU89FnxL26K31AHww
	 zbTzThC/rE5QMg08eDjikXIypvtQcPa6Pyq8puGI=
Date: Tue, 31 Mar 2026 15:53:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gary Guo <gary@garyguo.net>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tim Chirananthavat <theemathas@gmail.com>, stable@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.19.y 2/2] rust: pin-init: replace shadowed return token
 by `unsafe`-to-create token
Message-ID: <2026033159-jaundice-crayon-aecb@gregkh>
References: <20260325125734.944247-1-lossin@kernel.org>
 <20260325125734.944247-2-lossin@kernel.org>
 <2026033133-reroute-sugar-4d95@gregkh>
 <DHH0AG3OW3RO.O79RKFY0VR85@garyguo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHH0AG3OW3RO.O79RKFY0VR85@garyguo.net>
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
	TAGGED_FROM(0.00)[bounces-231427-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,protonmail.com,google.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,garyguo.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 9CF3B36A8DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 02:36:21PM +0100, Gary Guo wrote:
> On Tue Mar 31, 2026 at 11:17 AM BST, Greg KH wrote:
> > On Wed, Mar 25, 2026 at 01:57:32PM +0100, Benno Lossin wrote:
> >> [ Upstream commit fdbaa9d2b78e0da9e1aeb303bbdc3adfe6d8e749 ]
> >> 
> >> We use a unit struct `__InitOk` in the closure generated by the
> >> initializer macros as the return value. We shadow it by creating a
> >> struct with the same name again inside of the closure, preventing early
> >> returns of `Ok` in the initializer (before all fields have been
> >> initialized).
> >> 
> >> In the face of Type Alias Impl Trait (TAIT) and the next trait solver,
> >> this solution no longer works [1]. The shadowed struct can be named
> >> through type inference. In addition, there is an RFC proposing to add
> >> the feature of path inference to Rust, which would similarly allow [2].
> >> 
> >> Thus remove the shadowed token and replace it with an `unsafe` to create
> >> token.
> >> 
> >> The reason we initially used the shadowing solution was because an
> >> alternative solution used a builder pattern. Gary writes [3]:
> >> 
> >>     In the early builder-pattern based InitOk, having a single InitOk
> >>     type for token is unsound because one can launder an InitOk token
> >>     used for one place to another initializer. I used a branded lifetime
> >>     solution, and then you figured out that using a shadowed type would
> >>     work better because nobody could construct it at all.
> >> 
> >> The laundering issue does not apply to the approach we ended up with
> >> today.
> >> 
> >> With this change, the example by Tim Chirananthavat in [1] no longer
> >> compiles and results in this error:
> >> 
> >>     error: cannot construct `pin_init::__internal::InitOk` with struct literal syntax due to private fields
> >>       --> src/main.rs:26:17
> >>        |
> >>     26 |                 InferredType {}
> >>        |                 ^^^^^^^^^^^^
> >>        |
> >>        = note: private field `0` that was not provided
> >>     help: you might have meant to use the `new` associated function
> >>        |
> >>     26 -                 InferredType {}
> >>     26 +                 InferredType::new()
> >>        |
> >> 
> >> Applying the suggestion of using the `::new()` function, results in
> >> another expected error:
> >> 
> >>     error[E0133]: call to unsafe function `pin_init::__internal::InitOk::new` is unsafe and requires unsafe block
> >>       --> src/main.rs:26:17
> >>        |
> >>     26 |                 InferredType::new()
> >>        |                 ^^^^^^^^^^^^^^^^^^^ call to unsafe function
> >>        |
> >>        = note: consult the function's documentation for information on how to avoid undefined behavior
> >> 
> >> Reported-by: Tim Chirananthavat <theemathas@gmail.com>
> >> Link: https://github.com/rust-lang/rust/issues/153535 [1]
> >> Link: https://github.com/rust-lang/rfcs/pull/3444#issuecomment-4016145373 [2]
> >> Link: https://github.com/rust-lang/rust/issues/153535#issuecomment-4017620804 [3]
> >> Fixes: fc6c6baa1f40 ("rust: init: add initialization macros")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Benno Lossin <lossin@kernel.org>
> >> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >> Reviewed-by: Gary Guo <gary@garyguo.net>
> >> Link: https://patch.msgid.link/20260311105056.1425041-1-lossin@kernel.org
> >> [ Added period as mentioned. - Miguel ]
> >> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> >> [ Moved to declarative macro, because 6.19.y and earlier do not have
> >>   `syn`. - Benno ]
> >> Signed-off-by: Benno Lossin <lossin@kernel.org>
> >
> > This commit blows up the build for me with lots of errors like:
> >
> > error[E0433]: failed to resolve: could not find `init` in `$crate`
> >    --> rust/kernel/maple_tree.rs:393:20
> >     |
> > 393 |           let tree = pin_init!(MapleTree {
> >     |  ____________________^
> > 394 | |             // SAFETY: This initializes a maple tree into a pinned slot. The maple tree will be
> > 395 | |             // destroyed in Drop before the memory location becomes invalid.
> > 396 | |             tree <- Opaque::ffi_init(|slot| unsafe {
> > ...   |
> > 399 | |             _p: PhantomData,
> > 400 | |         });
> >     | |__________^ could not find `init` in `$crate`
> >     |
> >     = note: this error originates in the macro `$crate::__init_internal` which comes from the expansion of the macro `pin_init` (in Nightly builds, run with -Z macro-backtrace for more info)
> >
> >
> >
> > So I'll take patch 1 here, but not this one :(
> 
> This was dicussed in a RfL call, and we think it's fine to not backport this
> specific patch.
> 
> The soundness issue that this patch is fixing relies on code deliberately
> triggering this, a future Rust compiler that enables path inference without
> feature gates, and people using that compiler to build an old LTS/stable kernel.
> 
> On the other hand, the other two (or 1 for recent enough stable versions)
> patches have known broken out-of-tree users. So it's good that they're
> backported as code could have relied on them by accident.

Ok, then we are all set, thanks for the backports.

greg k-h

