Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C98783198
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 21:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjHUTvm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHUTvk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:51:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875C0F3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:51:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 233946444D
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32655C433C8;
        Mon, 21 Aug 2023 19:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647493;
        bh=zubj/pj0f85ja9rx1D07j6wzLnheolhlWy20rrcFpjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZhsmbBrN27m+PfGhn/erWPVTvxsfSR6uGmzlLWgRQw0Jo8DUNatjSmoKu4j0+Gc/s
         /2DNQlEnDdL/oMsW6RDPoua8zphCiBUG/7n6eRBKvD0Sw4FH8q9nuYDskoX8naqq99
         cPvxPAQw7wdrFWyj7zzc9aj85YLks5xytuqwO+Ew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 006/194] selftests: forwarding: tc_actions: cleanup temporary files when test is aborted
Date:   Mon, 21 Aug 2023 21:39:45 +0200
Message-ID: <20230821194122.995099455@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
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

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit f58531716ced8975a4ade108ef4af35f98722af7 ]

remove temporary files created by 'mirred_egress_to_ingress_tcp' test
in the cleanup() handler. Also, change variable names to avoid clashing
with globals from lib.sh.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Link: https://lore.kernel.org/r/091649045a017fc00095ecbb75884e5681f7025f.1676368027.git.dcaratti@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 5e8670610b93 ("selftests: forwarding: tc_actions: Use ncat instead of nc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/net/forwarding/tc_actions.sh       | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/tc_actions.sh b/tools/testing/selftests/net/forwarding/tc_actions.sh
index 919c0dd9fe4bc..a96cff8e72197 100755
--- a/tools/testing/selftests/net/forwarding/tc_actions.sh
+++ b/tools/testing/selftests/net/forwarding/tc_actions.sh
@@ -201,10 +201,10 @@ mirred_egress_to_ingress_test()
 
 mirred_egress_to_ingress_tcp_test()
 {
-	local tmpfile=$(mktemp) tmpfile1=$(mktemp)
+	mirred_e2i_tf1=$(mktemp) mirred_e2i_tf2=$(mktemp)
 
 	RET=0
-	dd conv=sparse status=none if=/dev/zero bs=1M count=2 of=$tmpfile
+	dd conv=sparse status=none if=/dev/zero bs=1M count=2 of=$mirred_e2i_tf1
 	tc filter add dev $h1 protocol ip pref 100 handle 100 egress flower \
 		$tcflags ip_proto tcp src_ip 192.0.2.1 dst_ip 192.0.2.2 \
 			action ct commit nat src addr 192.0.2.2 pipe \
@@ -220,11 +220,11 @@ mirred_egress_to_ingress_tcp_test()
 		ip_proto icmp \
 			action drop
 
-	ip vrf exec v$h1 nc --recv-only -w10 -l -p 12345 -o $tmpfile1  &
+	ip vrf exec v$h1 nc --recv-only -w10 -l -p 12345 -o $mirred_e2i_tf2  &
 	local rpid=$!
-	ip vrf exec v$h1 nc -w1 --send-only 192.0.2.2 12345 <$tmpfile
+	ip vrf exec v$h1 nc -w1 --send-only 192.0.2.2 12345 <$mirred_e2i_tf1
 	wait -n $rpid
-	cmp -s $tmpfile $tmpfile1
+	cmp -s $mirred_e2i_tf1 $mirred_e2i_tf2
 	check_err $? "server output check failed"
 
 	$MZ $h1 -c 10 -p 64 -a $h1mac -b $h1mac -A 192.0.2.1 -B 192.0.2.1 \
@@ -241,7 +241,7 @@ mirred_egress_to_ingress_tcp_test()
 	tc filter del dev $h1 egress protocol ip pref 101 handle 101 flower
 	tc filter del dev $h1 ingress protocol ip pref 102 handle 102 flower
 
-	rm -f $tmpfile $tmpfile1
+	rm -f $mirred_e2i_tf1 $mirred_e2i_tf2
 	log_test "mirred_egress_to_ingress_tcp ($tcflags)"
 }
 
@@ -270,6 +270,8 @@ setup_prepare()
 
 cleanup()
 {
+	local tf
+
 	pre_cleanup
 
 	switch_destroy
@@ -280,6 +282,8 @@ cleanup()
 
 	ip link set $swp2 address $swp2origmac
 	ip link set $swp1 address $swp1origmac
+
+	for tf in $mirred_e2i_tf1 $mirred_e2i_tf2; do rm -f $tf; done
 }
 
 mirred_egress_redirect_test()
-- 
2.40.1



