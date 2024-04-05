Return-Path: <stable+bounces-36102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62924899B63
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1592832E2
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0731D16C444;
	Fri,  5 Apr 2024 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r8UENpX8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A016C442
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314396; cv=none; b=bDL0BKNWZofsvG1u2Unl7G/owvVzvvoyrEbazF/CZ+ifMznfAQG48LblCiOnsZM6jQ9HawvHoukbyu+SfisHkZ7KDl+7HzVkNcItRLg1EgvBTNiAxPAnHQfv8LzpwM1fxSKdgCeIv4xc8pzcRep5YTrZqIxZ2ToCVoeCwqP8FJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314396; c=relaxed/simple;
	bh=xE38+IcEDs9aJUpTuh5Eu8qZZcpS3ojVBvXUuDvUzhg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q/ctH9dd9JNLORzeSyl5fgMClKUOcYtC/2cQfNN8N+pl7x+LsL0pS/YLgFTXq/27drsKloAPwTJ/ros1NG/8JWh01xK1JANJng3bzDhBV2/7conKOKfea7pW7u63MMVRZYu3NBBIogDu+G7OtCipVJngpWA5QslAo1IHk/J8me0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r8UENpX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7663C433F1;
	Fri,  5 Apr 2024 10:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712314396;
	bh=xE38+IcEDs9aJUpTuh5Eu8qZZcpS3ojVBvXUuDvUzhg=;
	h=Subject:To:Cc:From:Date:From;
	b=r8UENpX8FOKzHTPtOe7CANTXyV0UYJ0am9vAyNcf/88KPRsopGyVsQ/2iDvsx7UK/
	 1VgAc8FQ0Kn2jF1+F67wQMpVksm+8bjrqEZSjMwD0lc/59it5peAhs2qmFQLCFUl27
	 mfBGqmnK7u9VHkX64hovbstVlr9O2HD9EHnYWM0c=
Subject: FAILED: patch "[PATCH] ax25: fix use-after-free bugs caused by ax25_ds_del_timer" failed to apply to 5.10-stable tree
To: duoming@zju.edu.cn,horms@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 12:53:10 +0200
Message-ID: <2024040509-monetize-joyride-107c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x fd819ad3ecf6f3c232a06b27423ce9ed8c20da89
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040509-monetize-joyride-107c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd819ad3ecf6f3c232a06b27423ce9ed8c20da89 Mon Sep 17 00:00:00 2001
From: Duoming Zhou <duoming@zju.edu.cn>
Date: Fri, 29 Mar 2024 09:50:23 +0800
Subject: [PATCH] ax25: fix use-after-free bugs caused by ax25_ds_del_timer

When the ax25 device is detaching, the ax25_dev_device_down()
calls ax25_ds_del_timer() to cleanup the slave_timer. When
the timer handler is running, the ax25_ds_del_timer() that
calls del_timer() in it will return directly. As a result,
the use-after-free bugs could happen, one of the scenarios
is shown below:

      (Thread 1)          |      (Thread 2)
                          | ax25_ds_timeout()
ax25_dev_device_down()    |
  ax25_ds_del_timer()     |
    del_timer()           |
  ax25_dev_put() //FREE   |
                          |  ax25_dev-> //USE

In order to mitigate bugs, when the device is detaching, use
timer_shutdown_sync() to stop the timer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240329015023.9223-1-duoming@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index c5462486dbca..282ec581c072 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -105,7 +105,7 @@ void ax25_dev_device_down(struct net_device *dev)
 	spin_lock_bh(&ax25_dev_lock);
 
 #ifdef CONFIG_AX25_DAMA_SLAVE
-	ax25_ds_del_timer(ax25_dev);
+	timer_shutdown_sync(&ax25_dev->dama.slave_timer);
 #endif
 
 	/*


