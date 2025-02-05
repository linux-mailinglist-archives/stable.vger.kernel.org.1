Return-Path: <stable+bounces-112646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CACA28DDB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F113A466D
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E991547F2;
	Wed,  5 Feb 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1OoaJxJO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D75CF510;
	Wed,  5 Feb 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738764269; cv=none; b=bsUCinPCsxjJ0xgFWAd9q9AdaWPQiD0BMPxGSOxvQM0gmARWShbT3PeRN145y5ApEM2lFUQr0mGc4KiwSx43MhDNKnILlsLuBj7VCvz+hayONDfAjvLCAXug6Bc03VIaBF29Trd30NeznMhY4alN9BvDNoEyvkrUfPvtaq+o7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738764269; c=relaxed/simple;
	bh=FdLCHGFV8XH1N0ER5Iq4dfV3tfarQ2Qm1RJooELOaPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQrgkoUe/U2FFPEkyufFhrf0/f3EtE8Am/QeWhOZ78SwNyu6rikJSokYXrhFe1uQJepuJ5tjhbjZrHmPlDDzkIPPC5bXtpURFxoHzZeAiCG1BJQZktkUmJVkryelSAedBTUwxsQ+n7ChNgZ1hbO5mQwgOep8faKlG259fGhqj7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1OoaJxJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E360C4CED1;
	Wed,  5 Feb 2025 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738764269;
	bh=FdLCHGFV8XH1N0ER5Iq4dfV3tfarQ2Qm1RJooELOaPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1OoaJxJOqfUFh/5HPOt6Qo0G77XTnGQwqWnUuhslT5z9lZuKX4CQPhlwleP6sNMOA
	 AVa2/28g64UMgUtxDLFjVFRi+w1waI+yLOlGNjs2SdCqBqWoSWzN64W9XLpofNObPm
	 aiH6cC9AM9q1fLCg8DXky/EMohmxk0AxQCe1AdjQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 130/393] wifi: mt76: mt7996: fix ldpc setting
Date: Wed,  5 Feb 2025 14:40:49 +0100
Message-ID: <20250205134425.269838627@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Chiu <chui-hao.chiu@mediatek.com>

[ Upstream commit da8352da1e4f476fdbf549a4efce4f3c618fde3b ]

The non-AP interfaces would not use conf->vht_ldpc so they never set
STA_CAP_VHT_LDPC even if peer-station support LDPC.
Check conf->vht_ldpc only for AP interface.

Without this patch, station only uses BCC to transmit packet in VHT mode.

Fixes: dda423dd65c3 ("wifi: mt76: mt7996: remove mt7996_mcu_beacon_check_caps()")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Link: https://patch.msgid.link/20250114101026.3587702-7-shayne.chen@mediatek.com
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 19afe89fce785..65a5f24e53136 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1723,7 +1723,7 @@ mt7996_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7996_dev *dev,
 			cap |= STA_CAP_VHT_TX_STBC;
 		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_1)
 			cap |= STA_CAP_VHT_RX_STBC;
-		if (vif->bss_conf.vht_ldpc &&
+		if ((vif->type != NL80211_IFTYPE_AP || vif->bss_conf.vht_ldpc) &&
 		    (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
 			cap |= STA_CAP_VHT_LDPC;
 
-- 
2.39.5




