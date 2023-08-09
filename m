Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D935775D1F
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjHILeG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjHILeG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBE1E3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54C9A63482
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626CDC433C7;
        Wed,  9 Aug 2023 11:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580844;
        bh=dWcf/R750Buawz2Py6+NQACT1zETv7K1TX4Qd6rwSso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SgWxW9AsPVJSFJ1F4g43fosplbqQ9VEUoib2uIkAA7hTSNU5dqqk2Q00YGdKzkZAJ
         CueCdaxzrMkR5VW2qKvRrUqCPcXw2vWgf077xM5eCYJfgZ/JjPzjJjNMYfwMA9KbAr
         jMPoEcVV//4bHDaDH9EHkU3OG0q0j1oBbmABl7nA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 015/201] dlm: rearrange async condition return
Date:   Wed,  9 Aug 2023 12:40:17 +0200
Message-ID: <20230809103644.328956337@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Aring <aahringo@redhat.com>

[ Upstream commit a800ba77fd285c6391a82819867ac64e9ab3af46 ]

This patch moves the return of FILE_LOCK_DEFERRED a little bit earlier
than checking afterwards again if the request was an asynchronous request.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Stable-dep-of: 59e45c758ca1 ("fs: dlm: interrupt posix locks only when process is killed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/plock.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index e70e23eca03ec..01fb7d8c0bca5 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -149,26 +149,25 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		op_data->file	= file;
 
 		op->data = op_data;
+
+		send_op(op);
+		rv = FILE_LOCK_DEFERRED;
+		goto out;
 	} else {
 		op->info.owner	= (__u64)(long) fl->fl_owner;
 	}
 
 	send_op(op);
 
-	if (!op->data) {
-		rv = wait_event_interruptible(recv_wq, (op->done != 0));
-		if (rv == -ERESTARTSYS) {
-			log_debug(ls, "dlm_posix_lock: wait killed %llx",
-				  (unsigned long long)number);
-			spin_lock(&ops_lock);
-			list_del(&op->list);
-			spin_unlock(&ops_lock);
-			dlm_release_plock_op(op);
-			do_unlock_close(ls, number, file, fl);
-			goto out;
-		}
-	} else {
-		rv = FILE_LOCK_DEFERRED;
+	rv = wait_event_interruptible(recv_wq, (op->done != 0));
+	if (rv == -ERESTARTSYS) {
+		log_debug(ls, "%s: wait killed %llx", __func__,
+			  (unsigned long long)number);
+		spin_lock(&ops_lock);
+		list_del(&op->list);
+		spin_unlock(&ops_lock);
+		dlm_release_plock_op(op);
+		do_unlock_close(ls, number, file, fl);
 		goto out;
 	}
 
-- 
2.39.2



