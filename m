Return-Path: <stable+bounces-136873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658C4A9EFDE
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820193A99C0
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A541FBEA4;
	Mon, 28 Apr 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gvFffeC5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7682AD04
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841463; cv=none; b=gQ4YImyhUtuqJLyAo1mPzRjd+h4UBJm1hv6sv28mL9382Eb6gsnL/EjO7fyq75rMZKRAi1EkI18y2y6SUsceJD6j6U6DYM5astXlZcP9SrjSLu+Hoz/3IcqBfHvhAXLllpmB623GGxXgL+wcwph1uWRNEmVWtQm90egAkpm3eAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841463; c=relaxed/simple;
	bh=LsHyqm3kIYaVLrDD+ueDiKeD3lFb1Dc3dcTKckt0pk0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Gjucp6GnV4vqcvBjwDydJmPSO7y+flF95KoQ8SeavfacreYTFnoZSA9+bLg8KlJQJJO99JfzICdJKS/cRWDlw2Yt/mZ4N3uPPcGEwlpWRD9gfEHHP8wXbFodkq1gdAC3UvDPHJ+RdkRdIjm3OqMEowYuE5HtmtC6dgn67OdzTv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gvFffeC5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8170C4CEE4;
	Mon, 28 Apr 2025 11:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745841463;
	bh=LsHyqm3kIYaVLrDD+ueDiKeD3lFb1Dc3dcTKckt0pk0=;
	h=Subject:To:Cc:From:Date:From;
	b=gvFffeC5rIK05SOsA2O5ZSZRNOB91iqeD6YFw5rBZfBynrElbow8HP3a3AIFTXYrF
	 AjHoHzFbk43YvUI0ryvvLD4DmV5BTwvWP2a3zBwgJBtgW6e0QwyV7cPlFzyN//OV5m
	 pPY1ZEflAlyktxLLV2ZH2j7l6fs7LgHh9CFvFahM=
Subject: FAILED: patch "[PATCH] irqchip/gic-v2m: Prevent use after free of" failed to apply to 6.1-stable tree
To: suzuki.poulose@arm.com,maz@kernel.org,mingo@kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 28 Apr 2025 13:57:39 +0200
Message-ID: <2025042839-launch-disgrace-b785@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3318dc299b072a0511d6dfd8367f3304fb6d9827
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042839-launch-disgrace-b785@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


