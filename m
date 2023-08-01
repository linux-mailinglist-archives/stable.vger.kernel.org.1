Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8C876A892
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 08:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjHAGAQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 02:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjHAGAP (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 02:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975C0E7D
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 23:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F3D761470
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 06:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04737C433C8;
        Tue,  1 Aug 2023 06:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690869613;
        bh=8pp+y66vjbZpLMWYEtgBID/J2qeU+vQWYzcU5l4RD5M=;
        h=Subject:To:Cc:From:Date:From;
        b=esbvfdZhrbeuhp8cXUEF867fQvJ8HFwaMsivvf1NtJfBu6ZhW7vkU9N/1Kvufclle
         r8lancSlL9CdDO+OCzAU2xXLluDQeX54g+N6cnNzDZTm8VWcIg539KrNr2oiAWFoSd
         wgcJ4Nj/ckh8o8IqhxPjZphGtsOAo77G9XLY+eBg=
Subject: FAILED: patch "[PATCH] selftests: mptcp: join: only check for ip6tables if needed" failed to apply to 5.15-stable tree
To:     matthieu.baerts@tessares.net, kuba@kernel.org,
        martineau@kernel.org, pabeni@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 01 Aug 2023 08:00:04 +0200
Message-ID: <2023080104-stability-porcupine-fbad@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 016e7ba47f33064fbef8c4307a2485d2669dfd03
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080104-stability-porcupine-fbad@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

016e7ba47f33 ("selftests: mptcp: join: only check for ip6tables if needed")
87154755d90e ("selftests: mptcp: join: check for tools only if needed")
93827ad58f62 ("selftests: mptcp: join: create tmp files only if needed")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 016e7ba47f33064fbef8c4307a2485d2669dfd03 Mon Sep 17 00:00:00 2001
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 25 Jul 2023 11:34:55 -0700
Subject: [PATCH] selftests: mptcp: join: only check for ip6tables if needed

If 'iptables-legacy' is available, 'ip6tables-legacy' command will be
used instead of 'ip6tables'. So no need to look if 'ip6tables' is
available in this case.

Cc: stable@vger.kernel.org
Fixes: 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20230725-send-net-20230725-v1-1-6f60fe7137a9@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

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

