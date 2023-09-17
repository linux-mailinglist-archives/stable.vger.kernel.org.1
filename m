Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B547A3A03
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbjIQT5Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbjIQT5S (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:57:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1292F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:57:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD8DC433C7;
        Sun, 17 Sep 2023 19:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980632;
        bh=7jFHej5OV0IpjZoYNVHxM/4YxQbmxAKHaYr7FJRisDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxZ67rO2KAyRtwfr2YLRFlc1qLNlhgjWXyolIr9V7ZXsqasLhaZTfjOnDGjKAZU5G
         qUf2UI8i4P31kAk4jTeWvTzvl1BiUQZKzHuQy6UMn2eSSRCtcNAdj5g5dHE/JwyT9L
         MadlsO8ccTYEHkECWf9Mv2HQVMLfU7MWWgwb6gsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 248/285] kselftest/runner.sh: Propagate SIGTERM to runner child
Date:   Sun, 17 Sep 2023 21:14:08 +0200
Message-ID: <20230917191059.909298225@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 1c952d1401d46..70e0a465e30da 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -36,7 +36,8 @@ tap_timeout()
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



