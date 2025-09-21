Return-Path: <stable+bounces-180783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FEBB8DB01
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5BB3BC8D5
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA001A9F9E;
	Sun, 21 Sep 2025 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xlump8/8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6371853
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457991; cv=none; b=Q2sIHoEfh6JAvLipUN4GNmlBMHpruM0I2mOzPyS414T/Co+FtNrHXiP4S+bPgDUWNHIMtEHxpdHDIYPKz3LNgZJKVcAgWxuWEcTwBX+yz3q8WDRmHBJXW4x7vbO2PPnCtr8Sx67hhlNjhB+ReD4ghK2I2aqNAPT35JoTUbc+Irk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457991; c=relaxed/simple;
	bh=tkcyCxtCZ80mPlsMUJ52W4xRqOlbrY62h36sYhCKljI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=te5ExyUzxFb6uGr+w30UIkOHInf3A4c3TKCL3g8vQAns8Zmxhtw5gms5tJe/jrl3VBMyEWYTcBfw2O9fOSfS9axK312C08TCGoUmF5Dag+iyIfGsvomftTVx3xBfwrkLextVuGBeIJOg3aG8B46ISOfhA4LR1VaRkYJfyDGvgmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xlump8/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B243C4CEE7;
	Sun, 21 Sep 2025 12:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457991;
	bh=tkcyCxtCZ80mPlsMUJ52W4xRqOlbrY62h36sYhCKljI=;
	h=Subject:To:Cc:From:Date:From;
	b=xlump8/8/0LSSJPODfBLdqF6qGaU6DYyAQmvcGw1eI0MjDe/BmiBsJaXnwoSAnqh9
	 hbkl1qX4MasqqUhbm/ahGZ1HuDCEF+0p7SpiO7L9qE+j55KtKX4zRNSRFxPfEG6PG1
	 BtQ76F/hBXxTrc9y8X2K3YJcf+whXFSabaXizdmI=
Subject: FAILED: patch "[PATCH] net: rfkill: gpio: Fix crash due to dereferencering" failed to apply to 5.4-stable tree
To: hansg@kernel.org,heikki.krogerus@linux.intel.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:32:57 +0200
Message-ID: <2025092157-imagines-darkroom-e5c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b6f56a44e4c1014b08859dcf04ed246500e310e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092157-imagines-darkroom-e5c5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b6f56a44e4c1014b08859dcf04ed246500e310e5 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hansg@kernel.org>
Date: Sat, 13 Sep 2025 13:35:15 +0200
Subject: [PATCH] net: rfkill: gpio: Fix crash due to dereferencering
 uninitialized pointer

Since commit 7d5e9737efda ("net: rfkill: gpio: get the name and type from
device property") rfkill_find_type() gets called with the possibly
uninitialized "const char *type_name;" local variable.

On x86 systems when rfkill-gpio binds to a "BCM4752" or "LNV4752"
acpi_device, the rfkill->type is set based on the ACPI acpi_device_id:

        rfkill->type = (unsigned)id->driver_data;

and there is no "type" property so device_property_read_string() will fail
and leave type_name uninitialized, leading to a potential crash.

rfkill_find_type() does accept a NULL pointer, fix the potential crash
by initializing type_name to NULL.

Note likely sofar this has not been caught because:

1. Not many x86 machines actually have a "BCM4752"/"LNV4752" acpi_device
2. The stack happened to contain NULL where type_name is stored

Fixes: 7d5e9737efda ("net: rfkill: gpio: get the name and type from device property")
Cc: stable@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hansg@kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20250913113515.21698-1-hansg@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 41e657e97761..cf2dcec6ce5a 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -94,10 +94,10 @@ static const struct dmi_system_id rfkill_gpio_deny_table[] = {
 static int rfkill_gpio_probe(struct platform_device *pdev)
 {
 	struct rfkill_gpio_data *rfkill;
-	struct gpio_desc *gpio;
+	const char *type_name = NULL;
 	const char *name_property;
 	const char *type_property;
-	const char *type_name;
+	struct gpio_desc *gpio;
 	int ret;
 
 	if (dmi_check_system(rfkill_gpio_deny_table))


