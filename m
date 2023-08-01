Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0549276AECF
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjHAJmI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjHAJl4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:41:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED90E59C8
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE97E613E2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8E5C433C7;
        Tue,  1 Aug 2023 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882771;
        bh=mXIVyBKcZTTKoFbBaFMpC2ju2+x+K8fEARmph0vdraw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXcDCwA/6rKKGsPpTsbceHVfgTkrhIxxkmSsUuxqzvrKmi2Rl6asO4ZvfbEKUFXq4
         1oHwBrxEbft9I1tKTtyo5ODC1D5xT7M2qJit2XrEOv3gsisFBlbgLZ4lRPZUHrTprR
         b2FGguPB0a7jzEDDyTsSFMnxJz1MJhxmjGUDQROk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.1 225/228] selftests: mptcp: sockopt: use iptables-legacy if available
Date:   Tue,  1 Aug 2023 11:21:23 +0200
Message-ID: <20230801091930.977104536@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Matthieu Baerts <matthieu.baerts@tessares.net>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |   24 +++++++++++----------
 1 file changed, 13 insertions(+), 11 deletions(-)

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
 
@@ -92,14 +94,14 @@ if [ $? -ne 0 ];then
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
@@ -109,10 +111,10 @@ check_mark()
 	local ns=$1
 	local af=$2
 
-	tables=iptables
+	tables=${iptables}
 
 	if [ $af -eq 6 ];then
-		tables=ip6tables
+		tables=${ip6tables}
 	fi
 
 	counters=$(ip netns exec $ns $tables -v -L OUTPUT | grep DROP)
@@ -314,8 +316,8 @@ do_tcpinq_tests()
 {
 	local lret=0
 
-	ip netns exec "$ns1" iptables -F
-	ip netns exec "$ns1" ip6tables -F
+	ip netns exec "$ns1" ${iptables} -F
+	ip netns exec "$ns1" ${ip6tables} -F
 
 	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
 		echo "INFO: TCP_INQ not supported: SKIP"


