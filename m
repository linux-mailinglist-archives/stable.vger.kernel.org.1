Return-Path: <stable+bounces-67043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C136D94F3A5
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D44928125D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D9E186E47;
	Mon, 12 Aug 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LvFtHvfq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2D29CA;
	Mon, 12 Aug 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479613; cv=none; b=QzlWalbr40Fn0hr3f48YmiAUkLMC+x8ct6myiHbkJr+gOFPZhMVd25MG/qtgzn5S3kSTgxN89MYnGtcsHPpAHf+WpKtZLMnnf+ee5lH6K+ok5Abv7OE/wA1N6nBcZI9GZApM4EJlxTTGpxaVE1JSD+nQf+bisYZC0B8uwcLANQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479613; c=relaxed/simple;
	bh=kCoyaihn8YAc6+vBTBcRkCiNUWDaV3vVL6E2O7GqhL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPGOkHr2uLAiQzn+GhqPxMhnSu7tAEgM4FWQAkRGnqVSdyMJRlAkNNjjN+YcjAs1K44tPHrIKjzXbbLLkVVIFRYcmbuLcIWlpmgGo1Oa94Nr1RoFNKiIU2pD7Q4iodZGgPRlBZJFCB4pQ7Z39nIc+TfGs7qlz4w3vER/Mys0p2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LvFtHvfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D91C4AF0D;
	Mon, 12 Aug 2024 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479613;
	bh=kCoyaihn8YAc6+vBTBcRkCiNUWDaV3vVL6E2O7GqhL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LvFtHvfqYJGnC5cATUoN1B57USBiKjkWON+OVaaBKDCqOLqJDvfM5lOcIWRULhGZT
	 20+7d0++O2FoJA7J7DjX66prh92BlSxnQQyQQ+FbsbirxgupD1oXobAfRnwxt37b7U
	 qaEW9DccgMkUYcArMB3TWM7CB3kMhnqc9S4i+Jfo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrey Konovalov <andreyknvl@gmail.com>,
	syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com,
	Marco Elver <elver@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Aleksandr Nogikh <nogikh@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marcello Sylvester Bauer <sylv@sylv.io>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 141/189] kcov: properly check for softirq context
Date: Mon, 12 Aug 2024 18:03:17 +0200
Message-ID: <20240812160137.568896551@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Konovalov <andreyknvl@gmail.com>

commit 7d4df2dad312f270d62fecb0e5c8b086c6d7dcfc upstream.

When collecting coverage from softirqs, KCOV uses in_serving_softirq() to
check whether the code is running in the softirq context.  Unfortunately,
in_serving_softirq() is > 0 even when the code is running in the hardirq
or NMI context for hardirqs and NMIs that happened during a softirq.

As a result, if a softirq handler contains a remote coverage collection
section and a hardirq with another remote coverage collection section
happens during handling the softirq, KCOV incorrectly detects a nested
softirq coverate collection section and prints a WARNING, as reported by
syzbot.

This issue was exposed by commit a7f3813e589f ("usb: gadget: dummy_hcd:
Switch to hrtimer transfer scheduler"), which switched dummy_hcd to using
hrtimer and made the timer's callback be executed in the hardirq context.

Change the related checks in KCOV to account for this behavior of
in_serving_softirq() and make KCOV ignore remote coverage collection
sections in the hardirq and NMI contexts.

This prevents the WARNING printed by syzbot but does not fix the inability
of KCOV to collect coverage from the __usb_hcd_giveback_urb when dummy_hcd
is in use (caused by a7f3813e589f); a separate patch is required for that.

Link: https://lkml.kernel.org/r/20240729022158.92059-1-andrey.konovalov@linux.dev
Fixes: 5ff3b30ab57d ("kcov: collect coverage from interrupts")
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
Reported-by: syzbot+2388cdaeb6b10f0c13ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2388cdaeb6b10f0c13ac
Acked-by: Marco Elver <elver@google.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Aleksandr Nogikh <nogikh@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marcello Sylvester Bauer <sylv@sylv.io>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/kcov.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -161,6 +161,15 @@ static void kcov_remote_area_put(struct
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
@@ -170,7 +179,7 @@ static notrace bool check_kcov_mode(enum
 	 * so we ignore code executed in interrupts, unless we are in a remote
 	 * coverage collection section in a softirq.
 	 */
-	if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
+	if (!in_task() && !(in_softirq_really() && t->kcov_softirq))
 		return false;
 	mode = READ_ONCE(t->kcov_mode);
 	/*
@@ -848,7 +857,7 @@ void kcov_remote_start(u64 handle)
 
 	if (WARN_ON(!kcov_check_handle(handle, true, true, true)))
 		return;
-	if (!in_task() && !in_serving_softirq())
+	if (!in_task() && !in_softirq_really())
 		return;
 
 	local_lock_irqsave(&kcov_percpu_data.lock, flags);
@@ -990,7 +999,7 @@ void kcov_remote_stop(void)
 	int sequence;
 	unsigned long flags;
 
-	if (!in_task() && !in_serving_softirq())
+	if (!in_task() && !in_softirq_really())
 		return;
 
 	local_lock_irqsave(&kcov_percpu_data.lock, flags);



