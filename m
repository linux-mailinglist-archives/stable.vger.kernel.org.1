Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4652573E78B
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjFZSQU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjFZSQR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:16:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AB710FB
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:16:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDFAC60F52
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2337C433C9;
        Mon, 26 Jun 2023 18:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803375;
        bh=oZBcFVMY4skCKLgh71DrOX+g8oTb1SFo68ZpnFEv1Ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FksrG0vqESSrrODKrr9GoLn399S2loo8Nlvmfl0f9oubOEAqwE0JkYHT3W/vUzSGG
         KJvXgFw3N9nbov3bYxDtx3DomLTl8bQjCQIPD+wqDOAX/TpZ70/R5JyfkfqyEI47qS
         M+UbGgtG1L4TRpVLZYTCtLs3Vh5SgcehLX7AjU5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.3 040/199] selftests: mptcp: join: skip Fastclose tests if not supported
Date:   Mon, 26 Jun 2023 20:09:06 +0200
Message-ID: <20230626180807.348257951@linuxfoundation.org>
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

commit ae947bb2c253ff5f395bb70cb9db8700543bf398 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of MP_FASTCLOSE introduced in commit
f284c0c77321 ("mptcp: implement fastclose xmit path").

If the MIB counter is not available, the test cannot be verified and the
behaviour will not be the expected one. So we can skip the test if the
counter is missing.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 01542c9bf9ab ("selftests: mptcp: add fastclose testcase")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -261,6 +261,19 @@ reset()
 	return 0
 }
 
+# $1: test name ; $2: counter to check
+reset_check_counter()
+{
+	reset "${1}" || return 1
+
+	local counter="${2}"
+
+	if ! nstat -asz "${counter}" | grep -wq "${counter}"; then
+		mark_as_skipped "counter '${counter}' is not available"
+		return 1
+	fi
+}
+
 # $1: test name
 reset_with_cookies()
 {
@@ -3081,14 +3094,14 @@ fullmesh_tests()
 
 fastclose_tests()
 {
-	if reset "fastclose test"; then
+	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
 		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
-	if reset "fastclose server test"; then
+	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
 		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert


