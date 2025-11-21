Return-Path: <stable+bounces-196510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6078EC7A9A2
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CFE24E4CCB
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FE02FE05F;
	Fri, 21 Nov 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFIyWsYk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E02EB856
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763739645; cv=none; b=WYoLFawdSEK8L0DJg+Bf3NLS0gOa48rL0XyGNCATpf/n83XhPiKHv0lBxNKl2QcT2i7d+0y/ArA9C2bWqXCB+3C4cykYJxGJJdbuEjyfXrDmoYUYSyCUKYIxBpY69uwRh5sK0K9IwGZnH+8nNOCIyHHczoZsQf1y05NmFP6gboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763739645; c=relaxed/simple;
	bh=uUAbXRowBgK5JjFCR+mIlEd/zukY/cC49YnlYPo/ijE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soY9WIqZRB7Vzh59Y3n+ntX19oVzMU4g5Y0L6MYOvv+oheqyb6R3L8UoxBL9lGudsW6W9DnEp4Aah2gKxwZjm7paoedGn7mrwXd2Cv0U8XTINxEinl2TEbDtxOlC98JGEqcCFbbVtdFjE/lkcRizC6z7kxiuwbJG9KMakjD8nA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFIyWsYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C04C4CEF1;
	Fri, 21 Nov 2025 15:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763739643;
	bh=uUAbXRowBgK5JjFCR+mIlEd/zukY/cC49YnlYPo/ijE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFIyWsYkwz+GC6FD2tgwsnM62QIyZrGII5cjkSkJCNd6lm5VtA7vkgHqpAsT11LaK
	 JZAYfwutTJAgF9imvh72I5drEEScVy5XWXXPG4jedsR4VPscKpf8tTHOr3ZOL+/iQX
	 AXiPNc6ispOtgoKYrIZLBks62E/7O3BufK1cSnbjaIMdw/2cx59o1/VePXpPoWfy24
	 KohvB9GrtgGs1qG0sOvDybntXGZ80fDj93TY6GopJJ+KrwwHolxIZiRVP3Fbh6Nx62
	 yZuvOk7nI8YuBMkjjjwTEvG9B7s3ODxsWwMxvAKoKtndHr5f5BwCdll8ScARsYPqmD
	 3I4jTjxWUF6xA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] pmdomain: imx-gpc: Convert to platform remove callback returning void
Date: Fri, 21 Nov 2025 10:40:40 -0500
Message-ID: <20251121154041.2577393-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112009-appliance-symptom-7a59@gregkh>
References: <2025112009-appliance-symptom-7a59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit da07c5871d18157608a0d0702cb093168d79080a ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

In the error path emit an error message replacing the (less useful)
message by the core. Apart from the improved error message there is no
change in behaviour.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231124080623.564924-3-u.kleine-koenig@pengutronix.de
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Stable-dep-of: bbde14682eba ("pmdomain: imx: Fix reference count leak in imx_gpc_remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pmdomain/imx/gpc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 419ed15cc10c4..66703395b1795 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -512,7 +512,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int imx_gpc_remove(struct platform_device *pdev)
+static void imx_gpc_remove(struct platform_device *pdev)
 {
 	struct device_node *pgc_node;
 	int ret;
@@ -522,7 +522,7 @@ static int imx_gpc_remove(struct platform_device *pdev)
 	/* bail out if DT too old and doesn't provide the necessary info */
 	if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
 	    !pgc_node)
-		return 0;
+		return;
 
 	/*
 	 * If the old DT binding is used the toplevel driver needs to
@@ -532,16 +532,20 @@ static int imx_gpc_remove(struct platform_device *pdev)
 		of_genpd_del_provider(pdev->dev.of_node);
 
 		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_PU].base);
-		if (ret)
-			return ret;
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to remove PU power domain (%pe)\n",
+				ERR_PTR(ret));
+			return;
+		}
 		imx_pgc_put_clocks(&imx_gpc_domains[GPC_PGC_DOMAIN_PU]);
 
 		ret = pm_genpd_remove(&imx_gpc_domains[GPC_PGC_DOMAIN_ARM].base);
-		if (ret)
-			return ret;
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to remove ARM power domain (%pe)\n",
+				ERR_PTR(ret));
+			return;
+		}
 	}
-
-	return 0;
 }
 
 static struct platform_driver imx_gpc_driver = {
@@ -550,6 +554,6 @@ static struct platform_driver imx_gpc_driver = {
 		.of_match_table = imx_gpc_dt_ids,
 	},
 	.probe = imx_gpc_probe,
-	.remove = imx_gpc_remove,
+	.remove_new = imx_gpc_remove,
 };
 builtin_platform_driver(imx_gpc_driver)
-- 
2.51.0


