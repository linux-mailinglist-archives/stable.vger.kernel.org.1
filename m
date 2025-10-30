Return-Path: <stable+bounces-191720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594DFC1FCA6
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 12:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD703B4D9B
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10D733DEC2;
	Thu, 30 Oct 2025 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="h8a3X963"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC9A2E8894
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823231; cv=none; b=uTsf1tZ6w8UDaCu9S5W/Cb8Xex6mRah7bRPJDeVEj0n0fJ8OSDFsUY+H6VI7jnSFCmwxFcXdNDmDoAm1FN2GKYklx8KsxGBEerfLOwTbSTmTPqCMOT1ju9wfV0zDhrq8GjQmgg+H1fv0rgX5P/18Tm+UFaNO2rasMLL1NzL0yzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823231; c=relaxed/simple;
	bh=UMgHCQUu8cOFMbnecxRXWBDMtD529aws4Ow+KFvMMrU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=F83QaMysSi9nYfiVtouU6QNj8EJIR/tOaQLEYWT89CS5YcEoy/Qw7MnIoGxxh7qZWJC+qYBpheP/KgvhbROW6zLFfhG7RDk3kEgBgiBPHEbIvgpMnHMNmwkAR0leQ7o47N34vlF2DxtCwcjDEcj78KChX4SCwif7J0bEmpYWEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=h8a3X963; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso1030508b3a.2
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 04:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761823228; x=1762428028; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jBUXjI+VAuZkH4C/pJW07Y7+zKzm2v+t+cHIswPHfk=;
        b=h8a3X963C6Mcl5XIwQoF5UHlxjtI4k/5wtxzqieQslBNE6aTqVzRcW8dwflRztDK35
         R9qZ6JlmODiyqTTgynox8Qdw+RTxtQzGlHcbjHfXMySJe7EOUtuED7gs8OQgyVpUa1W5
         X51YDl1bMCJdk8O2kht45Hn7tOExOxT6uiSAiAzr3Dc2Uw3u8wdvy3WgHth4iqJhvGTb
         c6BPMMCP3hg327BHZ6LahTZq+gEjniSswaxEZZgqE+0HYzX/h6yeulodxhcwW5dfmWFe
         8Sule4v9lGbyjS9h46C8OUnzTHclwj+xnXNTjorNHS+xttl92HRKFYJC/tpoL2mcchuR
         I5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823228; x=1762428028;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jBUXjI+VAuZkH4C/pJW07Y7+zKzm2v+t+cHIswPHfk=;
        b=hgAy3nFhNTFCepurMplncBWCuk5fIJy6VKmLN8N8Rtn7p+tazOpRpXDZDO4UIfS8+D
         33YXElMcESqnMNC+XVHSA8T3emSY6JJK9izeW8qfz78ZSjNJRP1UkvDqk1KO3MJZjLEe
         Zlrf0SO46Qf7rOQt6+ncccoRYTXGLVMIDBYy4su/HVO5Niy7goAD+CUv1f9QKvRu3edM
         tRPEObPiGgT4bhcOGynyHCw7b1ae4Q3F9HGdH3cVuQGt6g3FVwxp80nBM5/+spYVvf53
         0b9fUpV244jA6duTgFkmeC+DVPiqsEN1vnO6ntoHEKPbV/BXJErgkQ52cBZYTVNzBCeH
         lx6A==
X-Gm-Message-State: AOJu0Yzz2Kfis7ZCtJFzTjw3NAUAXrRySG5WHMz2YJobHSap2dN4bHTY
	pT7Swu1z25k+H1AAsBDqPeLtCZG4OQDaQKPOY1Qrme8rY0tVbRJXHtYYM/FejDNEVOVGWAmOphN
	rrqNC
X-Gm-Gg: ASbGnct62GRphAHZ6GSp5PV13SLsh74iiY1x3wUHv32kRN8DvbXbhxo9YP49j7OdV1B
	sszHfaJD+Q9FEs7Hfdf7iANEqKTCQ1fDoMtqjhhssXHc7otnMmmVRLopyPr+KNO57JLMXDJw6tv
	xppeDuyJrqgUDw6FiOiMDD0/RvIZ61D/mbn7N4zpalvgu7tPQOIOQSk+eysGE6Vqk5zGEI36IPC
	vkGVfs7+sE4wxy2J/VA5oMpOVTtYuD17nrBeTAEKMpQbGUtM9cOO0Kwr9BHbN60vcdxl3H9YAYc
	clKDgECciyxqNyU7977BdfGOrgJE0Vs/KjFuWjSC4PEQYly8fjuITCSYvkrAxXxjKXHga9li73A
	rbhBXfVawknkv5lQRkfHWTSLscNhEDzoMHoeucs6InIIOyOGlBD7dknKL+5AQJMZKahxNS2U0ef
	OK/rnqtDm2sa3zzu7HR59uQxCRGFeJRCSW
X-Google-Smtp-Source: AGHT+IH9/DKVPYn+/MtW7hYEn3RJ/PWJk9L0OYkwwgKcNwxO7lRzqwX9cQVK9GtmiMJWH3FziLvB0Q==
X-Received: by 2002:a05:6a00:181b:b0:7a3:455e:3fa5 with SMTP id d2e1a72fcca58-7a621813833mr4031294b3a.0.1761823228287;
        Thu, 30 Oct 2025 04:20:28 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a42aa5d9a6sm14777024b3a.62.2025.10.30.04.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:20:27 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: stable@vger.kernel.org,
	joro@8bytes.org
Cc: linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org,
	guojinhui.liam@bytedance.com
Subject: [PATCH 5.4.y] iommu/amd: Fix 2G+ memory-size overflow in unmap_sg()
Date: Thu, 30 Oct 2025 19:19:56 +0800
Message-Id: <20251030111956.308-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Since npages is declared as int, shifting npages << PAGE_SHIFT
for a 2 GB+ scatter-gather list overflows before reaching
__unmap_single(), leading to incorrect unmapping.

A 2 GB region equals 524,288 pages. The expression
npages << PAGE_SHIFT yields 0x80000000, which exceeds
INT32_MAX (0x7FFFFFFF). Casting to size_t therefore produces
0xFFFFFFFF80000000, an overflow value that breaks the unmap
size calculation.

Fix the overflow by casting npages to size_t before the
PAGE_SHIFT left-shift.

Fixes: 89736a0ee81d ("Revert "iommu/amd: Remove the leftover of bypass support"")
Cc: stable@vger.kernel.org # 5.4
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---

Hi,

We hit an IO_PAGE_FAULT on AMD with 5.4-stable when mapping a
2 GB scatter-gather list.

The fault is caused by an overflow in unmap_sg(): on stable-5.4
the SG-mmap path was never moved to the IOMMU framework, so the
bug exists only in this branch.

Regards,
Jinhui

 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a30aac41af42..60872d7be52b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2682,7 +2682,7 @@ static void unmap_sg(struct device *dev, struct scatterlist *sglist,
 	dma_dom   = to_dma_ops_domain(domain);
 	npages    = sg_num_pages(dev, sglist, nelems);
 
-	__unmap_single(dma_dom, startaddr, npages << PAGE_SHIFT, dir);
+	__unmap_single(dma_dom, startaddr, (size_t)npages << PAGE_SHIFT, dir);
 }
 
 /*
-- 
2.20.1


