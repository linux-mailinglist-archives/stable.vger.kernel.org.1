Return-Path: <stable+bounces-220105-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF71DPYoo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220105-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:42:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7371C50C1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5EC33066F05
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0076647D93B;
	Sat, 28 Feb 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s47DDAEL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE947D936;
	Sat, 28 Feb 2026 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300013; cv=none; b=s0NW72qSeCjfOSDWCbJd10IkdlL6eam66dNQM9RgiGmIc+K9gOijMD3Iw4e1QF7u7izsLzqBTU+AD9wdQOeWAB+/8wAu2dTx2LIrSSFDTaUDvOfI1yUhxIFeZaxf/Xg4mhINX2vZQrfAM+gTL7bujuiJS15tLdnIP6ZDBFLyjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300013; c=relaxed/simple;
	bh=MYr2c1J4ADOsnfOTVMpeAwnhXCKn5YEPLHCPJdyqI2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLSUJb6Pyfi6CWS7DGRA/em14XA8R/zqkWAz8c55Hx4lJtdlPtUaHlFoLGvrUlolkLabT+x9yKVxCNvRdzm5JWPusS0zn47Q7LFOXSC6liSXCwO8Suk4DZm4OeMAbvlxcA1mELiGAIjOBQj4sG2rnq5+PpUEcgqlSpdFiLM4mwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s47DDAEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F838C116D0;
	Sat, 28 Feb 2026 17:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300013;
	bh=MYr2c1J4ADOsnfOTVMpeAwnhXCKn5YEPLHCPJdyqI2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s47DDAELBfTi33vNHmnCnBHei7rS8CcENBF4HsMUQeajIzST7CyDauWp0roqvcrvh
	 fd8jDl+VcWpZAFeWkkBxKoXU9nLyhdS8geYLwkdaAK7YlRS5uQi7ct31WhQeaLZimR
	 3HmR3ESgBk1VHE2PhGJ5+8+GlcT55W4/dDG6My8DwyzSZ0AG/AXQlm32+Mc6UHkycW
	 kbvxCc8L/iGnCvTGgZRAb1JH7iuJS0YE2zQiutE9bxtKxBv7flTVhAsLZJt1fOItUs
	 3Ec/RaxudiQjeVYSX/ssy4SoePz62nKCDqMTcQE9SSRFHKFuHH5NSuS99nBSAIh9Sh
	 6Ae8B1e9Y+nsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Leo Yan <leo.yan@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 027/844] perf metricgroup: Don't early exit if no CPUID table exists
Date: Sat, 28 Feb 2026 12:19:00 -0500
Message-ID: <20260228173244.1509663-28-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220105-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,intel.com:email,infradead.org:email,arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B7371C50C1
X-Rspamd-Action: no action

From: Ian Rogers <irogers@google.com>

[ Upstream commit cee275edcdb1acfdc8270f80e96f30750b633220 ]

The failure to find a table of metrics with a CPUID shouldn't early
exit as the metric code will now also consider the default table.

When searching for a metric or metric group,
pmu_metrics_table__for_each_metric() considers all tables and so the
caller doesn't need to switch the table to do this.

Fixes: c7adeb0974f18da4 ("perf jevents: Add set of common metrics based on default ones")
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/metricgroup.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 25c75fdbfc525..a21f2d4969c5c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1563,8 +1563,6 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 {
 	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 
-	if (!table)
-		return -EINVAL;
 	if (hardware_aware_grouping)
 		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
 
@@ -1602,22 +1600,16 @@ static int metricgroup__has_metric_or_groups_callback(const struct pmu_metric *p
 
 bool metricgroup__has_metric_or_groups(const char *pmu, const char *metric_or_groups)
 {
-	const struct pmu_metrics_table *tables[2] = {
-		pmu_metrics_table__find(),
-		pmu_metrics_table__default(),
-	};
+	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 	struct metricgroup__has_metric_data data = {
 		.pmu = pmu,
 		.metric_or_groups = metric_or_groups,
 	};
 
-	for (size_t i = 0; i < ARRAY_SIZE(tables); i++) {
-		if (pmu_metrics_table__for_each_metric(tables[i],
-							metricgroup__has_metric_or_groups_callback,
-							&data))
-			return true;
-	}
-	return false;
+	return pmu_metrics_table__for_each_metric(table,
+						  metricgroup__has_metric_or_groups_callback,
+						  &data)
+		? true : false;
 }
 
 static int metricgroup__topdown_max_level_callback(const struct pmu_metric *pm,
-- 
2.51.0


