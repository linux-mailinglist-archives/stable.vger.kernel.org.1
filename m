Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2947398C1
	for <lists+stable@lfdr.de>; Thu, 22 Jun 2023 09:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjFVH6r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 03:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjFVH6m (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 03:58:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D812102
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 00:58:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 632D06178A
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 07:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F3FC433C8;
        Thu, 22 Jun 2023 07:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687420688;
        bh=v43zjBUCrNubr+aEPRcS7a47o1SEmTD0k39mbP3jUpE=;
        h=Subject:To:Cc:From:Date:From;
        b=hVuAQfHX+m890/51CNMvAgaY94aJcoOHUzXoUi2rGWclK2H0qT0jNaIwJkuHn7KVe
         JpogbTR37DUV9iyIIGgVKB6gFkSrzUHO22lpIEP8du+WGR90EGkssBHG82YN6p2x+s
         5TDwVuvyFdanckPKi1csizoEboTOOyT96TwhQYF8=
Subject: FAILED: patch "[PATCH] selftests: mptcp: sockopt: skip TCP_INQ checks if not" failed to apply to 6.1-stable tree
To:     matthieu.baerts@tessares.net, kuba@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 22 Jun 2023 09:58:06 +0200
Message-ID: <2023062206-muzzle-pope-0802@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b631e3a4e94c77c9007d60b577a069c203ce9594
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062206-muzzle-pope-0802@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b631e3a4e94c77c9007d60b577a069c203ce9594 Mon Sep 17 00:00:00 2001
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 8 Jun 2023 18:38:53 +0200
Subject: [PATCH] selftests: mptcp: sockopt: skip TCP_INQ checks if not
 supported

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is TCP_INQ cmsg support introduced in commit 2c9e77659a0c
("mptcp: add TCP_INQ cmsg support").

It is possible to look for "mptcp_ioctl" in kallsyms because it was
needed to introduce the mentioned feature. We can skip these tests and
not set TCPINQ option if the feature is not supported.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 5cbd886ce2a9 ("selftests: mptcp: add TCP_INQ support")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 1d4ae8792227..f295a371ff14 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -187,9 +187,14 @@ do_transfer()
 		local_addr="0.0.0.0"
 	fi
 
+	cmsg="TIMESTAMPNS"
+	if mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		cmsg+=",TCPINQ"
+	fi
+
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
-			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
 				${local_addr} < "$sin" > "$sout" &
 	local spid=$!
 
@@ -197,7 +202,7 @@ do_transfer()
 
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
-			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c "${cmsg}" \
 				$connect_addr < "$cin" > "$cout" &
 
 	local cpid=$!
@@ -313,6 +318,11 @@ do_tcpinq_tests()
 {
 	local lret=0
 
+	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		echo "INFO: TCP_INQ not supported: SKIP"
+		return
+	fi
+
 	local args
 	for args in "-t tcp" "-r tcp"; do
 		do_tcpinq_test $args

