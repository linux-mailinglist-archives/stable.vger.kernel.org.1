Return-Path: <stable+bounces-106213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C069FD5CB
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 17:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3470416313C
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55D35974;
	Fri, 27 Dec 2024 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mr+fL5H8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7BD3596D
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735315344; cv=none; b=BTntwQbA5L9Jj3YRGU9hOPUhQGTB9lPNXjPsL2IhKW/oTOxivSgBJ3QXWD09hBhkA0YaF7MFPs6LjJqwTwB+5A9jb75SsgW3zSr9N3PV5HAyXP8ELafxEIJQa2gBWL5IdV9Su2IWbNK1htFDYLMMYRmAXfus8/JJVu/AZLmvm4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735315344; c=relaxed/simple;
	bh=r89bkX75USL4u9krJ8bR1HEYGdvO/mfQGdwiSqGr3WE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UJLmAXUJQxvO5ErJ2uXH450vkG/UsjPG0cq9tnooRak32yQpLLtFF9AtH8S0GKdYdtNi5N/U1pOOvO8N4Lm97QIqoZwVHQSP4HsFgWoTv/byUhYVFyFK5Coj3iKt7jj3XaW2QjbW+i4oDuOclBsRiP6UlyvMZpqOdssum/ZTzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mr+fL5H8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE3AC4CED0;
	Fri, 27 Dec 2024 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735315344;
	bh=r89bkX75USL4u9krJ8bR1HEYGdvO/mfQGdwiSqGr3WE=;
	h=Subject:To:Cc:From:Date:From;
	b=mr+fL5H8Y3+pUxF9LXoVdbIQeL0+Hbj3Ly7LOXe8UoAsig00m+vCLedMnV5AYgNlk
	 AJwev3j48Gcv0fGUhhji5mV8iYTouXMiWjes58EDxeG7m3LC7m4oZNPi8s2qWX9fiy
	 6yPdQGMgzzkvb7InLn3DQSRfd+DXcZz2xcaU57iI=
Subject: FAILED: patch "[PATCH] dmaengine: loongson2-apb: Change GENMASK to GENMASK_ULL" failed to apply to 6.12-stable tree
To: zhoubinbin@loongson.cn,dan.carpenter@linaro.org,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 27 Dec 2024 17:02:21 +0100
Message-ID: <2024122721-badge-research-e542@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 4b65d5322e1d8994acfdb9b867aa00bdb30d177b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122721-badge-research-e542@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4b65d5322e1d8994acfdb9b867aa00bdb30d177b Mon Sep 17 00:00:00 2001
From: Binbin Zhou <zhoubinbin@loongson.cn>
Date: Mon, 28 Oct 2024 17:34:13 +0800
Subject: [PATCH] dmaengine: loongson2-apb: Change GENMASK to GENMASK_ULL

Fix the following smatch static checker warning:

drivers/dma/loongson2-apb-dma.c:189 ls2x_dma_write_cmd()
warn: was expecting a 64 bit value instead of '~(((0)) + (((~((0))) - (((1)) << (0)) + 1) & (~((0)) >> ((8 * 4) - 1 - (4)))))'

The GENMASK macro used "unsigned long", which caused build issues when
using a 32-bit toolchain because it would try to access bits > 31. This
patch switches GENMASK to GENMASK_ULL, which uses "unsigned long long".

Fixes: 71e7d3cb6e55 ("dmaengine: ls2x-apb: New driver for the Loongson LS2X APB DMA controller")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/87cdc025-7246-4548-85ca-3d36fdc2be2d@stanley.mountain/
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Link: https://lore.kernel.org/r/20241028093413.1145820-1-zhoubinbin@loongson.cn
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/loongson2-apb-dma.c b/drivers/dma/loongson2-apb-dma.c
index 367ed34ce4da..c528f02b9f84 100644
--- a/drivers/dma/loongson2-apb-dma.c
+++ b/drivers/dma/loongson2-apb-dma.c
@@ -31,7 +31,7 @@
 #define LDMA_ASK_VALID		BIT(2)
 #define LDMA_START		BIT(3) /* DMA start operation */
 #define LDMA_STOP		BIT(4) /* DMA stop operation */
-#define LDMA_CONFIG_MASK	GENMASK(4, 0) /* DMA controller config bits mask */
+#define LDMA_CONFIG_MASK	GENMASK_ULL(4, 0) /* DMA controller config bits mask */
 
 /* Bitfields in ndesc_addr field of HW descriptor */
 #define LDMA_DESC_EN		BIT(0) /*1: The next descriptor is valid */


