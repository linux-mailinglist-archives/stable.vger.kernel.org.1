Return-Path: <stable+bounces-204941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 115A8CF5A81
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B534C301FB72
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3B72DECDF;
	Mon,  5 Jan 2026 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODNZ0OZH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F59C2D877D
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767648000; cv=none; b=d1kVAMYtJ6rBu13GHp/+yFVVaOJi+KJcNey+CitcM6S+POKfE5wsr8LQVEXYRH+IS7U89IpfLEObwd/dygufJn8wT62vDELPvri7T+4XOEeSc9YfALgElyhEU7o/ll7HkgmnDYJaBkDixj31bSns00zgCn5rxwMGJvWAKUeZzNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767648000; c=relaxed/simple;
	bh=t9qFiFeqGxp4Cn6wya3cXn6vSYwDyML16YgOBP5gC9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9zO/HLe4AtkfDNf0FVAQVeMpXiCO2dRxdz3Wb4qDA4SBkbXrbRAagvGIjZDSyB2qJbMW5f+GBUKIKU/NOPQbKBagWdAJUCR/zMs/Ih41slGOYX19JKFgKs1uzzg9lU3WSVsEpA3+1Uf4zPWC8iEAawM50MuQjunqH3XmIUxHn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODNZ0OZH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47797676c62so576665e9.1
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 13:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767647997; x=1768252797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYAiogr7/hdP4KHS0vv5xxzgIzj7f7R1MCPaXxXIEic=;
        b=ODNZ0OZHYmFWfgKdzIWejzUDQfJCrnIB2dZz2e13gGH7zuYdJiFJiEseFb3h9akaE4
         yu+SaBHExR1pfGKIOInxFtEp/hmuKjxDyFCiTkoCAZzE0s775FDQ8u9Hj9aRSxpilBoc
         eSfyNKYW65XaVL7nuJdkI+QLeB74vYzSVTXHpP48m0DfFehMdxfnM/YMzHmw4R4RICdZ
         d3G82EUXm76t9ArrzkxHZHN8abuvVaLhzLRj/afo8lrQANjapn8RrkRsx2Bd9j4dfaIZ
         vBc6hDB11P+hn7JLL/aEx4cmcTsfVa/C9d82IoDCdaXq4PaOQ4W45zZoz5gsF6z/FGsF
         jX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767647997; x=1768252797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYAiogr7/hdP4KHS0vv5xxzgIzj7f7R1MCPaXxXIEic=;
        b=ekey6XvxThHHXIewaZ5WnR9t/QTiC0JhfjcgfpMnl5UFWpLTf4vT/SaR0//HLmSnic
         mXUeHIokf09s92eeq6Loba3UDXegnzemFKFeE569oBg7Yjm/2T/q+pzxkTcxaM9PbtMt
         NifezblUDgCKK67nHyqEBH9ErkaTd+6p9I3LUb3k0JGiCHCSc90r9iPfzDCih6QKerR1
         lV0L0ZhRH4lUD39Mhncy1iapEf/JD7BMLZi2Eh4srhczbPA65AAF4GENby9RX22eGLEv
         xxBbdng1FUTMHlwvGq2c+FcTgqQzn8FvSixOrrJbZNGxmqCVwnze0inLS2OTPE94CEJs
         mOIg==
X-Forwarded-Encrypted: i=1; AJvYcCVGf8AB/1lCDB/y+Te59c3+VaxjaeCqsu/OFD9ZHE9MZEoeAhVbwRc//o7YWWArPUaEhMBDTo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+b9B+Um3wm2r4IGIQI+i1xnB10haKWQlk9omdRrrDJl//yC3v
	cHSS/3nid1EZSCMQ0ZBVKC6vJHcKIv6z2evwZsyk0eYQvb7sLQSrD5qr/cTZzQ==
X-Gm-Gg: AY/fxX6mbqhnhU9mzRnGUrWPN0T4dbsbPj2AEZToV6u1DiODh2xgQChh1o9gq0omwDG
	drCFOrr8OjO6qwuvXWpFZgB+thQBBG+1D+Id04QDQVIXQ6WpGlIf5cgq8s8Zum/GuHloui+FoeV
	fVepKIeBPnV/Qh91iVTR918QJahyV3AMYod1wKpOkLxX3/Fo33+KYb35sdYFPLzIQoVU6Qi1UHA
	yLWP2gr9ab5q/TXq2afLWs5J8sT54xqBrqISMtYwLSbyYc86THu+aPlk1xpfRTSLjrP4PHuvDhF
	7G0yGEL0B2ctgoxbE2PgkJDD+pHbb8/hcYYPcPnABe6MnXUsr/WyC7p6AuMe2Z7G3CTiKciuNb0
	4FA8Q7jIL/idBMWg06gk9eQM6y83UPK5A2nHeBsdVxekGmhwaroEQVzsVVXjdel9DV3zUT8ZAO+
	FiBfp5AHjutuwRzscLmS0fSW1tpoUktxzZ0s0=
X-Google-Smtp-Source: AGHT+IFIa4aa3q7kG3OyPJxh1m15HSK01sRw7aceSgFDOoGG3uwGaBJZsocA2rlnxs6QMnXHm5c2Vg==
X-Received: by 2002:a05:600c:5488:b0:47a:94fc:d063 with SMTP id 5b1f17b1804b1-47d7f06ca9bmr5264805e9.1.1767647997535;
        Mon, 05 Jan 2026 13:19:57 -0800 (PST)
Received: from thomas-precision3591.. ([2a0d:e487:144e:5eef:4e0a:3841:cee5:ead8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47d7fae67ebsm1957965e9.1.2026.01.05.13.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:19:57 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Chas Williams <3chas3@gmail.com>,
	chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
	"David S. Miller" <davem@davemloft.net>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] atm: Fix dma_free_coherent() size
Date: Mon,  5 Jan 2026 22:19:11 +0100
Message-ID: <20260105211913.24049-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of the buffer is not the same when alloc'd with
dma_alloc_coherent() in he_init_tpdrq() and freed.

Fixes: ede58ef28e10 ("atm: remove deprecated use of pci api")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/atm/he.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index ad91cc6a34fc..92a041d5387b 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -1587,7 +1587,8 @@ he_stop(struct he_dev *he_dev)
 				  he_dev->tbrq_base, he_dev->tbrq_phys);
 
 	if (he_dev->tpdrq_base)
-		dma_free_coherent(&he_dev->pci_dev->dev, CONFIG_TBRQ_SIZE * sizeof(struct he_tbrq),
+		dma_free_coherent(&he_dev->pci_dev->dev,
+				  CONFIG_TPDRQ_SIZE * sizeof(struct he_tpdrq),
 				  he_dev->tpdrq_base, he_dev->tpdrq_phys);
 
 	dma_pool_destroy(he_dev->tpd_pool);
-- 
2.43.0


