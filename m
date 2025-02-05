Return-Path: <stable+bounces-112871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CABD4A28ED0
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4B7188744B
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B6914A088;
	Wed,  5 Feb 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pPt8YPFV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8231519A4;
	Wed,  5 Feb 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765037; cv=none; b=tRWuP3gLRak06AFBUtThTnLbg3yHdoQyophBdOcnrTyqFWm0f+CuIRLr2E4QuhXlr5TEU4BUWOwHsGpjGrb3PM1YZ9clzBLNk1baodNP6MLb6117aV5kKz2qfPa2oZyiGt0t+bhGgVB3rBTBRodYfafcLIzkLkwtci48kSQb64Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765037; c=relaxed/simple;
	bh=RE1u27Hgx8D79JZaayIRibi8YYg/ymqWeuHTllbpTq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEsAN2kJppbq/gbuZMo+xoA9nqz9GhilV+fuZODkdcdRhQbUanSp65LEJWwUjNkOXTMmfCL45odaxiVDTUABW8TaOdlAV0v4Ev/OcSKckH8GdxoUwhWTfoQvIGkxkCCW5Iq+ZiyXLsqIn9A6o8sSXQipT+KBNsFvjHxnd5ChTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pPt8YPFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB8CC4CED1;
	Wed,  5 Feb 2025 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765037;
	bh=RE1u27Hgx8D79JZaayIRibi8YYg/ymqWeuHTllbpTq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPt8YPFVbzIrGS6C3u3NRv2gDow1LiU/qjiInqCxyBP4kNlmMbsFAogyCWjh9Lhaw
	 eB4yutzJAapFTCAnav4QGY5TH6LQHzXmzPrGjr5zDhikPNuOcha9U8wReTfYV/HDwE
	 XW13gsCzbDfjddWwq0KWatu0LQ1JSwvPBZGmmjSQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"allan.wang" <allan.wang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 184/590] wifi: mt76: mt7925: Fix incorrect WCID phy_idx assignment
Date: Wed,  5 Feb 2025 14:38:59 +0100
Message-ID: <20250205134502.319605729@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: allan.wang <allan.wang@mediatek.com>

[ Upstream commit 4f741a2378b27a6be5e63b829cae4eb9cf2484e7 ]

Fix incorrect WCID phy_idx assignment.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: allan.wang <allan.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/20241211011926.5002-5-sean.wang@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index cbc7a50810256..268d216f09e20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -384,7 +384,7 @@ static int mt7925_mac_link_bss_add(struct mt792x_dev *dev,
 
 	INIT_LIST_HEAD(&mlink->wcid.poll_list);
 	mlink->wcid.idx = idx;
-	mlink->wcid.phy_idx = mconf->mt76.band_idx;
+	mlink->wcid.phy_idx = 0;
 	mlink->wcid.hw_key_idx = -1;
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mt76_wcid_init(&mlink->wcid);
@@ -851,7 +851,7 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	INIT_LIST_HEAD(&mlink->wcid.poll_list);
 	mlink->wcid.sta = 1;
 	mlink->wcid.idx = idx;
-	mlink->wcid.phy_idx = mconf->mt76.band_idx;
+	mlink->wcid.phy_idx = 0;
 	mlink->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 	mlink->last_txs = jiffies;
 	mlink->wcid.link_id = link_sta->link_id;
-- 
2.39.5




