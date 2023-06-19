Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3A37352E4
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjFSKjP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjFSKjO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:39:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82690CA
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F5BC60B7C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21988C433C8;
        Mon, 19 Jun 2023 10:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171152;
        bh=FpZbeesFbF4D+zyryl0oboypA5TXNyeoaUfoXB0qfhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1uj4s5s/0Ikl8yXcLcBWUbsnqlTCQInhr5Zl2Fmx7uhSgTnELzdrgypwYmAfRxXm
         cRTP94ladkPeX9TqMGwoMM89uwj55gFROc83AUdXS0JtLIlzcTflZCSI+Jszqt70re
         x50be31Om1RFdP3C1XpS38zlNuzyhhFqcQs3PxhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danielle Ratson <danieller@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 167/187] selftests: forwarding: hw_stats_l3: Set addrgenmode in a separate step
Date:   Mon, 19 Jun 2023 12:29:45 +0200
Message-ID: <20230619102205.721576858@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Danielle Ratson <danieller@nvidia.com>

[ Upstream commit bef68e201e538eaa3a91f97aae8161eb2d0a8ed7 ]

Setting the IPv6 address generation mode of a net device during its
creation never worked, but after commit b0ad3c179059 ("rtnetlink: call
validate_linkmsg in rtnl_create_link") it explicitly fails [1]. The
failure is caused by the fact that validate_linkmsg() is called before
the net device is registered, when it still does not have an 'inet6_dev'.

Likewise, raising the net device before setting the address generation
mode is meaningless, because by the time the mode is set, the address
has already been generated.

Therefore, fix the test to first create the net device, then set its
IPv6 address generation mode and finally bring it up.

[1]
 # ip link add name mydev addrgenmode eui64 type dummy
 RTNETLINK answers: Address family not supported by protocol

Fixes: ba95e7930957 ("selftests: forwarding: hw_stats_l3: Add a new test")
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Link: https://lore.kernel.org/r/f3b05d85b2bc0c3d6168fe8f7207c6c8365703db.1686580046.git.petrm@nvidia.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/forwarding/hw_stats_l3.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/hw_stats_l3.sh b/tools/testing/selftests/net/forwarding/hw_stats_l3.sh
index 9c1f76e108af1..1a936ffbacee7 100755
--- a/tools/testing/selftests/net/forwarding/hw_stats_l3.sh
+++ b/tools/testing/selftests/net/forwarding/hw_stats_l3.sh
@@ -84,8 +84,9 @@ h2_destroy()
 
 router_rp1_200_create()
 {
-	ip link add name $rp1.200 up \
-		link $rp1 addrgenmode eui64 type vlan id 200
+	ip link add name $rp1.200 link $rp1 type vlan id 200
+	ip link set dev $rp1.200 addrgenmode eui64
+	ip link set dev $rp1.200 up
 	ip address add dev $rp1.200 192.0.2.2/28
 	ip address add dev $rp1.200 2001:db8:1::2/64
 	ip stats set dev $rp1.200 l3_stats on
@@ -256,9 +257,11 @@ reapply_config()
 
 	router_rp1_200_destroy
 
-	ip link add name $rp1.200 link $rp1 addrgenmode none type vlan id 200
+	ip link add name $rp1.200 link $rp1 type vlan id 200
+	ip link set dev $rp1.200 addrgenmode none
 	ip stats set dev $rp1.200 l3_stats on
-	ip link set dev $rp1.200 up addrgenmode eui64
+	ip link set dev $rp1.200 addrgenmode eui64
+	ip link set dev $rp1.200 up
 	ip address add dev $rp1.200 192.0.2.2/28
 	ip address add dev $rp1.200 2001:db8:1::2/64
 }
-- 
2.39.2



