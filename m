Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A26577A182
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 19:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjHLRvZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 13:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjHLRvZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 13:51:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EC11709
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 10:51:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8D0E61C7B
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 17:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BB6C433C7;
        Sat, 12 Aug 2023 17:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691862687;
        bh=P1s3emojjeqL0bC/tNIa8ipsNXosYVutN/HAU/q3Qyo=;
        h=Subject:To:Cc:From:Date:From;
        b=piftk+dtfkr1DkbWw4/t3wTM6zqUXvm17lWV3NiLU9VWlY1ytV7/Z5GD2NRYcX+9w
         lxGUyNiN6nPolnmv5DTaqEoBEwn8rVfNZy2qNNIvauBtIjmZII3esOJpHBcYkNSfkX
         4+m/pDw8roNXw+GqMYP9bzgKqifqqQwZ/Jq/LpMw=
Subject: FAILED: patch "[PATCH] selftests: forwarding: tc_actions: Use ncat instead of nc" failed to apply to 5.15-stable tree
To:     idosch@nvidia.com, kuba@kernel.org, liuhangbin@gmail.com,
        mirsad.todorovac@alu.unizg.hr, petrm@nvidia.com,
        razor@blackwall.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 19:51:22 +0200
Message-ID: <2023081222-relight-annoying-ed13@gregkh>
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
git cherry-pick -x 5e8670610b93158ffacc3241f835454ff26a3469
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081222-relight-annoying-ed13@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

5e8670610b93 ("selftests: forwarding: tc_actions: Use ncat instead of nc")
f58531716ced ("selftests: forwarding: tc_actions: cleanup temporary files when test is aborted")
ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
1d127effdc17 ("selftests: add a test case for mirred egress to ingress")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e8670610b93158ffacc3241f835454ff26a3469 Mon Sep 17 00:00:00 2001
From: Ido Schimmel <idosch@nvidia.com>
Date: Tue, 8 Aug 2023 17:14:57 +0300
Subject: [PATCH] selftests: forwarding: tc_actions: Use ncat instead of nc

The test relies on 'nc' being the netcat version from the nmap project.
While this seems to be the case on Fedora, it is not the case on Ubuntu,
resulting in failures such as [1].

Fix by explicitly using the 'ncat' utility from the nmap project and the
skip the test in case it is not installed.

[1]
 # timeout set to 0
 # selftests: net/forwarding: tc_actions.sh
 # TEST: gact drop and ok (skip_hw)                                    [ OK ]
 # TEST: mirred egress flower redirect (skip_hw)                       [ OK ]
 # TEST: mirred egress flower mirror (skip_hw)                         [ OK ]
 # TEST: mirred egress matchall mirror (skip_hw)                       [ OK ]
 # TEST: mirred_egress_to_ingress (skip_hw)                            [ OK ]
 # nc: invalid option -- '-'
 # usage: nc [-46CDdFhklNnrStUuvZz] [-I length] [-i interval] [-M ttl]
 #         [-m minttl] [-O length] [-P proxy_username] [-p source_port]
 #         [-q seconds] [-s sourceaddr] [-T keyword] [-V rtable] [-W recvlimit]
 #         [-w timeout] [-X proxy_protocol] [-x proxy_address[:port]]
 #         [destination] [port]
 # nc: invalid option -- '-'
 # usage: nc [-46CDdFhklNnrStUuvZz] [-I length] [-i interval] [-M ttl]
 #         [-m minttl] [-O length] [-P proxy_username] [-p source_port]
 #         [-q seconds] [-s sourceaddr] [-T keyword] [-V rtable] [-W recvlimit]
 #         [-w timeout] [-X proxy_protocol] [-x proxy_address[:port]]
 #         [destination] [port]
 # TEST: mirred_egress_to_ingress_tcp (skip_hw)                        [FAIL]
 #       server output check failed
 # INFO: Could not test offloaded functionality
 not ok 80 selftests: net/forwarding: tc_actions.sh # exit=1

Fixes: ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20230808141503.4060661-12-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index a96cff8e7219..b0f5e55d2d0b 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -9,6 +9,8 @@ NUM_NETIFS=4
 source tc_common.sh
 source lib.sh
 
+require_command ncat
+
 tcflags="skip_hw"
 
 h1_create()
@@ -220,9 +222,9 @@ mirred_egress_to_ingress_tcp_test()
 		ip_proto icmp \
 			action drop
 
-	ip vrf exec v$h1 nc --recv-only -w10 -l -p 12345 -o $mirred_e2i_tf2  &
+	ip vrf exec v$h1 ncat --recv-only -w10 -l -p 12345 -o $mirred_e2i_tf2 &
 	local rpid=$!
-	ip vrf exec v$h1 nc -w1 --send-only 192.0.2.2 12345 <$mirred_e2i_tf1
+	ip vrf exec v$h1 ncat -w1 --send-only 192.0.2.2 12345 <$mirred_e2i_tf1
 	wait -n $rpid
 	cmp -s $mirred_e2i_tf1 $mirred_e2i_tf2
 	check_err $? "server output check failed"

