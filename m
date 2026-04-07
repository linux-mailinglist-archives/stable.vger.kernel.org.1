Return-Path: <stable+bounces-233474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNN1KplN1GnvsgcAu9opvQ
	(envelope-from <stable+bounces-233474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:19:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD0C3A86B2
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 982573153568
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 00:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F461FA859;
	Tue,  7 Apr 2026 00:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyFK9nXb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B570E1A6809
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775520972; cv=none; b=DJvRQ8S2qiU3ADKZudBBCQpUWv3ohtmhrFsK8oXxp4hdIjR0kljsJO0HqZCKnB4MAnnq0SbaLWfjjY41lkcMCBU9OXMF1OTL/j8zSonTGcczaLCuXRd6uBq1otqewP2/RvyYGASaHxfRQfry1R1MLm+LXH+p3MpeHrE46vshAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775520972; c=relaxed/simple;
	bh=VjyvCnOPToeXVmCuBRK0MixnZpWd9wXYBTD/NVXy+mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQfjENlNEgUhpzmOL6/Pv7vEICrML4xo6dN0CcW7yJo052L5tQoiu34Yw3jgeEdbbVlFhgHLuQWWLhXInGiG/4WDUcZpK6LvAFBp5yWKhs9sYonza0zO9j0T581IuJgNuswNhSb2QMkHGVMsaiRatnTHSL6j0EasYMSv5H1pD5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyFK9nXb; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a2ee65171so64060727b3.2
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 17:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775520970; x=1776125770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwAUYgcUQbMzd5TGf/Ouq5Y4qwptEf+4MYg7+HsO1/0=;
        b=AyFK9nXbDAqiX2WrCvxSmBo/qCL1q2ZjOOl2Rq3SdJYVBahtv4zg90/1RQTMTjC0DV
         BXWFI/Urc7Al+NKnE1qcLZD3c2LoeTLqa1FhjrcX2Pv+wZ3KZAJUSlZaJpyP2GgFdzsU
         Xij1koRISuLp5fPd6skNJuMjfujURkItHNkjjGaGZfK4aM0ygXdqJ8eg6Fuug2JPXHHD
         8tWXPxse5mWUtKJc1p/CeXNf2x3fdajLfnIGIjZ5QET1smXWCeW6THZWbAWFdDL+qQzD
         og6bfJr21XuXy5wcTUhjUfAHyNpyZ2G8Np/rPFUOHl0aEqORmYXClkujpOQZHIwRAlnE
         aCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775520970; x=1776125770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YwAUYgcUQbMzd5TGf/Ouq5Y4qwptEf+4MYg7+HsO1/0=;
        b=cM7uznm7JAab1FoRYGarTvfLWFJIk7N8CbHhbgCoAfzdDyVFCb9Rj/BkTVbvVdhcCA
         SQlxsrhkO91vbdMzYBsUSMj8eF0nV+odzdvcY/OVBzNheZoSebxD135+VSMFH1jnryFb
         uh7u6egkq+vjj/kl//Kld11FhyiRaUe7EomfFsJFad8Ix/NKBLHaz+YFDmop3yNyKJIK
         AZm9KMq+4jVSyQPtB0Czjs1Ap8hoYRkpuT53zZr9JVH0LUysCMi35co0JPMzRjVMk5sa
         Vzq5tgvmEAd8GAaANiW8edqI6eZVs51leXU5zxVYQnrXjjuIbfVFy06saWaQdao/zwBo
         ia4g==
X-Forwarded-Encrypted: i=1; AJvYcCXjGgBdPihcEy1i+nUhS8ccUWm0S9IXkKDglmBpwzpdbz6QH2jRlJ8Byy5yM8ZAbjxgO+dcrYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ohvdyB7HmcXLP0+TfxSa9ykAE8g/8qE68gobaVXlqhWHZrZO
	5B/pgDoMxttezr/XBot3PAU+ua49VfMF8p8FBqytmoMPK/2LkibkgA92
X-Gm-Gg: AeBDiesRaoalXO0mPz87/dG8XF4ofwu55qHHw7blOSuL5q8FgeURvmkGbzHZIk9Ouvz
	fd9o49MgaRHqRkFeQCcvvD3fQdY75/Xn/5YfUaj5nCEmgSSVmb/np6H6wTRGybINJnVaVbSADyg
	bLL/wNKR6SPQg47M15izYR7sSwENB5p3zng4nlA36z1eYCV7bG6IL0KR6Hhc+FEnSINX05f+1iA
	LycLS/szOsR9lNyhyMXUooGsU7nOPfhqHjAqjNURbghKL/N+755M5UoSJsEeqSuVRPSRL30Wokl
	dT9B9atH7nLTZYNqbWEsnJGyyE4DRUF8shEaLGO5CJ9znMHxs1yOg0drcaS/JWGuBnhWbvzK++l
	GNwCS4oSz5Ul/6a74QMqh/FphA0bOzyHIzsP6189RXimbFF7TanCScLxtmBuLYaDkmWU+B7+GzY
	ZZVUrFiAhdHahK95pUIYYoN91y/Zt8nOGG5AWY55dSgHzp4IBpavXewx5CToK6
X-Received: by 2002:a05:690e:4801:b0:64a:d479:bfbe with SMTP id 956f58d0204a3-650486c0987mr11575623d50.11.1775520969817;
        Mon, 06 Apr 2026 17:16:09 -0700 (PDT)
Received: from DEV.lan (c-75-74-152-49.hsd1.fl.comcast.net. [75.74.152.49])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a9d50afsm6698649d50.19.2026.04.06.17.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:16:09 -0700 (PDT)
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
Subject: [PATCH wireless v2 4/4] wifi: mt76: mt7925: fix RCPI chain 3 mask in sta_poll RSSI extraction
Date: Mon,  6 Apr 2026 20:16:00 -0400
Message-ID: <20260407001600.31234-5-joshuaklinesmith@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233474-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 0BD0C3A86B2
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

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Klinesmith <joshuaklinesmith@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 0d94359004..596bc21b02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -145,7 +145,7 @@ static void mt7925_mac_sta_poll(struct mt792x_dev *dev)
 		rssi[0] = to_rssi(GENMASK(7, 0), val);
 		rssi[1] = to_rssi(GENMASK(15, 8), val);
 		rssi[2] = to_rssi(GENMASK(23, 16), val);
-		rssi[3] = to_rssi(GENMASK(31, 14), val);
+		rssi[3] = to_rssi(GENMASK(31, 24), val);
 
 		mlink->ack_signal =
 			mt76_rx_signal(msta->vif->phy->mt76->antenna_mask, rssi);
-- 
2.43.0


