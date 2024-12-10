Return-Path: <stable+bounces-100484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CDC9EBA1D
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 20:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACB3167836
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7962121423A;
	Tue, 10 Dec 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkJuH589"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A88523ED63
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858717; cv=none; b=WYhOOcPHSa+1ZBZnTFN8/RmnUZWe9TRpwKYiVwNLC3SJk5hNYsPRxe1Af8gNKq+QEST+qo9BtdkHJbey5XiTRJc4EiPafv0AnG3AY4obJnDAI5y7wEYx/O8nOiNwAfaY/mcMDiWq9TfydiXbpxcfxipOUsBaBxjrTD4bglv/eRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858717; c=relaxed/simple;
	bh=aGBPYNLNCjFIEiKmEWcoZvssjACZGyW7g+1vwp8aBAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ndibe1DA1NkcqsTh/sm0YqaHULNLj778qgVnUvcnHDFdbPhTdHc8GzM3SncONuDSC9gnTNKu5TAH2Qd0JXepLD2lhcBDYxYYyJZmwZN6fnQexKFtmiP45HkfWmD5fAfSKav4Mq9hnGAEb6TsmJBSiqRarF+mjgCV8+Ey8rCqTVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkJuH589; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3F3C4CED6;
	Tue, 10 Dec 2024 19:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858717;
	bh=aGBPYNLNCjFIEiKmEWcoZvssjACZGyW7g+1vwp8aBAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FkJuH589Kap7gXZdIyVYP0WM04FrcXbcp38Mhu8gjMWzRKyYDjwqgOChLE/OYGoeN
	 4gylQcExQKNCioUdKz3pfV5Y5NVTcmTKUd5T5UKxta9SGlYUXqp108/MTAEAs6XAt8
	 TiEngHjxU1F6JoQWLfdppLNHogd7hE+uAaS0/ULpLyYViGgXRaLdWv4qfntO2Clj7N
	 RVeHAb7E7QzgVqWxFDxAAmAOCDKihm38twu7xyJnUjxi7wIn75zKG8jdV89Fir3HLh
	 xXC2S0+ANw9IEsD/YruNRZMNMACl+ST1G8idYwB0JU8miBLKSfr9QwJporW0pWYO1U
	 iZ/ytpQgra48w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] net: stmmac: move the EST lock to struct stmmac_priv
Date: Tue, 10 Dec 2024 14:25:15 -0500
Message-ID: <20241210092312-6ea3adf627e2d3d6@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210020043.2545261-1-bin.lan.cn@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 36ac9e7f2e5786bd37c5cd91132e1f39c29b8197

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: Xiaolei Wang <xiaolei.wang@windriver.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: b538fefeb102)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  36ac9e7f2e578 ! 1:  5bc5febe7e329 net: stmmac: move the EST lock to struct stmmac_priv
    @@ Metadata
      ## Commit message ##
         net: stmmac: move the EST lock to struct stmmac_priv
     
    +    [ Upstream commit 36ac9e7f2e5786bd37c5cd91132e1f39c29b8197 ]
    +
         Reinitialize the whole EST structure would also reset the mutex
         lock which is embedded in the EST structure, and then trigger
         the following warning. To address this, move the lock to struct
    @@ Commit message
         Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
         Link: https://lore.kernel.org/r/20240513014346.1718740-2-xiaolei.wang@windriver.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    [ Resolve line conflicts ]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
     
      ## drivers/net/ethernet/stmicro/stmmac/stmmac.h ##
     @@ drivers/net/ethernet/stmicro/stmmac/stmmac.h: struct stmmac_priv {
    @@ drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c: static int stmmac_adjust_time(
     -		mutex_lock(&priv->plat->est->lock);
     +		mutex_lock(&priv->est_lock);
      		priv->plat->est->enable = false;
    - 		stmmac_est_configure(priv, priv, priv->plat->est,
    + 		stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
      				     priv->plat->clk_ptp_rate);
     -		mutex_unlock(&priv->plat->est->lock);
     +		mutex_unlock(&priv->est_lock);
    @@ drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c: static int stmmac_adjust_time(
      		time.tv_nsec = priv->plat->est->btr_reserve[0];
     @@ drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c: static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
      		priv->plat->est->enable = true;
    - 		ret = stmmac_est_configure(priv, priv, priv->plat->est,
    + 		ret = stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
      					   priv->plat->clk_ptp_rate);
     -		mutex_unlock(&priv->plat->est->lock);
     +		mutex_unlock(&priv->est_lock);
    @@ drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c: static int stmmac_adjust_time(
      	}
     
      ## drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c ##
    -@@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_taprio_configure(struct stmmac_priv *priv,
    +@@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_setup_taprio(struct stmmac_priv *priv,
      		if (!plat->est)
      			return -ENOMEM;
      
    @@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_taprio_configure(
     -	mutex_lock(&priv->plat->est->lock);
     +	mutex_lock(&priv->est_lock);
      	priv->plat->est->gcl_size = size;
    - 	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
    + 	priv->plat->est->enable = qopt->enable;
     -	mutex_unlock(&priv->plat->est->lock);
     +	mutex_unlock(&priv->est_lock);
      
      	for (i = 0; i < size; i++) {
      		s64 delta_ns = qopt->entries[i].interval;
    -@@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_taprio_configure(struct stmmac_priv *priv,
    +@@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_setup_taprio(struct stmmac_priv *priv,
      		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
      	}
      
    @@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_taprio_configure(
      	/* Adjust for real system time */
      	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
      	current_time_ns = timespec64_to_ktime(current_time);
    -@@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_taprio_configure(struct stmmac_priv *priv,
    - 	tc_taprio_map_maxsdu_txq(priv, qopt);
    +@@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_setup_taprio(struct stmmac_priv *priv,
    + 	priv->plat->est->ctr[1] = (u32)ctr;
      
      	if (fpe && !priv->dma_cap.fpesel) {
     -		mutex_unlock(&priv->plat->est->lock);
    @@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_taprio_configure(
      		return -EOPNOTSUPP;
      	}
      
    -@@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_taprio_configure(struct stmmac_priv *priv,
    +@@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_setup_taprio(struct stmmac_priv *priv,
      
    - 	ret = stmmac_est_configure(priv, priv, priv->plat->est,
    + 	ret = stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
      				   priv->plat->clk_ptp_rate);
     -	mutex_unlock(&priv->plat->est->lock);
     +	mutex_unlock(&priv->est_lock);
      	if (ret) {
      		netdev_err(priv->dev, "failed to configure EST\n");
      		goto disable;
    -@@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_taprio_configure(struct stmmac_priv *priv,
    +@@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_setup_taprio(struct stmmac_priv *priv,
      
      disable:
      	if (priv->plat->est) {
     -		mutex_lock(&priv->plat->est->lock);
     +		mutex_lock(&priv->est_lock);
      		priv->plat->est->enable = false;
    - 		stmmac_est_configure(priv, priv, priv->plat->est,
    + 		stmmac_est_configure(priv, priv->ioaddr, priv->plat->est,
      				     priv->plat->clk_ptp_rate);
    -@@ drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c: static int tc_taprio_configure(struct stmmac_priv *priv,
    - 			priv->xstats.max_sdu_txq_drop[i] = 0;
    - 			priv->xstats.mtl_est_txq_hlbf[i] = 0;
    - 		}
     -		mutex_unlock(&priv->plat->est->lock);
     +		mutex_unlock(&priv->est_lock);
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

