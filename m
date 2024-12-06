Return-Path: <stable+bounces-99049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA65C9E6E0F
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A961D1626E8
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFE920100D;
	Fri,  6 Dec 2024 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WSkFicVM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB21D63CB
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733487898; cv=none; b=gvvp7R/yEB6uwtjGcYXMwBH5FXcWinbxnpBtgfXuLtvCo3qRw+HtjwEUlX6GvgJxwVY2VueceonYMVv9plLIZQ7IqieknXC9B8hsUaRXKTV1LR5+DAKze4bCpUR7EGZppghfjNIlcdhLC6J9GRAtVQUe7k+NJhZqzY0l59VqH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733487898; c=relaxed/simple;
	bh=2EN/Mz94NbZ8winvl1rPF+sGaB4Rq+t0xYG340eIgDM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P1F76CtuUv/ZDjO8xkfH+RnBLyPYmabvD9bELNwAhdg0tdrriPuLNluxCmSn5BWctEl1YYZ58WhYacPfOn3lhaGA2N4tW/TiQHxltoXook8en97ATwMLVp4dCaRlXp1XHyHv2fFPcHMaVuulOIMBFMBWEeBBkqGIIZeRIfXHMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WSkFicVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B50CC4CED1;
	Fri,  6 Dec 2024 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733487898;
	bh=2EN/Mz94NbZ8winvl1rPF+sGaB4Rq+t0xYG340eIgDM=;
	h=Subject:To:Cc:From:Date:From;
	b=WSkFicVMGZaX/SXJCIUPQ1IvXw8nMB+Qx65NFXJBPybh4zTRhpYbUXqyqop1JfWMn
	 8d/KM6c5yv26s66t7JSOyMJx24Ue7Fkb/nbQ4PpL7NAjVkO5vapyyiE+snaU80GLNK
	 xiKMGRlEZi1fA9TP/ggQtywXro5aYyN3KbIBAmfw=
Subject: FAILED: patch "[PATCH] leds: flash: mt6360: Fix device_for_each_child_node()" failed to apply to 6.1-stable tree
To: javier.carrasco.cruz@gmail.com,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:24:54 +0100
Message-ID: <2024120654-feminize-upstart-b8c4@gregkh>
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
git cherry-pick -x 73b03b27736e440e3009fe1319cbc82d2cd1290c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120654-feminize-upstart-b8c4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 73b03b27736e440e3009fe1319cbc82d2cd1290c Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 27 Sep 2024 01:20:52 +0200
Subject: [PATCH] leds: flash: mt6360: Fix device_for_each_child_node()
 refcounting in error paths

The device_for_each_child_node() macro requires explicit calls to
fwnode_handle_put() upon early exits to avoid memory leaks, and in
this case the error paths are handled after jumping to
'out_flash_realease', which misses that required call to
to decrement the refcount of the child node.

A more elegant and robust solution is using the scoped variant of the
loop, which automatically handles such early exits.

Fix the child node refcounting in the error paths by using
device_for_each_child_node_scoped().

Cc: stable@vger.kernel.org
Fixes: 679f8652064b ("leds: Add mt6360 driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://lore.kernel.org/r/20240927-leds_device_for_each_child_node_scoped-v1-1-95c0614b38c8@gmail.com
Signed-off-by: Lee Jones <lee@kernel.org>

diff --git a/drivers/leds/flash/leds-mt6360.c b/drivers/leds/flash/leds-mt6360.c
index 4c74f1cf01f0..676236c19ec4 100644
--- a/drivers/leds/flash/leds-mt6360.c
+++ b/drivers/leds/flash/leds-mt6360.c
@@ -784,7 +784,6 @@ static void mt6360_v4l2_flash_release(struct mt6360_priv *priv)
 static int mt6360_led_probe(struct platform_device *pdev)
 {
 	struct mt6360_priv *priv;
-	struct fwnode_handle *child;
 	size_t count;
 	int i = 0, ret;
 
@@ -811,7 +810,7 @@ static int mt6360_led_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	device_for_each_child_node(&pdev->dev, child) {
+	device_for_each_child_node_scoped(&pdev->dev, child) {
 		struct mt6360_led *led = priv->leds + i;
 		struct led_init_data init_data = { .fwnode = child, };
 		u32 reg, led_color;


