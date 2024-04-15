Return-Path: <stable+bounces-39429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D110D8A4F34
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D962283CF8
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57A36BB44;
	Mon, 15 Apr 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ibKa0N57"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631255CDD9
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184679; cv=none; b=SPFfSHn4Q3vZMyM/SJ0Lbwd0+SpDjbggxK/73jQddr8GpZhC+qu374YIY/0Sa17RI+B2UU7tO2cnvwreeVcYOpY/bN2F4g2sVzvr0C9lGnricmIJmMA9JTQfzek5hWV81QT1cJLBMOmo1oC9VLa2pveZEXgKFB8VxyTRfIUiPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184679; c=relaxed/simple;
	bh=BPqdPa7lm/dHSQ0poYEn08l4eu6bquS+Alp4YsE3tsM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M3QYje+wE7PkuppVjdP5gqHbnJY7a3482xvfYkaq6uLj/OhQi8DE34BPq/5l0UbxBojED1oUTneGuncWBG0QCPp5bQ11q75+vCvwiauWwU7VIV8OI+ssrYn1pC0ow081ptcQccNz88eYwOvd/DIseFmwSZQklPkxLoxHYbC6MVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ibKa0N57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1E0C113CC;
	Mon, 15 Apr 2024 12:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713184678;
	bh=BPqdPa7lm/dHSQ0poYEn08l4eu6bquS+Alp4YsE3tsM=;
	h=Subject:To:Cc:From:Date:From;
	b=ibKa0N5752xVcjjakMQ7lQlHbmTq2f26XPh6gCsDIzp9+53Em/Lwv5lB4Bo6bGwmV
	 +7HxLruO+Sp5Bv9J6Ve0/otIR9v2n0oB1Rd52fksH1/MPyUlac8KsAjV8o/LFBQBfl
	 FnioNDNpr5BwzTIHhhh6lf5mzidp6lsuYZiM0nCg=
Subject: FAILED: patch "[PATCH] accel/ivpu: Check return code of ipc->lock init" failed to apply to 6.6-stable tree
To: karol.wachowski@intel.com,jacek.lawrynowicz@linux.intel.com,quic_jhugo@quicinc.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Apr 2024 14:37:55 +0200
Message-ID: <2024041555-provable-follicle-38d5@gregkh>
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
git cherry-pick -x f0cf7ffcd02953c72fed5995378805883d16203e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041555-provable-follicle-38d5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f0cf7ffcd02953c72fed5995378805883d16203e Mon Sep 17 00:00:00 2001
From: "Wachowski, Karol" <karol.wachowski@intel.com>
Date: Tue, 2 Apr 2024 12:49:22 +0200
Subject: [PATCH] accel/ivpu: Check return code of ipc->lock init

Return value of drmm_mutex_init(ipc->lock) was unchecked.

Fixes: 5d7422cfb498 ("accel/ivpu: Add IPC driver and JSM messages")
Cc: <stable@vger.kernel.org> # v6.3+
Signed-off-by: Wachowski, Karol <karol.wachowski@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240402104929.941186-2-jacek.lawrynowicz@linux.intel.com

diff --git a/drivers/accel/ivpu/ivpu_ipc.c b/drivers/accel/ivpu/ivpu_ipc.c
index 04ac4b9840fb..56ff067f63e2 100644
--- a/drivers/accel/ivpu/ivpu_ipc.c
+++ b/drivers/accel/ivpu/ivpu_ipc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020-2023 Intel Corporation
+ * Copyright (C) 2020-2024 Intel Corporation
  */
 
 #include <linux/genalloc.h>
@@ -501,7 +501,11 @@ int ivpu_ipc_init(struct ivpu_device *vdev)
 	spin_lock_init(&ipc->cons_lock);
 	INIT_LIST_HEAD(&ipc->cons_list);
 	INIT_LIST_HEAD(&ipc->cb_msg_list);
-	drmm_mutex_init(&vdev->drm, &ipc->lock);
+	ret = drmm_mutex_init(&vdev->drm, &ipc->lock);
+	if (ret) {
+		ivpu_err(vdev, "Failed to initialize ipc->lock, ret %d\n", ret);
+		goto err_free_rx;
+	}
 	ivpu_ipc_reset(vdev);
 	return 0;
 


