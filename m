Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42399739EAA
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 12:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjFVKj2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 06:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjFVKj0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 06:39:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A46D1992
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 03:39:22 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f8fe9dc27aso55272875e9.3
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 03:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687430361; x=1690022361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPQpz70DqGbXkFoc+1Rq9vVYIDMT1i8FJV1fRnK0yko=;
        b=vLdkKZThhnFEELbMj3dkspKnWOgI1R3vletjzi1eQEUgbBvRjk3eeQsn++eLriesDu
         4YEfS0c17UkaYG0Y9m58qURAjtlBGiqHfZAWS98sxsrk4KPK2oGJWxQ15O1IiKStLhJU
         T3g3YgkB8m/H98MzLuJ3DpCM+74dUu2hWfYGhr7GKQ/ZSiXktJM+8VmpSB7P10/mmXPw
         87kFwBuC5mnh950aLrF1wKyLVssuG1lQW4Af7cXCl1H3Yw6xZYJ5VV+WtyTQHUYpQkef
         am/AlsD2e2gvLJYCje18k6qXZV1rSr+DySX53laXzag6CP1QiniY2YApiQYNRoRgb3NY
         ijKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687430361; x=1690022361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPQpz70DqGbXkFoc+1Rq9vVYIDMT1i8FJV1fRnK0yko=;
        b=H3t8zdUMKfs5RewDiANonBN1of7iI3ZA1+u51ud5igVrtoV0TY9Kv9CTuDnTmEjk+5
         WVOSfXPLGfmxMCXbWAnciChQBIwagunQCMlmYaQwai1mHufsaqPi8sE+KOP3ap4m1U2E
         pyfqNENo0Hk35QjaygngoyXaJ50q8/DagGG5IY4c2UFeXh+svevjE0ogpHBuQK2lnJyY
         HNpzbwkb6+GyV+6+DD/bLPhCWdia5U5vqfYfZb/Z80+OYTlATZbQY4SarcqZL6Am6TOu
         m6GRuskqwJlyrmBl/rrUDzvtcbej8DdmG99YeqGYLwantEbMWeCJE10xu9qgrkOMai6m
         VGFw==
X-Gm-Message-State: AC+VfDx+1wFr9/Q3bfvtjf5qgnplqYSyzGULjRMnm32aCcdCdFWUVcaF
        n7+4CNR/AEH3kplslN+ty4oXxJsyrNlzf118z9/S4hqL
X-Google-Smtp-Source: ACHHUZ5hUSIORYpFMpmjHdawZhBoF9lxKmlmsQHCgh/NvdCVhKdJw8ewZRqDHRN5ZyPXqGlhkTJbrA==
X-Received: by 2002:a7b:c8cd:0:b0:3f9:1e4:f108 with SMTP id f13-20020a7bc8cd000000b003f901e4f108mr10648801wml.38.1687430360714;
        Thu, 22 Jun 2023 03:39:20 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bce16000000b003f8f9ab6f30sm7294673wmc.20.2023.06.22.03.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 03:39:20 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: skip userspace PM tests if not supported
Date:   Thu, 22 Jun 2023 12:39:14 +0200
Message-Id: <20230622103914.2951296-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023062235-census-ramp-a602@gregkh>
References: <2023062235-census-ramp-a602@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4893; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=oTqyrws6xKezv8s7KLwpZJV8a6Xo1j3IBem+9isfiew=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBklCTSOpPy4YtgEfolmknXGbaWO6RGDfAwhADyT
 PEOAB7FE5mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJQk0gAKCRD2t4JPQmmg
 czH/D/9iXAoaZXBUQyDs/43UysQ2bopvg2SMj/IMB219Rae5h3PI8qkIlwyuRcopygYv5k1jSod
 wDcn/lHXP7IZQnegx9v4NLvRnlvKY+A6ia07CB8RCE7VjL9HaSa9R71Lr9EmKidrx5NiamNZYkr
 SzAWShcbOpRXWShs5gb+B2f8VzGxFQFiFgpsUkRpgtFJ1V6wVWs4MoV85hd9EcUOZhRhCwNSpdC
 S2P0J7Xml5tsDZ7J8NuzkeQwR1XkOW7kzH4grUlb/u0ikCBm1ZvxE3uDPl5EFPwMS257AlFuTJq
 aLFY802EsiwwqmUqLWjuWaK4DKhTQ1549ndQ/x1Q/qXgq+7lTDVOyVI91s0H3rc0kUWW1wLAymH
 Y/jW5f8EHDd0qnTlZGkjkMIapJq7kvYDJIIFp73dsyigYIvvREjaXoVE0JNGJzwxQ0T85IAi719
 3SB0UYWCKQ6lEWMBhptJfsW7GJTIAm0kfHR66ECUckuJyejjG1Pss0QTKxtpfCaGmciINtY74F3
 aLWC1XpMtu2Qkhf7rRxFadb6Lr+gyoNCmYMq3KNRQf1QByr+Ev73d067UKdIAwLzGe5KkO/SdPp
 LGZswNuJW57HiQXsAWoDh0sdFSvLRUbIFVSylU6/+P0R9+46PKs6bHL/UlLPrbukDwbXfXjdtvN ugMu3jQUEBqbNYw==
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

commit f2b492b04a167261e1c38eb76f78fb4294473a49 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of the userspace PM introduced by commit
4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
and the following ones.

It is possible to look for the MPTCP pm_type's sysctl knob to know in
advance if the userspace PM is available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 5ac1d2d63451 ("selftests: mptcp: Add tests for userspace PM type")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Applied on top of stable-rc/linux-6.1.y: 639ecee7e0d3 ("Linux 6.1.36-rc1").
Conflicting with commit a3735625572d ("selftests: mptcp: make evts
global in mptcp_join") introducing reset_with_events(). Only the new
"continue_if" commands have been taken after "reset()", without using
reset_with_events().
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 68bd7bd221f3..1ad7de52e1a9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -79,7 +79,7 @@ init_partial()
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
-		ip netns exec $netns sysctl -q net.mptcp.pm_type=0
+		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 		if [ $checksum -eq 1 ]; then
@@ -3059,7 +3059,8 @@ fail_tests()
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
-	if reset "userspace pm type prevents add_addr"; then
+	if reset "userspace pm type prevents add_addr" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
@@ -3070,7 +3071,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type does not echo add_addr without daemon
-	if reset "userspace pm no echo w/o daemon"; then
+	if reset "userspace pm no echo w/o daemon" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
@@ -3081,7 +3083,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type rejects join
-	if reset "userspace pm type rejects join"; then
+	if reset "userspace pm type rejects join" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3091,7 +3094,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type does not send join
-	if reset "userspace pm type does not send join"; then
+	if reset "userspace pm type does not send join" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3101,7 +3105,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type prevents mp_prio
-	if reset "userspace pm type prevents mp_prio"; then
+	if reset "userspace pm type prevents mp_prio" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3112,7 +3117,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type prevents rm_addr
-	if reset "userspace pm type prevents rm_addr"; then
+	if reset "userspace pm type prevents rm_addr" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
@@ -3124,7 +3130,8 @@ userspace_tests()
 	fi
 
 	# userspace pm add & remove address
-	if reset "userspace pm add & remove address"; then
+	if reset "userspace pm add & remove address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
 		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
@@ -3134,7 +3141,8 @@ userspace_tests()
 	fi
 
 	# userspace pm create destroy subflow
-	if reset "userspace pm create destroy subflow"; then
+	if reset "userspace pm create destroy subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
-- 
2.40.1

