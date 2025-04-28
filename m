Return-Path: <stable+bounces-136876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DADDA9F024
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 14:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C907AF2E9
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EED2676C1;
	Mon, 28 Apr 2025 11:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k488lfLP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A58267B1A
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841479; cv=none; b=NPaftojxJ8UZzSbmjWfy/xV5IHudnqBANFrVo8s1Oi+Ky0+fjXG0DtiffTtNa9vNNDBhmnPLg50uVZWiJeM2w7SX1NM9ZeKW/RlfgUmb8djzQvnY8m+KbjETlGBA0U7wZOZAQpuSXXyXPn5LRxFZ6p0f4ccu6jOyUW+i3nmdGg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841479; c=relaxed/simple;
	bh=/ruthVdFdeM1PNjHqONrq6A5EYgdHscTsTymXD7gGLY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JJN0tdnA/BVZbycOaOlIUBaurDV6HBOPE+GUfEP9cRFdIEXlHoGevBJRyOXaKWGRgfuOtaMjA89ssFLo9iLRasDFVrZqwfhPSTkchhB8ejV6BbXTlms/m4/cQKNZORQ9nheU9Spd19aCNdYLS1y+To+vsoueh1/8FzuQ/pbl9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k488lfLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68E7C4CEE4;
	Mon, 28 Apr 2025 11:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745841479;
	bh=/ruthVdFdeM1PNjHqONrq6A5EYgdHscTsTymXD7gGLY=;
	h=Subject:To:Cc:From:Date:From;
	b=k488lfLPGs0SaVSrrvCO898Zviv6HVSP13Hn/t7mlnH4kk8Y9SWBt+DN1vGMk4qdm
	 ee+ly1Dd9Xa3NfoniZ0l7WTuk0KD8jHX6t3/L9hWbErX721xgwfo+PiCXI60chbLD2
	 5hDopw8X4wdy+KWRSyaEay7DOalThQelyEvjejls=
Subject: FAILED: patch "[PATCH] irqchip/gic-v2m: Prevent use after free of" failed to apply to 5.10-stable tree
To: suzuki.poulose@arm.com,maz@kernel.org,mingo@kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 13:57:41 +0200
Message-ID: <2025042841-rockfish-unwary-c95f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3318dc299b072a0511d6dfd8367f3304fb6d9827
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042841-rockfish-unwary-c95f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3318dc299b072a0511d6dfd8367f3304fb6d9827 Mon Sep 17 00:00:00 2001
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Date: Tue, 22 Apr 2025 17:16:16 +0100
Subject: [PATCH] irqchip/gic-v2m: Prevent use after free of
 gicv2m_get_fwnode()

With ACPI in place, gicv2m_get_fwnode() is registered with the pci
subsystem as pci_msi_get_fwnode_cb(), which may get invoked at runtime
during a PCI host bridge probe. But, the call back is wrongly marked as
__init, causing it to be freed, while being registered with the PCI
subsystem and could trigger:

 Unable to handle kernel paging request at virtual address ffff8000816c0400
  gicv2m_get_fwnode+0x0/0x58 (P)
  pci_set_bus_msi_domain+0x74/0x88
  pci_register_host_bridge+0x194/0x548

This is easily reproducible on a Juno board with ACPI boot.

Retain the function for later use.

Fixes: 0644b3daca28 ("irqchip/gic-v2m: acpi: Introducing GICv2m ACPI support")
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index c69894861866..dc98c39d2b20 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -421,7 +421,7 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 #ifdef CONFIG_ACPI
 static int acpi_num_msi;
 
-static __init struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
+static struct fwnode_handle *gicv2m_get_fwnode(struct device *dev)
 {
 	struct v2m_data *data;
 


