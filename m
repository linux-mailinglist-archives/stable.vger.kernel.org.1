Return-Path: <stable+bounces-206075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 095E4CFB84F
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 02:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13BA4303F9AF
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 01:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D76015B971;
	Wed,  7 Jan 2026 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7yTsZlU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7F73FCC
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 01:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767747797; cv=none; b=G8k8AYiH61zmq5XuTnWdeptozeeJwMkWAZjhsnCC/dmlv1GjYX4Re04gfghSEMkYyN1+bsx52PPvL9QgD4k7xbLy8mo1zQLibD2ieLB4p2hSo4tHww65Peh8F4ySYBO8ipjNyR4/k8i1vVl1eqfUBuVOTv6nXjkAQT9lw20RdWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767747797; c=relaxed/simple;
	bh=7KjNvX19PkwWR5/mM5N6FR120omxR/jCQWDFLMlI1Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhOuGeVV5qVyLKQZdmdfkDbqBLJRWKHLtGRlf+IANqOz+uvql7z2+4Vab1wkFYvX+wH97QpTcJzg7NeYmppfdy4WNYjkQDzjTvkFVp4rUsQSqbcPi6oRoXvMxnvWG5OqpnVfhSfvLRjw0azC8i/mOrMQ/E0Jy4ui1OS5QqvgeSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7yTsZlU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961A6C16AAE;
	Wed,  7 Jan 2026 01:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767747797;
	bh=7KjNvX19PkwWR5/mM5N6FR120omxR/jCQWDFLMlI1Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O7yTsZlUI+sQ3U2vZfAa/1CKKk7pbyqvaNOZLkZXVyscTljF5re3Nai38So1AEImx
	 L5tFFalFmrZcckH8ySFa1gtdNirRUGWCwLBiRCi8JhNQJpDWEAzMbBRL95vgibOIkj
	 t7vYH/yougB+zrXWQ8OJ/vGz5ZWnoKBQ1jJYZ/2z9hFA3IFZJn2KG4Px3w1GEtW2Jm
	 iM3Zhk7B12sKOOx5sqlf75O+/orfE7evL/IKIeUnm5Cc4J0yHz4zbGK23SlGNqqv7m
	 GqBc3ByBOJ6u5kdYZaAomUzUjxBAZ+SueCEdjpizlbcINKvFaoumrklPQW7cnGqkAy
	 E9BoIaH1XINCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net: phy: mediatek: fix nvmem cell reference leak in mt798x_phy_calibration
Date: Tue,  6 Jan 2026 20:03:14 -0500
Message-ID: <20260107010314.3480558-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010550-concise-enjoyment-35f1@gregkh>
References: <2026010550-concise-enjoyment-35f1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 1e5a541420b8c6d87d88eb50b6b978cdeafee1c9 ]

When nvmem_cell_read() fails in mt798x_phy_calibration(), the function
returns without calling nvmem_cell_put(), leaking the cell reference.

Move nvmem_cell_put() right after nvmem_cell_read() to ensure the cell
reference is always released regardless of the read result.

Found via static analysis and code review.

Fixes: 98c485eaf509 ("net: phy: add driver for MediaTek SoC built-in GE PHYs")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20251211081313.2368460-1-linmq006@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/mediatek-ge-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mediatek-ge-soc.c b/drivers/net/phy/mediatek-ge-soc.c
index f4f9412d0cd7..4b2a9a5444c5 100644
--- a/drivers/net/phy/mediatek-ge-soc.c
+++ b/drivers/net/phy/mediatek-ge-soc.c
@@ -1082,9 +1082,9 @@ static int mt798x_phy_calibration(struct phy_device *phydev)
 	}
 
 	buf = (u32 *)nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
-	nvmem_cell_put(cell);
 
 	if (!buf[0] || !buf[1] || !buf[2] || !buf[3] || len < 4 * sizeof(u32)) {
 		phydev_err(phydev, "invalid efuse data\n");
-- 
2.51.0


