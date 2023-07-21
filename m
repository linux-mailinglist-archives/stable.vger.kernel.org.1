Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DE975D289
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjGUTAk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjGUTAk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:00:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0AE30CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:00:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBE88619FD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBC2C433CB;
        Fri, 21 Jul 2023 19:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966038;
        bh=NLNQ2JMsy6VR6VkfnbJTY33aqgxbF5/hKavkVQhBUHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MI5rYeqq3JQPtVGMHgJMfn+S4aFs/S9V19rztOUF513AH3TJ9toXY9PThWVY0StrN
         Nm/TkKhRffEDReB/m47Yzbw5FnyyO2yZVNzQu3xdx0c3oFMzNlufLw+pf8KFiLPKFg
         M5PD4GwBNpOplJrDdHnv8myKV/ueMfpCXDiAiQGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
        Andre Fredette <anfredet@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Dave Tucker <datucker@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Derek Barbosa <debarbos@redhat.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 203/532] perf bench: Add missing setlocale() call to allow usage of %d style formatting
Date:   Fri, 21 Jul 2023 18:01:47 +0200
Message-ID: <20230721160625.411766429@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 16203e9cd01896b4244100a8e3fb9f6e612ab2b1 ]

Without this we were not getting the thousands separator for big
numbers.

Noticed while developing 'perf bench uprobe', but the use of %' predates
that, for instance 'perf bench syscall' uses it.

Before:

  # perf bench uprobe all
  # Running uprobe/baseline benchmark...
  # Executed 1000 usleep(1000) calls
       Total time: 1054082243ns

   1054082.243000 nsecs/op

  #

After:

  # perf bench uprobe all
  # Running uprobe/baseline benchmark...
  # Executed 1,000 usleep(1000) calls
       Total time: 1,053,715,144ns

   1,053,715.144000 nsecs/op

  #

Fixes: c2a08203052f8975 ("perf bench: Add basic syscall benchmark")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andre Fredette <anfredet@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Dave Tucker <datucker@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Link: https://lore.kernel.org/lkml/ZH3lcepZ4tBYr1jv@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-bench.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index d291f3a8af5f2..ac72bcccc353b 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -21,6 +21,7 @@
 #include "builtin.h"
 #include "bench/bench.h"
 
+#include <locale.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -248,6 +249,7 @@ int cmd_bench(int argc, const char **argv)
 
 	/* Unbuffered output */
 	setvbuf(stdout, NULL, _IONBF, 0);
+	setlocale(LC_ALL, "");
 
 	if (argc < 2) {
 		/* No collection specified. */
-- 
2.39.2



