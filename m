Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2309373A278
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 16:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjFVOAO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 10:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjFVOAM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 10:00:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302181AC
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 07:00:11 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f9bdb01ec0so21480635e9.2
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687442409; x=1690034409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waQDjvoZSvSPW8K61PEMM6QFQmxHoBgMRZ62rhmNBFw=;
        b=lexP8Ue93/SngWupHjVyZH35wxNuymJSBHjCW/1NbBb3xfo9hEEdEkGwYaBZCWFvs1
         RyVUkuaTJG9iXBpZpCBo8DL7kAfP124EXQqR3IgxzjJ/dNfK5xx/WhSK15PdRgnyX3Gl
         ubmeSnGXpGcAWX0lTCe2YH7LztMe2EbqO6zXsuhKKAx7WedHgCiKToZkqi3rrN++//O1
         Rwa48pL5WEjlASNeIwVFhTVmXzSbtkXeGfAABzs2kG2H7NdBYc3Y2Hjw1pRBQ3PSPSww
         HB4qjHeZz4lAwvG5LIo+nLDFGIX7TKDuVZKJR+oqWd3rSjrW5XPDmLSrqO1CKOZx1Xl6
         MexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687442409; x=1690034409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waQDjvoZSvSPW8K61PEMM6QFQmxHoBgMRZ62rhmNBFw=;
        b=RujdAzYZcdZhIddiwFnNK9wiw4aX7XAaENsLl/ezRACMhbB7qihSz0Nj1+v1eluh7V
         ez7hrORBI3t3mLUz7iAOE4Lxt9CT/S/J7+xuZLrLXMDq5EpP+ZZeDfUV2u0qBZkCxIuq
         U4poeVBc7ofMkQ/Bxlj3Illg4V2joJRKT7tcif2vXiuPxH0hVCWaaFpa9frI2/uiMRnM
         mlBiV5herhoaukywL65ZpjJzgpV4W0zbuHWHXIuL7XWCRjBqjcN31gk2d/wSEMFc2P9z
         nS91VUv8vcYdIz/5cM23bRDOzNpQw7qLRzlrb3lNwBSBLYXO9VBC6sJUk/vwmzKWrLT3
         /6Jw==
X-Gm-Message-State: AC+VfDzgNrc3eJ1jZW4tUi6AQ+AV3FV6EpuOSvqu+NBDRv4vo3n9Vso7
        70ypfO+y49+R815nq4V0IJxBc0LFcjx0vs4vkF21JQ==
X-Google-Smtp-Source: ACHHUZ5WYQsIAhYmYqu+HqZ3VQCpFYTGcu6BpiAxPagO3C3I8ERRW8n8ML4L1AUJEyZXLLMZyPtjRw==
X-Received: by 2002:a7b:c7c9:0:b0:3f7:f90c:4978 with SMTP id z9-20020a7bc7c9000000b003f7f90c4978mr15831875wmk.21.1687442409174;
        Thu, 22 Jun 2023 07:00:09 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u16-20020a7bc050000000b003f080b2f9f4sm18868083wmc.27.2023.06.22.07.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:00:08 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y 2/2] selftests: mptcp: join: skip check if MIB counter not supported
Date:   Thu, 22 Jun 2023 15:59:48 +0200
Message-Id: <20230622135948.3245451-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622135948.3245451-1-matthieu.baerts@tessares.net>
References: <2023062217-never-sedan-c4bd@gregkh>
 <20230622135948.3245451-1-matthieu.baerts@tessares.net>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5884; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=8ITtsCsCWZKQFp+hcaaL6pFZAGuJOTDq1UPIRq3Cnyk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBklFPU9e5QeaEO0LWZIDM283FKKXzkobtQEdPQu
 UPkMXLkFIOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJRT1AAKCRD2t4JPQmmg
 c/i0D/4oolKAKwyDJYprWjJnsi7arzMnfHiDFe0N3rHzgoVxkSGfQEU19wEl1NoqqFT6InUEELt
 gnn2Pk75U4s7gZnjdLXZ8wliUI7F4vEi2xki2SMJlBEmTXwN6ZNzIwPmN6FknwURFERL4JwuO9P
 4TIQqAwCygv4J0t9WmTfMkUbqcHlzVy79jsevmdJM0lBoIx5P2OmsC6BcvnrCvyUFZXDEGHeB4y
 2E6sXqMeGLTe2CQ9B7okQ7BbDzYQC2GOaKR915YONjgKSqusSGr1MCRtNOjG1m+QmS4hr3b9FJn
 JQL5QFOoQ1k5rAulyktgMqtZsDIs7mrBjuyKF2y5XCfnEhtgyeFOkmOX/aeqz4F5h53GpRSv5+g
 Kj2zLWKhU18sYVQzW97OJ5VIRui2wMMQ0YuxuxJJQbdZEjjHee3I17PzV0+MOoJ9i2a/ZwRg2FJ
 f5P5RElVWzScrGKjYS+w/9yarLG6eKA31ufblzcjJ3XS+i66Zq1b8BF+FWSm3BJ7oCAIE/2pGmk
 KV58f1BKPNYowDomSuAoD2V7V+v9NEdEn2Df+koAI5so/zD529T8YDJB4JSU+yJwQyGW0Gi1+Gi
 wetlLUkZH0sj3CLM+wZmdM+HS+g8A+pS9wknJhi1+SkipJzIb1XDgfA8OXgmFHgibT2DFkkFTeA q+HeD8xZBNX+MWg==
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

