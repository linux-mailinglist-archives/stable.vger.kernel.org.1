Return-Path: <stable+bounces-81224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85303992804
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 11:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6ECC1C225E4
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD2E18CC0A;
	Mon,  7 Oct 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ls4gUCLj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE881741E0
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293145; cv=none; b=K7oHyfAYWGA9xH3AGjY3SPZKHFMYTh+55YT42MZlTewPPLiGKwo2KcI7AD9TtL5yFrldXoLoMqveluhMoA29CTZqAGDPW0VanIV7ZEXwuObtDijPKNv2zygv4jvJgmqrAZ8WUELKsCiDILsHX3B1nWNKB8IZ4k2oFJcaZRDvWMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293145; c=relaxed/simple;
	bh=5fs6csZpv0h0ypmNhCmHGnCE8li+cw8EZLgNwPAm7WM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tO0MhOMdrW5lyG99Z5KWS6HHcV3WQKa5jGLmHzISp+rD/BsnGXtxngpulig29QKsJVBwHIZDUy6Nb3IKHrtxVnx3b1+nov6IHrdopDhcLkRtadc/Ty1VoI5pHtBKLg7LYKMSn3zpKwWN5bZE05LfjpafrpFA2MyqhWY5KVTMUew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ls4gUCLj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73595C4CEC6;
	Mon,  7 Oct 2024 09:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728293144;
	bh=5fs6csZpv0h0ypmNhCmHGnCE8li+cw8EZLgNwPAm7WM=;
	h=Subject:To:Cc:From:Date:From;
	b=Ls4gUCLjnUg7nx90B5IU+dRRHuibBnOjEs9nwz9n/bmNn1l9MtOTA5mbleORIMoOV
	 NKMyw1Z8SKFUn7opwJ9hR3eiXs8R6uqaZQy+pMOvb8R8fEcE5Kl0o7lP7orwYUYLZc
	 EGBvnF6WTFdgSiEKbk6zawdoIHEYt+dcZORORhUU=
Subject: FAILED: patch "[PATCH] platform/x86: x86-android-tablets: Fix use after free on" failed to apply to 6.6-stable tree
To: hdegoede@redhat.com,a.burakov@rosalinux.ru
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 11:25:42 +0200
Message-ID: <2024100741-rubber-buzz-b17a@gregkh>
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
git cherry-pick -x 2fae3129c0c08e72b1fe93e61fd8fd203252094a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100741-rubber-buzz-b17a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

2fae3129c0c0 ("platform/x86: x86-android-tablets: Fix use after free on platform_device_register() errors")
8b57d33a6fdb ("platform/x86: x86-android-tablets: Create a platform_device from module_init()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2fae3129c0c08e72b1fe93e61fd8fd203252094a Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 5 Oct 2024 15:05:45 +0200
Subject: [PATCH] platform/x86: x86-android-tablets: Fix use after free on
 platform_device_register() errors

x86_android_tablet_remove() frees the pdevs[] array, so it should not
be used after calling x86_android_tablet_remove().

When platform_device_register() fails, store the pdevs[x] PTR_ERR() value
into the local ret variable before calling x86_android_tablet_remove()
to avoid using pdevs[] after it has been freed.

Fixes: 5eba0141206e ("platform/x86: x86-android-tablets: Add support for instantiating platform-devs")
Fixes: e2200d3f26da ("platform/x86: x86-android-tablets: Add gpio_keys support to x86_android_tablet_init()")
Cc: stable@vger.kernel.org
Reported-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
Closes: https://lore.kernel.org/platform-driver-x86/20240917120458.7300-1-a.burakov@rosalinux.ru/
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20241005130545.64136-1-hdegoede@redhat.com

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
index 1427a9a39008..ef572b90e06b 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -390,8 +390,9 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 	for (i = 0; i < pdev_count; i++) {
 		pdevs[i] = platform_device_register_full(&dev_info->pdev_info[i]);
 		if (IS_ERR(pdevs[i])) {
+			ret = PTR_ERR(pdevs[i]);
 			x86_android_tablet_remove(pdev);
-			return PTR_ERR(pdevs[i]);
+			return ret;
 		}
 	}
 
@@ -443,8 +444,9 @@ static __init int x86_android_tablet_probe(struct platform_device *pdev)
 								  PLATFORM_DEVID_AUTO,
 								  &pdata, sizeof(pdata));
 		if (IS_ERR(pdevs[pdev_count])) {
+			ret = PTR_ERR(pdevs[pdev_count]);
 			x86_android_tablet_remove(pdev);
-			return PTR_ERR(pdevs[pdev_count]);
+			return ret;
 		}
 		pdev_count++;
 	}


