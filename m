Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29986755310
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjGPUPA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjGPUO7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:14:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5431C0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6815060E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5FCC433C8;
        Sun, 16 Jul 2023 20:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538495;
        bh=UFqRTG++XGUiJlHcEY3N6u9+wzkqsszNITspIE/UBxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YN22NYb192H9SzMXPi4BsdBMG47EX9VZNFqAILieqP0IP5as9xYECk1iZwdjkSmY8
         NvevVic+nvKnedMTcAhBXY/215Lw3j8I/jDMp8tS+tMup+N9f0JG6NTQqgUxPiVtnL
         7UICpr9JGsHOv9bS+xlnz5ikdnYENSNMtTQxgC6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aditya Gupta <adityag@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linuxppc-dev@lists.ozlabs.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 472/800] perf tests task_analyzer: Fix bad substitution ${$1}
Date:   Sun, 16 Jul 2023 21:45:25 +0200
Message-ID: <20230716195000.043973970@linuxfoundation.org>
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

From: Aditya Gupta <adityag@linux.ibm.com>

[ Upstream commit 5c4396efb53ef07d046a2e9456b240880e0c3076 ]

${$1} gives bad substitution error on sh, bash, and zsh. This seems like
a typo, and this patch modifies it to $1, since that is what it's usage
looks like from wherever `check_exec_0` is called.

This issue due to ${$1} caused all function calls to give error in
`find_str_or_fail` line, and so no test runs completely. But
'perf test "perf script task-analyzer tests"' wrongly reports
that tests passed with the status OK, which is wrong considering
the tests didn't even run completely

Fixes: e8478b84d6ba9ccf ("perf test: add new task-analyzer tests")
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
Cc: Hagen Paul Pfeifer <hagen@jauu.net>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Petar Gligoric <petar.gligoric@rohde-schwarz.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lore.kernel.org/r/20230613164145.50488-16-atrajeev@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/shell/test_task_analyzer.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/test_task_analyzer.sh b/tools/perf/tests/shell/test_task_analyzer.sh
index a98e4ab66040e..6b3343234a6b2 100755
--- a/tools/perf/tests/shell/test_task_analyzer.sh
+++ b/tools/perf/tests/shell/test_task_analyzer.sh
@@ -31,7 +31,7 @@ report() {
 
 check_exec_0() {
 	if [ $? != 0 ]; then
-		report 1 "invokation of ${$1} command failed"
+		report 1 "invocation of $1 command failed"
 	fi
 }
 
-- 
2.39.2



