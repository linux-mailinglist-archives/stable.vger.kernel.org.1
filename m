Return-Path: <stable+bounces-208097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 332EAD11FA8
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3500530203A6
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751DD327C09;
	Mon, 12 Jan 2026 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F88A2J6P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0026056E
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214645; cv=none; b=u5EpXFheVvAqIvm8r8NPxLnPCtAnwJvn9sBeqQozuvN9Gbt4ppur6Q/ajEfrfiBvVlQny7gHPtdQ+VoSPLnctzUehdg7iexTgHX8+7Ihmlj0sv6Cj48V61qJCj2E73C2R9txdEthVN2FbKnKAkLj8Cr2obHNhRyvz9T6kVn7Q1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214645; c=relaxed/simple;
	bh=WR/FmSwgtZpPu5FW6AVmL2tiQi6SCincDE4v1iZEgj4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KLWZJQCww3MTz+4cJKcLmMNlwUpNoTJLkjs54JriMF9Y5G+bYQJnrCmw4BZvrLNPW7yea0IYvS3E7FxhRgSIgXj+iFk20K61wGomRQKdtObRj16Ohpbl1kwcQ1w/NqVwNAC86SdBr78BWUq/Bs2ijGirDbfx/GlGtsfEEQ5M1Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F88A2J6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6972C19424;
	Mon, 12 Jan 2026 10:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768214645;
	bh=WR/FmSwgtZpPu5FW6AVmL2tiQi6SCincDE4v1iZEgj4=;
	h=Subject:To:Cc:From:Date:From;
	b=F88A2J6P0i+VgoAHcaBQd4UkZsRdQF6FlN+QC1shiLflK20CQP4E0auu6BUcqwJLj
	 hifUwLf+dbHA90JgvnoE/idnRM/KSD43SbyazMHsJpuYpki7gVVPR8/kmWL2NK3KEE
	 DLvRwRbNftQ0GsZiFJMPHR017+sPp7Pfp1DdIqaQ=
Subject: FAILED: patch "[PATCH] gpio: mpsse: fix reference leak in gpio_mpsse_probe() error" failed to apply to 6.18-stable tree
To: nihaal@cse.iitm.ac.in,bartosz.golaszewski@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Jan 2026 11:44:02 +0100
Message-ID: <2026011202-scheming-operating-3cbb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1e876e5a0875e71e34148c9feb2eedd3bf6b2b43
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011202-scheming-operating-3cbb@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e876e5a0875e71e34148c9feb2eedd3bf6b2b43 Mon Sep 17 00:00:00 2001
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Fri, 26 Dec 2025 11:34:10 +0530
Subject: [PATCH] gpio: mpsse: fix reference leak in gpio_mpsse_probe() error
 paths

The reference obtained by calling usb_get_dev() is not released in the
gpio_mpsse_probe() error paths. Fix that by using device managed helper
functions. Also remove the usb_put_dev() call in the disconnect function
since now it will be released automatically.

Cc: stable@vger.kernel.org
Fixes: c46a74ff05c0 ("gpio: add support for FTDI's MPSSE as GPIO")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Link: https://lore.kernel.org/r/20251226060414.20785-1-nihaal@cse.iitm.ac.in
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

diff --git a/drivers/gpio/gpio-mpsse.c b/drivers/gpio/gpio-mpsse.c
index ace652ba4df1..12191aeb6566 100644
--- a/drivers/gpio/gpio-mpsse.c
+++ b/drivers/gpio/gpio-mpsse.c
@@ -548,6 +548,13 @@ static void gpio_mpsse_ida_remove(void *data)
 	ida_free(&gpio_mpsse_ida, priv->id);
 }
 
+static void gpio_mpsse_usb_put_dev(void *data)
+{
+	struct mpsse_priv *priv = data;
+
+	usb_put_dev(priv->udev);
+}
+
 static int mpsse_init_valid_mask(struct gpio_chip *chip,
 				 unsigned long *valid_mask,
 				 unsigned int ngpios)
@@ -592,6 +599,10 @@ static int gpio_mpsse_probe(struct usb_interface *interface,
 	INIT_LIST_HEAD(&priv->workers);
 
 	priv->udev = usb_get_dev(interface_to_usbdev(interface));
+	err = devm_add_action_or_reset(dev, gpio_mpsse_usb_put_dev, priv);
+	if (err)
+		return err;
+
 	priv->intf = interface;
 	priv->intf_id = interface->cur_altsetting->desc.bInterfaceNumber;
 
@@ -713,7 +724,6 @@ static void gpio_mpsse_disconnect(struct usb_interface *intf)
 
 	priv->intf = NULL;
 	usb_set_intfdata(intf, NULL);
-	usb_put_dev(priv->udev);
 }
 
 static struct usb_driver gpio_mpsse_driver = {


