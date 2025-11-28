Return-Path: <stable+bounces-197607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53569C9282B
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05A53A80C9
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8D632C94C;
	Fri, 28 Nov 2025 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDAJp0YI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E532C950
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345977; cv=none; b=AQbKZbtI3RLARXJeLJoZA+15JJxvDaSyov+FxR1BBSVkxxk0R1/4vbMSLHsVvxvbmKev5UowY+H6sM77Zp31rE/fy9vZZQVT/1ipHmdJQ7APmSUnrduEr8J80fdszIZIDcyemhAZv2CdtoFgZ6Nn4KCfidT2E6cD5AVqvKqOiNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345977; c=relaxed/simple;
	bh=HhT6z2DVcZ8yTv/m6DHxcDKqHPAmK3H4JJhD4dhIVH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dASrakCUWTIRUlMC3mHmZJjY1jpKkge0Tj+M5gR/kUObfy+QmihdX3wheTj9maKoakFRAUubzCgpa7QEdW1dbUrybkJ9ONN3SGtPf1lC5oZObjRgM+zg5XHE1qecdfTlFECCApYbyBlTLpCikcaE/+fS12ka9jG7SWH3u5+U2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDAJp0YI; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b80fed1505so2458018b3a.3
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764345975; x=1764950775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ivwth3bvYn00MIlpqUjU3pfVj9NAWsfF7rOKTWPDVU=;
        b=QDAJp0YInzlKue+cv1quVOhF5wjp2MQKtZ25y/ab5AoqQoFav8QSfIRN3qgbtLzhZC
         mDrqmxkT33Ui8Fd0wqq6Mh+qngVGG0Qdbk5ZWOSRBAmbI0qrPE2zXwCJXrODPhk20lxf
         9mFDcy8dWatGATCSftKHWFTdBc3Mw95YAgws3p6r76TpR21oAGcq1pTOsirQvv27DaRo
         TRf3RD+VYD4eKo6vMTDXF7Ysj7H+N2bJjVCst4f9gwpm1lDLCB6XJLb7uM6LHjR99zh/
         inyGu3LBpma3g/U3T4DWJ3V7xBcjqXpO3KZ4+N+zqYvHFMB/ZD7dY2QKLNm9y+Ug2Omy
         mjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764345975; x=1764950775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Ivwth3bvYn00MIlpqUjU3pfVj9NAWsfF7rOKTWPDVU=;
        b=MlPiCjpepLRVcfpMDA+9DQyrXKkRLTwuOJysBpmPZr8u+WSt6wbX6/0pIMWrvxM7R8
         mWBryQ4DBHtIx25I7mCMnMOy+p/rbVzyZEEOGl0oHwRL7fHOnGzOhC1oCFMbHBVguNTW
         G7yC+gLXardCV0g9NPrE/syj8LtuBe3wOAXHyG9elBq/th6dIY0snsbOA6qK+BwZGcl9
         HK8aEpaH5bxqsmpz/4uMS8RAmh358awfXY/mUVDVhAq9vtc5AWITUfwtuscMaE/vrznV
         ip3cHN+WjszXV3Y6MCyNE2+00Reab0dNwS/WZVCRH7vXbCzf3Jh5gys95m4yUK+WKAQE
         qzIA==
X-Gm-Message-State: AOJu0Yz7Vzu3+hlWla1VaF6E934W3UhqKoGX5S5QKJtEE33QbLdu7tPh
	YiFLTYm5nIAPPWK1/X4mDlvJTuTJ6CcttwFuTFjrYLXFyLyo37XQTnf9APTSjSpWNZsLNu+v
X-Gm-Gg: ASbGncvrOHR8D7pfzKC71u0rkowukbY7t85ySrAabwRxOUFMdUMrayoNQWHHg1rwVMA
	YWVT4qizo8YlNhVj1D1Czacnl59pgccpgXx90YfLHoBVyd+q2xpNutym+bGehpsm+cIQaRZZHcJ
	4/Jl7rA8XjEYtIGw4RXe3LNVPbTQJk/epvmRXTOxc6X94ZMAztPy4USiB74lzG8TLvqzaqbtteH
	Q5kJBtx20njbTqDX45KwY9UMpCnabD4W81haDrOA2B113PzQY7Ex49Qz62WIryJui7urboohAgq
	Btd/xV1hQmNdU6oveGpiWJz82LAsqQ1WLKZCtS10cx/c1hMDR35nl9pzoIp/7rRJEDn1nthlPgq
	BnJpLHvmMBlYsE9RolDN2j3mXq0GBi1Ra2FAf6SoM81QlzaqvyCNuJleYSoHkG2d+62CoSYaFnk
	cRT1lf939zUtIzxodv1RkCowVomeROM0ikbXK3wQ==
X-Google-Smtp-Source: AGHT+IFt9S/vPqjUM0mz+GQlgswc6/I0j11kLNLh5CdF1ZTntqzS++PULCgN0F0Q/MhhEDQPVXOPYQ==
X-Received: by 2002:a05:6a00:3e29:b0:783:c2c4:9aa5 with SMTP id d2e1a72fcca58-7c58effc088mr29961873b3a.32.1764345974342;
        Fri, 28 Nov 2025 08:06:14 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:06:13 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.15.y 05/14] timers: Get rid of del_singleshot_timer_sync()
Date: Sat, 29 Nov 2025 01:05:30 +0900
Message-Id: <20251128160539.358938-6-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251128160539.358938-1-aha310510@gmail.com>
References: <20251128160539.358938-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 9a5a305686971f4be10c6d7251c8348d74b3e014 ]

del_singleshot_timer_sync() used to be an optimization for deleting timers
which are not rearmed from the timer callback function.

This optimization turned out to be broken and got mapped to
del_timer_sync() about 17 years ago.

Get rid of the undocumented indirection and use del_timer_sync() directly.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201624.706987932@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/char/tpm/tpm-dev-common.c     | 4 ++--
 drivers/staging/wlan-ng/hfa384x_usb.c | 4 ++--
 drivers/staging/wlan-ng/prism2usb.c   | 6 +++---
 include/linux/timer.h                 | 2 --
 kernel/time/timer.c                   | 2 +-
 net/sunrpc/xprt.c                     | 2 +-
 6 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 56e56a09cc90..c3fbbf4d3db7 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -157,7 +157,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 out:
 	if (!priv->response_length) {
 		*off = 0;
-		del_singleshot_timer_sync(&priv->user_read_timer);
+		del_timer_sync(&priv->user_read_timer);
 		flush_work(&priv->timeout_work);
 	}
 	mutex_unlock(&priv->buffer_mutex);
@@ -264,7 +264,7 @@ __poll_t tpm_common_poll(struct file *file, poll_table *wait)
 void tpm_common_release(struct file *file, struct file_priv *priv)
 {
 	flush_work(&priv->async_work);
-	del_singleshot_timer_sync(&priv->user_read_timer);
+	del_timer_sync(&priv->user_read_timer);
 	flush_work(&priv->timeout_work);
 	file->private_data = NULL;
 	priv->response_length = 0;
diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index 0d869b5e309c..8687e0bf3315 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -1116,8 +1116,8 @@ static int hfa384x_usbctlx_complete_sync(struct hfa384x *hw,
 		if (ctlx == get_active_ctlx(hw)) {
 			spin_unlock_irqrestore(&hw->ctlxq.lock, flags);
 
-			del_singleshot_timer_sync(&hw->reqtimer);
-			del_singleshot_timer_sync(&hw->resptimer);
+			del_timer_sync(&hw->reqtimer);
+			del_timer_sync(&hw->resptimer);
 			hw->req_timer_done = 1;
 			hw->resp_timer_done = 1;
 			usb_kill_urb(&hw->ctlx_urb);
diff --git a/drivers/staging/wlan-ng/prism2usb.c b/drivers/staging/wlan-ng/prism2usb.c
index 4b08dc1da4f9..83fcb937a58e 100644
--- a/drivers/staging/wlan-ng/prism2usb.c
+++ b/drivers/staging/wlan-ng/prism2usb.c
@@ -171,9 +171,9 @@ static void prism2sta_disconnect_usb(struct usb_interface *interface)
 		 */
 		prism2sta_ifstate(wlandev, P80211ENUM_ifstate_disable);
 
-		del_singleshot_timer_sync(&hw->throttle);
-		del_singleshot_timer_sync(&hw->reqtimer);
-		del_singleshot_timer_sync(&hw->resptimer);
+		del_timer_sync(&hw->throttle);
+		del_timer_sync(&hw->reqtimer);
+		del_timer_sync(&hw->resptimer);
 
 		/* Unlink all the URBs. This "removes the wheels"
 		 * from the entire CTLX handling mechanism.
diff --git a/include/linux/timer.h b/include/linux/timer.h
index e78521bce565..3c166b4f704d 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -198,8 +198,6 @@ static inline int del_timer_sync(struct timer_list *timer)
 	return timer_delete_sync(timer);
 }
 
-#define del_singleshot_timer_sync(t) del_timer_sync(t)
-
 extern void init_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d4ce3ebe2c8c..6cd908cfbad4 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1912,7 +1912,7 @@ signed long __sched schedule_timeout(signed long timeout)
 	timer_setup_on_stack(&timer.timer, process_timeout, 0);
 	__mod_timer(&timer.timer, expire, MOD_TIMER_NOTPENDING);
 	schedule();
-	del_singleshot_timer_sync(&timer.timer);
+	del_timer_sync(&timer.timer);
 
 	/* Remove the timer from the object tracker */
 	destroy_timer_on_stack(&timer.timer);
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 2db834318d14..2bccb5a90934 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1160,7 +1160,7 @@ xprt_request_enqueue_receive(struct rpc_task *task)
 	spin_unlock(&xprt->queue_lock);
 
 	/* Turn off autodisconnect */
-	del_singleshot_timer_sync(&xprt->timer);
+	del_timer_sync(&xprt->timer);
 }
 
 /**
--

