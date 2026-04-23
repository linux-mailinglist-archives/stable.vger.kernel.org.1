Return-Path: <stable+bounces-240456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHTJNTLx6WkzpQIAu9opvQ
	(envelope-from <stable+bounces-240456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:15:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDEA450708
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C17A230826CA
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C693379980;
	Thu, 23 Apr 2026 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juohZ7uP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0413C377556
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776938979; cv=none; b=a4ZSqrpfF/Y9EiRWrHDCDspq4lIY5VhQrmkxEWYgczrx0pw7WEHg80MUzTfKvkY/oY2aghoQmaPBZo3xIfpFgzQMHQgP+ZLF9q8ih1ka4o70tAV//JpAc6OtYuLpKIBaRy747M1BoW+3z8Jvif1YTrDWLhJojipGyYZezvF8iRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776938979; c=relaxed/simple;
	bh=UTlbVQte9MXWRTLRKgI2LMgHRO0jaYQooyHaYcX98aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H85sW/1rVUEZlf5Xl3EUqSdOag8yqTNeONmHlKHKwi3++SJva3Oelb48NLYIKBv3fZf5zm7u78r+KZnZ7X1qDjJsjycEEMcRlGITIOnoJFeFcdTWeZT/UDp2td/DyOjCNNZ31MvfWzOlskoj3sZpF5MRCdiyjI/r06qwrgLTHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juohZ7uP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35e576110adso4406413a91.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 03:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776938977; x=1777543777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hw3+dt4upvwPZbcilhyfG5LgQIqATsWm5ea0NmPrr4=;
        b=juohZ7uP31L4eLYx2MIWQQo2PZjSza5N3Mu6X7d0r5Br4kpMrF5nMo+ATaiZloSw0O
         rrij3dT6pZg/QV8USUVwVjrm09qL1qNxrzAiEu8RVk5vlzVtjR5X8137uTTWIRrRmqzA
         XOgSCJqQVmhTCUFjBEjqmworhx+HZ/pzTh0FTdkx/4VkLa5sgj6z8QISAwNxAzmYvr5w
         aiC+swWNcbtf/NAAwJiPl9dd9T6Qbe5HYLdAL/ms0f4M4WTCWteK+JGUJZACClvw08ka
         DDyx7y1vL//i9lCjOzxVKe8dejt+g3PJUiuuJtAQP962bjam0tmjtHRM4krKlLG8/Pbf
         XKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776938977; x=1777543777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hw3+dt4upvwPZbcilhyfG5LgQIqATsWm5ea0NmPrr4=;
        b=MqNiwgyxXU8LrIi/KZeRbSwaVxjtXOP4b8w9K9j9MkMAIvPualeMwLYBGCw4cwTbvi
         9HyZrATENYAr4WcLEn92WgcBsP4x6Flv8HCNTBDhHqBOY5ke0MPpsAuW4TMZ+OdqF+sE
         os8M9xhxO4gf9YCZCW/YvdpgIExHTRKwtqmXS+7Gx7dl+gC9oE5hc+D+lWXeFekMyBGm
         D7ZpTC2+JNSxEcHYvvRCEpE26rQ/WIvwMvZe+6J8VtecwLjI55m+/vh6p1NhLg5BmfIx
         dND0FQdJ5SUxSqQqyFvTLIuBDoAH/hjpt981RUxRz26DJ6sEWDRM1SQ8pHUdrGaCX3BI
         aVrg==
X-Forwarded-Encrypted: i=1; AFNElJ+kBowOYXVyi+f1BwM6XRmjv2wK/E9YM5PT9FNcWoH/qAl8bjMTZOC7x11bI+x+TzPl4siJnJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUy6cNOUd6HouhMEGR2gdqnZnvji75P1mVnfaGuyvLftAeGLor
	37PZX4+lo/+IjoGBV1zWCHUtaYQ3oH7EiFUwLis/aQQgGtxCnJ3ZpJ24
X-Gm-Gg: AeBDietVQxa5l2Ny5sJmz0QTBSstnY8cU/U1V+ZrJssaXoZIL8nFmfuOk0DFB+gvoDd
	2nk4mJdZ4FSOBSGFWl3gBf/4o9tOw9Vu4LIy1yETFbLrqZ7fI0817ZyQuPFTYL9lsS4kRlMb3UG
	kbEYPAru3ZwERc4M9bcpxdaTNCzQqYrevItA8SMGKHo+U1NusaoA4LXLn2q+B8gA2QSWOcWmnsd
	saiMkPGkkdXG8LPuWu/NhMehpkbIvhpshSS0rsrJz0N4Q1KkJnpZ9wbrzOOJiC9IN5uOjv2SSa1
	05J8I8FWo2aBRvXdhgJaWR9iCHsfDP6TuXK0rYWMsyRDQNtbVDdfAz1hORvJUsqgrCmbTs00fcD
	aI8MbEMpqdVp+Bbw4mdSv31GKv+D2Qo/d4agqGJETRHhjfJV0rQNyV9r20pfejzpjbFsqonvJFo
	4AFtcJXH+dhSY5WLX0ZzioOiPVo98lt1DafQ==
X-Received: by 2002:a17:90b:4b83:b0:356:21e9:73ff with SMTP id 98e67ed59e1d1-361402ebfebmr20950907a91.11.1776938977213;
        Thu, 23 Apr 2026 03:09:37 -0700 (PDT)
Received: from fedora ([2401:4900:1cbc:314:9667:4972:a94c:125a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc5d94sm25275714a91.2.2026.04.23.03.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:09:36 -0700 (PDT)
From: avinash pal <avinashpal441@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	avinash pal <avinashpal441@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Giovanni Pancotti <giovanni.pancotti@example.com>
Subject: [PATCH stable 6.12 1/2] iommu/vt-d: fail map loudly on stale DMA PTE
Date: Thu, 23 Apr 2026 15:39:03 +0530
Message-ID: <20260423100904.5966-2-avinashpal441@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423100904.5966-1-avinashpal441@gmail.com>
References: <20260423100904.5966-1-avinashpal441@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,8bytes.org,kernel.org,arm.com,gmail.com,lists.linux.dev,vger.kernel.org,example.com];
	TAGGED_FROM(0.00)[bounces-240456-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashpal441@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CDEA450708
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In __domain_mapping(), when dma_pte_present(pte) is true the existing
WARN continues execution, leaving the domain in an inconsistent state:
a new PTE is silently installed on top of a live one.

Replace it with:
  - pr_err_ratelimited: prints conflicting vPFN + old PTE value
  - WARN_ON_ONCE: one-shot kernel warning with stack trace
  - return -EEXIST: abort the bad map; no silent corruption

The root cause is in the unmap path — see the companion dma-iommu.c fix.

Reported-by: Giovanni Pancotti <giovanni.pancotti@example.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221389
Cc: stable@vger.kernel.org
Signed-off-by: avinash pal <avinashpal441@gmail.com>
---
 drivers/iommu/intel/iommu.c | 50 ++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c799cc67d..4a8937b44 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1777,14 +1777,25 @@ static void switch_to_super_page(struct dmar_domain *domain,
 			pte = pfn_to_dma_pte(domain, start_pfn, &level,
 					     GFP_ATOMIC);
 
-		if (dma_pte_present(pte)) {
-			dma_pte_free_pagetable(domain, start_pfn,
-					       start_pfn + lvl_pages - 1,
-					       level + 1);
-
-			cache_tag_flush_range(domain, start_pfn << VTD_PAGE_SHIFT,
-					      end_pfn << VTD_PAGE_SHIFT, 0);
-		}
+    		if (dma_pte_present(pte)) {
+    			/*
+    			 * A live DMA PTE is already installed at this vPFN.
+    			 * This violates the map/unmap contract: an IOVA must be
+    			 * fully unmapped and the IOTLB drained before reuse.
+    			 *
+    			 * Root cause: missing iommu_iotlb_sync() before
+    			 * free_iova_fast() in __iommu_dma_unmap_sg() on the
+    			 * lazy-flush path.  The companion patch in dma-iommu.c
+    			 * fixes that; this guard makes the violation explicit.
+    			 */
+    			pr_err_ratelimited(
+    				"DMAR: stale PTE at vPFN 0x%lx (val=0x%016llx) "
+    				"-- IOVA reused before IOTLB drain
+",
+    				iov_pfn, (unsigned long long)pte->val);
+    			WARN_ON_ONCE(1);
+    			return -EEXIST;
+    		}
 
 		pte++;
 		start_pfn += lvl_pages;
@@ -3663,10 +3674,25 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
 		struct dma_pte *pte;
 
 		pte = dmar_domain->pgd;
-		if (dma_pte_present(pte)) {
-			dmar_domain->pgd = phys_to_virt(dma_pte_addr(pte));
-			iommu_free_page(pte);
-		}
+    		if (dma_pte_present(pte)) {
+    			/*
+    			 * A live DMA PTE is already installed at this vPFN.
+    			 * This violates the map/unmap contract: an IOVA must be
+    			 * fully unmapped and the IOTLB drained before reuse.
+    			 *
+    			 * Root cause: missing iommu_iotlb_sync() before
+    			 * free_iova_fast() in __iommu_dma_unmap_sg() on the
+    			 * lazy-flush path.  The companion patch in dma-iommu.c
+    			 * fixes that; this guard makes the violation explicit.
+    			 */
+    			pr_err_ratelimited(
+    				"DMAR: stale PTE at vPFN 0x%lx (val=0x%016llx) "
+    				"-- IOVA reused before IOTLB drain
+",
+    				iov_pfn, (unsigned long long)pte->val);
+    			WARN_ON_ONCE(1);
+    			return -EEXIST;
+    		}
 		dmar_domain->agaw--;
 	}
 
-- 
2.53.0


