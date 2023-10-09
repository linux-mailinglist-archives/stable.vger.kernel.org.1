Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB07BDE02
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376895AbjJINO5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376866AbjJINO4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:14:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50526DA
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:14:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09EAC433C8;
        Mon,  9 Oct 2023 13:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857293;
        bh=0UDTGHjVIIkEyzudL1RfBtRtHfsQd28mx4BP/tNn/JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tXTaR1UwNoBhvG17/t+Q6A44HI3pXt03RNlxNfVdzOtLZC5GmT5WJVc/HAFboJL8N
         hXYDOU8+Yo5oMM6RNyeIWtBI7PjLZGm0A9et348QncwRDjSuS2O7PaSCiHq1Zfszvm
         MEQcxWV1u9YY9jAUlaQItvXUuKDCyCV5MxzMcrxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, luosili <rootlab@huawei.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.5 162/163] ksmbd: fix race condition from parallel smb2 lock requests
Date:   Mon,  9 Oct 2023 15:02:06 +0200
Message-ID: <20231009130128.474689115@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 75ac9a3dd65f7eab4d12b0a0f744234b5300a491 upstream.

There is a race condition issue between parallel smb2 lock request.

                                            Time
                                             +
Thread A                                     | Thread A
smb2_lock                                    | smb2_lock
                                             |
 insert smb_lock to lock_list                |
 spin_unlock(&work->conn->llist_lock)        |
                                             |
                                             |   spin_lock(&conn->llist_lock);
                                             |   kfree(cmp_lock);
                                             |
 // UAF!                                     |
 list_add(&smb_lock->llist, &rollback_list)  +

This patch swaps the line for adding the smb lock to the rollback list and
adding the lock list of connection to fix the race issue.

Reported-by: luosili <rootlab@huawei.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7029,10 +7029,6 @@ skip:
 
 				ksmbd_debug(SMB,
 					    "would have to wait for getting lock\n");
-				spin_lock(&work->conn->llist_lock);
-				list_add_tail(&smb_lock->clist,
-					      &work->conn->lock_list);
-				spin_unlock(&work->conn->llist_lock);
 				list_add(&smb_lock->llist, &rollback_list);
 
 				argv = kmalloc(sizeof(void *), GFP_KERNEL);
@@ -7063,9 +7059,6 @@ skip:
 
 				if (work->state != KSMBD_WORK_ACTIVE) {
 					list_del(&smb_lock->llist);
-					spin_lock(&work->conn->llist_lock);
-					list_del(&smb_lock->clist);
-					spin_unlock(&work->conn->llist_lock);
 					locks_free_lock(flock);
 
 					if (work->state == KSMBD_WORK_CANCELLED) {
@@ -7087,19 +7080,16 @@ skip:
 				}
 
 				list_del(&smb_lock->llist);
-				spin_lock(&work->conn->llist_lock);
-				list_del(&smb_lock->clist);
-				spin_unlock(&work->conn->llist_lock);
 				release_async_work(work);
 				goto retry;
 			} else if (!rc) {
+				list_add(&smb_lock->llist, &rollback_list);
 				spin_lock(&work->conn->llist_lock);
 				list_add_tail(&smb_lock->clist,
 					      &work->conn->lock_list);
 				list_add_tail(&smb_lock->flist,
 					      &fp->lock_list);
 				spin_unlock(&work->conn->llist_lock);
-				list_add(&smb_lock->llist, &rollback_list);
 				ksmbd_debug(SMB, "successful in taking lock\n");
 			} else {
 				goto out;


