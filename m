Return-Path: <stable+bounces-215510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cvDPBxD7iWluFQAAu9opvQ
	(envelope-from <stable+bounces-215510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:19:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95765111D4F
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 827B03010B95
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8A737D135;
	Mon,  9 Feb 2026 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1NnOgVI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B2D1A2545
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650381; cv=none; b=CVAFyVo9PYsp5jKBS8Dl2ahZgMuMioW7Uw8qO6EyeA2nYUdRQ7KSKCToRDlWUozUcDLKimQ12/tS6lzFnRABsO0+tFibL21AwPANE2nm01uVmeXw8jfE1vgimzhIEHcZTBiC6e6ugXLmQFNSsE65zd0NaBEt56W7ISowsVlHizQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650381; c=relaxed/simple;
	bh=uHOAoAqXBB6yKdjNEOSRdIq/aoI8ubCF1Y4crVHtibw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkKJZWiVxcWtoo2kjz38uxQIhWcfsj++wzxapYbKvxrPBNmkiE+nZgcSB4OC2qtrv+Fp4ehk1ntZKnkPPjQlNx+aQ9BA9lNlE3MH8AAVpmoxMFvUgSiJLFx8NYTo+W3EHZSO+fBbmA4WqUIWl1NaI3wv7lfvY3PHW7rh6Y5MKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1NnOgVI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359c54b682so295155f8f.3
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 07:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770650379; x=1771255179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YTzvCYXiRiQsNzIWAR8ywGvKHYp+IRPHv2CPPhaIo54=;
        b=L1NnOgVIyM9u/4YQl0b927UR+aOS6W+8ArxKLvB6byHXbCaRxKALWCWpwe889djvHn
         Ct7PLigbQzmcvvjehjUocy6mvjDWCN8hiBSGqb+zvzRLOgIPCDehW5KaM0pT98xZEjG9
         hkKNT7Ohe3qMa5730kb+TqjrO4+WZDLqTZAeor2oNdYf6unNYlTQtRhsJ/4j2yPqst/2
         iPgyPWLfUzdhPtQGxd5rkNDUUsuo3em8AEAKe6UL8auXxlpd6QGCIlCx/igvfe8OqOlK
         z01YRjW+coVYrE8gmxDKeAiEl+SyyeXtyWy/jOqJrbvi7giOFwCvBDzMNH6TSl9OnVVe
         rmsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770650379; x=1771255179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTzvCYXiRiQsNzIWAR8ywGvKHYp+IRPHv2CPPhaIo54=;
        b=FqIOxj0KFqxWWw40f5RnHHjT1uhcv2pTCUzWDfCDBIRUNBhjrKA6J24fjLo2Pisq7o
         sqCLQ0Da31q3Xe/s5Wmy6FUtCPCgwzVI7idCl9FHoj8xASpgfg9dz8gDyjE3pvTOSVUQ
         H+rUz5VTUV4P+CZqndQ30VRVflWOGeRya3/Atgp9cZLUjn//1LXDzu4JIbsuopQ+9XBn
         e/Lf7gS9El04yMS5GX2d9PvF6XHKafhqscfwS12EP2doO3qc3UlqdE2qH2OkLsGrceUR
         TCx0ZFzamMYhrhb2Kt00M3sR1lXn2oCkksiQqorAIS5iQ2OLHCwqbN9jvXTXns7lDhXL
         gShg==
X-Forwarded-Encrypted: i=1; AJvYcCU7qNH27rboFlTfBynpqu7uxtYHMAMqaClIYEKZe5ql8wkEjEm4xKma2Rb4V0mZe2GpuI9uv+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnuz+8BxW0B/Q74Q3jFxjBJrQfRuTm1o+DYv3NWPnW4zjq84pm
	Gycl54jqqd28PGSvmK+o2g/jFej5+EeRU+YICrga8w+kyAAYlUrFGWM0
X-Gm-Gg: AZuq6aK2skF+T+ypWj4gvYSelF7BhJ0ysG61h/gG0NVlLP8IBQ5ziKGm6gYI2pWlphu
	fL1YLBzgKzB/B4yRtmkrGYGFf9wRV60yJ1wHJ9bhQAHISaDgqz1Lt+NOle/g4lcEQzcgZuBg3h9
	V8heMImgvOWm0DU3QuM0hmsBwKqs8Ht3De9pddpMPxHQJmP4UQu+nB1L43j+kaTqMxcY7FKc4y3
	2WrhS0qdl4mMzaCUFEHhk9QOYVlBkezXQZ32ok49C0f2yZSRAs7Lmsm87qtenQyiO2IjIGZT3lv
	8c2/GKrStHDPyTv5rl+Bc12eHDlEPB8S5h37SCMO7GqXXK1AEFYwkZZ1yFnSBAGYoV32pUyv8cw
	/Mj6bMgRqsKvLlMNC9fbyVG4PQ3JCa8xiJfqfzMPrbqTBdbSBZu1xenFopsMeSt9C/ub8wQAr6A
	Mn+3Af9xxgwRbisDfZR/fs0t5f5t6dkEtzWX7jn+D0vjq1q5oB1JNyr3vADSkD/nVPSc51QYdES
	/5heEg2
X-Received: by 2002:a05:6000:184b:b0:437:72ce:8954 with SMTP id ffacd0b85a97d-43772ce8a4dmr1977190f8f.6.1770650378901;
        Mon, 09 Feb 2026 07:19:38 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-213.paris.inria.fr. [128.93.83.213])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4376686130csm15122697f8f.1.2026.02.09.07.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:19:38 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: mtk: wed: Fix dma_free_coherent() size mtk_wed_hwrro_free_buffer()
Date: Mon,  9 Feb 2026 16:18:21 +0100
Message-ID: <20260209151822.136934-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-215510-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,nbd.name,mediatek.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,collabora.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fourierthomas@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95765111D4F
X-Rspamd-Action: no action

The DMA buffer alloc'd in mtk_wed_hwrro_buffer_alloc() with size
dev->wlan.rx_nbuf but is freed with size dev->hw_rro.size.

Change the dealloc size to match the one used in
mtk_wed_hwrro_buffer_alloc().

Fixes: 6757d345dd7d ("net: ethernet: mtk_wed: introduce hw_rro support for MT7988")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 1ed1f88dd7f8..455df564174d 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -879,7 +879,7 @@ mtk_wed_hwrro_free_buffer(struct mtk_wed_device *dev)
 		__free_page(page);
 	}
 
-	dma_free_coherent(dev->hw->dev, dev->hw_rro.size * sizeof(*desc),
+	dma_free_coherent(dev->hw->dev, dev->wlan.rx_nbuf * sizeof(*desc),
 			  desc, dev->hw_rro.desc_phys);
 
 free_pagelist:
-- 
2.43.0


