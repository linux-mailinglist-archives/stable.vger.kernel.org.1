Return-Path: <stable+bounces-202376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F072CC36E1
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 15:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE3C33079D0E
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974E352F92;
	Tue, 16 Dec 2025 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fPRBLHaM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19931355F;
	Tue, 16 Dec 2025 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887696; cv=none; b=RqSy1XK5cpWqUHEq95hEYTKTqZGBj7mfRKGyibqOW1Oc4wVXWBZNH2bvtHdj4YWiyf7HnbzrrQtN1qX0IXTfszsKBR1fNWg7rCtct/l7UahWMtZQcGEkv3/kyCvs1ZoHNAWSggVNQySS4dEY1/qZHYnY1zZi+jF1bqTk50WeBGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887696; c=relaxed/simple;
	bh=ZFSRKF/jdwrhgDXxZZxKwLptg75ajHnb3EvACxReFhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCh3uWGOgMnQS0j5/kFuQ3MxFjH8mjSexUcg8A2UYvY+TgVWzvk1FWrwqfFKaCdvGzJvqN3SU5W0w6R58H3VmuB2w5aTnm2Vgw7GlhT6vDz9jJ8kbhLVBBa4KsW5nHFMYC/x3NnrgPnqMW+Om+xhPTIw2zs+73jEpSc1dSBcDZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fPRBLHaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB22C4CEF5;
	Tue, 16 Dec 2025 12:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765887696;
	bh=ZFSRKF/jdwrhgDXxZZxKwLptg75ajHnb3EvACxReFhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fPRBLHaMH63GSNE2F00zoxryqVOGu0bXs2gexCSyEQRkojX4NpCcwMJ4pp/5FKNsh
	 WW1t3P3g8IkRsZopfEwByGpqkhsIZMYbqC0N9LhbrnG/jVaY3F7nZRko68qKYLxupD
	 B0bZuD0pCYigwD7jK3vmvFo7uXXTEJEoBCXvEEAQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 309/614] drm/msm/a2xx: stop over-complaining about the legacy firmware
Date: Tue, 16 Dec 2025 12:11:16 +0100
Message-ID: <20251216111412.563901329@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit a3a22373fce576560757f5616eb48dbf85891d9c ]

If the rootfs have a legacy A200 firmware, currently the driver will
complain each time the hw is reinited (which can happen a lot). E.g.
with GL testsuite the hw is reinited after each test, spamming the
console.

Make sure that the message is printed only once: when we detect the
firmware that doesn't support protection.

Fixes: 302295070d3c ("drm/msm/a2xx: support loading legacy (iMX) firmware")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/688098/
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
index ec38db45d8a36..963c0f669ee50 100644
--- a/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a2xx_gpu.c
@@ -234,7 +234,7 @@ static int a2xx_hw_init(struct msm_gpu *gpu)
 	 * word (0x20xxxx for A200, 0x220xxx for A220, 0x225xxx for A225).
 	 * Older firmware files, which lack protection support, have 0 instead.
 	 */
-	if (ptr[1] == 0) {
+	if (ptr[1] == 0 && !a2xx_gpu->protection_disabled) {
 		dev_warn(gpu->dev->dev,
 			 "Legacy firmware detected, disabling protection support\n");
 		a2xx_gpu->protection_disabled = true;
-- 
2.51.0




