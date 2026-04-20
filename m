Return-Path: <stable+bounces-239894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NSNCYZi5mmavgEAu9opvQ
	(envelope-from <stable+bounces-239894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:29:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B2431469
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA71A31ADAC3
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3C62853F3;
	Mon, 20 Apr 2026 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g7ykHOnU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D17B1FB1;
	Mon, 20 Apr 2026 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701486; cv=none; b=ZDaeXxgXlSJIkfLfHh9F0BlbtozIh1bS1OuzGhe/kTOx+JBx4cdghBZi2bkqPQU1KlhIQJGHxZd2g1baARYZiN1ErWPSPXGvylD6qtmfH6fMBg9b5BX9BJLjmL5Y6F+P+iMR4108peQcFt+QjOgoWaSFn+Sr34ebCDVQpDXH47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701486; c=relaxed/simple;
	bh=BL0F4xSQJ2M71R/dSfNM2e3f0IEB1HWBxq7ZRRDtxbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxdCivTPwhf8Yc2mo7ROdweiPNxHrhY708Ac1zMurSgPZy8KSownJGra4uSrNa3QF0N29iQl3UyRaeTXvbtzzZa7P2EPn5x8BQlLEAwAHI/Dmh7bTmcH1bly4JMd9Clp5CeDx0r5eXVBG0J1PUig+b2jjWUzA3cXHdRetQ/ngwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g7ykHOnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618D4C19425;
	Mon, 20 Apr 2026 16:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701485;
	bh=BL0F4xSQJ2M71R/dSfNM2e3f0IEB1HWBxq7ZRRDtxbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7ykHOnUxuKBDdCNNnTPxyiXRVJwho6gpYm2lRTBDgyaq5oDXyzislbjEiFn7ccPo
	 Wm0tpVwKRVpUDluQol2ZAuSAJSssBQgmH6SUxxA+Z4PVH9QARA6GZ8jaPPbvuBGk7E
	 8n//eR6Vsj6Qh+XQLCN1YOK8gG/PDWbb/iBYxLZI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Lewalski <jakub.lewalski@nokia.com>,
	=?UTF-8?q?Pawe=C5=82=20Narewski?= <pawel.narewski@nokia.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 133/162] gpiolib: fix race condition for gdev->srcu
Date: Mon, 20 Apr 2026 17:42:45 +0200
Message-ID: <20260420153931.862711703@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239894-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,nokia.com:email]
X-Rspamd-Queue-Id: 2D7B2431469
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paweł Narewski <pawel.narewski@nokia.com>

[ Upstream commit a7ac22d53d0990152b108c3f4fe30df45fcb0181 ]

If two drivers were calling gpiochip_add_data_with_key(), one may be
traversing the srcu-protected list in gpio_name_to_desc(), meanwhile
other has just added its gdev in gpiodev_add_to_list_unlocked().
This creates a non-mutexed and non-protected timeframe, when one
instance is dereferencing and using &gdev->srcu, before the other
has initialized it, resulting in crash:

[    4.935481] Unable to handle kernel paging request at virtual address ffff800272bcc000
[    4.943396] Mem abort info:
[    4.943400]   ESR = 0x0000000096000005
[    4.943403]   EC = 0x25: DABT (current EL), IL = 32 bits
[    4.943407]   SET = 0, FnV = 0
[    4.943410]   EA = 0, S1PTW = 0
[    4.943413]   FSC = 0x05: level 1 translation fault
[    4.943416] Data abort info:
[    4.943418]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[    4.946220]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    4.955261]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    4.955268] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000038e6c000
[    4.961449] [ffff800272bcc000] pgd=0000000000000000
[    4.969203] , p4d=1000000039739003
[    4.979730] , pud=0000000000000000
[    4.980210] phandle (CPU): 0x0000005e, phandle (BE): 0x5e000000 for node "reset"
[    4.991736] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
...
[    5.121359] pc : __srcu_read_lock+0x44/0x98
[    5.131091] lr : gpio_name_to_desc+0x60/0x1a0
[    5.153671] sp : ffff8000833bb430
[    5.298440]
[    5.298443] Call trace:
[    5.298445]  __srcu_read_lock+0x44/0x98
[    5.309484]  gpio_name_to_desc+0x60/0x1a0
[    5.320692]  gpiochip_add_data_with_key+0x488/0xf00
    5.946419] ---[ end trace 0000000000000000 ]---

Move initialization code for gdev fields before it is added to
gpio_devices, with adjacent initialization code.
Adjust goto statements  to reflect modified order of operations

Fixes: 47d8b4c1d868 ("gpio: add SRCU infrastructure to struct gpio_device")
Reviewed-by: Jakub Lewalski <jakub.lewalski@nokia.com>
Signed-off-by: Paweł Narewski <pawel.narewski@nokia.com>
[Bartosz: fixed a build issue, removed stray newline]
Link: https://lore.kernel.org/r/20251224082641.10769-1-bartosz.golaszewski@oss.qualcomm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
[missing commit fcc8b637c542 ("gpiolib: switch the line state notifier
 to atomic"), commit dcb73cbaaeb3 ("gpio: cdev: use raw notifier for
 line state events") and commit d4f335b410dd ("gpiolib: rename GPIO chip
 printk macros") in 6.12.y.
 Both notifiers as well as both srcu inits are moved before the
 scoped_guard, following same logic as in a7ac22d53d09.
 Rest is changes to git context only.]
Cc: stable@vger.kernel.org # 6.12
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3f9019cc832ac..5c8cd81656963 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -988,6 +988,17 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gdev->ngpio = gc->ngpio;
 	gdev->can_sleep = gc->can_sleep;
 
+	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
+	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
+
+	ret = init_srcu_struct(&gdev->srcu);
+	if (ret)
+		goto err_free_label;
+
+	ret = init_srcu_struct(&gdev->desc_srcu);
+	if (ret)
+		goto err_cleanup_gdev_srcu;
+
 	scoped_guard(mutex, &gpio_devices_lock) {
 		/*
 		 * TODO: this allocates a Linux GPIO number base in the global
@@ -1002,7 +1013,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			if (base < 0) {
 				ret = base;
 				base = 0;
-				goto err_free_label;
+				goto err_cleanup_desc_srcu;
 			}
 
 			/*
@@ -1022,21 +1033,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		ret = gpiodev_add_to_list_unlocked(gdev);
 		if (ret) {
 			chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
-			goto err_free_label;
+			goto err_cleanup_desc_srcu;
 		}
 	}
 
-	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->line_state_notifier);
-	BLOCKING_INIT_NOTIFIER_HEAD(&gdev->device_notifier);
-
-	ret = init_srcu_struct(&gdev->srcu);
-	if (ret)
-		goto err_remove_from_list;
-
-	ret = init_srcu_struct(&gdev->desc_srcu);
-	if (ret)
-		goto err_cleanup_gdev_srcu;
-
 #ifdef CONFIG_PINCTRL
 	INIT_LIST_HEAD(&gdev->pin_ranges);
 #endif
@@ -1046,11 +1046,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	ret = gpiochip_set_names(gc);
 	if (ret)
-		goto err_cleanup_desc_srcu;
+		goto err_remove_from_list;
 
 	ret = gpiochip_init_valid_mask(gc);
 	if (ret)
-		goto err_cleanup_desc_srcu;
+		goto err_remove_from_list;
 
 	for (desc_index = 0; desc_index < gc->ngpio; desc_index++) {
 		struct gpio_desc *desc = &gdev->descs[desc_index];
@@ -1117,10 +1117,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	of_gpiochip_remove(gc);
 err_free_valid_mask:
 	gpiochip_free_valid_mask(gc);
-err_cleanup_desc_srcu:
-	cleanup_srcu_struct(&gdev->desc_srcu);
-err_cleanup_gdev_srcu:
-	cleanup_srcu_struct(&gdev->srcu);
 err_remove_from_list:
 	scoped_guard(mutex, &gpio_devices_lock)
 		list_del_rcu(&gdev->list);
@@ -1130,6 +1126,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		gpio_device_put(gdev);
 		goto err_print_message;
 	}
+err_cleanup_desc_srcu:
+	cleanup_srcu_struct(&gdev->desc_srcu);
+err_cleanup_gdev_srcu:
+	cleanup_srcu_struct(&gdev->srcu);
 err_free_label:
 	kfree_const(gdev->label);
 err_free_descs:
-- 
2.53.0




