Return-Path: <stable+bounces-246735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNj8MZ7+A2qiBwIAu9opvQ
	(envelope-from <stable+bounces-246735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:31:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F18552D2AF
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBA93305D856
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 04:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841CD2D94BA;
	Wed, 13 May 2026 04:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjnZpz1W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726349620;
	Wed, 13 May 2026 04:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778646670; cv=none; b=jqgmL3M0w8bEVUlz76NQruSfrV0QbsapNsxmoD37mOdW0hfETMx/gx7Kp3aysMdP1fQ2ncMVgA/SIOPNlikN9g6u7nmr8CbUZJ2Ohsg8Uay6+sWjwvZ1PDMhr/QUFHxP67GjATxp/JtSwzgVDOfP3oM8cKM1tNBbeiO/YZlPTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778646670; c=relaxed/simple;
	bh=o+ku2LAPuUt830MXbThTXkW9YDjjDcKnTqxiBpFvs3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8v+6DJfWaq4k5c/jHTanmMYwpI1mXxGngCg8KDBC7QUiaXIRy8T4K8F5AA/NNsA9PRmSNk66NLuZnDGncp+Yk5R6sb3L7KFgIV3eWeEGY+tLDV5/lBbsoYGR20ZeqRLTo07aIJIUASKSuPBePP+rnL0awPP7VEODiyxxy1yP88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjnZpz1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B367DC2BCB7;
	Wed, 13 May 2026 04:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778646669;
	bh=o+ku2LAPuUt830MXbThTXkW9YDjjDcKnTqxiBpFvs3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjnZpz1WAHevgxOTmvt0sLLAZ1rMY1x2JBNL0jql008qecwla2LA0fSRne2myqKAP
	 wjaB6qEKhfNLrusnOORttdqCjgKvP8dsOWwBjUlscjMwtFptWk5olCPmWQxSJiAx9t
	 +TMiPuuc3ufZsmKJkWwMUGibGlwcJ7+mQSb0tXLHf4QIWpuMYrB5HeXz820zqj6JtY
	 Yh6qOGYP8FDIcqg3vkRHRd6wuD4b6fguCuBR+dI2t2MMv5grp8xQm8U14F3N4cHxlF
	 U+xxxNbRsQg0Vps4uOSA4+vtiyQaRMlAfzEafU/wFWk6NOvM9s1CSyWqwM2TpnodSe
	 ABTPK3XW8ae5g==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y 1/2] mm/damon/core: implement damon_kdamond_pid()
Date: Tue, 12 May 2026 21:30:35 -0700
Message-ID: <20260513043039.173237-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026051243-crevice-spool-75d8@gregkh>
References: <2026051243-crevice-spool-75d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2F18552D2AF
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
	TAGGED_FROM(0.00)[bounces-246735-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
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
index e6941b239f449..7eeec0eaaf1f5 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -572,6 +572,7 @@ static inline unsigned int damon_max_nr_accesses(const struct damon_attrs *attrs
 
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
+int damon_kdamond_pid(struct damon_ctx *ctx);
 
 int damon_set_region_biggest_system_ram_default(struct damon_target *t,
 				unsigned long *start, unsigned long *end);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ab5c351b276ce..fc68364c9ad2e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -643,6 +643,23 @@ static bool damon_check_reset_time_interval(struct timespec64 *baseline,
 	return true;
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
 /*
  * Check whether it is time to flush the aggregated information
  */
-- 
2.47.3


