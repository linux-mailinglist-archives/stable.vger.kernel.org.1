Return-Path: <stable+bounces-66864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A2F94F2D0
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD682849AC
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F9E187550;
	Mon, 12 Aug 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KOYEvacu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02815183CD9;
	Mon, 12 Aug 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479036; cv=none; b=f7+o+7Tb0uDzH0YGuzR+t+LEzQRRK4CT7N6dMcEWS2pLBeMkKHd4lY9l5W8Y6rtLTHO6bwT4IuMX0HEr8ypThRG3yJ4RaTtCRs6EiFUT9a4t3SB43tf/ak6jb70REfAsS2d5Kk/9ujGADqlWD8jGnq3KK0D6Frj8bgvKBQX8Jf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479036; c=relaxed/simple;
	bh=FZn9j9c8EIh678NIaxVzMCrc47jrk5EoO5IshU41YF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lbO6WaolfOKqQr6gxkoxc5vI96Z3/tYvCbS5sXeS8QKXDG+gAF0zDzqSKcwYyyYsAuXgXuVVis2XZGLfNMwzCRMibapTHwzufl6Mla+O2QfybEFuG95BqXIi6AwaE1Ilfe8eOf4udoJhpWsu2cTM51aU1HS1UcFlo7aGsaOcmjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KOYEvacu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B27AC32782;
	Mon, 12 Aug 2024 16:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479035;
	bh=FZn9j9c8EIh678NIaxVzMCrc47jrk5EoO5IshU41YF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOYEvacuXsOjCCbixs/2Lt0ALk4/MxwTzE5GLkX0X9VeQdMFhavcguRYtMPRgZWzn
	 FZN6RgkSW38ZSQGEi2qO0LVhnwJ3ZfwNjm74RDT5zCv1428mZ+cb2Lr2F4S3VjUAme
	 RpO8/w3bVJ57TYeg7U1ZQBHr7bhlUf8bOZjA4W48=
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
Subject: [PATCH 6.1 112/150] kcov: properly check for softirq context
Date: Mon, 12 Aug 2024 18:03:13 +0200
Message-ID: <20240812160129.483576570@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160125.139701076@linuxfoundation.org>
References: <20240812160125.139701076@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -847,7 +856,7 @@ void kcov_remote_start(u64 handle)
 
 	if (WARN_ON(!kcov_check_handle(handle, true, true, true)))
 		return;
-	if (!in_task() && !in_serving_softirq())
+	if (!in_task() && !in_softirq_really())
 		return;
 
 	local_lock_irqsave(&kcov_percpu_data.lock, flags);
@@ -989,7 +998,7 @@ void kcov_remote_stop(void)
 	int sequence;
 	unsigned long flags;
 
-	if (!in_task() && !in_serving_softirq())
+	if (!in_task() && !in_softirq_really())
 		return;
 
 	local_lock_irqsave(&kcov_percpu_data.lock, flags);



