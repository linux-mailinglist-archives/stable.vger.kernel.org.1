Return-Path: <stable+bounces-1288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8947F7EE9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B0FB217B3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3A32FC4E;
	Fri, 24 Nov 2023 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="03+qg7jc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4AC33CC2;
	Fri, 24 Nov 2023 18:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01EAC433C8;
	Fri, 24 Nov 2023 18:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851026;
	bh=1kb9tNp+oqK6FtL9wS6bfeqiBjyxC7ck4VC/8zr51Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=03+qg7jcBQfUnbtVYdwEqqYXFJ17IayezORvyI6c0vAzp55mCVlb205r0EJtQS/DC
	 i8RtLPh65PWMl+zfnEyAouEbCqtbiIu55VDs+hlSNY1Fxtpmv+D/CUdFZG/GRQP6P+
	 WoX8r4hkN2sNqCh3xP670M/giUL51lQ/AjkpPrOw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.5 284/491] PCI: keystone: Dont discard .remove() callback
Date: Fri, 24 Nov 2023 17:48:40 +0000
Message-ID: <20231124172033.108894472@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

commit 200bddbb3f5202bbce96444fdc416305de14f547 upstream.

With CONFIG_PCIE_KEYSTONE=y and ks_pcie_remove() marked with __exit, the
function is discarded from the driver. In this case a bound device can
still get unbound, e.g via sysfs. Then no cleanup code is run resulting in
resource leaks or worse.

The right thing to do is do always have the remove callback available.
Note that this driver cannot be compiled as a module, so ks_pcie_remove()
was always discarded before this change and modpost couldn't warn about
this issue. Furthermore the __ref annotation also prevents a warning.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Link: https://lore.kernel.org/r/20231001170254.2506508-4-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pci-keystone.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1303,7 +1303,7 @@ err_link:
 	return ret;
 }
 
-static int __exit ks_pcie_remove(struct platform_device *pdev)
+static int ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 	struct device_link **link = ks_pcie->link;
@@ -1321,7 +1321,7 @@ static int __exit ks_pcie_remove(struct
 
 static struct platform_driver ks_pcie_driver __refdata = {
 	.probe  = ks_pcie_probe,
-	.remove = __exit_p(ks_pcie_remove),
+	.remove = ks_pcie_remove,
 	.driver = {
 		.name	= "keystone-pcie",
 		.of_match_table = ks_pcie_of_match,



