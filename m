Return-Path: <stable+bounces-25825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A4786FA48
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 07:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D4B2810FC
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6068511716;
	Mon,  4 Mar 2024 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FPc+BbaZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21067B667
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535229; cv=none; b=jiG/MJMsb3YjuiecvYMU7Qiv8oAdWPGw1+T+0NVzbG5bQJROs42K5lGMzy7TosDby7M9nhUfXwnv9OlbZyLx9l0Tu8zV9gK8w0GHksVVUMX1MklvaLkd4xXj3a1WaaQ4UXgmI/d4hQgnz3fy81CzN9m99YanUcc5cgwjA/u2oPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535229; c=relaxed/simple;
	bh=ceZSyXqsqda4tVjhkLWkM4VJUtTV4hFxScbR3WFRhIc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PmPV6icS9ljsWI+kQqQErYV4MC6LrnS4U0l+vsEapiFsPyrCUw38cDiZKm7SHRR9l7HvzJSB8ZXEsJOqJKQ0dKWloXcya2+V8pLxvdUCHBifWLdI8COmjpBQAkccb+7gZp0pa4tYqDb4vcakn3iRqwxdAAb8/BRszDyYzls71Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FPc+BbaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF84C433C7;
	Mon,  4 Mar 2024 06:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709535228;
	bh=ceZSyXqsqda4tVjhkLWkM4VJUtTV4hFxScbR3WFRhIc=;
	h=Subject:To:Cc:From:Date:From;
	b=FPc+BbaZP9eYJs8Y8558qJCdR3Qy3aCN9clZ9o9cxA4AGejEYNf3ArGV1blbZMVxi
	 uIdzIXrVPwbFzbxZ61pN5wAnLQTlhAGmBWudD7Kt3dGmP5bFOi47BixSYyu3oJMJKr
	 LElUXjKIaOJ6Y2Ua2aUYyVxSdRCjB9C4S8mibIXU=
Subject: FAILED: patch "[PATCH] dmaengine: fsl-edma: correct max_segment_size setting" failed to apply to 6.1-stable tree
To: Frank.Li@nxp.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 Mar 2024 07:53:35 +0100
Message-ID: <2024030434-underling-helmet-8fbe@gregkh>
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
git cherry-pick -x a79f949a5ce1d45329d63742c2a995f2b47f9852
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024030434-underling-helmet-8fbe@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a79f949a5ce1d45329d63742c2a995f2b47f9852 Mon Sep 17 00:00:00 2001
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 7 Feb 2024 14:47:32 -0500
Subject: [PATCH] dmaengine: fsl-edma: correct max_segment_size setting

Correcting the previous setting of 0x3fff to the actual value of 0x7fff.

Introduced new macro 'EDMA_TCD_ITER_MASK' for improved code clarity and
utilization of FIELD_GET to obtain the accurate maximum value.

Cc: stable@vger.kernel.org
Fixes: e06748539432 ("dmaengine: fsl-edma: support edma memcpy")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20240207194733.2112870-1-Frank.Li@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index bb5221158a77..f5e216b157c7 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -30,8 +30,9 @@
 #define EDMA_TCD_ATTR_SSIZE(x)		(((x) & GENMASK(2, 0)) << 8)
 #define EDMA_TCD_ATTR_SMOD(x)		(((x) & GENMASK(4, 0)) << 11)
 
-#define EDMA_TCD_CITER_CITER(x)		((x) & GENMASK(14, 0))
-#define EDMA_TCD_BITER_BITER(x)		((x) & GENMASK(14, 0))
+#define EDMA_TCD_ITER_MASK		GENMASK(14, 0)
+#define EDMA_TCD_CITER_CITER(x)		((x) & EDMA_TCD_ITER_MASK)
+#define EDMA_TCD_BITER_BITER(x)		((x) & EDMA_TCD_ITER_MASK)
 
 #define EDMA_TCD_CSR_START		BIT(0)
 #define EDMA_TCD_CSR_INT_MAJOR		BIT(1)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 45cc419b1b4a..d36e28b9c767 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -10,6 +10,7 @@
  */
 
 #include <dt-bindings/dma/fsl-edma.h>
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
@@ -582,7 +583,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 					DMAENGINE_ALIGN_32_BYTES;
 
 	/* Per worst case 'nbytes = 1' take CITER as the max_seg_size */
-	dma_set_max_seg_size(fsl_edma->dma_dev.dev, 0x3fff);
+	dma_set_max_seg_size(fsl_edma->dma_dev.dev,
+			     FIELD_GET(EDMA_TCD_ITER_MASK, EDMA_TCD_ITER_MASK));
 
 	fsl_edma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
 


