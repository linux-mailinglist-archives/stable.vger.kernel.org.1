Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30717615C0
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjGYLcn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjGYLcn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66FC11B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D3586168F
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4A0C433C8;
        Tue, 25 Jul 2023 11:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284760;
        bh=SP7FcrL/n/JbIPYcqAj06Y4gPl8RVIcWqAmrAHKcOK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wgqgYw8uqnfLNLT1TcbdUdXYtWWruYoU9O9XAaU8NlUQpei9R2qxBHPh2xhN8HpXu
         9OSRdN6pZCYMH/RAYOTfremYjot7XtSvyTTAbxv2iRSe+6wRSLkLk9ZYnCMENS+WeM
         DL5zcYB8okbxSPLyRHvJI2UnQydMkc7gRAPx3WZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        regressions@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.10 443/509] perf probe: Add test for regression introduced by switch to die_get_decl_file()
Date:   Tue, 25 Jul 2023 12:46:22 +0200
Message-ID: <20230725104614.032741396@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Georg Müller <georgmueller@gmx.net>

commit 56cbeacf143530576905623ac72ae0964f3293a6 upstream.

This patch adds a test to validate that 'perf probe' works for binaries
where DWARF info is split into multiple CUs

Signed-off-by: Georg Müller <georgmueller@gmx.net>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: regressions@lists.linux.dev
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230628084551.1860532-5-georgmueller@gmx.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh |   77 ++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_uprobe_from_different_cu.sh

--- /dev/null
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -0,0 +1,77 @@
+#!/bin/bash
+# test perf probe of function from different CU
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+temp_dir=$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
+
+cleanup()
+{
+	trap - EXIT TERM INT
+	if [[ "${temp_dir}" =~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
+		echo "--- Cleaning up ---"
+		perf probe -x ${temp_dir}/testfile -d foo
+		rm -f "${temp_dir}/"*
+		rmdir "${temp_dir}"
+	fi
+}
+
+trap_cleanup()
+{
+        cleanup
+        exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
+cat > ${temp_dir}/testfile-foo.h << EOF
+struct t
+{
+  int *p;
+  int c;
+};
+
+extern int foo (int i, struct t *t);
+EOF
+
+cat > ${temp_dir}/testfile-foo.c << EOF
+#include "testfile-foo.h"
+
+int
+foo (int i, struct t *t)
+{
+  int j, res = 0;
+  for (j = 0; j < i && j < t->c; j++)
+    res += t->p[j];
+
+  return res;
+}
+EOF
+
+cat > ${temp_dir}/testfile-main.c << EOF
+#include "testfile-foo.h"
+
+static struct t g;
+
+int
+main (int argc, char **argv)
+{
+  int i;
+  int j[argc];
+  g.c = argc;
+  g.p = j;
+  for (i = 0; i < argc; i++)
+    j[i] = (int) argv[i][0];
+  return foo (3, &g);
+}
+EOF
+
+gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
+gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
+gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
+
+perf probe -x ${temp_dir}/testfile --funcs foo
+perf probe -x ${temp_dir}/testfile foo
+
+cleanup


