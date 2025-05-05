Return-Path: <stable+bounces-140197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDACAAA615
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D51F97B43C2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A58531DA60;
	Mon,  5 May 2025 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YegHN7je"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20EA31DA59;
	Mon,  5 May 2025 22:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484317; cv=none; b=QzmxbhdYGeeUoAwk78rlkSE47GNTX8XZFgGtut+IQCS3HApbeRmlOvgP7HBzQWBsyZtWZoHgXbvNf/50ZjvYBUJMY4l0s1NG4LWznRfHG5hIk2K1ZKCwV54XRf2vI0uKRS2EhiArvMUN4vIRAXoRTJcQyL1Waz4uLVCaErXNY9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484317; c=relaxed/simple;
	bh=RJzjm2jlMUB/SBLIUQp0a59U9HrB8VfoOl2O1qsQVxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrXs9OO7O11D5qgo6tRrZ1/o3ptc7edtbMQVOosEgKh9+LnOyx7xACyr6ebkYN2eWUnv3U2D5oEfwGg2y7RW+G/oJ5W2jtF0H+09bFEj8jn8lySCIrhW9qMxH0SWkLnvTpDnqiNYPHI68sOirHPlSKIZfI3xqWS0gJSI6xbiNPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YegHN7je; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC534C4CEEF;
	Mon,  5 May 2025 22:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484316;
	bh=RJzjm2jlMUB/SBLIUQp0a59U9HrB8VfoOl2O1qsQVxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YegHN7jeXMIZqecNqCrivsJDs/1cIdvz88SUTdgrXCDqmfL3mHLzlqLp35CnVc8Fb
	 /fzvAC1rIl89Fd7YAdxmOFvICkIOx3/134ZX8VF0WopIN9Kt82/RKrljtc3w+Cu2xB
	 vRUII7hnltIM2BDDwRFEFhaVBO7T3MZh05uGQT7gBXSzRiirXj5iIv/wx77+eDhaG9
	 pss6RocPnwOPaP5ecQkRcBNxjBRbD0hgZm6r14psga34JFcpgtUoiwyjpvLrw962iK
	 OgR5p4CeyMCDU4t3nagkpNK2ky/gG57aet+ZpDQHqe5h2nwKx9YqQARPAKI5SXSkSr
	 WfCgFg96cXiTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Damon Ding <damon.ding@rock-chips.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kishon@kernel.org,
	heiko@sntech.de,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 450/642] phy: phy-rockchip-samsung-hdptx: Swap the definitions of LCPLL_REF and ROPLL_REF
Date: Mon,  5 May 2025 18:11:06 -0400
Message-Id: <20250505221419.2672473-450-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Damon Ding <damon.ding@rock-chips.com>

[ Upstream commit 2947c8065e9efdd3b6434d2817dc8896234a3fc0 ]

According to the datasheet, setting the dig_clk_sel bit of CMN_REG(0097)
to 1'b1 selects LCPLL as the reference clock, while setting it to 1'b0
selects the ROPLL.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20250205105157.580060-2-damon.ding@rock-chips.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 2fb4f297fda3d..920abf6fa9bdd 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -94,8 +94,8 @@
 #define LCPLL_ALONE_MODE		BIT(1)
 /* CMN_REG(0097) */
 #define DIG_CLK_SEL			BIT(1)
-#define ROPLL_REF			BIT(1)
-#define LCPLL_REF			0
+#define LCPLL_REF			BIT(1)
+#define ROPLL_REF			0
 /* CMN_REG(0099) */
 #define CMN_ROPLL_ALONE_MODE		BIT(2)
 #define ROPLL_ALONE_MODE		BIT(2)
-- 
2.39.5


