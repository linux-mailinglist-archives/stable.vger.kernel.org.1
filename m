Return-Path: <stable+bounces-91607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536D99BEEC4
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE598B24229
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9EF1DF97A;
	Wed,  6 Nov 2024 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C0MNjjt+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE481E0084;
	Wed,  6 Nov 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730899230; cv=none; b=rUXJXCjwuAvYZCd8hN3mp8AQEacEcmwkS7WkrySpqlvv5aYeSM5XL5SPI4O91HgRqZuih/jSZ2NYKSIZ1e6YO5Ttg8WB4UjyjYLnXKvw1LGB8IOvJ3XfIFKbS1VL92CErWjXcWTZhYDwuBAGoGGE2ayUo8HBYN+y/ifJf9F16I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730899230; c=relaxed/simple;
	bh=EscggTlvtE0erWj+8wYqdpsHFkTk4dL8eFwxj/zs2Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxFS8sE/wFbwEGZzY4sl8uqKwkTO5QEyUslumx6uTOs8BsmwTeuRK4cDM9QlVsoOX+v4b/LRDtFuuhaPJlzWzfxf31lRACEUy55dj76PqjxWpCP6qiJkXX+kByCtaXCskPbxdI9OzdwbbncXorBK/RmsJrQleeh86lYtVc2BiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C0MNjjt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A827C4CECD;
	Wed,  6 Nov 2024 13:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730899230;
	bh=EscggTlvtE0erWj+8wYqdpsHFkTk4dL8eFwxj/zs2Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0MNjjt+baEliR6McqlBCPHrHTceaGewmysWyD5cILCRPRR50D70hFfs6H+JDNltu
	 5IdHQyasu14gSKlMNYX5HpZCQrAZN2CqnzlEK6gzaIcsce+sYbtauay1/M+a7JOnYn
	 0Ki8VhJ8C0rLvWfwioi1tHcb0DQvuYQSnQP2muSE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 5.15 42/73] xhci: Use pm_runtime_get to prevent RPM on unsupported systems
Date: Wed,  6 Nov 2024 13:05:46 +0100
Message-ID: <20241106120301.219210069@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120259.955073160@linuxfoundation.org>
References: <20241106120259.955073160@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

commit 31004740e42846a6f0bb255e6348281df3eb8032 upstream.

Use pm_runtime_put in the remove function and pm_runtime_get to disable
RPM on platforms that don't support runtime D3, as re-enabling it through
sysfs auto power control may cause the controller to malfunction. This
can lead to issues such as hotplug devices not being detected due to
failed interrupt generation.

Fixes: a5d6264b638e ("xhci: Enable RPM on controllers that support low-power states")
Cc: stable <stable@kernel.org>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20241024133718.723846-1-Basavaraj.Natikar@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-pci.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -527,7 +527,7 @@ static int xhci_pci_probe(struct pci_dev
 	pm_runtime_put_noidle(&dev->dev);
 
 	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
-		pm_runtime_forbid(&dev->dev);
+		pm_runtime_get(&dev->dev);
 	else if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_allow(&dev->dev);
 
@@ -554,7 +554,9 @@ static void xhci_pci_remove(struct pci_d
 
 	xhci->xhc_state |= XHCI_STATE_REMOVING;
 
-	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
+	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
+		pm_runtime_put(&dev->dev);
+	else if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_forbid(&dev->dev);
 
 	if (xhci->shared_hcd) {



