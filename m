Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AE873E8BE
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjFZS3O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjFZS2z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:28:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CA41715
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD46660F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69DAC433C0;
        Mon, 26 Jun 2023 18:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804098;
        bh=8tv5oM6vRsiAtmHxDxsSG1W5kaOzt3DQqvfezAMBi2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZcksviJlgTqW7e5Vt8GnOZ6AalwKfIBDn29U6CAk3S8pKj7BSu9ySAzZF0ger6vjG
         ZswBOhy5zfmUcon+2hPYTcSB7P2r6s+8cf0yyOc2Jv9S+WKn+LowBY/9ZCF9oClRbo
         WZcV/HaaPJaAyRJ/lKiXTvi9cmeAXYN/9xSRE/6k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 040/170] selftests: mptcp: join: skip userspace PM tests if not supported
Date:   Mon, 26 Jun 2023 20:10:09 +0200
Message-ID: <20230626180802.337840182@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   26 +++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

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


