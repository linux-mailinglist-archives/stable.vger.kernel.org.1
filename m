Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F56C7A8110
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236248AbjITMmW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjITMmW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:42:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027318F
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:42:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E42EC433C8;
        Wed, 20 Sep 2023 12:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213735;
        bh=pL7pJTDvGzoCDKI9M1qX/qyE2pDRnxllN5kR9MhY3Pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FwHyRDdq9OvRmxHKX8OvBVPK4RtZcOE62sGqmq2ucFvt3FXk+RGmoocOzhFwJlkWN
         kKWEn3UR131yznYl6iarYcUUYHM5vr38eacOO6VRF2Oa+gPcnJbG33EmHIjP7YoZpt
         v5KYsRrjPiPtOu5uiVQsNWH331QE54P++2siODts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Jacek Caban <jacek@codeweavers.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Remi Bernon <rbernon@codeweavers.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 346/367] tools features: Add feature test to check if libbfd has buildid support
Date:   Wed, 20 Sep 2023 13:32:03 +0200
Message-ID: <20230920112907.456013815@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit e71e19a9ea70952a53d58a99971820ce6c1794a8 ]

Which is needed by the PE executable support, for instance.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jacek Caban <jacek@codeweavers.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Remi Bernon <rbernon@codeweavers.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 7822a8913f4c ("perf build: Update build rule for generated files")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/build/Makefile.feature              | 2 ++
 tools/build/feature/Makefile              | 4 ++++
 tools/build/feature/test-all.c            | 5 +++++
 tools/build/feature/test-libbfd-buildid.c | 8 ++++++++
 tools/perf/Makefile.config                | 6 ++++++
 5 files changed, 25 insertions(+)
 create mode 100644 tools/build/feature/test-libbfd-buildid.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 1ea26bb8c5791..6714c886940f8 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -42,6 +42,7 @@ FEATURE_TESTS_BASIC :=                  \
         gtk2-infobar                    \
         libaudit                        \
         libbfd                          \
+        libbfd-buildid			\
         libcap                          \
         libelf                          \
         libelf-getphdrnum               \
@@ -110,6 +111,7 @@ FEATURE_DISPLAY ?=              \
          gtk2                   \
          libaudit               \
          libbfd                 \
+         libbfd-buildid		\
          libcap                 \
          libelf                 \
          libnuma                \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 88392219d425e..8104e505efde6 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -15,6 +15,7 @@ FILES=                                          \
          test-hello.bin                         \
          test-libaudit.bin                      \
          test-libbfd.bin                        \
+         test-libbfd-buildid.bin		\
          test-disassembler-four-args.bin        \
          test-reallocarray.bin			\
          test-libbfd-liberty.bin                \
@@ -223,6 +224,9 @@ $(OUTPUT)test-libpython.bin:
 $(OUTPUT)test-libbfd.bin:
 	$(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
 
+$(OUTPUT)test-libbfd-buildid.bin:
+	$(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
+
 $(OUTPUT)test-disassembler-four-args.bin:
 	$(BUILD) -DPACKAGE='"perf"' -lbfd -lopcodes
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 6eaeaf2da36ea..039bd2fbe7d9e 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -90,6 +90,10 @@
 # include "test-libbfd.c"
 #undef main
 
+#define main main_test_libbfd_buildid
+# include "test-libbfd-buildid.c"
+#undef main
+
 #define main main_test_backtrace
 # include "test-backtrace.c"
 #undef main
@@ -208,6 +212,7 @@ int main(int argc, char *argv[])
 	main_test_gtk2(argc, argv);
 	main_test_gtk2_infobar(argc, argv);
 	main_test_libbfd();
+	main_test_libbfd_buildid();
 	main_test_backtrace();
 	main_test_libnuma();
 	main_test_numa_num_possible_cpus();
diff --git a/tools/build/feature/test-libbfd-buildid.c b/tools/build/feature/test-libbfd-buildid.c
new file mode 100644
index 0000000000000..157644b04c052
--- /dev/null
+++ b/tools/build/feature/test-libbfd-buildid.c
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <bfd.h>
+
+int main(void)
+{
+	bfd *abfd = bfd_openr("Pedro", 0);
+	return abfd && (!abfd->build_id || abfd->build_id->size > 0x506564726f);
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b94d9afad3f79..cc11050420496 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -775,6 +775,12 @@ else
   $(call feature_check,disassembler-four-args)
 endif
 
+ifeq ($(feature-libbfd-buildid), 1)
+  CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
+else
+  msg := $(warning Old version of libbfd/binutils things like PE executable profiling will not be available);
+endif
+
 ifdef NO_DEMANGLE
   CFLAGS += -DNO_DEMANGLE
 else
-- 
2.40.1



