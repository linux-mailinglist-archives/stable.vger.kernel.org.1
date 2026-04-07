Return-Path: <stable+bounces-233471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MtTBi5N1GnvsgcAu9opvQ
	(envelope-from <stable+bounces-233471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:17:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D2C3A866E
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 556A3307C2FE
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 00:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6021ACED5;
	Tue,  7 Apr 2026 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDNtDDiM"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD79927707
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 00:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520968; cv=none; b=PIROc01VIlhAJrhTVf8RUTMOhgXxqivxBs9qRQqRb5em/bz97uyLaS4+mePSFxZpZVUHkawQzAwhx3lLv8AT9FlawfEPI3o2WIIHmk0ogstXXLfbx49FcmOKHOpHsb20iEVtFoHaOkfPq98j4MR+a7nb+erb1OjUylz9+OBtz8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520968; c=relaxed/simple;
	bh=+50rzGhBt4ishhKokCcSA1l9V0TX9Tak+B9Pgz58g80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CR4SwlPBFikahB/TTyCLjK9+BU0vNRtuOoQtevXWRGoqX/QVPo/GsttWtN6Po1qNEgVqpxLOAveWkr1mRndKqFTSSrPm8yLLRivehuxoFJZVsvaN2L6+fXreFS8wmbvpU92I8Yh0FLKqLUB3xKB7IoSLS3oAypCHXPfullcHM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDNtDDiM; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6501c9903edso4345029d50.1
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 17:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775520966; x=1776125766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l12nMVHZLcuAdmgVWy1G8JLewfzqeYRmAf+JAzu/Tc=;
        b=GDNtDDiMUUpnqJylFJIDfNUrUR6J0Mx+5K48C/JLyaW50IZQ8rxADj7Eoxe1n0dZBQ
         hDkLIVwtO4goLWDlWuIKv0mXUcqNEn8A5huMeIHlP5XLyCrvCObJTF2HKv00xJBv/waY
         BhDOUxJi8bgHAar8Zp+6CxVw2S7+i/V/a9g99zJ99O3lXDodPhO6qF2BtThoIAXLFNTV
         u/T5gykwA5DaNrbnNYTLzphoEGwSjOKSkB6BM7ATpo1kRiJuXVlmKVYt+MmmAJ19Kfjj
         SieqwXeUhaCzIwVFkqO7yuYXILLYLOIdKKE/MaKBt/xjsBFlpO4rDmuvX3tTwS3MyBJ6
         BLRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775520966; x=1776125766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5l12nMVHZLcuAdmgVWy1G8JLewfzqeYRmAf+JAzu/Tc=;
        b=egPr9TWtGNryTr5LH/ovUozt1gjE1Geg8dVCdI0JKFG0SOTXMbV0GjsDwIIj1nHicg
         QuJ32Wt34pNd0NcejKwNxttf5er7UpkS/P1FQ/fQXB7FfxDKB8UNTIM58U99D10rgSvO
         7MUDzCUz0ba1bkwVhBRiupdiE7IZKJfwfSZl8i8WPW21dMGtrctCsk8OdB2LQjlsxS+N
         SJEFrZNQ6qfWIxEKQZy8yEqgN8Ciso5g4Le9rAYyb17MWdWt/XXdTTtRSg12QoyvgkxD
         avns4F1y1ZMI1qmFZU51uUoL5q5/+RP1mXMrCEoXc5UecxP4to+y0qOwdxmXcIbneYU2
         5aSg==
X-Forwarded-Encrypted: i=1; AJvYcCVOUQU01w7YDgrDjk8e9wQ/grYaZfPoLHlvEaJXvoWU6Mt1v5gNFp8+9JRSEn3ujBKAXY13ob4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydek1SjtwDpfFG13Gkg3agb8Kyid3P+Q9raVTsHMeB+u9vwCIz
	IttzsakgO1ElFqkZ4puZoziJTu7lO73R5HKzsyREQTEd74/V8R9uj81G
X-Gm-Gg: AeBDievZSHl4WERRbTJ43k3Vci9kj2AhOlkALvwweUZeGl4HdnxQ6PYWz1QvpI0eTmY
	IMXlj7K2gExteYTn4j5zGSWX4jCWWYMNn5mpk5Cs4vup3jjA4i2noKmsHb6PWVpj69i7oszXOcB
	3k3pj1tu3JFxbfZcg0dpLsXIpa3fZ8BrTBmQ2vwcbvzTHXDfGa/S7slvMOjPe37lOPpPrhPGMND
	o0fMiQ1uUguNB3EncRG87Ts0Uuxhvn4Au0hLMy6agNxe5O97CFKaPRUD5YWcFe+ij68pynNEGSN
	ykUTzwibHdtsCZjSfiZPYE/MnIbzF2zq6u5ZTwLV3bTPSGkgF8g6zHlwqbA8zYErKbHQCF8RCQl
	WckyTposx7mLeHNzVWdX2PUJ2bLv6Mjiktdtwi2xCGKiOArZXzdOA3cVS/NpCrOq+5G4w2F2OEp
	IKMSs0dhLSDBNQV2maEKfoKawfohi8ULI2cF312wIXjgYR9y8JwVOtfN5mxFs8
X-Received: by 2002:a05:690e:128c:b0:650:747d:f70f with SMTP id 956f58d0204a3-650747df9a4mr3030565d50.66.1775520965820;
        Mon, 06 Apr 2026 17:16:05 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9d50afsm6698649d50.19.2026.04.06.17.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:16:05 -0700 (PDT)
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	Joshua Klinesmith <joshuaklinesmith@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH wireless v2 1/4] wifi: mt76: mt7915: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 20:15:57 -0400
Message-ID: <20260407001600.31234-2-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407001600.31234-1-joshuaklinesmith@gmail.com>
References: <20260407001600.31234-1-joshuaklinesmith@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233471-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70D2C3A866E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The fourth receive chain RCPI uses GENMASK(31, 14), an 18-bit mask
spanning bits 14-31. It should be GENMASK(31, 24), an 8-bit mask
for the fourth byte, consistent with the other three chains and
with the RCPI3 definitions used elsewhere in the driver
(MT_PRXV_RCPI3 and MT_TXS7_F0_RCPI_3 both use GENMASK(31, 24)).

On devices with fewer than 4 antenna chains, the corrupted value
is masked out by antenna_mask in mt76_rx_signal(). On 4-chain
devices, this produces incorrect ACK signal strength readings.

Fixes: e57b7901469f ("mt76: add mac80211 driver for MT7915 PCIe-based chipsets")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cefe56c057..cf72b38c85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -221,7 +221,7 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		rssi[0] = to_rssi(GENMASK(7, 0), val);
 		rssi[1] = to_rssi(GENMASK(15, 8), val);
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
-		rssi[3] = to_rssi(GENMASK(31, 14), val);
+		rssi[3] = to_rssi(GENMASK(31, 24), val);
 
 		msta->ack_signal =
 			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
-- 
2.43.0


