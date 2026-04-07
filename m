Return-Path: <stable+bounces-233470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEkULNxM1GnvsgcAu9opvQ
	(envelope-from <stable+bounces-233470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:16:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C1A3A8642
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B9B13057D60
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 00:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93951C8604;
	Tue,  7 Apr 2026 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuJ7lmTn"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058C219C542
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520946; cv=none; b=habigtFy6TKNh4Ip8nTyl30Dj/4EZDSwlYoAFV2Hqe+QCBds7F9xYxZhv+jLqjj6i/yBzd/yci8/UNDjrc1eP0aJ1a02LGDPyqra2x6O3kPU7qEGiWbFxxV9scvp7/XUSkm7cKvMOpzuIIhH/wpkVYTOS2gJ+EvgdShfyIpNOik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520946; c=relaxed/simple;
	bh=WYY0327PGP6EmPVdxZ/UKxYSGwk28K0MY8yfuwYdQVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfYog6YB3ARMy2eTAzTknvPPioJYz9GUpk0Abet/yZK82MsbsvS1BeaOOqMasYXFBRdYOUDeyIQE4Jy8d59AUP2grCMKUGNu4f+9nTyacpPK5Hzl15haubwRIR/PG3Ofep9XwkyhKq1PvMFG+m7HS1DTHDvryjyic6nP0Tjd6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuJ7lmTn; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fc4425b6bso41361107b3.1
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 17:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775520944; x=1776125744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ax4QSQrnjy0pjzWmEl9UqqUoL/S+ZOGYtKORago0N/M=;
        b=CuJ7lmTnjhy+m9/mkw2aTco/SkBdUZOQiUdXZ6YHNvwOsqNeSvdiUI71bwrZVoawNC
         yyRDffyz6rW252tJ2O45y7026JjbpaYGAsScNucs/Jq2BqZSBEURh7Qle0df2tkNy3TH
         UFB1BE56irV7pQeOr023G0fCOy1Iq30rL7gXSyn8LaoZiRWtozUripc+5qxtWY+jEnBD
         vl6ejClo5VpcmG2XcxzghZFdDASRYm3zXLzGQUC4shAwIDO/RPq4k9QQ6eWx9b5/WBqP
         WcBWqtz+yre751MPyyWq7kL6tYt0o0GF3tQaI1E3PLra6z3Zei8hCWLBlMCsie2mVJ4m
         H0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775520944; x=1776125744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ax4QSQrnjy0pjzWmEl9UqqUoL/S+ZOGYtKORago0N/M=;
        b=E/ZiCbytUJXkY4/qfiQ+uhsjcJJtAY0qytcMXYkAos1mrKTyw2lUsyLErnFIKLO+Wu
         kNcTlbmYez1h729S5REpWX2YskmJp6Td/g8C+Y8o60z8lyOPBus0MbfAXW2bNYEXlK0i
         /jEFitsJTlh/FZnpwpAnk8Nq8EUc1Uwvt2eeQuvKfr3L8tovBftFjmDw1Xu8FX/YjeHs
         IwWdMUNqppCFpAIG28qEmoVb67q56fnpNirpPptFsgH8CAkUM2J77NtRyO5GkmMUQP8j
         VHqVG+iMBiODu7Jx+cPu3ZIAl4LPU5kdR/QhWQos92XcPOQ0LMGwf2EsXgRC3yiUi46L
         aSmw==
X-Forwarded-Encrypted: i=1; AJvYcCU0Uv/eWMC2sOgBmnVaxVjEYjqM3QCsKmpqZTvLIdHcqB8ltvKWs9XR8z7DA5SNPCWJtmgkquU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR9BNxRKjmyZ08JNOoQJ5Fu+Srg5/wbeO0/nA6RWWGgygStc6H
	gGcLTVkhgm1c8OKEdRezQg1z8KVxWCwHnFpx4qPzaUIuAgDnKFAisTmO
X-Gm-Gg: AeBDievh4+vahNyNVk1km3u4XIVk2IOMILv7KyupZ/sK9NcYltwxSBIxJTVA59jgVzz
	obENzxIYAjCZUyKRGBBidq+YkSO+uYkY/Ccfke5OZbcdde1oQRHluR5acEGiMNKUbhjqmITLSLb
	zieXPIBHLNEIN388c5kJ5KkxdGhO7YPEclgvnfrx2zn/pWq+Fes01RTieGWtW6287CD8psDLuPC
	tSd+ND+PiGW0tV3VJwLeygyWoX/TqFOJldmaIjQWWZf9xzidxTPiXf3O6SXn5Na/UPa1FxZp3HO
	fbLWf+RMR5J7jHbM/SbkBd834lxhyO5funrZxd3Y0FL7hPr+Hh+2drQ8oslEwl9vDG2vs0JeKs7
	C0E8iztpgiHN1I2f0KUe1ZDMA7yf4211GGdXBOVrna/1agcEMtkKkV+fU0oAYaPDOEfytrqi8OA
	Yoq9Z5VAt+5HquDS62mGr0saPlT8536qJpQZMF8SiBxByURdLQ7TCmfXzae2WgBzjA9Dyd9mI=
X-Received: by 2002:a05:690c:e3ec:b0:79c:ff02:a03d with SMTP id 00721157ae682-7a4d35d5df3mr150303367b3.10.1775520944129;
        Mon, 06 Apr 2026 17:15:44 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a36e320670sm59858877b3.2.2026.04.06.17.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:15:43 -0700 (PDT)
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
Subject: [PATCH wireless v2 2/2] wifi: mt76: mt7996: clear cipher state on key removal for WED offload
Date: Mon,  6 Apr 2026 20:15:31 -0400
Message-ID: <20260407001531.31207-3-joshuaklinesmith@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407001531.31207-1-joshuaklinesmith@gmail.com>
References: <20260407001531.31207-1-joshuaklinesmith@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-233470-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 53C1A3A8642
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Same issue as mt7915: link->mt76.cipher is set on key installation
but never cleared on removal. The WA firmware retains the stale
cipher in BSS_INFO, sets the protection bit on WED-offloaded
frames, and drops all plaintext traffic when encryption is
switched to open/none.

Reset link->mt76.cipher to zero and call mt7996_mcu_add_bss_info()
when the last group key is removed.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index f16135f0b7..d464fc3d90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -249,6 +249,13 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	else if (idx == *wcid_keyidx)
 		*wcid_keyidx = -1;
 
+	if (cmd != SET_KEY && !sta && link->mt76.cipher) {
+		link->mt76.cipher = 0;
+		if (link->phy)
+			mt7996_mcu_add_bss_info(link->phy, vif, link_conf,
+						&link->mt76, msta_link, true);
+	}
+
 	/* only do remove key for BIGTK */
 	if (cmd != SET_KEY && !is_bigtk)
 		return 0;
-- 
2.43.0


