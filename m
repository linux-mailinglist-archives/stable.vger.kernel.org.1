Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7066076149B
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjGYLU4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjGYLUy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:20:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA8E69
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADDCA615FE
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD137C433C8;
        Tue, 25 Jul 2023 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284052;
        bh=bTRPvysFmn/ERxUhLBcFoHp/t1q1YcG9KwC1UG9lQ/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0JuIv5Lkbad515tW13Nm4gYnEvPg7oL93UnGUVofIYDacpd1mdDeBRHxgqHjy3o2I
         6AGVAxXIe6fUN+XLczqZuIChacO/XerE/DVPD8UZ1DOLJQnif0Ccrml1+9ZHpb5z33
         w0OKbKqQ3Z0nGkmMZs2h/UJi16Nc5k8otJiKcM/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 188/509] perf script: Fix allocation of evsel->priv related to per-event dump files
Date:   Tue, 25 Jul 2023 12:42:07 +0200
Message-ID: <20230725104602.328892088@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 36d3e4138e1b6cc9ab179f3f397b5548f8b1eaae ]

When printing output we may want to generate per event files, where the
--per-event-dump option should be used, creating perf.data.EVENT.dump
files instead of printing to stdout.

The callback thar processes event thus expects that evsel->priv->fp
should point to either the per-event FILE descriptor or to stdout.

The a3af66f51bd0bca7 ("perf script: Fix crash because of missing
evsel->priv") changeset fixed a case where evsel->priv wasn't setup,
thus set to NULL, causing a segfault when trying to access
evsel->priv->fp.

But it did it for the non --per-event-dump case by allocating a 'struct
perf_evsel_script' just to set its ->fp to stdout.

Since evsel->priv is only freed when --per-event-dump is used, we ended
up with a memory leak, detected using ASAN.

Fix it by using the same method as perf_script__setup_per_event_dump(),
and reuse that static 'struct perf_evsel_script'.

Also check if evsel_script__new() failed.

Fixes: a3af66f51bd0bca7 ("perf script: Fix crash because of missing evsel->priv")
Reported-by: Ian Rogers <irogers@google.com>
Tested-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: https://lore.kernel.org/lkml/ZH+F0wGAWV14zvMP@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-script.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5651714e527c5..85befbacb2a44 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2146,6 +2146,9 @@ static int process_sample_event(struct perf_tool *tool,
 	return 0;
 }
 
+// Used when scr->per_event_dump is not set
+static struct evsel_script es_stdout;
+
 static int process_attr(struct perf_tool *tool, union perf_event *event,
 			struct evlist **pevlist)
 {
@@ -2154,7 +2157,6 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	struct evsel *evsel, *pos;
 	u64 sample_type;
 	int err;
-	static struct evsel_script *es;
 
 	err = perf_event__process_attr(tool, event, pevlist);
 	if (err)
@@ -2164,14 +2166,13 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	evsel = evlist__last(*pevlist);
 
 	if (!evsel->priv) {
-		if (scr->per_event_dump) {
+		if (scr->per_event_dump) { 
 			evsel->priv = evsel_script__new(evsel, scr->session->data);
-		} else {
-			es = zalloc(sizeof(*es));
-			if (!es)
+			if (!evsel->priv)
 				return -ENOMEM;
-			es->fp = stdout;
-			evsel->priv = es;
+		} else { // Replicate what is done in perf_script__setup_per_event_dump()
+			es_stdout.fp = stdout;
+			evsel->priv = &es_stdout;
 		}
 	}
 
@@ -2455,7 +2456,6 @@ static int perf_script__fopen_per_event_dump(struct perf_script *script)
 static int perf_script__setup_per_event_dump(struct perf_script *script)
 {
 	struct evsel *evsel;
-	static struct evsel_script es_stdout;
 
 	if (script->per_event_dump)
 		return perf_script__fopen_per_event_dump(script);
-- 
2.39.2



