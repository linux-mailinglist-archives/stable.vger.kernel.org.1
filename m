Return-Path: <stable+bounces-109558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC40EA16F11
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 16:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09C67A05CA
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CE21E5705;
	Mon, 20 Jan 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cfjcyC6h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95351E503D
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737386093; cv=none; b=g9YM0IesIvBiKximbea5LbB70zwir1zSiLW5Lwf8uujx6PFpWVI2MfFbBJhwWPorn5WdJ8gJgO5hVzz0Dr+m+hV6+ZwhFnd0t6yJ6GuGfhpvdF/8cxhKZOruFpPowf6aRER9Y3j57nk3t+wxhWLnSv0QhwtdHvc8T2d8XdTZ5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737386093; c=relaxed/simple;
	bh=gZfCROowjxfvKb1G/1TT1xoQmV4LWG5ohVwwyN5xLfc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z6Zi6VSyX40YIJlItKp+KbzxZ6dD3YDxs3TIqqFFrLBIK035PaBvOYsHs6SCNh7wAJakyxeVRAxYsC1t62hi4G4UIvTkSj0Z0ODa5dHpuKqSha4hEXqPROfLEUIxrSjmj/+fflxiMFP79hlkCbR2Y5XBb7Sy4cvtmn26p0skT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cfjcyC6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D1DC4CEDD;
	Mon, 20 Jan 2025 15:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737386092;
	bh=gZfCROowjxfvKb1G/1TT1xoQmV4LWG5ohVwwyN5xLfc=;
	h=Subject:To:Cc:From:Date:From;
	b=cfjcyC6h9nm7O7Urgdedwq1UvJx4ZiyO1apmx/19EtaZNKb+cN9PFnqlcOfZXGgG1
	 642bu93IUJn1ZQHOSVb80uhr10zyl0mEmmqMHPWkTdPfsYjjOPrxqBMA2gMm3YfM92
	 3KJF/ry2H+QWQxS3PExXQF9q0+2kBW05Gsq6so/I=
Subject: FAILED: patch "[PATCH] irqchip: Plug a OF node reference leak in" failed to apply to 5.10-stable tree
To: joe@pf.is.s.u-tokyo.ac.jp,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 16:14:50 +0100
Message-ID: <2025012049-connector-oxford-19f1@gregkh>
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
git cherry-pick -x 9322d1915f9d976ee48c09d800fbd5169bc2ddcc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012049-connector-oxford-19f1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9322d1915f9d976ee48c09d800fbd5169bc2ddcc Mon Sep 17 00:00:00 2001
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Date: Sun, 15 Dec 2024 12:39:45 +0900
Subject: [PATCH] irqchip: Plug a OF node reference leak in
 platform_irqchip_probe()

platform_irqchip_probe() leaks a OF node when irq_init_cb() fails. Fix it
by declaring par_np with the __free(device_node) cleanup construct.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: f8410e626569 ("irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and IRQCHIP_MATCH helper macros")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241215033945.3414223-1-joe@pf.is.s.u-tokyo.ac.jp

diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 1eeb0d0156ce..0ee7b6b71f5f 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -35,11 +35,10 @@ void __init irqchip_init(void)
 int platform_irqchip_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *par_np = of_irq_find_parent(np);
+	struct device_node *par_np __free(device_node) = of_irq_find_parent(np);
 	of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
 
 	if (!irq_init_cb) {
-		of_node_put(par_np);
 		return -EINVAL;
 	}
 
@@ -55,7 +54,6 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	 * interrupt controller can check for specific domains as necessary.
 	 */
 	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY)) {
-		of_node_put(par_np);
 		return -EPROBE_DEFER;
 	}
 


