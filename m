Return-Path: <stable+bounces-250486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCkULUPzDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-250486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:45:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DAF5947E4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA782339E297
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25C36D4E1;
	Wed, 20 May 2026 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLCCLucH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4011E7660;
	Wed, 20 May 2026 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295535; cv=none; b=M9QdTj7fimmsPeRv8Wdtni0DtD5Zxqj57WkUDOmVIht9r0fXaaHx4nZBLHY1kFY+olYmJ0GzFbrHqS4iWK3TVGFzm8WykWyWxEK/g/JhMVD1Gw1dcuGQautK1D752xifhYJuvhCoNTsPdhNVHr4murQQkxzf82fZBpb0pjLi4wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295535; c=relaxed/simple;
	bh=keiPzNqI0NvEf113vPbTL2fVILwwgcckw/r1+mUxDOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdRdBA1MDt29tzEDujuuT+QgVDrOEX6jgLx0o6S8TSPRD9pKx25/mkt6p/44pUweuTc+roQTUM1s4I1+sBVVmIq0r9ozxIYTCbpMFuoq9wtONOXrvtBJqpNRdo8QqQEnBtpCvn32YLupbA2uDWzPBsXqfbDuCD4yu0Z+p3r8aN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLCCLucH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF211F000E9;
	Wed, 20 May 2026 16:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295534;
	bh=/t1pG+HgWT/rixgUBI6kVgI1j4Mxtg6vWaTtbywmBYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gLCCLucH59Us180VGKufH7srXmLyH8BXpAvEPZG6Lgr4cVdTjeASqUzbLU5sOeUsC
	 S6VZKdPtG4gVOKkV9QkvFgS4aCvFheuWMqRl67PAo8TG7rNRmibWkW7N0nwVYgcJId
	 z/v+GGoRp7Wl0h92W+bgNiKVwEonnUpaDwY/Qwkc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0456/1146] tools/rtla: Generate optstring from long options
Date: Wed, 20 May 2026 18:11:46 +0200
Message-ID: <20260520162158.519395485@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250486-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 20DAF5947E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Costa Shulyupin <costa.shul@redhat.com>

[ Upstream commit 4a1cec7450b7159a0ee57403f44460ac4d618b4f ]

getopt_long() processes short and long options independently.
RTLA, like the majority of applications, uses both short and long
variants for each logical option.

Since the val member of struct option holds the letter of the short
variant, the string of short options can be reconstructed from the
array of long options.

Add getopt_auto() to generate optstring from an array of long options,
eliminating the need to maintain separate short option strings.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
Reviewed-by: Wander Lairson Costa <wander@redhat.com>
Link: https://lore.kernel.org/r/20260108095011.2115719-1-costa.shul@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Stable-dep-of: be8058f31b4e ("rtla: Fix segfault on multiple SIGINTs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/src/common.c        | 32 +++++++++++++++++++++++++-
 tools/tracing/rtla/src/common.h        |  2 ++
 tools/tracing/rtla/src/osnoise_hist.c  |  3 +--
 tools/tracing/rtla/src/osnoise_top.c   |  3 +--
 tools/tracing/rtla/src/timerlat_hist.c |  3 +--
 tools/tracing/rtla/src/timerlat_top.c  |  3 +--
 6 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index ceff76a62a30b..f310b0d59ad3e 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -39,6 +39,36 @@ static void set_signals(struct common_params *params)
 	}
 }
 
+/*
+ * getopt_auto - auto-generates optstring from long_options
+ */
+int getopt_auto(int argc, char **argv, const struct option *long_opts)
+{
+	char opts[256];
+	int n = 0;
+
+	for (int i = 0; long_opts[i].name; i++) {
+		if (long_opts[i].val < 32 || long_opts[i].val > 127)
+			continue;
+
+		if (n + 4 >= sizeof(opts))
+			fatal("optstring buffer overflow");
+
+		opts[n++] = long_opts[i].val;
+
+		if (long_opts[i].has_arg == required_argument)
+			opts[n++] = ':';
+		else if (long_opts[i].has_arg == optional_argument) {
+			opts[n++] = ':';
+			opts[n++] = ':';
+		}
+	}
+
+	opts[n] = '\0';
+
+	return getopt_long(argc, argv, opts, long_opts, NULL);
+}
+
 /*
  * common_parse_options - parse common command line options
  *
@@ -69,7 +99,7 @@ int common_parse_options(int argc, char **argv, struct common_params *common)
 	};
 
 	opterr = 0;
-	c = getopt_long(argc, argv, "c:C::Dd:e:H:P:", long_options, NULL);
+	c = getopt_auto(argc, argv, long_options);
 	opterr = 1;
 
 	switch (c) {
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 7602c5593ef5d..d4b3715700be7 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #pragma once
 
+#include <getopt.h>
 #include "actions.h"
 #include "timerlat_u.h"
 #include "trace.h"
@@ -156,6 +157,7 @@ int osnoise_set_stop_us(struct osnoise_context *context, long long stop_us);
 int osnoise_set_stop_total_us(struct osnoise_context *context,
 			      long long stop_total_us);
 
+int getopt_auto(int argc, char **argv, const struct option *long_opts);
 int common_parse_options(int argc, char **argv, struct common_params *common);
 int common_apply_config(struct osnoise_tool *tool, struct common_params *params);
 int top_main_loop(struct osnoise_tool *tool);
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 9d70ea34807ff..5c863e7aad28b 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -506,8 +506,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:E:hp:r:s:S:t::T:01234:5:6:7:",
-				 long_options, NULL);
+		c = getopt_auto(argc, argv, long_options);
 
 		/* detect the end of the options. */
 		if (c == -1)
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index d54d47947fb44..b7aed40fd2164 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -358,8 +358,7 @@ struct common_params *osnoise_top_parse_args(int argc, char **argv)
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:hp:qr:s:S:t::T:0:1:2:3:",
-				 long_options, NULL);
+		c = getopt_auto(argc, argv, long_options);
 
 		/* Detect the end of the options. */
 		if (c == -1)
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4e8c38a61197c..096de8ba3efbb 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -825,8 +825,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:b:E:hi:knp:s:t::T:uU0123456:7:8:9\1\2:\3:",
-				 long_options, NULL);
+		c = getopt_auto(argc, argv, long_options);
 
 		/* detect the end of the options. */
 		if (c == -1)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 284b74773c2b5..27c14aa71a8bc 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -588,8 +588,7 @@ static struct common_params
 		if (common_parse_options(argc, argv, &params->common))
 			continue;
 
-		c = getopt_long(argc, argv, "a:hi:knp:qs:t::T:uU0:1:2:345:6:7:",
-				 long_options, NULL);
+		c = getopt_auto(argc, argv, long_options);
 
 		/* detect the end of the options. */
 		if (c == -1)
-- 
2.53.0




