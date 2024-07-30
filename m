Return-Path: <stable+bounces-64543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 064DA941E4D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FCE2810A7
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C7F1A76C2;
	Tue, 30 Jul 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o4/I5FvO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77721A76B2;
	Tue, 30 Jul 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360470; cv=none; b=DNrWxC3FB/xuKH6VMLFdkhHCB7Pl5dzcDk6Wv7FULXhIgr37oFlKnU5Mf3hBtc/055ipa05isas4xPK2n53jm6+GaBGvMveJGHw0/Z3HE2Gth+Zv39ieu9fhJsAjqVb616sEHEabxRcOkkxBmPOq0SjGHxu0uB1QgT2gHsuZ8gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360470; c=relaxed/simple;
	bh=z2p6S7vIndNa7+YclK2T/llB5ztfi0MmGUiZ/Jm4Ro4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjbASJIgnoRNNAPUwT0XfszTLcej04nYdhjCAE2rz/VdNdO3j43I4xfhFPsHclEp215T+udR9wZM8NjunDVoklC/bGCc1HzQA77yU/W44wyEbKCWESS0IMYh8qCsjwepKDaCjnL6MOnMByINeYwB0XWnaZNO9wSk21MGgzsSzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o4/I5FvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54551C32782;
	Tue, 30 Jul 2024 17:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360469;
	bh=z2p6S7vIndNa7+YclK2T/llB5ztfi0MmGUiZ/Jm4Ro4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4/I5FvOA1TwRDFkMRoMdVeemWfFbt7iy+Rpdyjo748B9hkQk1D0SGP6eHRQ+qisb
	 tqP0GykiBmEJ9ruOEmwrHAw/TuvH4Ez/tWGn9eneGQQV9lHGbPs3VFdmqrcA37yeEM
	 zTCUeki0mzY56fbBgmYpRnx+8A4StknnJHrWhVyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.10 709/809] watchdog/perf: properly initialize the turbo mode timestamp and rearm counter
Date: Tue, 30 Jul 2024 17:49:45 +0200
Message-ID: <20240730151752.930490221@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit f944ffcbc2e1c759764850261670586ddf3bdabb upstream.

For systems on which the performance counter can expire early due to turbo
modes the watchdog handler has a safety net in place which validates that
since the last watchdog event there has at least 4/5th of the watchdog
period elapsed.

This works reliably only after the first watchdog event because the per
CPU variable which holds the timestamp of the last event is never
initialized.

So a first spurious event will validate against a timestamp of 0 which
results in a delta which is likely to be way over the 4/5 threshold of the
period.  As this might happen before the first watchdog hrtimer event
increments the watchdog counter, this can lead to false positives.

Fix this by initializing the timestamp before enabling the hardware event.
Reset the rearm counter as well, as that might be non zero after the
watchdog was disabled and reenabled.

Link: https://lkml.kernel.org/r/87frsfu15a.ffs@tglx
Fixes: 7edaeb6841df ("kernel/watchdog: Prevent false positives with turbo modes")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/watchdog_perf.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -75,11 +75,15 @@ static bool watchdog_check_timestamp(voi
 	__this_cpu_write(last_timestamp, now);
 	return true;
 }
-#else
-static inline bool watchdog_check_timestamp(void)
+
+static void watchdog_init_timestamp(void)
 {
-	return true;
+	__this_cpu_write(nmi_rearmed, 0);
+	__this_cpu_write(last_timestamp, ktime_get_mono_fast_ns());
 }
+#else
+static inline bool watchdog_check_timestamp(void) { return true; }
+static inline void watchdog_init_timestamp(void) { }
 #endif
 
 static struct perf_event_attr wd_hw_attr = {
@@ -161,6 +165,7 @@ void watchdog_hardlockup_enable(unsigned
 	if (!atomic_fetch_inc(&watchdog_cpus))
 		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
 
+	watchdog_init_timestamp();
 	perf_event_enable(this_cpu_read(watchdog_ev));
 }
 



