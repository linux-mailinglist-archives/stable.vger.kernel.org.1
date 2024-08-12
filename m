Return-Path: <stable+bounces-66486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C508194EC3E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B33282630
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B238C17276D;
	Mon, 12 Aug 2024 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g4gZ0dUK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738AE1366
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464099; cv=none; b=XBgMXWHVhiiJsO1LT6LXlkDl0k13ILaHBzVxbgu0GtzWrCB3rBBd4JBCgtrFgcYZEI51cRx5tUuVX0jIbYkj7wfe8aV6pyrlX18m8DCEeVJDywIVLFVErhDxPTu7WVhwKGl34K8WHY5SOPbS1T7pZcqlyUaQhAkyrWGBgImbSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464099; c=relaxed/simple;
	bh=P4X+iBpcdIeIKkezOMJvko1maAM4rIcAOst63LFVGKE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YX/P60vFmz9sCPwCgT/D6Rb3tnuX6MCmytw6bVY5lgYUXhnXlHOeErQRDolIbKiQkhZgfGUoXcs1wxk8Zsi7T7A6J+xU5q26F4P8jnQqctPxjC4H7FjJSBMamdFof3M17+hJ4GIQF1RN3WivZfEe9r7Ii9E8O69W8bTkLrwdDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g4gZ0dUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737E4C32782;
	Mon, 12 Aug 2024 12:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723464098;
	bh=P4X+iBpcdIeIKkezOMJvko1maAM4rIcAOst63LFVGKE=;
	h=Subject:To:Cc:From:Date:From;
	b=g4gZ0dUKrqi8n1ZocNU4SAkaAXU0Xv0LhWPrZgSad6QJPX09iYseP1NzouHQFDSO1
	 GvIcAk224b4f+hWkKS2dpWtYuLoI9Tc73Fbd9bqV3gYbkVRatUnMYZJj7/dLr8giJ+
	 EyuCq18VghGaWE3weR6Jvf6DjaquaJ3mh+pOVDSs=
Subject: FAILED: patch "[PATCH] irqchip/xilinx: Fix shift out of bounds" failed to apply to 4.19-stable tree
To: radhey.shyam.pandey@amd.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:01:27 +0200
Message-ID: <2024081227-gnarly-unplug-a067@gregkh>
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
git cherry-pick -x d73f0f49daa84176c3beee1606e73c7ffb6af8b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081227-gnarly-unplug-a067@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

d73f0f49daa8 ("irqchip/xilinx: Fix shift out of bounds")
67862a3c47fc ("irqchip/xilinx: Add support for multiple instances")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d73f0f49daa84176c3beee1606e73c7ffb6af8b2 Mon Sep 17 00:00:00 2001
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Date: Fri, 9 Aug 2024 12:32:24 +0530
Subject: [PATCH] irqchip/xilinx: Fix shift out of bounds

The device tree property 'xlnx,kind-of-intr' is sanity checked that the
bitmask contains only set bits which are in the range of the number of
interrupts supported by the controller.

The check is done by shifting the mask right by the number of supported
interrupts and checking the result for zero.

The data type of the mask is u32 and the number of supported interrupts is
up to 32. In case of 32 interrupts the shift is out of bounds, resulting in
a mismatch warning. The out of bounds condition is also reported by UBSAN:

  UBSAN: shift-out-of-bounds in irq-xilinx-intc.c:332:22
  shift exponent 32 is too large for 32-bit type 'unsigned int'

Fix it by promoting the mask to u64 for the test.

Fixes: d50466c90724 ("microblaze: intc: Refactor DT sanity check")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/1723186944-3571957-1-git-send-email-radhey.shyam.pandey@amd.com

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 238d3d344949..7e08714d507f 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -189,7 +189,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		irqc->intr_mask = 0;
 	}
 
-	if (irqc->intr_mask >> irqc->nr_irq)
+	if ((u64)irqc->intr_mask >> irqc->nr_irq)
 		pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");
 
 	pr_info("irq-xilinx: %pOF: num_irq=%d, edge=0x%x\n",


