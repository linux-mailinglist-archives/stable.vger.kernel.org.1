Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6FA77AC0B
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjHMV2k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjHMV2j (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:28:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FA910DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 586B962A63
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 689DDC433C7;
        Sun, 13 Aug 2023 21:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962119;
        bh=JDkWxroUeAhwSJG0BISP+VpwR8m5IcP8SA77rkNUpHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVxZwoHrUbQBY9Vid7snDauSMsROCGoJI50xcQwsfx3cDDzkaENKs3Wo6LlKU1bbM
         xwr8RIIBmQbEZJDMpkiPnYU1Rgts0TFiL6VUIQHmKgd/kljzO3JAkyZNbCgpOxXp/s
         foep3IlkeIOGvv1hGlhLaxwrMWL0XgdtRN+QLABc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Ido Schimmel <idosch@nvidia.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 119/206] selftests: forwarding: bridge_mdb: Fix failing test with old libnet
Date:   Sun, 13 Aug 2023 23:18:09 +0200
Message-ID: <20230813211728.446596076@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
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

commit e98e195d90cc93b1bf2ad762c7c274a40dab7173 upstream.

As explained in commit 8bcfb4ae4d97 ("selftests: forwarding: Fix failing
tests with old libnet"), old versions of libnet (used by mausezahn) do
not use the "SO_BINDTODEVICE" socket option. For IP unicast packets,
this can be solved by prefixing mausezahn invocations with "ip vrf
exec". However, IP multicast packets do not perform routing and simply
egress the bound device, which does not exist in this case.

Fix by specifying the source and destination MAC of the packet which
will cause mausezahn to use a packet socket instead of an IP socket.

Fixes: b6d00da08610 ("selftests: forwarding: Add bridge MDB test")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20230808141503.4060661-16-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 46 ++++++++++---------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 6f830b5f03c9..4853b8e4f8d3 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -850,6 +850,7 @@ cfg_test()
 __fwd_test_host_ip()
 {
 	local grp=$1; shift
+	local dmac=$1; shift
 	local src=$1; shift
 	local mode=$1; shift
 	local name
@@ -872,27 +873,27 @@ __fwd_test_host_ip()
 	# Packet should only be flooded to multicast router ports when there is
 	# no matching MDB entry. The bridge is not configured as a multicast
 	# router port.
-	$MZ $mode $h1.10 -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
 	tc_check_packets "dev br0 ingress" 1 0
 	check_err $? "Packet locally received after flood"
 
 	# Install a regular port group entry and expect the packet to not be
 	# locally received.
 	bridge mdb add dev br0 port $swp2 grp $grp temp vid 10
-	$MZ $mode $h1.10 -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
 	tc_check_packets "dev br0 ingress" 1 0
 	check_err $? "Packet locally received after installing a regular entry"
 
 	# Add a host entry and expect the packet to be locally received.
 	bridge mdb add dev br0 port br0 grp $grp temp vid 10
-	$MZ $mode $h1.10 -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
 	tc_check_packets "dev br0 ingress" 1 1
 	check_err $? "Packet not locally received after adding a host entry"
 
 	# Remove the host entry and expect the packet to not be locally
 	# received.
 	bridge mdb del dev br0 port br0 grp $grp vid 10
-	$MZ $mode $h1.10 -c 1 -p 128 -A $src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $src -B $grp -t udp -q
 	tc_check_packets "dev br0 ingress" 1 1
 	check_err $? "Packet locally received after removing a host entry"
 
@@ -905,8 +906,8 @@ __fwd_test_host_ip()
 
 fwd_test_host_ip()
 {
-	__fwd_test_host_ip "239.1.1.1" "192.0.2.1" "-4"
-	__fwd_test_host_ip "ff0e::1" "2001:db8:1::1" "-6"
+	__fwd_test_host_ip "239.1.1.1" "01:00:5e:01:01:01" "192.0.2.1" "-4"
+	__fwd_test_host_ip "ff0e::1" "33:33:00:00:00:01" "2001:db8:1::1" "-6"
 }
 
 fwd_test_host_l2()
@@ -966,6 +967,7 @@ fwd_test_host()
 __fwd_test_port_ip()
 {
 	local grp=$1; shift
+	local dmac=$1; shift
 	local valid_src=$1; shift
 	local invalid_src=$1; shift
 	local mode=$1; shift
@@ -999,43 +1001,43 @@ __fwd_test_port_ip()
 		vlan_ethtype $eth_type vlan_id 10 dst_ip $grp \
 		src_ip $invalid_src action drop
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 1 0
 	check_err $? "Packet from valid source received on H2 before adding entry"
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 2 0
 	check_err $? "Packet from invalid source received on H2 before adding entry"
 
 	bridge mdb add dev br0 port $swp2 grp $grp vid 10 \
 		filter_mode $filter_mode source_list $src_list
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 1 1
 	check_err $? "Packet from valid source not received on H2 after adding entry"
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 2 0
 	check_err $? "Packet from invalid source received on H2 after adding entry"
 
 	bridge mdb replace dev br0 port $swp2 grp $grp vid 10 \
 		filter_mode exclude
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 1 2
 	check_err $? "Packet from valid source not received on H2 after allowing all sources"
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 2 1
 	check_err $? "Packet from invalid source not received on H2 after allowing all sources"
 
 	bridge mdb del dev br0 port $swp2 grp $grp vid 10
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $valid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $valid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 1 2
 	check_err $? "Packet from valid source received on H2 after deleting entry"
 
-	$MZ $mode $h1.10 -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
+	$MZ $mode $h1.10 -a own -b $dmac -c 1 -p 128 -A $invalid_src -B $grp -t udp -q
 	tc_check_packets "dev $h2 ingress" 2 1
 	check_err $? "Packet from invalid source received on H2 after deleting entry"
 
@@ -1047,11 +1049,11 @@ __fwd_test_port_ip()
 
 fwd_test_port_ip()
 {
-	__fwd_test_port_ip "239.1.1.1" "192.0.2.1" "192.0.2.2" "-4" "exclude"
-	__fwd_test_port_ip "ff0e::1" "2001:db8:1::1" "2001:db8:1::2" "-6" \
+	__fwd_test_port_ip "239.1.1.1" "01:00:5e:01:01:01" "192.0.2.1" "192.0.2.2" "-4" "exclude"
+	__fwd_test_port_ip "ff0e::1" "33:33:00:00:00:01" "2001:db8:1::1" "2001:db8:1::2" "-6" \
 		"exclude"
-	__fwd_test_port_ip "239.1.1.1" "192.0.2.1" "192.0.2.2" "-4" "include"
-	__fwd_test_port_ip "ff0e::1" "2001:db8:1::1" "2001:db8:1::2" "-6" \
+	__fwd_test_port_ip "239.1.1.1" "01:00:5e:01:01:01" "192.0.2.1" "192.0.2.2" "-4" "include"
+	__fwd_test_port_ip "ff0e::1" "33:33:00:00:00:01" "2001:db8:1::1" "2001:db8:1::2" "-6" \
 		"include"
 }
 
@@ -1127,7 +1129,7 @@ ctrl_igmpv3_is_in_test()
 		filter_mode include source_list 192.0.2.1
 
 	# IS_IN ( 192.0.2.2 )
-	$MZ $h1.10 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
+	$MZ $h1.10 -c 1 -a own -b 01:00:5e:01:01:01 -A 192.0.2.1 -B 239.1.1.1 \
 		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q
 
 	bridge -d mdb show dev br0 vid 10 | grep 239.1.1.1 | grep -q 192.0.2.2
@@ -1140,7 +1142,7 @@ ctrl_igmpv3_is_in_test()
 		filter_mode include source_list 192.0.2.1
 
 	# IS_IN ( 192.0.2.2 )
-	$MZ $h1.10 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
+	$MZ $h1.10 -a own -b 01:00:5e:01:01:01 -c 1 -A 192.0.2.1 -B 239.1.1.1 \
 		-t ip proto=2,p=$(igmpv3_is_in_get 239.1.1.1 192.0.2.2) -q
 
 	bridge -d mdb show dev br0 vid 10 | grep 239.1.1.1 | grep -v "src" | \
@@ -1167,7 +1169,7 @@ ctrl_mldv2_is_in_test()
 
 	# IS_IN ( 2001:db8:1::2 )
 	local p=$(mldv2_is_in_get fe80::1 ff0e::1 2001:db8:1::2)
-	$MZ -6 $h1.10 -c 1 -A fe80::1 -B ff0e::1 \
+	$MZ -6 $h1.10 -a own -b 33:33:00:00:00:01 -c 1 -A fe80::1 -B ff0e::1 \
 		-t ip hop=1,next=0,p="$p" -q
 
 	bridge -d mdb show dev br0 vid 10 | grep ff0e::1 | \
@@ -1181,7 +1183,7 @@ ctrl_mldv2_is_in_test()
 		filter_mode include source_list 2001:db8:1::1
 
 	# IS_IN ( 2001:db8:1::2 )
-	$MZ -6 $h1.10 -c 1 -A fe80::1 -B ff0e::1 \
+	$MZ -6 $h1.10 -a own -b 33:33:00:00:00:01 -c 1 -A fe80::1 -B ff0e::1 \
 		-t ip hop=1,next=0,p="$p" -q
 
 	bridge -d mdb show dev br0 vid 10 | grep ff0e::1 | grep -v "src" | \
-- 
2.41.0



