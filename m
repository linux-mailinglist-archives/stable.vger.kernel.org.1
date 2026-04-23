Return-Path: <stable+bounces-240457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHqZMRry6WmepQIAu9opvQ
	(envelope-from <stable+bounces-240457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:19:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AE0450856
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 12:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E1EC3013A5D
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D618237AA88;
	Thu, 23 Apr 2026 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmcAkOdf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8437B02D
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939256; cv=none; b=Hb6zUCdayUU073ZMW4PCHdCL16ZygCF58lf3Oe4CPh/DjWpvA5hk8YUMz9J4ET64RQqPLACCvAJjTENQbvcAIOU7tRm+Dk/lVJOAKogWFH829q+x3cL+Whe/WnSlqjzc5R1A9qk8e6b0ZkZrOJEOe24Pv5EAmjTZHRwxFwc/fPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939256; c=relaxed/simple;
	bh=bfflzEHdpLESHwzPVr7kcu++Rfuj6zUYLaa4J7zWLPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwPt+0jNhfpfm+V4In98QxL1GB/V4vahVKchCdc2/0eepvWmNI/gFyP1QEzOrhavzIO0t72Gq7EHxoo7SJ00mkPioPeBhCh1X+bhVyOcrcYgP+jFACxwmbdLkjtlyUTDX5nNqzQRRgR0k2x6UIcnUClANoivv7iJ3IkhrHqMa7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmcAkOdf; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c795f096fa5so2595568a12.3
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776939254; x=1777544054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D105fItJZxsqyXtCtVn6aQ3UIkkHqVrtT7Vq4lq6K4g=;
        b=mmcAkOdfAILC0KYFpuH/oHKxF8UBpCQC5d75oANoeRSziiUMzMbiPkqiSEb95zGoLl
         bAJJXjtMlulUh5DYxpUymeXGNj8XeWbwbHu4drad8zLwFyVu9CUh3qv6aMVYoY47ZTfm
         lWpRbESERoyVIA41knIuRQQP/w0L+wnBtJxEjHnWrGJ4hzuIYIvzg+YM+DH/fhABZ56G
         B6wAub5wPrx7MkwSy9LAEXmEGEpmnHz3k+Oe1/wlfRrrkEHykB8t9/72dV3MfP3NWBiM
         nbwINtmp1+sF8V3277jQM1PQz8sXCNhyNWY6HGnfiAiAyvprO0u2TuJxKL7thHHbkSQt
         cJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776939254; x=1777544054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D105fItJZxsqyXtCtVn6aQ3UIkkHqVrtT7Vq4lq6K4g=;
        b=dFZY1TKMDmDINF4yg2Lx/tKFjXya4FyWoAQJoCwKGGzioMgttGf0IZQTNT/25NrMiM
         biMB/Wc/KDQv8XFUtvg9fcohBgBwauQXbREnb+2SelPp1ZNuX9sI3BvVXtubPvKfexHy
         Eool5Nt8Y/iI60Zkgw42+l66Qs1nSi9Zt1bh2guXAyKk6/ntLmjrBY8atz6ZO7Xd7J7Q
         j7SCNCKzQ2IWchDLBdXnOrcEUj1ZhfomBfD8++FMhRaZm4O1xPcZT4gvFnBOxuj3+y3G
         ydJ8bDnoOW6FrHXJZ7q/X2GU0+admxGVDS1roqPeDjfCn1QEo4xzGHgc+RnM6jZu9elI
         zHdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xSDXdp3vesglyJfEZEUrR0y8ghuzlBAtRSGZBJa/qPaMBLbaNow5hni9X2lZuPoMjqVNiq2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+yiVD86ytUBiggfdqUF76gXuL+yNPvEI0zEW1WVYXrhKhFRZ
	TK3wFdwiF4GnFIuwTamypCykZ5vbxmWLVF8O5MCN0JeXKAHXzwxN17Sp
X-Gm-Gg: AeBDiesjhu+wnfkcFNWYRnsvMIXY3CaIW5cLTzZYZ2R5odL1/8Hqrl5CkzXk0VdFzR4
	u0S+g+OsFFHD6lziVadVVzKLPLVh+90PVNPSIGp443ZklHFpVN9L/AYceSdbSC/snSd5nKC1rIf
	6TgvW1CJ4xHxEYAqr1Bx4FHPfbuoOFdQDMPsU5BISPsgbzC3KTociRdaIj1tRPICr2BSenDKDj4
	UN6LIsseRG91aFOBEkplg/Y0Syxj9r4p83kOC9pn5tn+H4sHLIg/ygw+Q1Ne906fWNPDfRZ4b5m
	rf7VWYvR8emC1TZQUHLWkLpPZxC2eAJXAknRvL8f8sJMb2F//PEc6MQQXPj0ks2SKX3R7iuvCpb
	/eYrppN42QYXMtNfzl0nPXtuRcWz3L+lUCf9Hg00I7B/bYVTgYHA3/fRy6jrHuzNJKGXqm+sPsv
	kWZowD8FKQjvbl7l04+Lpv2uIPVwOgpCn0yQ==
X-Received: by 2002:a17:90b:4b49:b0:35d:9560:3f09 with SMTP id 98e67ed59e1d1-361404b8efbmr26679621a91.24.1776939254431;
        Thu, 23 Apr 2026 03:14:14 -0700 (PDT)
Received: from fedora ([2401:4900:1cbc:314:9667:4972:a94c:125a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc5d94sm25275714a91.2.2026.04.23.03.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:14:14 -0700 (PDT)
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
Subject: [PATCH stable 6.12 2/2] iommu/dma: sync IOTLB before releasing IOVA on sg unmap
Date: Thu, 23 Apr 2026 15:39:04 +0530
Message-ID: <20260423100904.5966-3-avinashpal441@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-240457-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 43AE0450856
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On the lazy-flush path, __iommu_dma_unmap_sg() calls free_iova_fast()
before iommu_iotlb_sync() has drained the old mapping from hardware.
A concurrent dma_map_sg() can then allocate the same IOVA and hit the
stale-PTE WARN_ON in __domain_mapping() / intel_iommu_map_pages():

    CPU 0 (unmap, lazy)              CPU 1 (map)
    ───────────────────              ─────────────────────────────
    iommu_unmap(iova)
    free_iova_fast(iova)  ← live!
                                     alloc_iova_fast() → same iova
                                     __domain_mapping()
                                       dma_pte_present() == true ← WARN

Fix: insert iommu_iotlb_sync() immediately before free_iova_fast() on
the lazy path so the IOTLB is fully drained before IOVA reuse.

The strict-mode path already serialises here; this closes the same gap
for lazy/deferred flushing (regression introduced between v6.12.74 and
v6.12.76 — confirmed by reporter).

Reported-by: Giovanni Pancotti <giovanni.pancotti@example.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221389
Fixes: <run: git log v6.12.74..v6.12.76 -- drivers/iommu/dma-iommu.c>
Cc: stable@vger.kernel.org
Signed-off-by: avinash pal <avinashpal441@gmail.com>
---
 drivers/iommu/dma-iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 0f0caf590..90071cf4a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -159,6 +159,15 @@ static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq
 			break;
 
 		iommu_put_pages_list(&fq->entries[idx].freelist);
+/*
+ * Bug fix (Bugzilla #221389, regression v6.12.75/v6.12.76):
+ * Drain the IOTLB before handing the IOVA back to the allocator.
+ * On the lazy-flush path, free_iova_fast() makes the IOVA
+ * immediately reusable.  A concurrent map() call can then receive
+ * the same IOVA while the old PTE is still live in hardware,
+ * triggering a stale-PTE WARN in __domain_mapping().
+ */
+iommu_iotlb_sync(domain, &iotlb_gather);
 		free_iova_fast(&cookie->iovad,
 			       fq->entries[idx].iova_pfn,
 			       fq->entries[idx].pages);
-- 
2.53.0


