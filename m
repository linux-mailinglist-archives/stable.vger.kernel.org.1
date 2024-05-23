Return-Path: <stable+bounces-45700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C9C8CD370
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63250B21E7D
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B1414AD35;
	Thu, 23 May 2024 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VvAFqDKB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5D14AD2B;
	Thu, 23 May 2024 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470111; cv=none; b=lLhl9UQis2hqOtZcrR9z4oH7iIDJEuI8pkwMTyC57OfH/3GEgD+LkiabLVLYYoL1VnSzILg7A9aw3GjO5lYxgqeNGhiVk0rSirK3uEkGPu2MwSYrV/eiPq2fEOiRjzCE5P6sZ9DWkSOPWFtoTHoVLjWyA0Jb0Kabql9RyTxl/Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470111; c=relaxed/simple;
	bh=aNu9ICKEqsolNjac6jaz/z2uLONnZ3p0iABNwboRge8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8ewC6Amn8vEuYLXI2wG/NYeerXC2OgAo2KX8teoZs1FNaO37THZQv/bUpE22O0LJcIOjoD8Tml0DtdHGyZMs1tLDDali7jclvkt+fJl7ViErdRmbbKTL6oTa32vIzuy4iVSNcV6PgT6snZby8sC1AwmtllExzed0q1yLMQnC98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VvAFqDKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE2EC32782;
	Thu, 23 May 2024 13:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470110;
	bh=aNu9ICKEqsolNjac6jaz/z2uLONnZ3p0iABNwboRge8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VvAFqDKBK3LkVVQ7K3xzo2uSjnsg67UONGSaZ9pSiEjQmk+QSFRiQkzhtWXodpQJ6
	 CcwyMxLxdQcv9c6AJwboxO5bjewop+w9AvV15z+SKF4HKsml7iN6oGIptxDPB9SI+C
	 yq0ym4gAy3pqPX/WykXvWS1CH+L6q+WYQST9TAb4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liuye <liu.yeC@h3c.com>,
	Douglas Anderson <dianders@chromium.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 4.19 17/18] serial: kgdboc: Fix NMI-safety problems from keyboard reset code
Date: Thu, 23 May 2024 15:12:40 +0200
Message-ID: <20240523130326.392944420@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130325.727602650@linuxfoundation.org>
References: <20240523130325.727602650@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -16,6 +16,7 @@
 #include <linux/console.h>
 #include <linux/vt_kern.h>
 #include <linux/input.h>
+#include <linux/irq_work.h>
 #include <linux/module.h>
 
 #define MAX_CONFIG_LEN		40
@@ -35,6 +36,25 @@ static int kgdboc_use_kms;  /* 1 if we u
 static struct tty_driver	*kgdb_tty_driver;
 static int			kgdb_tty_line;
 
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
@@ -86,10 +106,17 @@ static void kgdboc_restore_input_helper(
 
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
@@ -120,6 +147,7 @@ static void kgdboc_unregister_kbd(void)
 			i--;
 		}
 	}
+	irq_work_sync(&kgdboc_restore_input_irq_work);
 	flush_work(&kgdboc_restore_input_work);
 }
 #else /* ! CONFIG_KDB_KEYBOARD */



