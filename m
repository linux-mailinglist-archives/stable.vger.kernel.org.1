Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F382F7ECF6B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjKOTsV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbjKOTsU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:48:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61ED1A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:48:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690EEC433C9;
        Wed, 15 Nov 2023 19:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077697;
        bh=CYhmPOMtVLLEkXLAwzyBcKCAOmSyh5m1Fh0ANHV/uWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yf5wf0T+f9HsVbbEytDElvP0rTrxVBGBgeuLpxwFZUpRobJJ22WDTh+VQkfErHckJ
         JvruVFz8DZrIwkxL/auVQHCDCIkvX/HCcG+j8h86xxwSm8eW6UEqOUZWos+MhV8tYv
         6uEIPhQinK6r+OqbDZmfVYvOpEfBYZqaCa4IDsvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 462/603] perf parse-events: Fix for term values that are raw events
Date:   Wed, 15 Nov 2023 14:16:47 -0500
Message-ID: <20231115191644.556021134@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

[ Upstream commit b20576fd7fe39554b212095c3c0d7a3dff512515 ]

Raw events can be strings like 'r0xead' but the 0x is optional so they
can also be 'read'. On IcelakeX uncore_imc_free_running has an event
called 'read' which may be programmed as:
```
$ perf stat -e 'uncore_imc_free_running/event=read/' -a sleep 1
```
However, the PE_RAW type isn't allowed on the right of a term, even
though in this case we just want to interpret it as a string. This
leads to the following error on IcelakeX:
```
$ perf stat -e 'uncore_imc_free_running/event=read/' -a sleep 1
event syntax error: '..nning/event=read/'
                                  \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event> event selector. use 'perf list' to list available events
```
Fix this by allowing raw types on the right of terms and treat them as
strings, just as is already done for PE_LEGACY_CACHE. Make this
consistent by just entirely removing name_or_legacy and always using
name_or_raw that covers all three cases.

Fixes: 6fd1e5191591 ("perf parse-events: Support PMUs for legacy cache events")
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@arm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20230928004431.1926969-1-irogers@google.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/parse-events.y | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index da9aac47972c1..c3a86ef4b7cf3 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -79,7 +79,7 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_MODIFIER_BP
 %type <str> PE_EVENT_NAME
 %type <str> PE_DRV_CFG_TERM
-%type <str> name_or_raw name_or_legacy
+%type <str> name_or_raw
 %destructor { free ($$); } <str>
 %type <term> event_term
 %destructor { parse_events_term__delete ($$); } <term>
@@ -680,8 +680,6 @@ event_term
 
 name_or_raw: PE_RAW | PE_NAME | PE_LEGACY_CACHE
 
-name_or_legacy: PE_NAME | PE_LEGACY_CACHE
-
 event_term:
 PE_RAW
 {
@@ -696,7 +694,7 @@ PE_RAW
 	$$ = term;
 }
 |
-name_or_raw '=' name_or_legacy
+name_or_raw '=' name_or_raw
 {
 	struct parse_events_term *term;
 	int err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER, $1, $3, &@1, &@3);
@@ -776,7 +774,7 @@ PE_TERM_HW
 	$$ = term;
 }
 |
-PE_TERM '=' name_or_legacy
+PE_TERM '=' name_or_raw
 {
 	struct parse_events_term *term;
 	int err = parse_events_term__str(&term, (enum parse_events__term_type)$1,
-- 
2.42.0



