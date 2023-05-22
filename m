Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3661170C66A
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjEVTRr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjEVTRq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:17:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB490CF
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D2A3627CA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286F8C433EF;
        Mon, 22 May 2023 19:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783058;
        bh=JIVqOOwSWuOCNO6WNW665Eu9nFgLFzCEUZ1bd9gn0gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDmPk+ebL/kuAabEoEvMS9YJ71OS8EGJNRTtutG/LqgO4UY0Mv9kIQhE5sa3cYEKw
         4kWJ8x2wgL2crOBht9rK61k6TsUuydW51VJXdfBFvN2xB88dkhAxKSdm/lqoH2dup0
         UJyY+ukxfy0hN/TK8R1BDfMGkrDrs5zcLrroXk9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 118/203] selftets: seg6: disable rp_filter by default in srv6_end_dt4_l3vpn_test
Date:   Mon, 22 May 2023 20:09:02 +0100
Message-Id: <20230522190358.243741187@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Andrea Mayer <andrea.mayer@uniroma2.it>

[ Upstream commit f97b8401e0deb46ad1e4245c21f651f64f55aaa6 ]

On some distributions, the rp_filter is automatically set (=1) by
default on a netdev basis (also on VRFs).
In an SRv6 End.DT4 behavior, decapsulated IPv4 packets are routed using
the table associated with the VRF bound to that tunnel. During lookup
operations, the rp_filter can lead to packet loss when activated on the
VRF.
Therefore, we chose to make this selftest more robust by explicitly
disabling the rp_filter during tests (as it is automatically set by some
Linux distributions).

Fixes: 2195444e09b4 ("selftests: add selftest for the SRv6 End.DT4 behavior")
Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Tested-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/net/srv6_end_dt4_l3vpn_test.sh  | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
index 37f08d582d2fe..f962823628119 100755
--- a/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_dt4_l3vpn_test.sh
@@ -258,6 +258,12 @@ setup_hs()
 
 	# set the networking for the host
 	ip netns add ${hsname}
+
+	# disable the rp_filter otherwise the kernel gets confused about how
+	# to route decap ipv4 packets.
+	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.all.rp_filter=0
+	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.default.rp_filter=0
+
 	ip -netns ${hsname} link add veth0 type veth peer name ${rtveth}
 	ip -netns ${hsname} link set ${rtveth} netns ${rtname}
 	ip -netns ${hsname} addr add ${IPv4_HS_NETWORK}.${hs}/24 dev veth0
@@ -276,11 +282,6 @@ setup_hs()
 
 	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.${rtveth}.proxy_arp=1
 
-	# disable the rp_filter otherwise the kernel gets confused about how
-	# to route decap ipv4 packets.
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${rtname} sysctl -wq net.ipv4.conf.${rtveth}.rp_filter=0
-
 	ip netns exec ${rtname} sh -c "echo 1 > /proc/sys/net/vrf/strict_mode"
 }
 
-- 
2.39.2



