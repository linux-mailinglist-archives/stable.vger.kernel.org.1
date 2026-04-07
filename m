Return-Path: <stable+bounces-233472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIsRE1ZN1GnvsgcAu9opvQ
	(envelope-from <stable+bounces-233472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:18:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1443A8685
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5FEA3098E73
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 00:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C721A317D;
	Tue,  7 Apr 2026 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1IryfIF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0899D1A0BF1
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520969; cv=none; b=nSGo8siSe96b6VPHbyBIXyUhblOJ641Bfw+PVlK15noUycnkWFR8qO1URwyQF3Plv3Or9QwHhkf6vTn0yFcQiHxFGwZEE777z3EbEGYMo4b55Aqfb4MudQVf0l8CkBLLcYeG3prdnTziVz0IrOkMkWQ9kH4YnwLEU/bD9R42YsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520969; c=relaxed/simple;
	bh=LfkYvGNeVcUMPzu6EUpovhxxAgmTZnYfYq+C8OGymRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQn5JFtI8fhe89QuTSdcbVg6VNpacnUjPHEITnN9svG+EYQK3rveA/Gc/nTfxKl/tyTOYW4baFzMlQF1TAK28G5/BETBf1Rnay13AWbYFrxf3+XYqJZ2Om5CJdnF4O/RhZo7/GEpaI6Xkkuj3Ap14YfUK2yDZ+UN22K5ct3jKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1IryfIF; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6501c9903edso4345051d50.1
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 17:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775520967; x=1776125767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFQLJBb/lmxRWKB/kx5iZa1pg9O2vzapGfay6oRBkO0=;
        b=n1IryfIFiR0hQp5Lgkw7I+X4jRXY1eIajpiyQYEKLgTMfNUP97iHJC2+teAqhcObIy
         t2n5vXFJAzpeN2+PquAjxsVcCa8laE54lKZxKdMz+CZEaonfcTE4xTL3RPVG0Fv2jFS9
         ZnSyIJRZN48LPNywfCadM2BKlPjJAQIe+PQ0zi/CwxZYDy1PUSEM8dJG0lcBgsOa0hFW
         OHCiebc5HyT7P2IK9upx5NbJknz0zC6f0EN7rPSQPzGIT37xwh9IdCryhhmn32Yh2ImS
         j/etsFpKuKMLklxI/oI+mlf6KjfXF3c8ZOu6kCxjpvJw01fjcIJzDT3a9vLzNbj/ysuV
         uQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775520967; x=1776125767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xFQLJBb/lmxRWKB/kx5iZa1pg9O2vzapGfay6oRBkO0=;
        b=OmZzHQzMMBsM3BDm/3gh9HC0bG3rVnCcEtAHX98WS/m5/MJxRiW6+tIPOq4k+Uu5Kg
         oZkvLd09i9BgjWf+l6NGbZt3QucFDDaXN7PVuNzLPNX+4YY06lv5Auk9O7bkH9XykMFV
         JZs51GaAfwLfeHlXmbiws75Xu1FHbiJSvEFb3U9BDKB6bsCfx6BG2aftLOqHo3Wq0RuK
         8P4r97yo75EkUGZzH1ka0fUOBaZKkfS5Bi1xpwXRjTIMRaLC36JsBbmvvAyZeOlf5Hea
         KtB7coWXrD80e8+yUapR7xwGN1pRS4vrtkvRuq7FFROTuSeaxHxzP1X7Gh1524jrtrhW
         RUgg==
X-Forwarded-Encrypted: i=1; AJvYcCUFr3I+GAaHaVc7g6vdgxEHypQpY/MQITyel6T1xrCSDKakq+orPmZFmWHhfF0h1cJeOR6F6Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPHpUMpCw2M7Rs5gdi05+zz0EnSoV9w7ou/B2iyfYYOh2juFu8
	m5W2SIvNJsitwa9BMfbtOrIbbrrEvuzLi++OjEUTKM6MRFOaKOdPai3d
X-Gm-Gg: AeBDietZcf5k0OPxcWl7E3NIT8io6FlznSA2D3bJggve0p+PStpJAOEbePYUnq+0nk6
	rCwRCdpYeQMR10w0RrrenEEt5+ZoHrP7wGc9aM6sVmiHElryJmT3s3AOySNijfMta3dHW6YPPy0
	kMLXC5M8L3wZzZLIuD5o3gJbePaGR2kzRwlykK8PqohMRoKRqF37fdqodJWjohwVhUAf7Vqk2m2
	uTGPfLdv/meBE6uBnHCxWZZvreChU8rIOH6V3GTMf0mPvWHdBihs0SNpdatqnVbspsrBft07gnS
	daMnDpt/aYJAwGJSZfsu0xTk9GT+m9/0XJTKnZFedT20qBLD9i+K0Qhopvog4PwsSAaGyoukYFi
	CpEfVRsAv0N4FZoe5+nYoRTPItQCU/AYkS+7sIXnouUR5W7c2dpMIzQudxnzD4J5XI2bCtYFTCD
	jCJsJIcZ+vlVY/0urGgLGLt/8LjyA1qke3fSqhpT+Pht4E0GYVIw4zPMhIToiu
X-Received: by 2002:a05:690e:d49:b0:650:37e7:e590 with SMTP id 956f58d0204a3-6504869b126mr13770674d50.15.1775520966993;
        Mon, 06 Apr 2026 17:16:06 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9d50afsm6698649d50.19.2026.04.06.17.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:16:06 -0700 (PDT)
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
Subject: [PATCH wireless v2 2/4] wifi: mt76: mt7996: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 20:15:58 -0400
Message-ID: <20260407001600.31234-3-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233472-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB1443A8685
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

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index d4f3ee943b..a0342012e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -205,7 +205,7 @@ static void mt7996_mac_sta_poll(struct mt7996_dev *dev)
 		rssi[0] = to_rssi(GENMASK(7, 0), val);
 		rssi[1] = to_rssi(GENMASK(15, 8), val);
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
-		rssi[3] = to_rssi(GENMASK(31, 14), val);
+		rssi[3] = to_rssi(GENMASK(31, 24), val);
 
 		mlink = rcu_dereference(msta->vif->mt76.link[wcid->link_id]);
 		if (mlink) {
-- 
2.43.0


