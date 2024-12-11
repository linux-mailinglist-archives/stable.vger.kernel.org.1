Return-Path: <stable+bounces-100706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FFA9ED50E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11E4285356
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853A523A18E;
	Wed, 11 Dec 2024 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLg5CNEs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C852288C8;
	Wed, 11 Dec 2024 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943062; cv=none; b=fMQG5Od5OeH3ra6uLSQoVJGzfXlH4HDP2G3fpIQH6YsPSgOwEV1tH6087MHwat57X8EEH0wTyJA7a5Azx3mypKl28Isb+zdBtOxySuxdAdKeZKr+JTV76aplW6gb/izSHmgfYvI/wMa8ANNCYRfdko+0re+KY8mXcYvUzBGuPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943062; c=relaxed/simple;
	bh=VQNisN11DKHDGAdOXQZUc6rLA8LP2dJTsux3IK+ROc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3tienhAq6rhWmscXO0Jjf/zBAGpk5GZGH3NCIfNHGi9LQshsX97y+Jd+7WzYSi69rqV6HVc1ZAPux/P8+tRemUNkYdSHKyHK7s2Wm2FwjSowVlriXG5NhqHNg/youYHaoVXZTZI/K9YHPWu+coSFWAmNgJzOI/6B5dJgUKvn1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLg5CNEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F8DC4CED2;
	Wed, 11 Dec 2024 18:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943062;
	bh=VQNisN11DKHDGAdOXQZUc6rLA8LP2dJTsux3IK+ROc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLg5CNEs7JIdQbNp+etRWaal6GnILUphgGmrKGEfMcvRTn0ece+ONRiiKlTpMuf/9
	 wy2gVZBPs9bKgr7d+SdNckF0mD21JYtOtSpCrwfd/y51HJ/N1wJdOqdVl6HTQDxR0V
	 xRjAK6vsYWtGTaNDPRtIfPp0Zf885hfUF033PdKsxgc8hI3dPyP15cjVTXIMT6EYXu
	 rE6VTfxf9yH3vLn1C+AoyPmrIrg0pIGZNjneqvfMvSvBKhhZY6GiD+bZcIcXTTjLe9
	 UpnGmQyDvV3AxLQaoWLL4znvIHK6MYQXWQgyMhNfOS3Cl90ggvoUWE274oG0HwdFHw
	 lh7bH5beffnzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org
Subject: [PATCH AUTOSEL 6.12 16/36] regmap: Use correct format specifier for logging range errors
Date: Wed, 11 Dec 2024 13:49:32 -0500
Message-ID: <20241211185028.3841047-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 3f1aa0c533d9dd8a835caf9a6824449c463ee7e2 ]

The register addresses are unsigned ints so we should use %u not %d to
log them.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20241127-regmap-test-high-addr-v1-1-74a48a9e0dc5@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 4ded93687c1f0..d09cda139d219 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1051,13 +1051,13 @@ struct regmap *__regmap_init(struct device *dev,
 
 		/* Sanity check */
 		if (range_cfg->range_max < range_cfg->range_min) {
-			dev_err(map->dev, "Invalid range %d: %d < %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u < %u\n", i,
 				range_cfg->range_max, range_cfg->range_min);
 			goto err_range;
 		}
 
 		if (range_cfg->range_max > map->max_register) {
-			dev_err(map->dev, "Invalid range %d: %d > %d\n", i,
+			dev_err(map->dev, "Invalid range %d: %u > %u\n", i,
 				range_cfg->range_max, map->max_register);
 			goto err_range;
 		}
-- 
2.43.0


