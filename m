Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7780B73E8BD
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjFZS3K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjFZS2w (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:28:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E3EE72
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1C0E60F4B
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB94C433C8;
        Mon, 26 Jun 2023 18:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804095;
        bh=FxLtuhO9y6NBD9QWvl3b+LNFMczbugUmNWEZAf38gbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKT0uXPa7/M2fyr9nnBN9zAXuQeHtxq0zlH5kKELhRApZCQY8TNUreXyxDPrUI/RR
         9/Ui+/oPa4uz7h5A1NcH6DoeV76S/IBaGZDZ6j8C8k0RxjXDBlA7ZasQfRqCxEChqp
         Pqq7hH51/xjFgCVS5pl9g8elfWuqFQ8k4Mlqzq1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 039/170] selftests: mptcp: join: skip test if iptables/tc cmds fail
Date:   Mon, 26 Jun 2023 20:10:08 +0200
Message-ID: <20230626180802.297655152@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 4a0b866a3f7d3c22033f40e93e94befc6fe51bce upstream

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

Some tests are using IPTables and/or TC commands to force some
behaviours. If one of these commands fails -- likely because some
features are not available due to missing kernel config -- we should
intercept the error and skip the tests requiring these features.

Note that if we expect to have these features available and if
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set to 1, the tests
will be marked as failed instead of skipped.

This patch also replaces the 'exit 1' by 'return 1' not to stop the
selftest in the middle without the conclusion if there is an issue with
NF or TC.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   88 +++++++++++++++---------
 1 file changed, 57 insertions(+), 31 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -291,11 +291,15 @@ reset_with_add_addr_timeout()
 	fi
 
 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-	ip netns exec $ns2 $tables -A OUTPUT -p tcp \
-		-m tcp --tcp-option 30 \
-		-m bpf --bytecode \
-		"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
-		-j DROP
+
+	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
+			-m tcp --tcp-option 30 \
+			-m bpf --bytecode \
+			"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
+			-j DROP; then
+		mark_as_skipped "unable to set the 'add addr' rule"
+		return 1
+	fi
 }
 
 # $1: test name
@@ -339,17 +343,12 @@ reset_with_allow_join_id0()
 #     tc action pedit offset 162 out of bounds
 #
 # Netfilter is used to mark packets with enough data.
-reset_with_fail()
+setup_fail_rules()
 {
-	reset "${1}" || return 1
-
-	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
-	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
-
 	check_invert=1
 	validate_checksum=1
-	local i="$2"
-	local ip="${3:-4}"
+	local i="$1"
+	local ip="${2:-4}"
 	local tables
 
 	tables="${iptables}"
@@ -364,15 +363,51 @@ reset_with_fail()
 		-p tcp \
 		-m length --length 150:9999 \
 		-m statistic --mode nth --packet 1 --every 99999 \
-		-j MARK --set-mark 42 || exit 1
+		-j MARK --set-mark 42 || return ${ksft_skip}
 
-	tc -n $ns2 qdisc add dev ns2eth$i clsact || exit 1
+	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${ksft_skip}
 	tc -n $ns2 filter add dev ns2eth$i egress \
 		protocol ip prio 1000 \
 		handle 42 fw \
 		action pedit munge offset 148 u8 invert \
 		pipe csum tcp \
-		index 100 || exit 1
+		index 100 || return ${ksft_skip}
+}
+
+reset_with_fail()
+{
+	reset "${1}" || return 1
+	shift
+
+	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
+	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
+
+	local rc=0
+	setup_fail_rules "${@}" || rc=$?
+
+	if [ ${rc} -eq ${ksft_skip} ]; then
+		mark_as_skipped "unable to set the 'fail' rules"
+		return 1
+	fi
+}
+
+reset_with_tcp_filter()
+{
+	reset "${1}" || return 1
+	shift
+
+	local ns="${!1}"
+	local src="${2}"
+	local target="${3}"
+
+	if ! ip netns exec "${ns}" ${iptables} \
+			-A INPUT \
+			-s "${src}" \
+			-p tcp \
+			-j "${target}"; then
+		mark_as_skipped "unable to set the filter rules"
+		return 1
+	fi
 }
 
 fail_test()
@@ -732,15 +767,6 @@ pm_nl_check_endpoint()
 	fi
 }
 
-filter_tcp_from()
-{
-	local ns="${1}"
-	local src="${2}"
-	local target="${3}"
-
-	ip netns exec "${ns}" ${iptables} -A INPUT -s "${src}" -p tcp -j "${target}"
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -1949,23 +1975,23 @@ subflows_error_tests()
 	fi
 
 	# multiple subflows, with subflow creation error
-	if reset "multi subflows, with failing subflow"; then
+	if reset_with_tcp_filter "multi subflows, with failing subflow" ns1 10.0.3.2 REJECT &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
 	# multiple subflows, with subflow timeout on MPJ
-	if reset "multi subflows, with subflow timeout"; then
+	if reset_with_tcp_filter "multi subflows, with subflow timeout" ns1 10.0.3.2 DROP &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		filter_tcp_from $ns1 10.0.3.2 DROP
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
@@ -1973,11 +1999,11 @@ subflows_error_tests()
 	# multiple subflows, check that the endpoint corresponding to
 	# closed subflow (due to reset) is not reused if additional
 	# subflows are added later
-	if reset "multi subflows, fair usage on close"; then
+	if reset_with_tcp_filter "multi subflows, fair usage on close" ns1 10.0.3.2 REJECT &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
 
 		# mpj subflow will be in TW after the reset


