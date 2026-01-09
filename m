Return-Path: <stable+bounces-206668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7BD093FE
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD6EE30146F2
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 11:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AD1335561;
	Fri,  9 Jan 2026 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HkcogKvD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D432FA3D;
	Fri,  9 Jan 2026 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959860; cv=none; b=lqgn9M1XNH5UAKd06gMFIKTa+58n+bA8SziCNigjAHCNMYTFdqTDdF40hstC9rqftIbl/g6Qf47AR8LWiWajCp8yzBumuD4KSurHUtB3epvx4UK128+NeOTs0Z61Zh9s8N1ShO/g9YCqL8foWSAolhpWmHIOPSbbP15lqTWO9hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959860; c=relaxed/simple;
	bh=zcfEb7tqNsmN1kd9hRrjBR4naFhTrU+/ACovy1MVYfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sqxOUhiq/QRJ/lmukyi/WXy9dy5yF00gZ2PR51yQarLu/WKPdoJDmoRxVPjMipBnRYFnRV2b9ARC3RzClRTW+trPi3R15zNRcXave1i1YGssiyJB2pypTXhaR/qS98UQ0YnuLRqpSHaGGSN+ohfhJ8OAIc0TcwmurLHXg/mOm9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HkcogKvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879CFC4CEF1;
	Fri,  9 Jan 2026 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767959859;
	bh=zcfEb7tqNsmN1kd9hRrjBR4naFhTrU+/ACovy1MVYfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkcogKvDgbMfvPji7HtYaqM57Fqmkhg4GRypBT+FMZaprCAQEMrovri2mTxcAvwHi
	 q9FL3JJIy20KbvEEpOejkYIU/bWNmyOMrxf/pVU45yE7TwPnyQ6xgvJ8cbQexVg6pP
	 beQefON5X4m6tJVJ4h9zR55Y/nx+UDPyzOgxdc9Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 200/737] mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_add()
Date: Fri,  9 Jan 2026 12:35:39 +0100
Message-ID: <20260109112141.526400146@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
References: <20260109112133.973195406@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 53d1548612670aa8b5d89745116cc33d9d172863 ]

In mt7615_mcu_wtbl_sta_add(), an skb sskb is allocated. If the
subsequent call to mt76_connac_mcu_alloc_wtbl_req() fails, the function
returns an error without freeing sskb, leading to a memory leak.

Fix this by calling dev_kfree_skb() on sskb in the error handling path
to ensure it is properly released.

Fixes: 99c457d902cf9 ("mt76: mt7615: move mt7615_mcu_set_bmc to mt7615_mcu_ops")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20251113062415.103611-1-zilin@seu.edu.cn
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e92040616a1f3..94adb22f8570f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -870,8 +870,10 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
 						  WTBL_RESET_AND_SET, NULL,
 						  &wskb);
-	if (IS_ERR(wtbl_hdr))
+	if (IS_ERR(wtbl_hdr)) {
+		dev_kfree_skb(sskb);
 		return PTR_ERR(wtbl_hdr);
+	}
 
 	if (enable) {
 		mt76_connac_mcu_wtbl_generic_tlv(&dev->mt76, wskb, vif, sta,
-- 
2.51.0




