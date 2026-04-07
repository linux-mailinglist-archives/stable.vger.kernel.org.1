Return-Path: <stable+bounces-233473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CagHYpN1GnvsgcAu9opvQ
	(envelope-from <stable+bounces-233473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:19:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFF83A86A2
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74B6430D6E27
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 00:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB672617;
	Tue,  7 Apr 2026 00:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjVTSiGE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1741CAA7D
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520971; cv=none; b=bo5uUiqjrtWTjUCx8FnYq7W0BcxiKk/YdEeiJ0XziUc8JYhHhG4XhREyWTKCn0xCTpaPKss4AjmUCADRurzvxHM3Xd9Shx74QcRxvlD0lXzPHVfthliC5ZEbegDZjhaGFMsGO6w+VRPQeDHmNGZoPX/D186MhNjD9op2vkCftvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520971; c=relaxed/simple;
	bh=Nysgk0uciCPiocl22DBJxD3R6NfAICtbGv+6Cp+q9CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Er6+vn76wGr75ct3PeSPcpFSB0xWFkS1VJL93Pm/xNeHt8FTxymr9eqyVjGEoFVs7Swow615qG8CNRju+kiwhwmBdPEJ7bgq5htBt4FuU9uE96Ca7Yn/UXeGYbtQWtUX9ItIFwA81ZyVyhxeSQxtAGwZrBM0XbsmhVotQ2VdVvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjVTSiGE; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6501547d7edso4488046d50.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 17:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775520968; x=1776125768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRqvQs6ivSDyEsQUNGAHXVReKeGYQz/kj2ZPLDDhbBc=;
        b=VjVTSiGEHwbxRA3LxPdMPj4UFxQca60eFzukPMNGNEuMZvCEtoqFV4w+iXHUr5X7Eg
         FVXz4/ailyp5Glbqx3IaNG+URZsbnX/B6xGmFaYPB0jhi7kCnGX59svnJyqiUE3dtyeR
         YMALRVMq3Rcv4s2pJjAn7QR2dRf2x68IcBN07fs2o5ZI24hpdgDW9bU4Mr4LSjXM5gdu
         pkvvK4rwtRMz/eImO/pM1GjV0+HhBypz0Lam4xoJdIl2N4JfALfx0sFjkGO2eer6k8BT
         /YozR5ilZKa+P2GJe8xzAgecEmrgrO/CP5+XQASgs1kJsJdaRPp/0UL8hcIctn+6Pqdv
         LjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775520968; x=1776125768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRqvQs6ivSDyEsQUNGAHXVReKeGYQz/kj2ZPLDDhbBc=;
        b=d3spFdSxkzh1pO4z9dir4bC6gsqLvuhypmqBZKD+4bdE9XgdQ8j+wreJCibPvin37a
         B/voHXoocgZsa+D20I5fZ0wAnORGuQqXRqHrZiHE09IBBeaV3z6KQew6Y2TLX0gGVfmq
         RX+ZiYwLcigYcg7SabBs89ByYmvWLXB46trfDD5XkU9Q95cV8TiN+KUpvIWdmMe/kOi2
         owvW9uu5f8afd104ZI/84nbqgaMkVxSoFau4+yqcX9FdwX7xpr6nht9vsIEgKaFadZaH
         Kr0YpgiKPBB0zWh0DoUcKNAuenBiU3l4OSreIGTQneJs5B6VLL2Gzk3+AmU3xo9Il0H3
         7T6g==
X-Forwarded-Encrypted: i=1; AJvYcCU9KWS5SmQoBOKDa0rfa9fwfntyxXGB47MA5sw9xnzvzzrga2GdZu6/+JgbDigZsX1m8xs3HkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyitcFJb/LGMdo8DG5WWdMgW4Hzx3VZfRsPinl8s2wI2WvSegqQ
	P0TtUsXgu8lu3EryAj3u158ICOxQZ/Fnf5c5E6BiF2hxP7fdrnQwm34R
X-Gm-Gg: AeBDietIQHuI62L4qAgmEcJ79ZzFy2qyr3h3tyJMWUOD+HjsGe8oAazMC5ljcBbQ9IC
	D6kvHGHOPuzbBIbSVFZIMDx3r1P7pif3ZUk7XhhvkGFB10Gt0Y/Xjqwb/vOhf765dw3iHA4+db1
	BHF1zpjyQBi5GdCvCyo/yf0/Y/peVPYE/bfX5RsLdWvm8d4g/eH/EholpvcxjhWe2sJeothJ9MV
	Z2HWSQNIRniQlC2MDyx/78urzp4syyP//aDawr07psCeNhrUMM60BT1y25ZXFYFjIU7KyZa8/Ve
	9x5R/xHLiq51hE31fOxJJ+3/jDmeCM55tcCZH8LU1Edu/GqveIAwU6kzk3IwFDMSZUUHA9tu0+C
	W25F4HaI6azw31SE3oPynCRWOS2d589IiJSuHGK948+fHYdl01lQ2IUj1f60dMDr2L3pErr0iK+
	bSqiMKq9Qtc0HDqqmxBu51NiS8q61n3VzbA7rP+BBCGb7uRy21U+RScqDDKI4P
X-Received: by 2002:a05:690e:1302:b0:650:f54:69f4 with SMTP id 956f58d0204a3-650486bf223mr14232730d50.13.1775520968649;
        Mon, 06 Apr 2026 17:16:08 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9d50afsm6698649d50.19.2026.04.06.17.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:16:08 -0700 (PDT)
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
Subject: [PATCH wireless v2 3/4] wifi: mt76: mt7921: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 20:15:59 -0400
Message-ID: <20260407001600.31234-4-joshuaklinesmith@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-233473-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: CFFF83A86A2
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

Fixes: 163f4d22c118 ("mt76: mt7921: add MAC support")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 03b4960db7..fa5631b879 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -155,7 +155,7 @@ static void mt7921_mac_sta_poll(struct mt792x_dev *dev)
 		rssi[0] = to_rssi(GENMASK(7, 0), val);
 		rssi[1] = to_rssi(GENMASK(15, 8), val);
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
-		rssi[3] = to_rssi(GENMASK(31, 14), val);
+		rssi[3] = to_rssi(GENMASK(31, 24), val);
 
 		mlink->ack_signal =
 			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
-- 
2.43.0


