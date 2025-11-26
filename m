Return-Path: <stable+bounces-196962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A32A5C88491
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 946BB4E2408
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 06:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434B930EF62;
	Wed, 26 Nov 2025 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UCtJqW78"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795F2192EE
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138943; cv=none; b=hSYfmCXIy1QVXQ1J1Qa2CVcrH4qHrQHDqSvkhuLXD5QPeNgdpzVlZpGIsB0zsNAORHKjPId/iHRLm8JSw2jImwJeDUmNQKtDB7qkDzgeRFnybg1dfggcsgQFIcZj9tg0vmckyptJr/ftgDQ+nWr9gwJDBefOI6DyOWt9R4dEzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138943; c=relaxed/simple;
	bh=n/TleG8NMo/yMDcgI8l/eb1LaTU01tWaRIBEs6/a5yM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fZUCvxQvvuxz4uOkGNg+fA5Qxq3jB4dafhomcEBoLnfHgi/Drn/K7Dl7ioIvUam6+lwZAMH/o8oHgZCtZGgZq2c9wMwnl/p1Z4o+ARlehGyzeF9T6WXjVht0JVGjNZyMvA3lbfVdAVwNBYNHpdu1nny8yhWk+Q5UmxANGoHXgCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UCtJqW78; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1d14a2c8ca9211f0b2bf0b349165d6e0-20251126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=do/xVjECxk0XCq5r3dtJPN+k1ODOd0A4nEEuScFllus=;
	b=UCtJqW78J+Ku4EOa9+NTNIlSSskgzGs3T9FMi00OJbYCaKXHgJ2Fo7e3xVlf3nuvIpo/HYRC++6ER8hf0K0+/hE00kFvdVg/99MV+VTM89adAyWPin+7HNJ+XjmWgN46SzLCCWAaQ5SSf6e8sUUxtQ+axGP4U3yt424WxErzD34=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b38bfb1b-06bf-4db5-abfb-de23a0124cfc,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:a9d874c,CLOUDID:ad8636bb-0c02-41a0-92a3-94dc7dc7eeca,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1d14a2c8ca9211f0b2bf0b349165d6e0-20251126
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 852544955; Wed, 26 Nov 2025 14:35:35 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 26 Nov 2025 14:35:33 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 26 Nov 2025 14:35:33 +0800
From: Quan Zhou <quan.zhou@mediatek.com>
To: Quan Zhou <quan.zhou@mediatek.com>
CC: <stable@vger.kernel.org>
Subject: [patch] wifi: mt76: mt7925: fix AMPDU state handling in mt7925_tx_check_aggr
Date: Wed, 26 Nov 2025 14:35:28 +0800
Message-ID: <bf6a29cfa16e31e5c2fc2956a294dd8ed97ebd26.1764138361.git.quan.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Previously, the AMPDU state bit for a given TID was set before attempting
to start a BA session, which could result in the AMPDU state being marked
active even if ieee80211_start_tx_ba_session() failed. This patch changes
the logic to only set the AMPDU state bit after successfully starting a BA
session, ensuring proper synchronization between AMPDU state and BA session
status.

This fixes potential issues with aggregation state tracking and improves
compatibility with mac80211 BA session management.

Fixes: 44eb173bdd4f ("wifi: mt76: mt7925: add link handling in mt7925_txwi_free")
Cc: stable@vger.kernel.org

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 871b67101976..80f1d738ec22 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -881,8 +881,9 @@ static void mt7925_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb,
 	else
 		mlink = &msta->deflink;
 
-	if (!test_and_set_bit(tid, &mlink->wcid.ampdu_state))
-		ieee80211_start_tx_ba_session(sta, tid, 0);
+	if (!test_bit(tid, &mlink->wcid.ampdu_state) &&
+	    !ieee80211_start_tx_ba_session(sta, tid, 0))
+		set_bit(tid, &mlink->wcid.ampdu_state);
 }
 
 static bool
-- 
2.45.2


