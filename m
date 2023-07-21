Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F8F75CA2A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjGUOhJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjGUOgu (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:36:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2448E68
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5136E61CC7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6558EC433C8;
        Fri, 21 Jul 2023 14:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950208;
        bh=Jv23yvE280LUB6Rreazxm3Px0HNBgfk3g+1ahthleyE=;
        h=Subject:To:Cc:From:Date:From;
        b=V3vaei0WNA86ZaJ80E8wji9pjSXO8u4GCvdHyUexcyLpEsk/spZrRA9tbNW0KXZFz
         f0q3Na6NqGLFy5jWL6Yi1e+tQL09BuEdL5kvz/Iiwu5FLvd+dp5W3h39hCGoSb0bvY
         YFNWTwyJd/v9gpgZhLyXiNaxocqdSW5P0mkuoqYA=
Subject: FAILED: patch "[PATCH] selftests: mptcp: sockopt: use 'iptables-legacy' if available" failed to apply to 5.15-stable tree
To:     matthieu.baerts@tessares.net, davem@davemloft.net,
        pabeni@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:36:45 +0200
Message-ID: <2023072145-cardigan-stinger-9c9a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x a5a5990c099dd354e05e89ee77cd2dbf6655d4a1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072145-cardigan-stinger-9c9a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

a5a5990c099d ("selftests: mptcp: sockopt: use 'iptables-legacy' if available")
5f17f8e315ad ("selftests: mptcp: declare var as local")
de2392028a19 ("selftests: mptcp: clearly declare global ns vars")
787eb1e4df93 ("selftests: mptcp: uniform 'rndh' variable")
b71dd705179c ("selftests: mptcp: removed defined but unused vars")
b4e0df4cafe1 ("selftests: mptcp: run mptcp_inq from a clean netns")
7e68d31020f1 ("selftests: mptcp: run mptcp_sockopt from a new netns")
259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
1e777bd818bd ("selftests: mptcp: join: clarify local/global vars")
ae7bd9ccecc3 ("selftests: mptcp: join: option to execute specific tests")
e59300ce3ff8 ("selftests: mptcp: join: reset failing links")
3afd0280e7d3 ("selftests: mptcp: join: define tests groups once")
3c082695e78b ("selftests: mptcp: drop msg argument of chk_csum_nr")
69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
d045b9eb95a9 ("mptcp: introduce implicit endpoints")
6fa0174a7c86 ("mptcp: more careful RM_ADDR generation")
f98c2bca7b2b ("selftests: mptcp: Rename wait function")
826d7bdca833 ("selftests: mptcp: join: allow running -cCi")
7d9bf018f907 ("selftests: mptcp: update output info of chk_rm_nr")
26516e10c433 ("selftests: mptcp: add more arguments for chk_join_nr")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a5a5990c099dd354e05e89ee77cd2dbf6655d4a1 Mon Sep 17 00:00:00 2001
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 4 Jul 2023 22:44:36 +0200
Subject: [PATCH] selftests: mptcp: sockopt: use 'iptables-legacy' if available

IPTables commands using 'iptables-nft' fail on old kernels, at least
on v5.15 because it doesn't see the default IPTables chains:

  $ iptables -L
  iptables/1.8.2 Failed to initialize nft: Protocol not supported

As a first step before switching to NFTables, we can use iptables-legacy
if available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: dc65fe82fb07 ("selftests: mptcp: add packet mark test case")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index f295a371ff14..c21bfd7f0c01 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -12,6 +12,8 @@ ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
+iptables="iptables"
+ip6tables="ip6tables"
 
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
@@ -25,7 +27,7 @@ add_mark_rules()
 	local m=$2
 
 	local t
-	for t in iptables ip6tables; do
+	for t in ${iptables} ${ip6tables}; do
 		# just to debug: check we have multiple subflows connection requests
 		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
 
@@ -95,14 +97,14 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-iptables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+# Use the legacy version if available to support old kernel versions
+if iptables-legacy -V &> /dev/null; then
+	iptables="iptables-legacy"
+	ip6tables="ip6tables-legacy"
+elif ! iptables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without iptables tool"
 	exit $ksft_skip
-fi
-
-ip6tables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+elif ! ip6tables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without ip6tables tool"
 	exit $ksft_skip
 fi
@@ -112,10 +114,10 @@ check_mark()
 	local ns=$1
 	local af=$2
 
-	local tables=iptables
+	local tables=${iptables}
 
 	if [ $af -eq 6 ];then
-		tables=ip6tables
+		tables=${ip6tables}
 	fi
 
 	local counters values

