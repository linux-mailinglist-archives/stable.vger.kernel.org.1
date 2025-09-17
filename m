Return-Path: <stable+bounces-180261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80545B7EFF1
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0200F1C247A3
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019B8319619;
	Wed, 17 Sep 2025 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FBKeoDOv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28A0319603;
	Wed, 17 Sep 2025 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113895; cv=none; b=l30gdy+1GuJsh1ec6X3k8KzvgDm/ooKnydeLZ5kSZdP8OMOdQ9VvhqBtx1jb3F6/M85C3Cm4GC4YcylbO/USondV0uNKUcoeO17FvHqpFecnc5VLOvVYmmlPhZGNK31nRLF4vP6HNBRn6XWbVfotEud+B/KevBL4izhaL3NYMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113895; c=relaxed/simple;
	bh=XVulvJ0GoTkg1yrjJD7WhR0KD+hEFBxPvIMppI9iKOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJvTrdMqeSbNIs1iw1pcDn7UCDqfBEZU6aPFl+nmckS2WQ/cOQTz4DVk/Di4J3RJKi3tfYDNUjYDQ2CIGOTwOp/FTT1TifN+7g3YW51I5rZbF/zb5bHbea4Gc356cOWfWoFuzUuAZOTj43bPUoAQrMkei3gJO1Jvl/Xsm2hfi9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FBKeoDOv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B19C4CEF0;
	Wed, 17 Sep 2025 12:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113895;
	bh=XVulvJ0GoTkg1yrjJD7WhR0KD+hEFBxPvIMppI9iKOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FBKeoDOvz4LSzqD051BVOF34M1lLTXiwBGG6Be2etkySK1FRS1bLW6v178flelcEN
	 hbaS0uppdZsswux+5DAwJcE8baultKWM/SgBDZc62aE+IZJlhcKZ7RQbR/61gY+q3L
	 pEM7vL+xuNrQ8I/HAyEMyiGQ8a1HvieTjJ/+344I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abaci Robot <abaci@linux.alibaba.com>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 086/101] hrtimer: Remove unused function
Date: Wed, 17 Sep 2025 14:35:09 +0200
Message-ID: <20250917123338.918820756@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123336.863698492@linuxfoundation.org>
References: <20250917123336.863698492@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ Upstream commit 82ccdf062a64f3c4ac575c16179ce68edbbbe8e4 ]

The function is defined, but not called anywhere:

  kernel/time/hrtimer.c:1880:20: warning: unused function '__hrtimer_peek_ahead_timers'.

Remove it.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240322070441.29646-1-jiapeng.chong@linux.alibaba.com
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8611
Stable-dep-of: e895f8e29119 ("hrtimers: Unconditionally update target CPU base after offline timer migration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/hrtimer.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6d9da768604d6..e9833a30a86a4 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1938,25 +1938,7 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	tick_program_event(expires_next, 1);
 	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
 }
-
-/* called with interrupts disabled */
-static inline void __hrtimer_peek_ahead_timers(void)
-{
-	struct tick_device *td;
-
-	if (!hrtimer_hres_active())
-		return;
-
-	td = this_cpu_ptr(&tick_cpu_device);
-	if (td && td->evtdev)
-		hrtimer_interrupt(td->evtdev);
-}
-
-#else /* CONFIG_HIGH_RES_TIMERS */
-
-static inline void __hrtimer_peek_ahead_timers(void) { }
-
-#endif	/* !CONFIG_HIGH_RES_TIMERS */
+#endif /* !CONFIG_HIGH_RES_TIMERS */
 
 /*
  * Called from run_local_timers in hardirq context every jiffy
-- 
2.51.0




