Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31246755182
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjGPT5Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjGPT5M (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:57:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FD11BE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:57:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD05460E8C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3A6C433C7;
        Sun, 16 Jul 2023 19:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537431;
        bh=k3iiOrVJXgITNWlYC+SOUmYv/rV+nyO1C7AzGsqw/qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsefDlY2HYmXRjbzCAkUifypewDt9CsRjmYDCRdzSZvv3pBGEa7grSeyMO+FQrpHN
         4LWZTKVxcMrF9lEEjqcjp+7DwLT1MXIF/TmMcpHCbGt0i10d9zg0oadS/3CMxmEQ+e
         QutUn902CZZnm7iAxa6yQQGGgrC44XApYKeMtDGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 094/800] selftests/ftace: Fix KTAP output ordering
Date:   Sun, 16 Jul 2023 21:39:07 +0200
Message-ID: <20230716194951.296718367@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 8cd0d8633e2de4e6dd9ddae7980432e726220fdb ]

The KTAP parser I used to test the KTAP output for ftracetest was overly
robust and did not notice that the test number and pass/fail result were
reversed. Fix this.

Fixes: dbcf76390eb9 ("selftests/ftrace: Improve integration with kselftest runner")
Signed-off-by: Mark Brown <broonie@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 2506621e75dfb..cb5f18c06593d 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -301,7 +301,7 @@ ktaptest() { # result comment
     comment="# $comment"
   fi
 
-  echo $CASENO $result $INSTANCE$CASENAME $comment
+  echo $result $CASENO $INSTANCE$CASENAME $comment
 }
 
 eval_result() { # sigval
-- 
2.39.2



