Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2456877A17F
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjHLRuk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 13:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjHLRuk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 13:50:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2901712
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 10:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3DC761C63
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 17:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F94C433C7;
        Sat, 12 Aug 2023 17:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691862642;
        bh=QAWMHBDkWQUvSf/snEqiJW9vuR+qXOopo7gMPdE1aD4=;
        h=Subject:To:Cc:From:Date:From;
        b=oj41FCfqnXRX31fTHxpRsmo6o6qAFqhCVtT88DV3lfcVFOH45jHXnTtpOpiq0lwdg
         vM8Nkpg3OeAkZYVnmY6bAIz8NtQAtSdwzTnXrd6EQGaGBHTfGDiaH0MYrk04rDALOP
         7P6FsyfLf6hUj4jLvbV5pyowBW1Y4pwz0y3lbg1U=
Subject: FAILED: patch "[PATCH] selftests: forwarding: tc_flower: Relax success criterion" failed to apply to 5.15-stable tree
To:     idosch@nvidia.com, kuba@kernel.org, liuhangbin@gmail.com,
        mirsad.todorovac@alu.unizg.hr, petrm@nvidia.com,
        razor@blackwall.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 19:50:31 +0200
Message-ID: <2023081231-copilot-haiku-c10f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9ee37e53e7687654b487fc94e82569377272a7a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081231-copilot-haiku-c10f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

9ee37e53e768 ("selftests: forwarding: tc_flower: Relax success criterion")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9ee37e53e7687654b487fc94e82569377272a7a8 Mon Sep 17 00:00:00 2001
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 8 Aug 2023 17:14:58 +0300
Subject: [PATCH] selftests: forwarding: tc_flower: Relax success criterion

The test checks that filters that match on source or destination MAC
were only hit once. A host can send more than one packet with a given
source or destination MAC, resulting in failures.

Fix by relaxing the success criterion and instead check that the filters
were not hit zero times. Using tc_check_at_least_x_packets() is also an
option, but it is not available in older kernels.

Fixes: 07e5c75184a1 ("selftests: forwarding: Introduce tc flower matching tests")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20230808141503.4060661-13-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/forwarding/tc_flower.sh b/tools/testing/selftests/net/forwarding/tc_flower.sh
index 683711f41aa9..b1daad19b01e 100755
--- a/tools/testing/selftests/net/forwarding/tc_flower.sh
+++ b/tools/testing/selftests/net/forwarding/tc_flower.sh
@@ -52,8 +52,8 @@ match_dst_mac_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
 
-	tc_check_packets "dev $h2 ingress" 102 1
-	check_err $? "Did not match on correct filter"
+	tc_check_packets "dev $h2 ingress" 102 0
+	check_fail $? "Did not match on correct filter"
 
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 	tc filter del dev $h2 ingress protocol ip pref 2 handle 102 flower
@@ -78,8 +78,8 @@ match_src_mac_test()
 	tc_check_packets "dev $h2 ingress" 101 1
 	check_fail $? "Matched on a wrong filter"
 
-	tc_check_packets "dev $h2 ingress" 102 1
-	check_err $? "Did not match on correct filter"
+	tc_check_packets "dev $h2 ingress" 102 0
+	check_fail $? "Did not match on correct filter"
 
 	tc filter del dev $h2 ingress protocol ip pref 1 handle 101 flower
 	tc filter del dev $h2 ingress protocol ip pref 2 handle 102 flower

