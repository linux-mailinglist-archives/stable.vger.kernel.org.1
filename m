Return-Path: <stable+bounces-259351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHl0DbhCHGq0LwkAu9opvQ
	(envelope-from <stable+bounces-259351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 16:16:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A08C6616A3D
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 16:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D21B301680B
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 14:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DAB32E72F;
	Sun, 31 May 2026 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L1qwrvt1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF162045AD;
	Sun, 31 May 2026 14:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236960; cv=none; b=io2FC+M+xGlKrAFstH1lAVyIRaqgj5qbsXrJN1tOz/V4gywD0IFvQEQqBLVLP41MrsEKNIrg1zR+jQ0/6ir3p6b73AGxDqmzxnUIwm9WpiKHTzlbewLFF05Ue0IvmKxvYFSg8noEXNQaWbIElAGIL1rcv4F5UnGgjghVsaaYXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236960; c=relaxed/simple;
	bh=W726x2lCOV9JBErFR7PyjXJtXS3Z2Xqpxhsa9Cpdzjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SY07jGLDqcTuSTZoa3uD89fL+NiK5T9FabdfiwYL/PeIeveWWA4MLb+T9GHNJIb+DZnIhFc6LAjJSNqbUpd9EbRtYLXX9gvc9FgLoA77697FCBZXd3ylBDHy0+ijARdY/9dP3PD1FMfRB1h5R5MqMHDJ1qbp9NyE+Y6Nfz6CPKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L1qwrvt1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6610C1F00893;
	Sun, 31 May 2026 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780236959;
	bh=U23k70jOkOIRnx4xfbsKF3eYCpD6GuFHR3Ka4h+u5QU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L1qwrvt1byj+XyLFyTBGlXK2Kfbd5te7XD/RAphHVLNMS0Sg9PAMJmPGGMhgfUCQm
	 fTzG3mE15uMgHz+b0EWNueao0GIvE+hpS49rK14vsIPUENEmQ/b0fGaNmZCGvaQ+lj
	 /Frbv4wcPTeOhqCQy6MDDurxVuNULNjv3BOrNCh0=
Date: Sun, 31 May 2026 16:15:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: harshpb@linux.ibm.com, zhaotianrui@loongson.cn, maobibo@loongson.cn,
	chenhuacai@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com,
	sashiko-reviews@lists.linux.dev, seanjc@google.com,
	pbonzini@redhat.com, kvm@vger.kernel.org, stable@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	caixiangfeng@bytedance.com, fangying.tommy@bytedance.com,
	isyanfei.xu@gmail.com
Subject: Re: [v2 0/2] KVM: Validate irqchip index in routing entries
Message-ID: <2026053158-cussed-outweigh-6f0f@gregkh>
References: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531135326.2238555-1-yanfei.xu@bytedance.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259351-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[linux.ibm.com,loongson.cn,kernel.org,gmail.com,lists.linux.dev,google.com,redhat.com,vger.kernel.org,lists.ozlabs.org,bytedance.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A08C6616A3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 09:53:24PM +0800, Yanfei Xu wrote:
> Validate irqchip indexes for LoongArch and PowerPC irq routing entries
> to reject out-of-range values before indexing the irqchip array.
> 
> v1->v2:
> - Split the patch into two by architecture (Sean)
> - Pick up Reviewed-by
> 
> Yanfei Xu (2):
>   KVM: LoongArch: Validate irqchip index in irqfd routing
>   KVM: PPC: Validate irqchip index in MPIC routing
> 
>  arch/loongarch/kvm/irqfd.c | 3 ++-
>  arch/powerpc/kvm/mpic.c    | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> -- 
> 2.20.1
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

