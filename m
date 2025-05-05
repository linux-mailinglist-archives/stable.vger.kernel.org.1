Return-Path: <stable+bounces-139591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE4AA8D1C
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C151888AE3
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4903719C57C;
	Mon,  5 May 2025 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U7D/E4KF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F935BAF0
	for <stable@vger.kernel.org>; Mon,  5 May 2025 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430599; cv=none; b=s249+Kg+y589wsA0BbDekrxwAe+MHp1Rb7QUMeV8Wus1R68b72OyoIh4OFcIHK3Eu6ub+19pAJdgbYewOJx5odoxLZtg6i0nGxjNuAEhaHOKr9U8F7P1GrlU3taXwt+0TaKXtpCTwmSGrGgm4cNM8rEpzf2sjyjagLQoSJSTrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430599; c=relaxed/simple;
	bh=sNjxCgNTDClqR87fHugQcW+8yAy9Hw3CAxOXc9j9dPc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=axLxcIEskt53Wuv/9rKy8+ldYfFbb6/sXajxaH7U1tgSZFc0vLTUqPpkBMsWPdWZZFGTqiwSXlhVljVhM7VSwwRspkeXnTFY7Z+T41jFnoSssVF1zzEu1QU7ouRHtCMYYNzXqf77qYfzrFGJpj2q60ZIRFcW2PzYom3y1LgiTj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U7D/E4KF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1C2C4CEEF;
	Mon,  5 May 2025 07:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746430598;
	bh=sNjxCgNTDClqR87fHugQcW+8yAy9Hw3CAxOXc9j9dPc=;
	h=Subject:To:Cc:From:Date:From;
	b=U7D/E4KFq2C2mB0uI8pVIgrnVDtnKUw4jbdSBC+RQL9LXfkdLm4GiHvo3620Kq+bW
	 c8t6tQXrqI7l/fr6qfNVec+feXTO6RTgJHX22vFGwXD5tGnekiJXxV0v6H3WUp6j4Q
	 LvRDR4KzppfYVXlM8z5as/sA1fMOpScRpn0fdXus=
Subject: FAILED: patch "[PATCH] spi: tegra114: Don't fail set_cs_timing when delays are zero" failed to apply to 6.1-stable tree
To: webgeek1234@gmail.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 May 2025 09:36:35 +0200
Message-ID: <2025050535-slider-herbicide-e70d@gregkh>
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
git cherry-pick -x 4426e6b4ecf632bb75d973051e1179b8bfac2320
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050535-slider-herbicide-e70d@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


