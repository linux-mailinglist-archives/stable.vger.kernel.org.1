Return-Path: <stable+bounces-41476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4779D8B2CFB
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 00:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E24B2C476
	for <lists+stable@lfdr.de>; Thu, 25 Apr 2024 22:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A348158D94;
	Thu, 25 Apr 2024 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXpQB1LS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF8157A6B;
	Thu, 25 Apr 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714083022; cv=none; b=BlwMQAvbO/wE9ma/4BIk0/byB9RRn4LBLt99VIsCKKX/JZYnFToteg1r69oygg/T0LAiqi6/NXetsHwrjZ1iTY7vzIHGeLPq6jy7aqWK/uUvvRLGqbQsfTBQEmPjNBWWQ0Zh60jm05Bxxf+Sszt/7shoO1ds/12vaH3ITeC3w+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714083022; c=relaxed/simple;
	bh=gK3IDBMN0QPgUq6nFSZArygjbcNekpXpG97aut6lPG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foZp/baxXmmdxrVbYgzVkPLXPTMWphce3I8I4htlBXUtrUV95SQfl+t/BPgnEAj0cGdpAu4VbxgQtLh6Gvw7EU3yl/Mk+Y3ler+PMfSQzqcA2kWbzuv6CI/qZSFxbbiUQ6beFYZ1V9JMleH7LY1+WcXJURZSBZvKprqBijxKLFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXpQB1LS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ac16b59fbeso1364006a91.2;
        Thu, 25 Apr 2024 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714083019; x=1714687819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoVri07CqNZY64mEc3hs+qcgGhmd3HVXaDxx+6B0MGI=;
        b=lXpQB1LS1kDuiDKDyHPSIXLg5juccmZO0zRdQWczp9pGzozKkwsQIwL6v0qt1ReepC
         W1/XVCDwzNCl2SkiIPZrZS+0cLQmTkPg7BKXWviKaYQdzHynv4Km85hRNL09fLiY9oL1
         OuVE6V6farTb+hnraNMszTgFh4LnhtH8NR6gmsG6ZHe4PVfiUrjw0W8ldzDuyzSZGAR1
         M0e+hEZ5AXf78Z8lNi5n387Zxfjr7zHPzoo6EDRJ+LOyEwhfKA+zom1Yo2zZ3JNSxGNa
         oZ7B/nssFKm4fQzZ6jBNzxprITb8YQgp4UdPNV22dG+DxrEJtH0/RYkQ0mL3Awlxwa/X
         uc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714083019; x=1714687819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoVri07CqNZY64mEc3hs+qcgGhmd3HVXaDxx+6B0MGI=;
        b=TZYqlOQdeMMRXA8bdTh1/sy9xaGWHEFcWFO+aeHbWVYaCDV+YtsTw0Tigm/JQVC6qD
         6pZAPtRqId+g3cH/QAaO818sVdhwcNqKyhJ/jBrO30x4BiP38x7isOO+5MACzF0d1E4n
         S1LvmsH6uiaFJWX0N0fWAOD5zgly8zuVr9v967sZWgS4VMCaaiYRhq9lfeqb5lUiXZjQ
         iXQxw6HqIcfEUgISF3iibQY1Wis6T50vRCUdANZl46UsJTswPRJGf/TH9S23WpX4pjPS
         AgVOI/XGR+PcBrP3MSijkknNG0SO5Jg3ccbMut10RuRIz+Cvos0US9a+ZGjkyeD+xQDL
         Yydg==
X-Forwarded-Encrypted: i=1; AJvYcCUv7SruyF1eEzhJIRNKZJplw3lQ+JFR10J8vnExPmKk3YJ/5R7LNRkRLythx6QWt8DfjFtsQWmTtopYO7/8ggduWDP9QsJ2
X-Gm-Message-State: AOJu0YxNwuTznS+OzEyKSN6zoAOakzgqMpbmr3a2VqGYNVqaooGGHE/w
	jOUATAulkfBn9n6iZTRjCOiKR9BYiQMl0RB+9Bj6w3ToZ+JgPt0jylXAFQ==
X-Google-Smtp-Source: AGHT+IHrpfUPrxk4lIZJp4v7B3MJA7lunTq6dyrV1du0hr/Dd9ZLxbToq8j58vHBs2413GZBgVGGaw==
X-Received: by 2002:a17:90b:4c8a:b0:2b0:502f:4ac0 with SMTP id my10-20020a17090b4c8a00b002b0502f4ac0mr848437pjb.17.1714083019287;
        Thu, 25 Apr 2024 15:10:19 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a4a0500b002a269828bb8sm13394766pjh.40.2024.04.25.15.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:10:18 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
Date: Thu, 25 Apr 2024 15:10:06 -0700
Message-Id: <20240425221007.2140041-3-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425221007.2140041-1-opendmb@gmail.com>
References: <20240425221007.2140041-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ndo_set_rx_mode function is synchronized with the
netif_addr_lock spinlock and BHs disabled. Since this
function is also invoked directly from the driver the
same synchronization should be applied.

Fixes: 72f96347628e ("net: bcmgenet: set Rx mode before starting netif")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b1f84b37032a..5452b7dc6e6a 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2,7 +2,7 @@
 /*
  * Broadcom GENET (Gigabit Ethernet) controller driver
  *
- * Copyright (c) 2014-2020 Broadcom
+ * Copyright (c) 2014-2024 Broadcom
  */
 
 #define pr_fmt(fmt)				"bcmgenet: " fmt
@@ -3334,7 +3334,9 @@ static void bcmgenet_netif_start(struct net_device *dev)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
 	/* Start the network engine */
+	netif_addr_lock_bh(dev);
 	bcmgenet_set_rx_mode(dev);
+	netif_addr_unlock_bh(dev);
 	bcmgenet_enable_rx_napi(priv);
 
 	umac_enable_set(priv, CMD_TX_EN | CMD_RX_EN, true);
-- 
2.34.1


