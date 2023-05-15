Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDCD7034E9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243224AbjEOQyG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243136AbjEOQxd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:53:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50435B82
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:53:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9659161FEE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF5EC433EF;
        Mon, 15 May 2023 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169590;
        bh=UMnLezGPkGwWIs7shz8Bgq0qRM3AuPB2jUwSIBLR+V8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1xhfvtV+q9IrI4MsZs9/5RoYEMAdYFahDcnnZ6Lc1cplaBes6WLr8vHPvB+AvCqmU
         txWFqEXPzDWJiZCzNoNaslXsIWo3r0vEd9nA20lb/aFxqkmrP+j1P+2BaHRPwDnjau
         NKJuUdsl9AgVs0bd4F54VsBYNMTL916Y/MK97JRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 106/246] perf hist: Improve srcfile sort key performance (really)
Date:   Mon, 15 May 2023 18:25:18 +0200
Message-Id: <20230515161725.760183309@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 6094c7744bb0563e833e81d8df8513f9a4e7a257 ]

The earlier commit f0cdde28fecc0d7f ("perf hist: Improve srcfile sort
key performance") updated the srcfile logic but missed to change the
->cmp() callback which is called for every sample.

It should use the same logic like in the srcline to speed up the
processing because it'd return the same information repeatedly for the
same address.  The real processing will be done in
sort__srcfile_collapse().

Fixes: f0cdde28fecc0d7f ("perf hist: Improve srcfile sort key performance")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230323025005.191239-1-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/sort.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 093a0c8b2e3d3..4d6a51b1c1b2e 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -611,12 +611,7 @@ static char *hist_entry__get_srcfile(struct hist_entry *e)
 static int64_t
 sort__srcfile_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	if (!left->srcfile)
-		left->srcfile = hist_entry__get_srcfile(left);
-	if (!right->srcfile)
-		right->srcfile = hist_entry__get_srcfile(right);
-
-	return strcmp(right->srcfile, left->srcfile);
+	return sort__srcline_cmp(left, right);
 }
 
 static int64_t
-- 
2.39.2



