Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE4875CA33
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbjGUOiO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjGUOhy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B5F2D77
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61F9561B41
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7275CC433C8;
        Fri, 21 Jul 2023 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950271;
        bh=aBQ+WWLZnTI2xH+E+YoEoizqbB+Wrr4Izohh2By5PAI=;
        h=Subject:To:Cc:From:Date:From;
        b=hylQRojOgVnZByoDQR6uGPUw7JRNPVq61ayOvJ37cKr4K5Kdwg9zQwILztAssYeEe
         /lWGaYe6UUy9L+N3Plw8aLkfKt0+kMLt3jxR0s4TebDvJJPz86HLihUhn/EA5kAlDC
         LAfR7fJXijAoXzZQoXpEu23pGfJYQvJvPkrrvuMw=
Subject: FAILED: patch "[PATCH] selftests: mptcp: depend on SYN_COOKIES" failed to apply to 5.10-stable tree
To:     matthieu.baerts@tessares.net, davem@davemloft.net
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:37:49 +0200
Message-ID: <2023072148-curry-reboot-ef1c@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6c8880fcaa5c45355179b759c1d11737775e31fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072148-curry-reboot-ef1c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

6c8880fcaa5c ("selftests: mptcp: depend on SYN_COOKIES")
8d014eaa9254 ("selftests: mptcp: add ADD_ADDR timeout test case")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6c8880fcaa5c45355179b759c1d11737775e31fc Mon Sep 17 00:00:00 2001
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 4 Jul 2023 22:44:40 +0200
Subject: [PATCH] selftests: mptcp: depend on SYN_COOKIES

MPTCP selftests are using TCP SYN Cookies for quite a while now, since
v5.9.

Some CIs don't have this config option enabled and this is causing
issues in the tests:

  # ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP     (duration   167ms) sysctl: cannot stat /proc/sys/net/ipv4/tcp_syncookies: No such file or directory
  # [ OK ]./mptcp_connect.sh: line 554: [: -eq: unary operator expected

There is no impact in the results but the test is not doing what it is
supposed to do.

Fixes: fed61c4b584c ("selftests: mptcp: make 2nd net namespace use tcp syn cookies unconditionally")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 6032f9b23c4c..e317c2e44dae 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -6,6 +6,7 @@ CONFIG_INET_DIAG=m
 CONFIG_INET_MPTCP_DIAG=m
 CONFIG_VETH=y
 CONFIG_NET_SCH_NETEM=m
+CONFIG_SYN_COOKIES=y
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_NETLINK=m

