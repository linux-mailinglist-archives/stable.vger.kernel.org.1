Return-Path: <stable+bounces-246833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEAEAkNqBGprIQIAu9opvQ
	(envelope-from <stable+bounces-246833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:10:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 302F3532CC5
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D869430FBC5D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569F038D6AD;
	Wed, 13 May 2026 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bmlgTd1z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085DA3FE641;
	Wed, 13 May 2026 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673951; cv=none; b=rbeHXJLgxLHA4PFa7LTM6kJNJxL/e5zXbYCmo1smZk8DYtz4NQ/6bKVaPXnXFdNFyXN6Fu8EyjLmU93XS6SIFWps61D3JNZ2b+pY4IFZgPAGzcjT36d1OXxEWPuDv6uaE4rlwIfZ/2pmSS1K2A/Ry0T5Kxsf/WFzzVgUGRWq/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673951; c=relaxed/simple;
	bh=1a9Ix2FvJpGGH8eCZfGnN2XAdxXZtKT+5yzua4lqaaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnOQLb8e65c4UUtisIiEJOb3a/lR5ZA+kxQ02pHCam9uws9yMvljlwt1Xe3klEacjntrv7l2HPbMlMCB3ZA7pn1sR/qHpO0mmyiDlia49gFsk/R8b36Ty3uEbIpdDGz794bGTL0rwf23bsMX0vS4AqiJRXVjeC2/13fp2K5L5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bmlgTd1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47172C2BCB7;
	Wed, 13 May 2026 12:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778673950;
	bh=1a9Ix2FvJpGGH8eCZfGnN2XAdxXZtKT+5yzua4lqaaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bmlgTd1zoQBjDiaFx/1lzIsv/b0PJQmyEN6GbVO91Kf3Eh9lQVCCCl9cGJPGt8uaP
	 S5DQaqhQLXAiQr13aRLJrHsr1SybM0lcKBFVpBOQi8cjv81itUhsA6tb+BSnfwFfa1
	 Pbb2ok7z8QKmHyjNK0XLgQI+XMXYlHjqO6hoNwe0=
Date: Wed, 13 May 2026 14:05:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.12 204/206] rust: pin-init: fix incorrect accessor
 reference lifetime
Message-ID: <2026051333-fiction-plug-9076@gregkh>
References: <20260512173937.196814135@linuxfoundation.org>
 <20260512211325.316158-1-ojeda@kernel.org>
 <DIH0S88MYNRZ.2J6YW6S3CONAX@garyguo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIH0S88MYNRZ.2J6YW6S3CONAX@garyguo.net>
X-Rspamd-Queue-Id: 302F3532CC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246833-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.966];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 10:35:33PM +0100, Gary Guo wrote:
> On Tue May 12, 2026 at 10:13 PM BST, Miguel Ojeda wrote:
> > On Tue, 12 May 2026 19:40:56 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >>
> >> 6.12-stable review patch.  If anyone has any objections, please let me know.
> >>
> >> ------------------
> >>
> >> From: Gary Guo <gary@garyguo.net>
> >>
> >> commit 68bf102226cf2199dc609b67c1e847cad4de4b57 upstream
> >>
> >> When a field has been initialized, `init!`/`pin_init!` create a reference
> >> or pinned reference to the field so it can be accessed later during the
> >> initialization of other fields. However, the reference it created is
> >> incorrectly `&'static` rather than just the scope of the initializer.
> >>
> >> This means that you can do
> >>
> >>     init!(Foo {
> >>         a: 1,
> >>         _: {
> >>             let b: &'static u32 = a;
> >>         }
> >>     })
> >>
> >> which is unsound.
> >>
> >> This is caused by `&mut (*$slot).$ident`, which actually allows arbitrary
> >> lifetime, so this is effectively `'static`.
> >>
> >> Fix it by adding `let_binding` method on `DropGuard` to shorten lifetime.
> >> This results in exactly what we want for these accessors. The safety and
> >> invariant comments of `DropGuard` have been reworked; instead of reasoning
> >> about what caller can do with the guard, express it in a way that the
> >> ownership is transferred to the guard and `forget` takes it back, so the
> >> unsafe operations within the `DropGuard` can be more easily justified.
> >>
> >> Assisted-by: Claude:claude-3-opus
> >> Signed-off-by: Gary Guo <gary@garyguo.net>
> >> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > I am seeing a few Clippy warnings:
> >
> >     warning: value assigned to `inner` is never read
> >         --> rust/kernel/init/macros.rs:1234:18
> >          |
> >     1234 |           unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), init)? };
> >          |  __________________^
> >     ...    |
> >     1260 | |             let $field = unsafe { $data.[< __project_ $field >]([< __ $field _guard >].let_binding()) };
> >          | |_____________________________________________________________________________________________________^
> >          |
> >         ::: rust/kernel/block/mq/tag_set.rs:62:9
> >          |
> >       62 | /         try_pin_init!(TagSet {
> >       63 | |             inner <- PinInit::<_, error::Error>::pin_chain(Opaque::new(tag_set?), |tag_set| {
> >       64 | |                 // SAFETY: we do not move out of `tag_set`.
> >       65 | |                 let tag_set = unsafe { Pin::get_unchecked_mut(tag_set) };
> >     ...    |
> >       69 | |             _p: PhantomData,
> >       70 | |         })
> >          | |__________- in this macro invocation
> >          |
> >          = help: maybe it is overwritten before being read?
> >          = note: `#[warn(unused_assignments)]` (part of `#[warn(unused)]`) on by default
> >          = note: this warning originates in the macro `$crate::__init_internal` which comes from the expansion of the macro `try_pin_init` (in Nightly builds, run with -Z macro-backtrace for more info)
> 
> I didn't hit this during local testing. Just figured out that this warning is
> appearing on Rust 1.82 but not Rust 1.85, as I have updated my environment when
> the MSRV is bumped. So it looks like this is a false positive that was already
> fixed, but we still need to workaround this for stable kernels.
> 
> (It is also puzzling because there weren't any extra assignments to the
> variable).
> 
> >
> > It seems the backport dropped the `allow`s for `unused_assignments`:
> >
> >> -        #[allow(unused_variables, unused_assignments)]
> 
> The dropped allows are for `let _ = ` which shouldn't need them.
> 
> The newly added `let $field` did only have `#[allow(unused_variables)]`.
> Changing them to `unused_assignments` fixd them.
> 
> The diff is below which is quite trivial. Greg, is this something that you
> could fix up or do you want to re-send a new version?

I will drop this one, can you send a new one for the next round of
releases?

thanks,

greg k-h

