Return-Path: <stable+bounces-240455-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPN2AgXx6WkzpQIAu9opvQ
	(envelope-from <stable+bounces-240455-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:14:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E3F4506EB
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84AD7301A413
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E0D3793B6;
	Thu, 23 Apr 2026 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfsSxQ3z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711A373BF4
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938963; cv=none; b=HwtJcYjHiX7RjmZXvHmbNRzYf0yoPtnUuiLNj2uOexJQHyJrTSbLDLX0PiOFd33RGGfHfPzj3H6kNxNJlL6udpkd/x16byDQNnUMYU7ptnqLimqVwfsVVbKGggSOb5Vbkw9Gf4cpubqZV5MKaBoqUI5gsduVfkUWx80sUa3zIGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938963; c=relaxed/simple;
	bh=EiYD+auU7T86T0M9WDiOvQ9Vuoydls3BzM6AwDu+XGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tw4LT4MA20K7pMQN3IqoA1M4IKpxBaQpKgxH3GQvwg/yRIP0GxfNQZADr00E38OyRv+cZ9CrjuyIU8+sPQ9qDWfo9mKhNhbXdtBkvFxjgEhxXxJvAqiRxw/NsI7mFsMGk4j3gwUPtQ4BFd+evQr2n87G+cWLDPymJaMBCWkUmpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfsSxQ3z; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35fb166b0c6so3748924a91.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 03:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776938962; x=1777543762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIyEuNNu5zTG4lMLqGXtVa8tjcYDo3Ze6J4csLjrIb8=;
        b=SfsSxQ3zb+dhvAFi70rFlhngulXqNazUCfQgs69Fr9Ads58sO7aijWTNToH9/Z+7+2
         HQN4/NVlfEU2jU2YzpvztMQsFw/2BP4jGcUazfXUAt7DnZ0430zVaZ/4/xuvegAP1iuO
         /EP3wzbBuOMb6pVe0W1BwJURISgjysAuaXrlO12gGR9wslyLY5zG40lHnZPEqsy3hcui
         LHjDJJBqD9DOcJTntGVoTwz5UtHCYOhi6aVs1uFi7lK+tm1KwIBuS6k0XDALWWXjJn4s
         3TDptUMibKYmKyhDv517Yy3RS5z678JJKek+M4aB5iZYrSd67AGPQWFuIm4Ar4udd9hq
         pCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776938962; x=1777543762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIyEuNNu5zTG4lMLqGXtVa8tjcYDo3Ze6J4csLjrIb8=;
        b=lkPFC4WUoNKgmw53mhY1BtxGk1iEtYmE9IETRnBiRCCUiONu9SWJzX3I44PWK4bjFb
         HVwARXHdFq16oNStdzc5KComoaw+P5uJ1yxSBZfxO5Znm6grVrqSPEgB0imntEhABUID
         VTZpsAknQHC6lZAZ8Ulkz3uQvX+Fg+zDaWQSslX3evb+XIJcudAqtmdjoV8X97gR4efy
         hmfAe07uxB8a0AcvSfslKo5ywrSErLsJ01SbEE7ACYjc9Qb0ZJfbep082nExJ6dT1yCB
         3XhlPy3QH9/+GITj6Ni2YzpeFi/PUVLEJMX7WBekFtoqdxFFJ5cl3RXNIwEwHCvhyeW6
         Qh3w==
X-Forwarded-Encrypted: i=1; AFNElJ+dBygR34+822iPshsXFSkwNnudOpVAyK2Djwvuwpo+5kh/7kzUENkA8yAIBPNVbmvxgVrLcyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2yegpK5FQakDKuYBGHrYDIh/PtpMuxkt2OXdQ/LZOE3Qg0c/o
	B/2+q6R9PhwEJ/TzYMPr+ncg7Bghhfug8N3pUTkWffQH7EmHBk93ObVffCxwMue6
X-Gm-Gg: AeBDies5eu2jBC7c3+XzJhncrem9RyFM5RUbFonbD8PWwwYBthpHe1zW6PtslbFADEG
	e/J9iS5dpBessvPyPZap2C8oZq9jCUGIruNPcx3BNHBBNQbkLQpM3cLgDPLG87xP0OplGPoStOK
	WNOINzsykzRERFkbvEAOijt8/+dgGR41O5vbonu5xBTAFwc6l69D6fZ/4LbyxHhV2wT/ZiNYXKC
	syoIS6vm1BLgap1lqHsDwMBWqcQd7356gYeQ7qyPT5crJPAaza/BLJV7Nq3qX7hhHTTKhhDM6h7
	yzOy0CAKDOyxMtMwEhdySNmBtPQ8+18tK2Uy7ILO/LEYHkF43nxJIZ2OcIL4Dy+7FFfYRyXzIFN
	WdK4ikHxzy1F+aUIKu7fjHGKapik/uAjNGndgjCuri9TqwXr3lcfTThHEG6Ag6jxICz3qfKHnrh
	sMw52GtSMAaj15zE+ZsJOB992lWdos073aOQ==
X-Received: by 2002:a17:90b:3d8e:b0:35f:b9ba:45b4 with SMTP id 98e67ed59e1d1-3613feec4d7mr20584096a91.0.1776938961918;
        Thu, 23 Apr 2026 03:09:21 -0700 (PDT)
Received: from fedora ([2401:4900:1cbc:314:9667:4972:a94c:125a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc5d94sm25275714a91.2.2026.04.23.03.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:09:21 -0700 (PDT)
From: avinash pal <avinashpal441@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	avinash pal <avinashpal441@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH stable 6.12 0/2] iommu/vt-d+dma: fix stale DMA PTE WARN on IOVA reuse (regression v6.12.75)
Date: Thu, 23 Apr 2026 15:39:02 +0530
Message-ID: <20260423100904.5966-1-avinashpal441@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,8bytes.org,kernel.org,arm.com,gmail.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-240455-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashpal441@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76E3F4506EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two-patch series addressing the stale-DMA-PTE WARN_ON regression that
hits kernels 6.12.75 and 6.12.76 when Intel IOMMU is enabled.

  Bugzilla : https://bugzilla.kernel.org/show_bug.cgi?id=221389
  Unaffected: v6.12.74   (confirmed: Giovanni Pancotti, 2026-04-22)
  Affected  : v6.12.76   (WARN on ATA/SCSI DMA workloads)
  Workaround: intel_iommu=off

Root cause
==========
The lazy-flush path in __iommu_dma_unmap_sg() releases an IOVA back to
the allocator via free_iova_fast() before iommu_iotlb_sync() drains the
hardware TLB.  A concurrent map() on the same domain receives the same
IOVA and hits a live PTE in __domain_mapping():

  CPU 0 (unmap, lazy path)        CPU 1 (concurrent map)
  ──────────────────────────      ───────────────────────────────
  iommu_unmap(iova)
  free_iova_fast(iova)  ← live
                                  alloc_iova_fast() → same iova
                                  __domain_mapping()
                                    dma_pte_present() == true
                                    WARN_ON_ONCE()          ← hit

Patches
=======
1/2  iommu/vt-d: fail map loudly on stale DMA PTE
     - Replaces bare WARN(1,...) with pr_err_ratelimited + WARN_ON_ONCE
     - Prints vPFN + old PTE value for debugging
     - Returns -EEXIST; no silent double-map

2/2  iommu/dma: sync IOTLB before releasing IOVA on sg unmap
     - Adds iommu_iotlb_sync() before free_iova_fast() on lazy path
     - Closes the race window; strict-mode path already does this

ACTION NEEDED by reviewer: run
  git log v6.12.74..v6.12.76 -- drivers/iommu/dma-iommu.c
to identify the offending commit for the Fixes: tag in patch 2/2.

avinash pal (2):
  iommu/vt-d: fail map loudly on stale DMA PTE
  iommu/dma: sync IOTLB before releasing IOVA on sg unmap

 drivers/iommu/dma-iommu.c   |  9 +++++++
 drivers/iommu/intel/iommu.c | 50 ++++++++++++++++++++++++++++---------
 2 files changed, 47 insertions(+), 12 deletions(-)


base-commit: 444b39ef6108313e8452010b22aaba588e8fb92b
-- 
2.53.0


