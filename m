Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DE07352E0
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjFSKjG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFSKjD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:39:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD529D7
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B2C160B33
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC0CC433C8;
        Mon, 19 Jun 2023 10:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171141;
        bh=McbMLBXb1zWa2kv9l4Q/ho1gDz0d6auu5uWwDs9LbZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i3ULuJswcozKq73BRp/lM4z6DF4uPl7lYr0OIng6iWgtg6KkVQicQDTj0rJZtT2JG
         C/eisjQJo3OCMDoV581pI3y21SuAfWkwfpGM0SRmwVMZh2PjpEeQlkzv3dZcV3u2WC
         85OHia1TT1vm88K5HWsCbrkJQ2A6Ia9bZurRIh44=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vlad Buslov <vladbu@nvidia.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 163/187] selftests/tc-testing: Fix SFB db test
Date:   Mon, 19 Jun 2023 12:29:41 +0200
Message-ID: <20230619102205.483497756@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Vlad Buslov <vladbu@nvidia.com>

[ Upstream commit b39d8c41c7a8336ce85c376b5d4906089524a0ae ]

Setting very small value of db like 10ms introduces rounding errors when
converting to/from jiffies on some kernel configs. For example, on 250hz
the actual value will be set to 12ms which causes the test to fail:

 # $ sudo ./tdc.py  -d eth2 -e 3410
 #  -- ns/SubPlugin.__init__
 # Test 3410: Create SFB with db setting
 #
 # All test results:
 #
 # 1..1
 # not ok 1 3410 - Create SFB with db setting
 #         Could not match regex pattern. Verify command output:
 # qdisc sfb 1: root refcnt 2 rehash 600s db 12ms limit 1000p max 25p target 20p increment 0.000503548 decrement 4.57771e-05 penalty_rate 10pps penalty_burst 20p

Set the value to 100ms instead which currently seem to work on 100hz,
250hz, 300hz and 1000hz kernel configs.

Fixes: 6ad92dc56fca ("selftests/tc-testing: add selftests for sfb qdisc")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json
index ba2f5e79cdbfe..e21c7f22c6d4c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfb.json
@@ -58,10 +58,10 @@
         "setup": [
             "$IP link add dev $DUMMY type dummy || /bin/true"
         ],
-        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb db 10",
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfb db 100",
         "expExitCode": "0",
         "verifyCmd": "$TC qdisc show dev $DUMMY",
-        "matchPattern": "qdisc sfb 1: root refcnt [0-9]+ rehash 600s db 10ms",
+        "matchPattern": "qdisc sfb 1: root refcnt [0-9]+ rehash 600s db 100ms",
         "matchCount": "1",
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root",
-- 
2.39.2



