Return-Path: <stable+bounces-108666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDC2A117D3
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 04:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781E93A521C
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 03:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2384C98;
	Wed, 15 Jan 2025 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsK+u4uo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2A469D
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736912002; cv=none; b=MqPB7F234Qsco6+7ig2Y4q9HtunCrrtaJre+PaX5+/Zn25ml+d71EHOmfxgTIvTGyVhuDH2L4U8JxpX6i8VhSBv0NFJ3UZCRIwZi0dz0b0VL2VnCHduKwC22s1ha6Z/R54/kpz8VqD2kwUszxGxpNqZhdmc7qvf7/dPBIu6R5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736912002; c=relaxed/simple;
	bh=VTOfPpK/m69CrxXWD1FWqXkCtv/PbGIeMowpyT9aXLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WhWncOmjXujWVa9qIIEF4P+2u6QjSzgm8H67VyTcz0zsdJi1JSiwrEQvesaIHCsDGG+XJ+bQkmp1/U2SkzIzQrL6D4uwPt01Xu7D5De2GeP0KRxFTWbpvzQeyQDpi7tUA7FPQVDkezetz67g0rsnC/8lVocuqW850LXTMM5Mwek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsK+u4uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB86C4CEDD;
	Wed, 15 Jan 2025 03:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736912002;
	bh=VTOfPpK/m69CrxXWD1FWqXkCtv/PbGIeMowpyT9aXLA=;
	h=From:To:Cc:Subject:Date:From;
	b=IsK+u4uogrFJVKblNdwrEq17aUUTPl1XvRVT5dZTgkO9P0xV97JvocasYf4uSTmBL
	 qyoSHurLPft8iHXMBMKmpuKVVudiGlhWiKsE4RY/RaA7mwpiyEds8X5SRCBr/Rn1Qh
	 uVS8dGBH3rNWsIcTErivifiXzgQBSelyMErM5jJ1dwSNiBDAxau0zY77BAbknCJMyW
	 pyG0gV5lAlR66bu0kUaFDISi0SUbtaDSKua86ale5LAB9oa9b+fQZ8tVeHNfgqpKIb
	 Jy1lKFGdifdA1Cd6YW7pyHLYYD0KzxPAgZQ0qil0PVBFRwYZJGmMyZTVzk2CYoGyXF
	 cGqPghh/1FgOw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: broonie@kernel.org,
	rafael@kernel.org,
	demonsingur@gmail.com,
	tzungbi@kernel.org
Subject: [PATCH 5.15.y] regmap: fix wrong backport
Date: Wed, 15 Jan 2025 03:33:14 +0000
Message-ID: <20250115033314.2540588-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f373a1898175 ("regmap: detach regmap from dev on regmap_exit")
wrongly backported upstream commit 3061e170381a.

It should patch regmap_exit() instead of regmap_reinit_cache().

Fixes: f373a1898175 ("regmap: detach regmap from dev on regmap_exit")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 00437ed9d5e0..6d94ad8bf1eb 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1508,7 +1508,6 @@ int regmap_reinit_cache(struct regmap *map, const struct regmap_config *config)
 {
 	int ret;
 
-	regmap_detach_dev(map->dev, map);
 	regcache_exit(map);
 	regmap_debugfs_exit(map);
 
@@ -1543,6 +1542,7 @@ void regmap_exit(struct regmap *map)
 {
 	struct regmap_async *async;
 
+	regmap_detach_dev(map->dev, map);
 	regcache_exit(map);
 	regmap_debugfs_exit(map);
 	regmap_range_exit(map);
-- 
2.48.0.rc2.279.g1de40edade-goog


