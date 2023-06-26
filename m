Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967F873E793
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjFZSQl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFZSQk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:16:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F95D130
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F369860F4D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08048C433C8;
        Mon, 26 Jun 2023 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803398;
        bh=RARs85Ojka1E6asJBFfBb3vHtgGkKbazwsgLZNoN/fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wqe/3c9VDR10W88+EfHMVhA/4AWIZ1bCdadYwY5ULUZ8IQsSTEvHzaH9dQcuT0mO5
         Rvs9y/qGrnlzZ/frittSn1tK683LxK29lT9qPAiNfTklPSZ2emG4gyuQicnYPc9+qu
         u1eeAKjrEpC936gXs4xPkq2yUesiEaoQoe/VfxMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.3 047/199] selftests: mptcp: join: skip MPC backups tests if not supported
Date:   Mon, 26 Jun 2023 20:09:13 +0200
Message-ID: <20230626180807.649760872@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

commit 632978f0a961b4591a05ba9e39eab24541d83e84 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of sending an MP_PRIO signal for the initial
subflow, introduced by commit c157bbe776b7 ("mptcp: allow the in kernel
PM to set MPC subflow priority").

It is possible to look for "mptcp_subflow_send_ack" in kallsyms because
it was needed to introduce the mentioned feature. So we can know in
advance if the feature is supported instead of trying and accepting any
results.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 914f6a59b10f ("selftests: mptcp: add MPC backup tests")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2673,14 +2673,16 @@ backup_tests()
 		chk_prio_nr 1 1
 	fi
 
-	if reset "mpc backup"; then
+	if reset "mpc backup" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
 
-	if reset "mpc backup both sides"; then
+	if reset "mpc backup both sides" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
@@ -2688,14 +2690,16 @@ backup_tests()
 		chk_prio_nr 1 1
 	fi
 
-	if reset "mpc switch to backup"; then
+	if reset "mpc switch to backup" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
 
-	if reset "mpc switch to backup both sides"; then
+	if reset "mpc switch to backup both sides" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup


