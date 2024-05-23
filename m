Return-Path: <stable+bounces-45828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F26C68CD416
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68BAE1F26B21
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB4E14B095;
	Thu, 23 May 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pUWRIp6P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6913BAC3;
	Thu, 23 May 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470478; cv=none; b=B9FP19dJynJVpBK4NW7sRa0r67ZT7WIjOZa0MgC3XKkOGu7oI/G8rbfMtcP0npjFpcrWBcHWfJVhl9Sewg5IzHpmbeqFGjKksOTaPFryQ7LXBOpeQxrWRtBGO/Uujx8GKBvqu+pWTF23+6VfLfobQcipCoeVxkgdoYyRQIHt8TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470478; c=relaxed/simple;
	bh=3PBH3Te2H4UweF2+97kwFtyMDBrq8ovwPMaBqEeqyMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjciG7nD9gr3OuYyKveyVAjNqQN0ONw/ldudATD2VBFVuh34vpgnnRjgSI2p8lQoOKMDhLied6GvAlrGf/TbR/l4WbUhtWZMxwgkLXPa8V2pEhx3LBXpWFUYrIEd764hd6c5ipz0kCda/vap5/39HH/+BxN6QgMtknvxqDYHc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pUWRIp6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D29C3277B;
	Thu, 23 May 2024 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470478;
	bh=3PBH3Te2H4UweF2+97kwFtyMDBrq8ovwPMaBqEeqyMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pUWRIp6PG/uBSbPhEHTnDU7JGCASumbtnM+qc0ZTey5SwAgXjfQOxVvgAXHL+Go8N
	 oNhAl7t7VhyTvHdbTRoc7PKl7ZDfS6TpQHTcisAeShEBwtb2iNp/Yg8iT4mQ1xSoXz
	 Qqw8D5n5BDP5viVGRGnrkL4hprhLUTL0uSSiyd10=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liuye <liu.yeC@h3c.com>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 6.1 41/45] serial: kgdboc: Fix NMI-safety problems from keyboard reset code
Date: Thu, 23 May 2024 15:13:32 +0200
Message-ID: <20240523130334.037747688@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130332.496202557@linuxfoundation.org>
References: <20240523130332.496202557@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Thompson <daniel.thompson@linaro.org>

commit b2aba15ad6f908d1a620fd97f6af5620c3639742 upstream.

Currently, when kdb is compiled with keyboard support, then we will use
schedule_work() to provoke reset of the keyboard status.  Unfortunately
schedule_work() gets called from the kgdboc post-debug-exception
handler.  That risks deadlock since schedule_work() is not NMI-safe and,
even on platforms where the NMI is not directly used for debugging, the
debug trap can have NMI-like behaviour depending on where breakpoints
are placed.

Fix this by using the irq work system, which is NMI-safe, to defer the
call to schedule_work() to a point when it is safe to call.

Reported-by: Liuye <liu.yeC@h3c.com>
Closes: https://lore.kernel.org/all/20240228025602.3087748-1-liu.yeC@h3c.com/
Cc: stable@vger.kernel.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20240424-kgdboc_fix_schedule_work-v2-1-50f5a490aec5@linaro.org
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/kgdboc.c |   30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -19,6 +19,7 @@
 #include <linux/console.h>
 #include <linux/vt_kern.h>
 #include <linux/input.h>
+#include <linux/irq_work.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/serial_core.h>
@@ -48,6 +49,25 @@ static struct kgdb_io		kgdboc_earlycon_i
 static int                      (*earlycon_orig_exit)(struct console *con);
 #endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
 
+/*
+ * When we leave the debug trap handler we need to reset the keyboard status
+ * (since the original keyboard state gets partially clobbered by kdb use of
+ * the keyboard).
+ *
+ * The path to deliver the reset is somewhat circuitous.
+ *
+ * To deliver the reset we register an input handler, reset the keyboard and
+ * then deregister the input handler. However, to get this done right, we do
+ * have to carefully manage the calling context because we can only register
+ * input handlers from task context.
+ *
+ * In particular we need to trigger the action from the debug trap handler with
+ * all its NMI and/or NMI-like oddities. To solve this the kgdboc trap exit code
+ * (the "post_exception" callback) uses irq_work_queue(), which is NMI-safe, to
+ * schedule a callback from a hardirq context. From there we have to defer the
+ * work again, this time using schedule_work(), to get a callback using the
+ * system workqueue, which runs in task context.
+ */
 #ifdef CONFIG_KDB_KEYBOARD
 static int kgdboc_reset_connect(struct input_handler *handler,
 				struct input_dev *dev,
@@ -99,10 +119,17 @@ static void kgdboc_restore_input_helper(
 
 static DECLARE_WORK(kgdboc_restore_input_work, kgdboc_restore_input_helper);
 
+static void kgdboc_queue_restore_input_helper(struct irq_work *unused)
+{
+	schedule_work(&kgdboc_restore_input_work);
+}
+
+static DEFINE_IRQ_WORK(kgdboc_restore_input_irq_work, kgdboc_queue_restore_input_helper);
+
 static void kgdboc_restore_input(void)
 {
 	if (likely(system_state == SYSTEM_RUNNING))
-		schedule_work(&kgdboc_restore_input_work);
+		irq_work_queue(&kgdboc_restore_input_irq_work);
 }
 
 static int kgdboc_register_kbd(char **cptr)
@@ -133,6 +160,7 @@ static void kgdboc_unregister_kbd(void)
 			i--;
 		}
 	}
+	irq_work_sync(&kgdboc_restore_input_irq_work);
 	flush_work(&kgdboc_restore_input_work);
 }
 #else /* ! CONFIG_KDB_KEYBOARD */



