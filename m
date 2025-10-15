Return-Path: <stable+bounces-185828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB67BDF43A
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 17:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A24B1505E24
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992172E8DF5;
	Wed, 15 Oct 2025 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO/Xyg0w"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC322E62C8
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540453; cv=none; b=C9TbWfu2e8rtXVnI3+D7KKvLWe/7281M8+N8BqgqUEAyK5efkuO9iFtLYIRYOX+Auwm4quSwQuX2mf4oJO3sn/u5Bcgk9dy4Wq+vTN7BAy01omhLuC+Ug8hlEMObmH6Mx862jksz46YJaIM8ueWfPD/7MPT+28kypZJbp12J9To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540453; c=relaxed/simple;
	bh=RwSzv+8gQB1+H127TYDuoUR0wJ+1TmPyBKKgVRzUJEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PophhWLG+VipxYZ7DgsiOl29qXlfsiiw2maN6dGV0pGvAtF+yUL65QMaLIiwfukSh7l9MQva/HPjE7OfRPXlkBq5Zq5XoM1GM8rJJeDfJtYR/+2mo7foK3Lf8uO7lFL+x30lA39/khUgg9H2jkPOYsx70P2L2Qj8L7mkPrHbTtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO/Xyg0w; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-273a0aeed57so14947375ad.1
        for <stable@vger.kernel.org>; Wed, 15 Oct 2025 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760540451; x=1761145251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rm72wEzVMr9IsZ30OMPLzaYiRU5ZuIof9e+ZCzfB2E0=;
        b=QO/Xyg0w4qeP5j4izl1rOx+O+69bickpQlD22a2hPrnBnbJ5ooWh71q7FCvmyoiXcZ
         KyxmElcCQMqyga8p/IS75BR3BVDkxaLeHqYfyB1PBOropWz+V4YZoeT3p0EkRdsGmQoe
         IqsmlKZAeHppZt4LJ4qab4AG5K4yTPRTSv9GjR1fZdbVSaobVbGwA0LRGaD9GnM9LbIS
         TW9W1MBRHH3QLmKZfrfohf+2rWYX2AEUnsMyJpSaj5nZb1Ku7sTYcpCv3E2mqPfacRPX
         CVKJGGagmhL4qCkBvVmqdgqXAreaX60RqGl4U4kMxdjEomeaYe7fiRsxDx1dBJFaiHFE
         NUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760540451; x=1761145251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rm72wEzVMr9IsZ30OMPLzaYiRU5ZuIof9e+ZCzfB2E0=;
        b=HVcoFeiIAayEeh/BuyFIB7g/d/y/jBj8QSi8Nfl1FLOkPtaC/vymC5BeXNwIPrLWMo
         UL+1vwUNSFp2QiqK1gBGUkNiK6R2PRbVS+C2OOzU59fdDVck57Y1b8Sc7WYKRpepHbBB
         WEY+t9X0lcQXxYpu1FCeIF0C0CxZeelSXW2tezL03NEy0FRvNPf6qYYlvpPN+y9xZVcu
         xsO4stfARLrvZT4LRTd+OhSYFj01Ftx7nPtT6q6i0qjUKW4QXcxsjZ5y95GTvs2uuryN
         GccsYCMqbfNbV6JAF5LXiT7ERDNM47u2vMbLBp3y7TWcUc5r4c9Ju0zqWiIhhmTEw9iq
         P/aw==
X-Forwarded-Encrypted: i=1; AJvYcCV70uXOIEGSRQ5EsJWzkVWnQ6ipm9l0C6eh1L/q4zo6L5EkJTUMPSr4EXyr1OLDcdhyqauMKss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR285JSedUpkITVnUJyIlVhmFarvzpZOPjmY+7znHAHwsr3/l5
	0/tiXIud0v5CVtBjhdcSCz9aKBtOgriTVoxOkuwzfevGOWD8aZqju0NC
X-Gm-Gg: ASbGncvUxdjXrMpNipubHHTMPgf/IMXWeApi0aRej48seRK0oMFkwMq1h4KLVYFbQ9Z
	kAbI1H7hrmBIjbPx04KLTmUwdPhlEoqsQWgZWMTQfTYCBzy7RXAmh4U37E/5SNlzlJfRWSPzsk4
	gztsGWzpyFi8OS2C9iD+u090oe09bniWb3ctfydLnucJADJngTOxPO7xBbgmtuSSdC4Tx3akFub
	R3XXWMhTI2Se1nj8Bz829RcRIpQLEbYOWpCVCTbd0M754TJRXjb988OIRST4g3FPdugOBdVCnL5
	F4JwTITQrA/vDNAbtCLLajirC5JDTIZXqqSm8YtBtvaS/6uHKER2o3mOv399kvS48GRA6FIRzr4
	cY9lpWUffXJZ8hJFOnVImQ2eojFwMTYFjhGR2O9/b++5EbFWlJF8NKiOM19mXQ+pi0fJlrDwVRw
	==
X-Google-Smtp-Source: AGHT+IHL1rGxPYL4gon+pNH5suaietGYpXTK0qY/tw1k5qOqO1eGaSYosHoMCad+WaJfRavoeJ3/NA==
X-Received: by 2002:a17:902:d4c2:b0:274:506d:7fcc with SMTP id d9443c01a7336-290918cbc9bmr5514205ad.6.1760540450611;
        Wed, 15 Oct 2025 08:00:50 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:f449:63fb:7005:808e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36408sm199642265ad.91.2025.10.15.08.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:00:49 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] net: ravb: Allocate correct number of queues based on SoC support
Date: Wed, 15 Oct 2025 16:00:25 +0100
Message-ID: <20251015150026.117587-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015150026.117587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251015150026.117587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On SoCs that only support the best-effort queue and not the network
control queue, calling alloc_etherdev_mqs() with fixed values for
TX/RX queues is not appropriate. Use the nc_queues flag from the
per-SoC match data to determine whether the network control queue
is available, and fall back to a single TX/RX queue when it is not.
This ensures correct queue allocation across all supported SoCs.

Fixes: a92f4f0662bf ("ravb: Add nc_queue to struct ravb_hw_info")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 69d382e8757d..a200e205825a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2926,13 +2926,14 @@ static int ravb_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 				     "failed to get cpg reset\n");
 
+	info = of_device_get_match_data(&pdev->dev);
+
 	ndev = alloc_etherdev_mqs(sizeof(struct ravb_private),
-				  NUM_TX_QUEUE, NUM_RX_QUEUE);
+				  info->nc_queues ? NUM_TX_QUEUE : 1,
+				  info->nc_queues ? NUM_RX_QUEUE : 1);
 	if (!ndev)
 		return -ENOMEM;
 
-	info = of_device_get_match_data(&pdev->dev);
-
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
 	ndev->vlan_features = info->vlan_features;
-- 
2.43.0


