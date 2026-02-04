Return-Path: <stable+bounces-214054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZM/vLnxng2kbmgMAu9opvQ
	(envelope-from <stable+bounces-214054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:36:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 742CFE8F50
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34693309DE09
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E3342314A;
	Wed,  4 Feb 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YyULthLK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95B421EE4;
	Wed,  4 Feb 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218407; cv=none; b=clCYtsv3z4udYHPP+GA3DjH4/gb5uO2VUrfUUO8GvV3niKBdrb8shmO+s1cweLWdwSnAX5pbfLmyg2YtsCXiuXbj+qHpJ05F5olHwNCTtHVi9Q6+cPFpSCx/u4/fjIItSNJ3Mnordos6STO6BcGzekPm7CJUzsvS11tPVs7bX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218407; c=relaxed/simple;
	bh=2kjt4KJHIKgAoUuPiVuH8dvR4ayng5/vMLiBx3zD3Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHFw3+ISv9rvHM5REcZLoSl4gfTcXZHxpx0SzxAnE2d9kUva/CjNel+XZrF/Qn7koNAgPoJHWlSTNDvSCHUCci1BF+AGJkAJrWGWyTTUOIFXaiEOn5D2PFb5moB2ZieY86ScuZAh0S+8QE6nCVerDWCkkIw5Xdx4WCrAPxUQNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YyULthLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB05C2BC9E;
	Wed,  4 Feb 2026 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218407;
	bh=2kjt4KJHIKgAoUuPiVuH8dvR4ayng5/vMLiBx3zD3Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YyULthLKcmpgbYnRbN88C9Gpjg/Hm4mVCYbRZigF59zGRH7RzhdHnnWrkumnvcu6f
	 yCyJl/Ty0iOV90shjEmW3D3XrLmu9A8pZjQAhhpDQnDvPxGNcz7Y/rdCntKw8Lyk2p
	 MNl5oIM2iGhHKqgPz/RhG66F8dEw9fp9UGG9r5o4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 22/72] dma/pool: distinguish between missing and exhausted atomic pools
Date: Wed,  4 Feb 2026 15:40:25 +0100
Message-ID: <20260204143846.428114002@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143845.603454952@linuxfoundation.org>
References: <20260204143845.603454952@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214054-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ti.com:email,samsung.com:email,arm.com:email]
X-Rspamd-Queue-Id: 742CFE8F50
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sai Sree Kartheek Adivi <s-adivi@ti.com>

[ Upstream commit 56c430c7f06d838fe3b2077dbbc4cc0bf992312b ]

Currently, dma_alloc_from_pool() unconditionally warns and dumps a stack
trace when an allocation fails, with the message "Failed to get suitable
pool".

This conflates two distinct failure modes:
1. Configuration error: No atomic pool is available for the requested
   DMA mask (a fundamental system setup issue)
2. Resource Exhaustion: A suitable pool exists but is currently full (a
   recoverable runtime state)

This lack of distinction prevents drivers from using __GFP_NOWARN to
suppress error messages during temporary pressure spikes, such as when
awaiting synchronous reclaim of descriptors.

Refactor the error handling to distinguish these cases:
- If no suitable pool is found, keep the unconditional WARN regarding
  the missing pool.
- If a pool was found but is exhausted, respect __GFP_NOWARN and update
  the warning message to explicitly state "DMA pool exhausted".

Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for IOMMU mappings")
Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20260128133554.3056582-1-s-adivi@ti.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/pool.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index b3b9c7ec5fc54..8a15b5008b20c 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -268,15 +268,20 @@ struct page *dma_alloc_from_pool(struct device *dev, size_t size,
 {
 	struct gen_pool *pool = NULL;
 	struct page *page;
+	bool pool_found = false;
 
 	while ((pool = dma_guess_pool(pool, gfp))) {
+		pool_found = true;
 		page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
 					     phys_addr_ok);
 		if (page)
 			return page;
 	}
 
-	WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
+	if (pool_found)
+		WARN(!(gfp & __GFP_NOWARN), "DMA pool exhausted for %s\n", dev_name(dev));
+	else
+		WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
 	return NULL;
 }
 
-- 
2.51.0




