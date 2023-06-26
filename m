Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BC373E8B2
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjFZS2q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjFZS2Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:28:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBCA2115
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CFAC60EFC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4FFC433C0;
        Mon, 26 Jun 2023 18:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804063;
        bh=ZP66lTbriuliz+SAo9+QFcfC476kOMIh4u565VblCx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2vkgGUEg23LRJ+E9bbVKDCp3G3b1JxtthFef1fYPknvWQ0GsWZH25+w+EQ5qPjVoj
         6OCAfO0jYjxtmBjDV6nFoEH+ZJrkY3Zswb7SCpm6SsG0c6jCxYxlbFLoXDudAhCA23
         ijuluzKPAo2QPRdI3ao537eeP2zHHftcaTQC5htQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 029/170] selftests: mptcp: join: support local endpoint being tracked or not
Date:   Mon, 26 Jun 2023 20:09:58 +0200
Message-ID: <20230626180801.850820067@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

commit d4c81bbb8600257fd3076d0196cb08bd2e5bdf24 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

At some points, a new feature caused internal behaviour changes we are
verifying in the selftests, see the Fixes tag below. It was not a uAPI
change but because in these selftests, we check some internal
behaviours, it is normal we have to adapt them from time to time after
having added some features.

It is possible to look for "mptcp_pm_subflow_check_next" in kallsyms
because it was needed to introduce the mentioned feature. So we can know
in advance what the behaviour we are expecting here instead of
supporting the two behaviours.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2064,11 +2064,18 @@ signal_address_tests()
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
-		chk_join_nr 3 3 3
 
-		# the server will not signal the address terminating
-		# the MPC subflow
-		chk_add_nr 3 3
+		# It is not directly linked to the commit introducing this
+		# symbol but for the parent one which is linked anyway.
+		if ! mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
+			chk_join_nr 3 3 2
+			chk_add_nr 4 4
+		else
+			chk_join_nr 3 3 3
+			# the server will not signal the address terminating
+			# the MPC subflow
+			chk_add_nr 3 3
+		fi
 	fi
 }
 


