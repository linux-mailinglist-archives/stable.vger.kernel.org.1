Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC077A300E
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbjIPM1e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239333AbjIPM1M (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:27:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6024CF2
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:27:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEE3C433C7;
        Sat, 16 Sep 2023 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867226;
        bh=BpQP2iKb4pJSrgd9/Gx9Pk3FMMNOB18++O6dAxcpsu0=;
        h=Subject:To:Cc:From:Date:From;
        b=2UqW+L4x2jyaZkHJjEs8S04k6Rq8+2EBvLdlX6FlJHSFqS09mM3p0io0fCNzC6Ox8
         298rjos+vUClcMmquSZy5rpLWkzbXM6XFvtW9ZJrzUiyNaLp0f82jJAftYJjZw/Aov
         yOiwm94/rhvTkPM/ciA8h2BkD/Pi83CR55n8wbeQ=
Subject: FAILED: patch "[PATCH] perf build: Update build rule for generated files" failed to apply to 5.4-stable tree
To:     namhyung@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        ak@linux.intel.com, anupnewsmail@gmail.com, irogers@google.com,
        jolsa@kernel.org, mingo@kernel.org, peterz@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:26:59 +0200
Message-ID: <2023091659-apricot-cartel-9e93@gregkh>
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7822a8913f4c51c7d1aff793b525d60c3384fb5b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091659-apricot-cartel-9e93@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

7822a8913f4c ("perf build: Update build rule for generated files")
00facc760903 ("perf jevents: Switch build to use jevents.py")
0d1c50ac488e ("perf tools: Add an option to build without libbfd")
517db3b59537 ("perf jevents: Make build dependency on test JSONs")
e71e19a9ea70 ("tools features: Add feature test to check if libbfd has buildid support")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7822a8913f4c51c7d1aff793b525d60c3384fb5b Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 27 Jul 2023 19:24:46 -0700
Subject: [PATCH] perf build: Update build rule for generated files

The bison and flex generate C files from the source (.y and .l)
files.  When O= option is used, they are saved in a separate directory
but the default build rule assumes the .C files are in the source
directory.  So it might read invalid file if there are generated files
from an old version.  The same is true for the pmu-events files.

For example, the following command would cause a build failure:

  $ git checkout v6.3
  $ make -C tools/perf  # build in the same directory

  $ git checkout v6.5-rc2
  $ mkdir build  # create a build directory
  $ make -C tools/perf O=build  # build in a different directory but it
                                # refers files in the source directory

Let's update the build rule to specify those cases explicitly to depend
on the files in the output directory.

Note that it's not a complete fix and it needs the next patch for the
include path too.

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
Link: https://lore.kernel.org/r/20230728022447.1323563-1-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index 89430338a3d9..fac42486a8cf 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -117,6 +117,16 @@ $(OUTPUT)%.s: %.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_s_c)
 
+# bison and flex files are generated in the OUTPUT directory
+# so it needs a separate rule to depend on them properly
+$(OUTPUT)%-bison.o: $(OUTPUT)%-bison.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,$(host)cc_o_c)
+
+$(OUTPUT)%-flex.o: $(OUTPUT)%-flex.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,$(host)cc_o_c)
+
 # Gather build data:
 #   obj-y        - list of build objects
 #   subdir-y     - list of directories to nest
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 150765f2baee..1d18bb89402e 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -35,3 +35,9 @@ $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_L
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
 endif
+
+# pmu-events.c file is generated in the OUTPUT directory so it needs a
+# separate rule to depend on it properly
+$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)

