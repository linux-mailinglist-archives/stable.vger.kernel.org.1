Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB97C7A7F22
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjITMYY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbjITMYU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:24:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242693
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:24:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F04C433C8;
        Wed, 20 Sep 2023 12:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212654;
        bh=9ZL3lwd0NzgeaFin+NgJN+MTixCXbqDjYqWW2IQt3TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czPm1sRjsYOShGEbPG50MBaQoAIgrkcKEXL+jVtSEHWa7jD7f1WZt3xIlcDhXzyG9
         HVRCsM0L8K27qJ4JYzIgOOp9dXpgf+Vexnm01oqAwPwrCl8UYagPU3Oxt0tM4ksA1d
         C0YJkm2Ep6gDHS1MBN/LbOsmjBB2P7dJ9Ajx2N74=
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
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 55/83] perf build: Update build rule for generated files
Date:   Wed, 20 Sep 2023 13:31:45 +0200
Message-ID: <20230920112828.836521956@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
References: <20230920112826.634178162@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 7822a8913f4c51c7d1aff793b525d60c3384fb5b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/build/Makefile.build  | 10 ++++++++++
 tools/perf/pmu-events/Build |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
index cd72016c3cfa7..5a727094ae832 100644
--- a/tools/build/Makefile.build
+++ b/tools/build/Makefile.build
@@ -116,6 +116,16 @@ $(OUTPUT)%.s: %.c FORCE
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
index 5ec5ce8c31bab..ea8c41f9c7398 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -25,3 +25,9 @@ $(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS_PY)
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(SRCARCH) pmu-events/arch $@
 endif
+
+# pmu-events.c file is generated in the OUTPUT directory so it needs a
+# separate rule to depend on it properly
+$(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
-- 
2.40.1



