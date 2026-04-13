Return-Path: <stable+bounces-236153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNCuOVoQ3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:48:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF63EE29C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8024B3048EEA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243DD3C660C;
	Mon, 13 Apr 2026 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOLZKnZ6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD53DC4DC
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095161; cv=none; b=FWc+xN49zOZvTp2b7qYp4bmJrTFEe3WkU4y37hlf/WuocBv0e8qGb+oND6vAkLio7kfI+ym+3De/yw9G/a27wHDKYmRspX1r3iVfP6MH8Nwd0sS43TCVbJ+VWXnOUvXNt20KXbCei4GInabr8m/fEl7wyP4pyRa200ea9xr/7ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095161; c=relaxed/simple;
	bh=4CemZu+suVUtzFuZOxj3sutsvIitsmDpqggC93wWMTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtUY23wGuXipgNzMun8BjU9Fct4aCJVgDGqjKB1U90XffXYlaajgWGd8iyMD7XLEt8730WySNcG0PmEFr52F8SJ0guqg9PjZcxAYyJGCLXaNMonYKzMYIIk6tfb/rNAsRgjLWtY5KBFfi0YirZL1zjGnwn7Chg+GMt+f3yuqjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOLZKnZ6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c76b95e652bso1977939a12.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776095160; x=1776699960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JusnDR0Yh9TDaRsWoQKtZaA9CPLjEJexzqPRXw9RNc=;
        b=jOLZKnZ6lAysEHloeIMR0dvx5BrUykpwrigoAoKIcSwehxZPhir9Z8loaQHzDOKDH6
         pBr5S+GJQJRbz1rGjio4HLogRjxdHCgBK42YdCG9nrbAc+5yLno0NATxSTOhVpvc57vZ
         hZv/lxhYbBF4P8LV2WdRj+625g1LsQqILQ5DvJ4Je4oaPTq7S9rZBM/OUpiWvW8HN+Vp
         s23HBtaZ9Jqo2UHtArjjaKBh2FugIXWOqwx3xN9kdw5vrRM00Cw1imYolNVL+lBW1/NF
         wvyzH5GwEppwMR5UGZiSgsW5M6cC0b+S/x+Zg+DVIO+GikBlaYVmHnM8GLb3gsHHJ4bS
         JHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776095160; x=1776699960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+JusnDR0Yh9TDaRsWoQKtZaA9CPLjEJexzqPRXw9RNc=;
        b=Lc8zn0Vsi9A9tpLc6LCQuJbfwM/8pbRl49j8oBBPCqFOiT530fLunBshV2l0Xi4Yxi
         UfxgFLIGy/LJMnu+jweQz9a8hQ19kQhtjcCCM9bOzl3gOFQ0zol+g0zNRqTgApeqKZcQ
         86QExpfEC0wilFOxovCoaLCk2QGeb9EJRlIlDXRyw+MEoBKv3kZyRX0UQdUujtG5mKJo
         Y49Ho7sUqS3vv/M5guBvzYFrOfW60IbZAM4tagdCaxfB0v3k4dCKNCINQhApvY4KVqXW
         mPANBUhLcrs/bvIo0e/LSv9II8U8W5faVdoITVo1+uNupEzxxy0iG1sepOXipLTmQQ1q
         V3Xg==
X-Forwarded-Encrypted: i=1; AFNElJ+Y37LlOCRIno+coLDQBtHyh+6BU2fdcTX2GYKD4pmmbBhGk/rNdsML1S+87nFVVmGLXJScmq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJoIsIbwsOJdhdkle1C2OIDpunnLiY3yFvdXbF5LdNs6pHifyu
	m441iHep/HgeEoLQbwqloDU0+UPli5yV/zM3hMbRBn3xGW8Dnt8rW+Ex
X-Gm-Gg: AeBDiesNiRTMvV3URY0Wfw0o5+IXF2Q/b6+2CZwKIm/iu3/ECt0Lp8eVvmUYbkknghx
	SG4S1sLorXMz3v4C4sYz3RqBdEq6EpH3hTCr/NTrtMV6U0Nj+dn6V84F27Sl/F65RtdhEZK0z3C
	PnrzUeuWZeyAl7+B/VyADnNZeylJppRgt7eVepwoIOf9pSvZU+6ayZ1AnDEqipC+c/WiE8l3fmp
	QZfTaevcZNgdchVKoxuCRGMK4hBSgGIHD8kMIU836GEzoUPB7TddCagHay/5E+Kqm6PiMiiqUYN
	7aUVu8fxuO7+G+jbAKLyRocT7ZqYg91biU+4K381f8MSB4CoAJvoUbrRZGCMnfTm/MXGl5vnBr/
	OPhZ30dMia2GU9c/dq5bA7ocXVTCMhCYtFKfITgaBRFkjifnAIovg8OMT6dPG+pc99PoN6yBG84
	xNLJQzLbcDAYbOsuKPoaQoXQ==
X-Received: by 2002:a05:6a20:7486:b0:398:b346:b13 with SMTP id adf61e73a8af0-39fe3d0dfafmr15810712637.16.1776095159705;
        Mon, 13 Apr 2026 08:45:59 -0700 (PDT)
Received: from ubuntu24.lan ([2602:ffe4:1:2113:9dfd:1ff:3726:3839])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c793488d824sm6318233a12.16.2026.04.13.08.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:45:59 -0700 (PDT)
From: Yiyang Chen <cyyzero16@gmail.com>
To: Balbir Singh <balbirs@nvidia.com>,
	Yang Yang <yang.yang29@zte.com.cn>,
	Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>,
	"Dr . Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Yiyang Chen <cyyzero16@gmail.com>
Subject: [PATCH v3 1/2] taskstats: retain dead thread stats in TGID queries
Date: Mon, 13 Apr 2026 23:45:44 +0800
Message-ID: <abd2a15d33343636ab5ba43d540bcfe508bd66c7.1776094300.git.cyyzero16@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776094300.git.cyyzero16@gmail.com>
References: <cover.1776094300.git.cyyzero16@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,uni-hamburg.de,linux-foundation.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-236153-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyyzero16@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BEF63EE29C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fill_stats_for_tgid() builds TGID stats from two sources: the cached
aggregate in signal->stats and a scan of the live threads in the group.

However, fill_tgid_exit() only accumulates delay accounting into
signal->stats. This means that once a thread exits, TGID queries lose
the fields that fill_stats_for_tgid() adds for live threads.

This gap was introduced incrementally by two earlier changes that
extended fill_stats_for_tgid() but did not make the corresponding
update to fill_tgid_exit():

- commit 8c733420bdd5 ("taskstats: add e/u/stime for TGID command")
  added ac_etime, ac_utime, and ac_stime to the TGID query path.
- commit b663a79c1915 ("taskstats: add context-switch counters")
  added nvcsw and nivcsw to the TGID query path.

As a result, those fields were accounted for live threads in TGID
queries, but were dropped from the cached TGID aggregate after thread
exit. The final TGID exit notification emitted when group_dead is true
also copies that cached aggregate, so it loses the same fields.

Factor the per-task TGID accumulation into tgid_stats_add_task() and
use it in both fill_stats_for_tgid() and fill_tgid_exit(). This keeps
the cached aggregate used for dead threads aligned with the live-thread
accumulation used by TGID queries.

Fixes: 8c733420bdd5 ("taskstats: add e/u/stime for TGID command")
Fixes: b663a79c1915 ("taskstats: add context-switch counters")
Cc: stable@vger.kernel.org
Acked-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Yiyang Chen <cyyzero16@gmail.com>

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 0cd680ccc7e5..f572f27a5828 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -210,13 +210,39 @@ static int fill_stats_for_pid(pid_t pid, struct taskstats *stats)
 	return 0;
 }
 
+static void tgid_stats_add_task(struct taskstats *stats,
+				struct task_struct *tsk, u64 now_ns)
+{
+	u64 delta, utime, stime;
+
+	/*
+	 * Each accounting subsystem calls its functions here to
+	 * accumulate its per-task stats for tsk, into the per-tgid structure
+	 *
+	 *	per-task-foo(stats, tsk);
+	 */
+	delayacct_add_tsk(stats, tsk);
+
+	/* calculate task elapsed time in nsec */
+	delta = now_ns - tsk->start_time;
+	/* Convert to micro seconds */
+	do_div(delta, NSEC_PER_USEC);
+	stats->ac_etime += delta;
+
+	task_cputime(tsk, &utime, &stime);
+	stats->ac_utime += div_u64(utime, NSEC_PER_USEC);
+	stats->ac_stime += div_u64(stime, NSEC_PER_USEC);
+
+	stats->nvcsw += tsk->nvcsw;
+	stats->nivcsw += tsk->nivcsw;
+}
+
 static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 {
 	struct task_struct *tsk, *first;
 	unsigned long flags;
 	int rc = -ESRCH;
-	u64 delta, utime, stime;
-	u64 start_time;
+	u64 now_ns;
 
 	/*
 	 * Add additional stats from live tasks except zombie thread group
@@ -233,30 +259,12 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 	else
 		memset(stats, 0, sizeof(*stats));
 
-	start_time = ktime_get_ns();
+	now_ns = ktime_get_ns();
 	for_each_thread(first, tsk) {
 		if (tsk->exit_state)
 			continue;
-		/*
-		 * Accounting subsystem can call its functions here to
-		 * fill in relevant parts of struct taskstsats as follows
-		 *
-		 *	per-task-foo(stats, tsk);
-		 */
-		delayacct_add_tsk(stats, tsk);
-
-		/* calculate task elapsed time in nsec */
-		delta = start_time - tsk->start_time;
-		/* Convert to micro seconds */
-		do_div(delta, NSEC_PER_USEC);
-		stats->ac_etime += delta;
 
-		task_cputime(tsk, &utime, &stime);
-		stats->ac_utime += div_u64(utime, NSEC_PER_USEC);
-		stats->ac_stime += div_u64(stime, NSEC_PER_USEC);
-
-		stats->nvcsw += tsk->nvcsw;
-		stats->nivcsw += tsk->nivcsw;
+		tgid_stats_add_task(stats, tsk, now_ns);
 	}
 
 	unlock_task_sighand(first, &flags);
@@ -275,18 +283,14 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 static void fill_tgid_exit(struct task_struct *tsk)
 {
 	unsigned long flags;
+	u64 now_ns;
 
 	spin_lock_irqsave(&tsk->sighand->siglock, flags);
 	if (!tsk->signal->stats)
 		goto ret;
 
-	/*
-	 * Each accounting subsystem calls its functions here to
-	 * accumalate its per-task stats for tsk, into the per-tgid structure
-	 *
-	 *	per-task-foo(tsk->signal->stats, tsk);
-	 */
-	delayacct_add_tsk(tsk->signal->stats, tsk);
+	now_ns = ktime_get_ns();
+	tgid_stats_add_task(tsk->signal->stats, tsk, now_ns);
 ret:
 	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
 	return;
-- 
2.43.0


