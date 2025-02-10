Return-Path: <stable+bounces-114552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E3AA2EE6B
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A732168D0C
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F192206B0;
	Mon, 10 Feb 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0cTo/Z17"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596922F14E
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194534; cv=none; b=rAG6MF4DLTsm3c2gsINET6eLn8DTd5nDNMmvS7cYyESGFnKCwuXz9q82EuxdpNFnbmBZyDiNPsIzrwky1WbYUs5kgW6U/l30T+Pd6NgwzLoLHABftEKgchqrihtQ3t7ZMiobpa5nPZU3v/X09Affh/rouub0HWc2hc5tvD+aML0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194534; c=relaxed/simple;
	bh=JJjstM/ogjZx+sh7yj42cbw7BEEkilr4EU8zClyCaF4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XhMb0TnYk0aYEaolnGj6FIc0m1TAVJ0PTnUF3AigiSd5L44YACqpP6ghQv80f8eiDllskHYYacdLuDL75ECZGNLNeCBBFm3lk8RnK0CwoYzQAy3Dy8oSq1fCsb+gHHp02HbrUXn+b4gbG0QryfJl5YKhIVGAUrpRKv24OPVFRuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0cTo/Z17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8C8C4CED1;
	Mon, 10 Feb 2025 13:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739194533;
	bh=JJjstM/ogjZx+sh7yj42cbw7BEEkilr4EU8zClyCaF4=;
	h=Subject:To:Cc:From:Date:From;
	b=0cTo/Z1703Nht9/bZ9G9ps0loOlFzv0DKFKDLN9j+nWdc+RhcMREX5txBuKwNTUKd
	 6o5dVeja15VPIFjK9ETH4AwpxKdf4ZltjAeW+him8TYmgU0U6mv56juqaqTI+bgXAT
	 Vrkh69s7qtGZuIdQxhYiMu/cWf2KhM4ZKD0+Ufbw=
Subject: FAILED: patch "[PATCH] Input: synaptics - fix crash when enabling pass-through port" failed to apply to 6.12-stable tree
To: dmitry.torokhov@gmail.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:31:59 +0100
Message-ID: <2025021059-splice-blush-823b@gregkh>
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
git cherry-pick -x 08bd5b7c9a2401faabdaa1472d45c7de0755fd7e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021059-splice-blush-823b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 08bd5b7c9a2401faabdaa1472d45c7de0755fd7e Mon Sep 17 00:00:00 2001
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 17 Jan 2025 09:23:40 -0800
Subject: [PATCH] Input: synaptics - fix crash when enabling pass-through port

When enabling a pass-through port an interrupt might come before psmouse
driver binds to the pass-through port. However synaptics sub-driver
tries to access psmouse instance presumably associated with the
pass-through port to figure out if only 1 byte of response or entire
protocol packet needs to be forwarded to the pass-through port and may
crash if psmouse instance has not been attached to the port yet.

Fix the crash by introducing open() and close() methods for the port and
check if the port is open before trying to access psmouse instance.
Because psmouse calls serio_open() only after attaching psmouse instance
to serio port instance this prevents the potential crash.

Reported-by: Takashi Iwai <tiwai@suse.de>
Fixes: 100e16959c3c ("Input: libps2 - attach ps2dev instances as serio port's drvdata")
Link: https://bugzilla.suse.com/show_bug.cgi?id=1219522
Cc: stable@vger.kernel.org
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/Z4qSHORvPn7EU2j1@google.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 2735f86c23cc..aba57abe6978 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -665,23 +665,50 @@ static void synaptics_pt_stop(struct serio *serio)
 	priv->pt_port = NULL;
 }
 
+static int synaptics_pt_open(struct serio *serio)
+{
+	struct psmouse *parent = psmouse_from_serio(serio->parent);
+	struct synaptics_data *priv = parent->private;
+
+	guard(serio_pause_rx)(parent->ps2dev.serio);
+	priv->pt_port_open = true;
+
+	return 0;
+}
+
+static void synaptics_pt_close(struct serio *serio)
+{
+	struct psmouse *parent = psmouse_from_serio(serio->parent);
+	struct synaptics_data *priv = parent->private;
+
+	guard(serio_pause_rx)(parent->ps2dev.serio);
+	priv->pt_port_open = false;
+}
+
 static int synaptics_is_pt_packet(u8 *buf)
 {
 	return (buf[0] & 0xFC) == 0x84 && (buf[3] & 0xCC) == 0xC4;
 }
 
-static void synaptics_pass_pt_packet(struct serio *ptport, u8 *packet)
+static void synaptics_pass_pt_packet(struct synaptics_data *priv, u8 *packet)
 {
-	struct psmouse *child = psmouse_from_serio(ptport);
+	struct serio *ptport;
 
-	if (child && child->state == PSMOUSE_ACTIVATED) {
-		serio_interrupt(ptport, packet[1], 0);
-		serio_interrupt(ptport, packet[4], 0);
-		serio_interrupt(ptport, packet[5], 0);
-		if (child->pktsize == 4)
-			serio_interrupt(ptport, packet[2], 0);
-	} else {
-		serio_interrupt(ptport, packet[1], 0);
+	ptport = priv->pt_port;
+	if (!ptport)
+		return;
+
+	serio_interrupt(ptport, packet[1], 0);
+
+	if (priv->pt_port_open) {
+		struct psmouse *child = psmouse_from_serio(ptport);
+
+		if (child->state == PSMOUSE_ACTIVATED) {
+			serio_interrupt(ptport, packet[4], 0);
+			serio_interrupt(ptport, packet[5], 0);
+			if (child->pktsize == 4)
+				serio_interrupt(ptport, packet[2], 0);
+		}
 	}
 }
 
@@ -720,6 +747,8 @@ static void synaptics_pt_create(struct psmouse *psmouse)
 	serio->write = synaptics_pt_write;
 	serio->start = synaptics_pt_start;
 	serio->stop = synaptics_pt_stop;
+	serio->open = synaptics_pt_open;
+	serio->close = synaptics_pt_close;
 	serio->parent = psmouse->ps2dev.serio;
 
 	psmouse->pt_activate = synaptics_pt_activate;
@@ -1216,11 +1245,10 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
 
 		if (SYN_CAP_PASS_THROUGH(priv->info.capabilities) &&
 		    synaptics_is_pt_packet(psmouse->packet)) {
-			if (priv->pt_port)
-				synaptics_pass_pt_packet(priv->pt_port,
-							 psmouse->packet);
-		} else
+			synaptics_pass_pt_packet(priv, psmouse->packet);
+		} else {
 			synaptics_process_packet(psmouse);
+		}
 
 		return PSMOUSE_FULL_PACKET;
 	}
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 899aee598632..3853165b6b3a 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -188,6 +188,7 @@ struct synaptics_data {
 	bool disable_gesture;			/* disable gestures */
 
 	struct serio *pt_port;			/* Pass-through serio port */
+	bool pt_port_open;
 
 	/*
 	 * Last received Advanced Gesture Mode (AGM) packet. An AGM packet


