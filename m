Return-Path: <stable+bounces-211810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOqaLHi+eGn6sgEAu9opvQ
	(envelope-from <stable+bounces-211810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:32:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C5294EFA
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B029303FDC5
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A69D2E889C;
	Tue, 27 Jan 2026 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="folgDE8L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35D357A52
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520592; cv=none; b=E0jOjgkOfMiGLuRrSwNC5YFcIb6GMax9CXKU47Y8iJcCRPawh0Nem4mwvtUn3Px9+JR8HiKu64c82HZRo6Nu9Kn+E708IwVF5Q/RZCiuwoxxCV2KDOAYSZio2gRWo0nVes+eLxKSQq2e4IR7RWRZ3Dzj8LcrCd64/K5LZhPKs6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520592; c=relaxed/simple;
	bh=Hc6l7tFTqznB4E4N24EMkd7iEpYcipXJH1xcJY/84BY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XvjUzsdJc74ps1Ggs6x7/yr7fZlZAC1usCf+er/Ar7Sp2nNB52iYcF2eCyMGuAcQcRQxdJHchMs3ek9jj979vZmP1pVfuNMkDq9rDD4zOoy3DKKFUryGxAWX1Dmu5WRIHwf5dJfKF64szmlbCe3hneqBO/pdM6V4xg5h/Yo3Ndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=folgDE8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8240AC19422;
	Tue, 27 Jan 2026 13:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769520592;
	bh=Hc6l7tFTqznB4E4N24EMkd7iEpYcipXJH1xcJY/84BY=;
	h=Subject:To:Cc:From:Date:From;
	b=folgDE8Lr/Ak/Zni5n73qdvqhFvbVyGMYrDrRAJSUY6JxAon9DC4j+0G7l5EAJOr2
	 xOyXghjauK5zAqvGvaT+aEv5dPv3v9yHDZ/IiZSo7CkrknufRa6YwECVaf1QRUr7Du
	 hjWgWvWgf4wC6s1kT4Cj8M0Pbd9DL9o2FgVCqODs=
Subject: FAILED: patch "[PATCH] gpio: cdev: Fix resource leaks on errors in" failed to apply to 6.12-stable tree
To: tzungbi@kernel.org,bartosz.golaszewski@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:29:18 +0100
Message-ID: <2026012718-antacid-populace-6683@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211810-lists,stable=lfdr.de];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[qualcomm.com:query timed out];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 58C5294EFA
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8a8c942cad4cd12f739a8bb60cac77fd173c4e07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012718-antacid-populace-6683@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8a8c942cad4cd12f739a8bb60cac77fd173c4e07 Mon Sep 17 00:00:00 2001
From: Tzung-Bi Shih <tzungbi@kernel.org>
Date: Tue, 20 Jan 2026 09:26:50 +0000
Subject: [PATCH] gpio: cdev: Fix resource leaks on errors in
 gpiolib_cdev_register()

On error handling paths, gpiolib_cdev_register() doesn't free the
allocated resources which results leaks.  Fix it.

Cc: stable@vger.kernel.org
Fixes: 7b9b77a8bba9 ("gpiolib: add a per-gpio_device line state notification workqueue")
Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Link: https://lore.kernel.org/r/20260120092650.2305319-1-tzungbi@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index ed249a45d658..2adc3c070908 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2797,13 +2797,18 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 		return -ENOMEM;
 
 	ret = cdev_device_add(&gdev->chrdev, &gdev->dev);
-	if (ret)
+	if (ret) {
+		destroy_workqueue(gdev->line_state_wq);
 		return ret;
+	}
 
 	guard(srcu)(&gdev->srcu);
 	gc = srcu_dereference(gdev->chip, &gdev->srcu);
-	if (!gc)
+	if (!gc) {
+		cdev_device_del(&gdev->chrdev, &gdev->dev);
+		destroy_workqueue(gdev->line_state_wq);
 		return -ENODEV;
+	}
 
 	gpiochip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);
 


