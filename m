Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071F47A3CEC
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbjIQUgw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241187AbjIQUgj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:36:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AD9101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:36:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693D4C433C8;
        Sun, 17 Sep 2023 20:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982994;
        bh=V1csM/M+nyVVTIhFc5XhEaVmVR9iBSGJjHN6vjx3DVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDPhGs3NbPP8TWqYh6PabLGCsddVAY+st8IeZzIGsQVN4iarVhAdfCQWSOMcwpSHf
         tOgTJvnBHo1zTbNWxaPVUnFxYLi1BbQKgfArUyjHUhY8av5M2DOfLhW0qmKEHNnA7a
         cIY09ukXqS0JZZc4a/2BLPq6ZP656cp9B9vmtBGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 411/511] perf trace: Use zfree() to reduce chances of use after free
Date:   Sun, 17 Sep 2023 21:13:58 +0200
Message-ID: <20230917191123.708095694@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 9997d5dd177c52017fa0541bf236a4232c8148e6 ]

Do defensive programming by using zfree() to initialize freed pointers
to NULL, so that eventual use after free result in a NULL pointer deref
instead of more subtle behaviour.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Stable-dep-of: 7962ef13651a ("perf trace: Really free the evsel->priv area")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d9ea546850cd6..d912dc878a6e9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2287,7 +2287,7 @@ static void syscall__exit(struct syscall *sc)
 	if (!sc)
 		return;
 
-	free(sc->arg_fmt);
+	zfree(&sc->arg_fmt);
 }
 
 static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
@@ -3129,7 +3129,7 @@ static void evlist__free_syscall_tp_fields(struct evlist *evlist)
 		if (!et || !evsel->tp_format || strcmp(evsel->tp_format->system, "syscalls"))
 			continue;
 
-		free(et->fmt);
+		zfree(&et->fmt);
 		free(et);
 	}
 }
@@ -4748,11 +4748,11 @@ static void trace__exit(struct trace *trace)
 	int i;
 
 	strlist__delete(trace->ev_qualifier);
-	free(trace->ev_qualifier_ids.entries);
+	zfree(&trace->ev_qualifier_ids.entries);
 	if (trace->syscalls.table) {
 		for (i = 0; i <= trace->sctbl->syscalls.max_id; i++)
 			syscall__exit(&trace->syscalls.table[i]);
-		free(trace->syscalls.table);
+		zfree(&trace->syscalls.table);
 	}
 	syscalltbl__delete(trace->sctbl);
 	zfree(&trace->perfconfig_events);
-- 
2.40.1



