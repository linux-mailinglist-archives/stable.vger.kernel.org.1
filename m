Return-Path: <stable+bounces-166886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9003B1EE2D
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 20:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D41C725F4E
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1031E5B91;
	Fri,  8 Aug 2025 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="eMD3AJwI"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225D1C84D6
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754676345; cv=none; b=Q7+fL9zRvz1A/x9Psk6bLA9wmzOlyse73VKu1Tmibmu7nhzyMDdja0oLVRwll4Cbe6U/3a4FA7QopHu6O8Bzlvrmhk3o8iJbPxvsKsBdstCG6jVM/nSbEan25WwSngg0K0C1fh0N5rXhZIS47jiHuMdwu14gKWCUSlNf0qZvCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754676345; c=relaxed/simple;
	bh=T2DceFAfgXnlNoxtKJ2zH2b4sO2Zchf+PeDPsEYRsMU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Slhdj+ETWScMk1U+zgsZCCY8Cb/X33H8JzOo8mauh/7Vn/xdbFVoQAcJkCwtyTCoBuBdRYuU5/0786CGMteZ5Jb2KNhIK0ClNP2Z7GEtIsHXlzHjBRRLNkh3vQEbs8PGKvoeE9OR578twJ6rUy3XWN4upCc8yknxhEwAlFAx/Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=eMD3AJwI; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1754676344; x=1786212344;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fdJQIvfCslGzxFz5MzKr+S0WumVrc3I8mnr8ItO/LPs=;
  b=eMD3AJwIeZ/vUS+lLnNaizXE+nPmrvRmO6BNrxHcPSRhTx35JJbnjhkX
   b2btiblSqis4onfWAVL5ojmKuAIpYmYP+N27W6u2DC/gyKdM9cbrOArPS
   eWtX2Fd4+Sab7wLVpvkBH79v8furHS1vVhPBvRMrYUHqACMIo9MG2s1pS
   x6Ov7QkMK1V7PoY/37HobXIBN7PhxBN3m8+so4Rjf3/u6qFaRx7Gy3itM
   HNVvoEMm/3qktqPFSv5DkUrQFokw8TTTjQEcT78YOcGYr2Zl+dzJtcc8Z
   DaIJgyrbEk3mGq9/iDnQnAuPQo5uNTSLKOKLbGpRynNVGdkNSY9LDqkzc
   g==;
X-IronPort-AV: E=Sophos;i="6.17,274,1747699200"; 
   d="scan'208";a="768250788"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 18:05:42 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:29197]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.230:2525] with esmtp (Farcaster)
 id 7163ea1e-8dc5-48d3-8071-00ad581fa08f; Fri, 8 Aug 2025 18:05:41 +0000 (UTC)
X-Farcaster-Flow-ID: 7163ea1e-8dc5-48d3-8071-00ad581fa08f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 8 Aug 2025 18:05:41 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 8 Aug 2025 18:05:40 +0000
From: Jay Wang <wanjay@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <christian.koenig@amd.com>,
	<hjeong.choi@samsung.com>
Subject: [PATCH 5.10] dma-buf: insert memory barrier before updating num_fences
Date: Fri, 8 Aug 2025 18:05:37 +0000
Message-ID: <20250808180537.26649-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Hyejeong Choi <hjeong.choi@samsung.com>

commit 72c7d62583ebce7baeb61acce6057c361f73be4a upstream.

smp_store_mb() inserts memory barrier after storing operation.
It is different with what the comment is originally aiming so Null
pointer dereference can be happened if memory update is reordered.

Signed-off-by: Hyejeong Choi <hjeong.choi@samsung.com>
Fixes: a590d0fdbaa5 ("dma-buf: Update reservation shared_count after adding the new fence")
CC: stable@vger.kernel.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20250513020638.GA2329653@au1-maretx-p37.eng.sarc.samsung.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Conflict resolved by applying changes from dma_resv_add_fence() in the original fix to dma_resv_add_shared_fence() in current code base]
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 drivers/dma-buf/dma-resv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 789f72db097f..16eb0b389e08 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -291,8 +291,9 @@ void dma_resv_add_shared_fence(struct dma_resv *obj, struct dma_fence *fence)
 
 replace:
 	RCU_INIT_POINTER(fobj->shared[i], fence);
-	/* pointer update must be visible before we extend the shared_count */
-	smp_store_mb(fobj->shared_count, count);
+	/* fence update must be visible before we extend the shared_count */
+	smp_wmb();
+	fobj->shared_count = count;
 
 	write_seqcount_end(&obj->seq);
 	dma_fence_put(old);
-- 
2.47.3


