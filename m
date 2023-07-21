Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5CA75BF3A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjGUHD4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGUHDz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:03:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F194B271F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:03:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A52A6112C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C0CC433C8;
        Fri, 21 Jul 2023 07:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689923032;
        bh=CQsoG1n5sKCXCE+X6n8SbH38oqypajfLPLRLzQFfj2U=;
        h=Subject:To:Cc:From:Date:From;
        b=nq981DBBPqcte30RfiUIrkvUWkWsB5DffktEBXmTcp+cYYiA3EP0YP7Iit+ZCEoY1
         g0VhqCXw0ykCQT/X5tH+15HdPiOIuShHrXEQD0EjS4ih+imdKCBxa3phXsGAScwCbL
         Md7H8ZdGixkD9iRe/gsnJLuXbRmNlZTrGsmdo1iY=
Subject: FAILED: patch "[PATCH] fs: dlm: interrupt posix locks only when process is killed" failed to apply to 5.15-stable tree
To:     aahringo@redhat.com, teigland@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:03:50 +0200
Message-ID: <2023072150-urgency-credit-e311@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 59e45c758ca1b9893ac923dd63536da946ac333b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072150-urgency-credit-e311@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

59e45c758ca1 ("fs: dlm: interrupt posix locks only when process is killed")
a800ba77fd28 ("dlm: rearrange async condition return")
bcbb4ba6c9ba ("dlm: cleanup plock_op vs plock_xop")
42252d0d2aa9 ("dlm: fix plock invalid read")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 59e45c758ca1b9893ac923dd63536da946ac333b Mon Sep 17 00:00:00 2001
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 19 May 2023 11:21:26 -0400
Subject: [PATCH] fs: dlm: interrupt posix locks only when process is killed

If a posix lock request is waiting for a result from user space
(dlm_controld), do not let it be interrupted unless the process
is killed. This reverts commit a6b1533e9a57 ("dlm: make posix locks
interruptible"). The problem with the interruptible change is
that all locks were cleared on any signal interrupt. If a signal
was received that did not terminate the process, the process
could continue running after all its dlm posix locks had been
cleared. A future patch will add cancelation to allow proper
interruption.

Cc: stable@vger.kernel.org
Fixes: a6b1533e9a57 ("dlm: make posix locks interruptible")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index fea2157fac5b..31bc601ee3d8 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -155,7 +155,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 
 	send_op(op);
 
-	rv = wait_event_interruptible(recv_wq, (op->done != 0));
+	rv = wait_event_killable(recv_wq, (op->done != 0));
 	if (rv == -ERESTARTSYS) {
 		spin_lock(&ops_lock);
 		/* recheck under ops_lock if we got a done != 0,

