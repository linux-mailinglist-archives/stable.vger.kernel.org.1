Return-Path: <stable+bounces-136875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC444A9F01F
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 14:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283387AEE26
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A676E266F1E;
	Mon, 28 Apr 2025 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VwGTHAal"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452D26AAAA
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841475; cv=none; b=PLVHo5k7cBqO9btRJXFrNr3yFHyAvPXezYFopUpAdtMgdw+Rs+GR3Sh+K6F7j+BzuF5yn9rBZNNH4uH4+jGjxncMBObKSHr/27LyFFu8intls3pHYjv7Uq2+tsRwKLkJCYJZekIerkkxt8rHVIF9gIzAhWUian3m97Te4JZrkBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841475; c=relaxed/simple;
	bh=vze2KDrVpz1mOMfSACgXKdWbimtMLcBIu7hrpQxVj+w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o2SGgKDSBN69FkGMGKYkNF+NmHxRd6JWs2blXHMAbdIQFK7p+ImNST8HoA+spPKl9NzJjRasC/AxI6OLMWGwo/qxk6mmGbgJWMgldXpLyr3NmPW4yRh3wQmfYDBqmRjU/KdE5R6mDxECfFnvCLdbd2UQILEk6fmGUXlVv9/9JPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VwGTHAal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA32C4CEEE;
	Mon, 28 Apr 2025 11:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745841475;
	bh=vze2KDrVpz1mOMfSACgXKdWbimtMLcBIu7hrpQxVj+w=;
	h=Subject:To:Cc:From:Date:From;
	b=VwGTHAalfmH+CLBgLa51YgpXNovXSp0uUckmtXtObs6ppnyZK/WheMrPLnAjLPMSM
	 vE9QAerQBzjuivg4IhRr6ZT4ctgtOnSSNzKi/Pjt5frqP/9q7xHwGf1MerLRwbtZv0
	 2UVIOc43sbjciTX0RqM5nXaPXoWXfrvroUnJ5iiM=
Subject: FAILED: patch "[PATCH] irqchip/gic-v2m: Prevent use after free of" failed to apply to 5.4-stable tree
To: suzuki.poulose@arm.com,maz@kernel.org,mingo@kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 13:57:41 +0200
Message-ID: <2025042841-retreat-dividend-28cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 3318dc299b072a0511d6dfd8367f3304fb6d9827
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042841-retreat-dividend-28cd@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


