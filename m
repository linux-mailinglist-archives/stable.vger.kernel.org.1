Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0188275D4C3
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjGUTYm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjGUTYi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:24:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20123E75
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8EFE61D96
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5170C433C8;
        Fri, 21 Jul 2023 19:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967475;
        bh=Fl48zyRm0qtJq+eSt6n1psCSiycX9YMyd8iekXvYr5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFoMuqLqES4SuPHTxJj9xxhDdaZUpYh+puzL8ovOZPF34wt2KMPvKsLkTfKINncOh
         EX87KTo317pIw2/i7gUTFYzODzkz2YvfZKmYQ6pLjhdv3pWfLRjPsZFiG5dhftDDlz
         GpcOIMks6vMSPyR78WNvrX3qrUqJgsvb/m/3kb5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>
Subject: [PATCH 6.1 138/223] fs: dlm: fix cleanup pending ops when interrupted
Date:   Fri, 21 Jul 2023 18:06:31 +0200
Message-ID: <20230721160526.758638167@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Aring <aahringo@redhat.com>

commit c847f4e203046a2c93d8a1cf0348315c0b655a60 upstream.

Immediately clean up a posix lock request if it is interrupted
while waiting for a result from user space (dlm_controld.)  This
largely reverts the recent commit b92a4e3f86b1 ("fs: dlm: change
posix lock sigint handling"). That previous commit attempted
to defer lock cleanup to the point in time when a result from
user space arrived. The deferred approach was not reliable
because some dlm plock ops may not receive replies.

Cc: stable@vger.kernel.org
Fixes: b92a4e3f86b1 ("fs: dlm: change posix lock sigint handling")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/dlm/plock.c |   25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -29,8 +29,6 @@ struct plock_async_data {
 struct plock_op {
 	struct list_head list;
 	int done;
-	/* if lock op got interrupted while waiting dlm_controld reply */
-	bool sigint;
 	struct dlm_plock_info info;
 	/* if set indicates async handling */
 	struct plock_async_data *data;
@@ -166,12 +164,14 @@ int dlm_posix_lock(dlm_lockspace_t *lock
 			spin_unlock(&ops_lock);
 			goto do_lock_wait;
 		}
-
-		op->sigint = true;
+		list_del(&op->list);
 		spin_unlock(&ops_lock);
+
 		log_debug(ls, "%s: wait interrupted %x %llx pid %d",
 			  __func__, ls->ls_global_id,
 			  (unsigned long long)number, op->info.pid);
+		do_unlock_close(&op->info);
+		dlm_release_plock_op(op);
 		goto out;
 	}
 
@@ -433,19 +433,6 @@ static ssize_t dev_write(struct file *fi
 		if (iter->info.fsid == info.fsid &&
 		    iter->info.number == info.number &&
 		    iter->info.owner == info.owner) {
-			if (iter->sigint) {
-				list_del(&iter->list);
-				spin_unlock(&ops_lock);
-
-				pr_debug("%s: sigint cleanup %x %llx pid %d",
-					  __func__, iter->info.fsid,
-					  (unsigned long long)iter->info.number,
-					  iter->info.pid);
-				do_unlock_close(&iter->info);
-				memcpy(&iter->info, &info, sizeof(info));
-				dlm_release_plock_op(iter);
-				return count;
-			}
 			list_del_init(&iter->list);
 			memcpy(&iter->info, &info, sizeof(info));
 			if (iter->data)
@@ -464,8 +451,8 @@ static ssize_t dev_write(struct file *fi
 		else
 			wake_up(&recv_wq);
 	} else
-		log_print("%s: no op %x %llx", __func__,
-			  info.fsid, (unsigned long long)info.number);
+		pr_debug("%s: no op %x %llx", __func__,
+			 info.fsid, (unsigned long long)info.number);
 	return count;
 }
 


