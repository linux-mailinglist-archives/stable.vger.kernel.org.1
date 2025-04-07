Return-Path: <stable+bounces-128671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEDDA7EA90
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B09517790C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF2D263C8E;
	Mon,  7 Apr 2025 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uR/XuDW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B49263C86;
	Mon,  7 Apr 2025 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049636; cv=none; b=DCmCarNxJykgnJgwQN7oSLk0xC7Qb1Fa4c615nV9eZQ05MiDjUA9zpALfW1SjSDZ4baXmSiMo+bBjAeHDNlXBK3rhXiumGdZLSyF6vLyy+r/SBhv0ZNf5gMrNCoKKwYRaDShKC5MebWa3e5IUudcTnToijet2vwYig2d3KcxhTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049636; c=relaxed/simple;
	bh=N3tuyanrTtxiKtiQRftQJLpETtDOfLjsVli+Lpax9x8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tz/J1kjbF05jseKQGqmT1dZBiH/qrOZVad7waRHAgBKSiLxUzKmOT00RWrBPyUGOWIS1NepZKa/cWUbwTGPiOhJaZ+qDjh6y1m+ZtTTvcFwu6QsSDFxJ9yFtzQsb84LWH/gDBzMDL91V96djXTs0JJWK8WIChIlwzR0VVwHhZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uR/XuDW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953F1C4CEE7;
	Mon,  7 Apr 2025 18:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049635;
	bh=N3tuyanrTtxiKtiQRftQJLpETtDOfLjsVli+Lpax9x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uR/XuDW2PPtV5U18bb5F1SFI3r+MACZ5F76O3xpKTB8d1Q28HJO4qF+7BKhLMM0A+
	 goouL4GGKCqmHIdQy77GqunjlypiwhhBurB2n62GkFan/GIAUVQ5f87DGmazuOVioN
	 ET5zUFDuQeCbiXxmpV+Wvl9GCt5iY2eDewfSOiTI42gcERVtIDyReAJR0pdVqUgHc7
	 /nuvUpqLoVTFXfLf6HFSMImWd8Hzo2eYbHUgzRSP/EWQOnG2IhCY46o7Nxy5WTFJ0F
	 2OwVt5aOHmKrk+uYsR+Ui5DVOuqL13q54myBNjGnQqTcr5ZUZ2wzr0FZuCJIpQ0Bih
	 L+2cE9vJhr9FA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andy Yan <andy.yan@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kishon@kernel.org,
	heiko@sntech.de,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 13/22] phy: rockchip: usbdp: Avoid call hpd_event_trigger in dp_phy_init
Date: Mon,  7 Apr 2025 14:13:23 -0400
Message-Id: <20250407181333.3182622-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181333.3182622-1-sashal@kernel.org>
References: <20250407181333.3182622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
Content-Transfer-Encoding: 8bit

From: Andy Yan <andy.yan@rock-chips.com>

[ Upstream commit 28dc672a1a877c77b000c896abd8f15afcdc1b0c ]

Function rk_udphy_dp_hpd_event_trigger will set vogrf let it
trigger HPD interrupt to DP by Type-C. This configuration is only
required when the DP work in Alternate Mode, and called by
typec_mux_set. In standard DP mode, such settings will prevent
the DP from receiving HPD interrupts.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Link: https://lore.kernel.org/r/20250302115257.188774-1-andyshrk@163.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 2c51e5c62d3eb..f5c6d264d89ed 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -1045,7 +1045,6 @@ static int rk_udphy_dp_phy_init(struct phy *phy)
 	mutex_lock(&udphy->mutex);
 
 	udphy->dp_in_use = true;
-	rk_udphy_dp_hpd_event_trigger(udphy, udphy->dp_sink_hpd_cfg);
 
 	mutex_unlock(&udphy->mutex);
 
-- 
2.39.5


