Return-Path: <stable+bounces-110075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1968EA187CF
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 23:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0878D3A4095
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 22:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A61F8AD4;
	Tue, 21 Jan 2025 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Xfh1/+gJ"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D788B187FE4;
	Tue, 21 Jan 2025 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737499296; cv=none; b=NtlKKg4p77S+4o/lskiY1QByjSBwkDYAdvm18v5mgMcnhbOvvygqZ4L6xiLPUmiWUZ8nEklTzrLVLVy/bnwAbwrb9rewx0XUcG6JiE2sNC6aDQiB/Ao2EGOcwZF3DEERxj7g0bt14ZotZfP5tEu5Xy7c1zjcAT8ko3S/7O0S9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737499296; c=relaxed/simple;
	bh=GLuR3iyLCe0QvSfmbDZcQKKhX1oOjMzCLBDTwWWtOcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pq944TWpz2FX1AyR9P2Mpwsk2iI0Afvp/SAYUOA6g+ss2+HOyjn+xLMS9xA9fa1PBfCQasOljsXCx7JMS1JEMBPwbryRuKFID/H/3X/IwCZI72qhsf8lyXqWhD5CMkiFKRXHTyZxO+LB5Qf12nzUjjSed9pDI96VXKwsZh8RM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Xfh1/+gJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737499291;
	bh=GLuR3iyLCe0QvSfmbDZcQKKhX1oOjMzCLBDTwWWtOcA=;
	h=From:Date:Subject:To:Cc:From;
	b=Xfh1/+gJp69fCcEt4D1uqAcZRBPVJ5iiZpNHxJzdtPjGGF6gsDRd2IXKLpdWtYBpb
	 x8BW9YmeNlVPkVPzn74/NX7bRp4lERa7T9RXn0HtiUMvWXG1/tCFU0Qsdrf8t+xumx
	 DgbKIyzoUbc5tU+wso3bCGKx0t8zoHBTjqDb1qvg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 21 Jan 2025 23:41:24 +0100
Subject: [PATCH] posix-clock: Explicitly handle compat ioctls
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJMikGcC/x3MywqEMAxA0V+RrCfQ+gL9FRmkZqIGHymtiCD+u
 2WWZ3HvDZGDcIQ2uyHwKVF0T7CfDGh2+8Qov2TITV4Zawr0GuVCWpUWJN28O3pROlZs6nFwVJW
 NLWtIuQ88yvVfd9/neQFDRAHlagAAAA==
X-Change-ID: 20250103-posix-clock-compat_ioctl-96fbac549146
To: Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Cyrill Gorcunov <gorcunov@gmail.com>, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737499290; l=4605;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GLuR3iyLCe0QvSfmbDZcQKKhX1oOjMzCLBDTwWWtOcA=;
 b=+kJt32CCzU0y4gID7601FKEg23cAx9xVrBMbPcTKEYy5GQwd6LgSXa/oAUIpf3rgsEKlZuzAz
 CQ5XnQeDO2YDCM/NnevupuHa6rwPz5Kok0QPMb2CKfIz4qrq1Ol0I6/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Pointer arguments passed to ioctls need to pass through compat_ptr() to
work correctly on s390; as explained in Documentation/driver-api/ioctl.rst.
Plumb the compat_ioctl callback through 'struct posix_clock_operations'
and handle the different ioctls cmds in the new ptp_compat_ioctl().

Using compat_ptr_ioctl is not possible.
For the commands PTP_ENABLE_PPS/PTP_ENABLE_PPS2 on s390
it would corrupt the argument 0x80000000, aka BIT(31) to zero.

Fixes: 0606f422b453 ("posix clocks: Introduce dynamic clocks")
Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp clocks.")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/ptp/ptp_chardev.c   | 18 ++++++++++++++++++
 drivers/ptp/ptp_clock.c     |  1 +
 drivers/ptp/ptp_private.h   |  7 +++++++
 include/linux/posix-clock.h |  3 +++
 kernel/time/posix-clock.c   |  4 ++--
 5 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index ea96a14d72d141a4b255563b66bac8ed568b45e9..704af620c1173c12ee26b3b6c7982693e3c4c21f 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  */
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/posix-clock.h>
 #include <linux/poll.h>
@@ -507,6 +508,23 @@ long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+long ptp_compat_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
+		      unsigned long arg)
+{
+	switch (cmd) {
+	case PTP_ENABLE_PPS:
+	case PTP_ENABLE_PPS2:
+		/* These take in scalar arg, do not convert */
+		break;
+	default:
+		arg = (unsigned long)compat_ptr(arg);
+	}
+
+	return ptp_ioctl(pccontext, cmd, arg);
+}
+#endif
+
 __poll_t ptp_poll(struct posix_clock_context *pccontext, struct file *fp,
 		  poll_table *wait)
 {
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index 77a36e7bddd54e8f45eab317e687f033f57cc5bc..dec84b81cedfd13bcf8c97be6c3c27d73cd671f6 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -180,6 +180,7 @@ static struct posix_clock_operations ptp_clock_ops = {
 	.clock_getres	= ptp_clock_getres,
 	.clock_settime	= ptp_clock_settime,
 	.ioctl		= ptp_ioctl,
+	.compat_ioctl	= ptp_compat_ioctl,
 	.open		= ptp_open,
 	.release	= ptp_release,
 	.poll		= ptp_poll,
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 18934e28469ee6e3bf9c9e6d1a1adb82808d88e6..13999a7af47a7b67ae8dc549351fbafef2ae402f 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -133,6 +133,13 @@ int ptp_set_pinfunc(struct ptp_clock *ptp, unsigned int pin,
 long ptp_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
 	       unsigned long arg);
 
+#ifdef CONFIG_COMPAT
+long ptp_compat_ioctl(struct posix_clock_context *pccontext, unsigned int cmd,
+		      unsigned long arg);
+#else
+#define ptp_compat_ioctl NULL
+#endif
+
 int ptp_open(struct posix_clock_context *pccontext, fmode_t fmode);
 
 int ptp_release(struct posix_clock_context *pccontext);
diff --git a/include/linux/posix-clock.h b/include/linux/posix-clock.h
index ef8619f489203eeb369ae580fc4d4b2439c94ae9..8bdc7aec5f7979c42752a233077620818d15acdd 100644
--- a/include/linux/posix-clock.h
+++ b/include/linux/posix-clock.h
@@ -54,6 +54,9 @@ struct posix_clock_operations {
 	long (*ioctl)(struct posix_clock_context *pccontext, unsigned int cmd,
 		      unsigned long arg);
 
+	long (*compat_ioctl)(struct posix_clock_context *pccontext, unsigned int cmd,
+			     unsigned long arg);
+
 	int (*open)(struct posix_clock_context *pccontext, fmode_t f_mode);
 
 	__poll_t (*poll)(struct posix_clock_context *pccontext, struct file *file,
diff --git a/kernel/time/posix-clock.c b/kernel/time/posix-clock.c
index 1af0bb2cc45c0aab843f77eb156992de469c8fb9..63184d92ef139c3fb9254745619ebca120fecce6 100644
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -101,8 +101,8 @@ static long posix_clock_compat_ioctl(struct file *fp,
 	if (!clk)
 		return -ENODEV;
 
-	if (clk->ops.ioctl)
-		err = clk->ops.ioctl(pccontext, cmd, arg);
+	if (clk->ops.compat_ioctl)
+		err = clk->ops.compat_ioctl(pccontext, cmd, arg);
 
 	put_posix_clock(clk);
 

---
base-commit: 0bc21e701a6ffacfdde7f04f87d664d82e8a13bf
change-id: 20250103-posix-clock-compat_ioctl-96fbac549146

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


