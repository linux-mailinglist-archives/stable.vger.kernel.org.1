Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040C0755315
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjGPUPS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjGPUPL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:15:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6EC1BE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:15:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D15E60EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333D2C433C7;
        Sun, 16 Jul 2023 20:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538509;
        bh=NamyjZLwDGs2YaSjbnqfaM1hm3x8cLrwCYMrFZaDtyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bI3ss0l5tbY6MOw3rSvwYeR+LQkEUT7DYjgIXPCtMW0koZH1Gywfc2squ9USaaI7H
         Q+gGx5SayE0SDIxOM0Lq7jm+q8BsI/ca0WV3DfduuuxWTQlGhkSf1wdBvBasIXy42T
         RA3/XzdlPzTN6fHAD5MbC9sPirssjItdsAuA3piE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 476/800] perf tool x86: Fix perf_env memory leak
Date:   Sun, 16 Jul 2023 21:45:29 +0200
Message-ID: <20230716195000.135889785@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ian Rogers <irogers@google.com>

[ Upstream commit 99d4850062a84564f36923764bb93935ef2ed108 ]

Found by leak sanitizer:
```
==1632594==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 21 byte(s) in 1 object(s) allocated from:
    #0 0x7f2953a7077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x556701d6fbbf in perf_env__read_cpuid util/env.c:369
    #2 0x556701d70589 in perf_env__cpuid util/env.c:465
    #3 0x55670204bba2 in x86__is_amd_cpu arch/x86/util/env.c:14
    #4 0x5567020487a2 in arch__post_evsel_config arch/x86/util/evsel.c:83
    #5 0x556701d8f78b in evsel__config util/evsel.c:1366
    #6 0x556701ef5872 in evlist__config util/record.c:108
    #7 0x556701cd6bcd in test__PERF_RECORD tests/perf-record.c:112
    #8 0x556701cacd07 in run_test tests/builtin-test.c:236
    #9 0x556701cacfac in test_and_print tests/builtin-test.c:265
    #10 0x556701cadddb in __cmd_test tests/builtin-test.c:402
    #11 0x556701caf2aa in cmd_test tests/builtin-test.c:559
    #12 0x556701d3b557 in run_builtin tools/perf/perf.c:323
    #13 0x556701d3bac8 in handle_internal_command tools/perf/perf.c:377
    #14 0x556701d3be90 in run_argv tools/perf/perf.c:421
    #15 0x556701d3c3f8 in main tools/perf/perf.c:537
    #16 0x7f2952a46189 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58

SUMMARY: AddressSanitizer: 21 byte(s) leaked in 1 allocation(s).
```

Fixes: f7b58cbdb3ff36eb ("perf mem/c2c: Add load store event mappings for AMD")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Ravi Bangoria <ravi.bangoria@amd.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20230613235416.1650755-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/arch/x86/util/env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/env.c b/tools/perf/arch/x86/util/env.c
index 33b87f8ac1cc1..3e537ffb1353a 100644
--- a/tools/perf/arch/x86/util/env.c
+++ b/tools/perf/arch/x86/util/env.c
@@ -13,7 +13,7 @@ bool x86__is_amd_cpu(void)
 
 	perf_env__cpuid(&env);
 	is_amd = env.cpuid && strstarts(env.cpuid, "AuthenticAMD") ? 1 : -1;
-
+	perf_env__exit(&env);
 ret:
 	return is_amd >= 1 ? true : false;
 }
-- 
2.39.2



