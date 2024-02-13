Return-Path: <stable+bounces-20099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FDC8539B7
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 19:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65C11F247C7
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 18:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4208D605B1;
	Tue, 13 Feb 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="SHOGLMNv"
X-Original-To: stable@vger.kernel.org
Received: from smtp102.iad3a.emailsrvr.com (smtp102.iad3a.emailsrvr.com [173.203.187.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494605FBB3
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848211; cv=none; b=YRwdKMAosmmiZ77ycTBvDo7cYkiIx5n7FplVgO46/DY89zuloM3fzRZutTdmSDL+ic9ejhJb0+IT7ChNOnx6hxqbYOnMI+VrHzlX3uAAzpopTvmKISW/0G/ijQ+yA9iOMJu2tX0LBBf6XxSkL6M7HzmtKJYnXFGqvnGQweBQzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848211; c=relaxed/simple;
	bh=pjbuxl8oRQ0+R+g36gg/gBcvAmBulWkgzcftiFFzEzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r5Uq1/Gixpj0Fs8u+RBcW/ibvz2+Jcafh5XuLhl99Y71xCpb0QWZYLYu5/Q/0A9wimh7qtTvqTXjS/FE5Nares9Xdqe33XUzsI/z5GaL2B1ZjHuDE1DKEfOLZMaeji994t3DmjMVj9rEl7Kl8GUywQHrMSZnJN3MrC+isp76enM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=SHOGLMNv; arc=none smtp.client-ip=173.203.187.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1707847819;
	bh=pjbuxl8oRQ0+R+g36gg/gBcvAmBulWkgzcftiFFzEzc=;
	h=From:To:Subject:Date:From;
	b=SHOGLMNv4peTulwzUKMCjCrkHdXPCQtzjvUY+5UrWYuajT9QGy2WRexnZM/yWArAs
	 21aO1AbTAWmhXg5Lg/qSCLLVS0pIOi7DZqaQAvQ0Djju3ofC7QTy8OqCeqGP9QpdHn
	 aeoxWzuP+LDqrC8kd8TdHGRMBD6rl2Xi28slCsXQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp29.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 4D98124EB0;
	Tue, 13 Feb 2024 13:10:18 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: comedi_test: Prevent timers rescheduling during deletion
Date: Tue, 13 Feb 2024 18:10:04 +0000
Message-ID: <20240213181004.105072-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 969d28ca-18e8-4879-92d9-b2ffe5639bd8-1-1

The comedi_test devices have a couple of timers (ai_timer and ao_timer)
that can be started to simulate hardware interrupts.  Their expiry
functions normally reschedule the timer.  The driver code calls either
del_timer_sync() or del_timer() to delete the timers from the queue, but
does not currently prevent the timers from rescheduling themselves so
synchronized deletion may be ineffective.

Add a couple of boolean members (one for each timer: ai_timer_enable and
ao_timer_enable) to the device private data structure to indicate
whether the timers are allowed to reschedule themselves.  Set the member
to true when adding the timer to the queue, and to false when deleting
the timer from the queue in the waveform_ai_cancel() and
waveform_ao_cancel() functions.

The del_timer_sync() function is also called from the waveform_detach()
function, but the timer enable members will already be set to false when
that function is called, so no change is needed there.

Fixes: 403fe7f34e33 ("staging: comedi: comedi_test: fix timer race conditions")
Cc: <stable@vger.kernel.org> # 4.4+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/comedi_test.c | 37 +++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index 30ea8b53ebf8..7fefe0de0bcc 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -87,6 +87,8 @@ struct waveform_private {
 	struct comedi_device *dev;	/* parent comedi device */
 	u64 ao_last_scan_time;		/* time of previous AO scan in usec */
 	unsigned int ao_scan_period;	/* AO scan period in usec */
+	bool ai_timer_enable:1;		/* should AI timer be running? */
+	bool ao_timer_enable:1;		/* should AO timer be running? */
 	unsigned short ao_loopbacks[N_CHANS];
 };
 
@@ -232,12 +234,18 @@ static void waveform_ai_timer(struct timer_list *t)
 	if (cmd->stop_src == TRIG_COUNT && async->scans_done >= cmd->stop_arg) {
 		async->events |= COMEDI_CB_EOA;
 	} else {
+		unsigned long flags;
+
 		if (devpriv->ai_convert_time > now)
 			time_increment = devpriv->ai_convert_time - now;
 		else
 			time_increment = 1;
-		mod_timer(&devpriv->ai_timer,
-			  jiffies + usecs_to_jiffies(time_increment));
+		spin_lock_irqsave(&dev->spinlock, flags);
+		if (devpriv->ai_timer_enable) {
+			mod_timer(&devpriv->ai_timer,
+				  jiffies + usecs_to_jiffies(time_increment));
+		}
+		spin_unlock_irqrestore(&dev->spinlock, flags);
 	}
 
 overrun:
@@ -352,6 +360,7 @@ static int waveform_ai_cmd(struct comedi_device *dev,
 	struct comedi_cmd *cmd = &s->async->cmd;
 	unsigned int first_convert_time;
 	u64 wf_current;
+	unsigned long flags;
 
 	if (cmd->flags & CMDF_PRIORITY) {
 		dev_err(dev->class_dev,
@@ -393,9 +402,12 @@ static int waveform_ai_cmd(struct comedi_device *dev,
 	 * Seem to need an extra jiffy here, otherwise timer expires slightly
 	 * early!
 	 */
+	spin_lock_irqsave(&dev->spinlock, flags);
+	devpriv->ai_timer_enable = true;
 	devpriv->ai_timer.expires =
 		jiffies + usecs_to_jiffies(devpriv->ai_convert_period) + 1;
 	add_timer(&devpriv->ai_timer);
+	spin_unlock_irqrestore(&dev->spinlock, flags);
 	return 0;
 }
 
@@ -403,7 +415,11 @@ static int waveform_ai_cancel(struct comedi_device *dev,
 			      struct comedi_subdevice *s)
 {
 	struct waveform_private *devpriv = dev->private;
+	unsigned long flags;
 
+	spin_lock_irqsave(&dev->spinlock, flags);
+	devpriv->ai_timer_enable = false;
+	spin_unlock_irqrestore(&dev->spinlock, flags);
 	if (in_softirq()) {
 		/* Assume we were called from the timer routine itself. */
 		del_timer(&devpriv->ai_timer);
@@ -494,9 +510,14 @@ static void waveform_ao_timer(struct timer_list *t)
 	} else {
 		unsigned int time_inc = devpriv->ao_last_scan_time +
 					devpriv->ao_scan_period - now;
+		unsigned long flags;
 
-		mod_timer(&devpriv->ao_timer,
-			  jiffies + usecs_to_jiffies(time_inc));
+		spin_lock_irqsave(&dev->spinlock, flags);
+		if (devpriv->ao_timer_enable) {
+			mod_timer(&devpriv->ao_timer,
+				  jiffies + usecs_to_jiffies(time_inc));
+		}
+		spin_unlock_irqrestore(&dev->spinlock, flags);
 	}
 
 underrun:
@@ -510,6 +531,7 @@ static int waveform_ao_inttrig_start(struct comedi_device *dev,
 	struct waveform_private *devpriv = dev->private;
 	struct comedi_async *async = s->async;
 	struct comedi_cmd *cmd = &async->cmd;
+	unsigned long flags;
 
 	if (trig_num != cmd->start_arg)
 		return -EINVAL;
@@ -517,9 +539,12 @@ static int waveform_ao_inttrig_start(struct comedi_device *dev,
 	async->inttrig = NULL;
 
 	devpriv->ao_last_scan_time = ktime_to_us(ktime_get());
+	spin_lock_irqsave(&dev->spinlock, flags);
+	devpriv->ao_timer_enable = true;
 	devpriv->ao_timer.expires =
 		jiffies + usecs_to_jiffies(devpriv->ao_scan_period);
 	add_timer(&devpriv->ao_timer);
+	spin_unlock_irqrestore(&dev->spinlock, flags);
 
 	return 1;
 }
@@ -602,8 +627,12 @@ static int waveform_ao_cancel(struct comedi_device *dev,
 			      struct comedi_subdevice *s)
 {
 	struct waveform_private *devpriv = dev->private;
+	unsigned long flags;
 
 	s->async->inttrig = NULL;
+	spin_lock_irqsave(&dev->spinlock, flags);
+	devpriv->ao_timer_enable = false;
+	spin_unlock_irqrestore(&dev->spinlock, flags);
 	if (in_softirq()) {
 		/* Assume we were called from the timer routine itself. */
 		del_timer(&devpriv->ao_timer);
-- 
2.43.0


