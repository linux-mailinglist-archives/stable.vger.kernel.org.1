Return-Path: <stable+bounces-240460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG+wNGD+6WkHrAIAu9opvQ
	(envelope-from <stable+bounces-240460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:11:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B584511E5
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F086C301BF40
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6450A20B810;
	Thu, 23 Apr 2026 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s6fkDAgN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54E37DE80;
	Thu, 23 Apr 2026 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942615; cv=none; b=hyNyruZ18WIy8k5ADMr8Gm4mcwDa/bTQdgIujRKuAYlATE3t7SHhm/ox+q1zwojkghgVBgljlpvGjMLMfcyRWWbhTdWZ+qYlALrhKh9VwCCqrrQlwcM6NRbey5VpO/IxIFqsx+Gx+PUrrzoIhJU6UUDcIZ71Y/oiLvzebxpFyck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942615; c=relaxed/simple;
	bh=O4/ish6+FBd5fdl85dueKnWZBgyFuHDLNZl0cPlNsDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEuFYWhe9Kv/zxUB0R+BLv/PaW48c/acqqM0wzQ7/ffZr6i08KF45ULk1A0Qin0AHbg+9sIsoetD7dX0Mxw04R6lwzG0fD+6q4K4jzMaLP9u4R9mv+uBoTdt+wUNIBdQ7/vtBU/jIdXE5kxKJtBo5UBpn4xHmfyY6Ui9AiEvx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s6fkDAgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D91EC2BCB2;
	Thu, 23 Apr 2026 11:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776942614;
	bh=O4/ish6+FBd5fdl85dueKnWZBgyFuHDLNZl0cPlNsDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6fkDAgNqnIPMPzIVkJA88zwRPaQAmPexq5klUAdMfIlBMkOHQPCoduLwAIvP9B6L
	 F2QkWwHK4532RmdD7vQmqxJGy40ZFaxpECeayu2cNodCPwMnRpJcUKI4hLWreJRoq7
	 U0tSMjeEtzjICcbROw1BU5bWWaHMuTXBxpu/91+M=
Date: Thu, 23 Apr 2026 13:10:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: avinash pal <avinashpal441@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH stable 6.12 0/2] iommu/vt-d+dma: fix stale DMA PTE WARN
 on IOVA reuse (regression v6.12.75)
Message-ID: <2026042303-untreated-lubricate-646b@gregkh>
References: <20260423100904.5966-1-avinashpal441@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423100904.5966-1-avinashpal441@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240460-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38B584511E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 03:39:02PM +0530, avinash pal wrote:
> Two-patch series addressing the stale-DMA-PTE WARN_ON regression that
> hits kernels 6.12.75 and 6.12.76 when Intel IOMMU is enabled.
> 
>   Bugzilla : https://bugzilla.kernel.org/show_bug.cgi?id=221389
>   Unaffected: v6.12.74   (confirmed: Giovanni Pancotti, 2026-04-22)
>   Affected  : v6.12.76   (WARN on ATA/SCSI DMA workloads)
>   Workaround: intel_iommu=off
> 
> Root cause
> ==========
> The lazy-flush path in __iommu_dma_unmap_sg() releases an IOVA back to
> the allocator via free_iova_fast() before iommu_iotlb_sync() drains the
> hardware TLB.  A concurrent map() on the same domain receives the same
> IOVA and hits a live PTE in __domain_mapping():
> 
>   CPU 0 (unmap, lazy path)        CPU 1 (concurrent map)
>   ──────────────────────────      ───────────────────────────────
>   iommu_unmap(iova)
>   free_iova_fast(iova)  ← live
>                                   alloc_iova_fast() → same iova
>                                   __domain_mapping()
>                                     dma_pte_present() == true
>                                     WARN_ON_ONCE()          ← hit
> 
> Patches
> =======
> 1/2  iommu/vt-d: fail map loudly on stale DMA PTE
>      - Replaces bare WARN(1,...) with pr_err_ratelimited + WARN_ON_ONCE
>      - Prints vPFN + old PTE value for debugging
>      - Returns -EEXIST; no silent double-map
> 
> 2/2  iommu/dma: sync IOTLB before releasing IOVA on sg unmap
>      - Adds iommu_iotlb_sync() before free_iova_fast() on lazy path
>      - Closes the race window; strict-mode path already does this
> 
> ACTION NEEDED by reviewer: run
>   git log v6.12.74..v6.12.76 -- drivers/iommu/dma-iommu.c
> to identify the offending commit for the Fixes: tag in patch 2/2.
> 
> avinash pal (2):
>   iommu/vt-d: fail map loudly on stale DMA PTE
>   iommu/dma: sync IOTLB before releasing IOVA on sg unmap
> 
>  drivers/iommu/dma-iommu.c   |  9 +++++++
>  drivers/iommu/intel/iommu.c | 50 ++++++++++++++++++++++++++++---------
>  2 files changed, 47 insertions(+), 12 deletions(-)
> 
> 
> base-commit: 444b39ef6108313e8452010b22aaba588e8fb92b
> -- 
> 2.53.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

