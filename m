Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D019713DAC
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjE1T1s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjE1T1r (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:27:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007A3C7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:27:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB0361C2F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4E1C433D2;
        Sun, 28 May 2023 19:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302064;
        bh=jES49ybjzaym9a+DhZf3qWrKpvcFrDdD0nUxASV/xhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XI2Mpc2Do5ZOHAksFL+WesiumedPUYvliHgOElW/q20VEzIpQqt2dxhcfCnHc+uwM
         xmEgjr7zZYPaohBxnTz3NBKu+cn7nYlIWGJ+bbYIWgaR6/6oHmHll+Scb4XqELF2Ip
         ydZtffi1ZAb1/TG0MsBZi7PUri597YTrGt2E4zMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Po-Hsu Lin <po-hsu.lin@canonical.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 146/161] selftests: fib_tests: mute cleanup error message
Date:   Sun, 28 May 2023 20:11:10 +0100
Message-Id: <20230528190841.549675445@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Po-Hsu Lin <po-hsu.lin@canonical.com>

commit d226b1df361988f885c298737d6019c863a25f26 upstream.

In the end of the test, there will be an error message induced by the
`ip netns del ns1` command in cleanup()

  Tests passed: 201
  Tests failed:   0
  Cannot remove namespace file "/run/netns/ns1": No such file or directory

This can even be reproduced with just `./fib_tests.sh -h` as we're
calling cleanup() on exit.

Redirect the error message to /dev/null to mute it.

V2: Update commit message and fixes tag.
V3: resubmit due to missing netdev ML in V2

Fixes: b60417a9f2b8 ("selftest: fib_tests: Always cleanup before exit")
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/fib_tests.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -68,7 +68,7 @@ setup()
 cleanup()
 {
 	$IP link del dev dummy0 &> /dev/null
-	ip netns del ns1
+	ip netns del ns1 &> /dev/null
 	ip netns del ns2 &> /dev/null
 }
 


