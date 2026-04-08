Return-Path: <stable+bounces-234882-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI6jL36l1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234882-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:59:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3D63C21EE
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 606F731068AF
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3043D9DAE;
	Wed,  8 Apr 2026 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g8Iyzooq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8843D9043;
	Wed,  8 Apr 2026 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674007; cv=none; b=jyssa6cav69p9aLN+KhT2IgBbY3eVCI+l9HpLWHyeLHCmp0PMU+g3VSNU5xC/JIbUHYSHTCotnUG40pOZnsCsGAhkniFkiYOaW1axVnsASguFJ3PBIwtQPsAlWOvgO4zQkvszv6Sn0Ewmxo2iq9BVt89cyhJZOtyt8RaTV7MeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674007; c=relaxed/simple;
	bh=nA2RL1wQdY8PRFVVy5WVc06B7WIGLUR+lLzSlDm3g9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYm6kEmn1qjdrRVmSrChN7ciAH4fjakneTnE9kvER6hxkz/K+kQNWZE/+ZeLQAsgd+A3bNXdTPVChoFAaZ0RsycXUEmSPMRy4IGDgl7AQWS50ddlNsc0X+crOH8YhYuLET9hKOSgx9fJtsj5d8jbW0Ioa3cHneCYLct+wU8nesw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g8Iyzooq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0CFC19425;
	Wed,  8 Apr 2026 18:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674007;
	bh=nA2RL1wQdY8PRFVVy5WVc06B7WIGLUR+lLzSlDm3g9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g8IyzooqOhUhaVvdSW65xcNzHQnqehRG2TcWDyzgEecU7GUWZjd5dXkC6rjVnJkVH
	 Y2A3Tlihfngy/4qr/BFTWGOayzY/b1WSYgO425uPlYYDfPapwlgx8eA3yCBqN5IDe5
	 PXhnFn1LfbeAO9piYikMH6LONPXdoTqJ2DaEiVy0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liam Mitchell <mitchell.liam@gmail.com>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.12 145/242] Input: bcm5974 - recover from failed mode switch
Date: Wed,  8 Apr 2026 20:03:05 +0200
Message-ID: <20260408175932.520936887@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-234882-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,bitmath.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,bitmath.org:email]
X-Rspamd-Queue-Id: 3B3D63C21EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liam Mitchell <mitchell.liam@gmail.com>

commit fc1e8a6f129d87c64ac8e58b50d9dfa66217cfda upstream.

Mode switches sent before control response are ignored. This results in
an unresponsive trackpad and "bcm5974: bad trackpad package, length: 8"
repeated in logs.

On receiving unknown 8-byte packets, assume that mode switch was ignored
and schedule an asynchronous mode reset. The reset will switch the
device to normal mode, wait, then switch back to wellspring mode.

Signed-off-by: Liam Mitchell <mitchell.liam@gmail.com>
Link: https://lore.kernel.org/linux-input/CAOQ1CL4+DP1TuLAGNsz5GdFBTHvnTg=5q=Dr2Z1OQc6RXydSYA@mail.gmail.com/
Acked-by: Henrik Rydberg <rydberg@bitmath.org>
Link: https://patch.msgid.link/20260213-bcm5974-reset-v2-1-1837851336b0@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/bcm5974.c |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -286,6 +286,8 @@ struct bcm5974 {
 	const struct tp_finger *index[MAX_FINGERS];	/* finger index data */
 	struct input_mt_pos pos[MAX_FINGERS];		/* position array */
 	int slots[MAX_FINGERS];				/* slot assignments */
+	struct work_struct mode_reset_work;
+	unsigned long last_mode_reset;
 };
 
 /* trackpad finger block data, le16-aligned */
@@ -696,6 +698,32 @@ static int bcm5974_wellspring_mode(struc
 	return retval;
 }
 
+/*
+ * Mode switches sent before the control response are ignored.
+ * Fixing this state requires switching to normal mode and waiting
+ * about 1ms before switching back to wellspring mode.
+ */
+static void bcm5974_mode_reset_work(struct work_struct *work)
+{
+	struct bcm5974 *dev = container_of(work, struct bcm5974, mode_reset_work);
+	int error;
+
+	guard(mutex)(&dev->pm_mutex);
+	dev->last_mode_reset = jiffies;
+
+	error = bcm5974_wellspring_mode(dev, false);
+	if (error) {
+		dev_err(&dev->intf->dev, "reset to normal mode failed\n");
+		return;
+	}
+
+	fsleep(1000);
+
+	error = bcm5974_wellspring_mode(dev, true);
+	if (error)
+		dev_err(&dev->intf->dev, "mode switch after reset failed\n");
+}
+
 static void bcm5974_irq_button(struct urb *urb)
 {
 	struct bcm5974 *dev = urb->context;
@@ -752,10 +780,20 @@ static void bcm5974_irq_trackpad(struct
 	if (dev->tp_urb->actual_length == 2)
 		goto exit;
 
-	if (report_tp_state(dev, dev->tp_urb->actual_length))
+	if (report_tp_state(dev, dev->tp_urb->actual_length)) {
 		dprintk(1, "bcm5974: bad trackpad package, length: %d\n",
 			dev->tp_urb->actual_length);
 
+		/*
+		 * Receiving a HID packet means we aren't in wellspring mode.
+		 * If we haven't tried a reset in the last second, try now.
+		 */
+		if (dev->tp_urb->actual_length == 8 &&
+		    time_after(jiffies, dev->last_mode_reset + msecs_to_jiffies(1000))) {
+			schedule_work(&dev->mode_reset_work);
+		}
+	}
+
 exit:
 	error = usb_submit_urb(dev->tp_urb, GFP_ATOMIC);
 	if (error)
@@ -906,6 +944,7 @@ static int bcm5974_probe(struct usb_inte
 	dev->intf = iface;
 	dev->input = input_dev;
 	dev->cfg = *cfg;
+	INIT_WORK(&dev->mode_reset_work, bcm5974_mode_reset_work);
 	mutex_init(&dev->pm_mutex);
 
 	/* setup urbs */
@@ -998,6 +1037,7 @@ static void bcm5974_disconnect(struct us
 {
 	struct bcm5974 *dev = usb_get_intfdata(iface);
 
+	disable_work_sync(&dev->mode_reset_work);
 	usb_set_intfdata(iface, NULL);
 
 	input_unregister_device(dev->input);



