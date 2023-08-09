Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6FC775764
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjHIKpa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHIKp1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:45:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1317310F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DB0E63125
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E9EC433C9;
        Wed,  9 Aug 2023 10:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577926;
        bh=31HqNmphNVvCIARF6+f3rsUCFR54BlZLVf+HFB64Jbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxahGxXVmLUQ0YEszaT3uHgBoDNY3rCiatwXJuumiU2iMDMTSlTAam65/baGb3aLa
         ypTJBB0q2RSoLs9jYtncWIOrVql+1OVZSxL6Ac/LntcFLCDn7Szm9XR8C3sFtiDW6z
         K1cmC+TXojQCRFWF/dQnOgEsga/pRqDi8pan9ZUk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Georg=20M=C3=BCller?= <georgmueller@gmx.net>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 044/165] perf test uprobe_from_different_cu: Skip if there is no gcc
Date:   Wed,  9 Aug 2023 12:39:35 +0200
Message-ID: <20230809103644.263395968@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Georg Müller <georgmueller@gmx.net>

[ Upstream commit 98ce8e4a9dcfb448b30a2d7a16190f4a00382377 ]

Without gcc, the test will fail.

On cleanup, ignore probe removal errors. Otherwise, in case of an error
adding the probe, the temporary directory is not removed.

Fixes: 56cbeacf14353057 ("perf probe: Add test for regression introduced by switch to die_get_decl_file()")
Signed-off-by: Georg Müller <georgmueller@gmx.net>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Georg Müller <georgmueller@gmx.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230728151812.454806-2-georgmueller@gmx.net
Link: https://lore.kernel.org/r/CAP-5=fUP6UuLgRty3t2=fQsQi3k4hDMz415vWdp1x88QMvZ8ug@mail.gmail.com/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
index 00d2e0e2e0c28..319f36ebb9a40 100644
--- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
+++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
@@ -4,6 +4,12 @@
 
 set -e
 
+# skip if there's no gcc
+if ! [ -x "$(command -v gcc)" ]; then
+        echo "failed: no gcc compiler"
+        exit 2
+fi
+
 temp_dir=$(mktemp -d /tmp/perf-uprobe-different-cu-sh.XXXXXXXXXX)
 
 cleanup()
@@ -11,7 +17,7 @@ cleanup()
 	trap - EXIT TERM INT
 	if [[ "${temp_dir}" =~ ^/tmp/perf-uprobe-different-cu-sh.*$ ]]; then
 		echo "--- Cleaning up ---"
-		perf probe -x ${temp_dir}/testfile -d foo
+		perf probe -x ${temp_dir}/testfile -d foo || true
 		rm -f "${temp_dir}/"*
 		rmdir "${temp_dir}"
 	fi
-- 
2.40.1



