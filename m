Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C31F7A38DC
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbjIQTlX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239913AbjIQTlI (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:41:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8915F133
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:41:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA66CC433C8;
        Sun, 17 Sep 2023 19:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979662;
        bh=KPftC77digq9+hl296wzXWoGGKYcLPDo3faO9W6wWyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BD4/l7Zez7MY1bNnkplw9K8YmR/jh77qjohnJ4cCWlzJRp0LFZhjoraoOT3UedMHu
         Ff0TshJt1gFIUUTiDceweUBirLLPvsJcvmS+Gglyy2TBr4UGAGpeqydXlZB/PVgVwe
         JqNxBuSkc46W+MKtGl1y24Ps3Jh/qACxCkbcBvQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.10 378/406] perf hists browser: Fix hierarchy mode header
Date:   Sun, 17 Sep 2023 21:13:52 +0200
Message-ID: <20230917191111.247777426@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

commit e2cabf2a44791f01c21f8d5189b946926e34142e upstream.

The commit ef9ff6017e3c4593 ("perf ui browser: Move the extra title
lines from the hists browser") introduced ui_browser__gotorc_title() to
help moving non-title lines easily.  But it missed to update the title
for the hierarchy mode so it won't print the header line on TUI at all.

  $ perf report --hierarchy

Fixes: ef9ff6017e3c4593 ("perf ui browser: Move the extra title lines from the hists browser")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230731094934.1616495-1-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/ui/browsers/hists.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1778,7 +1778,7 @@ static void hists_browser__hierarchy_hea
 	hists_browser__scnprintf_hierarchy_headers(browser, headers,
 						   sizeof(headers));
 
-	ui_browser__gotorc(&browser->b, 0, 0);
+	ui_browser__gotorc_title(&browser->b, 0, 0);
 	ui_browser__set_color(&browser->b, HE_COLORSET_ROOT);
 	ui_browser__write_nstring(&browser->b, headers, browser->b.width + 1);
 }


