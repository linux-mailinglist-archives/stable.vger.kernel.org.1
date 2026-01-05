Return-Path: <stable+bounces-204725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A65CF3553
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BBAB30060E5
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7E233291D;
	Mon,  5 Jan 2026 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XNpl4+Hp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849F933290D
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613593; cv=none; b=pUooKQjG7gzhLtDL5bzaEyFmsgCXxm8wgFuPGkryBYgQD6I3X4jGZYKcs7cxZ4s9a8PgPsDYfnHxYrCckLUlPWtpL2sXFczg8kqbA4kGdvBDcoA8nZaEY0mQbjwkje6uWdeQTj2gWUACT6UQUcdNB7Jngbhoj2sB7kJ/ofokPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613593; c=relaxed/simple;
	bh=HAf9NIl0ANB11uecV6aUHdcdxkaygU/goJ3HdB7iQ+I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kp6hNqAK0rnTCctCJUc401DMp6zHZ21jrWJMGaX2noh8xNzRmZeFn+1RZEAPdDudWY0IeYifcoHIaNhR6jHK0WCo0fHpq21zmcQZoqNuLtVCHtVnFTTGUc9k038tv6q3hjDOhIxPEa4HXq3luptAXncYmYy3RUbewNI6MON2uSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XNpl4+Hp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01856C116D0;
	Mon,  5 Jan 2026 11:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767613592;
	bh=HAf9NIl0ANB11uecV6aUHdcdxkaygU/goJ3HdB7iQ+I=;
	h=Subject:To:Cc:From:Date:From;
	b=XNpl4+HpL7GglHKzF+fJfBWNVuRIuxAwoDvhVsenCAmAx3V34LXEMVDuU7co86GmS
	 bRGavlAUN4Sup25WLmAEm/pYeKYW1BESLYUpSqR90bjVfCXwhCfj04efaR/hio1Og/
	 7P2RiUyFRt6EpRexlwx7QDhb+JrgRqyc3e6ixix4=
Subject: FAILED: patch "[PATCH] pmdomain: imx: Fix reference count leak in imx_gpc_probe()" failed to apply to 5.15-stable tree
To: vulab@iscas.ac.cn,Frank.Li@nxp.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 12:46:15 +0100
Message-ID: <2026010515-dragonish-pelican-5b3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 73cb5f6eafb0ac7aea8cdeb8ff12981aa741d8fb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010515-dragonish-pelican-5b3c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


