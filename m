Return-Path: <stable+bounces-194705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E63EC58AC4
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 17:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D075540ADF
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 16:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B53559E8;
	Thu, 13 Nov 2025 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="toprBaN9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QKpow0Bd"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFC6329383;
	Thu, 13 Nov 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049835; cv=none; b=DtsiOyd9HFqT2iMniS0MOYaL8N4xkfYipCTi+KVmKIAoR6BhkTgz/4Sbelu0B0xEkaW4zZmZtQYjV7nf9+lvox/X5JHgsWqfM/IQR1HdkoNHp+Li2G8IPoxk2TT+H0dcB2SQl3EzGS41Ywn3elui2a3M1MXhmEENxkv2PZURCNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049835; c=relaxed/simple;
	bh=+EQqqr4aXZKCkc39s9Hy2xPKj/wIDgdN7Ty015/QYV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wsv+G1DwScjgV54weIC8aSDVTl5M63aCfLYwXvymOolvoa5vaDoUrWgEOV8Qs9WUqXUS9QjXrkfNlzcWFhmXUyojxMsoQ7AE4JCRjcmH5aQPUMZQi0L9BL+tMhsX8BosG3454J0JlV1I4IXSsLqCZ8VL6Ck6BMyno5zq4YOQda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=toprBaN9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QKpow0Bd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763049832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YmTV8R+fRrPYd6LEUl1jTZ6XIQQXOMozxx7WQ79gQI=;
	b=toprBaN99tTfB/Tq+SjOjm06E1o8m461wpDp2dfHOrVhzfq6YlOsTwMr0FcaAHhjXwiMOP
	C5HUjiJI/qEQaunvHYpPOgFczHiXPdaqW7RqVeNA9quNe0j5CdP732I7N6so9CkwLlLEjH
	0/QmQrT6TFc4u6X4m7D46KWC5DH+dyFcGmear2YvZvWXDOBJ32ALDRNewu0dvqwaJ/wHf6
	O6rWwfYXZtVZPD8SkxoJVvtpkj+1wtJYKLdzL8YeGtbKkKmnh7h6G3V/qMJnZK3EIM9UIC
	OPHSqfnzZ3P7zhIzQs2jmSJu2nNwqQ+cGY5jYRKVOwSPqcv7tYNboCOzxWCawg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763049832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YmTV8R+fRrPYd6LEUl1jTZ6XIQQXOMozxx7WQ79gQI=;
	b=QKpow0Bd2zNzpUTWKObMcGpzxkEwq3cAchoZTiSKkaQSlWrJOA54ZceMq/l55F7f1kt94Q
	HfXRuvQx6O4I95Cw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sherry Sun <sherry.sun@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Derek Barbosa <debarbos@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH printk v2 1/2] printk: Allow printk_trigger_flush() to flush all types
Date: Thu, 13 Nov 2025 17:09:47 +0106
Message-ID: <20251113160351.113031-2-john.ogness@linutronix.de>
In-Reply-To: <20251113160351.113031-1-john.ogness@linutronix.de>
References: <20251113160351.113031-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently printk_trigger_flush() only triggers legacy offloaded
flushing, even if that may not be the appropriate method to flush
for currently registered consoles. (The function predates the
NBCON consoles.)

Since commit 6690d6b52726 ("printk: Add helper for flush type
logic") there is printk_get_console_flush_type(), which also
considers NBCON consoles and reports all the methods of flushing
appropriate based on the system state and consoles available.

Update printk_trigger_flush() to use
printk_get_console_flush_type() to appropriately flush registered
consoles.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/nbcon.c  |  2 +-
 kernel/printk/printk.c | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 558ef31779760..73f315fd97a3e 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1849,7 +1849,7 @@ void nbcon_device_release(struct console *con)
 			if (console_trylock())
 				console_unlock();
 		} else if (ft.legacy_offload) {
-			printk_trigger_flush();
+			defer_console_output();
 		}
 	}
 	console_srcu_read_unlock(cookie);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5aee9ffb16b9a..dc89239cf1b58 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -4567,9 +4567,30 @@ void defer_console_output(void)
 	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
 }
 
+/**
+ * printk_trigger_flush - Attempt to flush printk buffer to consoles.
+ *
+ * If possible, flush the printk buffer to all consoles in the caller's
+ * context. If offloading is available, trigger deferred printing.
+ *
+ * This is best effort. Depending on the system state, console states,
+ * and caller context, no actual flushing may result from this call.
+ */
 void printk_trigger_flush(void)
 {
-	defer_console_output();
+	struct console_flush_type ft;
+
+	printk_get_console_flush_type(&ft);
+	if (ft.nbcon_atomic)
+		nbcon_atomic_flush_pending();
+	if (ft.nbcon_offload)
+		nbcon_kthreads_wake();
+	if (ft.legacy_direct) {
+		if (console_trylock())
+			console_unlock();
+	}
+	if (ft.legacy_offload)
+		defer_console_output();
 }
 
 int vprintk_deferred(const char *fmt, va_list args)
-- 
2.47.3


