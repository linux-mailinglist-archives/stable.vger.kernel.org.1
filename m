Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF75D73E9C3
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjFZSju (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjFZSjt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:39:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6983DA
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:39:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B60A60F18
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3624BC433C0;
        Mon, 26 Jun 2023 18:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804787;
        bh=e0lNJm3iRBZZs6fFDhE/aiDKs8jlAVJyBjcYDD2ZuEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDoNRZ6um+anOJzF97KuYwrRVH4AeVLtbw1MM56oR29NfRvqCWpnzg1b96B+gaKiV
         gbs8rXEl/Luz2iD8WtS6iL+7ZMx7JKn3di0M9zjvdXwNHxtISEjOt+w9WIwS7Lq6uG
         6BLUfuLhGWGytqwVSR8+3cHYfnQXT/iAF6zJZ2kA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 12/96] selftests: mptcp: join: use iptables-legacy if available
Date:   Mon, 26 Jun 2023 20:11:27 +0200
Message-ID: <20230626180747.426122856@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
References: <20230626180746.943455203@linuxfoundation.org>
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

commit 0c4cd3f86a40028845ad6f8af5b37165666404cd upstream.

IPTables commands using 'iptables-nft' fail on old kernels, at least
5.15 because it doesn't see the default IPTables chains:

  $ iptables -L
  iptables/1.8.2 Failed to initialize nft: Protocol not supported

As a first step before switching to NFTables, we can use iptables-legacy
if available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,6 +12,8 @@ cinfail=""
 cinsent=""
 cout=""
 ksft_skip=4
+iptables="iptables"
+ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 mptcp_connect=""
@@ -126,9 +128,9 @@ reset_with_add_addr_timeout()
 	local ip="${1:-4}"
 	local tables
 
-	tables="iptables"
+	tables="${iptables}"
 	if [ $ip -eq 6 ]; then
-		tables="ip6tables"
+		tables="${ip6tables}"
 	fi
 
 	reset
@@ -171,8 +173,10 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
-iptables -V > /dev/null 2>&1
-if [ $? -ne 0 ];then
+if iptables-legacy -V &> /dev/null; then
+	iptables="iptables-legacy"
+	ip6tables="ip6tables-legacy"
+elif ! iptables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without iptables tool"
 	exit $ksft_skip
 fi


