Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5657CE644
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 20:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjJRSYG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 14:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjJRSYF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 14:24:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3E7F7
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 11:24:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03943C433D9;
        Wed, 18 Oct 2023 18:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697653443;
        bh=uMZX/B6ZarsMvm/WGOAr/UwyvhAfU161tjHBCE2TWoM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=TO7IGrzznb0rQDyEGWS+KgZS5bxB/kk/bW0u1rPFpaskzCIZ1vNkX1IU4m3Pwt4nh
         NaIcelycInJ724A0JCHGRxrWgQJWzWwA7EMMEzeSBwZWNjCAwEKK+jIX+PfktFgiCw
         E1nyawsIO4Lfec7fwCpA4ndx2FEcSXuM5a6rSIgwhF/r9QMUEgi6CFESw+yBgj0gYB
         A1THBnPf3JG7KD88uGyKnzO0h9zsMDHpaXiMJo3o8mqgxSz1WVlGBR99NCCkwvB1s3
         M2o7dIh604rdREaViAxegxMOSawQ+edmgm8LHAJVUyTysgm+H3oxxYEUxw0Jmava7m
         s0Q+ANhTDE+1A==
From:   Mat Martineau <martineau@kernel.org>
Date:   Wed, 18 Oct 2023 11:23:52 -0700
Subject: [PATCH net 1/5] selftests: mptcp: join: correctly check for no RST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-send-net-20231018-v1-1-17ecb002e41d@kernel.org>
References: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
In-Reply-To: <20231018-send-net-20231018-v1-0-17ecb002e41d@kernel.org>
To:     Matthieu Baerts <matttbe@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Davide Caratti <dcaratti@redhat.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matttbe@kernel.org>

The commit mentioned below was more tolerant with the number of RST seen
during a test because in some uncontrollable situations, multiple RST
can be generated.

But it was not taking into account the case where no RST are expected:
this validation was then no longer reporting issues for the 0 RST case
because it is not possible to have less than 0 RST in the counter. This
patch fixes the issue by adding a specific condition.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ee1f89a872b3..27953670206e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1432,7 +1432,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		print_skip
-	elif [ $count -lt $rst_tx ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_tx -ne 0 ] && [ $count -lt $rst_tx ]; } ||
+	     { [ $rst_tx -eq 0 ] && [ $count -ne 0 ]; }; then
 		fail_test "got $count MP_RST[s] TX expected $rst_tx"
 	else
 		print_ok
@@ -1442,7 +1444,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		print_skip
-	elif [ "$count" -lt "$rst_rx" ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_rx -ne 0 ] && [ $count -lt $rst_rx ]; } ||
+	     { [ $rst_rx -eq 0 ] && [ $count -ne 0 ]; }; then
 		fail_test "got $count MP_RST[s] RX expected $rst_rx"
 	else
 		print_ok

-- 
2.41.0

