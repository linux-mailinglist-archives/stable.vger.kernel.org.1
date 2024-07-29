Return-Path: <stable+bounces-62343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7F293EB26
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 04:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8646CB21035
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 02:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083E97E58D;
	Mon, 29 Jul 2024 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="htsvdPzt"
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D247BB0A
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219728; cv=none; b=sjII9gQhejRcR2GPGg2YFOVU4L75TYYe5HRav6ucUueAn7Kob84mxE1iToJ2zFn/i87EtgXMr6x49+Hs2RGP6r4DKC7Yfe3AodGdfQ11thvYcGOUQxDLNnoDceqhHBoQI9MX3fWi+5En6doZE4Fq706+zEdKWe/9XTv6dOb+oyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219728; c=relaxed/simple;
	bh=JDn57jWP9FtwzbMF7WdN/nye9zvaQzfWbI2rDDZA6HE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZFgBpCegKbeTzw1c7h3OLn+wfuscwqe8vvB/mA+0AigYjeeykNvWTxAzS1ehxrmLDIkzM1v/Vb56KdDwYHc8VUejCXV25d2R6vD2CDsZ9UE+gCStUPTdKqn3cl09PJB8FAVUAtHB8sY3Z7livTJ5m7r+N9E/BfBRFj2xhPixKFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=htsvdPzt; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722219723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LsRQ18TXosCV7Zr1JLjd4CYqcPz8tKyiBF4C+fLmLDs=;
	b=htsvdPztIF2VBaEHJS0GKwyJigWRbUzeMGL2rUhSOgsqkALXSnbz73zJesuuqwlWngTseA
	D3N9M+ptlbThvav7arA5zZ0y7fw3NCh+nmFOexeGT0m75SpxU4zw81qQFJK6GnpUJuZH1t
	+sZpP0x8gpe4Fp6GHA+TdAm5rwWPlLI=
From: andrey.konovalov@linux.dev
To: Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcello Sylvester Bauer <sylv@sylv.io>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] kcov: properly check for softirq context
Date: Mon, 29 Jul 2024 04:21:58 +0200
Message-Id: <20240729022158.92059-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@gmail.com>

When collecting coverage from softirqs, KCOV uses in_serving_softirq() to
check whether the code is running in the softirq context. Unfortunately,
in_serving_softirq() is > 0 even when the code is running in the hardirq
or NMI context for hardirqs and NMIs that happened during a softirq.

As a result, if a softirq handler contains a remote coverage collection
section and a hardirq with another remote coverage collection section
happens during handling the softirq, KCOV incorrectly detects a nested
softirq coverate collection section and prints a WARNING, as reported
by syzbot.

This issue was exposed by commit a7f3813e589f ("usb: gadget: dummy_hcd:
Switch to hrtimer transfer scheduler"), which switched dummy_hcd to using
hrtimer and made the timer's callback be executed in the hardirq context.

Change the related checks in KCOV to account for this behavior of
in_serving_softirq() and make KCOV ignore remote coverage collection
sections in the hardirq and NMI contexts.

This prevents the WARNING printed by syzbot but does not fix the inability
of KCOV to collect coverage from the __usb_hcd_giveback_urb when dummy_hcd
is in use (caused by a7f3813e589f); a separate patch is required for that.

Reported-by: syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2388cdaeb6b10f0c13ac
Fixes: 5ff3b30ab57d ("kcov: collect coverage from interrupts")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 kernel/kcov.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index f0a69d402066e..274b6b7c718de 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -161,6 +161,15 @@ static void kcov_remote_area_put(struct kcov_remote_area *area,
 	kmsan_unpoison_memory(&area->list, sizeof(area->list));
 }
 
+/*
+ * Unlike in_serving_softirq(), this function returns false when called during
+ * a hardirq or an NMI that happened in the softirq context.
+ */
+static inline bool in_softirq_really(void)
+{
+	return in_serving_softirq() && !in_hardirq() && !in_nmi();
+}
+
 static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
 {
 	unsigned int mode;
@@ -170,7 +179,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
 	 * so we ignore code executed in interrupts, unless we are in a remote
 	 * coverage collection section in a softirq.
 	 */
-	if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
+	if (!in_task() && !(in_softirq_really() && t->kcov_softirq))
 		return false;
 	mode = READ_ONCE(t->kcov_mode);
 	/*
@@ -849,7 +858,7 @@ void kcov_remote_start(u64 handle)
 
 	if (WARN_ON(!kcov_check_handle(handle, true, true, true)))
 		return;
-	if (!in_task() && !in_serving_softirq())
+	if (!in_task() && !in_softirq_really())
 		return;
 
 	local_lock_irqsave(&kcov_percpu_data.lock, flags);
@@ -991,7 +1000,7 @@ void kcov_remote_stop(void)
 	int sequence;
 	unsigned long flags;
 
-	if (!in_task() && !in_serving_softirq())
+	if (!in_task() && !in_softirq_really())
 		return;
 
 	local_lock_irqsave(&kcov_percpu_data.lock, flags);
-- 
2.25.1


