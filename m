Return-Path: <stable+bounces-66518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3E594ECE7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565A6280C39
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DC21E488;
	Mon, 12 Aug 2024 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hM1OWYDD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4613E16E871
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465470; cv=none; b=d4ojDiF0H0v0ZLpcPsfHCGDdol7f7/bgkU5/+FOHQwQFfDkji1NktLhWJSozGRo4pfDx58dE16Stq3RKj+2BdIaM2jMQtVNwkhb7gTIglmrTjcRloyV3QypUNaoHTbTSDn9clTHCc1XOH5M6dpujh0CksgtttsFhte1e87nGpgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465470; c=relaxed/simple;
	bh=cpOeNdxjtiZcJqEhPS0qb7OB8lLmtQTx8VKYfMMW3wU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Dq89TQGK5q4tbBBC/fWsK3SU+2svUiv1ub1gwNPGfAkwzpQKB4ChctTItgLBITaVhWvXEb2YRdlQgU9UUPUzLwuc/RNBwVPpaEpQT4TfgG2JVvIrEfayhCIq21llxU2ekekkYZ7yDapJRpbPlx5ejPytaSKOYI60ID6Ml3MNABc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hM1OWYDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99280C32782;
	Mon, 12 Aug 2024 12:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723465470;
	bh=cpOeNdxjtiZcJqEhPS0qb7OB8lLmtQTx8VKYfMMW3wU=;
	h=Subject:To:Cc:From:Date:From;
	b=hM1OWYDDkEWVmzsucIr7Ty1tnBqoJRkQi2MBlYI0AOotRu2w/ctrEfEJrEaugZ9fB
	 Zx4GKFsmElDMVIzi0fS1hmqE58dM4A5X7BZ1ply8ZPaFDnJx2UgqWKTgyAEKBCjOPS
	 GpixdEfRYzGvLDzRzQykTkOv8q9jUtd2lhGMMTDI=
Subject: FAILED: patch "[PATCH] kcov: properly check for softirq context" failed to apply to 5.10-stable tree
To: andreyknvl@gmail.com,akpm@linux-foundation.org,dvyukov@google.com,elver@google.com,glider@google.com,gregkh@linuxfoundation.org,nogikh@google.com,stable@vger.kernel.org,stern@rowland.harvard.edu,sylv@sylv.io
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:24:26 +0200
Message-ID: <2024081226-usual-undocked-fd62@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7d4df2dad312f270d62fecb0e5c8b086c6d7dcfc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081226-usual-undocked-fd62@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

7d4df2dad312 ("kcov: properly check for softirq context")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d4df2dad312f270d62fecb0e5c8b086c6d7dcfc Mon Sep 17 00:00:00 2001
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 29 Jul 2024 04:21:58 +0200
Subject: [PATCH] kcov: properly check for softirq context

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

diff --git a/kernel/kcov.c b/kernel/kcov.c
index f0a69d402066..274b6b7c718d 100644
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


