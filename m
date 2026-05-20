Return-Path: <stable+bounces-249721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPMdL7EHDWpQsQUAu9opvQ
	(envelope-from <stable+bounces-249721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:00:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 291F6586712
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC53D3013A8F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 00:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A0A280CD2;
	Wed, 20 May 2026 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ega+ZfpQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF0E15E8B;
	Wed, 20 May 2026 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238793; cv=none; b=qGG3+8uJEsMPK+WI4/jyWXCO7GJbbatQQv3cTeML/51NHfzjQltm9J6zjAkJXc0sXEaF5PZQJ+vC7O/ifR7+roZD+RD97P7XXN7PcAUcpkbYTe70dp0D3yuPxM5Mabx0KAA87XAPzuLiSvOsO+b0aZinDidbIzKBvomyOPpkurg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238793; c=relaxed/simple;
	bh=smDlNMdLuBBikPaqQTQClw/0iBPZA3/HEYBGeCsm1sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQJgVid9QNWapRr+2NEpLKmUcfvEd3plxWbW7k1Wgz8hcvvWXruf5HCmiIb8FjWM19YBEK+hP3pnWUNndjjOT2Y/nc5f5gQtQ9K6z6r7a19Khti53Pq/0VxuPlngVe6rcENJpvDtvbDJ6xclj8kFuk0nhDixn9OsbvX9falMebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ega+ZfpQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827371F000E9;
	Wed, 20 May 2026 00:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238791;
	bh=W+4vFlL4g0qhHATf1HFjGQrVj6nKXRbt1c5SFAqy/QQ=;
	h=From:To:Cc:Subject:Date;
	b=ega+ZfpQ4LhyPbpOUZx7SWPWfcdiT84ClE8sciQGPWYEH0lNt+E1xgwAEX9m1DpS9
	 tJrAUjxmUn0/NOPeoP1zihiB6chH4SAxl0Bj57rIQayVHMOITsgq+BGaUB/s/MGGfj
	 5JkPujhA9dksFfPu4hZ2q5BOExwHLQR6Xzcl9t5xHdUdjBdxMxt/exedy+iILvMxTz
	 WftBCoHQK60Pebt1NFgmCUEb+WNf63bh4LXty3ngjyFraQkTASsl/4e9zpAcHZPukH
	 hJzx+y0iqcpqQq5iuO3iv2/MnQ55HvoGCfNheK/I2nEWMIfAU9GObaVOz38UX2U3pn
	 dZolO+NeT+mkA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH] mm/damon/core: trace esz at first setup
Date: Tue, 19 May 2026 17:59:38 -0700
Message-ID: <20260520005940.92003-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249721-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 291F6586712
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DAMON traces effective size quota from the second update, only if a
change has been made by the update.  Tracing only changed updates was an
intentional decision to avoid unnecessary same value tracing.  Always
skipping the first value is just an unintended mistake.

The mistake makes the tracepoint based investigation incomplete, because
the first effective size quota is never traced.  It is not a big issue
when the 'consist' quota tuner is used, because it keeps changing the
quota in the usual setup.

However, when the 'temporal' tuner is used, the quota value is not
changed before the goal achievement status is completely changed.  For
example, if the DAMOS scheme is started with an under-achieved goal, the
quota is set to the maximum value, and kept the same value until the
goal is achieved.  Because DAMON skips the first value, the user cannot
know what effective quota the current scheme is using.  Only after the
goal is achieved, the effective quota is changed to zero, and traced.

Unconditionally trace the initial quota value to fix this problem.

Note that the 'temporal' quota tuner was introduced by commit
af738a6a00c1 ("mm/damon/core: introduce
DAMOS_QUOTA_GOAL_TUNER_TEMPORAL"), which was added to 7.1-rc1.  But even
with the 'consist' quota tuner, the tracing is unintentionally
incomplete. Hence this commit marks the introduction of the trace event
as the broken commit.

Fixes: a86d695193bf ("mm/damon: add trace event for effective size quota")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 68b3b4bbc8fc9..0267faf216b95 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2886,6 +2886,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
 		damos_set_effective_quota(c, s);
+		if (trace_damos_esz_enabled())
+			damos_trace_esz(c, s, quota);
 	}
 
 	/* New charge window starts */

base-commit: abe8c076ff4a1283d77c1c5cb7b975723314aec9
-- 
2.47.3

