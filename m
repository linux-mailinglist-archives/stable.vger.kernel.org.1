Return-Path: <stable+bounces-192799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E35A8C4379E
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 04:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72DF94E2128
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 03:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AEA1B85FD;
	Sun,  9 Nov 2025 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bzq7YK5z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EF2189906
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 03:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762657739; cv=none; b=XLFhHTBcNkBapiOE+b9HgxkCo6TmIo+FWsyW5p81atBknpyVJVMVUONPBY0O4VzidA1RWiQvJeQerd/pB8kddFaQypX58tUCaTOJ9mDJR+O5fT5cfXTCjHJBKqnFz/NsH0CwPRBtpMqqGvEWP99Laqd+VRzovxgRDIMOiQ1PXLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762657739; c=relaxed/simple;
	bh=T76TIcthVS8xoiKGreqqVzhiZsPqSnmAuBK7lHFy9r0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TDXNXtZiXug84QBqD5G2avZUM8dKEo3H4QJKjz64TpT7VDhbC8t5pXAGIZLku1T643TAL0KA9P/R1+WMXOhmXBe7DBrq8o1gV8rlsJF88BOnRhOoJlQO3QC+RpSeKIaTHce9NaQxzv0bWCVdn/Sa1Ga4rNOjj0p5Ji4UC8CzoxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bzq7YK5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A228C16AAE;
	Sun,  9 Nov 2025 03:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762657738;
	bh=T76TIcthVS8xoiKGreqqVzhiZsPqSnmAuBK7lHFy9r0=;
	h=Subject:To:Cc:From:Date:From;
	b=bzq7YK5zOkvGQtbo6T2vHsRzUehb+MDvImN2MQzwr2ILV9Mq9hpd5kgYxgDzGP54K
	 YtPDBDM2zXO02b74R56zapnF4RjCIO9HiK6s1TpMSLiryqIc/SSYAKH3lb2N/2ddem
	 26xKO2sNFicfK+5drqia5HAuNGrZvPtoYbeBbuD4=
Subject: FAILED: patch "[PATCH] wifi: cfg80211: add an hrtimer based delayed work item" failed to apply to 6.6-stable tree
To: benjamin.berg@intel.com,johannes.berg@intel.com,miriam.rachel.korenblit@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Nov 2025 12:08:55 +0900
Message-ID: <2025110955-quilt-nastiness-ab78@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7ceba45a6658ce637da334cd0ebf27f4ede6c0fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110955-quilt-nastiness-ab78@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ceba45a6658ce637da334cd0ebf27f4ede6c0fe Mon Sep 17 00:00:00 2001
From: Benjamin Berg <benjamin.berg@intel.com>
Date: Tue, 28 Oct 2025 12:58:37 +0200
Subject: [PATCH] wifi: cfg80211: add an hrtimer based delayed work item

The normal timer mechanism assume that timeout further in the future
need a lower accuracy. As an example, the granularity for a timer
scheduled 4096 ms in the future on a 1000 Hz system is already 512 ms.
This granularity is perfectly sufficient for e.g. timeouts, but there
are other types of events that will happen at a future point in time and
require a higher accuracy.

Add a new wiphy_hrtimer_work type that uses an hrtimer internally. The
API is almost identical to the existing wiphy_delayed_work and it can be
used as a drop-in replacement after minor adjustments. The work will be
scheduled relative to the current time with a slack of 1 millisecond.

CC: stable@vger.kernel.org # 6.4+
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20251028125710.7f13a2adc5eb.I01b5af0363869864b0580d9c2a1770bafab69566@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 781624f5913a..820e299f06b5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6435,6 +6435,11 @@ static inline void wiphy_delayed_work_init(struct wiphy_delayed_work *dwork,
  * after wiphy_lock() was called. Therefore, wiphy_cancel_work() can
  * use just cancel_work() instead of cancel_work_sync(), it requires
  * being in a section protected by wiphy_lock().
+ *
+ * Note that these are scheduled with a timer where the accuracy
+ * becomes less the longer in the future the scheduled timer is. Use
+ * wiphy_hrtimer_work_queue() if the timer must be not be late by more
+ * than approximately 10 percent.
  */
 void wiphy_delayed_work_queue(struct wiphy *wiphy,
 			      struct wiphy_delayed_work *dwork,
@@ -6506,6 +6511,79 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
 bool wiphy_delayed_work_pending(struct wiphy *wiphy,
 				struct wiphy_delayed_work *dwork);
 
+struct wiphy_hrtimer_work {
+	struct wiphy_work work;
+	struct wiphy *wiphy;
+	struct hrtimer timer;
+};
+
+enum hrtimer_restart wiphy_hrtimer_work_timer(struct hrtimer *t);
+
+static inline void wiphy_hrtimer_work_init(struct wiphy_hrtimer_work *hrwork,
+					   wiphy_work_func_t func)
+{
+	hrtimer_setup(&hrwork->timer, wiphy_hrtimer_work_timer,
+		      CLOCK_BOOTTIME, HRTIMER_MODE_REL);
+	wiphy_work_init(&hrwork->work, func);
+}
+
+/**
+ * wiphy_hrtimer_work_queue - queue hrtimer work for the wiphy
+ * @wiphy: the wiphy to queue for
+ * @hrwork: the high resolution timer worker
+ * @delay: the delay given as a ktime_t
+ *
+ * Please refer to wiphy_delayed_work_queue(). The difference is that
+ * the hrtimer work uses a high resolution timer for scheduling. This
+ * may be needed if timeouts might be scheduled further in the future
+ * and the accuracy of the normal timer is not sufficient.
+ *
+ * Expect a delay of a few milliseconds as the timer is scheduled
+ * with some slack and some more time may pass between queueing the
+ * work and its start.
+ */
+void wiphy_hrtimer_work_queue(struct wiphy *wiphy,
+			      struct wiphy_hrtimer_work *hrwork,
+			      ktime_t delay);
+
+/**
+ * wiphy_hrtimer_work_cancel - cancel previously queued hrtimer work
+ * @wiphy: the wiphy, for debug purposes
+ * @hrtimer: the hrtimer work to cancel
+ *
+ * Cancel the work *without* waiting for it, this assumes being
+ * called under the wiphy mutex acquired by wiphy_lock().
+ */
+void wiphy_hrtimer_work_cancel(struct wiphy *wiphy,
+			       struct wiphy_hrtimer_work *hrtimer);
+
+/**
+ * wiphy_hrtimer_work_flush - flush previously queued hrtimer work
+ * @wiphy: the wiphy, for debug purposes
+ * @hrwork: the hrtimer work to flush
+ *
+ * Flush the work (i.e. run it if pending). This must be called
+ * under the wiphy mutex acquired by wiphy_lock().
+ */
+void wiphy_hrtimer_work_flush(struct wiphy *wiphy,
+			      struct wiphy_hrtimer_work *hrwork);
+
+/**
+ * wiphy_hrtimer_work_pending - Find out whether a wiphy hrtimer
+ * work item is currently pending.
+ *
+ * @wiphy: the wiphy, for debug purposes
+ * @hrwork: the hrtimer work in question
+ *
+ * Return: true if timer is pending, false otherwise
+ *
+ * Please refer to the wiphy_delayed_work_pending() documentation as
+ * this is the equivalent function for hrtimer based delayed work
+ * items.
+ */
+bool wiphy_hrtimer_work_pending(struct wiphy *wiphy,
+				struct wiphy_hrtimer_work *hrwork);
+
 /**
  * enum ieee80211_ap_reg_power - regulatory power for an Access Point
  *
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 797f9f2004a6..54a34d8d356e 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1787,6 +1787,62 @@ bool wiphy_delayed_work_pending(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL_GPL(wiphy_delayed_work_pending);
 
+enum hrtimer_restart wiphy_hrtimer_work_timer(struct hrtimer *t)
+{
+	struct wiphy_hrtimer_work *hrwork =
+		container_of(t, struct wiphy_hrtimer_work, timer);
+
+	wiphy_work_queue(hrwork->wiphy, &hrwork->work);
+
+	return HRTIMER_NORESTART;
+}
+EXPORT_SYMBOL_GPL(wiphy_hrtimer_work_timer);
+
+void wiphy_hrtimer_work_queue(struct wiphy *wiphy,
+			      struct wiphy_hrtimer_work *hrwork,
+			      ktime_t delay)
+{
+	trace_wiphy_hrtimer_work_queue(wiphy, &hrwork->work, delay);
+
+	if (!delay) {
+		hrtimer_cancel(&hrwork->timer);
+		wiphy_work_queue(wiphy, &hrwork->work);
+		return;
+	}
+
+	hrwork->wiphy = wiphy;
+	hrtimer_start_range_ns(&hrwork->timer, delay,
+			       1000 * NSEC_PER_USEC, HRTIMER_MODE_REL);
+}
+EXPORT_SYMBOL_GPL(wiphy_hrtimer_work_queue);
+
+void wiphy_hrtimer_work_cancel(struct wiphy *wiphy,
+			       struct wiphy_hrtimer_work *hrwork)
+{
+	lockdep_assert_held(&wiphy->mtx);
+
+	hrtimer_cancel(&hrwork->timer);
+	wiphy_work_cancel(wiphy, &hrwork->work);
+}
+EXPORT_SYMBOL_GPL(wiphy_hrtimer_work_cancel);
+
+void wiphy_hrtimer_work_flush(struct wiphy *wiphy,
+			      struct wiphy_hrtimer_work *hrwork)
+{
+	lockdep_assert_held(&wiphy->mtx);
+
+	hrtimer_cancel(&hrwork->timer);
+	wiphy_work_flush(wiphy, &hrwork->work);
+}
+EXPORT_SYMBOL_GPL(wiphy_hrtimer_work_flush);
+
+bool wiphy_hrtimer_work_pending(struct wiphy *wiphy,
+				struct wiphy_hrtimer_work *hrwork)
+{
+	return hrtimer_is_queued(&hrwork->timer);
+}
+EXPORT_SYMBOL_GPL(wiphy_hrtimer_work_pending);
+
 static int __init cfg80211_init(void)
 {
 	int err;
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 8a4c34112eb5..2b71f1d867a0 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -304,6 +304,27 @@ TRACE_EVENT(wiphy_delayed_work_queue,
 		  __entry->delay)
 );
 
+TRACE_EVENT(wiphy_hrtimer_work_queue,
+	TP_PROTO(struct wiphy *wiphy, struct wiphy_work *work,
+		 ktime_t delay),
+	TP_ARGS(wiphy, work, delay),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		__field(void *, instance)
+		__field(void *, func)
+		__field(ktime_t, delay)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		__entry->instance = work;
+		__entry->func = work->func;
+		__entry->delay = delay;
+	),
+	TP_printk(WIPHY_PR_FMT " instance=%p func=%pS delay=%llu",
+		  WIPHY_PR_ARG, __entry->instance, __entry->func,
+		  __entry->delay)
+);
+
 TRACE_EVENT(wiphy_work_worker_start,
 	TP_PROTO(struct wiphy *wiphy),
 	TP_ARGS(wiphy),


