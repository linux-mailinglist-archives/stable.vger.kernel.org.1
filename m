Return-Path: <stable+bounces-422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659617F7B02
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DFEB20DAD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35E39FF2;
	Fri, 24 Nov 2023 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yvKrWtOK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B339FDD;
	Fri, 24 Nov 2023 18:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D223C433C7;
	Fri, 24 Nov 2023 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700848857;
	bh=cXQyM5dBFnfpKrls6Uc9XrJWzZGgFxc1EEmPwMBQj1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yvKrWtOKLjMcq3gv7aIdIrqFKzwqjVliTFAOGSa9jpl1UONL2HTmCuduY8Z00D1YL
	 Uf/dlNkO8qBiWVDj0TrxLfKYJJFiRtSr7wFK+7P4v06RceV4OaUMPVWSm3/gF4fXLq
	 UVuH4j+a7iEq5bTqqkdPbbXN357riYOH6BnHMyQ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacky Bai <ping.bai@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 02/57] clocksource/drivers/timer-imx-gpt: Fix potential memory leak
Date: Fri, 24 Nov 2023 17:50:26 +0000
Message-ID: <20231124171930.365963582@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171930.281665051@linuxfoundation.org>
References: <20231124171930.281665051@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacky Bai <ping.bai@nxp.com>

[ Upstream commit 8051a993ce222a5158bccc6ac22ace9253dd71cb ]

Fix coverity Issue CID 250382:  Resource leak (RESOURCE_LEAK).
Add kfree when error return.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231009083922.1942971-1-ping.bai@nxp.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-imx-gpt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 6ec6d79b237ce..fcc12f72e907f 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -489,12 +489,16 @@ static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type t
 		return -ENOMEM;
 
 	imxtm->base = of_iomap(np, 0);
-	if (!imxtm->base)
-		return -ENXIO;
+	if (!imxtm->base) {
+		ret = -ENXIO;
+		goto err_kfree;
+	}
 
 	imxtm->irq = irq_of_parse_and_map(np, 0);
-	if (imxtm->irq <= 0)
-		return -EINVAL;
+	if (imxtm->irq <= 0) {
+		ret = -EINVAL;
+		goto err_kfree;
+	}
 
 	imxtm->clk_ipg = of_clk_get_by_name(np, "ipg");
 
@@ -507,11 +511,15 @@ static int __init mxc_timer_init_dt(struct device_node *np,  enum imx_gpt_type t
 
 	ret = _mxc_timer_init(imxtm);
 	if (ret)
-		return ret;
+		goto err_kfree;
 
 	initialized = 1;
 
 	return 0;
+
+err_kfree:
+	kfree(imxtm);
+	return ret;
 }
 
 static int __init imx1_timer_init_dt(struct device_node *np)
-- 
2.42.0




