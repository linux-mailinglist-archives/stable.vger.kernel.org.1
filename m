Return-Path: <stable+bounces-255958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEVzNsCnGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:38:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E26045F92E2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 785E0301DA41
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CEE313550;
	Thu, 28 May 2026 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JB0MghyL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A4F3368B5;
	Thu, 28 May 2026 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000356; cv=none; b=rKoLcaVj7JdF4j6/xLJILBLMuRLdDeolLn3EmFaCjO86gqb/Cj+dmNEAV0GWWJNS3BQHssdy/9wrmi+lxML+wfqhiABTdUaA6RjioQm8UKlVOVo6E2ZKTshxVvQOpIxrJvz0Cmmb8bJ7LEuN7wd5xRCE6lGBikZrOFS9X8H4VMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000356; c=relaxed/simple;
	bh=kGJh7vl0AbnlH9Dx7sxz92R3lW0h4+qggeWsCxX94xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRWGHgwNKULYVj2sEbzOigiBj8SF4E6F4p8kHwW0uGpTWAN3bmb9ImXprG1ORoX9C6bkli+2NRrbi55oEHbJiyQCn0J1EUnpjpK35uBFKJs3I+FfOLcbvDP+x+AA0mgidN3lNZNDvz7FYeqAOfAPDi8ykuBo49pWGqnI6/b6syI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JB0MghyL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F08D1F00A3A;
	Thu, 28 May 2026 20:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000355;
	bh=n3sd6X+pGntHkdpqYCkxBroVDJhhyX2UNa8YsBIRSbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JB0MghyLqgzqlfj7TmeqVh96jFZRLQ56+Fdf3yjUvZg6JjoxNxvCtQ+vRa4S48EOI
	 94mqT9VgeQedSzwE4x19uliob6uoRqcnmotr4NILl3ub6NIvKmYrfwm6OMFlwcWlzm
	 9eK8o/R2JF29oTmd55YkrfGvN93py/ynQaM/b0CU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 008/272] Revert "perf cgroup: Update metric leader in evlist__expand_cgroup"
Date: Thu, 28 May 2026 21:46:22 +0200
Message-ID: <20260528194629.615304873@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255958-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E26045F92E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit d26e31446c0fa96feca0b7701243b42447225d33.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/cgroup.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index e172bcdf7fcb1..fbcc0626f9ce2 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -417,6 +417,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 			  struct rblist *metric_events, bool open_cgroup)
 {
 	struct evlist *orig_list, *tmp_list;
+	struct evsel *pos, *evsel, *leader;
 	struct rblist orig_metric_events;
 	struct cgroup *cgrp = NULL;
 	struct cgroup_name *cn;
@@ -455,7 +456,6 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 		goto out_err;
 
 	list_for_each_entry(cn, &cgroup_list, list) {
-		struct evsel *pos;
 		char *name;
 
 		if (!cn->used)
@@ -471,37 +471,21 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 		if (cgrp == NULL)
 			continue;
 
-		/* copy the list and set to the new cgroup. */
+		leader = NULL;
 		evlist__for_each_entry(orig_list, pos) {
-			struct evsel *evsel = evsel__clone(/*dest=*/NULL, pos);
-
+			evsel = evsel__clone(/*dest=*/NULL, pos);
 			if (evsel == NULL)
 				goto out_err;
 
-			/* stash the copy during the copying. */
-			pos->priv = evsel;
 			cgroup__put(evsel->cgrp);
 			evsel->cgrp = cgroup__get(cgrp);
 
-			evlist__add(tmp_list, evsel);
-		}
-		/* update leader information using stashed pointer to copy. */
-		evlist__for_each_entry(orig_list, pos) {
-			struct evsel *evsel = pos->priv;
-
-			if (evsel__leader(pos))
-				evsel__set_leader(evsel, evsel__leader(pos)->priv);
-
-			if (pos->metric_leader)
-				evsel->metric_leader = pos->metric_leader->priv;
+			if (evsel__is_group_leader(pos))
+				leader = evsel;
+			evsel__set_leader(evsel, leader);
 
-			if (pos->first_wildcard_match)
-				evsel->first_wildcard_match = pos->first_wildcard_match->priv;
+			evlist__add(tmp_list, evsel);
 		}
-		/* the stashed copy is no longer used. */
-		evlist__for_each_entry(orig_list, pos)
-			pos->priv = NULL;
-
 		/* cgroup__new() has a refcount, release it here */
 		cgroup__put(cgrp);
 		nr_cgroups++;
-- 
2.53.0




