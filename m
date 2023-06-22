Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECCA739EA3
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 12:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjFVKi1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 06:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjFVKi0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 06:38:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D6C1739
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 03:38:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fa71e253f2so4818105e9.0
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 03:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687430302; x=1690022302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRG7I3ETqL6xNDOB96gTthRgduPz7tKVaZfotA35Qhg=;
        b=znJTjEA6X01CGQ+K849kJjGhVDpl0dwELmDMyPkDwasncy3U1sMAEt0aqRGAspF/hD
         nFX6zR1jBHcLgYylhvZhQenbsB9kVV8+JYTo3De5CJh1Uvej0ijUC2mz4FIv2QvUMd/J
         qGxm5c6xyRUbtfYMWyLUcezRG0GrZ5lE7bDL3GmJawb9Oi7gnrk+rYUKGBnnLtKJwcay
         xziWcgSgzTESRefdrkmlocyaWk+Vc1NYuBq/clbyGLcfaT3fP25VFxiFXa++1bs5R90R
         pna546O/g1O0MxZmEkepxfS8uDkTXaK/vwZ+8c7BdxW2cmLeBX9xv5nBUygiLN3UjsBf
         OJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687430302; x=1690022302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRG7I3ETqL6xNDOB96gTthRgduPz7tKVaZfotA35Qhg=;
        b=cllcQr/CX6Tpezn+MAb5dgzlts5kDhNgpypOOgPLdq2eQZJgGmlvW+qqsG4DWvRTWY
         20vWNsifqrIp5Ha8C/5QIDzBe1vOgUTTPpP1Dl12ip2w1MAVJ/Kyqpj+4DQF4o0QNfWJ
         NnhYcLJi1nE95/w8aVCEIWvfD+3dsGdbx3BwnqZwhEl/NOjln34ycphsgaFa4rALlJCY
         yLQnY2ofvF752oLkoDQn8UvGz4zG6BoSWoYrZeBO7gMcm6l2bqp8wuMHnrZztDEO2EhI
         OdAg+wOuQ8YEU9AzysyQMcJ/H4ap7dCXoMf8XRwrBTcDPMESO3w3Q0LDVfea5tlKvFq5
         uoNQ==
X-Gm-Message-State: AC+VfDxzgRYlSWpQttgjaAtht89Mgc9mgSzKq55eFTz+7nzkNC26JVdR
        J+V3WvQqHO/IgNDWP95iWWqiErOmBgwrAsqIcp18KIe2
X-Google-Smtp-Source: ACHHUZ6PAgpdW723KYLU5zmgCWV8Ae/5JL4ZFyo7wASy9kblDoRW1PK5xppngnHXBifjiWxvCmA7pg==
X-Received: by 2002:a7b:c450:0:b0:3f7:367a:bd28 with SMTP id l16-20020a7bc450000000b003f7367abd28mr15858673wmi.4.1687430301670;
        Thu, 22 Jun 2023 03:38:21 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id i3-20020a05600c290300b003f8140763c7sm7395373wmd.30.2023.06.22.03.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 03:38:21 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: skip test if iptables/tc cmds fail
Date:   Thu, 22 Jun 2023 12:37:54 +0200
Message-Id: <20230622103754.2949735-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023062218-dude-unshaven-b4cb@gregkh>
References: <2023062218-dude-unshaven-b4cb@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6299; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=FZiKKjVyhnq4DDxLx6cD82l49oaCStOt45D+gOQw82k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBklCSCr+76HkDFtO3aY6hzxaPH/VeYkVroOSJYF
 EFb6gr4lAeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJQkggAKCRD2t4JPQmmg
 c5WpD/4xbq3SbjJBUYxiFemf3/6Ai5BezbksYKkl4I8vtY8AtacBHQWHHapVkbMYGbmzqsJnCmQ
 q6uecQj0bCTZi67SrHc0rc+CwXS0NAMkW9UMVDUxaJspwfZn7G0YxcmiXRsFZm5H4JJc/hWXLUM
 PsFomGPq4Qs2sGf4dj0Aiwny41R/1too/Q6ZeFByXbdRUvqxjJj/z+GgarOHgs3b6j66dG5+KsQ
 dQEmKuZ22npgkJ1zCszPzypxt83ry9tg8Ds24ZCFpwL2qAdcV4+78GZk9nmrh4KBfgEqg598234
 kCPN+S8j3SSEDi+Zts1L9Dy8/+DjlyAsXOzoIM9v0MC/bQVL09mFc0M9UGquljrsBa7oPuSPG++
 jt+BXjuJbqqSRZozaAldcufEiu5k9j1eM6GzMFL6ocscY3Q1eBD6h1F7nwXwwhercWGjCpdhxeY
 ZzC97wLEE5qCPcm+74QHSotY9bvHEisbqW5P/AecrzqWpoUN5JLRB4gi432nLRAUi5qodVhKN6Z
 hqQRasrK42cAaCD8dJwYgyGtdTW/IwyQ0FP0N1YOHAyirwiWIB/KqR4KW1UnTqrjatbT2uETrlh
 5GhNluAiv6nFjaIIG4gey6tqCjON1SNndXYnRnXBVsiyg5B6AYyykJts+pTt/dlMldRPwKBmPRT Ag60z2q+yUtw0jw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
---
Applied on top of stable-rc/linux-6.1.y: 639ecee7e0d3 ("Linux 6.1.36-rc1").
Conflicting with commit a3735625572d ("selftests: mptcp: make evts
global in mptcp_join") introducing reset_with_events(). The new
reset_with_fail() function has then been placed after reset_with_fail()
instead.
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 88 ++++++++++++-------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b6f8eb4110a9..68bd7bd221f3 100755
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
-- 
2.40.1

