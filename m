Return-Path: <stable+bounces-210439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 783FFD3BF43
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B905387ABB
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 06:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2679F38F230;
	Tue, 20 Jan 2026 06:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giqAmU8x"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1233389DE4
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890551; cv=none; b=ua71tFQQvwe+/sUd4jJQqBir/pZgnIcMmr0B3pdT7ZTqJ+nl+aI8qJECHmcI5V98KOb+IObC0sKk7D//pJZePqoDK3RB19x0nRY4FRxeVWTeIHUcY/mYMZPEXN2TAG1FNRsU7MCi1yu4jyc6XXzJQWhn9vIhMDY7BkZ3bA4hokw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890551; c=relaxed/simple;
	bh=cJcXyjEZSUQDGUOvvl04ViXnS4Gd51j6mnYPp5zBgFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpBcGD7lMiN+XEErLof3XtMemVOD/X8Jy4L9DIBGX0qtP1wmsLlKg6pzLmrFj9VV/Bb9NBPp1lH7rL6agV3Stxj7TyZxePIojjEEgGhwdG1WKh2NXQouKEkHTbEjOAgfInsCzUR+mX0rHs8nIKJMMJMdPtDGFHgOWHxz4hLT8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giqAmU8x; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b6bf6adc65so4982911eec.0
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 22:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890548; x=1769495348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt1mPPXw8aFoKYpC5Tia09ZY3lzzrV+SydYHdLpjRKk=;
        b=giqAmU8xx9py7oVzsuNrxu3G+ede94Itd42sMGeY5FRQJe/y0gza5szqSxyZNIaeq6
         Zn8Q6INsmYnS4lr0ZD0UM/XtZHnthQurpa+XMncZPuuCINA2XfNvhyw0g1yqJ6k7MOW9
         gB+xCKuVqBk2p9ExMNx9fsLw9TL+stbmOKAfZhFmI2QanKzowPbnBOIZSProq1aeMYhg
         ha1qaclIZJDhsl6RTabzm/tgCqqgd3NuqtTHnQEEdENK5YlXJSvCkb8bevcVE5riDtS5
         bVuCoT24nkploeWbDcXjc3T7pqOLw7ScZ0ufPla3FmeeYV+E9i7WMVGVIYEt9OfYUdO/
         lmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890548; x=1769495348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt1mPPXw8aFoKYpC5Tia09ZY3lzzrV+SydYHdLpjRKk=;
        b=MpXKMyvO+wUv1BLdlM9TtEq9jhzQWcSoICRF1G+z4GqNw3W0MnuOxsjILf3PsI4pCk
         2NBaDaVMvWaMqLO8fHnxQZwIeSS+s2Fwph2QrwF0XOnMKpEx2/qmlNzwA+pJotUj9ljm
         KdayzNKCjM9FMr5kqVAglSezQH9s9fet79XwMkGR5Up32dPoF1lYeOXnarGrH1tQ8hu6
         qyLZSbCq8b1pgb7tJ2++rN0VxqfHcwkSHyVUxOVBsW131VAifnkDXOr6Ju2o2W0xRCqS
         f0M8AkoMKdhp7WpaXXRYSI3SrxHUXPiQLpqQW0rriIpfp8fbSRzJjLwWHP75LwmmseCW
         oU8g==
X-Forwarded-Encrypted: i=1; AJvYcCXw048TufEciNkI5QtTRBjJaw8365JgSLJQd6+9XRxfoFcayVnAB9hwfKRUiAVtUNpG4O69PXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvUl2LkfiDuUjS9A2klg6UwbsnndxxvZIlDfPZbSoj/Uz/bOXj
	68qtVmInjGFwmkAUTiCX9axiDKFJJn1sp/80a3sxUJNS+3S5aFTK6JPE
X-Gm-Gg: AZuq6aLWsHRJGO6SThpNnm7kml8pklnEhLB00cQotghErRYca82Ix1xGWKrkgqC9E2I
	LzzoImuKKSHpnmlrFIzTJztM1F6YGybo8nWGazvEldFpLXxkjKuo5z9HjsBRdC2yl1FnqP+MEqy
	NnF05SF9tH40vneWt69eHfPXWY9teV4GK/EVc/y2tWglpXRp5Hk4a40lhjd3/T84bz/J4VtkuSk
	OOoLbe/ZfYFdm+iuYo4RstWKGp2ytWCvv/dUWgGBXHHbghszdhN8TOOEaRIRuTKong2AH/Qmzxa
	GH9mIdQU09G63oQtugvhOwyUGc9Meev0BPWtSb1rOUpR+gBhEzO+/vEY+6IoGtNGEHIcYDt9s5p
	GrQo3W6wFeorl2rNF+UJWN5Jk0vhhUSnvZ37289WiUY+vURHUrMhAvbZDVevRmbhYqMI5X/Qbza
	Q6HemBzl0yPPkVhYyxCFLRsYuVF1JHlL54UW8TY5AHEc8qNUse8lM/cwoYWOCf
X-Received: by 2002:a05:7300:54d:b0:2a4:3593:ddd9 with SMTP id 5a478bee46e88-2b6b46c69ebmr9563555eec.6.1768890547673;
        Mon, 19 Jan 2026 22:29:07 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:07 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	stable@vger.kernel.org,
	linux@frame.work,
	zbowling@gmail.com,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH 08/11] wifi: mt76: mt7925: add lockdep assertions for mutex verification
Date: Mon, 19 Jan 2026 22:28:51 -0800
Message-ID: <20260120062854.126501-9-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120062854.126501-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260120062854.126501-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Add lockdep_assert_held() calls to critical MCU functions to help catch
mutex violations during development and debugging. This follows the
pattern used in other mt76 drivers (mt7996, mt7915, mt7615).

Functions with new assertions:
- mt7925_mcu_add_bss_info(): Core BSS configuration MCU command
- mt7925_mcu_sta_update(): Station record update MCU command
- mt7925_mcu_uni_bss_ps(): Power save state MCU command

These functions modify firmware state and must be called with the
device mutex held to prevent race conditions. The lockdep assertions
will trigger warnings at runtime if code paths exist that call these
functions without proper mutex protection.

This aids in detecting the class of bugs fixed by patches in this series.

Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 94ec62a4538a..1c58b0be2be4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1532,6 +1532,8 @@ int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
 		},
 	};
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	if (link_conf->vif->type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 
@@ -2047,6 +2049,8 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	struct mt792x_sta *msta;
 	struct mt792x_link_sta *mlink = NULL;
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
@@ -2853,6 +2857,8 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	struct mt792x_link_sta *mlink_bc;
 	struct sk_buff *skb;
 
+	lockdep_assert_held(&dev->mt76.mutex);
+
 	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
 					 MT7925_BSS_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
-- 
2.52.0


