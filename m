Return-Path: <stable+bounces-1975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38E37F8238
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED62B237B1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9A1A5A4;
	Fri, 24 Nov 2023 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oOvIoRFB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A9C2E64F;
	Fri, 24 Nov 2023 19:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE11C433C7;
	Fri, 24 Nov 2023 19:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852740;
	bh=WoyiGyZrze/ll57fEhMYecyNNjqp8DkMpkOIT9a8gQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOvIoRFBnN6m+0koYvmu+tPEiGFexS7zSNXNszw/mI4sen3S2NZvA2sdUrfq1ezK1
	 NASvFgVbX99gMQ4DIt2NoQLeMs0vkKBdX9XhTaPLBBflkfufY3fVUwJNSSQo9hgq6p
	 wNENwSspLfQrlKnqGoBuOzzkQm+YwJs0RvWF0stw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 5.10 104/193] PCI/sysfs: Protect drivers D3cold preference from user space
Date: Fri, 24 Nov 2023 17:53:51 +0000
Message-ID: <20231124171951.402336472@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171947.127438872@linuxfoundation.org>
References: <20231124171947.127438872@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 70b70a4307cccebe91388337b1c85735ce4de6ff upstream.

struct pci_dev contains two flags which govern whether the device may
suspend to D3cold:

* no_d3cold provides an opt-out for drivers (e.g. if a device is known
  to not wake from D3cold)

* d3cold_allowed provides an opt-out for user space (default is true,
  user space may set to false)

Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend"),
the user space setting overwrites the driver setting.  Essentially user
space is trusted to know better than the driver whether D3cold is
working.

That feels unsafe and wrong.  Assume that the change was introduced
inadvertently and do not overwrite no_d3cold when d3cold_allowed is
modified.  Instead, consider d3cold_allowed in addition to no_d3cold
when choosing a suspend state for the device.

That way, user space may opt out of D3cold if the driver hasn't, but it
may no longer force an opt in if the driver has opted out.

Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Link: https://lore.kernel.org/r/b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org	# v4.8+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci-acpi.c  |    2 +-
 drivers/pci/pci-sysfs.c |    5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -909,7 +909,7 @@ static pci_power_t acpi_pci_choose_state
 {
 	int acpi_state, d_max;
 
-	if (pdev->no_d3cold)
+	if (pdev->no_d3cold || !pdev->d3cold_allowed)
 		d_max = ACPI_STATE_D3_HOT;
 	else
 		d_max = ACPI_STATE_D3_COLD;
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -500,10 +500,7 @@ static ssize_t d3cold_allowed_store(stru
 		return -EINVAL;
 
 	pdev->d3cold_allowed = !!val;
-	if (pdev->d3cold_allowed)
-		pci_d3cold_enable(pdev);
-	else
-		pci_d3cold_disable(pdev);
+	pci_bridge_d3_update(pdev);
 
 	pm_runtime_resume(dev);
 



