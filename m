Return-Path: <stable+bounces-13438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01CF837C11
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C1229538C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2AC3B790;
	Tue, 23 Jan 2024 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PcONZDPG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4322CA6;
	Tue, 23 Jan 2024 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969492; cv=none; b=P8F4Rj8IQI0oUu27QGjF+t8CSBeMfVcHAQCYMFpuwjnKfyO5B8XRS60vCpL51o1gAhF8ht7I5GS69uIrc+UZS8g/r1evlwJl6B2EN+kvnH4LHjmR/WN856FcueL4BRUSDBdSCORbPC7aXVc2rTU2PptZQd18AwFdRp9tOwQtHQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969492; c=relaxed/simple;
	bh=FyxF/wJE0x7TxZXFHqePav+Yll8EmStNCk5gGzkuWjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxgVxFLA4zZmXqxwi8nvalQJUCjJGs6XirTG3j1VSIncQtH1dYBKN+2B45eCfOzrAvYbylIqGonZnl9APrcxb0Oo6LwLd6b6Hc3lMVC7urjCBGq4WX2S9uhVKcxFq4550eWCgcxBy7gaLOAciSwk4FTL06Ab5YSrP22xetFMufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PcONZDPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4A8C43399;
	Tue, 23 Jan 2024 00:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969491;
	bh=FyxF/wJE0x7TxZXFHqePav+Yll8EmStNCk5gGzkuWjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PcONZDPGAAqFI4ah02q4WCSJCcleo+e02xW6pniJoDYNa5mEvDQO28MdpVMGQB1+w
	 vF8CB0XfvinI0GGIEfPtZX14yP6DJR+q81diK+cGEwTkN7uADYop4FmOl7pQe8eL1g
	 Gh3Nj7qsZR72RiJbGcjDro2wMbd7WO0Lajg4i+vY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 281/641] drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks
Date: Mon, 22 Jan 2024 15:53:05 -0800
Message-ID: <20240122235826.703344503@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 3d07a411b4faaf2b498760ccf12888f8de529de0 ]

This helper has been introduced to avoid programmer errors (missing
_put calls leading to dangling refcnt) when using pm_runtime_get, use it.

While at it, start checking the return value.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 5c8290284402 ("drm/msm/dsi: Split PHY drivers to separate files")
Patchwork: https://patchwork.freedesktop.org/patch/543350/
Link: https://lore.kernel.org/r/20230620-topic-dsiphy_rpm-v2-1-a11a751f34f0@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 05621e5e7d63..b6314bb66d2f 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -516,7 +516,9 @@ static int dsi_phy_enable_resource(struct msm_dsi_phy *phy)
 	struct device *dev = &phy->pdev->dev;
 	int ret;
 
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
 
 	ret = clk_prepare_enable(phy->ahb_clk);
 	if (ret) {
-- 
2.43.0




