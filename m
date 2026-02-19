Return-Path: <stable+bounces-217471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIQNHLZFl2lMwQIAu9opvQ
	(envelope-from <stable+bounces-217471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:17:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E6C1610FC
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 18:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4443430B751E
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D659349B1F;
	Thu, 19 Feb 2026 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSqKh1Et"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5646266EE9
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521218; cv=none; b=EO907/UPy8JgTx3hpCghgcmAA8sAZkc25qwDqDwoPkJ5n0mj2cCfQdeHUy7Cc0dj3HtkCJtQ1SkCostLp0D0/HmCfNGIXztN2W9hA50UE4D7WtrCMT0hcHkKhg5M4HRcIk018TjioDqhrULZKkP98hvZhxWSCYQgxlhlRZdv744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521218; c=relaxed/simple;
	bh=HhT6z2DVcZ8yTv/m6DHxcDKqHPAmK3H4JJhD4dhIVH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RnYBFv4Z5SvB0nBEXpi4RMYGdGUyfpjjROKGmsEGW9qyvVfjWMAzEhuN7z3KkGo1BlecI8Efb9TZDyP7z55i6mcqIayTjs5+ehWfVKdb978Mh7NRhErJvKfTHoAMV4AZVO/3xlUFPE2SGcLWN+a8Lj1uRTABxw3ZKg31IfGL4O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSqKh1Et; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82310b74496so632091b3a.3
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 09:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521216; x=1772126016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ivwth3bvYn00MIlpqUjU3pfVj9NAWsfF7rOKTWPDVU=;
        b=iSqKh1EtcQq3Vw7JlOgIlbG/jUIdobO7x/7X68R9/m/62XmQG6tIi4l913RcKGad/u
         ixrurEoIFtrSqU5NDv4klM4yFtm/Qa2NWFBu4Y6HDe9uRdXij2vCLmhXNPn2O6ddtfSk
         0mX0osBfgp/93jWe+fRehNQ74bMml9qc4lAIusGSbdzpelqlZGt71UjSnIqIhl/gJT19
         V+/1t+utSKktCRCyWbSLfs99k5i+bbkdI31jC589PB6cjQRQGia/ygRpAGmZ2ul6jCjo
         P/3z8fQltix+jnxd9iHgEVBvFN2mbgjg386NI0MrR5c1sAjcZ/ZsLwTz+VGxKm22erfM
         +rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521216; x=1772126016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Ivwth3bvYn00MIlpqUjU3pfVj9NAWsfF7rOKTWPDVU=;
        b=A4yovqe644WLjsPIG2bUh0HWWYTVSNYrDfTBziIhbFs9qwoJqRRn6098qFnDus10Bo
         WBKOz78pvdTDJOgZHrPuw9qe3LazcCSW1bLq+uyfu9jetxZhem1smP2nIaQtU0K9hsIP
         3uJhPCWo08r/cMS9311+yzTZvBGA8KDP8eRd6fakH2gpkBT/AusF860Ml7245LrYac/d
         iAEE+sNi6jyfzOJtN9Umd/GVOdB23UuiqWeGqVMLy1lScrwOupy5A/2ZnhPVXVcmPsNd
         oTy4sNAIfZhCBkKmiOMiV9aoaAFuFOHpQR5mpuV5mQseqg5cGohxbSPF5SJc5JJuuTbf
         Sj1g==
X-Gm-Message-State: AOJu0YydqExRuQc/tKi2jTUbZPTb+5eL9DQ00Gr6xdfxV5QgQsgromTL
	TREAIIjtX6VlM1N5vusgoWeIBHjliYINgJrCn1ImpJ2Q59rQcWLnHVYWXqCxxNq0
X-Gm-Gg: AZuq6aK119sVGN4fWFzW1npGxGZ2h9rVcB7FWoAiTTmKQSt/bL9ta4OS9dOkrA0EOVd
	a+9EYC3ay8rNBblA/NanirHevLnHis3zP+uiEWJcYh+Jb5YhCFrFsDQRsSQxUNQRJYCmLCblANA
	uHpz/ZgdIxxvDAin2H1lC9nPSkOYNdmOaH3yX6DjcyohuXkgY/Kf8nhFEPik/GLsRGv0DMIabru
	E/l7WlQ0UhEB6sSgj/SJ8oK6OxEc6hrPHWRl9bCFrSHoRUEN/cYhFr2svGx4KEIrAlAVi5t93Um
	ZHfwOjRwV7MzxsIOjtxMHzGh+QMidakq4Phsw5SKtF6H75T4eLbZWK5yd2SGHf2f+KPWzZOOEQR
	F4GnyB8fsyfYLD/ZxcFY318jXAtcrRH/iQy3pt2t8AhoSVUUMrWsyfrrDmgzvZ1WgM965m9LeJK
	sz3jr9cgib5IkISYt4Glys+5ThRmynVDeu3b85Pbh2GC5YiVhuCULvjwAZolvx
X-Received: by 2002:a05:6a21:6b05:b0:34f:b660:770d with SMTP id adf61e73a8af0-3946c95590dmr18861831637.55.1771521216447;
        Thu, 19 Feb 2026 09:13:36 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:35 -0800 (PST)
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
	zouyipeng@huawei.com,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.10.y 05/15] timers: Get rid of del_singleshot_timer_sync()
Date: Fri, 20 Feb 2026 02:13:00 +0900
Message-Id: <20260219171310.118170-6-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219171310.118170-1-aha310510@gmail.com>
References: <20260219171310.118170-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,linutronix.de,inria.fr,linux-foundation.org,arndb.de,vger.kernel.org,roeck-us.net,gmail.com,holtmann.org,kernel.org,infradead.org,goodmis.org,linaro.org,huawei.com,lists.linux.dev,intel.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-217471-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,linutronix.de:email,intel.com:email]
X-Rspamd-Queue-Id: C0E6C1610FC
X-Rspamd-Action: no action

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

