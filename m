Return-Path: <stable+bounces-242630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEU7I3SZ9mkgWwIAu9opvQ
	(envelope-from <stable+bounces-242630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 02:40:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4F74B3DF8
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 02:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F40563007977
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 00:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BC31DF74F;
	Sun,  3 May 2026 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+z6ZfVs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448E41DDC2B
	for <stable@vger.kernel.org>; Sun,  3 May 2026 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777768818; cv=none; b=WQrQb6RX4EH54mE8et4pD74aZJadmyobJl/XIsXv6tM7jDypIwxgcZwG4Tb4qnkqNm5UfgE8bZ5Xpj0IbvV9MTraerRu0kPoqPgSpmKBUX1Rc9YsrM3UGe9yMtij1danGCW3wLcJGnYdfvbWvfI1Gi+ZOSUFLPDavqxwdw5uNU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777768818; c=relaxed/simple;
	bh=JoNXbzQleeKxATWN9I1/FYrLrtu5V/njSfOAh2mK6Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlerSVHKXfEdNT9urXrx2r35tMqPiBxlYyPrh1X//YvhDE1NJANP84kwaOwaDSDjQzbSay0kS03AOqHljyG8UEOcXwJ/JVe+w7yD9YFj10l7OrYk9IVINk2VawywSCeS5dz3JO4KZv5Y51KD12mqx7AAeY5C03QDtL7XTpmNbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+z6ZfVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637FCC2BCB8;
	Sun,  3 May 2026 00:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777768817;
	bh=JoNXbzQleeKxATWN9I1/FYrLrtu5V/njSfOAh2mK6Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+z6ZfVsoWYMixaIZfCg2vZV0wqITVpB0aVegXdNxBE67DbyvxCgtVrg2H3d0tslc
	 TFD1bdbRceYD48kIxJ+FTAb9sFeDAgjhy2mrcg+NotV/lEMRTbbjlrfMEMt6mdMt2G
	 6gyVF5G71WE+f71jSsgMQZEsse9PhGXP/5TpgZJSgetWTwgZkU/6+I6iw0DxFb9Jfy
	 FFdfZxBsrvRX8iLf7pKqW/3D9UuWcyPBiTE/s1R6OEkQvjJitdJRoGSSEFu2hZHl6I
	 NN1Tb6xDMQgRo9ymneC4WvnLu8ZJyC86eo28x+ET2TqRNhpe31zQS3oEIKWPpkACJa
	 YM6Yj7NV2jD0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joseph Salisbury <joseph.salisbury@oracle.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] sched: Use u64 for bandwidth ratio calculations
Date: Sat,  2 May 2026 20:40:07 -0400
Message-ID: <20260503004007.933354-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050101-glamorous-absurd-e506@gregkh>
References: <2026050101-glamorous-absurd-e506@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1A4F74B3DF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242630-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]

From: Joseph Salisbury <joseph.salisbury@oracle.com>

[ Upstream commit c6e80201e057dfb7253385e60bf541121bf5dc33 ]

to_ratio() computes BW_SHIFT-scaled bandwidth ratios from u64 period and
runtime values, but it returns unsigned long.  tg_rt_schedulable() also
stores the current group limit and the accumulated child sum in unsigned
long.

On 32-bit builds, large bandwidth ratios can be truncated and the RT
group sum can wrap when enough siblings are present.  That can let an
overcommitted RT hierarchy pass the schedulability check, and it also
narrows the helper result for other callers.

Return u64 from to_ratio() and use u64 for the RT group totals so
bandwidth ratios are preserved and compared at full width on both 32-bit
and 64-bit builds.

Fixes: b40b2e8eb521 ("sched: rt: multi level group constraints")
Assisted-by: Codex:GPT-5
Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260403210014.2713404-1-joseph.salisbury@oracle.com
[ dropped `extern` keyword from `to_ratio()` declaration ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/rt.c    | 2 +-
 kernel/sched/sched.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e5173a48eb9b0..bcb313b1e1fd3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3328,7 +3328,7 @@ void sched_post_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 	uclamp_post_fork(p);
 }
 
-unsigned long to_ratio(u64 period, u64 runtime)
+u64 to_ratio(u64 period, u64 runtime)
 {
 	if (runtime == RUNTIME_INF)
 		return BW_UNIT;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index cc6950fc6061e..2c49da90566b5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2527,7 +2527,7 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 {
 	struct rt_schedulable_data *d = data;
 	struct task_group *child;
-	unsigned long total, sum = 0;
+	u64 total, sum = 0;
 	u64 period, runtime;
 
 	period = ktime_to_ns(tg->rt_bandwidth.rt_period);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5f17507bd66b8..2a43d95dad386 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1956,7 +1956,7 @@ extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
 #define RATIO_SHIFT		8
 #define MAX_BW_BITS		(64 - BW_SHIFT)
 #define MAX_BW			((1ULL << MAX_BW_BITS) - 1)
-unsigned long to_ratio(u64 period, u64 runtime);
+u64 to_ratio(u64 period, u64 runtime);
 
 extern void init_entity_runnable_average(struct sched_entity *se);
 extern void post_init_entity_util_avg(struct task_struct *p);
-- 
2.53.0


