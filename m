Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582D8762174
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjGYSfD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 14:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjGYSfC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 14:35:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF1F1989
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 409B061874
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 18:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB2FC433CB;
        Tue, 25 Jul 2023 18:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690310099;
        bh=QwCnG5+Z7TjpjUwNXP4jPD4RDLcuQH9RqoFnYbUu7zk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=WLf9j7bNRkk+C8wUwtTrglbCQ3trv6Z5i+Zv5RaFOU5WMeevBR/rtSw8yhsVhBBfw
         dyHdV38/mRlnvb23QCiusBcAHxk7+94J21m7kZ+lSCKX9ul+lGD2jsU8tePClT8+kU
         7uUZTlvC9zwgqNmqilX6liw03A3rTxbKOTWeQYV1Gq0bYjMsuUFlEwObeKUaadu8rH
         HzNOje1HztlFsHcRZvusUrku48cZorlJlRHHffHCkw8FtJNVp5kW7a6BoJhaIv7KOY
         c6gJebLmPrmnh7iOuvGrKkEmuZzaN5+MZYRaplzGLZsYYviKfmpcQqo4S/1amIDrCQ
         p3rBM5xXuYBgQ==
From:   Mat Martineau <martineau@kernel.org>
Date:   Tue, 25 Jul 2023 11:34:55 -0700
Subject: [PATCH net 1/2] selftests: mptcp: join: only check for ip6tables
 if needed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-send-net-20230725-v1-1-6f60fe7137a9@kernel.org>
References: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
In-Reply-To: <20230725-send-net-20230725-v1-0-6f60fe7137a9@kernel.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Geliang Tang <geliang.tang@suse.com>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        stable@vger.kernel.org, Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.3
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

If 'iptables-legacy' is available, 'ip6tables-legacy' command will be
used instead of 'ip6tables'. So no need to look if 'ip6tables' is
available in this case.

Fixes: 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e6c9d5451c5b..3c2096ac97ef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -162,9 +162,7 @@ check_tools()
 	elif ! iptables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without iptables tool"
 		exit $ksft_skip
-	fi
-
-	if ! ip6tables -V &> /dev/null; then
+	elif ! ip6tables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without ip6tables tool"
 		exit $ksft_skip
 	fi

-- 
2.41.0

