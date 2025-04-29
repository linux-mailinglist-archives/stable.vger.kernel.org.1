Return-Path: <stable+bounces-136997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BF5AA037C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 08:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2626174605
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 06:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F002750FD;
	Tue, 29 Apr 2025 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TwfLUd7A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7532750F9
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 06:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745908551; cv=none; b=YCRRSeuWLFUSIgYSftbx/Qk6GpbCRer1rFiH7WUbqMp9Rp6CmhSMqmgdhF6WGHlXWRWBJ3KBC90xPzmZ61cWxj6fnNwbssMmsFe0CsnMM5/E9UTM34BbxeipkfnTwWIozrys7AnJkw5CfAj75cj4Lbu1FcrkyA1A4rQiK/Rj+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745908551; c=relaxed/simple;
	bh=Q44i/drhD8Yqbeaz5O9cwh9F9N8lJbj/qyFPnb3ughM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NuDYpKluFeOWwzi2d2v+lyhlvIO4qSk4FWRWfuJ5BfA4zuoEXvoNR2bwkUU+N4IH8K3JazOj+h7vLKBK2OBFaJ2vOZpLUiZd9Smq3reD3zF9ntYn0j1Jev39mTvc4Z3L/jmLsmjmfSmyp/xE3PSARPq4LLflhwB2EfvcqYjU/fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TwfLUd7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E29C4CEED;
	Tue, 29 Apr 2025 06:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745908550;
	bh=Q44i/drhD8Yqbeaz5O9cwh9F9N8lJbj/qyFPnb3ughM=;
	h=Subject:To:Cc:From:Date:From;
	b=TwfLUd7A472JD0wneO3ciAlyZScauMX/eilh7nnJXYv5HZGNbxbD95lqf1vVdiAQb
	 AKYeUCOkV7aTTV/tri+74T2Bd4mMH+EUcBalAmFEO5Y0zLBSvteoTfDteFBeQouAsN
	 LJtnkbqRm3tx7vEgcIMb3h+k/wSBzhcOqKKAD44I=
Subject: FAILED: patch "[PATCH] serial: msm: Configure correct working mode before starting" failed to apply to 5.15-stable tree
To: stephan.gerhold@linaro.org,gregkh@linuxfoundation.org,neil.armstrong@linaro.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Apr 2025 08:35:47 +0200
Message-ID: <2025042947-baffling-scrawny-24d8@gregkh>
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
git cherry-pick -x 7094832b5ac861b0bd7ed8866c93cb15ef619996
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042947-baffling-scrawny-24d8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7094832b5ac861b0bd7ed8866c93cb15ef619996 Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 8 Apr 2025 19:22:47 +0200
Subject: [PATCH] serial: msm: Configure correct working mode before starting
 earlycon

The MSM UART DM controller supports different working modes, e.g. DMA or
the "single-character mode", where all reads/writes operate on a single
character rather than 4 chars (32-bit) at once. When using earlycon,
__msm_console_write() always writes 4 characters at a time, but we don't
know which mode the bootloader was using and we don't set the mode either.

This causes garbled output if the bootloader was using the single-character
mode, because only every 4th character appears in the serial console, e.g.

  "[ 00oni pi  000xf0[ 00i s 5rm9(l)l s 1  1 SPMTA 7:C 5[ 00A ade k d[
   00ano:ameoi .Q1B[ 00ac _idaM00080oo'"

If the bootloader was using the DMA ("DM") mode, output would likely fail
entirely. Later, when the full serial driver probes, the port is
re-initialized and output works as expected.

Fix this also for earlycon by clearing the DMEN register and
reset+re-enable the transmitter to apply the change. This ensures the
transmitter is in the expected state before writing any output.

Cc: stable <stable@kernel.org>
Fixes: 0efe72963409 ("tty: serial: msm: Add earlycon support")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20250408-msm-serial-earlycon-v1-1-429080127530@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 1b137e068444..3449945493ce 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1746,6 +1746,12 @@ msm_serial_early_console_setup_dm(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
+	/* Disable DM / single-character modes */
+	msm_write(&device->port, 0, UARTDM_DMEN);
+	msm_write(&device->port, MSM_UART_CR_CMD_RESET_RX, MSM_UART_CR);
+	msm_write(&device->port, MSM_UART_CR_CMD_RESET_TX, MSM_UART_CR);
+	msm_write(&device->port, MSM_UART_CR_TX_ENABLE, MSM_UART_CR);
+
 	device->con->write = msm_serial_early_write_dm;
 	return 0;
 }


