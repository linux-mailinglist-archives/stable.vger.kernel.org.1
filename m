Return-Path: <stable+bounces-248623-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLQQFNFNB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248623-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:46:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1537553DF6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC6983058413
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DA83FBB6E;
	Fri, 15 May 2026 16:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JF3zKv3E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1F3B635B;
	Fri, 15 May 2026 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862207; cv=none; b=F59wMZheuRRA2I61GzWDPIGOUTyQcWnfdUYAyjvUHRHYmXRY6RwiEYC8Rq+ssyJwiC2G+QqfKxjElKlb0knHMg+JJYv2Zcy9LSPZKiCPy1AAIhDfAU2KK88ISZMD5qrmenkN3UX8+n7A72VARrQDbJ3qQoBjhnuvvmM6Ott7Z7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862207; c=relaxed/simple;
	bh=K440mouuK+4+OX2jhMw10pSgZ3/nIYshWhnRmGQFgWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1QGCgt+9LKGZ300F+j0Vuv6oE9Tl3ieHetfyvjpoDL591muPnG6S59JRmsoDRNrsibz0Hp5qUR//X12AtcFDSsZjE7UOmHrKywgxOYtHI22X3DdDV2knyc22FczqtZtsQmUYVEbNJ/o+Qy4nRXmfsC94JBcVt5HMwhWOM77aLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JF3zKv3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDB4C2BCB0;
	Fri, 15 May 2026 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862206;
	bh=K440mouuK+4+OX2jhMw10pSgZ3/nIYshWhnRmGQFgWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JF3zKv3EvOwbsstBrDBQKa4U5j9IY0yWa3V2olbqpZ45QGPxHbEbWM319fOuWCB3u
	 VUffDaJYF/MLqoqQ800t74RIujJ4laBIEY4K6haaoWkIsVcBDbLqknhFROHA0gDJES
	 ukr2Qijsn/opSFTJXa5gdhwjAIBODOBSyjiFfnuM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18 147/188] mm/damon/core: implement damon_kdamond_pid()
Date: Fri, 15 May 2026 17:49:24 +0200
Message-ID: <20260515154700.511457931@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F1537553DF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248623-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linux-foundation.org:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SeongJae Park <sj@kernel.org>

commit 4262c53236977de3ceaa3bf2aefdf772c9b874dd upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/damon.h |    1 +
 mm/damon/core.c       |   17 +++++++++++++++++
 2 files changed, 18 insertions(+)

--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -949,6 +949,7 @@ bool damon_initialized(void);
 int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 bool damon_is_running(struct damon_ctx *ctx);
+int damon_kdamond_pid(struct damon_ctx *ctx);
 
 int damon_call(struct damon_ctx *ctx, struct damon_call_control *control);
 int damos_walk(struct damon_ctx *ctx, struct damos_walk_control *control);
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1437,6 +1437,23 @@ bool damon_is_running(struct damon_ctx *
 }
 
 /**
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
+/**
  * damon_call() - Invoke a given function on DAMON worker thread (kdamond).
  * @ctx:	DAMON context to call the function for.
  * @control:	Control variable of the call request.



