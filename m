Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134A97ECCC2
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjKOTc3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjKOTcY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:32:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE8A130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:32:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F78C433CC;
        Wed, 15 Nov 2023 19:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076740;
        bh=pwbNxomCrhpWEQ3K4KC84H889aJN6499h/acS3qMQHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q8r/SnpjMv9cLrDvICjjTMpIODItCiHTTe+syxTr6xyymWNfGdVO4vmLNF/BWdNLA
         O6MqJeegKmEKruGrb3eAPDqKVC2gUY4CKEaBJ6O7JszMuW05Xq3xlWfcIwhx+ie1wX
         bxuhBytcEsyiK9LZ+ZzBGa535N3YCd49ZRzUph8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yi Yang <yiyang13@huawei.com>,
        GUO Zihua <guozihua@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 386/550] tty: tty_jobctrl: fix pid memleak in disassociate_ctty()
Date:   Wed, 15 Nov 2023 14:16:10 -0500
Message-ID: <20231115191627.601822092@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yi Yang <yiyang13@huawei.com>

[ Upstream commit 11e7f27b79757b6586645d87b95d5b78375ecdfc ]

There is a pid leakage:
------------------------------
unreferenced object 0xffff88810c181940 (size 224):
  comm "sshd", pid 8191, jiffies 4294946950 (age 524.570s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 ad 4e ad de  .............N..
    ff ff ff ff 6b 6b 6b 6b ff ff ff ff ff ff ff ff  ....kkkk........
  backtrace:
    [<ffffffff814774e6>] kmem_cache_alloc+0x5c6/0x9b0
    [<ffffffff81177342>] alloc_pid+0x72/0x570
    [<ffffffff81140ac4>] copy_process+0x1374/0x2470
    [<ffffffff81141d77>] kernel_clone+0xb7/0x900
    [<ffffffff81142645>] __se_sys_clone+0x85/0xb0
    [<ffffffff8114269b>] __x64_sys_clone+0x2b/0x30
    [<ffffffff83965a72>] do_syscall_64+0x32/0x80
    [<ffffffff83a00085>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

It turns out that there is a race condition between disassociate_ctty() and
tty_signal_session_leader(), which caused this leakage.

The pid memleak is triggered by the following race:
task[sshd]                     task[bash]
-----------------------        -----------------------
                               disassociate_ctty();
                               spin_lock_irq(&current->sighand->siglock);
                               put_pid(current->signal->tty_old_pgrp);
                               current->signal->tty_old_pgrp = NULL;
                               tty = tty_kref_get(current->signal->tty);
                               spin_unlock_irq(&current->sighand->siglock);
tty_vhangup();
tty_lock(tty);
...
tty_signal_session_leader();
spin_lock_irq(&p->sighand->siglock);
...
if (tty->ctrl.pgrp) //tty->ctrl.pgrp is not NULL
p->signal->tty_old_pgrp = get_pid(tty->ctrl.pgrp); //An extra get
spin_unlock_irq(&p->sighand->siglock);
...
tty_unlock(tty);
                               if (tty) {
                                   tty_lock(tty);
                                   ...
                                   put_pid(tty->ctrl.pgrp);
                                   tty->ctrl.pgrp = NULL; //It's too late
                                   ...
                                   tty_unlock(tty);
                               }

The issue is believed to be introduced by commit c8bcd9c5be24 ("tty:
Fix ->session locking") who moves the unlock of siglock in
disassociate_ctty() above "if (tty)", making a small window allowing
tty_signal_session_leader() to kick in. It can be easily reproduced by
adding a delay before "if (tty)" and at the entrance of
tty_signal_session_leader().

To fix this issue, we move "put_pid(current->signal->tty_old_pgrp)" after
"tty->ctrl.pgrp = NULL".

Fixes: c8bcd9c5be24 ("tty: Fix ->session locking")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Co-developed-by: GUO Zihua <guozihua@huawei.com>
Signed-off-by: GUO Zihua <guozihua@huawei.com>
Link: https://lore.kernel.org/r/20230831023329.165737-1-yiyang13@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_jobctrl.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 0d04287da0984..ef8741c3e6629 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -300,12 +300,7 @@ void disassociate_ctty(int on_exit)
 		return;
 	}
 
-	spin_lock_irq(&current->sighand->siglock);
-	put_pid(current->signal->tty_old_pgrp);
-	current->signal->tty_old_pgrp = NULL;
-	tty = tty_kref_get(current->signal->tty);
-	spin_unlock_irq(&current->sighand->siglock);
-
+	tty = get_current_tty();
 	if (tty) {
 		unsigned long flags;
 
@@ -320,6 +315,16 @@ void disassociate_ctty(int on_exit)
 		tty_kref_put(tty);
 	}
 
+	/* If tty->ctrl.pgrp is not NULL, it may be assigned to
+	 * current->signal->tty_old_pgrp in a race condition, and
+	 * cause pid memleak. Release current->signal->tty_old_pgrp
+	 * after tty->ctrl.pgrp set to NULL.
+	 */
+	spin_lock_irq(&current->sighand->siglock);
+	put_pid(current->signal->tty_old_pgrp);
+	current->signal->tty_old_pgrp = NULL;
+	spin_unlock_irq(&current->sighand->siglock);
+
 	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
 	session_clear_tty(task_session(current));
-- 
2.42.0



