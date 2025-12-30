Return-Path: <stable+bounces-204235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5141CCEA1CA
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20648301F24A
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F8328505E;
	Tue, 30 Dec 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byYy1/J8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E88231C91
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110159; cv=none; b=nCjL7TQqj64ruX3S2nLIxxdCUiI6W4psJjQhpY/IAxJnLplmRyAohSs2fCEzj5GL6XpwbogByMmXirVF8oOH2kYpN2rVTGzinQ2pScTabyMt20C4VE8c88ExPEAiQPgqy0YwmBF4P3VeHFpCbU+UF4BTdye246Prar+pXIAldCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110159; c=relaxed/simple;
	bh=pd1zGF06Q30h3mG7ucXBSPRmqdRQnXdZm1RywwH2OaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEHEVJnV2u6K7WnKiSxHUhKIqbjf5vppnPYJPqrZXQgZxwkcvm1mDYzJG4GNPv6DdkaN/66QJ+pSXgodYhB/CaBJlltvBHnL7yu8/VRK/pI8InbHt58j7sCCLTcLr2NyuCeub9R5kuthHibnXltrlT7vSrXxLFf5U0Z+uuuOSNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byYy1/J8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C7CC4CEFB;
	Tue, 30 Dec 2025 15:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767110158;
	bh=pd1zGF06Q30h3mG7ucXBSPRmqdRQnXdZm1RywwH2OaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=byYy1/J8nkI62YpFQUY//CGMfJ0KV7y1Z9M3TOt5nHKMPQP3Jw1/6NMNxEQI9D7t7
	 0eKDvGT7Fct/jpwdPwH/ObW3q+EiOmvanIxDVdBcaQWKcX+fPZIsv7UTkFMeKjYzZS
	 7qpPkpLarMZTlqQH5m3saoEeyTqXSSsizfY/tWon2ietnDWksoO+v5H3MXcA+fyZrI
	 EWjQYQminjPlXCRgqusiqn4ciWT1iypvZFM+0XSM77CJZFHEEY62QS0zHpsJZUUGHy
	 +lfmRVVJiykAXjcrPCN8Y4RY9ZGUGNzgzolrR5zoaUre8Wo0Nniy6av+i8/Uq6ABbl
	 sNKG2tbuqezNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] hrtimers: Introduce hrtimer_update_function()
Date: Tue, 30 Dec 2025 10:55:54 -0500
Message-ID: <20251230155556.2289800-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122923-amaretto-output-f3dc@gregkh>
References: <2025122923-amaretto-output-f3dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nam Cao <namcao@linutronix.de>

[ Upstream commit 8f02e3563bb5824eb01c94f2c75f1dcee2d05625 ]

Some users of hrtimer need to change the callback function after the
initial setup. They write to hrtimer::function directly.

That's not safe under all circumstances as the write is lockless and a
concurrent timer expiry might end up using the wrong function pointer.

Introduce hrtimer_update_function(), which also performs runtime checks
whether it is safe to modify the callback.

This allows to make hrtimer::function private once all users are converted.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20a937b0ae09ad54b5b6d86eabead7c570f1b72e.1730386209.git.namcao@linutronix.de
Stable-dep-of: 267ee93c417e ("serial: xilinx_uartps: fix rs485 delay_rts_after_send")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hrtimer.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 6caaa62d2b1f..39fbeb64a7da 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -337,6 +337,28 @@ static inline int hrtimer_callback_running(struct hrtimer *timer)
 	return timer->base->running == timer;
 }
 
+/**
+ * hrtimer_update_function - Update the timer's callback function
+ * @timer:	Timer to update
+ * @function:	New callback function
+ *
+ * Only safe to call if the timer is not enqueued. Can be called in the callback function if the
+ * timer is not enqueued at the same time (see the comments above HRTIMER_STATE_ENQUEUED).
+ */
+static inline void hrtimer_update_function(struct hrtimer *timer,
+					   enum hrtimer_restart (*function)(struct hrtimer *))
+{
+	guard(raw_spinlock_irqsave)(&timer->base->cpu_base->lock);
+
+	if (WARN_ON_ONCE(hrtimer_is_queued(timer)))
+		return;
+
+	if (WARN_ON_ONCE(!function))
+		return;
+
+	timer->function = function;
+}
+
 /* Forward a hrtimer so it expires after now: */
 extern u64
 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval);
-- 
2.51.0


