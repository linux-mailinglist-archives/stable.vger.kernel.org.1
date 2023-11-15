Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B152E7ECDFB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjKOTjg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjKOTjf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:39:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB0D9E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:39:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3A2C433C8;
        Wed, 15 Nov 2023 19:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077171;
        bh=U055PtNhTu723KcX9CRT8ANQYa1Foon/d9Dr128tOJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YdIGBjaX0l1q59kxADySD68ir9KaU9F8NdFswrU0U3/myBbMaZXgWk/1AVgQv4/Gv
         v8KarTdQsGrR6YwMFRWChCt2HU/B3+2sdnOFAS7oAprKrNcDiaPhqrOwkwqv8hLqfB
         bM5n80t8DQ3OQsQLtfV8vxxe2/v2OHR4j0Aow7Bg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Mat Martineau <martineau@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5 544/550] selftests: mptcp: fix wait_rm_addr/sf parameters
Date:   Wed, 15 Nov 2023 14:18:48 -0500
Message-ID: <20231115191638.626945001@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geliang Tang <geliang.tang@suse.com>

commit 9168ea02b898d3dde98b51e4bd3fb082bd438dab upstream.

The second input parameter of 'wait_rm_addr/sf $1 1' is misused. If it's
1, wait_rm_addr/sf will never break, and will loop ten times, then
'wait_rm_addr/sf' equals to 'sleep 1'. This delay time is too long,
which can sometimes make the tests fail.

A better way to use wait_rm_addr/sf is to use rm_addr/sf_count to obtain
the current value, and then pass into wait_rm_addr/sf.

Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
Cc: stable@vger.kernel.org
Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231025-send-net-next-20231025-v1-2-db8f25f798eb@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3259,6 +3259,7 @@ userspace_pm_rm_sf_addr_ns1()
 	local addr=$1
 	local id=$2
 	local tk sp da dp
+	local cnt_addr cnt_sf
 
 	tk=$(grep "type:1," "$evts_ns1" |
 	     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
@@ -3268,11 +3269,13 @@ userspace_pm_rm_sf_addr_ns1()
 	     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
 	dp=$(grep "type:10" "$evts_ns1" |
 	     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt_addr=$(rm_addr_count ${ns1})
+	cnt_sf=$(rm_sf_count ${ns1})
 	ip netns exec $ns1 ./pm_nl_ctl rem token $tk id $id
 	ip netns exec $ns1 ./pm_nl_ctl dsf lip "::ffff:$addr" \
 				lport $sp rip $da rport $dp token $tk
-	wait_rm_addr $ns1 1
-	wait_rm_sf $ns1 1
+	wait_rm_addr $ns1 "${cnt_addr}"
+	wait_rm_sf $ns1 "${cnt_sf}"
 }
 
 userspace_pm_add_sf()
@@ -3294,17 +3297,20 @@ userspace_pm_rm_sf_addr_ns2()
 	local addr=$1
 	local id=$2
 	local tk da dp sp
+	local cnt_addr cnt_sf
 
 	tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
 	da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
 	dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
 	sp=$(grep "type:10" "$evts_ns2" |
 	     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	cnt_addr=$(rm_addr_count ${ns2})
+	cnt_sf=$(rm_sf_count ${ns2})
 	ip netns exec $ns2 ./pm_nl_ctl rem token $tk id $id
 	ip netns exec $ns2 ./pm_nl_ctl dsf lip $addr lport $sp \
 				rip $da rport $dp token $tk
-	wait_rm_addr $ns2 1
-	wait_rm_sf $ns2 1
+	wait_rm_addr $ns2 "${cnt_addr}"
+	wait_rm_sf $ns2 "${cnt_sf}"
 }
 
 userspace_tests()


