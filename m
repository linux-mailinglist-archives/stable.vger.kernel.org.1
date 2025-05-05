Return-Path: <stable+bounces-139592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF07AA8D1D
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DDD188DDB4
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727BC1B6D06;
	Mon,  5 May 2025 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xDJAz13X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCA619995E
	for <stable@vger.kernel.org>; Mon,  5 May 2025 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430607; cv=none; b=YlslDB/3FMJfYGdShLJit/KjF8yZ5VVU8Dm8LFjrl6388j1u135IDSadMymJEv0PiVCbldSwPTiZhYa9bEwNPIjsaQB22LRKslJ3I0pOuk0VmuLmceEuQlsthw00IsJxZVvMAemfe2eAOLI1Gfr7/lrbGsFL8UVmFEDi3kwCKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430607; c=relaxed/simple;
	bh=GAt6q1KRTjpWRPLXNFS/OAbnAstc7bPQdwRnVQMFtYo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IQ3iocAIE6u8tYK6qZ5uiAgib+XeWzKQZM/N6BoBMCg9ynKnLSSIuzU7krZMzmStMQdkqLmgYxigZjO4wktqm+I7ROnbsC/uYMKOZAn9w16MwwIjhc4iBRFsOTK+lGIHEHHxpHwAEATVHtV5eoacst53/nh+0fU0+QXITZzjK+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xDJAz13X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C93C4CEE4;
	Mon,  5 May 2025 07:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746430606;
	bh=GAt6q1KRTjpWRPLXNFS/OAbnAstc7bPQdwRnVQMFtYo=;
	h=Subject:To:Cc:From:Date:From;
	b=xDJAz13XvJ3KXlZYGwBaidjZMv33/Yzs/BY5qOnRM1o/JHELNoEiYnCQbetBGZnpc
	 mja5UwCFwuMr9cnGFKoe3iS+lZYn0jk4j0FHka3DFBRBzcN6aM7ySyGRPUmj3NXRg6
	 LKxBkDIjEP1ldALs1Z88flU2OES7jE5pGrG0UBks=
Subject: FAILED: patch "[PATCH] spi: tegra114: Don't fail set_cs_timing when delays are zero" failed to apply to 5.15-stable tree
To: webgeek1234@gmail.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 09:36:35 +0200
Message-ID: <2025050535-ducking-playroom-1844@gregkh>
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
git cherry-pick -x 4426e6b4ecf632bb75d973051e1179b8bfac2320
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050535-ducking-playroom-1844@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4426e6b4ecf632bb75d973051e1179b8bfac2320 Mon Sep 17 00:00:00 2001
From: Aaron Kling <webgeek1234@gmail.com>
Date: Wed, 23 Apr 2025 21:03:03 -0500
Subject: [PATCH] spi: tegra114: Don't fail set_cs_timing when delays are zero

The original code would skip null delay pointers, but when the pointers
were converted to point within the spi_device struct, the check was not
updated to skip delays of zero. Hence all spi devices that didn't set
delays would fail to probe.

Fixes: 04e6bb0d6bb1 ("spi: modify set_cs_timing parameter")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
Link: https://patch.msgid.link/20250423-spi-tegra114-v1-1-2d608bcc12f9@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 3822d7c8d8ed..2a8bb798e95b 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -728,9 +728,9 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 	u32 inactive_cycles;
 	u8 cs_state;
 
-	if (setup->unit != SPI_DELAY_UNIT_SCK ||
-	    hold->unit != SPI_DELAY_UNIT_SCK ||
-	    inactive->unit != SPI_DELAY_UNIT_SCK) {
+	if ((setup->unit && setup->unit != SPI_DELAY_UNIT_SCK) ||
+	    (hold->unit && hold->unit != SPI_DELAY_UNIT_SCK) ||
+	    (inactive->unit && inactive->unit != SPI_DELAY_UNIT_SCK)) {
 		dev_err(&spi->dev,
 			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
 			SPI_DELAY_UNIT_SCK);


