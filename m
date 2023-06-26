Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C7073E78F
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjFZSQh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjFZSQf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:16:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F6BE44
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6651160F3E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E90AC433C0;
        Mon, 26 Jun 2023 18:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803386;
        bh=MHTuyvWLsollqj7cq6TUAV9tq16VoQCsgwBkTl/hgVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ylk0tXrmbmyg65yAVxWkZugqVbmer7Gpf7OdnEGnfkYYVMdkJ3LkFzON4oJnJJZWi
         6bQGCd/8WTcXY2Kbgs6eVHA/RUw0O3YZXMjYHLDEHZ3BkncRXy5c55I/bW+79X9gX/
         LaNyLcoL3b/BW9bidE849DLTbn0zcnczujwVCppM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.3 044/199] selftests: mptcp: join: skip fullmesh flag tests if not supported
Date:   Mon, 26 Jun 2023 20:09:10 +0200
Message-ID: <20230626180807.527679330@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 9db34c4294af9999edc773d96744e2d2d4eb5060 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of the fullmesh flag for the in-kernel PM
introduced by commit 2843ff6f36db ("mptcp: remote addresses fullmesh")
and commit 1a0d6136c5f0 ("mptcp: local addresses fullmesh").

It looks like there is no easy external sign we can use to predict the
expected behaviour. We could add the flag and then check if it has been
added but for that, and for each fullmesh test, we would need to setup a
new environment, do the checks, clean it and then only start the test
from yet another clean environment. To keep it simple and avoid
introducing new issues, we look for a specific kernel version. That's
not ideal but an acceptable solution for this case.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 6a0653b96f5d ("selftests: mptcp: add fullmesh setting tests")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3058,7 +3058,8 @@ fullmesh_tests()
 	fi
 
 	# set fullmesh flag
-	if reset "set fullmesh flag test"; then
+	if reset "set fullmesh flag test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
@@ -3068,7 +3069,8 @@ fullmesh_tests()
 	fi
 
 	# set nofullmesh flag
-	if reset "set nofullmesh flag test"; then
+	if reset "set nofullmesh flag test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
@@ -3078,7 +3080,8 @@ fullmesh_tests()
 	fi
 
 	# set backup,fullmesh flags
-	if reset "set backup,fullmesh flags test"; then
+	if reset "set backup,fullmesh flags test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
@@ -3089,7 +3092,8 @@ fullmesh_tests()
 	fi
 
 	# set nobackup,nofullmesh flags
-	if reset "set nobackup,nofullmesh flags test"; then
+	if reset "set nobackup,nofullmesh flags test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh


