Return-Path: <stable+bounces-1289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B670B7F7EE8
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C2128241A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39E6364BE;
	Fri, 24 Nov 2023 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QO9U/cnE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C22D626;
	Fri, 24 Nov 2023 18:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3195DC433C7;
	Fri, 24 Nov 2023 18:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851028;
	bh=0BTZlDPw9MpmYpuKiMkjaGCt1A59ScXfPukUEZC2Mh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QO9U/cnES+fszfYop8Ia+yiA0ohH4cUq1sfsTOkumvnqFAkeGWr5Z3MlhqsHRLoDk
	 I7A3QVtfTPXSEmOrX5/+CfEQzgUh18jz/wQSGkDsQYsAaoMntc68SNelCpmhcu/esE
	 Xfz1/9j4nbd4BymiffYY4U4BkRlXOCzSSMARt14I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.5 285/491] PCI: keystone: Dont discard .probe() callback
Date: Fri, 24 Nov 2023 17:48:41 +0000
Message-ID: <20231124172033.134393423@linuxfoundation.org>
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

commit 7994db905c0fd692cf04c527585f08a91b560144 upstream.

The __init annotation makes the ks_pcie_probe() function disappear after
booting completes. However a device can also be bound later. In that case,
we try to call ks_pcie_probe(), but the backing memory is likely already
overwritten.

The right thing to do is do always have the probe callback available.  Note
that the (wrong) __refdata annotation prevented this issue to be noticed by
modpost.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Link: https://lore.kernel.org/r/20231001170254.2506508-5-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pci-keystone.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1101,7 +1101,7 @@ static const struct of_device_id ks_pcie
 	{ },
 };
 
-static int __init ks_pcie_probe(struct platform_device *pdev)
+static int ks_pcie_probe(struct platform_device *pdev)
 {
 	const struct dw_pcie_host_ops *host_ops;
 	const struct dw_pcie_ep_ops *ep_ops;
@@ -1319,7 +1319,7 @@ static int ks_pcie_remove(struct platfor
 	return 0;
 }
 
-static struct platform_driver ks_pcie_driver __refdata = {
+static struct platform_driver ks_pcie_driver = {
 	.probe  = ks_pcie_probe,
 	.remove = ks_pcie_remove,
 	.driver = {



