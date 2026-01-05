Return-Path: <stable+bounces-204722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A60B3CF355C
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3CF3302080E
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B388B33290D;
	Mon,  5 Jan 2026 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aKtXS97I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39C933291F
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613577; cv=none; b=Zr3RMUrptn54XJSKzcUkRESH2cQ9ZU5MZv2LpH2LEm1VHHQX2IqGLoZTAQ8vAME2fWUOvz2vb6o3xjYmHtdx7fgOAOCmiiKYfclAIrtIV2fFKKDI/SPOQCDwHX2S+JYx4Sv+o65U9zJrgWJHBvzWEh20h0co3Xp1vyo9SUefcTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613577; c=relaxed/simple;
	bh=dQyzlw/zFiCBTNL5pwkl0WVdizufr0pgGTePZRHiY8o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oE1vko8kLlKwff2cvwKuHD0xd3ry4G3lF2aTsGdMEBKLWVuDtAB2elYf/P+srfROZWoEJeWF3I+lN4Mb2adJBo3dI+yLVcs1cIWnbMMrB6WNbBshs/gleQTmLp8hYudl5D9w72T2X8ld1fGv1IkEc5QCJdLEMxOdzYBFaZw1irQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aKtXS97I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7566C116D0;
	Mon,  5 Jan 2026 11:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767613577;
	bh=dQyzlw/zFiCBTNL5pwkl0WVdizufr0pgGTePZRHiY8o=;
	h=Subject:To:Cc:From:Date:From;
	b=aKtXS97IA3tsZi69sjrkQDRKGFMHIEQIuXFG5hYq+UneZ4PM6E8ldp2gHno98Y/Nl
	 8eQw5dSWCUlWpO9Ma+Nsset5xqE/hMrt0lNGLmdjyl4t8OFj/B79wNCTi3Zy9JhBJW
	 PbLgOqzvoiJXgCknoBUYV6k7P46JTr0Rd7S9iJZQ=
Subject: FAILED: patch "[PATCH] pmdomain: imx: Fix reference count leak in imx_gpc_probe()" failed to apply to 6.6-stable tree
To: vulab@iscas.ac.cn,Frank.Li@nxp.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:46:14 +0100
Message-ID: <2026010514-aerospace-cathouse-bd44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 73cb5f6eafb0ac7aea8cdeb8ff12981aa741d8fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010514-aerospace-cathouse-bd44@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


