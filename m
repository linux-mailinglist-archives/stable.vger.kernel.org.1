Return-Path: <stable+bounces-255980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLC3ETKoGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:40:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E55F9473
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 329643035AB2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE35925F7B9;
	Thu, 28 May 2026 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OS1pS32v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D87313550;
	Thu, 28 May 2026 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000417; cv=none; b=deaXWwBVYr3LVqbhveYe+qEHuQyI1jHpne2DXMcDlLdu1g4J1exUVUgFmol6I1U1JnMwJNbpMbJ4erRMQOndTCTjy4hMC7ii+Z9j2HwBqitqYCIEE1CdGL2vShDehIjhPGgQr8HrkqVNHr8oUsV4wnysi5aqWvunoUwg3obHv5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000417; c=relaxed/simple;
	bh=jD7j3Sam+ejOKrdfRm+3vC2EExSdDhXlWFnwkg9hT28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpzJA5a/nfp4AhczNs87IXKiZyoisdhToa0mxmRCxpNvOF2ZRUQIQzhdNtRE2jxtgjuSu247zWFjPa+NvdCXsMSktRCm7fVCqW6rWzB2vumtgRqKq0pvQ+TabDbJ+1xHSSf2U7rVYNfL/1LUe0+AJmWRy1OTdH9BpJRJ8/j16cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OS1pS32v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20701F000E9;
	Thu, 28 May 2026 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000416;
	bh=vSgJwEfKgQ+jUxK/r4d7qqZHvBRgHetumt4zVEf61ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OS1pS32vUyFFPQ/1c2BTiT5sfwHay4UCfIZ9X6tjMkJ+kNpIv3m1yElSsxV2iNnlc
	 ns8TaOwxlktgz5Uwkz4OJN1z+oFHdCfHae66OrmZyxrMpV3tYiWRuiJCPvjs7k5g1B
	 snBJcJ/vF4aRrjotfVHIvGAtIRQiMg5ye0xxLfBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 010/272] Revert "perf python: Add parse_events function"
Date: Thu, 28 May 2026 21:46:24 +0200
Message-ID: <20260528194629.668898492@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255980-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E02E55F9473
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit 9cd264079fab9867dbc9fbc8a1e521996e3d7212.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/cgroup.c |  2 +-
 tools/perf/util/evsel.c  | 19 +++++--------
 tools/perf/util/evsel.h  |  2 +-
 tools/perf/util/python.c | 61 ----------------------------------------
 4 files changed, 9 insertions(+), 75 deletions(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index fbcc0626f9ce2..0f759dd96db71 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -473,7 +473,7 @@ int evlist__expand_cgroup(struct evlist *evlist, const char *str,
 
 		leader = NULL;
 		evlist__for_each_entry(orig_list, pos) {
-			evsel = evsel__clone(/*dest=*/NULL, pos);
+			evsel = evsel__clone(pos);
 			if (evsel == NULL)
 				goto out_err;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 45a7ed5c7a473..d2965dc49bac2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -332,7 +332,7 @@ static int evsel__copy_config_terms(struct evsel *dst, struct evsel *src)
  * The assumption is that @orig is not configured nor opened yet.
  * So we only care about the attributes that can be set while it's parsed.
  */
-struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
+struct evsel *evsel__clone(struct evsel *orig)
 {
 	struct evsel *evsel;
 
@@ -345,11 +345,7 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 	if (orig->bpf_obj)
 		return NULL;
 
-	if (dest)
-		evsel = dest;
-	else
-		evsel = evsel__new(&orig->core.attr);
-
+	evsel = evsel__new(&orig->core.attr);
 	if (evsel == NULL)
 		return NULL;
 
@@ -399,12 +395,11 @@ struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig)
 	evsel->core.leader = orig->core.leader;
 
 	evsel->max_events = orig->max_events;
-	zfree(&evsel->unit);
-	if (orig->unit) {
-		evsel->unit = strdup(orig->unit);
-		if (evsel->unit == NULL)
-			goto out_err;
-	}
+	free((char *)evsel->unit);
+	evsel->unit = strdup(orig->unit);
+	if (evsel->unit == NULL)
+		goto out_err;
+
 	evsel->scale = orig->scale;
 	evsel->snapshot = orig->snapshot;
 	evsel->per_pkg = orig->per_pkg;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 0e64b9f17f0a6..b23fa3ca88883 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -241,7 +241,7 @@ static inline struct evsel *evsel__new(struct perf_event_attr *attr)
 	return evsel__new_idx(attr, 0);
 }
 
-struct evsel *evsel__clone(struct evsel *dest, struct evsel *orig);
+struct evsel *evsel__clone(struct evsel *orig);
 
 int copy_config_terms(struct list_head *dst, struct list_head *src);
 void free_config_terms(struct list_head *config_terms);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 5060dc801dede..e7f36ea9e2fa1 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -13,7 +13,6 @@
 #include "evsel.h"
 #include "event.h"
 #include "print_binary.h"
-#include "strbuf.h"
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
@@ -1248,60 +1247,6 @@ static PyObject *pyrf__tracepoint(struct pyrf_evsel *pevsel,
 #endif // HAVE_LIBTRACEEVENT
 }
 
-static PyObject *pyrf_evsel__from_evsel(struct evsel *evsel)
-{
-	struct pyrf_evsel *pevsel = PyObject_New(struct pyrf_evsel, &pyrf_evsel__type);
-
-	if (!pevsel)
-		return NULL;
-
-	memset(&pevsel->evsel, 0, sizeof(pevsel->evsel));
-	evsel__init(&pevsel->evsel, &evsel->core.attr, evsel->core.idx);
-
-	evsel__clone(&pevsel->evsel, evsel);
-	return (PyObject *)pevsel;
-}
-
-static PyObject *pyrf_evlist__from_evlist(struct evlist *evlist)
-{
-	struct pyrf_evlist *pevlist = PyObject_New(struct pyrf_evlist, &pyrf_evlist__type);
-	struct evsel *pos;
-
-	if (!pevlist)
-		return NULL;
-
-	memset(&pevlist->evlist, 0, sizeof(pevlist->evlist));
-	evlist__init(&pevlist->evlist, evlist->core.all_cpus, evlist->core.threads);
-	evlist__for_each_entry(evlist, pos) {
-		struct pyrf_evsel *pevsel = (void *)pyrf_evsel__from_evsel(pos);
-
-		evlist__add(&pevlist->evlist, &pevsel->evsel);
-	}
-	return (PyObject *)pevlist;
-}
-
-static PyObject *pyrf__parse_events(PyObject *self, PyObject *args)
-{
-	const char *input;
-	struct evlist evlist = {};
-	struct parse_events_error err;
-	PyObject *result;
-
-	if (!PyArg_ParseTuple(args, "s", &input))
-		return NULL;
-
-	parse_events_error__init(&err);
-	evlist__init(&evlist, NULL, NULL);
-	if (parse_events(&evlist, input, &err)) {
-		parse_events_error__print(&err, input);
-		PyErr_SetFromErrno(PyExc_OSError);
-		return NULL;
-	}
-	result = pyrf_evlist__from_evlist(&evlist);
-	evlist__exit(&evlist);
-	return result;
-}
-
 static PyMethodDef perf__methods[] = {
 	{
 		.ml_name  = "tracepoint",
@@ -1309,12 +1254,6 @@ static PyMethodDef perf__methods[] = {
 		.ml_flags = METH_VARARGS | METH_KEYWORDS,
 		.ml_doc	  = PyDoc_STR("Get tracepoint config.")
 	},
-	{
-		.ml_name  = "parse_events",
-		.ml_meth  = (PyCFunction) pyrf__parse_events,
-		.ml_flags = METH_VARARGS,
-		.ml_doc	  = PyDoc_STR("Parse a string of events and return an evlist.")
-	},
 	{ .ml_name = NULL, }
 };
 
-- 
2.53.0




