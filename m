Return-Path: <stable+bounces-124760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A884FA6673B
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 04:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E194174AA1
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 03:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078A31991C9;
	Tue, 18 Mar 2025 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kotCoC0x"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6313E35280;
	Tue, 18 Mar 2025 03:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742268271; cv=none; b=j5YlvbIGsRc5QIyuAShTBCZf1HsbtxbQJ7DTUzPX5FlmYHt9GsrR//Q3CZUy8ZJR7VcexVYfnsj19WxW1F2Mdc39U4b+kiPWXd5UrDBML+bfIs4VJIIncMDpnHsSaQv0AWD7d4x7YvBvlfd/AW2kaintWAfVGe25xMnp0msVZpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742268271; c=relaxed/simple;
	bh=GJEQZBZoSXG8ZavXNPasT/udLtFSf8e3izTuvlxWoow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5U1OTIHFpUOWIuDsYJgdQOsq03yCkjfBDmZWcxjYJaePoa3td88UoeEcEbyk/3vjDMYNRSfOJ7Py4Z3yLoOsYpQ6vasBp+VtbXyXh7Q1SBP2QbRDhywoi9LRYzJTIeh8lQyX9M1H7K0PDbHsxKZ7HoMcvga8I8ROLk3wCNQvns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kotCoC0x; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223fb0f619dso84768965ad.1;
        Mon, 17 Mar 2025 20:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742268269; x=1742873069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xzsGjBDZ3uOi/9IBR3NoAthzrrDc884LFnPwtHEO8r8=;
        b=kotCoC0xliV1s3jyNu+4uhR7LQPtHTiKyXNTjFPhw7kbHuUaEl93YiuCdEH3Dc6icJ
         hzQG4uym0MVrL2mjrsZUWUPjP99uZbKrEg8CIK1eEWZhkYR/WWGPiS2q8wpyj9EvSjMf
         GFOtKQeNzr9xq40Fl7iU20QQZgbmrf79QQmSQHGUmSOe8dMTpV49HApUqL9cH7LWgh1l
         K+GH9TWyltVfzYvu0QVl9cemrBKapazM9zemOM3q50iWRE/ccDFBaba//sjduL5qyJvY
         D+oMsVNCDvQZoXZGTkppk+1RzaaXaXS8JY6L54+ALJuCDorhDulu6HPShGXED352GZNq
         2+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742268269; x=1742873069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzsGjBDZ3uOi/9IBR3NoAthzrrDc884LFnPwtHEO8r8=;
        b=YX4O9//XFCRBgorQlJxBvsnTb25BnqW6QrPzhvoWpOfXDgxqbKnPc3sxmMtwtEzehh
         dWqyfBIoDVSbzH36B5a67U0iOz+u5FaPsECxFZH8aJJVzmMWu3gWrXiKDwJsOEC2Yykj
         bYlviW3U1K5za6xR1qdpA9oZQ4/89EskqFu2TPp4t872rV0Ycx5YyuipH8S2vZ+Pk6LX
         W0dFPteEwuq448aVPNF+7FOIANmgtKpF5flvZ7wztf8Yp7MzOTVbzQyHRrKuStZ80PLq
         Jv2eHeqzQK1OYSvZ14Zonu27ZZgq4BbKr4RVuP/zmpkjoFe04/rhCXvQSYcjhKNDDKYb
         De9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUk7EYp867vdY0Y279qdtgdzBcz6BG3nxrQkuBm7AQSAX1KMPtRk19BzfyFgR6hufgWU0qdfhFw@vger.kernel.org, AJvYcCWul76XLyzeOQHEQ4IPOA1I8xG1UIXdW7HJunlXhkSI4XwSc1vUUxu2oBoEw2bNJP5vdNDMrUR68nQdjVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdpm3WuaXzSgH1ABP3ST3oHEx0qfV3EMlzTwQQu6skiISuVxkq
	y++1botcrrBUtlY5ZNLAIgc9T+eXjaFx/Md+qKV4BEwNCZE/ncBf
X-Gm-Gg: ASbGnctxJVVAq7pK2y4ylPGmVRmjuN7npvKUrrXyPZgvkrqT3Ysv1W7te9BBdXs1hSZ
	Yl0Si7tRs51e32NvXt+aTJXuVNP4XakKBCgdzQExsQA2HEqCX0q5Z9BLRVnXRhX/E27S8U5qvoO
	7s8gDYmcs1m1Ap2bDyqASaWgCrWsjpnmeEZQpac9xKELX0uENHYpWXpGUJIEmpIVDVfxYl8XALW
	4sDZihhz+IclqchUcX1Z7hlPsrl0QogsP92i3fIbarbLIn/gkImNL30rB45N/lMrcsJnnBIVLOL
	U00nGMFCFaux2Cb1txjxmPF3ulbBeDEzUQ3T5A==
X-Google-Smtp-Source: AGHT+IEvQZr1NDuupnwhk0WVzDIWEjDBiyCz7Lf8A5Y9iUiBLq47O6z6JgLA8D0IgZ7PxP69ke1QsQ==
X-Received: by 2002:a05:6a21:600f:b0:1f3:4427:74ae with SMTP id adf61e73a8af0-1f5c122df38mr18511704637.25.1742268269508;
        Mon, 17 Mar 2025 20:24:29 -0700 (PDT)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711694e56sm8666125b3a.130.2025.03.17.20.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 20:24:29 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH net v2] net: stmmac: Fix accessing freed irq affinity_hint
Date: Tue, 18 Mar 2025 11:24:23 +0800
Message-ID: <20250318032424.112067-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpumask should not be a local variable, since its pointer is saved
to irq_desc and may be accessed from procfs.
To fix it, use the persistent mask cpumask_of(cpu#).

Cc: stable@vger.kernel.org
Fixes: 8deec94c6040 ("net: stmmac: set IRQ affinity hint for multi MSI vectors")
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v2: use cpumask_of()

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b22417167cac..ec63452187d0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3667,7 +3667,6 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	enum request_irq_err irq_err;
-	cpumask_t cpu_mask;
 	int irq_idx = 0;
 	char *int_name;
 	int ret;
@@ -3796,9 +3795,8 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 			irq_idx = i;
 			goto irq_error;
 		}
-		cpumask_clear(&cpu_mask);
-		cpumask_set_cpu(i % num_online_cpus(), &cpu_mask);
-		irq_set_affinity_hint(priv->rx_irq[i], &cpu_mask);
+		irq_set_affinity_hint(priv->rx_irq[i],
+				      cpumask_of(i % num_online_cpus()));
 	}
 
 	/* Request Tx MSI irq */
@@ -3821,9 +3819,8 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 			irq_idx = i;
 			goto irq_error;
 		}
-		cpumask_clear(&cpu_mask);
-		cpumask_set_cpu(i % num_online_cpus(), &cpu_mask);
-		irq_set_affinity_hint(priv->tx_irq[i], &cpu_mask);
+		irq_set_affinity_hint(priv->tx_irq[i],
+				      cpumask_of(i % num_online_cpus()));
 	}
 
 	return 0;
-- 
2.43.0


