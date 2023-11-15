Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF4B7ECCA0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjKOTbk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjKOTbj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:31:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F03EA4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:31:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D423DC433C9;
        Wed, 15 Nov 2023 19:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076696;
        bh=JDlDc/ZwtiuqjqTgHlupEE6pyzD0DOVZECm4t2A7z+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKRNjKcAJCdzCIyvbKrv6oqrEdMHHkDUKZF1CMoP41nXVwA/OJT0Nz92sxSDRMsyi
         GAh2QuD5eNMXhPnnTYTAUxkuI9pOZpVKJ49XvMoNjRK9xzu0nOuSNolX1++MkeKPik
         x939xmyfkblOV8KB9Q+7Owp2h3pIIsZ7py+nxqxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        He Kuang <hekuang@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 391/550] perf parse-events: Fix tracepoint name memory leak
Date:   Wed, 15 Nov 2023 14:16:15 -0500
Message-ID: <20231115191627.950583297@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit ede72dca45b1893f3e9236b6ad6c4e790db232f6 ]

Fuzzing found that an invalid tracepoint name would create a memory
leak with an address sanitizer build:
```
$ perf stat -e '*:o/' true
event syntax error: '*:o/'
                       \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events

=================================================================
==59380==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 4 byte(s) in 2 object(s) allocated from:
    #0 0x7f38ac07077b in __interceptor_strdup ../../../../src/libsanitizer/asan/asan_interceptors.cpp:439
    #1 0x55f2f41be73b in str util/parse-events.l:49
    #2 0x55f2f41d08e8 in parse_events_lex util/parse-events.l:338
    #3 0x55f2f41dc3b1 in parse_events_parse util/parse-events-bison.c:1464
    #4 0x55f2f410b8b3 in parse_events__scanner util/parse-events.c:1822
    #5 0x55f2f410d1b9 in __parse_events util/parse-events.c:2094
    #6 0x55f2f410e57f in parse_events_option util/parse-events.c:2279
    #7 0x55f2f4427b56 in get_value tools/lib/subcmd/parse-options.c:251
    #8 0x55f2f4428d98 in parse_short_opt tools/lib/subcmd/parse-options.c:351
    #9 0x55f2f4429d80 in parse_options_step tools/lib/subcmd/parse-options.c:539
    #10 0x55f2f442acb9 in parse_options_subcommand tools/lib/subcmd/parse-options.c:654
    #11 0x55f2f3ec99fc in cmd_stat tools/perf/builtin-stat.c:2501
    #12 0x55f2f4093289 in run_builtin tools/perf/perf.c:322
    #13 0x55f2f40937f5 in handle_internal_command tools/perf/perf.c:375
    #14 0x55f2f4093bbd in run_argv tools/perf/perf.c:419
    #15 0x55f2f409412b in main tools/perf/perf.c:535

SUMMARY: AddressSanitizer: 4 byte(s) leaked in 2 allocation(s).
```
Fix by adding the missing destructor.

Fixes: 865582c3f48e ("perf tools: Adds the tracepoint name parsing support")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: He Kuang <hekuang@huawei.com>
Link: https://lore.kernel.org/r/20230914164028.363220-1-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/parse-events.y | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 8b25b964d6962..c4f675f15fa91 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -107,6 +107,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <list_evsel> groups
 %destructor { free_list_evsel ($$); } <list_evsel>
 %type <tracepoint_name> tracepoint_name
+%destructor { free ($$.sys); free ($$.event); } <tracepoint_name>
 %type <hardware_term> PE_TERM_HW
 %destructor { free ($$.str); } <hardware_term>
 
-- 
2.42.0



