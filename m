Return-Path: <stable+bounces-246726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK/JGSz0A2rKBAIAu9opvQ
	(envelope-from <stable+bounces-246726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 05:46:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B910652CF21
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 05:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B46C30063A3
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 03:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F0F3921C8;
	Wed, 13 May 2026 03:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atNI8dLs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30E30FC27;
	Wed, 13 May 2026 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643772; cv=none; b=msq1zgx8cKCF3r5/H4TDW7oX+IsMvMcdF7AZ5x6T+pdFP4NwvtBuNPgVCitV+2NcQrBIZil8fOE2jYElvnDzIRCgoPtMrtYFc7OIojzXzan9LUUHKDzJT34hsIIDv1212qAOqaRhgZsPk5b06vXNtH9fKzfIjJrEOWXKrlXQ7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643772; c=relaxed/simple;
	bh=1U5j98JmsPu3oc0wBW1+ms5UCTDM78EOOk480QfbKK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paNBnDJRVunnYIWkgrxkf65FZ+zcSCcu5nNtqrSpnQWrSY5hxcvtOXI1zprGnXjLKzHC/HfUtSsd34YfIRrcaYlr1Vxa85bvSh/4lEulfFGfg4fsm4bkDPB3VW1KQeip2vM/HuyHYlSUBAEBNrJlCjS71Z5ciZv9bkx8WMEQD+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atNI8dLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8002BC2BCC7;
	Wed, 13 May 2026 03:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643771;
	bh=1U5j98JmsPu3oc0wBW1+ms5UCTDM78EOOk480QfbKK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=atNI8dLsAp2FxKbnqISO5vV+de1LH+ec2oh+eGcHKg0GEe4Rq/FOpK//5p/XPqvzZ
	 jBD/DS9h2tHqhDA6DsSf3M0Pbei7fcZYoAKQ5ZzHrGOD9izlPPSy4oUq/j3qI4xGdq
	 KFBy27N0uIgx0ZiwM5/M81YyJKLEoa0i7Mco46w31m5mmr6x3XEQoSttKiqPfPiDpY
	 Y7zV84+U+zS1jRE1qLWOyHsdVajfRRb28oA5G5/frWx9qOG4xktj45mxlMMZyOdZ9R
	 5Fk7eKN9v8OIaOJ9CbjOmg/28dKTEPIWWUr6nhLz5z/3e5FmrcCO6vQ2tbCpb9S9c/
	 QCHpTQI/sG5Jw==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y 1/2] mm/damon/core: implement damon_kdamond_pid()
Date: Tue, 12 May 2026 20:42:26 -0700
Message-ID: <20260513034229.131258-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026051240-quickly-effective-c901@gregkh>
References: <2026051240-quickly-effective-c901@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B910652CF21
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246726-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Action: no action

Patch series "mm/damon: hide kdamond and kdamond_lock from API callers".

'kdamond' and 'kdamond_lock' fields initially exposed to DAMON API callers
for flexible synchronization and use cases.  As DAMON API became somewhat
complicated compared to the early days, Keeping those exposed could only
encourage the API callers to invent more creative but complicated and
difficult-to-debug use cases.

Fortunately DAMON API callers didn't invent that many creative use cases.
There exist only two use cases of 'kdamond' and 'kdamond_lock'.  Finding
whether the kdamond is actively running, and getting the pid of the
kdamond.  For the first use case, a dedicated API function, namely
'damon_is_running()' is provided, and all DAMON API callers are using the
function for the use case.  Hence only the second use case is where the
fields are directly being used by DAMON API callers.

To prevent future invention of complicated and erroneous use cases of the
fields, hide the fields from the API callers.  For that, provide new
dedicated DAMON API functions for the remaining use case, namely
damon_kdamond_pid(), migrate DAMON API callers to use the new function,
and mark the fields as private fields.

This patch (of 5):

'kdamond' and 'kdamond_lock' are directly being used by DAMON API callers
for getting the pid of the corresponding kdamond.  To discourage invention
of creative but complicated and erroneous new usages of the fields that
require careful synchronization, implement a new API function that can
simply be used without the manual synchronizations.

Link: https://lkml.kernel.org/r/20260115152047.68415-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20260115152047.68415-2-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 4262c53236977de3ceaa3bf2aefdf772c9b874dd)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
The second patch depends on this commit, so porting this together.

 include/linux/damon.h |  1 +
 mm/damon/core.c       | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 6fe6f7fcf83d8..d902381950908 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -949,6 +949,7 @@ bool damon_initialized(void);
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 bool damon_is_running(struct damon_ctx *ctx);
+int damon_kdamond_pid(struct damon_ctx *ctx);
 
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7738095ea4ce3..386b1afd05c35 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1431,6 +1431,23 @@ bool damon_is_running(struct damon_ctx *ctx)
 	return running;
 }
 
+/**
+ * damon_kdamond_pid() - Return pid of a given DAMON context's worker thread.
+ * @ctx:	The DAMON context of the question.
+ *
+ * Return: pid if @ctx is running, negative error code otherwise.
+ */
+int damon_kdamond_pid(struct damon_ctx *ctx)
+{
+	int pid = -EINVAL;
+
+	mutex_lock(&ctx->kdamond_lock);
+	if (ctx->kdamond)
+		pid = ctx->kdamond->pid;
+	mutex_unlock(&ctx->kdamond_lock);
+	return pid;
+}
+
 /**
  * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
  * @ctx:	DAMON context to call the function for.
-- 
2.47.3


