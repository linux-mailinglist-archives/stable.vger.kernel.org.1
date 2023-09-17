Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0557A3A16
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbjIQT61 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240316AbjIQT6J (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:58:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B0CEE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:58:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3733FC433C8;
        Sun, 17 Sep 2023 19:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980683;
        bh=3bPN4zzq1NNkyvAeaPF3oSmnaftj5DWe4UYoPAz0Eeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCXLVFOndMcUAn1wNGZOnY0koMItJYhd3PwhFtvdUlRlRc5swBrEWIzsKynEP5JaT
         eLXlLQRAIuFbhe+xhWjdiPacSW8qSo3yVetEupMDDLiA257u8Rd75+b85qlEAwdwDm
         SfJpdbnPdPCAVJaG6oCMZNoLn+FAUViIzIB1njPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.5 236/285] perf build: Include generated header files properly
Date:   Sun, 17 Sep 2023 21:13:56 +0200
Message-ID: <20230917191059.573361717@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

commit c7e97f215a4ad634b746804679f5937d25f77e29 upstream.

The flex and bison generate header files from the source.  When user
specified a build directory with O= option, it'd generate files under
the directory.  The build command has -I option to specify the header
include directory.

But the -I option only affects the files included like <...>.  Let's
change the flex and bison headers to use it instead of "...".

Fixes: 80eeb67fe577aa76 ("perf jevents: Program to convert JSON file")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anup Sharma <anupnewsmail@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230728022447.1323563-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/pmu-events/jevents.py |    2 +-
 tools/perf/util/bpf-filter.c     |    4 ++--
 tools/perf/util/expr.c           |    4 ++--
 tools/perf/util/parse-events.c   |    4 ++--
 tools/perf/util/pmu.c            |    4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -999,7 +999,7 @@ such as "arm/cortex-a34".''',
   _args = ap.parse_args()
 
   _args.output_file.write("""
-#include "pmu-events/pmu-events.h"
+#include <pmu-events/pmu-events.h>
 #include "util/header.h"
 #include "util/pmu.h"
 #include <string.h>
--- a/tools/perf/util/bpf-filter.c
+++ b/tools/perf/util/bpf-filter.c
@@ -9,8 +9,8 @@
 #include "util/evsel.h"
 
 #include "util/bpf-filter.h"
-#include "util/bpf-filter-flex.h"
-#include "util/bpf-filter-bison.h"
+#include <util/bpf-filter-flex.h>
+#include <util/bpf-filter-bison.h>
 
 #include "bpf_skel/sample-filter.h"
 #include "bpf_skel/sample_filter.skel.h"
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -10,8 +10,8 @@
 #include "debug.h"
 #include "evlist.h"
 #include "expr.h"
-#include "expr-bison.h"
-#include "expr-flex.h"
+#include <util/expr-bison.h>
+#include <util/expr-flex.h>
 #include "util/hashmap.h"
 #include "smt.h"
 #include "tsc.h"
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -18,8 +18,8 @@
 #include "debug.h"
 #include <api/fs/tracing_path.h>
 #include <perf/cpumap.h>
-#include "parse-events-bison.h"
-#include "parse-events-flex.h"
+#include <util/parse-events-bison.h>
+#include <util/parse-events-flex.h>
 #include "pmu.h"
 #include "pmus.h"
 #include "asm/bug.h"
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -19,8 +19,8 @@
 #include "evsel.h"
 #include "pmu.h"
 #include "pmus.h"
-#include "pmu-bison.h"
-#include "pmu-flex.h"
+#include <util/pmu-bison.h>
+#include <util/pmu-flex.h>
 #include "parse-events.h"
 #include "print-events.h"
 #include "header.h"


