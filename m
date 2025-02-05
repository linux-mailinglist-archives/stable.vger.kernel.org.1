Return-Path: <stable+bounces-112878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DFFA28EDB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C83D1889DB0
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE21814F136;
	Wed,  5 Feb 2025 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B5ASc4e8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8EB8634E;
	Wed,  5 Feb 2025 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765060; cv=none; b=hhyw2q8AviEVvZADHsgktgVa83KBCogg8q44QxhnPiS/Fz6xUyGGT3aPhqcMOVpoTRdWGyrGSsgwrEnb3xAD4P+sAKnucwczj6yeTaaVEE92JMb6sDYn5pr/8mi2m17D8ubqZiTtp8LOOWSoDFSmSRQ0O3RM8fL+qrksJ1Nj9Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765060; c=relaxed/simple;
	bh=5m5lbgowlpt1QH7Z3WEFuYfBjEw/dHBTXXcGSxyBslA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clYAcouW8rxM2ancWlk0Tr16woyaumjOLQ2+DZxz9ric0RNaQ7k7XGXwEopC892Rk7KvzBaAKZjdIA6BgbS5/gB6asTdoZiL1pk6munXfmO1WVifQuCp5qvmVu8z7pc+UixTZcEcQelLl7C0HNdHCH+DFyxrsNeXzd24aZ/bYwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B5ASc4e8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74E7C4CED1;
	Wed,  5 Feb 2025 14:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738765060;
	bh=5m5lbgowlpt1QH7Z3WEFuYfBjEw/dHBTXXcGSxyBslA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5ASc4e8TId27UZ+Fzdt5BV2fiFi1fWpCD0ZSI4kosMJjZy2GyqThkX+8RLtUWBx3
	 SUorhURXHlDZJqi1lwPlqwK4ajPsgp9ryMT1M7nJogGt+vh12S0DvyrhR8A0Hy04+e
	 1/JOLcT94iuAzBw99q8ABwRUsDJefWZ0KmyyWBGA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leon Yen <leon.yen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 186/590] wifi: mt76: mt7925: Fix CNM Timeout with Single Active Link in MLO
Date: Wed,  5 Feb 2025 14:39:01 +0100
Message-ID: <20250205134502.395852977@linuxfoundation.org>
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

From: Leon Yen <leon.yen@mediatek.com>

[ Upstream commit 4a596010b246816d7589d8d775b83833a59e63f9 ]

Fix CNM command timeout issue when only a single active link is available
during MLO connection to fix the following kernel log error.

[  741.931030] wlan0: [link 1] local address be:90:e0:22:c4:22, AP link address 08:0c:43:7a:19:2a
[  741.931042] wlan0: [link 1] determined AP 08:0c:43:7a:19:2a to be EHT
[  741.931052] wlan0: [link 1] connecting with EHT mode, max bandwidth 160 MHz
[  741.931071] wlan0: WMM AC=0 acm=0 aifs=2 cWmin=3 cWmax=7 txop=47 uapsd=0, downgraded=0
[  741.931076] wlan0: WMM AC=1 acm=0 aifs=2 cWmin=7 cWmax=15 txop=94 uapsd=0, downgraded=0
[  741.931080] wlan0: WMM AC=2 acm=0 aifs=3 cWmin=15 cWmax=1023 txop=0 uapsd=0, downgraded=0
[  741.931085] wlan0: WMM AC=3 acm=0 aifs=7 cWmin=15 cWmax=1023 txop=0 uapsd=0, downgraded=0
[  741.931095] wlan0: moving STA 22:0c:43:7a:19:2a to state 3
[  749.090928] mt7925e 0000:2b:00.0: Message 00020002 (seq 15) timeout
[  752.162972] mt7925e 0000:2b:00.0: Message 00020003 (seq 1) timeout
[  755.234975] mt7925e 0000:2b:00.0: Message 00020002 (seq 2) timeout
[  758.306971] mt7925e 0000:2b:00.0: Message 00020004 (seq 3) timeout

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Link: https://patch.msgid.link/20241211011926.5002-7-sean.wang@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 23d0b1d97956e..60a12b0e45ee6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1151,7 +1151,12 @@ int mt7925_mcu_set_mlo_roc(struct mt792x_bss_conf *mconf, u16 sel_links,
 			u8 rsv[4];
 		} __packed hdr;
 		struct roc_acquire_tlv roc[2];
-	} __packed req;
+	} __packed req = {
+			.roc[0].tag = cpu_to_le16(UNI_ROC_NUM),
+			.roc[0].len = cpu_to_le16(sizeof(struct roc_acquire_tlv)),
+			.roc[1].tag = cpu_to_le16(UNI_ROC_NUM),
+			.roc[1].len = cpu_to_le16(sizeof(struct roc_acquire_tlv))
+	};
 
 	if (!mconf || hweight16(vif->valid_links) < 2 ||
 	    hweight16(sel_links) != 2)
-- 
2.39.5




