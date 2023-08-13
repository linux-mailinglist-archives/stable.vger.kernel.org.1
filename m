Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557C777AC09
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjHMV2e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjHMV2d (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C1F10DD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFCA962A58
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E17C433C8;
        Sun, 13 Aug 2023 21:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962114;
        bh=/UAP5+LUskuc5gm430HSm6otkGDae7mzS8RMk49xVxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ad+9W9fddIE8/ZF9p1S1UfAwEV+TFlAG861zReJ0ohsasUvmH0B6ZpqtNddNcRYPM
         /NvVAZoD0JGaaozdUe4+emuX7bX2+01SdmiIJH+MIlsc3mBHH4/MX9R3AHo2/rAY0U
         ViY+txBzJnwNGN/HVT7rXRg+VXFoiLSGyz+biCZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Ido Schimmel <idosch@nvidia.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 118/206] selftests: forwarding: bridge_mdb_max: Fix failing test with old libnet
Date:   Sun, 13 Aug 2023 23:18:08 +0200
Message-ID: <20230813211728.417141063@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
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

commit cb034948ac292da82cc0e6bc1340f81be36e117d upstream.

As explained in commit 8bcfb4ae4d97 ("selftests: forwarding: Fix failing
tests with old libnet"), old versions of libnet (used by mausezahn) do
not use the "SO_BINDTODEVICE" socket option. For IP unicast packets,
this can be solved by prefixing mausezahn invocations with "ip vrf
exec". However, IP multicast packets do not perform routing and simply
egress the bound device, which does not exist in this case.

Fix by specifying the source and destination MAC of the packet which
will cause mausezahn to use a packet socket instead of an IP socket.

Fixes: 3446dcd7df05 ("selftests: forwarding: bridge_mdb_max: Add a new selftest")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20230808141503.4060661-17-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../selftests/net/forwarding/bridge_mdb_max.sh     | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
index fa762b716288..3da9d93ab36f 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb_max.sh
@@ -252,7 +252,8 @@ ctl4_entries_add()
 	local IPs=$(seq -f 192.0.2.%g 1 $((n - 1)))
 	local peer=$(locus_dev_peer $locus)
 	local GRP=239.1.1.${grp}
-	$MZ $peer -c 1 -A 192.0.2.1 -B $GRP \
+	local dmac=01:00:5e:01:01:$(printf "%02x" $grp)
+	$MZ $peer -a own -b $dmac -c 1 -A 192.0.2.1 -B $GRP \
 		-t ip proto=2,p=$(igmpv3_is_in_get $GRP $IPs) -q
 	sleep 1
 
@@ -272,7 +273,8 @@ ctl4_entries_del()
 
 	local peer=$(locus_dev_peer $locus)
 	local GRP=239.1.1.${grp}
-	$MZ $peer -c 1 -A 192.0.2.1 -B 224.0.0.2 \
+	local dmac=01:00:5e:00:00:02
+	$MZ $peer -a own -b $dmac -c 1 -A 192.0.2.1 -B 224.0.0.2 \
 		-t ip proto=2,p=$(igmpv2_leave_get $GRP) -q
 	sleep 1
 	! bridge mdb show dev br0 | grep -q $GRP
@@ -289,8 +291,10 @@ ctl6_entries_add()
 	local peer=$(locus_dev_peer $locus)
 	local SIP=fe80::1
 	local GRP=ff0e::${grp}
+	local dmac=33:33:00:00:00:$(printf "%02x" $grp)
 	local p=$(mldv2_is_in_get $SIP $GRP $IPs)
-	$MZ -6 $peer -c 1 -A $SIP -B $GRP -t ip hop=1,next=0,p="$p" -q
+	$MZ -6 $peer -a own -b $dmac -c 1 -A $SIP -B $GRP \
+		-t ip hop=1,next=0,p="$p" -q
 	sleep 1
 
 	local nn=$(bridge mdb show dev br0 | grep $GRP | wc -l)
@@ -310,8 +314,10 @@ ctl6_entries_del()
 	local peer=$(locus_dev_peer $locus)
 	local SIP=fe80::1
 	local GRP=ff0e::${grp}
+	local dmac=33:33:00:00:00:$(printf "%02x" $grp)
 	local p=$(mldv1_done_get $SIP $GRP)
-	$MZ -6 $peer -c 1 -A $SIP -B $GRP -t ip hop=1,next=0,p="$p" -q
+	$MZ -6 $peer -a own -b $dmac -c 1 -A $SIP -B $GRP \
+		-t ip hop=1,next=0,p="$p" -q
 	sleep 1
 	! bridge mdb show dev br0 | grep -q $GRP
 }
-- 
2.41.0



