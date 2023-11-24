Return-Path: <stable+bounces-822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D632C7F7CB7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2371F20FBE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66EF3A8CA;
	Fri, 24 Nov 2023 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CEZ7Ogzy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808443A8C2;
	Fri, 24 Nov 2023 18:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03704C433C8;
	Fri, 24 Nov 2023 18:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849863;
	bh=vqsecyOIMGRPhH04Fmf/3ITDgDwV6lfUh2QTiBljrw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CEZ7OgzydhOlB79XGTni0mGdV2vwp3ioWtNgYzoborjoxCshyzRfV4LBZME75IiCt
	 G/oRccrGHu1CFHNsH44IqOQpcdND2M/ic0g99Xugrk5EGH1XXw88B/+ViuGLfZCniV
	 bqvh0nmMLhz7wOk5mxxKtvorrNPzSgpTJ5M1k6xA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.6 326/530] PCI: kirin: Dont discard .remove() callback
Date: Fri, 24 Nov 2023 17:48:12 +0000
Message-ID: <20231124172037.950927399@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

commit 3064ef2e88c1629c1e67a77d7bc20020b35846f2 upstream.

With CONFIG_PCIE_KIRIN=y and kirin_pcie_remove() marked with __exit, the
function is discarded from the driver. In this case a bound device can
still get unbound, e.g via sysfs. Then no cleanup code is run resulting in
resource leaks or worse.

The right thing to do is do always have the remove callback available.
This fixes the following warning by modpost:

  drivers/pci/controller/dwc/pcie-kirin: section mismatch in reference: kirin_pcie_driver+0x8 (section: .data) -> kirin_pcie_remove (section: .exit.text)

(with ARCH=x86_64 W=1 allmodconfig).

Fixes: 000f60db784b ("PCI: kirin: Add support for a PHY layer")
Link: https://lore.kernel.org/r/20231001170254.2506508-3-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-kirin.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -741,7 +741,7 @@ err:
 	return ret;
 }
 
-static int __exit kirin_pcie_remove(struct platform_device *pdev)
+static int kirin_pcie_remove(struct platform_device *pdev)
 {
 	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
 
@@ -818,7 +818,7 @@ static int kirin_pcie_probe(struct platf
 
 static struct platform_driver kirin_pcie_driver = {
 	.probe			= kirin_pcie_probe,
-	.remove	        	= __exit_p(kirin_pcie_remove),
+	.remove	        	= kirin_pcie_remove,
 	.driver			= {
 		.name			= "kirin-pcie",
 		.of_match_table		= kirin_pcie_match,



