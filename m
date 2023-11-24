Return-Path: <stable+bounces-903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB8D7F7D10
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD841C20F56
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538D63A8C3;
	Fri, 24 Nov 2023 18:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r7cFXLq2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144F034197;
	Fri, 24 Nov 2023 18:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929CAC433C8;
	Fri, 24 Nov 2023 18:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850065;
	bh=GdQUkidxrA8xNVvD0S9c8OE+HScrJm2+LBZB9KPEeJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r7cFXLq20ZGhzwQAcW6NlRn3iMVbRYc36Q15/9y2/iaqJ4MLOzzXq3HbfQOJLhIaH
	 H1aANk5PY2RSyFAIV+zjWICv/xNDo1kQp5Qqrreit4n94Zq6ncu5KG6ZUlr8LqxAvw
	 VKoKN5hGqQGXxjotr2P7trNTkvhXZju+OO3XX0bs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 407/530] rcutorture: Fix stuttering races and other issues
Date: Fri, 24 Nov 2023 17:49:33 +0000
Message-ID: <20231124172040.447373281@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

From: Joel Fernandes (Google) <joel@joelfernandes.org>

[ Upstream commit cca42bd8eb1b54a4c9bbf48c79d120e66619a3e4 ]

The stuttering code isn't functioning as expected. Ideally, it should
pause the torture threads for a designated period before resuming. Yet,
it fails to halt the test for the correct duration. Additionally, a race
condition exists, potentially causing the stuttering code to pause for
an extended period if the 'spt' variable is non-zero due to the stutter
orchestration thread's inadequate CPU time.

Moreover, over-stuttering can hinder RCU's progress on TREE07 kernels.
This happens as the stuttering code may run within a softirq due to RCU
callbacks. Consequently, ksoftirqd keeps a CPU busy for several seconds,
thus obstructing RCU's progress. This situation triggers a warning
message in the logs:

[ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9

This warning suggests that an RCU torture object, although invisible to
RCU readers, couldn't make it past the pipe array and be freed -- a
strong indication that there weren't enough grace periods during the
stutter interval.

To address these issues, this patch sets the "stutter end" time to an
absolute point in the future set by the main stutter thread. This is
then used for waiting in stutter_wait(). While the stutter thread still
defines this absolute time, the waiters' waiting logic doesn't rely on
the stutter thread receiving sufficient CPU time to halt the stuttering
as the halting is now self-controlled.

Cc: stable@vger.kernel.org
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/torture.c | 45 ++++++++++++---------------------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index e851b8e9390b3..c7b475883b9a8 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -721,7 +721,7 @@ static void torture_shutdown_cleanup(void)
  * suddenly applied to or removed from the system.
  */
 static struct task_struct *stutter_task;
-static int stutter_pause_test;
+static ktime_t stutter_till_abs_time;
 static int stutter;
 static int stutter_gap;
 
@@ -731,30 +731,16 @@ static int stutter_gap;
  */
 bool stutter_wait(const char *title)
 {
-	unsigned int i = 0;
 	bool ret = false;
-	int spt;
+	ktime_t till_ns;
 
 	cond_resched_tasks_rcu_qs();
-	spt = READ_ONCE(stutter_pause_test);
-	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
-		if (!ret && !rt_task(current)) {
-			sched_set_normal(current, MAX_NICE);
-			ret = true;
-		}
-		if (spt == 1) {
-			torture_hrtimeout_jiffies(1, NULL);
-		} else if (spt == 2) {
-			while (READ_ONCE(stutter_pause_test)) {
-				if (!(i++ & 0xffff))
-					torture_hrtimeout_us(10, 0, NULL);
-				cond_resched();
-			}
-		} else {
-			torture_hrtimeout_jiffies(round_jiffies_relative(HZ), NULL);
-		}
-		torture_shutdown_absorb(title);
+	till_ns = READ_ONCE(stutter_till_abs_time);
+	if (till_ns && ktime_before(ktime_get(), till_ns)) {
+		torture_hrtimeout_ns(till_ns, 0, HRTIMER_MODE_ABS, NULL);
+		ret = true;
 	}
+	torture_shutdown_absorb(title);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(stutter_wait);
@@ -765,23 +751,16 @@ EXPORT_SYMBOL_GPL(stutter_wait);
  */
 static int torture_stutter(void *arg)
 {
-	DEFINE_TORTURE_RANDOM(rand);
-	int wtime;
+	ktime_t till_ns;
 
 	VERBOSE_TOROUT_STRING("torture_stutter task started");
 	do {
 		if (!torture_must_stop() && stutter > 1) {
-			wtime = stutter;
-			if (stutter > 2) {
-				WRITE_ONCE(stutter_pause_test, 1);
-				wtime = stutter - 3;
-				torture_hrtimeout_jiffies(wtime, &rand);
-				wtime = 2;
-			}
-			WRITE_ONCE(stutter_pause_test, 2);
-			torture_hrtimeout_jiffies(wtime, NULL);
+			till_ns = ktime_add_ns(ktime_get(),
+					       jiffies_to_nsecs(stutter));
+			WRITE_ONCE(stutter_till_abs_time, till_ns);
+			torture_hrtimeout_jiffies(stutter - 1, NULL);
 		}
-		WRITE_ONCE(stutter_pause_test, 0);
 		if (!torture_must_stop())
 			torture_hrtimeout_jiffies(stutter_gap, NULL);
 		torture_shutdown_absorb("torture_stutter");
-- 
2.42.0




