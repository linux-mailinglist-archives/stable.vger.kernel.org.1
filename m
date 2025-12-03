Return-Path: <stable+bounces-198859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B040AC9FD73
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3079303CF44
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F71F34F488;
	Wed,  3 Dec 2025 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uDjwJ5qY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA9E34F482;
	Wed,  3 Dec 2025 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777904; cv=none; b=gV392k825Lm/jrOMdMC580JXRFDl9pyjZlaSHGLm0xOv93X/+dlRhCEiYQIs3iRshrvbUc+i6q0insV/XpI8JFQsXsu4nnkz/kREyfuW8bhnkxVNCDMBe8u2o9rQNp4lDmCZxyqYmUB5Qg922zN3fkJQUuTzn8uSXEVs+cprL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777904; c=relaxed/simple;
	bh=AR6YRxMlHOCvEp7FuERWs3G2R7Vsolppzv/5PUu7mas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td8OLRlVDThbCW8ylATPpVrVG34BpQHNmc36r+rZsLS5/3QOtBYgSbjl3MMcUzBePD3kJuO21a6RQlMOgyRl4DBQEHCumMTktRmAnq6tLwH3Lubf1jdmRPH+hk+2oC8sB8n3vy40dBchN+pfPlOxPQ88L2qjOGBtp06QP3hXHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uDjwJ5qY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E0FC4CEF5;
	Wed,  3 Dec 2025 16:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777904;
	bh=AR6YRxMlHOCvEp7FuERWs3G2R7Vsolppzv/5PUu7mas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uDjwJ5qYA7umtuwAcebdt9DTXqxpW45hUCAMzKdIu772Rh1abdgAO+M69FRCzEvSN
	 Oi0eKa+ALG2pb89qNr9kDqPp9Uq7iuvW/sLtuE5PuNpX5KVDryunmWUMtn/4CeKXND
	 HBYLfiErXJGhuT113xszGBfat2M64JHylWxx9EvU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 184/392] page_pool: Clamp pool size to max 16K pages
Date: Wed,  3 Dec 2025 16:25:34 +0100
Message-ID: <20251203152420.851863740@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit a1b501a8c6a87c9265fd03bd004035199e2e8128 ]

page_pool_init() returns E2BIG when the page_pool size goes above 32K
pages. As some drivers are configuring the page_pool size according to
the MTU and ring size, there are cases where this limit is exceeded and
the queue creation fails.

The page_pool size doesn't have to cover a full queue, especially for
larger ring size. So clamp the size instead of returning an error. Do
this in the core to avoid having each driver do the clamping.

The current limit was deemed to high [1] so it was reduced to 16K to avoid
page waste.

[1] https://lore.kernel.org/all/1758532715-820422-3-git-send-email-tariqt@nvidia.com/

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250926131605.2276734-2-dtatulea@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/page_pool.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 813d15a5593c6..4ec7e6229f697 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -61,11 +61,7 @@ static int page_pool_init(struct page_pool *pool,
 		return -EINVAL;
 
 	if (pool->p.pool_size)
-		ring_qsize = pool->p.pool_size;
-
-	/* Sanity limit mem that can be pinned down */
-	if (ring_qsize > 32768)
-		return -E2BIG;
+		ring_qsize = min(pool->p.pool_size, 16384);
 
 	/* DMA direction is either DMA_FROM_DEVICE or DMA_BIDIRECTIONAL.
 	 * DMA_BIDIRECTIONAL is for allowing page used for DMA sending,
-- 
2.51.0




