Return-Path: <stable+bounces-214136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBYVIEFsg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-214136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:56:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D20FE9A37
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB2ED321B10F
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F322D594F;
	Wed,  4 Feb 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d1TkFmHl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BAC2D4B68;
	Wed,  4 Feb 2026 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218685; cv=none; b=BsH7bzEDA+QJOKZnmpLt+hWYLHrvdrf0PuSP+E6iPfO1qAWmrG3eyfM3/GksHVFQMZJpBpNYpDwftdHDGZ5xf7KI5FEjjqQr1dyzroxtvNADxX3dFtS6zAMhl/BYTQIlCxERN7iUEy0wREQBqSs0aPV+ni4QbwVo/UFeedbbL2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218685; c=relaxed/simple;
	bh=pePw0sSoeCPYLQoHy1kL9oGGjZN2EpxB90iG8KUTZ2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piOJvv508XkknLtpHAItl6pSNCtdSRpIT0xCtcPypZq0vhas01kDc4XJgsS/BNe6DhD59SB8i4OtFOmTs+Xz4/hB5Z5NHmUUXkgFJX3zwRncMq5b3BFx05JQLH1mLAFE1zSWqN/+norZRkvHl9aE+rpzAAFGNEFt18FjMZw5TQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d1TkFmHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743D3C4CEF7;
	Wed,  4 Feb 2026 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218684;
	bh=pePw0sSoeCPYLQoHy1kL9oGGjZN2EpxB90iG8KUTZ2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1TkFmHlVE3xj7RmR0rCzC7T1tK6Q/FAv6WpOg6lQryjwqJGl/5takbI2TDM/dB+r
	 Su0FvfGfZPKYj4ysNB/iLk7eQHleRYSx6ne/Z4bZuW3BwUGmffVxQU4NOzBNGWFaA4
	 g/mcAHWqV1txUFfm/f7XLdVi4Lc/I4RK1rLeAwgc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 31/87] dma/pool: distinguish between missing and exhausted atomic pools
Date: Wed,  4 Feb 2026 15:40:29 +0100
Message-ID: <20260204143848.032521157@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
References: <20260204143846.906385641@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214136-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: 9D20FE9A37
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 26392badc36b0..985d6aa102b67 100644
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




