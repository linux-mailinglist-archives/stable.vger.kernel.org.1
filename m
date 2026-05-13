Return-Path: <stable+bounces-246800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDrJNDZUBGp/HAIAu9opvQ
	(envelope-from <stable+bounces-246800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:36:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCC7531663
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EFEB305FE50
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2363FADFE;
	Wed, 13 May 2026 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KnLRslPE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061A3E5EE2;
	Wed, 13 May 2026 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668533; cv=none; b=B4a+2bS/2qYlrH/73UToTGzZxdZvpRmtpHiMuT2i1AcgbhBXKGGm17b+jwP4EqYrQDWaLSyizdpAko7LouG7AI8LBSFjfQlWipZVkmcftZ8osj/mBb+vzaHxdgSgycnWpgX1f4zL7IOcIXD5I0Aypx1P+/aBOZqw6zQKVHEXhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668533; c=relaxed/simple;
	bh=gwplUYjPZasu1UlzqLUjVpQM6LOJwrACVqgiZTgSq0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYkx0G+sgkRZDoScx9zdyRhbh4IDE1FLAM9xjZ47ca5pOfPi4M0aveH5/X3f6wUyExzgl4RB3kJkKqrjBP96RiZVQ7K4EJnfpFnwZ61gJTQwE3i2Rmo7kG6zL3NC9cfYvHYBvFrR6WLR7ScakUZW9kEcnSZZcc993VbubEGuvgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KnLRslPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223EBC2BCB7;
	Wed, 13 May 2026 10:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778668533;
	bh=gwplUYjPZasu1UlzqLUjVpQM6LOJwrACVqgiZTgSq0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnLRslPEg+o6OUZjunK17Yaa95l4m4vNNIizVW9LjIl6xQJkgql4KvBEq13vgnE7p
	 HYeF+zwt5O7fH7neUFA45pa+Fme2uAbESptFZIZ8oEdErskhiXOaOdi6ni8Gkmhdb4
	 owpb2LTgPiD2omlqOinWZNg7pn/wtkNObWfn75fw=
Date: Wed, 13 May 2026 12:31:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>, kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	Dave Hansen <dave.hansen@linux.intel.com>, chenhuacai@loongson.cn,
	lixianglai@loongson.cn, patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.18 091/270] LoongArch: KVM: Compile switch.S directly
 into the kernel
Message-ID: <2026051319-lazily-machine-5ab3@gregkh>
References: <20260512173940.376401154@linuxfoundation.org>
 <20260512205250.313933-1-ojeda@kernel.org>
 <agOhSMXZGSv0bPhX@google.com>
 <CAAhV-H6GFmKrJpVgaShCzUigZByvQkXQy_2qGcyaJ089Q6chWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6GFmKrJpVgaShCzUigZByvQkXQy_2qGcyaJ089Q6chWg@mail.gmail.com>
X-Rspamd-Queue-Id: 9CCC7531663
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246800-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 11:06:20AM +0800, Huacai Chen wrote:
> On Wed, May 13, 2026 at 5:53 AM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Tue, May 12, 2026, Miguel Ojeda wrote:
> > > On Tue, 12 May 2026 19:38:12 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > 6.18-stable review patch.  If anyone has any objections, please let me know.
> > > >
> > > > ------------------
> > > >
> > > > From: Xianglai Li <lixianglai@loongson.cn>
> > > >
> > > > commit 5203012fa6045aac4b69d4e7c212e16dcf38ef10 upstream.
> > > >
> > > > If we directly compile the switch.S file into the kernel, the address of
> > > > the kvm_exc_entry function will definitely be within the DMW memory area.
> > > > Therefore, we will no longer need to perform a copy relocation of the
> > > > kvm_exc_entry.
> > > >
> > > > So this patch compiles switch.S directly into the kernel, and then remove
> > > > the copy relocation execution logic for the kvm_exc_entry function.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > For loongarch64, I am seeing a bunch of errors like:
> > >
> > >     arch/loongarch/kvm/switch.S:201:1: error: unrecognized instruction mnemonic
> > >     EXPORT_SYMBOL_FOR_KVM(kvm_exc_entry)
> > >     ^
> > >
> > > `EXPORT_SYMBOL_FOR_KVM` does not exist in 6.18. Does this need a subset
> > > of commit 6276c67f2bc4 ("x86: Restrict KVM-induced symbol exports to KVM
> > > modules where obvious/possible")?
> >
> > Either that or just convert EXPORT_SYMBOL_FOR_KVM() => EXPORT_SYMBOL_GPL().  If
> > that's somewhat scriptable for ongoing LTS backports, that's probably the best
> > option.  EXPORT_SYMBOL_FOR_KVM() will only work for 6.18, and the list of backports
> > needed to get EXPORT_SYMBOL_FOR_MODULES() working on older LTS kernels looks to
> > be non-trivial
> >
> > If we do end up backporting EXPORT_SYMBOL_FOR_KVM() and others, we might as well
> > also grab a subset of 01122b89361e ("perf: Use EXPORT_SYMBOL_FOR_KVM() for the
> > mediated APIs") to ensure a kvm_types.h stub is present on all archs.  That way
> > EXPORT_SYMBOL_FOR_KVM() usage in arch-neutral code will also work.
> I have already noticed Greg about this before.

You did?  Where?

> And I think the best solution is to use EXPORT_SYMBOL_GPL().
> 
> If Greg doesn't want to adjust manually, please drop this patch and I
> will send one.

I'll go drop this one from the queue.

thanks,

greg k-h

