Return-Path: <stable+bounces-173619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9521FB35E77
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6635B4651C8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6430333CE88;
	Tue, 26 Aug 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HTrHKXTc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E6F3002D2;
	Tue, 26 Aug 2025 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208718; cv=none; b=JLqONr9xpsRBBiSXdZCo4lmvugwMWzXN0g4Zr7bO2Dg5xtJj/y2LxWXTdhDVE60vAzn1H4hlX7l+ieNbvfK79CmPtFByyvCiSkIZBeTJl2T2NTcmeNMzDEoHkwcbL4mc+J+ip6fpKgVlfWklp67zNxwBfBfAZ+WjOKprhMrQ/fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208718; c=relaxed/simple;
	bh=zAKJEcku7e6Ob/oveTREHoM4GW0wth+30L/oESXgKLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=roPbBGIZm1TNMWUE42OH0yLLuYdcllgqIvnlxVDpiiEHhApDj2Fhla6BN3WSEF7t/a15NWJm+ZM/jVAH2mtS0Ia+E1x1YaUXDvIgiUwu4zQdALffU2IkhKNJtbWzFdfNmkgs36b5hpPbNk1cJ54osL1HRI+cfCpofUGMnpMjOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HTrHKXTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C2DC116B1;
	Tue, 26 Aug 2025 11:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208718;
	bh=zAKJEcku7e6Ob/oveTREHoM4GW0wth+30L/oESXgKLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTrHKXTctFkCjNr3rMFKacmzKcwvkRlvvY2z18BmSC4N1607J4aIPyh4gSi30M0r4
	 X1RgwtDlGNamT+j8t2gab7JmXnP3PaSFOdMP7QoktY5LfgbFg+60EQfqij+1apG5QN
	 3vkf1fwnzBJX24KPc81FD2KbnfhxSao0Dr7snkAo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Yunseong Kim <ysk@kzalloc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 6.12 219/322] kcov, usb: Dont disable interrupts in kcov_remote_start_usb_softirq()
Date: Tue, 26 Aug 2025 13:10:34 +0200
Message-ID: <20250826110921.294549273@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 9528d32873b38281ae105f2f5799e79ae9d086c2 upstream.

kcov_remote_start_usb_softirq() the begin of urb's completion callback.
HCDs marked HCD_BH will invoke this function from the softirq and
in_serving_softirq() will detect this properly.
Root-HUB (RH) requests will not be delayed to softirq but complete
immediately in IRQ context.
This will confuse kcov because in_serving_softirq() will report true if
the softirq is served after the hardirq and if the softirq got
interrupted by the hardirq in which currently runs.

This was addressed by simply disabling interrupts in
kcov_remote_start_usb_softirq() which avoided the interruption by the RH
while a regular completion callback was invoked.
This not only changes the behaviour while kconv is enabled but also
breaks PREEMPT_RT because now sleeping locks can no longer be acquired.

Revert the previous fix. Address the issue by invoking
kcov_remote_start_usb() only if the context is just "serving softirqs"
which is identified by checking in_serving_softirq() and in_hardirq()
must be false.

Fixes: f85d39dd7ed89 ("kcov, usb: disable interrupts in kcov_remote_start_usb_softirq")
Cc: stable <stable@kernel.org>
Reported-by: Yunseong Kim <ysk@kzalloc.com>
Closes: https://lore.kernel.org/all/20250725201400.1078395-2-ysk@kzalloc.com/
Tested-by: Yunseong Kim <ysk@kzalloc.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20250811082745.ycJqBXMs@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/hcd.c |   12 +++++-------
 include/linux/kcov.h   |   47 +++++++++--------------------------------------
 2 files changed, 14 insertions(+), 45 deletions(-)

--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1623,7 +1623,6 @@ static void __usb_hcd_giveback_urb(struc
 	struct usb_hcd *hcd = bus_to_hcd(urb->dev->bus);
 	struct usb_anchor *anchor = urb->anchor;
 	int status = urb->unlinked;
-	unsigned long flags;
 
 	urb->hcpriv = NULL;
 	if (unlikely((urb->transfer_flags & URB_SHORT_NOT_OK) &&
@@ -1641,14 +1640,13 @@ static void __usb_hcd_giveback_urb(struc
 	/* pass ownership to the completion handler */
 	urb->status = status;
 	/*
-	 * Only collect coverage in the softirq context and disable interrupts
-	 * to avoid scenarios with nested remote coverage collection sections
-	 * that KCOV does not support.
-	 * See the comment next to kcov_remote_start_usb_softirq() for details.
+	 * This function can be called in task context inside another remote
+	 * coverage collection section, but kcov doesn't support that kind of
+	 * recursion yet. Only collect coverage in softirq context for now.
 	 */
-	flags = kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
+	kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
 	urb->complete(urb);
-	kcov_remote_stop_softirq(flags);
+	kcov_remote_stop_softirq();
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -57,47 +57,21 @@ static inline void kcov_remote_start_usb
 
 /*
  * The softirq flavor of kcov_remote_*() functions is introduced as a temporary
- * workaround for KCOV's lack of nested remote coverage sections support.
- *
- * Adding support is tracked in https://bugzilla.kernel.org/show_bug.cgi?id=210337.
- *
- * kcov_remote_start_usb_softirq():
- *
- * 1. Only collects coverage when called in the softirq context. This allows
- *    avoiding nested remote coverage collection sections in the task context.
- *    For example, USB/IP calls usb_hcd_giveback_urb() in the task context
- *    within an existing remote coverage collection section. Thus, KCOV should
- *    not attempt to start collecting coverage within the coverage collection
- *    section in __usb_hcd_giveback_urb() in this case.
- *
- * 2. Disables interrupts for the duration of the coverage collection section.
- *    This allows avoiding nested remote coverage collection sections in the
- *    softirq context (a softirq might occur during the execution of a work in
- *    the BH workqueue, which runs with in_serving_softirq() > 0).
- *    For example, usb_giveback_urb_bh() runs in the BH workqueue with
- *    interrupts enabled, so __usb_hcd_giveback_urb() might be interrupted in
- *    the middle of its remote coverage collection section, and the interrupt
- *    handler might invoke __usb_hcd_giveback_urb() again.
+ * work around for kcov's lack of nested remote coverage sections support in
+ * task context. Adding support for nested sections is tracked in:
+ * https://bugzilla.kernel.org/show_bug.cgi?id=210337
  */
 
-static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
+static inline void kcov_remote_start_usb_softirq(u64 id)
 {
-	unsigned long flags = 0;
-
-	if (in_serving_softirq()) {
-		local_irq_save(flags);
+	if (in_serving_softirq() && !in_hardirq())
 		kcov_remote_start_usb(id);
-	}
-
-	return flags;
 }
 
-static inline void kcov_remote_stop_softirq(unsigned long flags)
+static inline void kcov_remote_stop_softirq(void)
 {
-	if (in_serving_softirq()) {
+	if (in_serving_softirq() && !in_hardirq())
 		kcov_remote_stop();
-		local_irq_restore(flags);
-	}
 }
 
 #ifdef CONFIG_64BIT
@@ -131,11 +105,8 @@ static inline u64 kcov_common_handle(voi
 }
 static inline void kcov_remote_start_common(u64 id) {}
 static inline void kcov_remote_start_usb(u64 id) {}
-static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
-{
-	return 0;
-}
-static inline void kcov_remote_stop_softirq(unsigned long flags) {}
+static inline void kcov_remote_start_usb_softirq(u64 id) {}
+static inline void kcov_remote_stop_softirq(void) {}
 
 #endif /* CONFIG_KCOV */
 #endif /* _LINUX_KCOV_H */



