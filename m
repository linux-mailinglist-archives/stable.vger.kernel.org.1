Return-Path: <stable+bounces-246916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJojKDmeBGr3LwIAu9opvQ
	(envelope-from <stable+bounces-246916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:52:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1232A536863
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0A1A3056693
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F19F4A13BA;
	Wed, 13 May 2026 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yprRugyj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4717429800;
	Wed, 13 May 2026 15:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686175; cv=none; b=tdopI2yIWzh7hzeuyKpF3q0uu+aJ4tWHhlQSQLjpvYv7TQH/fjg9/u/oH0T4WjsbCiqvOzIgcIlWWqizsx8VbRPJfV2mV4nkGlrebUpuBFct1eW3hxU0TJAD40NLkIxPW60aci+a246aY2v6r/PpFlaLEMD0JqO8dwkm/c9fpD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686175; c=relaxed/simple;
	bh=+GTyIVYo4BpoFl3JfjZgmVQ0TxTdr6v5vKx444qp0oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDMeAIXrjtu9mad8DCQ71HFs5d/eUh5zMolY0cby2QDGZKz2LfHkwDeDLbWclMpl9I65zirGw7hEm+8JE3sEmtoErLTFJxp41P4FI++6HxzrLiBOtyvMER11SCP/dK64RO5IShNAw9FEexqNEwqEKDnwj+kJUaWp9pjwnO+RbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yprRugyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F1AC2BCB3;
	Wed, 13 May 2026 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778686175;
	bh=+GTyIVYo4BpoFl3JfjZgmVQ0TxTdr6v5vKx444qp0oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yprRugyjWyD7Np2aCMHVnxx9Ro+o2+2DV1/A2AIMWWTO7j3s21pMJWt4r9XOu5Jts
	 L8dvn5iP4JIPl3D/8vSUxJ2Co0RKTdjmRXrfXd9u/PhbfpfYI9SHkqCvKeKBW7TYOK
	 wFODeG+QWl5jL9gYeXq5cLANetTgr2Ntwa684lt0=
Date: Wed, 13 May 2026 17:29:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: chenhuacai@kernel.org, chenhuacai@loongson.cn,
	dave.hansen@linux.intel.com, kvm@vger.kernel.org,
	lixianglai@loongson.cn, loongarch@lists.linux.dev,
	maobibo@loongson.cn, ojeda@kernel.org, patches@lists.linux.dev,
	seanjc@google.com, stable@vger.kernel.org, zhaotianrui@loongson.cn
Subject: Re: Re: [PATCH 6.18 091/270] LoongArch: KVM: Compile switch.S
 directly into the kernel
Message-ID: <2026051357-unmasked-economic-2a46@gregkh>
References: <2026051311-lullaby-wrecker-7d23@gregkh>
 <20260513120808.339792-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513120808.339792-1-guanwentao@uniontech.com>
X-Rspamd-Queue-Id: 1232A536863
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246916-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marc.info:url,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 08:08:08PM +0800, Wentao Guan wrote:
> > On Wed, May 13, 2026 at 07:58:10PM +0800, Wentao Guan wrote:
> > > Hello,
> > > 
> > > > On Wed, May 13, 2026 at 11:06:20AM +0800, Huacai Chen wrote:
> > > > > On Wed, May 13, 2026 at 5:53 AM Sean Christopherson <seanjc@google.com> wrote:
> > > > > >
> > > > > > On Tue, May 12, 2026, Miguel Ojeda wrote:
> > > > > > > On Tue, 12 May 2026 19:38:12 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > 6.18-stable review patch.  If anyone has any objections, please let me know.
> > > > > > > >
> > > > > > > > ------------------
> > > > > > > >
> > > > > > > > From: Xianglai Li <lixianglai@loongson.cn>
> > > > > > > >
> > > > > > > > commit 5203012fa6045aac4b69d4e7c212e16dcf38ef10 upstream.
> > > > > > > >
> > > > > > > > If we directly compile the switch.S file into the kernel, the address of
> > > > > > > > the kvm_exc_entry function will definitely be within the DMW memory area.
> > > > > > > > Therefore, we will no longer need to perform a copy relocation of the
> > > > > > > > kvm_exc_entry.
> > > > > > > >
> > > > > > > > So this patch compiles switch.S directly into the kernel, and then remove
> > > > > > > > the copy relocation execution logic for the kvm_exc_entry function.
> > > > > > > >
> > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> > > > > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > >
> > > > > > > For loongarch64, I am seeing a bunch of errors like:
> > > > > > >
> > > > > > >     arch/loongarch/kvm/switch.S:201:1: error: unrecognized instruction mnemonic
> > > > > > >     EXPORT_SYMBOL_FOR_KVM(kvm_exc_entry)
> > > > > > >     ^
> > > > > > >
> > > > > > > `EXPORT_SYMBOL_FOR_KVM` does not exist in 6.18. Does this need a subset
> > > > > > > of commit 6276c67f2bc4 ("x86: Restrict KVM-induced symbol exports to KVM
> > > > > > > modules where obvious/possible")?
> > > > > >
> > > > > > Either that or just convert EXPORT_SYMBOL_FOR_KVM() => EXPORT_SYMBOL_GPL().  If
> > > > > > that's somewhat scriptable for ongoing LTS backports, that's probably the best
> > > > > > option.  EXPORT_SYMBOL_FOR_KVM() will only work for 6.18, and the list of backports
> > > > > > needed to get EXPORT_SYMBOL_FOR_MODULES() working on older LTS kernels looks to
> > > > > > be non-trivial
> > > > > >
> > > > > > If we do end up backporting EXPORT_SYMBOL_FOR_KVM() and others, we might as well
> > > > > > also grab a subset of 01122b89361e ("perf: Use EXPORT_SYMBOL_FOR_KVM() for the
> > > > > > mediated APIs") to ensure a kvm_types.h stub is present on all archs.  That way
> > > > > > EXPORT_SYMBOL_FOR_KVM() usage in arch-neutral code will also work.
> > > > > I have already noticed Greg about this before.
> > > > 
> > > > You did?  Where?
> > > 
> > > Small problem, I guess where he means is 'stable-commits@vger.kernel.org', is a
> > > not public maillist? I want to find it in 'lore.kernel.org' but not found... 
> > 
> > It's a public list, anyone can sign up for it.  Don't know if lore
> > archives it, but I'm sure that someone does...
> 
> Thanks for your reply. It is interesting that now i found them in
> https://marc.info/?l=linux-stable-commits&m=177859589029820&w=2,
> and https://marc.info/?l=linux-stable-commits&m=177859840800303

Ah, yeah, I had to delete that message due to that footer, and didn't
even look at it on request of the sender as it was confidental
information which is not allowed here.

thanks,

greg k-h

