Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E6977ACBA
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjHMVgY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjHMVgX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF55810DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D49062D18
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717B6C433C8;
        Sun, 13 Aug 2023 21:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962584;
        bh=au87tlTGG3kVmUHDd/aOS7tzJPnWfRwjIyLp+gnphwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9bNfuT6F8d2ekEY/o6UJGljV6SMEBvym6OTjkWNXLI4fldKcjCRmr5LWHX8gRp/d
         C9qaczDtM5DhVTffeGd9YWrF4BywwaS6AUUibq5kLI8t8sVVmHnzxqKL+TTbcI6TQe
         q/HAKn4LuouK6i6MsMRjGszg/28vyn1CeQut20TI=
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
Subject: [PATCH 6.1 082/149] selftests: forwarding: tc_flower: Relax success criterion
Date:   Sun, 13 Aug 2023 23:18:47 +0200
Message-ID: <20230813211721.248758881@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ido Schimmel <idosch@nvidia.com>

commit 9ee37e53e7687654b487fc94e82569377272a7a8 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/forwarding/tc_flower.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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


