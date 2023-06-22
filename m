Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AA573A1EA
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 15:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFVNfw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 09:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjFVNfv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 09:35:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4150D1995
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:35:49 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f9c532fa45so16749105e9.2
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687440947; x=1690032947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OibaAAGhUGhpfriaiqRYrsYqFA0UQyWx/3MpO9Oiewo=;
        b=iVL/OhBHEEmRhIUELYKZeTrm9NHlU+nSIVI/griAVk5brynUL/UvAhoU+BBkVfOLn8
         JRgxK6hG9/lPzTC+EA/fsWwj2MnfybnCY+NGgMvNAIB9XVOxBGXXgq4V+3XcwQzZNLi0
         +aVPRi6NfXRmasWLg5JSio9/vZYmPqv2eobsz86U49voF+Hy8yeN4a7cXTJCEbSu8uAb
         q10jjeOIe0PDPG8uEaWshM9eBWFvhMzkhQiNtDC7VAC8BgSmPvIXmvpK8dFVwgCsMYIw
         AqH+fHRBl5KIbWpZ2aOqQLJSN2Vf7nGa4swhQpLyxP3+UqzxYoKA8QhrZ9QiMwvAHHqB
         7pFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687440947; x=1690032947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OibaAAGhUGhpfriaiqRYrsYqFA0UQyWx/3MpO9Oiewo=;
        b=N6tCsjzY6zlt+JZb03PRgrILRbANGdgPdm7leGLcit/O+/gpYHzaGmZlYvOpjPRpPx
         ezYOgrXiURGUnbXVV455/4yYRb2TerauP6FS5g6fRdNCJjqrtBEtDJca93FxcfuUszQE
         9wZep1KEv/CtkXG7vn9cDGQjH7F8IVTlbKB9MavvFZYWSfASshsAL1ql9q1AyPjQCezs
         NPyyZNYcYw5ex6h0r6zrZ5o6kueWKexzWjKx4y+oooXTC7ZZ9ctN/48I3ewHpH5muUIA
         3p5VIrq2UNR39mqaJSKGiQf6ro0HzUd4VmIK9HgDtgIAFqmSzUa8qag8YXfQNXeSptI6
         Rmtw==
X-Gm-Message-State: AC+VfDyMj6cylivIuPcTDiRGUzxpcH92xPOXcKrVSSyjzEbnXrU74Nxr
        lTzkR/Ugqq8ws2b4ZeEIDB61hkxfN6nF4EptumoYOg==
X-Google-Smtp-Source: ACHHUZ6POpPSrJYywVdd8QTQ0HAZ2f2xp8HfYARqaJOaCpKH526HhosxXwnZNIDohMc6TiZlKGs5wg==
X-Received: by 2002:a1c:cc15:0:b0:3f9:bf0f:1cf5 with SMTP id h21-20020a1ccc15000000b003f9bf0f1cf5mr3333534wmb.20.1687440946772;
        Thu, 22 Jun 2023 06:35:46 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id hn10-20020a05600ca38a00b003f60eb72cf5sm19108104wmb.2.2023.06.22.06.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 06:35:46 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] selftests: mptcp: join: skip check if MIB counter not supported
Date:   Thu, 22 Jun 2023 15:35:37 +0200
Message-Id: <20230622133537.3217897-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023062255-wrath-reword-b29d@gregkh>
References: <2023062255-wrath-reword-b29d@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13097; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=FH1hABXBgKUjN/WmeHROMyUHxNnqHDqgjYQ2AXNHWcE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBklE4p4kWvBPT7T4bEcz5esFYHLCURMb8Ce7l7k
 GfcX2ExTi2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJROKQAKCRD2t4JPQmmg
 c5+hEADth7Qv5Tet3t1OxoBwfTjjqwTPNCW8Ouujc4SaluZAe3522faFi2VZjc84x5ZlRvQ0csk
 iYAQwl/U3afrKl83mX0whpM8SSbUxPbfpNI82u9OIWtzuBw5CPxOdO9cFttlsOfw14vjAvJOMf5
 ZoT6+GEwcz3C1GniRlhnqhNrM6Jg/br+Ml48saS3IS0SOHVIOTT4m+9G1UOypXB5RFbjzPlaOMk
 W8nupjF2gXEQqcokkke4vBWi34Ec12WIiCXdr/3FroN+K1FUo3cBlLBVCKeIID3x6+bHPZQrwfF
 mZUnHj2H+39OdnYkh6+SPXIxcIKF/7g3lfQzbpl7JMMK9tXNPAhgY8uWiHw8lpWqrQ/cOH+OF4V
 acHESZBQFYsg+MTKBavJ9yEF/7qhzUrZw9vxkGgnL1LHjBePXmm2rkTd79dbsK6T2BWjO6JnN9B
 G9G+HZmjbgndvzNPPWnSx9zicoZh5JtvjOruycHcQ4ar4ITUIByZ+ElsOJA36J0UVkOd9SlLr0e
 UZ7JOc9UWVt7ksHdgcAKoMeWZQkR5KgY3uksI/A4AMjgtfZkmL6zwIMJAed3mvMijKgBcpwjbJQ
 9x/701z7uKr+R2N8QtuVVbiHt+TMCpUbtplcdyGALF31K9eeb4rM2/vFMB3ibtwAIDcQFeQV2Vh IPFnpbPCOGqNb4w==
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

commit 47867f0a7e831e24e5eab3330667ce9682d50fb1 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the MPTCP MIB counters introduced in commit fc518953bc9c
("mptcp: add and use MIB counter infrastructure") and more later. The
MPTCP Join selftest heavily relies on these counters.

If a counter is not supported by the kernel, it is not displayed when
using 'nstat -z'. We can then detect that and skip the verification. A
new helper (get_counter()) has been added to do the required checks and
return an error if the counter is not available.

Note that if we expect to have these features available and if
SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var is set to 1, the tests
will be marked as failed instead of skipped.

This new helper also makes sure we get the exact counter we want to
avoid issues we had in the past, e.g. with MPTcpExtRmAddr and
MPTcpExtRmAddrDrop sharing the same prefix. While at it, we uniform the
way we fetch a MIB counter.

Note for the backports: we rarely change these modified blocks so if
there is are conflicts, it is very likely because a counter is not used
in the older kernels and we don't need that chunk.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Applied on top of stable-rc/linux-5.15.y: d2efde0d1c2e ("Linux 5.15.119-rc1").
Conflicting with multiple commits as expected but they were easy to
solve because either it was a modification in features not in v5.15 and
then no need to do anything. Or because commit 4bfadd7120a1 ("selftests:
mptcp: join: avoid backquotes") is not in v5.15.
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 169 ++++++++++--------
 1 file changed, 99 insertions(+), 70 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e6391e234e97..368fae525fea 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -247,6 +247,22 @@ is_v6()
 	[ -z "${1##*:*}" ]
 }
 
+# $1: ns ; $2: counter
+get_counter()
+{
+	local ns="${1}"
+	local counter="${2}"
+	local count
+
+	count=$(ip netns exec ${ns} nstat -asz "${counter}" | awk 'NR==1 {next} {print $2}')
+	if [ -z "${count}" ]; then
+		mptcp_lib_fail_if_expected_feature "${counter} counter"
+		return 1
+	fi
+
+	echo "${count}"
+}
+
 do_transfer()
 {
 	listener_ns="$1"
@@ -560,9 +576,10 @@ chk_csum_nr()
 		echo -n "  "
 	fi
 	printf " %-36s %s" "$msg" "sum"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != 0 ]; then
+	count=$(get_counter ${ns1} "MPTcpExtDataCsumErr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
 		ret=1
 		dump_stats=1
@@ -570,9 +587,10 @@ chk_csum_nr()
 		echo -n "[ ok ]"
 	fi
 	echo -n " - csum  "
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != 0 ]; then
+	count=$(get_counter ${ns2} "MPTcpExtDataCsumErr")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
 		ret=1
 		dump_stats=1
@@ -595,9 +613,10 @@ chk_fail_nr()
 	local dump_stats
 
 	printf "%-39s %s" " " "ftx"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_fail_nr_tx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPFailTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$mp_fail_nr_tx" ]; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $mp_fail_nr_tx"
 		ret=1
 		dump_stats=1
@@ -606,9 +625,10 @@ chk_fail_nr()
 	fi
 
 	echo -n " - frx   "
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_fail_nr_rx" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtMPFailRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$mp_fail_nr_rx" ]; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $mp_fail_nr_rx"
 		ret=1
 		dump_stats=1
@@ -635,9 +655,10 @@ chk_join_nr()
 	local with_cookie
 
 	printf "%02u %-36s %s" "$TEST_COUNT" "$msg" "syn"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$syn_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
 		ret=1
 		dump_stats=1
@@ -647,9 +668,10 @@ chk_join_nr()
 
 	echo -n " - synack"
 	with_cookie=`ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies`
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$syn_ack_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$syn_ack_nr" ]; then
 		# simult connections exceeding the limit with cookie enabled could go up to
 		# synack validation as the conn limit can be enforced reliably only after
 		# the subflow creation
@@ -665,9 +687,10 @@ chk_join_nr()
 	fi
 
 	echo -n " - ack"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$ack_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinAckRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
 		ret=1
 		dump_stats=1
@@ -702,14 +725,13 @@ chk_stale_nr()
 	local recover_nr
 
 	printf "%-39s %-18s" " " "stale"
-	stale_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}'`
-	[ -z "$stale_nr" ] && stale_nr=0
-	recover_nr=`ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}'`
-	[ -z "$recover_nr" ] && recover_nr=0
-
-	if [ $stale_nr -lt $stale_min ] ||
-	   [ $stale_max -gt 0 -a $stale_nr -gt $stale_max ] ||
-	   [ $((stale_nr - $recover_nr)) -ne $stale_delta ]; then
+	stale_nr=$(get_counter ${ns} "MPTcpExtSubflowStale")
+	recover_nr=$(get_counter ${ns} "MPTcpExtSubflowRecover")
+	if [ -z "$stale_nr" ] || [ -z "$recover_nr" ]; then
+		echo "[skip]"
+	elif [ $stale_nr -lt $stale_min ] ||
+	     [ $stale_max -gt 0 -a $stale_nr -gt $stale_max ] ||
+	     [ $((stale_nr - $recover_nr)) -ne $stale_delta ]; then
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
 		     " expected stale in range [$stale_min..$stale_max]," \
 		     " stale-recover delta $stale_delta "
@@ -740,9 +762,10 @@ chk_add_nr()
 	local dump_stats
 
 	printf "%-39s %s" " " "add"
-	count=`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$add_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtAddAddr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
 		ret=1
 		dump_stats=1
@@ -751,9 +774,10 @@ chk_add_nr()
 	fi
 
 	echo -n " - echo  "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$echo_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtEchoAdd")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
 		ret=1
 		dump_stats=1
@@ -763,9 +787,10 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		echo -n " - pt "
-		count=`ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}'`
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$port_nr" ]; then
+		count=$(get_counter ${ns2} "MPTcpExtPortAdd")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
 			ret=1
 			dump_stats=1
@@ -774,10 +799,10 @@ chk_add_nr()
 		fi
 
 		printf "%-39s %s" " " "syn"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
-			awk '{print $2}'`
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$syn_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
 				port-number expected $syn_nr"
 			ret=1
@@ -787,10 +812,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - synack"
-		count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
-			awk '{print $2}'`
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$syn_ack_nr" ]; then
+		count=$(get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
 				port-number expected $syn_ack_nr"
 			ret=1
@@ -800,10 +825,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
-			awk '{print $2}'`
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$ack_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
 				port-number expected $ack_nr"
 			ret=1
@@ -813,10 +838,10 @@ chk_add_nr()
 		fi
 
 		printf "%-39s %s" " " "syn"
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
-			awk '{print $2}'`
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$mis_syn_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
 				port-number expected $mis_syn_nr"
 			ret=1
@@ -826,10 +851,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack   "
-		count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortAckRx |
-			awk '{print $2}'`
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$mis_ack_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
 				port-number expected $mis_ack_nr"
 			ret=1
@@ -868,9 +893,10 @@ chk_rm_nr()
 	fi
 
 	printf "%-39s %s" " " "rm "
-	count=`ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$rm_addr_nr" ]; then
+	count=$(get_counter ${addr_ns} "MPTcpExtRmAddr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
 		ret=1
 		dump_stats=1
@@ -879,9 +905,10 @@ chk_rm_nr()
 	fi
 
 	echo -n " - sf    "
-	count=`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$rm_subflow_nr" ]; then
+	count=$(get_counter ${subflow_ns} "MPTcpExtRmSubflow")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
 		ret=1
 		dump_stats=1
@@ -905,9 +932,10 @@ chk_prio_nr()
 	local dump_stats
 
 	printf "%-39s %s" " " "ptx"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_prio_nr_tx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPPrioTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
 		ret=1
 		dump_stats=1
@@ -916,9 +944,10 @@ chk_prio_nr()
 	fi
 
 	echo -n " - prx   "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_prio_nr_rx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPPrioRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
 		ret=1
 		dump_stats=1
-- 
2.40.1

