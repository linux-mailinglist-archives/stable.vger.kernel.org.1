Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A714474C3AD
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjGILfK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjGILfF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:35:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EDF95
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFB5A60BBA
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F1CC433C8;
        Sun,  9 Jul 2023 11:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902503;
        bh=rhn8Prifb1IgWR+qGBsgSWoK6XwEOB7JdbUQVLB1zCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYJpRuMN7txoR9mYVHA8fT7xbiEt32KoBD9OZaIt94MbfOjSl6siyZQ45amb5Tn41
         4sun9SUBHnkUdo0v2Q6ApVm3qacKU9y6lCH0lZHR164TOjqOMRS4omiHEG+E7H2mtH
         VRTV26Dxa5s+/u8w/sVfjBnwfm4vlFvrjMtNBZ/A=
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
Subject: [PATCH 6.3 361/431] perf bench: Add missing setlocale() call to allow usage of %d style formatting
Date:   Sun,  9 Jul 2023 13:15:09 +0200
Message-ID: <20230709111459.633174949@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index 814e9afc86f6e..5efb29a7564af 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -21,6 +21,7 @@
 #include "builtin.h"
 #include "bench/bench.h"
 
+#include <locale.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -258,6 +259,7 @@ int cmd_bench(int argc, const char **argv)
 
 	/* Unbuffered output */
 	setvbuf(stdout, NULL, _IONBF, 0);
+	setlocale(LC_ALL, "");
 
 	if (argc < 2) {
 		/* No collection specified. */
-- 
2.39.2



