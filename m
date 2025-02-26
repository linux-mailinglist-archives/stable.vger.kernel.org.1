Return-Path: <stable+bounces-119705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABC4A465A5
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F2019C44D9
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B85521CC66;
	Wed, 26 Feb 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8bHVYLV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE03209;
	Wed, 26 Feb 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584637; cv=none; b=raQNzavcyczbnivNBQWKq0CoW2sgo9A+Orau2BmVzccs4adPRRfDPgFFwYTtR8S16DAtnykE44/jPR6M+pk/6G/m0129aHX0MpXYCqYgsJ8/7TulpDhi2QUYnS4X3+Mn9Eyhz1WxrJyv2ut6vKf40f78ScSgOuoBCfILBYm0/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584637; c=relaxed/simple;
	bh=S4vXwMzbgKuzoB2GNLXoh9u2AmH65nkVYHhHCyGHSOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=s1T2LCCxzbSDyhyQqlfgm07UkzywvxhdpvZAZrWZJhP02MhSv2UeJ/alsoclFsdWkbX4Y8ssV4XerTBu6TZ++Ex8G/fw6q5dMAiEFQf+06sr21DdFFNIxgj+YCoRyws9gRvMPbDndF+M4BEH5i5OQjL6pWuNm2A8gT7I2X6XLW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8bHVYLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5095C4CED6;
	Wed, 26 Feb 2025 15:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740584636;
	bh=S4vXwMzbgKuzoB2GNLXoh9u2AmH65nkVYHhHCyGHSOU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=c8bHVYLVmTf1hA0OLp/6shhd0T2hIkFRYzqiiaZKYG3WyoOqdbhhy7xBID78VO44p
	 ydNmKQAbguzngzJ9dMj85OY6CR+FIVv32IdgcwRuA/aA42t4j1zvkYgZPMmXO3FETO
	 e9Qzlujouvrow9dPKd7Ny5Enr/q7Cam6+XFC6LPJrJl7SB9/Xh1Scq1zlhHlpIM+9n
	 r1OdDFKMOPirPYBqv94G6ek+3HclLrjczM8R3YSmaikTCt32EyMNET9agq/x7BE5ex
	 uu3P91uOot+XLg1SDvSZci5ao36VlELmpUhGZz2s9d69N7c5pLuQVai2ug39+1Npha
	 1w18uXwAjEcag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CADC021B8;
	Wed, 26 Feb 2025 15:43:56 +0000 (UTC)
From: Brendan King via B4 Relay <devnull+Brendan.King.imgtec.com@kernel.org>
Date: Wed, 26 Feb 2025 15:43:54 +0000
Subject: [PATCH v2] drm/imagination: only init job done fences once
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-init-done-fences-once-v2-1-c1b2f556b329@imgtec.com>
X-B4-Tracking: v=1; b=H4sIALk2v2cC/3WNwQrCMBBEf6Xs2ZUkbYJ48j+kh7rZtHtoIkkpS
 um/G+vZy8AbmDcbFM7CBa7NBplXKZJiBXNqgKYhjoziK4NRxirdapQoC/oUGQNH4oKpJpK1ZL0
 Knb8Q1O0zc5DX4b33lScpS8rv42bV3/ZnNKr9Y1w1ahyMd6ZTzrrucZN5XJjOlGbo933/AHQ8S
 Mi7AAAA
X-Change-ID: 20250131-init-done-fences-once-c55c5d0f4d8c
To: Frank Binns <frank.binns@imgtec.com>, 
 Matt Coster <matt.coster@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Brendan King <brendan.king@imgtec.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740584635; l=1461;
 i=Brendan.King@imgtec.com; s=20250203; h=from:subject:message-id;
 bh=UrgZZNLO6KQjYmVVmOuiGQdH9eC1zmrRRgFAWjyyAho=;
 b=GTiqpbY02OZNMyfKtmKmWhn2GpFDSni7bVrmNCJR6tUDDSAlsGFQ4sgHyywyNc1mRTWGiHEeD
 PBf3bqEsfGQAlqGNp1L+MY+RkpT3g+97uQyGTltHlVJcnTJrgZa5xSn
X-Developer-Key: i=Brendan.King@imgtec.com; a=ed25519;
 pk=i3JvC3unEBLW+4r5s/aEWQZFsRCWaCBrWdFbMXIXCqg=
X-Endpoint-Received: by B4 Relay for Brendan.King@imgtec.com/20250203 with
 auth_id=335
X-Original-From: Brendan King <Brendan.King@imgtec.com>
Reply-To: Brendan.King@imgtec.com

From: Brendan King <Brendan.King@imgtec.com>

Ensure job done fences are only initialised once.

This fixes a memory manager not clean warning from drm_mm_takedown
on module unload.

Cc: stable@vger.kernel.org
Fixes: eaf01ee5ba28 ("drm/imagination: Implement job submission and scheduling")
Signed-off-by: Brendan King <brendan.king@imgtec.com>
---
Changes in v2:
- Added 'Cc:' and 'Fixes:' tags
- Link to v1: https://lore.kernel.org/r/20250203-init-done-fences-once-v1-1-a2d62406564b@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_queue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index c4f08432882b12f5cdfeb7fc991fd941f0946676..9a67e646f1eae709859f664c796e1940f0b45300 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -304,8 +304,9 @@ pvr_queue_cccb_fence_init(struct dma_fence *fence, struct pvr_queue *queue)
 static void
 pvr_queue_job_fence_init(struct dma_fence *fence, struct pvr_queue *queue)
 {
-	pvr_queue_fence_init(fence, queue, &pvr_queue_job_fence_ops,
-			     &queue->job_fence_ctx);
+	if (!fence->ops)
+		pvr_queue_fence_init(fence, queue, &pvr_queue_job_fence_ops,
+				     &queue->job_fence_ctx);
 }
 
 /**

---
base-commit: 3ab334814dc7dff39075e055e12847d51878916e
change-id: 20250131-init-done-fences-once-c55c5d0f4d8c

Best regards,
-- 
Brendan King <Brendan.King@imgtec.com>



