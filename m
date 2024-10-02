Return-Path: <stable+bounces-78775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50798D4ED
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE7FEB21A4F
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349251D0429;
	Wed,  2 Oct 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AFo15Swr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C6F1D0434;
	Wed,  2 Oct 2024 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875495; cv=none; b=pQt9GKVgqn16L0Rj48SMq6oCll1iBYw5gLYso+wvzjLxywoLocwIGEh0mgRN2rM2nXtRoY8DAoJC69oakmHpBsCjDeSyZGYF2+R2S/5Pn70SFS2tOZK2Pmhjbv5Su1y02V/hrXgnUEHXD63uOwRDD9+ZP0doPGyem/OBXlX7AhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875495; c=relaxed/simple;
	bh=nhBw3JTQ03+rmlFxGHWsBrZN0rF4COyaSFgijjQkus8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBzzGQdG5fmnW9S64a87Xto2RsdghoCXq+VKZ9okU5ocwTdW/VpM3NtdKpLYTpVLo6ts8KPOAq4Uw39YIuvSVZm6tfYrsseWvcWbxiE76h1LBv02M20ATQGKtkYKnWdsMovmrWfpGVSSlrlGAVOSIDI8SOs1cJJ8HJAY3sT0IXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AFo15Swr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C47AC4CEC5;
	Wed,  2 Oct 2024 13:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875494;
	bh=nhBw3JTQ03+rmlFxGHWsBrZN0rF4COyaSFgijjQkus8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFo15SwrEysTGMcz3g+dPdW/Tp2JMb5TGrmpaTVcqKh0VYkGiGP4WxruOEql57yZU
	 tur6r9uwC52zuaqJoZlrpUnqTye+mY9qoVRArlQ+Y9NB/qtdYaRXKcPqQThdshaqbc
	 7HKb2FTTN52X2CLoQboExVBF5Awe3Fx5tndPyjyA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 088/695] wifi: mt76: mt7603: fix mixed declarations and code
Date: Wed,  2 Oct 2024 14:51:26 +0200
Message-ID: <20241002125825.993048846@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 9b8d932053b8b45d650360b36f701cf0f9b6470e ]

Move the qid variable declaration further up

Fixes: b473c0e47f04 ("wifi: mt76: mt7603: fix tx queue of loopback packets")
Link: https://patch.msgid.link/20240827093011.18621-1-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index ea017f22fff22..863e5770df51d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -29,7 +29,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	struct ieee80211_sta *sta;
 	struct mt7603_sta *msta;
 	struct mt76_wcid *wcid;
-	u8 tid = 0, hwq = 0;
+	u8 qid, tid = 0, hwq = 0;
 	void *priv;
 	int idx;
 	u32 val;
@@ -57,7 +57,7 @@ mt7603_rx_loopback_skb(struct mt7603_dev *dev, struct sk_buff *skb)
 	if (ieee80211_is_data_qos(hdr->frame_control)) {
 		tid = *ieee80211_get_qos_ctl(hdr) &
 			 IEEE80211_QOS_CTL_TAG1D_MASK;
-		u8 qid = tid_to_ac[tid];
+		qid = tid_to_ac[tid];
 		hwq = wmm_queue_map[qid];
 		skb_set_queue_mapping(skb, qid);
 	} else if (ieee80211_is_data(hdr->frame_control)) {
-- 
2.43.0




