Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FADA7A3B9C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240767AbjIQUTs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240776AbjIQUTl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:19:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A886F4
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:19:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EDFC433C7;
        Sun, 17 Sep 2023 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981975;
        bh=lD1Gf/UAwUgi6BCmURQ6ngoMx6ULJ4Xs5n/IfpGVCeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PruzooP5v3JUoF+DJhY93tOAYtnnCwOEkKf19t52XEdkqM1iF0BEk6PiQfJ5axFRY
         Rg8IaeLInsi6cnqTEJeMObkvAX2XnEbBYL7MHmsMZdYwpzH8E8257f8ijVsabOc8e1
         NNcAOz5V0M/QpMTTuxE16/AH8cc5lu9fEq12ESZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 187/219] kselftest/runner.sh: Propagate SIGTERM to runner child
Date:   Sun, 17 Sep 2023 21:15:14 +0200
Message-ID: <20230917191047.707727101@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit 9616cb34b08ec86642b162eae75c5a7ca8debe3c ]

Timeouts in kselftest are done using the "timeout" command with the
"--foreground" option. Without the "foreground" option, it is not
possible for a user to cancel the runner using SIGINT, because the
signal is not propagated to timeout which is running in a different
process group. The "forground" options places the timeout in the same
process group as its parent, but only sends the SIGTERM (on timeout)
signal to the forked process. Unfortunately, this does not play nice
with all kselftests, e.g. "net:fcnal-test.sh", where the child
processes will linger because timeout does not send SIGTERM to the
group.

Some users have noted these hangs [1].

Fix this by nesting the timeout with an additional timeout without the
foreground option.

Link: https://lore.kernel.org/all/7650b2eb-0aee-a2b0-2e64-c9bc63210f67@alu.unizg.hr/ # [1]
Fixes: 651e0d881461 ("kselftest/runner: allow to properly deliver signals to tests")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/kselftest/runner.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 294619ade49fe..1333ab1eda708 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -35,7 +35,8 @@ tap_timeout()
 {
 	# Make sure tests will time out if utility is available.
 	if [ -x /usr/bin/timeout ] ; then
-		/usr/bin/timeout --foreground "$kselftest_timeout" $1
+		/usr/bin/timeout --foreground "$kselftest_timeout" \
+			/usr/bin/timeout "$kselftest_timeout" $1
 	else
 		$1
 	fi
-- 
2.40.1



