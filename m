Return-Path: <stable+bounces-66485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE31294EC3D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 765691F22606
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EB03715E;
	Mon, 12 Aug 2024 12:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oWstx4dP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2469A1537DD
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464090; cv=none; b=UUgzXdeMV+JHPa6LxzhEW3jMVG1f6+HBEQqnAet5sRTOiAZzdKPvSJ+qqKSxqVC5XDM810oPvQsUIm/11AScMAVtCtlk4WHt6MXznmH//XcOSbnjw8H/KwlZgR92sDt8WzsQkEAhfXtr1Uk0Csqrja1uHp+9ygodgZfCJNDQcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464090; c=relaxed/simple;
	bh=7hDJOn9pNwe8iACKLFrZ43lCJaYR/tNH6n4f2CF+0T8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZIkiNsAzILjmivQEnRHL94ujPhDvVwUpYCHw1CRv4iR+w18pumR9Dz4lJO8Gogg0m2WokXX9Za+Dg9awGeKuQurfOufGsWx7kc0wmenQB/grVzuZ4dkWKCsSHE+tVjc+d3dpztB1R051AwpgnxmdzndrKZrhU28PnYHMeIhBh8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oWstx4dP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A33C4AF0D;
	Mon, 12 Aug 2024 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723464089;
	bh=7hDJOn9pNwe8iACKLFrZ43lCJaYR/tNH6n4f2CF+0T8=;
	h=Subject:To:Cc:From:Date:From;
	b=oWstx4dPCpIlTya92JVFEtLQ2dhYhRv3a/XTF0ajMwvztDri5jSAaJV3Dz/aqTeej
	 wHyG9qC5AvWzTl8pmUJ2wzTo7JEywmfYaeBaevw1fDDcacLRta4/KfKG8hvmmHAnbL
	 E+zRyecKQ5XfeNCpy39++ESDKGqirorWDHSMdS40=
Subject: FAILED: patch "[PATCH] irqchip/xilinx: Fix shift out of bounds" failed to apply to 5.4-stable tree
To: radhey.shyam.pandey@amd.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:01:21 +0200
Message-ID: <2024081221-shortage-arrogance-0fc6@gregkh>
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
git cherry-pick -x d73f0f49daa84176c3beee1606e73c7ffb6af8b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081221-shortage-arrogance-0fc6@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


