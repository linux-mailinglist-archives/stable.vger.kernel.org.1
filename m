Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72469703764
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbjEORU5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243903AbjEORUi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F73120AC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F3E62C35
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC256C433D2;
        Mon, 15 May 2023 17:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171097;
        bh=+uYP06R+TB4tHjw/8hOh0muGsWF7sdTRUwAcTu33Iu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEN1C3e7GcTijywlxJ7vnVfSAu9YVS3TRaH0rPBd/UhOIOyTupDXzq1Coe3qdNjYQ
         LbQuBD6CgR3ZFxKVlMhX/KuPtTGGRNDs0mniduZFXRKX3TD16dovl2GJ6OoLavK/dV
         an0u9LKT+iMnegBEcpjrEsRNUjeI6tQJdS9VgyN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Patrice Duroux <patrice.duroux@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 099/242] perf tests record_offcpu.sh: Fix redirection of stderr to stdin
Date:   Mon, 15 May 2023 18:27:05 +0200
Message-Id: <20230515161724.876056025@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Patrice Duroux <patrice.duroux@gmail.com>

[ Upstream commit 9835b742ac3ee16dee361e7ccda8022f99d1cd94 ]

It's not 2&>1, the correct is 2>&1

Fixes: ade1d0307b2fb3d9 ("perf offcpu: Update offcpu test for child process")
Signed-off-by: Patrice Duroux <patrice.duroux@gmail.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20230303193058.21274-1-patrice.duroux@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/record_offcpu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index e01973d4e0fba..f062ae9a95e1a 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -65,7 +65,7 @@ test_offcpu_child() {
 
   # perf bench sched messaging creates 400 processes
   if ! perf record --off-cpu -e dummy -o ${perfdata} -- \
-    perf bench sched messaging -g 10 > /dev/null 2&>1
+    perf bench sched messaging -g 10 > /dev/null 2>&1
   then
     echo "Child task off-cpu test [Failed record]"
     err=1
-- 
2.39.2



