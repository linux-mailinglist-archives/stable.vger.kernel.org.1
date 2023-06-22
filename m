Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7725D739C73
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 11:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjFVJRy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 05:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjFVJRW (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 05:17:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB4030EA
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 02:09:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-311167ba376so6921607f8f.1
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687424958; x=1690016958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdgNHprTGLPA91FFYpBHGZxqdHnMyvbJk8/KLCkFuYc=;
        b=26Cz75MQ7EijDkIefB0G0Dggxz1yts8bzTPOKrpd48rVycSCgZgYmtkzt2oZNOr+lz
         hausY6FA1JYyWFF5E3WT1tH6v2+oc9FdNMrdulpCK1ATOwVdzQsviBm5R2Se3pNRGxme
         GegVvn8OFPdKnBInfkADUjqIRmjrsQu15y/Jtop6YK/XB2AnrwNku2G0Uw2iDz4c69wm
         bwA+TXDfJMIN+TKoPBty5IlmTOb4MKHPWxKLnGhhjryNXgk/XBeSGlVQXH0MFuC9p5cS
         Xf/km8dtvjsjlTzGKy0GuCnhqzsGpuYTSMh9f8Et89IQBZlsMlz+JK+JBgRGnt9QPP5Y
         Z8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687424958; x=1690016958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdgNHprTGLPA91FFYpBHGZxqdHnMyvbJk8/KLCkFuYc=;
        b=NnZ+RwWP8884is74bUes+oKUTXY+tYQfYFMmWz1pRVpazfcfu0ktmaFOgXHFZ6INqs
         BeDNbESk7fSxuxaxPs5rnNHR+oa8UYN933RpCMlEjbSurAbaQExYyy3d/R9aP/INMAQP
         iAJoWP4gv170NAPzn3o4PiyU9fU2xrVJSDa7SMQSSs4EFc0FwQbe6/Za4bpnZuPyNYlf
         gbG6nQZycSLKpx6eXRcRTcgGwThFP3bLxitN1rXj5WVuw0CnxwrxEoa9wuGtAw5SbP60
         SAik9uJMq34ZKmubiepG2O4uWz304dsmZtWpLNBVBXokJ/8Cyb3sR4M30cM6/mluPqVi
         5/6Q==
X-Gm-Message-State: AC+VfDyM/d42mkuBLm83k1vERKbqil4zFqlHdC0mvgaRF0S8K+2dO/zs
        s7fE27L5kMD7Wa9BTq5juJUG60FaU+TLgtZ0ZZK/b/sL
X-Google-Smtp-Source: ACHHUZ6rShEm0sV14jXDnck6wOrF8s2AqzSkb0gKWNjTqauLJpUDeV3MfmgNh4k3oFuaEMoR89dLcw==
X-Received: by 2002:a5d:5272:0:b0:30f:c6a9:5df2 with SMTP id l18-20020a5d5272000000b0030fc6a95df2mr1339651wrc.35.1687424958539;
        Thu, 22 Jun 2023 02:09:18 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe8d2000000b0030ae3a6be4asm6630287wrn.72.2023.06.22.02.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:09:18 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: diag: skip listen tests if not supported
Date:   Thu, 22 Jun 2023 11:08:52 +0200
Message-Id: <20230622090852.2848019-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023062242-ripple-resilient-26a8@gregkh>
References: <2023062242-ripple-resilient-26a8@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3588; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=7SjOlgOjlgoWw9QFC2BKSQNeMaRvunk+mJum0n6+jyw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBklA+keOm8uroWSJcPBTbrVXmN2H3aLLqBX+3UN
 aXJmiqP2iqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJQPpAAKCRD2t4JPQmmg
 cz9MEADPMzpoV9ERLy054f9tlxpVeRQlxfQJ5D1fXzwynx+7k4jjCNmqHS3GZgLMkFyv+miljYX
 Cfl7U8n+wWw9d5a6kUVHxio/SMYtvmSmWHmUVB3dOgNKRMbw0Qkfi5n8Y4DosfH+SfiD/Jr91bJ
 xqOq3+sbu3oeOyLmIWWrhZUnPD30Vto/0YjyOmnoUZTJ4jOvWZAzfrkTOOYcWP+ZcX1M1KHs8fV
 5nVGaDOK59q/vYVEsR0qynJa8dyTERszypiUGeS4MpT+2/sMR7FaEk2CeVUZKfqSgDjbhrhbOji
 TAtHQqpeOWVrXZQlOCb7xH3pRTvR58/Ahz1pMmQm68Zo1TZKIpJBdOyu3HfY+JJ78UqQ63nZvI6
 GqfPzWbnnmyThWl32DPBBvpdAtGWYHiLzV/S7PmrM6f06DuMDd1YjOY3NaKTdlh2JBAA9CThPSV
 t6tB5YFomUD/v5OJqSt7QaLS25MgQkSL0JQlFIP0O/LTX5SwObifCqo3uta5AGJBYY7jLFqFvMW
 fTS/0/4T4lh6Q+arny6+73wdo8hTq8K80jjSX4+6gDLDOY/MyNkCOCx+xqrxf3B1l4m6iJr+f7e
 LWHnkCHD9AEv1BPtUNWfXnhIJhFhXDGn7ncY8zEkmoTgnjuMNG2+zH8G0+J0zkZMevVQi/HxYVS j+uVDQSADXlKGVg==
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

commit dc97251bf0b70549c76ba261516c01b8096771c5 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the listen diag dump support introduced by
commit 4fa39b701ce9 ("mptcp: listen diag dump support").

It looks like there is no good pre-check to do here, i.e. dedicated
function available in kallsyms. Instead, we try to get info if nothing
is returned, the test is marked as skipped.

That's not ideal because something could be wrong with the feature and
instead of reporting an error, the test could be marked as skipped. If
we know in advanced that the feature is supposed to be supported, the
tester can set SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var to 1: in
this case the test will report an error instead of marking the test as
skipped if nothing is returned.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: f2ae0fa68e28 ("selftests/mptcp: add diag listen tests")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Applied on top of stable-rc/linux-6.1.y: 639ecee7e0d3 ("Linux 6.1.36-rc1")
Conflicting with commit e04a30f78809 ("selftest: mptcp: add test for
mptcp socket in use"): modifications around __chk_msk_nr() have been
included here.
---
 tools/testing/selftests/net/mptcp/diag.sh | 47 ++++++++++++-----------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index dd730a35bd12..400cf1ce96e3 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -42,27 +42,39 @@ fi
 
 __chk_nr()
 {
-	local condition="$1"
+	local command="$1"
 	local expected=$2
-	local msg nr
+	local msg="$3"
+	local skip="${4:-SKIP}"
+	local nr
 
-	shift 2
-	msg=$*
-	nr=$(ss -inmHMN $ns | $condition)
+	nr=$(eval $command)
 
 	printf "%-50s" "$msg"
 	if [ $nr != $expected ]; then
-		echo "[ fail ] expected $expected found $nr"
-		ret=$test_cnt
+		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
+			echo "[ skip ] Feature probably not supported"
+		else
+			echo "[ fail ] expected $expected found $nr"
+			ret=$test_cnt
+		fi
 	else
 		echo "[  ok  ]"
 	fi
 	test_cnt=$((test_cnt+1))
 }
 
+__chk_msk_nr()
+{
+	local condition=$1
+	shift 1
+
+	__chk_nr "ss -inmHMN $ns | $condition" "$@"
+}
+
 chk_msk_nr()
 {
-	__chk_nr "grep -c token:" $*
+	__chk_msk_nr "grep -c token:" "$@"
 }
 
 wait_msk_nr()
@@ -100,37 +112,26 @@ wait_msk_nr()
 
 chk_msk_fallback_nr()
 {
-		__chk_nr "grep -c fallback" $*
+	__chk_msk_nr "grep -c fallback" "$@"
 }
 
 chk_msk_remote_key_nr()
 {
-		__chk_nr "grep -c remote_key" $*
+	__chk_msk_nr "grep -c remote_key" "$@"
 }
 
 __chk_listen()
 {
 	local filter="$1"
 	local expected=$2
+	local msg="$3"
 
-	shift 2
-	msg=$*
-
-	nr=$(ss -N $ns -Ml "$filter" | grep -c LISTEN)
-	printf "%-50s" "$msg"
-
-	if [ $nr != $expected ]; then
-		echo "[ fail ] expected $expected found $nr"
-		ret=$test_cnt
-	else
-		echo "[  ok  ]"
-	fi
+	__chk_nr "ss -N $ns -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
 }
 
 chk_msk_listen()
 {
 	lport=$1
-	local msg="check for listen socket"
 
 	# destination port search should always return empty list
 	__chk_listen "dport $lport" 0 "listen match for dport $lport"
-- 
2.40.1

