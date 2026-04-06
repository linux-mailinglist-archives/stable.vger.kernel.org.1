Return-Path: <stable+bounces-233463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N+7NWpF1GnVsQcAu9opvQ
	(envelope-from <stable+bounces-233463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:44:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 807ED3A8460
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 01:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFBF43052A02
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 23:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A613A168D;
	Mon,  6 Apr 2026 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNJkitIb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A5324718
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775518993; cv=none; b=I8ifBETpBXPFMIGY7RQLa+3RVG3gqee46a+STv7yPQ11yh2FE1PT/PPgaCe9nBcjCpggL3P7d8AQV5ECKJWNk2OdvPFfUn2B9Dd+q9wqNKYxd58fyyRntTvnXHMxu0dBjeHCUySFBPdnvajVC2AiCJTcwTG3vKXYtCWVjrIemxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775518993; c=relaxed/simple;
	bh=5AFQSaFmab0W60GDHchwkX6lsxFVStzDQSBUV0l8xYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QOJIxm6MipBg5y3hL+aBYvKizw7SqnAC9QEPfCKcJJngRsatP798ZnpMvBhEFlBYpbmYk/eCVhRzRxGUlXbSyiV7fb6XM6p8W+ybh/rya1Dr91Vk+280jZpZBjCWRuwVrOcT5Ne/V9VbCEdynsowyS7XWxqzHZcJtddVhoKx+14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNJkitIb; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7982c3b7dfcso39136437b3.0
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 16:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775518991; x=1776123791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhhW2JtmFLuaeAr//pW9N+0QVOgFVlmDgosFHmJ4lDI=;
        b=MNJkitIbQPwTE7KE87sBkEbywAsqEbNN4ixjlHRGqEI7SoFYtl0PUmwAgXmX8L1L/3
         gEPvr0Ep9MwyQkLSHkIELkdw76xcIDDqBpIYZDwawOAwq7NGtjL35Ls/pDPSBcY/yNe5
         gxo0YVaQky2i3tQir7lOhdfR/psTbRe4O6N0mbbGcr/X+eSvJR0NZZKIgKt2o6uko6UJ
         3Matr5juqyhcBP6ExBmOF/fEj0sUZSxgy6y+qCIDdCmUUS8gqy4Vbf2gnDBTFGZEklRr
         /DuIEtcVjYOAae+b/Pv2mu1Ha6gn++5WB3vAsFaTVnp7JfwwizySNPBh2JteF/qY5/ad
         ORgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775518991; x=1776123791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhhW2JtmFLuaeAr//pW9N+0QVOgFVlmDgosFHmJ4lDI=;
        b=m4FgBlMDWgFzdQ+LgvGh4DaB4UzLlrytFTuZt79hi4PL4Qxyje1y95DSDvPPODRjf3
         v2WEyY+ArxpuzshO3Rcl/NtH/8jRPgNlOLPCjsH1GV2fUplWbTcsDbB5bG2hwjIFJI2Y
         qLkrv9YF+atGSQLue3zJXrzNH0RTGUeelASui3AvtmtYpX/jUhqsBQCFGfLQVZFdYotw
         vAig6efBOHcyRYmX3XQS0fZZCIU7M1hxeuG6OT28pG8Iw8D1SSfca/0mL6yWXvCcRpli
         PTzvRTTvLuppingLT+G4lfwgdrU6u7Br+uyZsmY5MrlcSHlhYllbrCpxk0oReojZDNbU
         BAoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1sm7YDfXoB6ZOnebU0E2a2FlaSLyUMNsFOU7tgVcJPx0H2v2JZsV/BIlDH50RbVsBiyhv9U4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2oJOuQ5wB7Fkb6xgtCGhZ05ealEJa+13xtx3wLrxYVBkMeTPn
	V3/erLvDS7VQeGrR7leWSwu9Wk5SI0eJa7A/7vSJg1VVv4yPfQoviSxa
X-Gm-Gg: AeBDieujWR5nwK4c/XPIiMH/eOdFCzM1yCwdp+ia3b8RMqB35aP0l3hcxPvwova8hZe
	QbjcsrvXtvI+Et1gV+/nSlVB+zDAQjbE4U4hGEIwjwlTq+7IrylkI+5MFNsOWicKalpvD/bKv5G
	Ba38CHxWlE2wvKRdmXahSAf52oiZbP3naGPACu64lM8yxDSaICw00RHmIYA10YkiybpkZmNEGBr
	Wz7xVsjvL/BjDIRnY+t36Dvvyf41tE1+I8jOULxbQbj/UgJLBLUNbJFeR9Sr3mLBTZCyzW8KPBw
	13wDwabzLry18Gfz1WgXpMhnhjkQexptbpWCayBYljX1XzSiXyIWwH5B3kD306hfz8cnrPVkIiC
	zT3MbObLmyM7lqemZkhFuQYZ24TRpvGm2Pj2ED+kAnCA2j62cPoJKA1WsnI/d8DqKzg3mzv1G6J
	pn7ueskdrMj5//CMFuIvLf9qLSgEU85lA5gr7VaEUItVFzJVPDNlVr7i4QBfs/
X-Received: by 2002:a05:690c:e3ef:b0:79d:bb7:54da with SMTP id 00721157ae682-7a4d5d540bbmr156205827b3.41.1775518990749;
        Mon, 06 Apr 2026 16:43:10 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370df16aasm59144037b3.40.2026.04.06.16.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 16:43:10 -0700 (PDT)
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
Subject: [PATCH wireless 1/2] wifi: mt76: mt7915: clear cipher state on key removal for WED offload
Date: Mon,  6 Apr 2026 19:42:03 -0400
Message-ID: <20260406234205.29857-2-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406234205.29857-1-joshuaklinesmith@gmail.com>
References: <20260406234205.29857-1-joshuaklinesmith@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233463-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 807ED3A8460
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When switching from WPA-PSK/SAE to open/no encryption, the
DISABLE_KEY path never resets mvif->mt76.cipher back to zero.
The stale cipher value is sent to the WA firmware via BSS_INFO
updates, causing the firmware to keep the protection bit set on
WED-offloaded packets. The hardware then drops all plaintext
frames, resulting in zero throughput.

Reset mvif->mt76.cipher to zero and notify the firmware via
mt7915_mcu_add_bss_info() when the last group key is removed.

Fixes: 3fd2dbd6a1d3 ("mt76: mt7915: update bss_info with cipher after setting the group key")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index fe0639c14b..8d32729a58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -414,7 +414,11 @@ static int mt7915_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	} else {
 		if (idx == *wcid_keyidx)
 			*wcid_keyidx = -1;
-		goto out;
+
+		if (!sta && mvif->mt76.cipher) {
+			mvif->mt76.cipher = 0;
+			mt7915_mcu_add_bss_info(phy, vif, true);
+		}
 	}
 
 	mt76_wcid_key_setup(&dev->mt76, wcid, key);
@@ -486,10 +490,6 @@ static int mt7915_config(struct ieee80211_hw *hw, int radio_idx,
 		if (!enabled) {
 			rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
 			dev->monitor_mask &= ~BIT(band);
-		} else {
-			rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
-			dev->monitor_mask |= BIT(band);
-		}
 
 		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
 			       enabled);
@@ -1166,10 +1166,6 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 	if (txrate->legacy || txrate->flags) {
 		if (txrate->legacy) {
 			sinfo->txrate.legacy = txrate->legacy;
-		} else {
-			sinfo->txrate.mcs = txrate->mcs;
-			sinfo->txrate.nss = txrate->nss;
-			sinfo->txrate.bw = txrate->bw;
 			sinfo->txrate.he_gi = txrate->he_gi;
 			sinfo->txrate.he_dcm = txrate->he_dcm;
 			sinfo->txrate.he_ru_alloc = txrate->he_ru_alloc;
-- 
2.43.0


