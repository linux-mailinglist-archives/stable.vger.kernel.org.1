Return-Path: <stable+bounces-371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121F37F7ACD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A7B1C20B3B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E22E39FD4;
	Fri, 24 Nov 2023 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J3xxoA08"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CA039FC3;
	Fri, 24 Nov 2023 17:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5DEC433C8;
	Fri, 24 Nov 2023 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700848725;
	bh=idIT+idDiYHDtDgymrdOkFuc2Pxhm78i7w/HDf57xr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3xxoA08ocHd5ZCuyS5v55Jpr1o1pQ6blwoGJQyk62xNzieQV4IJzVlzsFzfmpZRV
	 tD3qKO2wzRzp0pYz3Q5CTwgEh4fXhB8lri3r8LFrkV2fOp00DPbl/BboUR9oXmBUp0
	 nmFavo5XI5ylAjghFkr992lI4Pgkjo8EOebV4JfA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.19 57/97] PCI: keystone: Dont discard .remove() callback
Date: Fri, 24 Nov 2023 17:50:30 +0000
Message-ID: <20231124171936.279146843@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171934.122298957@linuxfoundation.org>
References: <20231124171934.122298957@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -376,7 +376,7 @@ static const struct dw_pcie_ops dw_pcie_
 	.link_up = ks_dw_pcie_link_up,
 };
 
-static int __exit ks_pcie_remove(struct platform_device *pdev)
+static int ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 
@@ -454,7 +454,7 @@ fail_clk:
 
 static struct platform_driver ks_pcie_driver __refdata = {
 	.probe  = ks_pcie_probe,
-	.remove = __exit_p(ks_pcie_remove),
+	.remove = ks_pcie_remove,
 	.driver = {
 		.name	= "keystone-pcie",
 		.of_match_table = of_match_ptr(ks_pcie_of_match),



