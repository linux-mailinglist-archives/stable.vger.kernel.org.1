Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0BD7ED168
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344146AbjKOUB1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344134AbjKOUB0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:01:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5CEB9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:01:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8B5C433C8;
        Wed, 15 Nov 2023 20:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078482;
        bh=zizf2F2b1K1J427Um8CN4lRqvxahQWgqNDj2iHUbtGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hgPs1Q9l1L39+HKw9Pj+XZsbRxZ3ig/jkh66XFMadIK7PmzOB4J8S6oFs/mp6K71o
         EmJOqWME2QlKjPMj3Yrg9vq3kc8YaeH33M2oNA2/+w62VKCT/wkGj4TW4srQbniPW0
         aJEJ4p1Y3op6zzE5e/oR4XGh4NK7P+BTbAxt6ffI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 348/379] selftests: pmtu.sh: fix result checking
Date:   Wed, 15 Nov 2023 14:27:03 -0500
Message-ID: <20231115192705.735342861@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 63e201916b27260218e528a2f8758be47f99bbf4 ]

In the PMTU test, when all previous tests are skipped and the new test
passes, the exit code is set to 0. However, the current check mistakenly
treats this as an assignment, causing the check to pass every time.

Consequently, regardless of how many tests have failed, if the latest test
passes, the PMTU test will report a pass.

Fixes: 2a9d3716b810 ("selftests: pmtu.sh: improve the test result processing")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/pmtu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index dfe3d287f01d2..0d705fdcf3b76 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -2013,7 +2013,7 @@ run_test() {
 	case $ret in
 		0)
 			all_skipped=false
-			[ $exitcode=$ksft_skip ] && exitcode=0
+			[ $exitcode -eq $ksft_skip ] && exitcode=0
 		;;
 		$ksft_skip)
 			[ $all_skipped = true ] && exitcode=$ksft_skip
-- 
2.42.0



