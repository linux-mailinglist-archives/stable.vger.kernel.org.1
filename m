Return-Path: <stable+bounces-267729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kk4DOXlDOWo5pgcAu9opvQ
	(envelope-from <stable+bounces-267729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 16:15:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C126B03B6
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 16:15:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K0TLhcOz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267729-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267729-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43285307BA23
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14333B893A;
	Mon, 22 Jun 2026 14:10:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559693B840E;
	Mon, 22 Jun 2026 14:10:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782137444; cv=none; b=oHxiZl5PKMjNrI1eCyqJFs7pwrLZ611Cz/hbQq4Fdf/rdxqs0BWNYakkSXMEiIintlEBBm01NBfxB/xyuPr2Vm+++iRgutOllqnxBEO2BUTFAIbchfZO7fuwrDXBuTGulUId7bBEjAC5/+RG155Qycq1ZikDSzHVsKzn+ysq0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782137444; c=relaxed/simple;
	bh=i64uFeNZXP3jrE9BkeGNcZxdbjLnd7A9BSpNv11HClA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvQ8BhyO0nnjI1OUqfDkjPpJZR5INNK+ASJxjslhkiZDdSxH1WkfF65uLIpPBpioh3ZFgurz3Kb0xwhFtJzWQhvFwZFR+iUwHURBKGM4LuXcTrVfONOQrfsuALm2HIorW5loI7E2Spx99Q9vG7LAIAVulHhqRChUIeEEOYgYYzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0TLhcOz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC161F00A3F;
	Mon, 22 Jun 2026 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782137443;
	bh=SJM/0XTBV4bkcxgnv4dRGM4IPEuvuQll1XDjuKhJgOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K0TLhcOz0QO6auoiihEfednChAH/dux6kSknrgWaApka8AHQo/V47SKGdJX74O/5r
	 Sm7Mv6gRnBzZNO9VsQCcCA4tx9Aqrdv+C6qYbpfoQUBn7BoY468r+nLCdbCT3lz0B7
	 GAUcTMMN36GRH4DdjuUt7sgMsTi8S/sFkAwLDO3mOH+W5mZW7Looh6rPPFhQnGL8Pz
	 /gdlmRALZsu5ssDCtcoFoEo1Hd3pgWBaRG9JhJSndAjIJvEXy/QLTOy52EHbZt/MD+
	 yseAOINCiRNPyITvIlHjOrakbtPosUlZufzVa94DdAv2O20sQIa+Sy+9EzuboJDJLn
	 M4w+/W3uTidlA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 3 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 2/2] mm/damon/ops-common: prevent >DAMON_MAX_SUBSCORE freq_subscore
Date: Mon, 22 Jun 2026 07:10:25 -0700
Message-ID: <20260622141027.29145-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622141027.29145-1-sj@kernel.org>
References: <20260622141027.29145-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267729-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21C126B03B6

When a zero sampling interval and a zero aggregation interval are
online-committed, damon_max_nr_accesses() will return 1 right after the
update.  damon_update_monitoring_results() skips updating nr_accesses of
regions for zero intervals, though.  As a result, some regions could
have nr_acceses values that are larger than damon_max_nr_accesses() for
the remaining aggregation window.  Note that the remaining aggregation
window will be quite short.  It is just the remaining execution of the
kdamond_fn() main loop body, since the aggregation interval is zero.

If damon_hot_score() is called during the remaining aggregation window,
the function can calculate freq_subscore that is larger than
DAMON_MAX_SUBSCORE.  Depending on the score weights and age/size scores,
damon_hot_score() can now return a score that is higher than
DAMOS_MAX_SCORE.

damos_adjust_quota(), which is an indirect caller of damon_hot_score()
uses the score as an index to regions_score_histogram array.  The
array's size is set to only DAMOS_MAX_SCORE + 1.  As a result, an
out-of-bound array access can happen.

The issue is expected to happen only rarely in the real world.  After
all, zero aggregation interval is not supposed to be common.  Also, the
online commit of zero intervals should be made on exactly when the DAMOS
scheme will be triggered.  I was unable to trigger this on my own.
Nonetheless, it is possible in theory and the consequence is bad.

Fix the problem by applying an upper bound of the freq_subscore.  This
is a short term fix.  In the long term,
damon_update_monitoring_results() should be modified to update all
monitoring results even in case of zero aggregation interval.  Add that
as a TODO.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260621175849.91990-1-sj@kernel.org

Fixes: 2f5bef5a590b ("mm/damon/core: update monitoring results for new monitoring attributes")
Cc: <stable@vger.kernel.org> # 6.3.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index 5c93ef2bb8a97..8d516851a69e4 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -115,6 +115,9 @@ int damon_hot_score(struct damon_ctx *c, struct damon_region *r,
 
 	freq_subscore = r->nr_accesses * DAMON_MAX_SUBSCORE /
 		damon_max_nr_accesses(&c->attrs);
+	/* TODO: update monitoring results always to avoid this. */
+	if (freq_subscore > DAMON_MAX_SUBSCORE)
+		freq_subscore = DAMON_MAX_SUBSCORE;
 
 	age_in_sec = (unsigned long)r->age * c->attrs.aggr_interval / 1000000;
 	if (age_in_sec)
-- 
2.47.3

