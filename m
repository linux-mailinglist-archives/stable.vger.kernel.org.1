Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154F4764E7F
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 11:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjG0JFU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 27 Jul 2023 05:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjG0JFB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 27 Jul 2023 05:05:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9116595
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 01:45:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3110ab7110aso723230f8f.3
        for <stable@vger.kernel.org>; Thu, 27 Jul 2023 01:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690447544; x=1691052344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPg4eSQOn2RRpb0GruSim2/Tji/I9NO1lbHKuNPLzyE=;
        b=Li+xQYt8l7QZBRrN3JoDoMNPXHcdxRSqO+ouZDeAm1gpTN0+Tz8MuEpp0q0ZmLjR/o
         5Po1Z5CUDBijBy8vaj5nX/m1R9yw2loQVkq0SNRTLVk6oQqfaBvrqDwjwPiijAmPCdzN
         bI6/hGI3nFxgA6Jxwiq5J++IDKYnh2dFA1sbLbAID/a/bZnfVYXd2CLM8Ikx8iuaHw98
         UbNXP99j80XwQ04fIipyXmpP9rl6VpIAiBBgz1fbFGd2SBRmZdDpF7zdUXSsdaRreeX5
         9+juHOCtZlT14qqv3+taomaFVdqg7xtHQ/ILTXxv4Areufv/zzdimPlgu3EXySyksTJI
         //SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690447544; x=1691052344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPg4eSQOn2RRpb0GruSim2/Tji/I9NO1lbHKuNPLzyE=;
        b=C12wjZzA86KPBhZLRCfYgLYdtGv79TD9dif2KN4EBjLJ/p34ZL4jEt9hSHkGIZ/ooE
         /7g+XPQQ2LuWuZGIgBvWuwsjKu8x5VhcWJPjMUdx67UJU33r7o7qJPiGjbuHfO2zDznq
         UJk1q+70pymGFbXrASlpnq9H0kslJpZhaqLBOeaau3SKu+Cdr25weH98/u8dvsmJ7iiF
         XsY5gzg16xw6sC2aaCjDSMzEQYAJW9rUrI9XzQlu4h+qxUFVA9zNiXPYl5GLI9MNsp45
         ibZV1YsjFniDkQ7Mrup5D9nlGBdSZ+wAOxt+f4sFm/agTCRkvPo+06ktOSTeib9Q+r0M
         NR/Q==
X-Gm-Message-State: ABy/qLZFBU+9DZVEyKEFjfly3/obRIb3z086ag7MX6ll/1MHIAbNG997
        QzlVee4fbcUqgXKfZ2kU3UsVsHJdbiL5aU5CcaX+Zw==
X-Google-Smtp-Source: APBJJlHAJk0T2S0aguib7Zc0XdepjlyrQbmzro3/9o1h0bqMPXQ5c9h/HyRDtxYLkWKPrtEO1j4TGA==
X-Received: by 2002:adf:ef05:0:b0:315:7d2f:fc36 with SMTP id e5-20020adfef05000000b003157d2ffc36mr1232975wro.20.1690447543624;
        Thu, 27 Jul 2023 01:45:43 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id u13-20020a5d514d000000b003172510d19dsm1352429wrt.73.2023.07.27.01.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:45:43 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     MPTCP Upstream <mptcp@lists.linux.dev>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 5.15.y] selftests: mptcp: sockopt: use 'iptables-legacy' if available
Date:   Thu, 27 Jul 2023 10:45:22 +0200
Message-Id: <20230727084522.2035300-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023072145-cardigan-stinger-9c9a@gregkh>
References: <2023072145-cardigan-stinger-9c9a@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2796; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=+k9lBRyH4O2eIEt1+k+jsFkebCcN3ieBWl9B9paW6Vw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkwi6iyLFg36SA7RH/ecHEMjpah7erAQZtpBoAK
 KobR5U/8HmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZMIuogAKCRD2t4JPQmmg
 cwyqD/4p/B9Z4iLbxgyDMgNZyvM8aTKKE5Dsepdy7z3+N5Xzy60hPp7oMGo0SsVIJnA1GriOdPz
 lue7Qdd4Z8CxF18pb+AcX1OvJaIgM72xwu4+iUssT9DzwY6bQp5Mw4+MXG8gRc7e/BKo0Y94rVJ
 TSAaCb+fiatH4oIytgZ8eikGsYDXE+/YGxWhNlORtsmRuxhcltlk0QYnusE6m16m8GCSvv8zM/a
 LoMVJwyWCgf2rc4gM+H+F/ne4F1n0HrBomc/0tnQaUbm8qvC7oI32IyqBY6B0LXg+but7p5uzU7
 gI1U/PJPgW+Qq01GaCn27bHMxLI3f4an9pBeww8pAchFHIm2ToiDq/thnr3sti3AB3kWABnzatf
 ++Vhvl2yXndOB2wFnfjEMJnjjKTAN5i+vLo5jI35HkrYzZBWEA9J4jlQMbRD8CVUuQmTOhPNzwa
 bWPALfbJECreep3E3XzKP+CPTxuYkmVxsbZvn8CBQtkP1jpKCi5SaCQ+Ld/ffJ3ag4iJ8gWpYse
 1stuHNBeN/7nXsesCig2cHaQGVwRbKJjsPOgMG1hbVpZ3y+QrtF1Da0i6vKchhNMBTuhAYvaaH0
 qNCULKQVm4FApsXvc5os8/CXTOaH8iDJlIsSVRPFNqXzRapQAKbsdcGUpfgYwxvNttmTxQQc4Ve lyN68VZuMB5pzUQ==
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

commit a5a5990c099dd354e05e89ee77cd2dbf6655d4a1 upstream.

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
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Backport notes:
  - it was conflicting with some cleanup patches: b71dd705179c
    ("selftests: mptcp: removed defined but unused vars") and
    5f17f8e315ad ("selftests: mptcp: declare var as local")
  - conflicts were in the same context but not with the code that needed
    to be adapted.
---
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index d5c79e4a8f1e..3432d11e0a03 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -13,13 +13,15 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
 do_all_tests=1
+iptables="iptables"
+ip6tables="ip6tables"
 
 add_mark_rules()
 {
 	local ns=$1
 	local m=$2
 
-	for t in iptables ip6tables; do
+	for t in ${iptables} ${ip6tables}; do
 		# just to debug: check we have multiple subflows connection requests
 		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
 
@@ -90,14 +92,14 @@ if [ $? -ne 0 ];then
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
@@ -107,10 +109,10 @@ check_mark()
 	local ns=$1
 	local af=$2
 
-	tables=iptables
+	tables=${iptables}
 
 	if [ $af -eq 6 ];then
-		tables=ip6tables
+		tables=${ip6tables}
 	fi
 
 	counters=$(ip netns exec $ns $tables -v -L OUTPUT | grep DROP)
-- 
2.40.1

