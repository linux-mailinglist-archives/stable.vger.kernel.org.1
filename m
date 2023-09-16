Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B277B7A3011
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbjIPM1e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbjIPM1S (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:27:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF2F194
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:27:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADABC433C8;
        Sat, 16 Sep 2023 12:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867232;
        bh=IRCI8kNMGe4NcFiYaFNl6NP8v1qbmp5Zy9cgdveartE=;
        h=Subject:To:Cc:From:Date:From;
        b=OCoiWZhjUa7wgyg96op1nLrfoAtmthwtqZzoMN01kVYJSoESfb5H5wt0ZQPB5B/I8
         98moFYpUu7yI01L8VAGpmBOyABc/RRN92Cd4MgvBySpyBRtLrUgSb2xjlX0m/jSokl
         8MSMrfYTTgzGUCfgjxeKIYvvZCBTrzyym0/cCzyM=
Subject: FAILED: patch "[PATCH] perf build: Update build rule for generated files" failed to apply to 4.14-stable tree
To:     namhyung@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        ak@linux.intel.com, anupnewsmail@gmail.com, irogers@google.com,
        jolsa@kernel.org, mingo@kernel.org, peterz@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:27:01 +0200
Message-ID: <2023091601-concerned-refurbish-854c@gregkh>
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 7822a8913f4c51c7d1aff793b525d60c3384fb5b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091601-concerned-refurbish-854c@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

7822a8913f4c ("perf build: Update build rule for generated files")
00facc760903 ("perf jevents: Switch build to use jevents.py")
0d1c50ac488e ("perf tools: Add an option to build without libbfd")
517db3b59537 ("perf jevents: Make build dependency on test JSONs")
e71e19a9ea70 ("tools features: Add feature test to check if libbfd has buildid support")
74d5f3d06f70 ("tools build: Add capability-related feature detection")
3b1c5d965971 ("tools build: Implement libzstd feature check, LIBZSTD_DIR and NO_LIBZSTD defines")
8a1b1718214c ("perf build: Check what binutils's 'disassembler()' signature to use")
31be9478ed7f ("perf feature detection: Add -lopcodes to feature-libbfd")
a96c03e8cdcf ("tools build: Add test-reallocarray.c to test-all.c to fix the build")
1c3b28fd7ae8 ("perf coresight: Do not test for libopencsd by default")
aa8f9c517ebc ("tools build: Add -lrt to FEATURE_CHECK_LDFLAGS-libaio")
14541b1e7e72 ("perf build: Don't unconditionally link the libbfd feature test to -liberty and -lz")
2a07d814747b ("tools build feature: Check if libaio is available")
531b014e7a2f ("tools: bpf: make use of reallocarray")
174e719439b8 ("Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

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

