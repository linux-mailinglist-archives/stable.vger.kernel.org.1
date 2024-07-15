Return-Path: <stable+bounces-59289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3B79310AC
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 10:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D56DCB227F0
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E2D1836CE;
	Mon, 15 Jul 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jKCCGbgf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B273513B59B
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033629; cv=none; b=uZbxNE4l0GEet271Rz6qWxqZ3vOlyPJzqUqn+d72PGv5w2d31jb37yEpCkIkDlAJQ9dwJZk6jQN/khAc1JjT4Dicdmheh5Sha8Wo0RdXCahPFy8xUaVVQsKi7uHH1MisK1nrUFhvOV5t5h4k5fRhHRo4J+ln10SkrnFcnjBL9/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033629; c=relaxed/simple;
	bh=dSnrShJrI5NIJdWMx2X/+qURsKFGkRZW9da7CwhOWf0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jXR3rkEVfBAZcSkeHKoq+yfR38JdeQTzrX4TwGqrK6+qd/5iqI57aEWV+1cfSiPd92fuG8b8146EEEW9dmiN3kcrF7SMkn1czygvjwo1fqjos2hmB/qgarYUlSoGez3NZqkBhktOnP4KZNCMP7wi4WvZb3hdqUqeaxJxOyNooeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jKCCGbgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85BDC32782;
	Mon, 15 Jul 2024 08:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721033629;
	bh=dSnrShJrI5NIJdWMx2X/+qURsKFGkRZW9da7CwhOWf0=;
	h=Subject:To:Cc:From:Date:From;
	b=jKCCGbgfE5tJNudnIrJVyzXNQKIeOGlNQQhEBDDoaMCkitt8sWalFOFNVFJuJQi1F
	 rEg7GUwl0Cr4G4DYYKa588IQ371XQgq8Pw/FhrsLxu/ulGCJBZjO3GiOr4KuMFx8Fl
	 9fOTricdoGhw+iond2iQPKoxf3MD4MVG2vKq7Sac=
Subject: FAILED: patch "[PATCH] USB: serial: mos7840: fix crash on resume" failed to apply to 4.19-stable tree
To: d.smirnov@inbox.lv,johan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 10:53:38 +0200
Message-ID: <2024071538-nerd-march-746a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x c15a688e49987385baa8804bf65d570e362f8576
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071538-nerd-march-746a@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

c15a688e4998 ("USB: serial: mos7840: fix crash on resume")
7183192196a6 ("USB: serial: mos7840: rip out broken interrupt handling")
32d8a6fc5bd6 ("USB: serial: mos7840: remove set but not used variables 'st, data1, iflag'")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c15a688e49987385baa8804bf65d570e362f8576 Mon Sep 17 00:00:00 2001
From: Dmitry Smirnov <d.smirnov@inbox.lv>
Date: Sat, 15 Jun 2024 01:45:56 +0300
Subject: [PATCH] USB: serial: mos7840: fix crash on resume

Since commit c49cfa917025 ("USB: serial: use generic method if no
alternative is provided in usb serial layer"), USB serial core calls the
generic resume implementation when the driver has not provided one.

This can trigger a crash on resume with mos7840 since support for
multiple read URBs was added back in 2011. Specifically, both port read
URBs are now submitted on resume for open ports, but the context pointer
of the second URB is left set to the core rather than mos7840 port
structure.

Fix this by implementing dedicated suspend and resume functions for
mos7840.

Tested with Delock 87414 USB 2.0 to 4x serial adapter.

Signed-off-by: Dmitry Smirnov <d.smirnov@inbox.lv>
[ johan: analyse crash and rewrite commit message; set busy flag on
         resume; drop bulk-in check; drop unnecessary usb_kill_urb() ]
Fixes: d83b405383c9 ("USB: serial: add support for multiple read urbs")
Cc: stable@vger.kernel.org	# 3.3
Signed-off-by: Johan Hovold <johan@kernel.org>

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 8b0308d84270..85697466b147 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1737,6 +1737,49 @@ static void mos7840_port_remove(struct usb_serial_port *port)
 	kfree(mos7840_port);
 }
 
+static int mos7840_suspend(struct usb_serial *serial, pm_message_t message)
+{
+	struct moschip_port *mos7840_port;
+	struct usb_serial_port *port;
+	int i;
+
+	for (i = 0; i < serial->num_ports; ++i) {
+		port = serial->port[i];
+		if (!tty_port_initialized(&port->port))
+			continue;
+
+		mos7840_port = usb_get_serial_port_data(port);
+
+		usb_kill_urb(mos7840_port->read_urb);
+		mos7840_port->read_urb_busy = false;
+	}
+
+	return 0;
+}
+
+static int mos7840_resume(struct usb_serial *serial)
+{
+	struct moschip_port *mos7840_port;
+	struct usb_serial_port *port;
+	int res;
+	int i;
+
+	for (i = 0; i < serial->num_ports; ++i) {
+		port = serial->port[i];
+		if (!tty_port_initialized(&port->port))
+			continue;
+
+		mos7840_port = usb_get_serial_port_data(port);
+
+		mos7840_port->read_urb_busy = true;
+		res = usb_submit_urb(mos7840_port->read_urb, GFP_NOIO);
+		if (res)
+			mos7840_port->read_urb_busy = false;
+	}
+
+	return 0;
+}
+
 static struct usb_serial_driver moschip7840_4port_device = {
 	.driver = {
 		   .owner = THIS_MODULE,
@@ -1764,6 +1807,8 @@ static struct usb_serial_driver moschip7840_4port_device = {
 	.port_probe = mos7840_port_probe,
 	.port_remove = mos7840_port_remove,
 	.read_bulk_callback = mos7840_bulk_in_callback,
+	.suspend = mos7840_suspend,
+	.resume = mos7840_resume,
 };
 
 static struct usb_serial_driver * const serial_drivers[] = {


