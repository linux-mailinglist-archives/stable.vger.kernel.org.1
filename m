Return-Path: <stable+bounces-108665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D61A117D2
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 04:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144A81676DE
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 03:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053E74C98;
	Wed, 15 Jan 2025 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpkGNzzD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ECE232439
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736911991; cv=none; b=TsZqubIM2PJV1bHp1/7FJc7w19sBzR2amhEKgetkw+37ko296wADMc5/BmXnXNb7pdFQ7Nd4DK4UZIo8oIOXRsiv+TbcAxjvbVcpimWBjLRd1LlF8oULce2AcV/3HoIDCzbP6vEs7c2SMilRKabm8mLB1xoylqJmt63rK16QvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736911991; c=relaxed/simple;
	bh=+5S1MmPB8bi2n12VmvWjO1MuCiQR6ReA6olMy7skS0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C6+7djD9lYzgDX831ZjGse9ih7fwWXqJ5PyJAmVC/M9DaZsuO51oqJCQARWRT4AqsHSFUOpv2IQ4Vwt72qwg2B8z/7zCJxpWdE0KvM8BNBW73HBJ8T+YQRxqv6vtnQorlsZ0Oi4l982fzGZxG18xmNB3MGBb4e9QdQoCq3WNXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpkGNzzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CD7C4CEDD;
	Wed, 15 Jan 2025 03:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736911991;
	bh=+5S1MmPB8bi2n12VmvWjO1MuCiQR6ReA6olMy7skS0I=;
	h=From:To:Cc:Subject:Date:From;
	b=CpkGNzzDFmsqKLQTecrH03zMUCBMNaeaG5QcXiBT5PZO/VRxvLf3JfO1S1YZMPuoT
	 c7H0cKiK/wwDTAkE25PE430vVyIwXOVOVuQfoCZ/xyI8TA71qaD54nS+4+4pNHi8cm
	 KwmKZQGzAH+DhTH4Fmbkv+r405cuSLH9Ayt4Aym1YKpgLkD2Lp2EceiD98SWDH654A
	 BloY7hLgSyAt85PmJdokqiOy0OUuo72cK3v1emoV+f49qNjfiwKkevW0oq6N3eW7dh
	 rz0W7grxXcI/yv7AfKLS2H87yFpSzyPXdb8fu+A2XX5p4sJSEWO3/s+fyCnoJzfVGx
	 qiSV7wbtS5ucA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: broonie@kernel.org,
	rafael@kernel.org,
	demonsingur@gmail.com,
	tzungbi@kernel.org
Subject: [PATCH 6.1.y] regmap: fix wrong backport
Date: Wed, 15 Jan 2025 03:32:44 +0000
Message-ID: <20250115033244.2540522-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

48dc44f3c1af ("regmap: detach regmap from dev on regmap_exit")
wrongly backported upstream commit 3061e170381a.

It should patch regmap_exit() instead of regmap_reinit_cache().

Fixes: 48dc44f3c1af ("regmap: detach regmap from dev on regmap_exit")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 8748cea3bc38..f0e314abcafc 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1513,7 +1513,6 @@ int regmap_reinit_cache(struct regmap *map, const struct regmap_config *config)
 {
 	int ret;
 
-	regmap_detach_dev(map->dev, map);
 	regcache_exit(map);
 	regmap_debugfs_exit(map);
 
@@ -1548,6 +1547,7 @@ void regmap_exit(struct regmap *map)
 {
 	struct regmap_async *async;
 
+	regmap_detach_dev(map->dev, map);
 	regcache_exit(map);
 	regmap_debugfs_exit(map);
 	regmap_range_exit(map);
-- 
2.48.0.rc2.279.g1de40edade-goog


