Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF63B721C7C
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 05:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjFEDZd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 4 Jun 2023 23:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjFEDZb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Jun 2023 23:25:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEB6CD
        for <stable@vger.kernel.org>; Sun,  4 Jun 2023 20:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C6C160C8C
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 03:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F219C433A0;
        Mon,  5 Jun 2023 03:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685935529;
        bh=vCS+0O+llNRhLjcqsTnAJiVXReGH+K2zHMbKF1jlOBc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=u9JkjjhpBuiI/wY6qZTXlttG13d/h1RcrVbqAbBfauQK1XJJLgOlmTCOHIbHbrEO4
         0TE8eu1OJQ7HCWVtuHuTWL2bA5hC5+mVowI6XMdcD32kzURVb5fsFRxoKkjDky/tOH
         uTnGiAHT54lqTPbIObf+VQygIWjYmxUFKYnU5o6YEQY6UDbHjUd1pB6+8Xz2gLLQyY
         zhlI6ZJ7Q61FsiZBAxSXbI7V1BOPS4vbAUU9sYxDxKjmcosU472weRZTzzoUsi/wPD
         i4K+y8c1lGW86ORL6ks/36JG3f7scNPPUGld4XFVAhfJFeXrKPnKeJqKUfhkO0ZxRS
         2fKAB8jbxLXIQ==
From:   Mat Martineau <martineau@kernel.org>
Date:   Sun, 04 Jun 2023 20:25:18 -0700
Subject: [PATCH net 2/5] selftests: mptcp: update userspace pm addr tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230602-send-net-20230602-v1-2-fe011dfa859d@kernel.org>
References: <20230602-send-net-20230602-v1-0-fe011dfa859d@kernel.org>
In-Reply-To: <20230602-send-net-20230602-v1-0-fe011dfa859d@kernel.org>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kishen Maloor <kishen.maloor@intel.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Florian Westphal <fw@strlen.de>
Cc:     netdev@vger.kernel.org, mptcp@lists.linux.dev,
        Mat Martineau <martineau@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Geliang Tang <geliang.tang@suse.com>

This patch is linked to the previous commit ("mptcp: only send RM_ADDR in
nl_cmd_remove").

To align with what is done by the in-kernel PM, update userspace pm addr
selftests, by sending a remove_subflows command together after the
remove_addrs command.

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Fixes: 97040cf9806e ("selftests: mptcp: userspace pm address tests")
Cc: stable@vger.kernel.org
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 96f63172b8fe..651740a656f0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -862,7 +862,15 @@ do_transfer()
 				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
 				sleep 1
+				sp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+				da=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+				dp=$(grep "type:10" "$evts_ns1" |
+				     sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
+				ip netns exec ${listener_ns} ./pm_nl_ctl dsf lip "::ffff:$addr" \
+							lport $sp rip $da rport $dp token $tk
 			fi
 
 			counter=$((counter + 1))

-- 
2.40.1

