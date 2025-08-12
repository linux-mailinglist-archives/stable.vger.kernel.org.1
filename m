Return-Path: <stable+bounces-167217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898A6B22D45
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB15F16283A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A40F2F83AA;
	Tue, 12 Aug 2025 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="s902gEyB"
X-Original-To: stable@vger.kernel.org
Received: from sonic301-21.consmr.mail.sg3.yahoo.com (sonic301-21.consmr.mail.sg3.yahoo.com [106.10.242.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2D923D7D9
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.242.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755015492; cv=none; b=UgDoAMgsKyiQgYGhhE24S1zIbkM6c3gcLSlDBC2/K+pa4SaUYgNOY/1FbPyGXpNMrEoXs28metkhB1Tt9vlpLACHVUZ4N7MQE6YQpnNPRTBOwPyA+yP/3e4o05Hge+OvxKdWmClihwzhLGewI9BOYbYrJ3LD6eVG1V4srH1sh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755015492; c=relaxed/simple;
	bh=47dtQ0+NnxVh6Wv1F04eEO3b5zcGJmdlqvbUUrHVQ40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=PvdT59GZ8lvWnzQDQcLtkT9sj3MB3U4IsawpXRIm9ClGTWGp//FJO8W+LOdY86Ugmn9FHgCV+xC+AnUYBuuHZaL4fPOt/zVJPQrX6LqwZt/A9LVjgdQU9dLxPvD3V34k/rwbUp+Y1jrYT0r7iIP6XuKUL3H+L4o4p41E3NyW3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=s902gEyB; arc=none smtp.client-ip=106.10.242.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755015483; bh=2Np9t6XE5Kp4/1uhHUg0bqElqxOXmpDTaNcKzwtAyt8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=s902gEyB2IGQ33Wd3PtN+Qw7PvAa1h3OL4KhlKX+YlL2xViETXC+y7Rktd2T5ClKofEU8EecOapRrNHXy/kkqwMkSI85TvGyW2jZYtq0D8zDOKwM+m8EybycwgRPFp2TGruKLf9c6CpScHo1PsHqcthv3tj//9SJHw4xYdCWNvxzq6lGo7WJQkWXSkeO0uAFnNBX6NpeBEvMrOSKyKOuAL8A3Id+5IJjHQ8hCsFKDBcrgAAEh0xRYyopQhrZ5HBvNaMkRc/3HMVpghqmYHfVmnfQABWzJ3eJIGxKvLEGZ1ITw/Oif/8GZDeDydxzG+8SeCUNBgtCziwTweEljjfB5g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755015483; bh=zUiAOLCxR0LM/P3+np2I+6/Zd2QpFlXq17/N1QBuUAQ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=X6IIm4UQ+CYmAXfhTPPjBRsbRwbMxgK63JKyhNctNmCSOnSVuvuGvicT+kkJViM7HAWophuDTsr4XMn8NETZ3Dk+ppj0Z/KFUtMoxEr93JG1uTjQEPiKbnQNTWZtQC04zpgIXx5gtoOEsUk2Rp6pxqB2/Qjo1O5n+F1IhQibX+R22g3KcSchGPegWTUcyagF459tu3xmK6f8QbGVy69dxZ3Lp30mRjwWYOJcvJt8Xmjk4ocNQiTjtx+AotLbbGZMHUSX5505fo+T3pKhYYlOxbvBwqmPAzHexJNWArivYMVYuDW7O/OKVoNhD3kq8+1DiDvBWLzwtstG24C0ZC4CmA==
X-YMail-OSG: 1jJnYy0VM1loLxxLve.B0bpSjucOddJpiLfR6MuGcUahtHHYRr3SFROjDtW1jZS
 zESs62jdOE4h7c3oG9t_L_IDxzAJn.d9lhxGYdB3PVhBXz7K3fXkQRgtA_g3ghpCXKTru6V_eGU_
 tnP9CZqh1KZmb9hAOU_JXtatX4U_PJNMjKMIH0xAgUgKCZIQmAgZCgXKYxk.IXRznpcS9zS5h5ZC
 WNh2dk5E01XPOIoHVOrmAUIBl1c4WCUjomLgedhshzS_vr0hH3rXINefRBcHpPOghZYZ5p6N5CDK
 SCsEqAv2rWT3vmwLMCVWCc9srLAg4u4nnUWaKVlHujDXwgs4fXTQct9dtkyMCU5Ydk664zAdZppV
 0mW6BMh9TKvs8KbkLXhnjPd7Szg06pnxUgkexE9nVzrVBZeTFN5lw7xzIlfXfVp4mS9..ryWxv7Q
 6QS9I6f9meTEHpFrpjfoJy3.e5hL4SDfahvOd6Y0sNPNPbw9OeqFMw0YrxLLOrCAmDER73q3blRZ
 OR3w2bEtz.BDJRZf1iUBYAtaY7heHw9OqFKarahVBB3hZ.p9AubTntvUlYlYyiFH0pRBM.VZ9GrS
 obKpOITS6GnwJt2eLB1R6kaVdsPy96ZysywVO_mgn79BfomP3TzBx2mUHE391RtTnh0Hxdvagfwa
 2BeuSd13kFotHmdtHcUzdssN190EvE9eu_IuF.TUxtqv3_hoHhLkjlXvF1ea7Hvucqz3YEeIodWe
 C4XumWacviuccIhRmBwf7OXsyr5LhrhM7nVROlERUnpykQjYkY3JvjpN1cvxa1qAjabRRm4LrxpD
 di4G2grUXMPoAKJjUblKJUHE9EQ8HnnA6Lj55CjFF05WolVsIgGrE6WFD8uuTpMb7q_p4LcsMrk.
 MtbnsfYTJ3j9DMoZiqsppFdpdxKmuuy2g3rlEDK7Z_P0BjLb3PGwiEZhIan3ln.FxVZkNYFM_Wjo
 0mc29LZsnSmk_PmclSiWKz2NtlYcZ0bOfTbHx1XLGL_.DY5DbW7S4y.x97L0Q7b4fjJvsrd1fuqt
 UchkzsmDKbuwnlKv0LwrZExLomKbSOhqUaF6Wuqf8WnIC1aRzTXvGnu0_HJqPGNqdQ7p.YNw80DE
 MxWzuQ2OcoxMbnlVJd7dUTwXAfJl5Js1wsHO8VANXqpELzh0nB9tMCvh0sX_N7XY11XS6rawYLy3
 cVN1QODNpCSAnmXJpGbCZDxGZY0km5wwWByQ4IZXxRKrmQCVb.UM4kYhuMzTubnX0CCYl3IqEv1f
 0XBFIiNrp6FLusG67iC4P5U0d.bH72ANAY3VarlBKjXIZz_agUyJJFFcnp4GxLjcrDvDMamLE_b2
 LkBcUO8QSiEFbQC4l1rgw1OHydVLGQGNk94xaMQy7s7xE632fX3fPUw0WbBOz24YrHOqkRuOGa9X
 c0kqD.1nqnax_CUNKiETwLn9w7y0ssdR72HW3Ht0DNlcjXTwvd6FCTnWrUmwglgegGeyTD97xoMy
 H77_LkBpKAJXV3Nl8mll4gevjZRCAmgagNEc3U3xhK8EZCvtvLklbF6PXkqbbyxyURIToBIiKQm3
 SdC.0rbKQPJbutJrmoAjNyDLwl4zvKZ56.mo86d67mnAuMbZa7ioqGapW8qj2_sOEfB0vlvIujCs
 we0S4nGD7H0btZ.ekJihnmomhoBdnuX66eTw.UWktVL3p.263IoB3guJ8WppR0MQjLwZELbNLJEJ
 l6exvR2LjkqSI544B8NJT5efv_bHLt1ahY1C2COZn4MGAzFVaYTE7K.6kMNSjIG1o26z90RRiMBh
 N7NndP.KZmZdEp.GTHLLzgX9vp.v5fZhGxnoCxsBoQcTX6xEVwRjaNc70CD9cdKzhMT4dZ3Paut3
 NW9tfdj7SKDSAWGOFPCw5Mytx_vGNsqzl30ncmYbQVB4xVQiWyht1cZ.oPJqiFNwjfC_GifD7AFm
 4Yrb3cs4OlAmummf6TQAoxLhtRjqUdNJDtgDp1YkkALoGmdGdHXnGyovTl3Ad3NJC3lsXBZyNCqF
 LXcqJSkpC7CJY1czpMqrXi3tcCE9x0agF.TnOnsQJJxJL5fXZnX.97TO7PZ1KtHSbHGspsUNQ0sP
 XjRXx2bH4CkJsXTF5P.QHI1PMGAc27bNMaEiG52cDFVYiXON7Qn2blgvFwfLTn7Y7yW8tTVqjqoU
 Q4pzNxD8GfD3IkCEwSjs_QauIkdK4_.VifR6rtfIMG2tuEBnNTUwd_vi_8WSJNNJJrzfaYJyImZt
 XurlC5Ij4MpEYCG4.BLktfFEl.Iq2gTNwYAEUOpbavgtg7M1WXXM0QwUoWgVCAjEPoHAcbzalpsS
 KjdZy.1fG2_wyqLHNg8UBR61sD9kb6Of_NBpLHtM5
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 81c8d48c-51e7-47d1-a1b4-7a32898358ed
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.sg3.yahoo.com with HTTP; Tue, 12 Aug 2025 16:18:03 +0000
Received: by hermes--production-ne1-9495dc4d7-nmbx6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c833430937a7bf59cd7a05229c15b336;
          Tue, 12 Aug 2025 16:17:59 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	sumanth.gavini@yahoo.com,
	tglx@linutronix.de,
	jstultz@google.com,
	clingutla@codeaurora.org,
	mingo@kernel.org,
	sashal@kernel.org,
	boqun.feng@gmail.com,
	gregkh@linuxfoundation.org,
	ryotkkr98@gmail.com,
	kprateek.nayak@amd.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"J . Avila" <elavila@google.com>
Subject: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
Date: Tue, 12 Aug 2025 11:17:54 -0500
Message-ID: <20250812161755.609600-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250812161755.609600-1-sumanth.gavini.ref@yahoo.com>

commit f4bf3ca2e5cba655824b6e0893a98dfb33ed24e5 upstream.

Tasklets are supposed to finish their work quickly and should not block the
current running process, but it is not guaranteed that they do so.

Currently softirq_entry/exit can be used to analyse the total tasklets
execution time, but that's not helpful to track individual tasklets
execution time. That makes it hard to identify tasklet functions, which
take more time than expected.

Add tasklet_entry/exit trace point support to track individual tasklet
execution.

Trivial usage example:
   # echo 1 > /sys/kernel/debug/tracing/events/irq/tasklet_entry/enable
   # echo 1 > /sys/kernel/debug/tracing/events/irq/tasklet_exit/enable
   # cat /sys/kernel/debug/tracing/trace
 # tracer: nop
 #
 # entries-in-buffer/entries-written: 4/4   #P:4
 #
 #                                _-----=> irqs-off/BH-disabled
 #                               / _----=> need-resched
 #                              | / _---=> hardirq/softirq
 #                              || / _--=> preempt-depth
 #                              ||| / _-=> migrate-disable
 #                              |||| /     delay
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
           <idle>-0       [003] ..s1.   314.011428: tasklet_entry: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func
           <idle>-0       [003] ..s1.   314.011432: tasklet_exit: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func
           <idle>-0       [003] ..s1.   314.017369: tasklet_entry: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func
           <idle>-0       [003] ..s1.   314.017371: tasklet_exit: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func

Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
Signed-off-by: J. Avila <elavila@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20230407230526.1685443-1-jstultz@google.com

[elavila: Port to android-mainline]
[jstultz: Rebased to upstream, cut unused trace points, added
 comments for the tracepoints, reworded commit]

Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
 include/trace/events/irq.h | 47 ++++++++++++++++++++++++++++++++++++++
 kernel/softirq.c           |  9 ++++++--
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index eeceafaaea4c..a07b4607b663 100644
--- a/include/trace/events/irq.h
+++ b/include/trace/events/irq.h
@@ -160,6 +160,53 @@ DEFINE_EVENT(softirq, softirq_raise,
 	TP_ARGS(vec_nr)
 );
 
+DECLARE_EVENT_CLASS(tasklet,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func),
+
+	TP_STRUCT__entry(
+		__field(	void *,	tasklet)
+		__field(	void *,	func)
+	),
+
+	TP_fast_assign(
+		__entry->tasklet = t;
+		__entry->func = func;
+	),
+
+	TP_printk("tasklet=%ps function=%ps", __entry->tasklet, __entry->func)
+);
+
+/**
+ * tasklet_entry - called immediately before the tasklet is run
+ * @t: tasklet pointer
+ * @func: tasklet callback or function being run
+ *
+ * Used to find individual tasklet execution time
+ */
+DEFINE_EVENT(tasklet, tasklet_entry,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func)
+);
+
+/**
+ * tasklet_exit - called immediately after the tasklet is run
+ * @t: tasklet pointer
+ * @func: tasklet callback or function being run
+ *
+ * Used to find individual tasklet execution time
+ */
+DEFINE_EVENT(tasklet, tasklet_exit,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func)
+);
+
 #endif /*  _TRACE_IRQ_H */
 
 /* This part must be outside protection */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9ab5ca399a99..fadc6bbda27b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -822,10 +822,15 @@ static void tasklet_action_common(struct softirq_action *a,
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
 				if (tasklet_clear_sched(t)) {
-					if (t->use_callback)
+					if (t->use_callback) {
+						trace_tasklet_entry(t, t->callback);
 						t->callback(t);
-					else
+						trace_tasklet_exit(t, t->callback);
+					} else {
+						trace_tasklet_entry(t, t->func);
 						t->func(t->data);
+						trace_tasklet_exit(t, t->func);
+					}
 				}
 				tasklet_unlock(t);
 				continue;
-- 
2.43.0


