Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E147ED386
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjKOUxN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbjKOUxN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:53:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8780C1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:53:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F728C4E779;
        Wed, 15 Nov 2023 20:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081589;
        bh=Pz2vMYgu80hpLTWfdEp6w47PXgHvRfQwhBsWwsfVHjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0f6KpGmGq0XYdnCK/70251xMIf50u6B/yoI+rlwo/Ta5odRc3vqfhLtdeIU+g7esL
         JSzM2s5Y7/++VakkdKSevpX5f93SaCTZVlHO9LoBDcaXZGLMyxCzqR0UFhyjVtWexJ
         4b4aopEIS0TZAUHduArJb1zsuLYYeGy7oYob52Nc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 224/244] selftests: pmtu.sh: fix result checking
Date:   Wed, 15 Nov 2023 15:36:56 -0500
Message-ID: <20231115203601.786398795@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index da6ab300207c0..0a9d482c50589 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1880,7 +1880,7 @@ run_test() {
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



