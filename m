Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BDD77ACB8
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjHMVgT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjHMVgS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6E10E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBCB562D32
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D26C433C7;
        Sun, 13 Aug 2023 21:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962579;
        bh=EK7DBH2Lv0CLn59k9VT24GZTjGypqZWmlrlCYx/6Tj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AKFj3J4jAea/yI/+ASsg/WPohddc7iKrEn1Niwe42MQxq2kg0TpUdHEhgKhnIkBFT
         zuIcJFQL876FmTV6LWAq4ZiI8gibVoE88PyskUm1g+QzBA3qwRnZ48w5LRPKf/v/fC
         f6/NZXA13n87OgIBbYEU2RP0u7q0BD3cmXG+sMXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 080/149] selftests: forwarding: Skip test when no interfaces are specified
Date:   Sun, 13 Aug 2023 23:18:45 +0200
Message-ID: <20230813211721.187955328@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ido Schimmel <idosch@nvidia.com>

commit d72c83b1e4b4a36a38269c77a85ff52f95eb0d08 upstream.

As explained in [1], the forwarding selftests are meant to be run with
either physical loopbacks or veth pairs. The interfaces are expected to
be specified in a user-provided forwarding.config file or as command
line arguments. By default, this file is not present and the tests fail:

 # make -C tools/testing/selftests TARGETS=net/forwarding run_tests
 [...]
 TAP version 13
 1..102
 # timeout set to 45
 # selftests: net/forwarding: bridge_igmp.sh
 # Command line is not complete. Try option "help"
 # Failed to create netif
 not ok 1 selftests: net/forwarding: bridge_igmp.sh # exit=1
 [...]

Fix by skipping a test if interfaces are not provided either via the
configuration file or command line arguments.

 # make -C tools/testing/selftests TARGETS=net/forwarding run_tests
 [...]
 TAP version 13
 1..102
 # timeout set to 45
 # selftests: net/forwarding: bridge_igmp.sh
 # SKIP: Cannot create interface. Name not specified
 ok 1 selftests: net/forwarding: bridge_igmp.sh # SKIP

[1] tools/testing/selftests/net/forwarding/README

Fixes: 81573b18f26d ("selftests/net/forwarding: add Makefile to install tests")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/856d454e-f83c-20cf-e166-6dc06cbc1543@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20230808141503.4060661-2-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/forwarding/lib.sh |    5 +++++
 1 file changed, 5 insertions(+)

--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -211,6 +211,11 @@ create_netif_veth()
 	for ((i = 1; i <= NUM_NETIFS; ++i)); do
 		local j=$((i+1))
 
+		if [ -z ${NETIFS[p$i]} ]; then
+			echo "SKIP: Cannot create interface. Name not specified"
+			exit $ksft_skip
+		fi
+
 		ip link show dev ${NETIFS[p$i]} &> /dev/null
 		if [[ $? -ne 0 ]]; then
 			ip link add ${NETIFS[p$i]} type veth \


