Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203DF725EAB
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 14:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbjFGMSd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 08:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240610AbjFGMSb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 08:18:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EA21FC0
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 05:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1844863E64
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 12:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291F0C4339E;
        Wed,  7 Jun 2023 12:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686140308;
        bh=EzWT/GUMIkDFg0lx7pdzuYxM+nFgbM887HXkj4hddlI=;
        h=Subject:To:Cc:From:Date:From;
        b=hIIMmStEyNZ9c1Y7ymzpQ76RtWr59M4HLQ8HWgIaNzW4dEN5cDuwj8AOAtx4HEbLN
         DbyFbJMGUFEuHDWL2UqZlxrONjgzKzGEJJBbpHLs8uQX9JNXh8y0Sd5xJ5aA3J0rNs
         FWsDi9Dg/IZbZqUswTM58ipDkYs3rCxSVkLByto8=
Subject: FAILED: patch "[PATCH] selftests: mptcp: diag: skip if MPTCP is not supported" failed to apply to 5.10-stable tree
To:     matthieu.baerts@tessares.net, pabeni@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 07 Jun 2023 14:18:16 +0200
Message-ID: <2023060716-speckled-duchess-40d9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 46565acdd29facbf418a11e4a3791b3c8967308d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060716-speckled-duchess-40d9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 46565acdd29facbf418a11e4a3791b3c8967308d Mon Sep 17 00:00:00 2001
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Sun, 28 May 2023 19:35:30 +0200
Subject: [PATCH] selftests: mptcp: diag: skip if MPTCP is not supported

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index ef628b16fe9b..4eacdb1ab962 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
@@ -31,6 +33,8 @@ cleanup()
 	ip netns del $ns
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"

