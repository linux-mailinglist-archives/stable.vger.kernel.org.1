Return-Path: <stable+bounces-45349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A1B8C7ED3
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 01:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5851C1F22085
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 23:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6903FB2F;
	Thu, 16 May 2024 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxUUd1iG"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFA33B2A6;
	Thu, 16 May 2024 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715900528; cv=none; b=bdE/iqGzcNGdYuCGtatjnRP9CmiZoVFJDj8YLaN3jaRbc7vxBOp4sRFJUZAljrH6oHKHJzPYM6KjhrhFY79GWnqqLPJheBX+0IhqbJ/4ocHperCV4v4ZogcxjnXHsa9C/t18ujCZG51a7LBseoc+WnswCPsX4aEXxWFmUWhqu7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715900528; c=relaxed/simple;
	bh=rWhDCKDGUNLE4EoUeTeFDmTUc++hfoUGmdNIrG+/IR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J/Wm0hi7vFfuHjN9oGWSpZoUE826VsdUKRq5aid2ZZKFj2qJH+veV4FHjzwoofEyJbBTAzQnyV+tRQLwzkIC6124qqFBedTrfXCKSXjMn0TAVgh5wN+Mx7HrKj9W2/A0N3marLRwkTxg8ECp6/BJrh4Dh40CuerxjdQL8XnNC/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxUUd1iG; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-43e2bca05e8so317011cf.2;
        Thu, 16 May 2024 16:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715900525; x=1716505325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQ+YHRdKVUaH+6BWpdlpKpl2u3zSs+jY9z+FmOnpPYE=;
        b=AxUUd1iGusAozXVP7oRJE8WIRcsu6Rmw78KiBcq256+rCNykDMICR0grGVwrRuHOpt
         zrGSHkv4CtviSwhPcXQBn40a87wzxnl4KXXEa1YEkOg3+jw/IkCk+5oY4uEU/zv/XKqH
         RvcXPz8ciB7+U0VzYs4IVEluGJdsFV1wJa0kdFnkheGQllyQZPzTh8y/bHmWebHSKCk8
         KyQ1AaUDQMgIQBnc1pOSeOBx/r5ybIVsRLPn3wlpn34mxSCHyhr5Tu+UDxukIAZo4SE9
         DsGEWaNbLJkHnP1hwejm9/cvMOL+5j9fZ90x1BsufiwKJZrNykKhw1X5Cg2uMraKg0Ef
         cnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715900525; x=1716505325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQ+YHRdKVUaH+6BWpdlpKpl2u3zSs+jY9z+FmOnpPYE=;
        b=rrbI1GvFYb+HP5ZZk08DRB5YWbyMfdgTDHF2I6XUe/d3r/K9e1LRcAHqV1fs/fTBzU
         6PJnYLlvMloohv8d2mnkdiI8NRjsYcgRRd/o0TCgk9w1uWzbYwTIVuXU7O/wWuYG0kgx
         eo9DymDJKwSS3Xt7RHK+qZMyvVaZ2S7uNzJDQupWfF06OlCNauBdxO3qek2e6m8dNQj9
         4GZHcjP7l6sfNTNUpOYUU8WfYEUSve1QvcPtNk7hDRE2dlALDOGQnjzxfL+IrdxkMt2z
         KfpemPhkZW0zAIpJo2bZyp6eUjgD245CcvwNDb+3rV/r6nJIqv/mZulYpp93Z6PfHqpj
         5hBA==
X-Forwarded-Encrypted: i=1; AJvYcCU6kP8x98WyaT5LO2M9Cizi1x9y9NVpqbqqdyb7O5DPlUPcbLGwPY9Zc6o6FLX05xgQCCIBBZbDvdS5ZecDnbUSqh2kv71r1vaFkj2KjWVIIoMGvzwrLkKT+rxlYdnUUmjeNr/a
X-Gm-Message-State: AOJu0YwQFGrAiPPcK7k453lHP7LK/3is47uWsfWfd+VPUZpPTXbIyLw2
	ta8QpMdNVwWg22e8jwnWThS79pbdi7YbikFhB8LjTT0qCQfWtXsWb+mOQQ==
X-Google-Smtp-Source: AGHT+IGuRvJzQiRpV2oU5Ww6p0oIVaKIDCu2YH5Y9yCwTbh6NAgtRBM3voXr8p9zmuIAWMLMA19D5Q==
X-Received: by 2002:a05:622a:1912:b0:434:b04a:20d1 with SMTP id d75a77b69052e-43dfdb1f7c3mr237392321cf.36.1715900525428;
        Thu, 16 May 2024 16:02:05 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e251233c6sm47154851cf.84.2024.05.16.16.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 16:02:05 -0700 (PDT)
From: Doug Berger <opendmb@gmail.com>
To: stable@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH stable 5.4 2/3] net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
Date: Thu, 16 May 2024 16:01:50 -0700
Message-Id: <20240516230151.1031190-3-opendmb@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516230151.1031190-1-opendmb@gmail.com>
References: <20240516230151.1031190-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 2dbe5f19368caae63b1f59f5bc2af78c7d522b3a ]

The ndo_set_rx_mode function is synchronized with the
netif_addr_lock spinlock and BHs disabled. Since this
function is also invoked directly from the driver the
same synchronization should be applied.

Fixes: 72f96347628e ("net: bcmgenet: set Rx mode before starting netif")
Cc: stable@vger.kernel.org
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index bf52bd643846..e34df8da65e7 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2874,7 +2874,9 @@ static void bcmgenet_netif_start(struct net_device *dev)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
 	/* Start the network engine */
+	netif_addr_lock_bh(dev);
 	bcmgenet_set_rx_mode(dev);
+	netif_addr_unlock_bh(dev);
 	bcmgenet_enable_rx_napi(priv);
 
 	umac_enable_set(priv, CMD_TX_EN | CMD_RX_EN, true);
-- 
2.34.1


