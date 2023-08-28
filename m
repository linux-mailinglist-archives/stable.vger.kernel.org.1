Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FFC78AC97
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjH1KlJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjH1Kk5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:40:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDA1131
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9A826100C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED79FC433C8;
        Mon, 28 Aug 2023 10:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219251;
        bh=kZCqamOnE4ZHwPtQ/gHM18npCJoSWiWTPW0RHl3lmLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmzvMU/0shVTtUGXwmt0BuXnMYMKbeiOr9x3EGO4yDC1TR95IwI9lCZqN1kArdCHj
         dxGMYZ25uIz+2YuTt8IMz9JVax2oFqRWW1nwu3coH1DfQfZFdwAvp3UzjDv3T3Rb8Y
         WkbVeckYgCeHWaF4UxNC+mdB9wr5Fn7mdxexRk40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 100/158] fs: dlm: use dlm_plock_info for do_unlock_close
Date:   Mon, 28 Aug 2023 12:13:17 +0200
Message-ID: <20230828101200.683064751@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit 4d413ae9ced4180c0e2114553c3a7560b509b0f8 ]

This patch refactors do_unlock_close() by using only struct dlm_plock_info
as a parameter.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Stable-dep-of: 57e2c2f2d94c ("fs: dlm: fix mismatch of plock results from userspace")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/plock.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 0d00ca2c44c71..fa8969c0a5f55 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -80,8 +80,7 @@ static void send_op(struct plock_op *op)
    abandoned waiter.  So, we have to insert the unlock-close when the
    lock call is interrupted. */
 
-static void do_unlock_close(struct dlm_ls *ls, u64 number,
-			    struct file *file, struct file_lock *fl)
+static void do_unlock_close(const struct dlm_plock_info *info)
 {
 	struct plock_op *op;
 
@@ -90,15 +89,12 @@ static void do_unlock_close(struct dlm_ls *ls, u64 number,
 		return;
 
 	op->info.optype		= DLM_PLOCK_OP_UNLOCK;
-	op->info.pid		= fl->fl_pid;
-	op->info.fsid		= ls->ls_global_id;
-	op->info.number		= number;
+	op->info.pid		= info->pid;
+	op->info.fsid		= info->fsid;
+	op->info.number		= info->number;
 	op->info.start		= 0;
 	op->info.end		= OFFSET_MAX;
-	if (fl->fl_lmops && fl->fl_lmops->lm_grant)
-		op->info.owner	= (__u64) fl->fl_pid;
-	else
-		op->info.owner	= (__u64)(long) fl->fl_owner;
+	op->info.owner		= info->owner;
 
 	op->info.flags |= DLM_PLOCK_FL_CLOSE;
 	send_op(op);
@@ -168,7 +164,7 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 			  __func__, ls->ls_global_id,
 			  (unsigned long long)number, op->info.pid);
 		dlm_release_plock_op(op);
-		do_unlock_close(ls, number, file, fl);
+		do_unlock_close(&op->info);
 		goto out;
 	}
 
-- 
2.40.1



