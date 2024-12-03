Return-Path: <stable+bounces-96236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764959E1981
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26FD5B3A852
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830261DED59;
	Tue,  3 Dec 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hyT20z6l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4460017F4F2
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217573; cv=none; b=Jr/uWthXmAvH/zQRNV2HmjEMGmjWFkNz0lcyzfJvY43BfyG9C4C/AVaVfFHiWeacgtgxJLuVMKv4s8JEjYlDbcKo6NzHxhbbHm7PsQo+yoUENZNdR3FJk9uyM0Ct6Tj7yfTbbFblJMQMOtACnkHhHjXqUoEBC/ZI3rkxtHAaUWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217573; c=relaxed/simple;
	bh=2JOT0RDKBBu1qoSe9fiWb0Jp/J60HaHFURY+1s4xeLc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GtOHcm7fHuXldmSi7D5BLRL8ucr9B/H5NljL349dkcg9iQpgfiq8zVdJM0OSAgtKsJSjwQ5wIGvuSvxL++xF7cvOe/Odmd6I6prFDOyvUeQTmMHjYGW9tV/ZCcfmxVD/yJzOboiK6s8IV5HpArVQvas0BKDpotNKQbp945eez+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hyT20z6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED4DC4CECF;
	Tue,  3 Dec 2024 09:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733217573;
	bh=2JOT0RDKBBu1qoSe9fiWb0Jp/J60HaHFURY+1s4xeLc=;
	h=Subject:To:Cc:From:Date:From;
	b=hyT20z6lmBkz5retdGfLri9mMBB9yaQ9seT00xzlvgefXK19Ho7knqGyRIG3C2sgI
	 UzY+m9vKylTv55D+NvbahL5eb11HCdywnTN/prdun27g2U+J1Ga28pZLPlr977gCur
	 6hI9pCNPEljuLsbSVC6Zo3l3e0PkYlrnngY9fRuA=
Subject: FAILED: patch "[PATCH] spi: stm32: fix missing device mode capability in stm32mp25" failed to apply to 6.12-stable tree
To: alain.volmat@foss.st.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 10:19:27 +0100
Message-ID: <2024120327-unopposed-pulmonary-1dd6@gregkh>
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
git cherry-pick -x 941584e2f3ddde26e4d71941ebc0836ece181594
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120327-unopposed-pulmonary-1dd6@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 941584e2f3ddde26e4d71941ebc0836ece181594 Mon Sep 17 00:00:00 2001
From: Alain Volmat <alain.volmat@foss.st.com>
Date: Thu, 10 Oct 2024 15:33:03 +0200
Subject: [PATCH] spi: stm32: fix missing device mode capability in stm32mp25

The STM32MP25 SOC has capability to behave in device mode however
missing .has_device_mode within its stm32mp25_spi_cfg structure leads
to not being able to enable the device mode.

Fixes: f6cd66231aa5 ("spi: stm32: add st,stm32mp25-spi compatible supporting STM32MP25 soc")
Cc: stable@vger.kernel.org
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Link: https://patch.msgid.link/20241010-spi-mp25-device-fix-v2-1-d13920de473d@foss.st.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index f2dd8ab12df8..da3517d7102d 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -2044,6 +2044,7 @@ static const struct stm32_spi_cfg stm32mp25_spi_cfg = {
 	.baud_rate_div_max = STM32H7_SPI_MBR_DIV_MAX,
 	.has_fifo = true,
 	.prevent_dma_burst = true,
+	.has_device_mode = true,
 };
 
 static const struct of_device_id stm32_spi_of_match[] = {


