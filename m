Return-Path: <stable+bounces-232903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEO0BkTnzWmuiwYAu9opvQ
	(envelope-from <stable+bounces-232903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:49:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 826AF3833FA
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 05:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67A493020E96
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 03:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30942FFF8F;
	Thu,  2 Apr 2026 03:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1pXJM0xf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6124286D60
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 03:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775101760; cv=none; b=sGNx4faVNdyyk+mSK8VZAWWZPt1m2wwsPFg/zy7FPIYm2nki+C8jFOqcuj13OY0x5wsGPczskL3GmDDdnBZ9k5m0VJqCumZ0DyYTqfY28+MImtbYgfkKswwK2Gp/05nBpOa75RGYQnSvMWM/8Tq8aOPrE2a/YLymr+PZEgoAiDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775101760; c=relaxed/simple;
	bh=VDnWPcoBIlQIIRSgUcq27iSNIl8mCGAJPwcz7A0FH/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSgbWxp6QCNB9HKlnBfIvHm+VoWMnbHAN9TOp3tOZRSlfA4PH5+ojO46FYw9MFSEX9oB0Radeh587kmGEPSdoRuqPVCaSHcNP9+x98FHdQKhQKkObqYYEm6zle5RwgXMfws91bgdqVXIRRWrFNMXt55Td1b4ywbt4wu/oXDCgSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1pXJM0xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F64C19423;
	Thu,  2 Apr 2026 03:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775101760;
	bh=VDnWPcoBIlQIIRSgUcq27iSNIl8mCGAJPwcz7A0FH/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1pXJM0xfhgVgvuLFX4UgtT9S59hWW2n76eplYn8aON9cJNHJvN3FBOjinxOWANMfF
	 FRawI1GgwsAmNRd+2Goiij3rXihuZazGHePJ00y5HeEnlMoH+5Epvx/5YpygkOgtLi
	 Y2dfFZ28FV/vxTpxnlH9wsesT9ZUh46Nshlj09Ys=
Date: Thu, 2 Apr 2026 05:49:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sean Christopherson <seanjc@google.com>
Cc: bkov@amazon.com, fgriffo@amazon.co.uk, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] KVM: x86/mmu: Drop/zap existing present
 SPTE even when" failed to apply to 5.10-stable tree
Message-ID: <2026040202-confusion-deepness-720f@gregkh>
References: <2026033039-occupy-slush-db02@gregkh>
 <ac2NRUTLk-yX13va@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac2NRUTLk-yX13va@google.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232903-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 826AF3833FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 02:25:25PM -0700, Sean Christopherson wrote:
> On Mon, Mar 30, 2026, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.10-stable tree.
> 
> ...
> 
> > Fixes: a54aa15c6bda3 ("KVM: x86/mmu: Handle MMIO SPTEs directly in mmu_set_spte()")
> > Cc: stable@vger.kernel.org
> 
> Partially out of curiosity, partially to reduce the probability of future goofs,
> why did the tooling try to apply a patch to a kernel without the Fixes commit?
> 5.10 doesn't have a54aa15c6bda3 and so doesn't need this fix.
> 
> I assumed that having an explicit Fixes would implicit scope the backport to
> kernels with that commit (or a backport of that commit).

Yeah, my fault, I still "manually" read that, and my script properly
spit out:

	Commit id aad885e774966e97b675dfe928da164214a71605
		queued in:	queue-6.19/kvm-x86-mmu-drop-zap-existing-present-spte-even-when-creating-an-mmio-spte.patch
		queued in:	queue-6.18/kvm-x86-mmu-drop-zap-existing-present-spte-even-when-creating-an-mmio-spte.patch
		queued in:	queue-6.12/kvm-x86-mmu-drop-zap-existing-present-spte-even-when-creating-an-mmio-spte.patch
		queued in:	queue-6.6/kvm-x86-mmu-drop-zap-existing-present-spte-even-when-creating-an-mmio-spte.patch
		fixed in:	5.13
	> ○ 6.19
	  ○ 6.18
	  ○ 6.12
	  ○ 6.6
	  ○ 6.1
	  ○ 5.15
	  ○ 5.10

But I guess I seleced "5.10" accidentally as well.

Sorry about that, my fault, one of these days I'll make the script a bit
smarter to "pre-populate" the checkboxes with what it thinks should be
happening here, and not require me to actually read values :)

thanks,

greg k-h

