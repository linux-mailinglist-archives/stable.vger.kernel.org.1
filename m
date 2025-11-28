Return-Path: <stable+bounces-197616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4A2C9289A
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C184F3537F9
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140BE3321B1;
	Fri, 28 Nov 2025 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhOXafUE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1943321AF
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346024; cv=none; b=Y0Sj5XJkBKSnZWKX+cYFuQ5k038HxJI5jD8ndeFD+0GPFHyzsXGjYFbKby0DPT74MyLAP3I6oGA0r2ta0LlJvycOILr7TOA7d6shJ2NoniAxj0nmvf3gsJ3QzS4fk/aFHHNiH06PkBrugXcr8uStkAOntIw8ioCFMZRowQZ9a90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346024; c=relaxed/simple;
	bh=wtM3KGXEQuicJ8O+1w9NeLqs1Q3c/AYVobYXG6O4xkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BuRskWgVo/wLeuUeOU6zXl/Vw++A92754hH8GiDI7EckyN/UN9hLTH5eY3V4tBtAwy+6mdjBSFf+D/+n5iz/lWsV6DxewApWUfh51EdlX5irgVrEl95jNYQDChm5SXkBMYJmK7vbT2viX4TvQYnVfnnumt/7RIxmU0ylM73Iw9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhOXafUE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7baf61be569so2419201b3a.3
        for <stable@vger.kernel.org>; Fri, 28 Nov 2025 08:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764346022; x=1764950822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avVd2rCSlmy3mzSueRF3eaj+JsVil8OR/Q+bsjGDE3A=;
        b=IhOXafUEhg4evsLMn2hs+lf5f7rJn0H5MXvh51TQxLlZX/mxhGQw4mCtc+rlm9Kjgz
         y/k5zQwKyWO8Gx2kc3dLeByJpJfoPrK5FIyNHC7RPcRF0gONBUAn00Tg0P342NyG3j/5
         SBNhpupqFdisc9BZ4BwPtKnDYQBhTp3+vtI68br+Z6UUPpSj1HcvZn2CdBRcZUdph8u9
         0RMo5ekODzHm2FD+zhh01WVs5NnWYxGQnnjnKqaOaV3l5+iOliuAm3RBagWQ3xJRhI7E
         wrLqhyqWy9syPa4UkGNBj0RTn6Mb21Lw4fB5Zl4GEOEHvNL7jQm4qYzZDVPM0yNuMtTO
         9AaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764346022; x=1764950822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=avVd2rCSlmy3mzSueRF3eaj+JsVil8OR/Q+bsjGDE3A=;
        b=tmMTL9qQTQgCFw3hSGuS9tsPaA8kV0daL1bV0gnQxaPCt0YO9sewVBmmAftiK2imR1
         lXjhZp4qJKmjon4PJc3ES8hnxfevMiKSJylcdAwQnFk+OksNRH/Y/mhG6aH1/m55JQPm
         vCgKpSsHhHtJH10wAWJSFw1nPG8QQqSLtb0PrT6kiYlh4sD/lyqWeyVELjLvkQgwP4Ls
         zUP0p1huvIHwnBeUrznE6kVEAhhhMIkmvFdQ1SfmEM26+73cR7nx90xvO0LySu1+H5Io
         zD7K4/RKU1rx71J3CsZlWa8RtxLhetnKQKRnKBHg2HbaFcBcayJcJXV6HDWNKMYWaX73
         8Qyg==
X-Gm-Message-State: AOJu0YwFSwRARtjkBjf4LYwAeL/bzYnaDT+sVic9JLeQEAXICBQFHEn7
	kJLulIWRZXMbXUDd709oEHksnPiRNavPkMKMDDtRGSITmKspG3Rnb0eJJPCbEJOhqw4WhA==
X-Gm-Gg: ASbGncs/4mGkxTH14gJlMA7HmthTlGqv0kRNNjpoL8r1q8I0evrl3C+aJtY6+pIPQ+u
	xnIGMYgwJyP3Cr5m0AEqtK5OLrc8jsADP1jpUibe7frMyShmcb4xC7MAwI8yiu40R33YOdfqqPg
	EatkUg5VFnX+b7hwKWts2B8KarHeRKKOmlJ6ywBcF0C7tZlWoWCT/Hi4h7pM3Czln6Qc7Oyyesj
	e08q1VL72lI9Xs6qnzJVkfnNwcyRJ00xDyOBFPFwVAl3AAgHO/qEF+Z+GWXbdDObi2/QWxlAZM5
	p0Ubku7PbsAyQRKHjIXhDSOga1PqjQcgVkUcg6O+4+1+O8RxzvHkiAH1LoFw6gOHaj7qbhBoWlz
	RPTLJcv1vY/qJjtaiQZGz2GyIf+9AUcCQHqX3o9rPiNWXd6PH/CFq2s62J+DAgZgree2SjzZ8z6
	AWetWx/MiGdy2CMMwLVUJSxrDwveoIe6vhwAdSlg==
X-Google-Smtp-Source: AGHT+IFbb5wRaCswqOfBZvptqiaZuYa9cCWiPzI9C94VNg3d8rKHwc6PhwU1RUpFCGSPXAzo6Ott0w==
X-Received: by 2002:a05:6a00:22cb:b0:7aa:2cc6:8c38 with SMTP id d2e1a72fcca58-7c58c2abb3dmr27067471b3a.2.1764346022026;
        Fri, 28 Nov 2025 08:07:02 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f26f11fsm5408499b3a.50.2025.11.28.08.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 08:07:00 -0800 (PST)
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
Subject: [PATCH 5.15.y 14/14] Bluetooth: hci_qca: Fix the teardown problem for real
Date: Sat, 29 Nov 2025 01:05:39 +0900
Message-Id: <20251128160539.358938-15-aha310510@gmail.com>
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

[ Upstream commit e0d3da982c96aeddc1bbf1cf9469dbb9ebdca657 ]

While discussing solutions for the teardown problem which results from
circular dependencies between timers and workqueues, where timers schedule
work from their timer callback and workqueues arm the timers from work
items, it was discovered that the recent fix to the QCA code is incorrect.

That commit fixes the obvious problem of using del_timer() instead of
del_timer_sync() and reorders the teardown calls to

   destroy_workqueue(wq);
   del_timer_sync(t);

This makes it less likely to explode, but it's still broken:

   destroy_workqueue(wq);
   /* After this point @wq cannot be touched anymore */

   ---> timer expires
         queue_work(wq) <---- Results in a NULL pointer dereference
			      deep in the work queue core code.
   del_timer_sync(t);

Use the new timer_shutdown_sync() function to ensure that the timers are
disarmed, no timer callbacks are running and the timers cannot be armed
again. This restores the original teardown sequence:

   timer_shutdown_sync(t);
   destroy_workqueue(wq);

which is now correct because the timer core silently ignores potential
rearming attempts which can happen when destroy_workqueue() drains pending
work before mopping up the workqueue.

Fixes: 72ef98445aca ("Bluetooth: hci_qca: Use del_timer_sync() before freeing")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Link: https://lore.kernel.org/all/87iljhsftt.ffs@tglx
Link: https://lore.kernel.org/r/20221123201625.435907114@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 66f416f59a8d..204ba1de624d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -710,9 +710,15 @@ static int qca_close(struct hci_uart *hu)
 	skb_queue_purge(&qca->tx_wait_q);
 	skb_queue_purge(&qca->txq);
 	skb_queue_purge(&qca->rx_memdump_q);
+	/*
+	 * Shut the timers down so they can't be rearmed when
+	 * destroy_workqueue() drains pending work which in turn might try
+	 * to arm a timer.  After shutdown rearm attempts are silently
+	 * ignored by the timer core code.
+	 */
+	timer_shutdown_sync(&qca->tx_idle_timer);
+	timer_shutdown_sync(&qca->wake_retrans_timer);
 	destroy_workqueue(qca->workqueue);
-	del_timer_sync(&qca->tx_idle_timer);
-	del_timer_sync(&qca->wake_retrans_timer);
 	qca->hu = NULL;
 
 	kfree_skb(qca->rx_skb);
--

