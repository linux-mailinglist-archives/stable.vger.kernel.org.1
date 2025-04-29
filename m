Return-Path: <stable+bounces-137527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD2CAA1371
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB977B0C66
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504CD211A0B;
	Tue, 29 Apr 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LUr+sO7K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2BD82C60;
	Tue, 29 Apr 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946335; cv=none; b=XOOmLURwhgOjiOa9Rb0ExTt9VyiMnt/S5C1S1v7zdqgCA45tkiBq/mQpnQCaq1PqwS62DGnABRubFZVdmwxcu1T+2idtTpFoHLiW1PbrKzZQYQXmGyhIlx1xIpGdYqi6qpwUx2Tn03wK1P7KzqyH5PGFdskC4uP8+sYTq7zYwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946335; c=relaxed/simple;
	bh=+aWRNCWnGXnnZygDbw5iZRQLjxytlggexy/VxFr6mG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJEAvc5zbQby/7trSnUhtgEpby8EZrQ490IyK54+kYIZMaKwMQ/h/hkol4xTmfCrASoZYPfpQcsXmQYRStuRFqyaGx2UiOepe0d3j+ycwUt+ZPNHAh1Ut/1P8qZUdhpRaW+IfQILyMmzrmFE9nTJDDOtB/KWwYQS5MfHJDi7IV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LUr+sO7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7433FC4CEE3;
	Tue, 29 Apr 2025 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946334;
	bh=+aWRNCWnGXnnZygDbw5iZRQLjxytlggexy/VxFr6mG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUr+sO7Kzo7Swy1sOGF3fSCbnHaKffd+xvkX6nDJpeeKyOvQg/8l5c3KrnYOP5Qxx
	 T9lXCLzLC15g01ZEjtl+wQ/dCTJd+Xoh3vgCvgVU4NyuL/zRAfxaFGjsT7ynFeHQwi
	 4xHwwC8EXqJ2CEECQBSWyqseuaV0NP7TMfc2K/0g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Yan <andy.yan@rock-chips.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 215/311] phy: rockchip: usbdp: Avoid call hpd_event_trigger in dp_phy_init
Date: Tue, 29 Apr 2025 18:40:52 +0200
Message-ID: <20250429161129.802109273@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 5b1e8a3806ed4..c04cf64f8a35d 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -1045,7 +1045,6 @@ static int rk_udphy_dp_phy_init(struct phy *phy)
 	mutex_lock(&udphy->mutex);
 
 	udphy->dp_in_use = true;
-	rk_udphy_dp_hpd_event_trigger(udphy, udphy->dp_sink_hpd_cfg);
 
 	mutex_unlock(&udphy->mutex);
 
-- 
2.39.5




