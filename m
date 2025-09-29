Return-Path: <stable+bounces-181899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C427BA945A
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 15:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DF51613D6
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 13:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADD83064AD;
	Mon, 29 Sep 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xLjISFqG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1D2FF660
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151023; cv=none; b=unBeOKKqp11v4SVgcGN6SwrcaoHw70vigoL2K+YAh1S+rqI58Y7z1i9pNkzKLCgR/C/VD/zxnaFkk3Oh6V70WWXibxJA7XbdFfec413i4GQo0sxnoNCtHIx5JyYpHYGWVuNsmrdnmCdaNBX/yt8SIKCJ+QXYGJmBxuPx9uL3p8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151023; c=relaxed/simple;
	bh=TjMczk8kQk8QAsVj5Kfcr0zW/gM/XDikVxvjZqE/EPw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XY864rXRvxZx7Ns1CGs8PDJGuhUIHO3bFJ7yDKoTT9xPfpszGH6ba5jMC/jLvBROt9lVJo9KxFrjqbf8FX7jkvn3DIrjZrObEcMl7X1deEAn0p4do2iKpGxZFG1fHb6cEYAKxVaTO/Kuvc+W6TAFGukflUNmqYLhEPJgwyYliXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xLjISFqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BD0C113D0;
	Mon, 29 Sep 2025 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759151023;
	bh=TjMczk8kQk8QAsVj5Kfcr0zW/gM/XDikVxvjZqE/EPw=;
	h=Subject:To:Cc:From:Date:From;
	b=xLjISFqGrSCDn+FS6T5mT2shUr8qfKozQbDgEj1riHupVjEb25ti1bAdGtpmS2Z+S
	 O1eqdHkjyO8AFNZhdECw01tzLE7zj7P1uRUTzIRC/PV02IHXpvhjWtbQxeMlv2bfWO
	 GSeTz27rEAKKw5+fe8+UWLCsZu/NJJCtSj750m9I=
Subject: FAILED: patch "[PATCH] gpiolib: Extend software-node support to support secondary" failed to apply to 6.6-stable tree
To: hansg@kernel.org,bartosz.golaszewski@linaro.org,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Sep 2025 15:03:39 +0200
Message-ID: <2025092939-unsafe-alfalfa-105c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c6ccc4dde17676dfe617b9a37bd9ba19a8fc87ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092939-unsafe-alfalfa-105c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c6ccc4dde17676dfe617b9a37bd9ba19a8fc87ee Mon Sep 17 00:00:00 2001
From: Hans de Goede <hansg@kernel.org>
Date: Sat, 20 Sep 2025 22:09:55 +0200
Subject: [PATCH] gpiolib: Extend software-node support to support secondary
 software-nodes

When a software-node gets added to a device which already has another
fwnode as primary node it will become the secondary fwnode for that
device.

Currently if a software-node with GPIO properties ends up as the secondary
fwnode then gpiod_find_by_fwnode() will fail to find the GPIOs.

Add a new gpiod_fwnode_lookup() helper which falls back to calling
gpiod_find_by_fwnode() with the secondary fwnode if the GPIO was not
found in the primary fwnode.

Fixes: e7f9ff5dc90c ("gpiolib: add support for software nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hansg@kernel.org>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/20250920200955.20403-1-hansg@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 0d2b470a252e..74d54513730a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4604,6 +4604,23 @@ static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
 	return desc;
 }
 
+static struct gpio_desc *gpiod_fwnode_lookup(struct fwnode_handle *fwnode,
+					     struct device *consumer,
+					     const char *con_id,
+					     unsigned int idx,
+					     enum gpiod_flags *flags,
+					     unsigned long *lookupflags)
+{
+	struct gpio_desc *desc;
+
+	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, flags, lookupflags);
+	if (gpiod_not_found(desc) && !IS_ERR_OR_NULL(fwnode))
+		desc = gpiod_find_by_fwnode(fwnode->secondary, consumer, con_id,
+					    idx, flags, lookupflags);
+
+	return desc;
+}
+
 struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 					 struct fwnode_handle *fwnode,
 					 const char *con_id,
@@ -4622,8 +4639,8 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 	int ret = 0;
 
 	scoped_guard(srcu, &gpio_devices_srcu) {
-		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
-					    &flags, &lookupflags);
+		desc = gpiod_fwnode_lookup(fwnode, consumer, con_id, idx,
+					   &flags, &lookupflags);
 		if (gpiod_not_found(desc) && platform_lookup_allowed) {
 			/*
 			 * Either we are not using DT or ACPI, or their lookup


