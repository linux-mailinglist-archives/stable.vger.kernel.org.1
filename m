Return-Path: <stable+bounces-20571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F4D85A830
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F051C219FB
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0021D3B19D;
	Mon, 19 Feb 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QZLKxjLD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57903B1A8
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358819; cv=none; b=CVVgM5XQpzxgzWRsfCbrKws4lZ87w/Sk5ZdKClur1Pex7KVYosX8MFfrfcFJ0ZMiG265CYczhHeK5/PtNW0r1c0ZaHmgwSy8bLl85owv5J8LzWaNAeGFF+pZ77XmBuY3PnOX6c3qxgLvzgMGBxEBnLH+CuxYViXIXYWtkCf/nc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358819; c=relaxed/simple;
	bh=zrUv37U5UvLTDxIBpmB+Wttz80kXvdrUS1aSIP9p/kM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BFJ3lTCWJaUpRZfaOokaE6/JYPNHG0lPBk1d+nB7V8j7HVV3uvkeD7ShVcfS9S51maXC5rBRTzvyjt/pTafrFZGSGJREI3017vA41U95/ghgXPzfeLS2iznW7c3CP2N/Zl19XOzKgn5FiVZtTEHDyQBta+t8+vc3wIahqmnfyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QZLKxjLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21647C433C7;
	Mon, 19 Feb 2024 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708358819;
	bh=zrUv37U5UvLTDxIBpmB+Wttz80kXvdrUS1aSIP9p/kM=;
	h=Subject:To:Cc:From:Date:From;
	b=QZLKxjLDwQrxAa6U8M5a7W4i0dXUsR8aT2wJpcEg5oKqNJQtnryLL9/85LM78p9zS
	 dM/xAbARzLqsg+5oQLD7BiFZDWaDEdPDLo0f/eHvfQ1pZFXRcVidet/wSNBBI9j5lp
	 EwoFDenXpKaReaB7u30aLeVpUTWqY09smaIdwsrw=
Subject: FAILED: patch "[PATCH] media: Revert "media: rkisp1: Drop IRQF_SHARED"" failed to apply to 5.15-stable tree
To: tomi.valkeinen@ideasonboard.com,laurent.pinchart@ideasonboard.com,mchehab@kernel.org,mike.rudenko@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:06:56 +0100
Message-ID: <2024021956-boxy-ethically-dcb0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a107d643b2a3382e0a2d2c4ef08bf8c6bff4561d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021956-boxy-ethically-dcb0@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

a107d643b2a3 ("media: Revert "media: rkisp1: Drop IRQF_SHARED"")
0753874617de ("media: rkisp1: Store IRQ lines")
85d2a31fe4d9 ("media: rkisp1: Drop IRQF_SHARED")
0c0b9f9c8e84 ("media: rkisp1: csi: Rename CSI functions with a common rkisp1_csi prefix")
039a73427bfa ("media: rkisp1: csi: Handle CSI-2 RX configuration fully in rkisp1-csi.c")
4fd1e6a9abb3 ("media: rkisp1: isp: Start CSI-2 receiver before ISP")
8082e2f4994d ("media: rkisp1: Split CSI handling to separate file")
af2dababb4d6 ("media: rkisp1: Reject sensors without pixel rate control at bound time")
deaf1120ab96 ("media: rkisp1: Move sensor .s_stream() call to ISP")
0f3c2ab2a6da ("media: rkisp1: Make rkisp1_isp_mbus_info common")
1195b18c6486 ("media: rkisp1: Access ISP version from info pointer")
9125aee770fc ("media: rkisp1: Save info pointer in rkisp1_device")
cdce5b957d5e ("media: rkisp1: Rename rkisp1_match_data to rkisp1_info")
196179c54572 ("media: rkisp1: Read the ID register at probe time instead of streamon")
fd83ef8f8e59 ("media: rkisp1: Drop parentheses and fix indentation in rkisp1_probe()")
fd3608fe6bfe ("media: rkisp1: Compile debugfs support conditionally")
8682037db36c ("media: rkisp1: Move debugfs code to a separate file")
0ef7dc305bd4 ("media: rkisp1: Swap value and address arguments to rkisp1_write()")
3b430c2cf0e4 ("media: rkisp1: regs: Rename CCL, ICCL and IRCL registers with VI_ prefix")
6ff02276beb9 ("media: rkisp1: Simplify rkisp1_entities_register() error path")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a107d643b2a3382e0a2d2c4ef08bf8c6bff4561d Mon Sep 17 00:00:00 2001
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 18 Dec 2023 08:54:00 +0100
Subject: [PATCH] media: Revert "media: rkisp1: Drop IRQF_SHARED"

This reverts commit 85d2a31fe4d9be1555f621ead7a520d8791e0f74.

The rkisp1 does share interrupt lines on some platforms, after all. Thus
we need to revert this, and implement a fix for the rkisp1 shared irq
handling in a follow-up patch.

Closes: https://lore.kernel.org/all/87o7eo8vym.fsf@gmail.com/
Link: https://lore.kernel.org/r/20231218-rkisp-shirq-fix-v1-1-173007628248@ideasonboard.com

Reported-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index f96f821a7b50..acc559652d6e 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -559,7 +559,7 @@ static int rkisp1_probe(struct platform_device *pdev)
 				rkisp1->irqs[il] = irq;
 		}
 
-		ret = devm_request_irq(dev, irq, info->isrs[i].isr, 0,
+		ret = devm_request_irq(dev, irq, info->isrs[i].isr, IRQF_SHARED,
 				       dev_driver_string(dev), dev);
 		if (ret) {
 			dev_err(dev, "request irq failed: %d\n", ret);


