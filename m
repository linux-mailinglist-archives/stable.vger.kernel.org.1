Return-Path: <stable+bounces-252542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JIpJ6/7DWru5AUAu9opvQ
	(envelope-from <stable+bounces-252542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:21:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E95B595E4D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25EBA302F6A8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E8434DB46;
	Wed, 20 May 2026 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WJTs6twD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3003368B6;
	Wed, 20 May 2026 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300947; cv=none; b=n1ErJhE7bDIXUejWGKAB661VpTnD8l9xqkh7z03QsnbuugfP76LhcwLj2BmWtGfdEHzU5wo1onTwnhfn+Ync3OgBDQvMM8Sib9ixAU7XnLZ/atLF5YF+0mGTvuTrJ1Dgc0SrY87+VTfaouw8AGQ2EJCqFZw5++wKm8NsQmj69zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300947; c=relaxed/simple;
	bh=+aJJsd/LUkvXQGYsIGem5WkMqJluQD3W5PNeM/UPlSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZfX5c4MTi62pyC63DQK/7FqgRU7nMjbcHarhGXnLD6i8sRJvmBdBZ1XyBpTay9gxzCQTXRiClKPbzjmmPxqHrw42giUsJGFFg+hbg6gm55YZt5knSEw0PjrrA0lvyutsRSwfqdNL7vBS41dYaFaML8tbdogLZPVKnmsqdQleM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WJTs6twD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BD41F000E9;
	Wed, 20 May 2026 18:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300946;
	bh=Tz7uZVO4tAl/5BvTD7/rot+0X0TQg02QdjAf/2jUW3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WJTs6twDkSFw8CmzNql9DSnx+c9M0GkDjbMV+gnB4F42d7nmFxOAI1SmEAjgmTzLO
	 Gs/Xwk4cna0NVgqzqSZ4NJ9b5L0uD/I3ho+8RRzfkDwWsDnh/+lh9F3P1FFFb+W4Z4
	 YQb26h/Rme7NU4Lhbl+jMuZjnIWdOXkwlKCNgftI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 368/666] perf stat: Fix opt->value type for parse_cache_level
Date: Wed, 20 May 2026 18:19:39 +0200
Message-ID: <20260520162119.217920556@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252542-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E95B595E4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit 44311ae84ad9177fb311aee856027861c22f17b2 ]

Commit f5803651b4a4 ("perf stat: Choose the most disaggregate command
line option") changed aggregation option handling for `perf stat` but
not `perf stat report` leading to parse_cache_level being passed a
struct in the `perf stat` case but erroneously an aggr_mode enum value
for `perf stat report`. Change the `perf stat report` aggregation
handling to use the same opt_aggr_mode as `perf stat`. Also, just pass
the boolean for consistency with other boolean argument handling.

Fixes: f5803651b4a4 ("perf stat: Choose the most disaggregate command line option")
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-stat.c | 43 +++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b578930ed76a4..e476598de8083 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -171,7 +171,7 @@ struct opt_aggr_mode {
 };
 
 /* Turn command line option into most generic aggregation mode setting. */
-static enum aggr_mode opt_aggr_mode_to_aggr_mode(struct opt_aggr_mode *opt_mode)
+static enum aggr_mode opt_aggr_mode_to_aggr_mode(const struct opt_aggr_mode *opt_mode)
 {
 	enum aggr_mode mode = AGGR_GLOBAL;
 
@@ -1154,8 +1154,8 @@ static int parse_cache_level(const struct option *opt,
 			     int unset __maybe_unused)
 {
 	int level;
-	struct opt_aggr_mode *opt_aggr_mode = (struct opt_aggr_mode *)opt->value;
-	u32 *aggr_level = (u32 *)opt->data;
+	bool *per_cache = opt->value;
+	u32 *aggr_level = opt->data;
 
 	/*
 	 * If no string is specified, aggregate based on the topology of
@@ -1193,7 +1193,7 @@ static int parse_cache_level(const struct option *opt,
 		return -EINVAL;
 	}
 out:
-	opt_aggr_mode->cache = true;
+	*per_cache = true;
 	*aggr_level = level;
 	return 0;
 }
@@ -2316,24 +2316,23 @@ static struct perf_stat perf_stat = {
 static int __cmd_report(int argc, const char **argv)
 {
 	struct perf_session *session;
+	struct opt_aggr_mode opt_mode = {};
 	const struct option options[] = {
 	OPT_STRING('i', "input", &input_name, "file", "input file name"),
-	OPT_SET_UINT(0, "per-socket", &perf_stat.aggr_mode,
-		     "aggregate counts per processor socket", AGGR_SOCKET),
-	OPT_SET_UINT(0, "per-die", &perf_stat.aggr_mode,
-		     "aggregate counts per processor die", AGGR_DIE),
-	OPT_SET_UINT(0, "per-cluster", &perf_stat.aggr_mode,
-		     "aggregate counts perf processor cluster", AGGR_CLUSTER),
-	OPT_CALLBACK_OPTARG(0, "per-cache", &perf_stat.aggr_mode, &perf_stat.aggr_level,
-			    "cache level",
-			    "aggregate count at this cache level (Default: LLC)",
+	OPT_BOOLEAN(0, "per-thread", &opt_mode.thread, "aggregate counts per thread"),
+	OPT_BOOLEAN(0, "per-socket", &opt_mode.socket,
+		    "aggregate counts per processor socket"),
+	OPT_BOOLEAN(0, "per-die", &opt_mode.die, "aggregate counts per processor die"),
+	OPT_BOOLEAN(0, "per-cluster", &opt_mode.cluster,
+		    "aggregate counts per processor cluster"),
+	OPT_CALLBACK_OPTARG(0, "per-cache", &opt_mode.cache, &perf_stat.aggr_level,
+			    "cache level", "aggregate count at this cache level (Default: LLC)",
 			    parse_cache_level),
-	OPT_SET_UINT(0, "per-core", &perf_stat.aggr_mode,
-		     "aggregate counts per physical processor core", AGGR_CORE),
-	OPT_SET_UINT(0, "per-node", &perf_stat.aggr_mode,
-		     "aggregate counts per numa node", AGGR_NODE),
-	OPT_SET_UINT('A', "no-aggr", &perf_stat.aggr_mode,
-		     "disable CPU count aggregation", AGGR_NONE),
+	OPT_BOOLEAN(0, "per-core", &opt_mode.core,
+		    "aggregate counts per physical processor core"),
+	OPT_BOOLEAN(0, "per-node", &opt_mode.node, "aggregate counts per numa node"),
+	OPT_BOOLEAN('A', "no-aggr", &opt_mode.no_aggr,
+		    "disable aggregation across CPUs or PMUs"),
 	OPT_END()
 	};
 	struct stat st;
@@ -2341,6 +2340,10 @@ static int __cmd_report(int argc, const char **argv)
 
 	argc = parse_options(argc, argv, options, stat_report_usage, 0);
 
+	perf_stat.aggr_mode = opt_aggr_mode_to_aggr_mode(&opt_mode);
+	if (perf_stat.aggr_mode == AGGR_GLOBAL)
+		perf_stat.aggr_mode = AGGR_UNSET; /* No option found so leave unset. */
+
 	if (!input_name || !strlen(input_name)) {
 		if (!fstat(STDIN_FILENO, &st) && S_ISFIFO(st.st_mode))
 			input_name = "-";
@@ -2490,7 +2493,7 @@ int cmd_stat(int argc, const char **argv)
 		OPT_BOOLEAN(0, "per-die", &opt_mode.die, "aggregate counts per processor die"),
 		OPT_BOOLEAN(0, "per-cluster", &opt_mode.cluster,
 			"aggregate counts per processor cluster"),
-		OPT_CALLBACK_OPTARG(0, "per-cache", &opt_mode, &stat_config.aggr_level,
+		OPT_CALLBACK_OPTARG(0, "per-cache", &opt_mode.cache, &stat_config.aggr_level,
 				"cache level", "aggregate count at this cache level (Default: LLC)",
 				parse_cache_level),
 		OPT_BOOLEAN(0, "per-core", &opt_mode.core,
-- 
2.53.0




