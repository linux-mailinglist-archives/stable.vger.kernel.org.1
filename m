Return-Path: <stable+bounces-172095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A29B2FA77
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF191890F43
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879B132BF50;
	Thu, 21 Aug 2025 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PSNZ20mc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4849F2D24A9
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782955; cv=none; b=MrttpwIQJzzbsvftMi3R/2Qz2JCRg9FfSbnsFsBCpdYXVFcOEeVMcNqEhmAhUhsJE+74Ff3/qB1NAZwth2O0VyfBJSIdVr5vOkX5d20EqS0bNxYwrDHfG6F4w64RCmuNKj/MAy+gB9hbnKbA3CWel+Gzd+BTwJ5zknxd/99zUGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782955; c=relaxed/simple;
	bh=4aqtLwsCjDmsiFdnVGd4dSpEELlBv2N3AuwUEMXlUmk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GYgeh7wJLfebOomYxaWWQ1sdy/CXb9eXz9PTRECTbkXS7kqkukXeV9M9p0CZxtZ7rjYO7+lfO1Pck+sWHma9qaJRdZrF4pj29hNgRkNy0yBMwQou53s9YmXkqHP4nvP+KGbm2K65r7RmqKT5PJDvxlTBSPAe3+ish2u4aHA11Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PSNZ20mc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA381C4CEED;
	Thu, 21 Aug 2025 13:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782955;
	bh=4aqtLwsCjDmsiFdnVGd4dSpEELlBv2N3AuwUEMXlUmk=;
	h=Subject:To:Cc:From:Date:From;
	b=PSNZ20mco/QfYxoqIULuHMNg4SCSNxC10ogiv5ohAmKQ/napFvUvmhIYkVfdSVs4J
	 eIrsfncLN5hdNpJaqADLoDA7FEEG8Hm0tdIzNlq+NCfvzsRRdhw3DoXvZwdyxMmsiZ
	 Enf4QFrkBsAjvjapPRT9uEPzHhBgv5dfd8HFKqjU=
Subject: FAILED: patch "[PATCH] PCI: imx6: Delay link start until configfs 'start' written" failed to apply to 6.6-stable tree
To: hongxing.zhu@nxp.com,Frank.Li@nxp.com,bhelgaas@google.com,mani@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:29:11 +0200
Message-ID: <2025082111-relock-troubling-f45c@gregkh>
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
git cherry-pick -x 2e6ea70690ddd1ffa422423fd0d4523e4dfe4b62
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082111-relock-troubling-f45c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2e6ea70690ddd1ffa422423fd0d4523e4dfe4b62 Mon Sep 17 00:00:00 2001
From: Richard Zhu <hongxing.zhu@nxp.com>
Date: Wed, 9 Jul 2025 11:37:22 +0800
Subject: [PATCH] PCI: imx6: Delay link start until configfs 'start' written

According to Documentation/PCI/endpoint/pci-endpoint-cfs.rst, the Endpoint
controller (EPC) should only start the link when userspace writes '1' to
the '/sys/kernel/config/pci_ep/controllers/<EPC>/start' attribute, which
ultimately results in calling imx_pcie_start_link() via
pci_epc_start_store().

To align with the documented behavior, do not start the link automatically
when adding the EP controller.

Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
[mani: reworded commit subject and description]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250709033722.2924372-3-hongxing.zhu@nxp.com

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 240e080825bc..80e48746bbaf 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1474,9 +1474,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 
 	pci_epc_init_notify(ep->epc);
 
-	/* Start LTSSM. */
-	imx_pcie_ltssm_enable(dev);
-
 	return 0;
 }
 


