Return-Path: <stable+bounces-203952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F3ACE7A0E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39928301BE8E
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CB232FA3C;
	Mon, 29 Dec 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Chb3UJeq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E43191A7;
	Mon, 29 Dec 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025634; cv=none; b=Us0STM7f9gmkBcu8NCGzvwbppqvarkV8gNSxBwXb2xReWMVfurMI+0RiwLVJU7VdtjiE2ZgY5vUNdHBkjuEENsV7EvUIT3rMHt8wmjkKgLhcLDIT/n2p/Mak76d99HRbkQjgnWjyIdl2PyaEKawxRtovS6oo3rbu2N6r9lEsYBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025634; c=relaxed/simple;
	bh=AfEpBfISoHmXFd7q8Tbs5ZD5LunXHkEbE84cNolLEC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g78x7pkysdd+fWOIbP3u4FWrUY3AhnUvIrzGm/G6vLxxwreIaPZhZeETaV5LPwlirr9Q/aCLGQZYl9vXWPn2Ck8eqsaSNc19F9umoO4hYEGXkMdiiJDAFS64yEdKVc+EtwBE3CQCzjX7D9LR34qPrsqDTE2vIAdHsvZ1hOeMJLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Chb3UJeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C235C4CEF7;
	Mon, 29 Dec 2025 16:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025633;
	bh=AfEpBfISoHmXFd7q8Tbs5ZD5LunXHkEbE84cNolLEC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Chb3UJeqvhhWaiMTthfqviOENqSGrtXOA1sPR6Lp86wQYSXDq5PfdVECdAg8Qiwdu
	 SSUGknU1N2JciPSl13bLlJgXYJSzzO/s/BcTfQ9813aJdQj1fyipcHhrKeeTT/HH79
	 MjJI6HPEFgRJ2vIyWWSOCrt0Cjor6RUHcd/zG1Bo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.18 283/430] phy: broadcom: bcm63xx-usbh: fix section mismatches
Date: Mon, 29 Dec 2025 17:11:25 +0100
Message-ID: <20251229160734.760576637@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 356d1924b9a6bc2164ce2bf1fad147b0c37ae085 upstream.

Platform drivers can be probed after their init sections have been
discarded (e.g. on probe deferral or manual rebind through sysfs) so the
probe function and match table must not live in init.

Fixes: 783f6d3dcf35 ("phy: bcm63xx-usbh: Add BCM63xx USBH driver")
Cc: stable@vger.kernel.org	# 5.9
Cc: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20251017054537.6884-1-johan@kernel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/phy/broadcom/phy-bcm63xx-usbh.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/phy/broadcom/phy-bcm63xx-usbh.c
+++ b/drivers/phy/broadcom/phy-bcm63xx-usbh.c
@@ -375,7 +375,7 @@ static struct phy *bcm63xx_usbh_phy_xlat
 	return of_phy_simple_xlate(dev, args);
 }
 
-static int __init bcm63xx_usbh_phy_probe(struct platform_device *pdev)
+static int bcm63xx_usbh_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct bcm63xx_usbh_phy	*usbh;
@@ -432,7 +432,7 @@ static int __init bcm63xx_usbh_phy_probe
 	return 0;
 }
 
-static const struct of_device_id bcm63xx_usbh_phy_ids[] __initconst = {
+static const struct of_device_id bcm63xx_usbh_phy_ids[] = {
 	{ .compatible = "brcm,bcm6318-usbh-phy", .data = &usbh_bcm6318 },
 	{ .compatible = "brcm,bcm6328-usbh-phy", .data = &usbh_bcm6328 },
 	{ .compatible = "brcm,bcm6358-usbh-phy", .data = &usbh_bcm6358 },
@@ -443,7 +443,7 @@ static const struct of_device_id bcm63xx
 };
 MODULE_DEVICE_TABLE(of, bcm63xx_usbh_phy_ids);
 
-static struct platform_driver bcm63xx_usbh_phy_driver __refdata = {
+static struct platform_driver bcm63xx_usbh_phy_driver = {
 	.driver	= {
 		.name = "bcm63xx-usbh-phy",
 		.of_match_table = bcm63xx_usbh_phy_ids,



