Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682C7787240
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbjHXOv5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241791AbjHXOvx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:51:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38131BE
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3892B64452
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F79C433C8;
        Thu, 24 Aug 2023 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888710;
        bh=RE0ONZxMGwhzsQHQH0vPTB/Bvp+DUQuTuLscugafPPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/lhZnUldv6goIGb5Dl0sE1v+Pbjhp4SCOop0PNONkn/kaqZfZ+2MmAXXeEqsKiIx
         CNP6+QTOKJ/4bMWZPCW3dBqTVy9W5cma2IXk9+32DWq0e02DSjMfyMvmosoDus2FiL
         38N6z2KpJbry0CEdJr2yaCj64RSQ3jCedg7AOLbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 003/139] selftests: forwarding: tc_actions: Use ncat instead of nc
Date:   Thu, 24 Aug 2023 16:48:46 +0200
Message-ID: <20230824145023.724470419@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 5e8670610b93158ffacc3241f835454ff26a3469 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/forwarding/tc_actions.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index 9c2aca8a4b8de..dd02ed4cacacb 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -8,6 +8,8 @@ NUM_NETIFS=4
 source tc_common.sh
 source lib.sh
 
+require_command ncat
+
 tcflags="skip_hw"
 
 h1_create()
@@ -174,9 +176,9 @@ mirred_egress_to_ingress_tcp_test()
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
-- 
2.40.1



