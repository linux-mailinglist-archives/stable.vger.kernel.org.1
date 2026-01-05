Return-Path: <stable+bounces-204723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC98CF354D
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 297973004E33
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF68133291D;
	Mon,  5 Jan 2026 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z5oCrsJ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A2316199
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613586; cv=none; b=MKazGBj32G27NIwQ1dqSpcr00PUv6nBOsVhlnu2Z/8uidlKaBKURHbypty/zhABILymUPQxBSG13tz0AVsINoRa4j9C0FP3v02pJqZIMOeey0rvu3d0BNuwjbxVeTP5rvDEbDKnQHtVqcDMESwlSW7nBGr85jZo3lSf0G3+BPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613586; c=relaxed/simple;
	bh=81oy82DlZKIUMHuR8sM00DWUWgrEAWG6iTnt2gD2+iI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F77KMFRElslei3IVfEX70VqBjSsmxbYOkEyAG2YPhOSjULHTXosI/WlUiuekfG+xMZvA1fl9m0cNx/OXSio3mmINKDWQF5r8RiapmlwNFaG/PAQfVAGvXSX9IKA8loRDRQQF0Pr9Lybpp1xXd8xxcjtUQ+HlbJwOIUiuEI59M8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z5oCrsJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8A5C116D0;
	Mon,  5 Jan 2026 11:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767613585;
	bh=81oy82DlZKIUMHuR8sM00DWUWgrEAWG6iTnt2gD2+iI=;
	h=Subject:To:Cc:From:Date:From;
	b=z5oCrsJ9sUM8BnTLkSzUSpbgWJWNAJfx7JY3dBpCuNHabAjgcwnFNDI7C+8dGECOf
	 Amo4HPQicyJJzmBeTzklK4muQyYMGwDR73Te7L3nys/COtLOSeVk9X6IRk3DY7UnAf
	 klXS+Jlj1bdgEJF99eLzXwg7rUU718oQ4d4lgisE=
Subject: FAILED: patch "[PATCH] pmdomain: imx: Fix reference count leak in imx_gpc_probe()" failed to apply to 6.1-stable tree
To: vulab@iscas.ac.cn,Frank.Li@nxp.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:46:14 +0100
Message-ID: <2026010514-cahoots-scholar-954d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 73cb5f6eafb0ac7aea8cdeb8ff12981aa741d8fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010514-cahoots-scholar-954d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 73cb5f6eafb0ac7aea8cdeb8ff12981aa741d8fb Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 11 Dec 2025 04:02:52 +0000
Subject: [PATCH] pmdomain: imx: Fix reference count leak in imx_gpc_probe()

of_get_child_by_name() returns a node pointer with refcount incremented.
Use the __free() attribute to manage the pgc_node reference, ensuring
automatic of_node_put() cleanup when pgc_node goes out of scope.

This eliminates the need for explicit error handling paths and avoids
reference count leaks.

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index a34b260274f7..de695f1944ab 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -402,13 +402,12 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
 static int imx_gpc_probe(struct platform_device *pdev)
 {
 	const struct imx_gpc_dt_data *of_id_data = device_get_match_data(&pdev->dev);
-	struct device_node *pgc_node;
+	struct device_node *pgc_node __free(device_node)
+		= of_get_child_by_name(pdev->dev.of_node, "pgc");
 	struct regmap *regmap;
 	void __iomem *base;
 	int ret;
 
-	pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
-
 	/* bail out if DT too old and doesn't provide the necessary info */
 	if (!of_property_present(pdev->dev.of_node, "#power-domain-cells") &&
 	    !pgc_node)


