Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BB17A3953
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbjIQTrq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbjIQTrc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:47:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5629F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:47:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB0CC433C8;
        Sun, 17 Sep 2023 19:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980046;
        bh=Ne/EzIWFpHLNADhRJYGkpd7boKkCOM9PZTajo9xGbWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0DsAse77nCRuiC5hIpkIw0dHVxvwsedHaFEPkJtE87RWWeSvrzpyLY9mF7tDj8tB
         C7SZyn3vER+uHYLmOseaz4d42yluXxEVx5kcnLO+wRphovl5gMPmPu92pT952ZufSR
         X3RkHUy64ZOAVxwcaMOEizcb8nX/2UqHrWA1HVgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 082/285] perf dlfilter: Initialize addr_location before passing it to thread__find_symbol_fb()
Date:   Sun, 17 Sep 2023 21:11:22 +0200
Message-ID: <20230917191054.545412622@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@kernel.org>

[ Upstream commit 42c6dd9d23019ff339d0aca80a444eb71087050e ]

As thread__find_symbol_fb() will end up calling thread__find_map() and
it in turn will call these on uninitialized memory:

        maps__zput(al->maps);
        map__zput(al->map);
        thread__zput(al->thread);

Fixes: 0dd5041c9a0eaf8c ("perf addr_location: Add init/exit/copy functions")
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20230731091857.10681-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/dlfilter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 46f74b2344dbb..798a53d7e6c9d 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -166,6 +166,7 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
 	if (!thread)
 		return -1;
 
+	addr_location__init(&al);
 	thread__find_symbol_fb(thread, d->sample->cpumode, address, &al);
 
 	al_to_d_al(&al, &d_al);
-- 
2.40.1



