Return-Path: <stable+bounces-235847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFSuOCDw22mjJAkAu9opvQ
	(envelope-from <stable+bounces-235847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 21:18:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED8B3E5ADC
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 21:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B15AA3003351
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 19:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBEC363C40;
	Sun, 12 Apr 2026 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQC+kjDZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E453537C4
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776021533; cv=none; b=bsYKxI7D5T8GldN73oHg/c53c7RY3JGlGlb/LZkpgAYH/xXsUPsaeUwCZ08mI55rGH/4+PtdWFxs1ygxzNLskLqB/aEKWFI61NDTmjDrGdQIm7cIhcZSknUQCmp5i+UHq0iGYOtpUzVdWrcRH87Wao+8t6UKEnTKOv7LdS2vHJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776021533; c=relaxed/simple;
	bh=D3Zx7q+jagPNX2zM/ItOrdAtZmXCdo7UO8rhYFHyMFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5SkgLS6V6XooUEE513PZZgGfEFyWRuve2KdsJK3fm+1O0JdUD0YcC/PhI93SwRbXY2nOxoN9CCBQpXQ3jtQUhY7hZryqjKRFAI/KmpljxnOjBp+kyq5FKYFjIxh9YPo3q5MLKBXmjFc4yQdTzRrTdqdI3D41lMXVgNZCKeO2/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQC+kjDZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a8fba3f769so16446505ad.2
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776021531; x=1776626331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcSoI/8gd+Lz5ms3qNFjtNkgBdfJJNG1XR3lhET5sGQ=;
        b=CQC+kjDZhd70jXeIeHedF6mZHVL/mOGtNGAEPwiKiHZBuS4yUQeS13+fOXcFRnEers
         TI9RwmpQh+xttNN7fyyXpl9EJUZiqDXw3rLqzILCPqrce7v+SI0psRj7eOMnL9CvstkZ
         lc50nrU1FpAO7oh3acX33VJ4uYF26GSbIsZPbmwyt/urWPL80JMOHuFIJ/bcUUAMmj2M
         6DyTRnlg+D+m++M0ElvUAeGZoGDjrw7hoDj1kngw6uAIKdPQ1WOPPTvvFdVHJlDnNYEw
         42pKLHZ7B61rSNDQ26VGwyYuHH9g/3l1sDu4bSFA5jAltPW3dUWrhO9Nn1/it0wmLu4c
         yjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776021531; x=1776626331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GcSoI/8gd+Lz5ms3qNFjtNkgBdfJJNG1XR3lhET5sGQ=;
        b=hLAVAF3DiD4GcgeGlAkiMB8K09StLWta8quFEA7l8fan/CakuCShzqFBMnaNpvASpo
         0Hkra/uchVFBY3poRgtgm6oYstsQmT530G5YZ9WA2hcGtK0Z8D2VKQ1p7unOfWLqL0Qv
         VU43fBp6/nFlMcot8rjM5hFPmtv4aEwkJSDsXlxOS/TwjExd2Mke/OTyfySUrYV3WLjU
         mNgrP5m6uOSaEFa+drr9ce6tk3020odoN7t0zb7dMTWDVXVarq3QDpB680crKIW6C0GY
         XYwHi20BxOp6TUJTQuAYwkokm5+nJJZd6RbeJDHxHPLErRKGKnG4DGpTOc02zB/si2SL
         QQrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9wfkUfojdXDtxM0PhqjmeMQFgAYvVMIvJ63VeZUxb+FdjFZlJY6QVoegHLU/UzN+8LvxRonSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtltuZqZZ9QoCK/QAolTU20zcUlKipLmYgaSRbCVNaK6QAlv0/
	jlYUI3eru8NoanXM75Sq62/+1+EsYZbOtzdnkm/sNhbUVhHFcjtxkbex
X-Gm-Gg: AeBDiesPzA3YynJV8QODAb4/ZehSZiWf+t9NYUJ3id+jl4TZFLb63Gt/STdsME9p+1e
	N6H7IhXqBGTlungs5R62xmHkyCLYgW9l5gZsdG37hu9Yqn2aKbCwemJ+mkqdrO601bBeafg+dWH
	FcUsPDRkuQaZolOXnp714BB7rlu/auTacNG5tr1ha2RdTrGhsSsKLnBQKFifj15yzy/FceArIq0
	3CuWJy36pqRb3iOM7b8oDwMSD7XGaAcGGyfZqab2NRVZRoMQ2yphlk7r3ysnxboKAygFLwnMCDw
	7qTVN8VXyROjJhfRIy3kq+M7Y/3mAIWqKzYWIReDZT7zDyutIXE5UZsR7e6l3JFvfpr5hWCEZN4
	KJmeph6AtEDPfnKdXfKuhvEKs8B9fo+aSr2JkQK0n1EP5e2tX3S4LAo0QY23D1MOCGaWq9eU72z
	OcttuPSMVmc9TrMTjD5BK87Q==
X-Received: by 2002:a17:903:c11:b0:2b2:5099:2f3e with SMTP id d9443c01a7336-2b2d59416b7mr68154855ad.4.1776021531368;
        Sun, 12 Apr 2026 12:18:51 -0700 (PDT)
Received: from ubuntu24.lan ([2602:ffe4:1:2113:9dfd:1ff:3726:3839])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45cbf11b1sm13864075ad.17.2026.04.12.12.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 12:18:50 -0700 (PDT)
From: Yiyang Chen <cyyzero16@gmail.com>
To: Balbir Singh <balbirs@nvidia.com>,
	Yang Yang <yang.yang29@zte.com.cn>,
	Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>,
	"Dr . Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yiyang Chen <cyyzero16@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] taskstats: retain dead thread stats in TGID queries
Date: Mon, 13 Apr 2026 03:18:33 +0800
Message-ID: <99c79e8529eb2c125ffd1eaa9f5d6b479fec227c.1776020234.git.cyyzero16@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1776020234.git.cyyzero16@gmail.com>
References: <cover.1776020234.git.cyyzero16@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,uni-hamburg.de,linux-foundation.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-235847-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cyyzero16@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8ED8B3E5ADC
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
Signed-off-by: Yiyang Chen <cyyzero16@gmail.com>

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 0cd680ccc7e5..a80be5d9f52b 100644
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
+	 *	per-task-foo(tsk->signal->stats, tsk);
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


