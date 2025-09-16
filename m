Return-Path: <stable+bounces-179699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C23B590D9
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 10:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1948A7B56B0
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8306D2877E9;
	Tue, 16 Sep 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oRO8mGpK"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFA4A04
	for <Stable@vger.kernel.org>; Tue, 16 Sep 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011600; cv=none; b=TjYKmpZAIJAqCcGkxAAm1tguC9t3m/mXOsBQSIinTDybc4pUt5b3jxq0bNgbqiHGO8A02BXASn7Jfms9F8dEif34UbULoz/MY7+9SYaUZ5Tp65n/5j/+r/EJQwtbtTIq+ATI2clvljCQWjbit+AIMlWCSbz6VgiUeuMqdaHR0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011600; c=relaxed/simple;
	bh=pyPFrWVYkE0EdJn8ld7LpbpzNGd0DKiLJctH8iDgzDg=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=N7JspxJRfaCwauwh/yrjwBvlrmhkEOXJvfni5iYYRDMb68sr204/AN6gpOZfnCcD7szCGTwnljsOtbGwP8lZGAIkjH7U5bvNU2N258jZfPK1bpOO2XkKwSpsRN6iBtU7hb12wUfXRs0HNrKRG0LLdPcPB0f2A+/ua9ACcla/ddQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oRO8mGpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B305FC4CEEB;
	Tue, 16 Sep 2025 08:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011600;
	bh=pyPFrWVYkE0EdJn8ld7LpbpzNGd0DKiLJctH8iDgzDg=;
	h=Subject:To:From:Date:From;
	b=oRO8mGpK3D5XCaLnXH2b1mK3Vr4/oeifVs8sTLPIdKCgq043LLEoGiC2cHv0cVVML
	 3NXpNHUX4hFGaolx3/b7OMjYmBGsBPvvJwq4AmBS+zWdE0xJ++bHijs9i0c2gpmQj+
	 goGrA3Apa7dBqmo2cTuLVBTjqIo5MqhOxMSVf9z4=
Subject: patch "iio: xilinx-ams: Unmask interrupts after updating alarms" added to char-misc-next
To: sean.anderson@linux.dev,Jonathan.Cameron@huawei.com,Salih.Erim@amd.com,Stable@vger.kernel.org,conall.ogriofa@amd.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 16 Sep 2025 10:32:59 +0200
Message-ID: <2025091659-quadrant-sharply-ec63@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: xilinx-ams: Unmask interrupts after updating alarms

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From feb500c7ae7a198db4d2757901bce562feeefa5e Mon Sep 17 00:00:00 2001
From: Sean Anderson <sean.anderson@linux.dev>
Date: Mon, 14 Jul 2025 20:28:47 -0400
Subject: iio: xilinx-ams: Unmask interrupts after updating alarms

To convert level-triggered alarms into edge-triggered IIO events, alarms
are masked when they are triggered. To ensure we catch subsequent
alarms, we then periodically poll to see if the alarm is still active.
If it isn't, we unmask it. Active but masked alarms are stored in
current_masked_alarm.

If an active alarm is disabled, it will remain set in
current_masked_alarm until ams_unmask_worker clears it. If the alarm is
re-enabled before ams_unmask_worker runs, then it will never be cleared
from current_masked_alarm. This will prevent the alarm event from being
pushed even if the alarm is still active.

Fix this by recalculating current_masked_alarm immediately when enabling
or disabling alarms.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Reviewed-by: O'Griofa, Conall <conall.ogriofa@amd.com>
Tested-by: Erim, Salih <Salih.Erim@amd.com>
Acked-by: Erim, Salih <Salih.Erim@amd.com>
Link: https://patch.msgid.link/20250715002847.2035228-1-sean.anderson@linux.dev
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/xilinx-ams.c | 45 ++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 76dd0343f5f7..180d4140993d 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -389,6 +389,29 @@ static void ams_update_pl_alarm(struct ams *ams, unsigned long alarm_mask)
 	ams_pl_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK, cfg);
 }
 
+static void ams_unmask(struct ams *ams)
+{
+	unsigned int status, unmask;
+
+	status = readl(ams->base + AMS_ISR_0);
+
+	/* Clear those bits which are not active anymore */
+	unmask = (ams->current_masked_alarm ^ status) & ams->current_masked_alarm;
+
+	/* Clear status of disabled alarm */
+	unmask |= ams->intr_mask;
+
+	ams->current_masked_alarm &= status;
+
+	/* Also clear those which are masked out anyway */
+	ams->current_masked_alarm &= ~ams->intr_mask;
+
+	/* Clear the interrupts before we unmask them */
+	writel(unmask, ams->base + AMS_ISR_0);
+
+	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
+}
+
 static void ams_update_alarm(struct ams *ams, unsigned long alarm_mask)
 {
 	unsigned long flags;
@@ -401,6 +424,7 @@ static void ams_update_alarm(struct ams *ams, unsigned long alarm_mask)
 
 	spin_lock_irqsave(&ams->intr_lock, flags);
 	ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
+	ams_unmask(ams);
 	spin_unlock_irqrestore(&ams->intr_lock, flags);
 }
 
@@ -1035,28 +1059,9 @@ static void ams_handle_events(struct iio_dev *indio_dev, unsigned long events)
 static void ams_unmask_worker(struct work_struct *work)
 {
 	struct ams *ams = container_of(work, struct ams, ams_unmask_work.work);
-	unsigned int status, unmask;
 
 	spin_lock_irq(&ams->intr_lock);
-
-	status = readl(ams->base + AMS_ISR_0);
-
-	/* Clear those bits which are not active anymore */
-	unmask = (ams->current_masked_alarm ^ status) & ams->current_masked_alarm;
-
-	/* Clear status of disabled alarm */
-	unmask |= ams->intr_mask;
-
-	ams->current_masked_alarm &= status;
-
-	/* Also clear those which are masked out anyway */
-	ams->current_masked_alarm &= ~ams->intr_mask;
-
-	/* Clear the interrupts before we unmask them */
-	writel(unmask, ams->base + AMS_ISR_0);
-
-	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
-
+	ams_unmask(ams);
 	spin_unlock_irq(&ams->intr_lock);
 
 	/* If still pending some alarm re-trigger the timer */
-- 
2.51.0



