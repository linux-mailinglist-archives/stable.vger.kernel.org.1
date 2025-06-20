Return-Path: <stable+bounces-154949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6F1AE1511
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05147AD1E2
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C67202978;
	Fri, 20 Jun 2025 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eTEKTGGo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6289917583
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405057; cv=none; b=WErCYhhDqBGeaPDp2kGjcBBXGoSf0xKhc8YqKEas9029B/2WCXes86/cfN5Rfk0Rvauap8wyGiXrSKFN6xc+nCpTOnEyxKz8Jv1W+/tI+X42wOKrHxIRTxmMzfas/COYCmmHSDsfME4zVhzJdcA2b4TndmeceWy7v/8nszkuBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405057; c=relaxed/simple;
	bh=gsZJgVVh8FnSVRFKN4sk+uBhworbQlZirOV0I9k5fo8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gVNztg6DYy2BExZeKsR6CXimSvRCskrLM/n6QJHgioOkapBClxsrRX0nT/3N1qKgVYmyJMPbM1um1PzuXIXU0n408oF39Qbp+BmJ3/VmMUFJFOXgSOHxViBMDmt5WoSpRG5Kw9pyEt9DkrKYUuN0TnCalGxadtN2ykDb1VUQu6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eTEKTGGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A61C4CEE3;
	Fri, 20 Jun 2025 07:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750405056;
	bh=gsZJgVVh8FnSVRFKN4sk+uBhworbQlZirOV0I9k5fo8=;
	h=Subject:To:Cc:From:Date:From;
	b=eTEKTGGotN8xWyAEM88eZd+/3Gd2zF4sXBjYS/8qObLVGWE8NPZRMyW9PuKLh6bO+
	 WwpG8x6MQ+NLNmpced8jj3BkmxmFOBz3IwnMt/RkdH2b+huC3b+4NJR+ZqUhYcpAZ3
	 IRwIVOyh+BnlUOUI3cX8nPgBlj0X8kYpM9FbHPqo=
Subject: FAILED: patch "[PATCH] media: davinci: vpif: Fix memory leak in probe error path" failed to apply to 5.15-stable tree
To: Dm1tryNk@yandex.ru,hverkuil@xs4all.nl,johan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 09:37:33 +0200
Message-ID: <2025062033-navigator-observant-8f41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 024bf40edf1155e7a587f0ec46294049777d9b02
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062033-navigator-observant-8f41@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 024bf40edf1155e7a587f0ec46294049777d9b02 Mon Sep 17 00:00:00 2001
From: Dmitry Nikiforov <Dm1tryNk@yandex.ru>
Date: Wed, 16 Apr 2025 23:51:19 +0300
Subject: [PATCH] media: davinci: vpif: Fix memory leak in probe error path

If an error occurs during the initialization of `pdev_display`,
the allocated platform device `pdev_capture` is not released properly,
leading to a memory leak.

Adjust error path handling to fix the leak.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 43acb728bbc4 ("media: davinci: vpif: fix use-after-free on driver unbind")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Nikiforov <Dm1tryNk@yandex.ru>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/platform/ti/davinci/vpif.c b/drivers/media/platform/ti/davinci/vpif.c
index a81719702a22..969d623fc842 100644
--- a/drivers/media/platform/ti/davinci/vpif.c
+++ b/drivers/media/platform/ti/davinci/vpif.c
@@ -504,7 +504,7 @@ static int vpif_probe(struct platform_device *pdev)
 	pdev_display = kzalloc(sizeof(*pdev_display), GFP_KERNEL);
 	if (!pdev_display) {
 		ret = -ENOMEM;
-		goto err_put_pdev_capture;
+		goto err_del_pdev_capture;
 	}
 
 	pdev_display->name = "vpif_display";
@@ -527,6 +527,8 @@ static int vpif_probe(struct platform_device *pdev)
 
 err_put_pdev_display:
 	platform_device_put(pdev_display);
+err_del_pdev_capture:
+	platform_device_del(pdev_capture);
 err_put_pdev_capture:
 	platform_device_put(pdev_capture);
 err_put_rpm:


