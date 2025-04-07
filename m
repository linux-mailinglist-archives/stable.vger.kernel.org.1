Return-Path: <stable+bounces-128645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA02A7EA41
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181A8442615
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974E125D55E;
	Mon,  7 Apr 2025 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfiMP2KK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E4B25D557;
	Mon,  7 Apr 2025 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049575; cv=none; b=hUehWwwhDRLqh7cYo0ae/Uf8+1oIoZVY74wugzPEd49kfVNDF3QJO5EEjef3geYA8jc3d5HTr3/TmUrKwD4aGRmW441UE3WxVdiU783uQawTqif8G19dhT1CZmYHSk9ngOQm99ymlg9s7O+cxd0Du8IGb9HuKRhezFT30usY59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049575; c=relaxed/simple;
	bh=lUqZd0rd4XtM1OpzBOVReCueFe1OJ6zFjC6Bpun+2DE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kU5YZX6r1SpP371653UU0JmLmC74nHFav7y0bMACzQ4x3lTn6eOHG/0BPn6CKRHxs5qNwuCVFhmaG2keE8F1Du3Ix9loL+DPYbdlrYVryG5auQ6MUk8CRhwgNQAXbf6r79o5RePzc7P5tPSTrC7eKZvvT5IOpOi7+jGP3t257Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfiMP2KK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EA8C4CEDD;
	Mon,  7 Apr 2025 18:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049574;
	bh=lUqZd0rd4XtM1OpzBOVReCueFe1OJ6zFjC6Bpun+2DE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfiMP2KKyIMh5yUUClNaeOm6Da1uO6ZKVmo6hxohYK/Mk4fiOdBDKkgslrtoIZu7x
	 3iHT0QRsVkABeI2Izfnto2s21EAQsXeZ0fZJ9C6F9kL62oJtfdqhRJ+neF1dkC9SkA
	 0ToUeG19t0AYtsd8xUHLRBlJV6zUBwJ5jTqfjUeytr18ZMe4wNu8jdkzZJO2kDPpyz
	 SwnuQHnODiNlQVtAR7uZWih7zZDTiJHw0LBKVJEzS2OtJJ6Hj8xLZbkCgIU8ogPYEC
	 9M46pAMhTuJCxrpm3epAZtUaYT2seYxhr1lvIQMhIbV4PfJLxwmF1eBJn/3/Df7L31
	 NgVLShKzctGOA==
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
Subject: [PATCH AUTOSEL 6.13 16/28] phy: rockchip: usbdp: Avoid call hpd_event_trigger in dp_phy_init
Date: Mon,  7 Apr 2025 14:12:06 -0400
Message-Id: <20250407181224.3180941-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
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


