Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5F87A38FC
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbjIQTn2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239896AbjIQTm7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:42:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE06DB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:42:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF114C433C8;
        Sun, 17 Sep 2023 19:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979774;
        bh=FpSPxfm3VxP98PpFKXPHPL1zOXRWtlRJWFLPSm5doO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1Yr8iUy09OnBYlJy9/t07bda3s5D710YEpP7DyPNPXKSglbIME85P6aeF0OvMVNW
         5KaDE2iK/GjddkRJiDDpE2eTDWqWh0KlfP4gYbzY5fHFgSHLqHuOcktpFulN5zIRsQ
         QAqydtpFEtnes8/nkMzfJ6yRvMn1D2oZF8tSL+mM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 392/406] kselftest/runner.sh: Propagate SIGTERM to runner child
Date:   Sun, 17 Sep 2023 21:14:06 +0200
Message-ID: <20230917191111.616204672@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index a9ba782d8ca0f..83616f0779a7e 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -33,7 +33,8 @@ tap_timeout()
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



