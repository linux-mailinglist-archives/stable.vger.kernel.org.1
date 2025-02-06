Return-Path: <stable+bounces-114026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F209A29F2B
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 04:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 786557A265A
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 03:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D343FB0E;
	Thu,  6 Feb 2025 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="KrXrE7QW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01A4C8F
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738811147; cv=none; b=fNXd16L8s/ICBA253U7dRxJmjjW1/RyKYs6PnME+toZ+NAy4MSVR+GsIZq5yeooOXsFLIbD11nWNCk9jZA9OQaF0ARw7GylNdt25OdlgBatq5PYp9u79661RZNbtxISMIER8JhNE7Lq5Z1uShYsjhU7yvb+NXtaGXX2IPQGd8Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738811147; c=relaxed/simple;
	bh=54yoTXIy+BgN4RRhfycSnTE4g25MRL44lDayWTyxGGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wlq56ejF8HRCP27e8s6uOdblYyCBTeLhQjr98F4RAacvS4HVNn5mOhDTAFpYmBqPMQdijGQf/fk/LnbY2/3VsdvPkL7cdXiNCixC15mSD9m8fox5DOlGEDG6EvSrzj8SREJx340hhiqgV0BwqcF5j/53h+hRv0MX2HCJXngf/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=KrXrE7QW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216728b1836so8338835ad.0
        for <stable@vger.kernel.org>; Wed, 05 Feb 2025 19:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1738811144; x=1739415944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auAy9KZcrTW6kYAlbBemAOJmVzvvwh7fjCFeNie6u0s=;
        b=KrXrE7QWKR4kt2RmpFwlIZSap4nGsb6iWivAFV3aNCMel2DW3IvSPRA3BAFLB+gWPP
         /IhgG6xoZUA3sbA/aHJ8nw+QVKWEjeSvTXQ3RyiIp7znS4aYuSmDXYkkb83ixc9fmxxK
         dFomsKcR43D6du2yhuBWFvvg+452l2f34aIpHEwEgBYhhzB29nEKJCo3N1XQHnCOmjsD
         5J5HcZ2FD5l9jI+nAX1ASpemY2JKsI/A201+5xyG3GM0AQCEc84jp1fS4l9utHJQxMIm
         0VrRMXzMum4Z1BvAMxyJIjEVJ7KaOiRLDxJps+rbpmPjz8G99wBmEjiHnZe8mlSMdx69
         9Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738811144; x=1739415944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=auAy9KZcrTW6kYAlbBemAOJmVzvvwh7fjCFeNie6u0s=;
        b=HLhbZd143YWwsbHKYv6IojCxUaca+UP37tbUro03Z4JvLm6HI53fMY2mVCrOb9LoZ9
         fwbojsICj3+MF6h8QYmXqqBqTJS6zHrfGzPlMxcrptd8n4djMBFypqHnC/clGu6HdT8E
         vzIQkSAzj8bKhOQe1t5rJUCGCqKGc2ZE0cLgJWA+/zAAKagUN0CQoDK1zEYqHau0Gh8g
         bZL18WC5Ajs2VcNYj2DEGPGJNXPM73rt/oT0QxK8QgaXj4/Vupu4TmvBojGou+uuwur2
         VYfYNvBkNXl3vCBr5lDEXS90nkKohIVsXW4D1+Mlk/bnEInD7MaWT1oINKcsnz0r4O72
         3Qrw==
X-Gm-Message-State: AOJu0YxBylmMT5VvJNehlT519WPeXPMvpCEiQvjmyvRGTBVcvwgHQDtQ
	lnfdUaguLTZF1kGo3EgLUeBxkzYJJYz/rwBeN9UBkG6pfWBT7HCU4zdGO60Ygk1/3OS9NMf7uQO
	A
X-Gm-Gg: ASbGnctCqxpgdMRq43or+u+CYvmOK4hQGHvO12mm2qxl+9rkuCHARCkFTTaulb2hh0s
	sztazt7Sns9uamJoo3+WAv2jDjTARYBDjcmtCfe04oAQRIF8Mwd6ULaSi3foW6RpEqIg8cr9Stj
	o3M07tnPAzeN7hI5w+6uGdVTB5q02eCkGwF2gHz5Z+7WSIq8Xl111mcis48uP1H4id7O7BGDz6e
	Q/rUQkT31effSs3hr3RkOO53A5Vy7X3S57hKrp1Qc1wnmJmTu/yZeh8KX36xE6R9Dy7PQD2Mx8R
	u00FIeubUGmXqoWw3NzwNlBB+cQ6cRMNiGnnOVXeVVgCPhBXJUjh0mBvppWI
X-Google-Smtp-Source: AGHT+IGevahvTJrVw7wMYfmVZ/ShvU5viGeBfmbqcRgFCgHKxlSnTLKGy+BJZOukO2wU/kF7Ox9/5g==
X-Received: by 2002:a05:6a00:1411:b0:72a:bc54:be9e with SMTP id d2e1a72fcca58-730351ec0c5mr7436530b3a.15.1738811144418;
        Wed, 05 Feb 2025 19:05:44 -0800 (PST)
Received: from mozart.vkv.me (192-184-160-101.fiber.dynamic.sonic.net. [192.184.160.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7fdfsm200254b3a.83.2025.02.05.19.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 19:05:43 -0800 (PST)
From: Calvin Owens <calvin@wbinvd.org>
To: stable@vger.kernel.org
Cc: mschmidt@redhat.com,
	calvin@wbinvd.org
Subject: [PATCH 5.4.y] pps: Fix a use-after-free
Date: Wed,  5 Feb 2025 19:05:37 -0800
Message-ID: <c79f096dfae9f9f5167eb249066bd09de46f4b19.1738811137.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025020424-bloated-undecided-1814@gregkh>
References: <2025020424-bloated-undecided-1814@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a board running ntpd and gpsd, I'm seeing a consistent use-after-free
in sys_exit() from gpsd when rebooting:

    pps pps1: removed
    ------------[ cut here ]------------
    kobject: '(null)' (00000000db4bec24): is not initialized, yet kobject_put() is being called.
    WARNING: CPU: 2 PID: 440 at lib/kobject.c:734 kobject_put+0x120/0x150
    CPU: 2 UID: 299 PID: 440 Comm: gpsd Not tainted 6.11.0-rc6-00308-gb31c44928842 #1
    Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
    pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : kobject_put+0x120/0x150
    lr : kobject_put+0x120/0x150
    sp : ffffffc0803d3ae0
    x29: ffffffc0803d3ae0 x28: ffffff8042dc9738 x27: 0000000000000001
    x26: 0000000000000000 x25: ffffff8042dc9040 x24: ffffff8042dc9440
    x23: ffffff80402a4620 x22: ffffff8042ef4bd0 x21: ffffff80405cb600
    x20: 000000000008001b x19: ffffff8040b3b6e0 x18: 0000000000000000
    x17: 0000000000000000 x16: 0000000000000000 x15: 696e6920746f6e20
    x14: 7369203a29343263 x13: 205d303434542020 x12: 0000000000000000
    x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
    x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
    x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
    x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
    Call trace:
     kobject_put+0x120/0x150
     cdev_put+0x20/0x3c
     __fput+0x2c4/0x2d8
     ____fput+0x1c/0x38
     task_work_run+0x70/0xfc
     do_exit+0x2a0/0x924
     do_group_exit+0x34/0x90
     get_signal+0x7fc/0x8c0
     do_signal+0x128/0x13b4
     do_notify_resume+0xdc/0x160
     el0_svc+0xd4/0xf8
     el0t_64_sync_handler+0x140/0x14c
     el0t_64_sync+0x190/0x194
    ---[ end trace 0000000000000000 ]---

...followed by more symptoms of corruption, with similar stacks:

    refcount_t: underflow; use-after-free.
    kernel BUG at lib/list_debug.c:62!
    Kernel panic - not syncing: Oops - BUG: Fatal exception

This happens because pps_device_destruct() frees the pps_device with the
embedded cdev immediately after calling cdev_del(), but, as the comment
above cdev_del() notes, fops for previously opened cdevs are still
callable even after cdev_del() returns. I think this bug has always
been there: I can't explain why it suddenly started happening every time
I reboot this particular board.

In commit d953e0e837e6 ("pps: Fix a use-after free bug when
unregistering a source."), George Spelvin suggested removing the
embedded cdev. That seems like the simplest way to fix this, so I've
implemented his suggestion, using __register_chrdev() with pps_idr
becoming the source of truth for which minor corresponds to which
device.

But now that pps_idr defines userspace visibility instead of cdev_add(),
we need to be sure the pps->dev refcount can't reach zero while
userspace can still find it again. So, the idr_remove() call moves to
pps_unregister_cdev(), and pps_idr now holds a reference to pps->dev.

    pps_core: source serial1 got cdev (251:1)
    <...>
    pps pps1: removed
    pps_core: unregistering pps1
    pps_core: deallocating pps1

Fixes: d953e0e837e6 ("pps: Fix a use-after free bug when unregistering a source.")
Cc: stable@vger.kernel.org
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Link: https://lore.kernel.org/r/a17975fd5ae99385791929e563f72564edbcf28f.1731383727.git.calvin@wbinvd.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit c79a39dc8d060b9e64e8b0fa9d245d44befeefbe)
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/pps/clients/pps-gpio.c    |   4 +-
 drivers/pps/clients/pps-ktimer.c  |   4 +-
 drivers/pps/clients/pps-ldisc.c   |   6 +-
 drivers/pps/clients/pps_parport.c |   4 +-
 drivers/pps/kapi.c                |  10 +--
 drivers/pps/kc.c                  |  10 +--
 drivers/pps/pps.c                 | 127 ++++++++++++++++--------------
 include/linux/pps_kernel.h        |   3 +-
 8 files changed, 86 insertions(+), 82 deletions(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index e0de1df2ede0..541b03706808 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -232,8 +232,8 @@ static int pps_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	dev_info(data->pps->dev, "Registered IRQ %d as PPS source\n",
-		 data->irq);
+	dev_dbg(&data->pps->dev, "Registered IRQ %d as PPS source\n",
+		data->irq);
 
 	return 0;
 }
diff --git a/drivers/pps/clients/pps-ktimer.c b/drivers/pps/clients/pps-ktimer.c
index d33106bd7a29..2f465549b843 100644
--- a/drivers/pps/clients/pps-ktimer.c
+++ b/drivers/pps/clients/pps-ktimer.c
@@ -56,7 +56,7 @@ static struct pps_source_info pps_ktimer_info = {
 
 static void __exit pps_ktimer_exit(void)
 {
-	dev_info(pps->dev, "ktimer PPS source unregistered\n");
+	dev_dbg(&pps->dev, "ktimer PPS source unregistered\n");
 
 	del_timer_sync(&ktimer);
 	pps_unregister_source(pps);
@@ -74,7 +74,7 @@ static int __init pps_ktimer_init(void)
 	timer_setup(&ktimer, pps_ktimer_event, 0);
 	mod_timer(&ktimer, jiffies + HZ);
 
-	dev_info(pps->dev, "ktimer PPS source registered\n");
+	dev_dbg(&pps->dev, "ktimer PPS source registered\n");
 
 	return 0;
 }
diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index 4fd0cbf7f931..3a21177c0d1a 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -34,7 +34,7 @@ static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
 	pps_event(pps, &ts, status ? PPS_CAPTUREASSERT :
 			PPS_CAPTURECLEAR, NULL);
 
-	dev_dbg(pps->dev, "PPS %s at %lu\n",
+	dev_dbg(&pps->dev, "PPS %s at %lu\n",
 			status ? "assert" : "clear", jiffies);
 }
 
@@ -71,7 +71,7 @@ static int pps_tty_open(struct tty_struct *tty)
 		goto err_unregister;
 	}
 
-	dev_info(pps->dev, "source \"%s\" added\n", info.path);
+	dev_dbg(&pps->dev, "source \"%s\" added\n", info.path);
 
 	return 0;
 
@@ -91,7 +91,7 @@ static void pps_tty_close(struct tty_struct *tty)
 	if (WARN_ON(!pps))
 		return;
 
-	dev_info(pps->dev, "removed\n");
+	dev_info(&pps->dev, "removed\n");
 	pps_unregister_source(pps);
 }
 
diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index 84e49204912f..b2a991c10c74 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -83,7 +83,7 @@ static void parport_irq(void *handle)
 	/* check the signal (no signal means the pulse is lost this time) */
 	if (!signal_is_set(port)) {
 		local_irq_restore(flags);
-		dev_err(dev->pps->dev, "lost the signal\n");
+		dev_err(&dev->pps->dev, "lost the signal\n");
 		goto out_assert;
 	}
 
@@ -100,7 +100,7 @@ static void parport_irq(void *handle)
 	/* timeout */
 	dev->cw_err++;
 	if (dev->cw_err >= CLEAR_WAIT_MAX_ERRORS) {
-		dev_err(dev->pps->dev, "disabled clear edge capture after %d"
+		dev_err(&dev->pps->dev, "disabled clear edge capture after %d"
 				" timeouts\n", dev->cw_err);
 		dev->cw = 0;
 		dev->cw_err = 0;
diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index d9d566f70ed1..92d1b62ea239 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -41,7 +41,7 @@ static void pps_add_offset(struct pps_ktime *ts, struct pps_ktime *offset)
 static void pps_echo_client_default(struct pps_device *pps, int event,
 		void *data)
 {
-	dev_info(pps->dev, "echo %s %s\n",
+	dev_info(&pps->dev, "echo %s %s\n",
 		event & PPS_CAPTUREASSERT ? "assert" : "",
 		event & PPS_CAPTURECLEAR ? "clear" : "");
 }
@@ -112,7 +112,7 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
 		goto kfree_pps;
 	}
 
-	dev_info(pps->dev, "new PPS source %s\n", info->name);
+	dev_dbg(&pps->dev, "new PPS source %s\n", info->name);
 
 	return pps;
 
@@ -166,7 +166,7 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 	/* check event type */
 	BUG_ON((event & (PPS_CAPTUREASSERT | PPS_CAPTURECLEAR)) == 0);
 
-	dev_dbg(pps->dev, "PPS event at %lld.%09ld\n",
+	dev_dbg(&pps->dev, "PPS event at %lld.%09ld\n",
 			(s64)ts->ts_real.tv_sec, ts->ts_real.tv_nsec);
 
 	timespec_to_pps_ktime(&ts_real, ts->ts_real);
@@ -188,7 +188,7 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 		/* Save the time stamp */
 		pps->assert_tu = ts_real;
 		pps->assert_sequence++;
-		dev_dbg(pps->dev, "capture assert seq #%u\n",
+		dev_dbg(&pps->dev, "capture assert seq #%u\n",
 			pps->assert_sequence);
 
 		captured = ~0;
@@ -202,7 +202,7 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 		/* Save the time stamp */
 		pps->clear_tu = ts_real;
 		pps->clear_sequence++;
-		dev_dbg(pps->dev, "capture clear seq #%u\n",
+		dev_dbg(&pps->dev, "capture clear seq #%u\n",
 			pps->clear_sequence);
 
 		captured = ~0;
diff --git a/drivers/pps/kc.c b/drivers/pps/kc.c
index 50dc59af45be..fbd23295afd7 100644
--- a/drivers/pps/kc.c
+++ b/drivers/pps/kc.c
@@ -43,11 +43,11 @@ int pps_kc_bind(struct pps_device *pps, struct pps_bind_args *bind_args)
 			pps_kc_hardpps_mode = 0;
 			pps_kc_hardpps_dev = NULL;
 			spin_unlock_irq(&pps_kc_hardpps_lock);
-			dev_info(pps->dev, "unbound kernel"
+			dev_info(&pps->dev, "unbound kernel"
 					" consumer\n");
 		} else {
 			spin_unlock_irq(&pps_kc_hardpps_lock);
-			dev_err(pps->dev, "selected kernel consumer"
+			dev_err(&pps->dev, "selected kernel consumer"
 					" is not bound\n");
 			return -EINVAL;
 		}
@@ -57,11 +57,11 @@ int pps_kc_bind(struct pps_device *pps, struct pps_bind_args *bind_args)
 			pps_kc_hardpps_mode = bind_args->edge;
 			pps_kc_hardpps_dev = pps;
 			spin_unlock_irq(&pps_kc_hardpps_lock);
-			dev_info(pps->dev, "bound kernel consumer: "
+			dev_info(&pps->dev, "bound kernel consumer: "
 				"edge=0x%x\n", bind_args->edge);
 		} else {
 			spin_unlock_irq(&pps_kc_hardpps_lock);
-			dev_err(pps->dev, "another kernel consumer"
+			dev_err(&pps->dev, "another kernel consumer"
 					" is already bound\n");
 			return -EINVAL;
 		}
@@ -83,7 +83,7 @@ void pps_kc_remove(struct pps_device *pps)
 		pps_kc_hardpps_mode = 0;
 		pps_kc_hardpps_dev = NULL;
 		spin_unlock_irq(&pps_kc_hardpps_lock);
-		dev_info(pps->dev, "unbound kernel consumer"
+		dev_info(&pps->dev, "unbound kernel consumer"
 				" on device removal\n");
 	} else
 		spin_unlock_irq(&pps_kc_hardpps_lock);
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 22a65ad4e46e..2d008e0d116a 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -25,7 +25,7 @@
  * Local variables
  */
 
-static dev_t pps_devt;
+static int pps_major;
 static struct class *pps_class;
 
 static DEFINE_MUTEX(pps_idr_lock);
@@ -62,7 +62,7 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
 	else {
 		unsigned long ticks;
 
-		dev_dbg(pps->dev, "timeout %lld.%09d\n",
+		dev_dbg(&pps->dev, "timeout %lld.%09d\n",
 				(long long) fdata->timeout.sec,
 				fdata->timeout.nsec);
 		ticks = fdata->timeout.sec * HZ;
@@ -80,7 +80,7 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
 
 	/* Check for pending signals */
 	if (err == -ERESTARTSYS) {
-		dev_dbg(pps->dev, "pending signal caught\n");
+		dev_dbg(&pps->dev, "pending signal caught\n");
 		return -EINTR;
 	}
 
@@ -98,7 +98,7 @@ static long pps_cdev_ioctl(struct file *file,
 
 	switch (cmd) {
 	case PPS_GETPARAMS:
-		dev_dbg(pps->dev, "PPS_GETPARAMS\n");
+		dev_dbg(&pps->dev, "PPS_GETPARAMS\n");
 
 		spin_lock_irq(&pps->lock);
 
@@ -114,7 +114,7 @@ static long pps_cdev_ioctl(struct file *file,
 		break;
 
 	case PPS_SETPARAMS:
-		dev_dbg(pps->dev, "PPS_SETPARAMS\n");
+		dev_dbg(&pps->dev, "PPS_SETPARAMS\n");
 
 		/* Check the capabilities */
 		if (!capable(CAP_SYS_TIME))
@@ -124,14 +124,14 @@ static long pps_cdev_ioctl(struct file *file,
 		if (err)
 			return -EFAULT;
 		if (!(params.mode & (PPS_CAPTUREASSERT | PPS_CAPTURECLEAR))) {
-			dev_dbg(pps->dev, "capture mode unspecified (%x)\n",
+			dev_dbg(&pps->dev, "capture mode unspecified (%x)\n",
 								params.mode);
 			return -EINVAL;
 		}
 
 		/* Check for supported capabilities */
 		if ((params.mode & ~pps->info.mode) != 0) {
-			dev_dbg(pps->dev, "unsupported capabilities (%x)\n",
+			dev_dbg(&pps->dev, "unsupported capabilities (%x)\n",
 								params.mode);
 			return -EINVAL;
 		}
@@ -144,7 +144,7 @@ static long pps_cdev_ioctl(struct file *file,
 		/* Restore the read only parameters */
 		if ((params.mode & (PPS_TSFMT_TSPEC | PPS_TSFMT_NTPFP)) == 0) {
 			/* section 3.3 of RFC 2783 interpreted */
-			dev_dbg(pps->dev, "time format unspecified (%x)\n",
+			dev_dbg(&pps->dev, "time format unspecified (%x)\n",
 								params.mode);
 			pps->params.mode |= PPS_TSFMT_TSPEC;
 		}
@@ -165,7 +165,7 @@ static long pps_cdev_ioctl(struct file *file,
 		break;
 
 	case PPS_GETCAP:
-		dev_dbg(pps->dev, "PPS_GETCAP\n");
+		dev_dbg(&pps->dev, "PPS_GETCAP\n");
 
 		err = put_user(pps->info.mode, iuarg);
 		if (err)
@@ -176,7 +176,7 @@ static long pps_cdev_ioctl(struct file *file,
 	case PPS_FETCH: {
 		struct pps_fdata fdata;
 
-		dev_dbg(pps->dev, "PPS_FETCH\n");
+		dev_dbg(&pps->dev, "PPS_FETCH\n");
 
 		err = copy_from_user(&fdata, uarg, sizeof(struct pps_fdata));
 		if (err)
@@ -206,7 +206,7 @@ static long pps_cdev_ioctl(struct file *file,
 	case PPS_KC_BIND: {
 		struct pps_bind_args bind_args;
 
-		dev_dbg(pps->dev, "PPS_KC_BIND\n");
+		dev_dbg(&pps->dev, "PPS_KC_BIND\n");
 
 		/* Check the capabilities */
 		if (!capable(CAP_SYS_TIME))
@@ -218,7 +218,7 @@ static long pps_cdev_ioctl(struct file *file,
 
 		/* Check for supported capabilities */
 		if ((bind_args.edge & ~pps->info.mode) != 0) {
-			dev_err(pps->dev, "unsupported capabilities (%x)\n",
+			dev_err(&pps->dev, "unsupported capabilities (%x)\n",
 					bind_args.edge);
 			return -EINVAL;
 		}
@@ -227,7 +227,7 @@ static long pps_cdev_ioctl(struct file *file,
 		if (bind_args.tsformat != PPS_TSFMT_TSPEC ||
 				(bind_args.edge & ~PPS_CAPTUREBOTH) != 0 ||
 				bind_args.consumer != PPS_KC_HARDPPS) {
-			dev_err(pps->dev, "invalid kernel consumer bind"
+			dev_err(&pps->dev, "invalid kernel consumer bind"
 					" parameters (%x)\n", bind_args.edge);
 			return -EINVAL;
 		}
@@ -259,7 +259,7 @@ static long pps_cdev_compat_ioctl(struct file *file,
 		struct pps_fdata fdata;
 		int err;
 
-		dev_dbg(pps->dev, "PPS_FETCH\n");
+		dev_dbg(&pps->dev, "PPS_FETCH\n");
 
 		err = copy_from_user(&compat, uarg, sizeof(struct pps_fdata_compat));
 		if (err)
@@ -296,20 +296,36 @@ static long pps_cdev_compat_ioctl(struct file *file,
 #define pps_cdev_compat_ioctl	NULL
 #endif
 
+static struct pps_device *pps_idr_get(unsigned long id)
+{
+	struct pps_device *pps;
+
+	mutex_lock(&pps_idr_lock);
+	pps = idr_find(&pps_idr, id);
+	if (pps)
+		get_device(&pps->dev);
+
+	mutex_unlock(&pps_idr_lock);
+	return pps;
+}
+
 static int pps_cdev_open(struct inode *inode, struct file *file)
 {
-	struct pps_device *pps = container_of(inode->i_cdev,
-						struct pps_device, cdev);
+	struct pps_device *pps = pps_idr_get(iminor(inode));
+
+	if (!pps)
+		return -ENODEV;
+
 	file->private_data = pps;
-	kobject_get(&pps->dev->kobj);
 	return 0;
 }
 
 static int pps_cdev_release(struct inode *inode, struct file *file)
 {
-	struct pps_device *pps = container_of(inode->i_cdev,
-						struct pps_device, cdev);
-	kobject_put(&pps->dev->kobj);
+	struct pps_device *pps = file->private_data;
+
+	WARN_ON(pps->id != iminor(inode));
+	put_device(&pps->dev);
 	return 0;
 }
 
@@ -332,22 +348,13 @@ static void pps_device_destruct(struct device *dev)
 {
 	struct pps_device *pps = dev_get_drvdata(dev);
 
-	cdev_del(&pps->cdev);
-
-	/* Now we can release the ID for re-use */
 	pr_debug("deallocating pps%d\n", pps->id);
-	mutex_lock(&pps_idr_lock);
-	idr_remove(&pps_idr, pps->id);
-	mutex_unlock(&pps_idr_lock);
-
-	kfree(dev);
 	kfree(pps);
 }
 
 int pps_register_cdev(struct pps_device *pps)
 {
 	int err;
-	dev_t devt;
 
 	mutex_lock(&pps_idr_lock);
 	/*
@@ -364,40 +371,29 @@ int pps_register_cdev(struct pps_device *pps)
 		goto out_unlock;
 	}
 	pps->id = err;
-	mutex_unlock(&pps_idr_lock);
-
-	devt = MKDEV(MAJOR(pps_devt), pps->id);
-
-	cdev_init(&pps->cdev, &pps_cdev_fops);
-	pps->cdev.owner = pps->info.owner;
 
-	err = cdev_add(&pps->cdev, devt, 1);
-	if (err) {
-		pr_err("%s: failed to add char device %d:%d\n",
-				pps->info.name, MAJOR(pps_devt), pps->id);
+	pps->dev.class = pps_class;
+	pps->dev.parent = pps->info.dev;
+	pps->dev.devt = MKDEV(pps_major, pps->id);
+	dev_set_drvdata(&pps->dev, pps);
+	dev_set_name(&pps->dev, "pps%d", pps->id);
+	err = device_register(&pps->dev);
+	if (err)
 		goto free_idr;
-	}
-	pps->dev = device_create(pps_class, pps->info.dev, devt, pps,
-							"pps%d", pps->id);
-	if (IS_ERR(pps->dev)) {
-		err = PTR_ERR(pps->dev);
-		goto del_cdev;
-	}
 
 	/* Override the release function with our own */
-	pps->dev->release = pps_device_destruct;
+	pps->dev.release = pps_device_destruct;
 
-	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name,
-			MAJOR(pps_devt), pps->id);
+	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
+		 pps->id);
 
+	get_device(&pps->dev);
+	mutex_unlock(&pps_idr_lock);
 	return 0;
 
-del_cdev:
-	cdev_del(&pps->cdev);
-
 free_idr:
-	mutex_lock(&pps_idr_lock);
 	idr_remove(&pps_idr, pps->id);
+	put_device(&pps->dev);
 out_unlock:
 	mutex_unlock(&pps_idr_lock);
 	return err;
@@ -407,7 +403,13 @@ void pps_unregister_cdev(struct pps_device *pps)
 {
 	pr_debug("unregistering pps%d\n", pps->id);
 	pps->lookup_cookie = NULL;
-	device_destroy(pps_class, pps->dev->devt);
+	device_destroy(pps_class, pps->dev.devt);
+
+	/* Now we can release the ID for re-use */
+	mutex_lock(&pps_idr_lock);
+	idr_remove(&pps_idr, pps->id);
+	put_device(&pps->dev);
+	mutex_unlock(&pps_idr_lock);
 }
 
 /*
@@ -427,6 +429,11 @@ void pps_unregister_cdev(struct pps_device *pps)
  * so that it will not be used again, even if the pps device cannot
  * be removed from the idr due to pending references holding the minor
  * number in use.
+ *
+ * Since pps_idr holds a reference to the device, the returned
+ * pps_device is guaranteed to be valid until pps_unregister_cdev() is
+ * called on it. But after calling pps_unregister_cdev(), it may be
+ * freed at any time.
  */
 struct pps_device *pps_lookup_dev(void const *cookie)
 {
@@ -449,13 +456,11 @@ EXPORT_SYMBOL(pps_lookup_dev);
 static void __exit pps_exit(void)
 {
 	class_destroy(pps_class);
-	unregister_chrdev_region(pps_devt, PPS_MAX_SOURCES);
+	__unregister_chrdev(pps_major, 0, PPS_MAX_SOURCES, "pps");
 }
 
 static int __init pps_init(void)
 {
-	int err;
-
 	pps_class = class_create(THIS_MODULE, "pps");
 	if (IS_ERR(pps_class)) {
 		pr_err("failed to allocate class\n");
@@ -463,8 +468,9 @@ static int __init pps_init(void)
 	}
 	pps_class->dev_groups = pps_groups;
 
-	err = alloc_chrdev_region(&pps_devt, 0, PPS_MAX_SOURCES, "pps");
-	if (err < 0) {
+	pps_major = __register_chrdev(0, 0, PPS_MAX_SOURCES, "pps",
+				      &pps_cdev_fops);
+	if (pps_major < 0) {
 		pr_err("failed to allocate char device region\n");
 		goto remove_class;
 	}
@@ -477,8 +483,7 @@ static int __init pps_init(void)
 
 remove_class:
 	class_destroy(pps_class);
-
-	return err;
+	return pps_major;
 }
 
 subsys_initcall(pps_init);
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 78c8ac4951b5..c7abce28ed29 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -56,8 +56,7 @@ struct pps_device {
 
 	unsigned int id;			/* PPS source unique ID */
 	void const *lookup_cookie;		/* For pps_lookup_dev() only */
-	struct cdev cdev;
-	struct device *dev;
+	struct device dev;
 	struct fasync_struct *async_queue;	/* fasync method */
 	spinlock_t lock;
 };
-- 
2.47.2


