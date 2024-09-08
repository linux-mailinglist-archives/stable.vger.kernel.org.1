Return-Path: <stable+bounces-73850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DBC970695
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E631F21AEA
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96D514D2A8;
	Sun,  8 Sep 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LhZHnu7u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC336B0D
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725791388; cv=none; b=NjoYWwe+/46AXNNbFwpse9GUgUD67YUI3Klh5MsGVyg9ksSsr7gODilxB/mBkV94zE7XWrO8kj+1irCuUY0s2JOTsATMRjqFgo6nEw9aXiDWTkoA5lE0SrMUtu7vDufbwg14UI6cC1AJa08aURiLAuUFNvHDJlMIMHmcPQggwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725791388; c=relaxed/simple;
	bh=201laUOXF13rStQ+7HQm+rwXw3b+KjJmNBPUX8o6mZo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tYlpa6yq2m4NRqvwLJ7aMXLLdMb1Qb+zBORHFnAJkV2QEzeGjYya/Uyv5lEiEVRY0pjeEsHL/GOjsuk4aytUgoyrwIouazHgo/ODfnwYV/W8thHjpLVQ4PXM4Z36d+gtCa3krVTC+kHYMPRblDtC8WRQw9i9EpH9Ql1hfMPyOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LhZHnu7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F96FC4CEC3;
	Sun,  8 Sep 2024 10:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725791388;
	bh=201laUOXF13rStQ+7HQm+rwXw3b+KjJmNBPUX8o6mZo=;
	h=Subject:To:Cc:From:Date:From;
	b=LhZHnu7u/DVsuFXIQtH/KWyYIi67Z/pNvZhdzXaV2JyPV9/y5pNr5hhETd93cW/w3
	 ZxJctvCxDUwdIL7ofiW2u0TURZMVFcg5kjT3r6GBNPRHk94NDw0GORU9pbmsW8DPLB
	 0KueqKS+ZIUfmPgi8HxKsQs35OnBXtkZudHPViNk=
Subject: FAILED: patch "[PATCH] irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()" failed to apply to 4.19-stable tree
To: make24@iscas.ac.cn,maz@kernel.org,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 12:29:44 +0200
Message-ID: <2024090844-cohesive-abrasion-ef6b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x c5af2c90ba5629f0424a8d315f75fb8d91713c3c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090844-cohesive-abrasion-ef6b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

c5af2c90ba56 ("irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()")
90b4c5558615 ("irqchip/gic-v2m: Add support for Amazon Graviton variant of GICv3+GICv2m")
737be74710f3 ("irqchip/gicv2m: Don't map the MSI page in gicv2m_compose_msi_msg()")
d38a71c54525 ("irqchip/gic-v3-its: Change initialization ordering for LPIs")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c5af2c90ba5629f0424a8d315f75fb8d91713c3c Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Tue, 20 Aug 2024 17:28:43 +0800
Subject: [PATCH] irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()

gicv2m_of_init() fails to perform an of_node_put() when
of_address_to_resource() fails, leading to a refcount leak.

Address this by moving the error handling path outside of the loop and
making it common to all failure modes.

Fixes: 4266ab1a8ff5 ("irqchip/gic-v2m: Refactor to prepare for ACPI support")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240820092843.1219933-1-make24@iscas.ac.cn

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 51af63c046ed..be35c5349986 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -407,12 +407,12 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 
 		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis,
 				      &res, 0);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			break;
-		}
 	}
 
+	if (ret && child)
+		of_node_put(child);
 	if (!ret)
 		ret = gicv2m_allocate_domains(parent);
 	if (ret)


