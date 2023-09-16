Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474C77A301A
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjIPM2g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239343AbjIPM2D (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:28:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF75194
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:27:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9E9C433C7;
        Sat, 16 Sep 2023 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867278;
        bh=PRlvRaaxCIwrCSqGSX9d2MhSkS6koV7k1R9wKxstiNc=;
        h=Subject:To:Cc:From:Date:From;
        b=Vh0mfB7vKbrpmNYNXwNDgLpnBC193qvI2kWNekJVgKqIOXeMbfFkYNSlJTYDQ8zKT
         QpGYgu/fl3xPcigQlCSoyjloZwXT8KKZ8PbC3FlHl+rxuJXOlhcGPsKly7VLwujVFf
         G9Y9A1ecPLpPw72NXz9DyFF1xy7NoINJm6xGdptk=
Subject: FAILED: patch "[PATCH] perf build: Include generated header files properly" failed to apply to 4.19-stable tree
To:     namhyung@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        ak@linux.intel.com, anupnewsmail@gmail.com, irogers@google.com,
        jolsa@kernel.org, mingo@kernel.org, peterz@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:27:47 +0200
Message-ID: <2023091647-cartwheel-shivering-fe02@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x c7e97f215a4ad634b746804679f5937d25f77e29
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091647-cartwheel-shivering-fe02@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

c7e97f215a4a ("perf build: Include generated header files properly")
3d88aec0d42e ("perf pmu: Make parser reentrant")
e293a5e816c0 ("perf pmu: Use relative path for sysfs scan")
eec1131091c8 ("perf pmu: Add perf_pmu__destroy() function")
990a71e904f6 ("perf bpf filter: Introduce basic BPF filter expression")
16cad1d3597d ("perf lock contention: Use lock_stat_find{,new}")
492fef218a66 ("perf lock contention: Factor out lock_contention_get_name()")
d50a79cd0f39 ("perf pmu: Use perf_pmu__open_file() and perf_pmu__scan_file()")
f8ad6018ce3c ("perf pmu: Remove duplication around EVENT_SOURCE_DEVICE_PATH")
acef233b7ca7 ("perf pmu: Add #slots literal support for arm64")
688d2e8de231 ("perf lock contention: Add -l/--lock-addr option")
eca949b2b4ad ("perf lock contention: Implement -t/--threads option for BPF")
fd507d3e359c ("perf lock contention: Add lock_data.h for common data")
378ef0f5d9d7 ("perf build: Use libtraceevent from the system")
616aa32d6f22 ("perf build: Fixes for LIBTRACEEVENT_DYNAMIC")
cc2367eebb0c ("machine: Adopt is_lock_function() from builtin-lock.c")
336b92da1aa4 ("perf tool: Move pmus list variable to a new file")
a3720e969c6d ("perf build: Fix LIBTRACEEVENT_DYNAMIC")
746bd29e348f ("perf build: Use tools/lib headers from install path")
bd560973c5d3 ("perf expr: Tidy hashmap dependency")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c7e97f215a4ad634b746804679f5937d25f77e29 Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 27 Jul 2023 19:24:47 -0700
Subject: [PATCH] perf build: Include generated header files properly

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

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 08ec9aa583e7..8cd561aa606a 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1000,7 +1000,7 @@ such as "arm/cortex-a34".''',
   _args = ap.parse_args()
 
   _args.output_file.write("""
-#include "pmu-events/pmu-events.h"
+#include <pmu-events/pmu-events.h>
 #include "util/header.h"
 #include "util/pmu.h"
 #include <string.h>
diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
index 0b30688d78a7..47f01df658d9 100644
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
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 4814262e3805..7410a165f68b 100644
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
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index ac315e1be2bc..acddb2542b1a 100644
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
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7f984a7f16ca..b6654b9f55d2 100644
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

