Return-Path: <stable+bounces-186089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85081BE3926
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 15:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F366C5065FA
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674583375C6;
	Thu, 16 Oct 2025 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p4fr8YSC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7543375BD
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619559; cv=none; b=Z3+iV3b5wYdQ/5HQ+u9cr79p83t9vt9EbRO/98fdTRwDuuG9nc1JshwPzz5UbXT8FeDa+3ALwCSJM41mfc0mkDDZIcrCpht6LF/1QLQc+6xM7idn0gaCrS1f+8rLXgYKqNGtLl4OkJjlQ8MQNdF35X9JYa6u2R1xoVppYHhV/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619559; c=relaxed/simple;
	bh=3ajf2VjlFXNCd1tuYPr+oYCcbQZx7xSjRscmLS8Fcmg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CXHhC18uL6k0vlTXl7BNeKOag+ndGs4CXmNeKs41x+rzPYD0H+6yS+9RaNR317gs3iU/obc27RJCCAit6pWn/J274gNQw4CMJMrJzzRr31XrRYY/rTHVHt/Qn955rdesNxGkNn0oioQanmQQdB9cCkhkp8Ohr7QWEaenz3xdDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p4fr8YSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9A1C4CEF1;
	Thu, 16 Oct 2025 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760619557;
	bh=3ajf2VjlFXNCd1tuYPr+oYCcbQZx7xSjRscmLS8Fcmg=;
	h=Subject:To:Cc:From:Date:From;
	b=p4fr8YSCcGFYgZgfoeKfn9y8ELzVQeThJLEixMs4Nhm/KG3wGRoUpBCZ9ypMuJwfS
	 MgIRfeUQy0E2i6Vws1tv/OMlSBQGEUdne6UKLC6etUiD1K/ro9OXS6aKEkII1ObeDa
	 Xzx5BkDkWGmM/huz/xfdNJ85RYOBAtRjUbufC0j4=
Subject: FAILED: patch "[PATCH] PCI: j721e: Fix programming sequence of "strap" settings" failed to apply to 6.6-stable tree
To: s-vadapalli@ti.com,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 14:59:14 +0200
Message-ID: <2025101614-regulator-gumball-c7c6@gregkh>
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
git cherry-pick -x f842d3313ba179d4005096357289c7ad09cec575
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101614-regulator-gumball-c7c6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f842d3313ba179d4005096357289c7ad09cec575 Mon Sep 17 00:00:00 2001
From: Siddharth Vadapalli <s-vadapalli@ti.com>
Date: Mon, 8 Sep 2025 17:38:27 +0530
Subject: [PATCH] PCI: j721e: Fix programming sequence of "strap" settings

The Cadence PCIe Controller integrated in the TI K3 SoCs supports both
Root-Complex and Endpoint modes of operation. The Glue Layer allows
"strapping" the Mode of operation of the Controller, the Link Speed
and the Link Width. This is enabled by programming the "PCIEn_CTRL"
register (n corresponds to the PCIe instance) within the CTRL_MMR
memory-mapped register space. The "reset-values" of the registers are
also different depending on the mode of operation.

Since the PCIe Controller latches onto the "reset-values" immediately
after being powered on, if the Glue Layer configuration is not done while
the PCIe Controller is off, it will result in the PCIe Controller latching
onto the wrong "reset-values". In practice, this will show up as a wrong
representation of the PCIe Controller's capability structures in the PCIe
Configuration Space. Some such capabilities which are supported by the PCIe
Controller in the Root-Complex mode but are incorrectly latched onto as
being unsupported are:
- Link Bandwidth Notification
- Alternate Routing ID (ARI) Forwarding Support
- Next capability offset within Advanced Error Reporting (AER) capability

Fix this by powering off the PCIe Controller before programming the "strap"
settings and powering it on after that. The runtime PM APIs namely
pm_runtime_put_sync() and pm_runtime_get_sync() will decrement and
increment the usage counter respectively, causing GENPD to power off and
power on the PCIe Controller.

Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250908120828.1471776-1-s-vadapalli@ti.com

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index cfca13a4c840..5a9ae33e2b93 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -284,6 +284,25 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 	if (!ret)
 		offset = args.args[0];
 
+	/*
+	 * The PCIe Controller's registers have different "reset-values"
+	 * depending on the "strap" settings programmed into the PCIEn_CTRL
+	 * register within the CTRL_MMR memory-mapped register space.
+	 * The registers latch onto a "reset-value" based on the "strap"
+	 * settings sampled after the PCIe Controller is powered on.
+	 * To ensure that the "reset-values" are sampled accurately, power
+	 * off the PCIe Controller before programming the "strap" settings
+	 * and power it on after that. The runtime PM APIs namely
+	 * pm_runtime_put_sync() and pm_runtime_get_sync() will decrement and
+	 * increment the usage counter respectively, causing GENPD to power off
+	 * and power on the PCIe Controller.
+	 */
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to power off PCIe Controller\n");
+		return ret;
+	}
+
 	ret = j721e_pcie_set_mode(pcie, syscon, offset);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set pci mode\n");
@@ -302,6 +321,12 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 		return ret;
 	}
 
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to power on PCIe Controller\n");
+		return ret;
+	}
+
 	/* Enable ACSPCIE refclk output if the optional property exists */
 	syscon = syscon_regmap_lookup_by_phandle_optional(node,
 						"ti,syscon-acspcie-proxy-ctrl");


