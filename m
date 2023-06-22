Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6B573A297
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjFVOBr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 10:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjFVOBa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 10:01:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A6119BE
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 07:01:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f904dcc1e2so63602735e9.3
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 07:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687442479; x=1690034479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waQDjvoZSvSPW8K61PEMM6QFQmxHoBgMRZ62rhmNBFw=;
        b=ZFYL2rNtSS1bqZs99uiZ8QrxXSr/slcEChqdoEh1Fi5JxeKvrXgxDkb3XKdadw6PHk
         BzGNWn+s/meAymTC8RMtC0D7DzLTCnIWel5erkYzs1mWYO9nBllBYkwBRIU1jNGOim4K
         H3Y+hJ+6JzKISQyrTPfnTK0ENfTJy3tYd2Ujk6EKIczBHaXqmMOX5jYd7Dr2apS1Rkaa
         kOoTSOymi9/cKj/PhSJ5FsBxjPkQjBIvX/DTlipr3laA7kEQfwFttRcoqI4nwQ8ElDVm
         big93ogwsSsbztXKXP/tr/72iLOh8UhEygajeu8EGVXc/jhTwOnLP+1Or/4XaUT7dE8O
         0SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687442479; x=1690034479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waQDjvoZSvSPW8K61PEMM6QFQmxHoBgMRZ62rhmNBFw=;
        b=f1rt15yr87uomgT15zVKH6nvmFxz5PECr+32NL2clHR6+f4LG1hAYEUmFMZe4Qu+fj
         s6znX3tS7T3sVYAn9RvroMXfRHc8C/kBFrJfEQxiQoyBtJvDi8d7toOM29Fp7/kuHD7u
         JTrfRDOVEYMT6/9XvSHlhFjuVZExYgc4CCK8eHcP0lL0vxRsiXbA22ffvvssm7LBxRR3
         AIRumMNHlzzxhMXG1dzsobLtkViOffdw3j9wLr5FSdpU4qXLV/I4jbbfk8LpE/WNxjcZ
         CGrs6Jfu2eJQlZH0iiNsGEi6WKnJlIeC0WUijWfHgxJ9fADskEhK1avJKpWZKe3LDixb
         mKjw==
X-Gm-Message-State: AC+VfDxjLWHXsJCSPkwRMYoUBwA8kdd/M27TuPC7pbVFkd3bd/ZgnDfa
        OQPX5mIgC6FiRnwE9mloghNzVim5c81K7FpGP6mjHw==
X-Google-Smtp-Source: ACHHUZ5S/0jNAexLS/ZZ4yD2tktiUCS3E1qUiPyQLvHC2ngMuW9Tyk1M8zuLPQYUe9MnvtnkdY72ng==
X-Received: by 2002:a7b:c4da:0:b0:3f8:f67d:912d with SMTP id g26-20020a7bc4da000000b003f8f67d912dmr14342605wmk.16.1687442479516;
        Thu, 22 Jun 2023 07:01:19 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003f7e4d143cfsm7840620wmi.15.2023.06.22.07.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:01:19 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] selftests: mptcp: join: skip check if MIB counter not supported
Date:   Thu, 22 Jun 2023 16:01:08 +0200
Message-Id: <20230622140108.3246987-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023062256-giggly-chummy-891a@gregkh>
References: <2023062256-giggly-chummy-891a@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5884; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=8ITtsCsCWZKQFp+hcaaL6pFZAGuJOTDq1UPIRq3Cnyk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBklFQj9e5QeaEO0LWZIDM283FKKXzkobtQEdPQu
 UPkMXLkFIOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJRUIwAKCRD2t4JPQmmg
 cx1xEADp1C4F+ePJhBIVwIyFtSCb/jEPLND8JGrX5/KQCRUnIUiJ15hQb4RNZN04L5DBU3ZDfqH
 RnhN5TerkBlEAhDMzhGl4r4S3YKQk0b7B58/W/O8VQt/d/XcNW2XgfEix0JE/cRonB39LXwajEc
 q2ADmY9EgVeDN/jeK43hqhTw0kHiodTI6p5LF/pGej1mcET7ELkAA0ftTsBz9dcy02eWp2cf0UP
 keAPE3m3wc9o506JZ7PFeF9Vr+WorNyMwqbrXnbSOFccAyeIyRZk1d39Z/9zyym/F9RTAlLU5Sw
 6A57eCrNSqAXeOy4I0Y+d//LbyAUiqSDljqJPyanvVLlCLZkXwGgY/JcdWIvk3qcZ1f+B30SqQP
 IKbKvA6OU7t4wDlyySgHZIVkkRk6rrtjb4LkkECxNw85JWxIRtTsiWcXlkPiiOzExQ3imjYDiPG
 ZwTainL0qHUa7kdZ5FV6acs8ccBLGhbFItkkS6GdDWS8+9GK6VegK5mzDPCAYV3E0wmF3QGTH0V
 z1h3DfZSI7mODfkVWM+I3D23R89EClAnc1C6H0e92b5j/0f7YmMRsWlWfuxXxGEcPE8dPsJ0k5J
 O3como2tPzDQTu3Z/f8eiwNSMZGY099I6hfhCnaNayS2mKMMJyZ17D+Sn6IOEfo5ogyPo6cm5Fz SjcB1xfFPQey1tA==
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
Applied on top of stable-rc/linux-5.10.y: e4636b6297b0 ("Linux 5.10.186-rc1").
Conflicting with multiple commits as expected but they were easy to
solve when using the version of this patch proposed for v5.15.y.
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 65 +++++++++++++------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 94b15bb28e11..d205828d7575 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -130,6 +130,22 @@ do_ping()
 	fi
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
@@ -291,9 +307,10 @@ chk_join_nr()
 	local dump_stats
 
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
@@ -302,9 +319,10 @@ chk_join_nr()
 	fi
 
 	echo -n " - synack"
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$syn_ack_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$syn_ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
 		ret=1
 		dump_stats=1
@@ -313,9 +331,10 @@ chk_join_nr()
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
@@ -338,9 +357,10 @@ chk_add_nr()
 	local dump_stats
 
 	printf "%-39s %s" " " "add"
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtAddAddr | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$add_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtAddAddr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
 		ret=1
 		dump_stats=1
@@ -349,9 +369,10 @@ chk_add_nr()
 	fi
 
 	echo -n " - echo  "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$echo_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtEchoAdd")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
 		ret=1
 		dump_stats=1
@@ -375,9 +396,10 @@ chk_rm_nr()
 	local dump_stats
 
 	printf "%-39s %s" " " "rm "
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$rm_addr_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtRmAddr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
 		ret=1
 		dump_stats=1
@@ -386,9 +408,10 @@ chk_rm_nr()
 	fi
 
 	echo -n " - sf    "
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}'`
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$rm_subflow_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtRmSubflow")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
 		ret=1
 		dump_stats=1
-- 
2.40.1

