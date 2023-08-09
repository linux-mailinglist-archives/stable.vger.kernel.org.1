Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A549775BDF
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjHILVx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjHILVt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:21:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2161FD8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C35631F8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A910FC433C8;
        Wed,  9 Aug 2023 11:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580108;
        bh=RzQlmatUCxkypMYl7xIife2z6y0lVFJ8m/e1S2g6BVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uuQCqC7x8zSokwMh7ya0TAu9X2xNnosO4ImyI1OBvCAWr+HnXJoCaus2R+iTj71oO
         z0+HX/mCKsQSZRO62IdLYsoF7kxyve55/xQMtBgxg/+iV+UlwkHigIIOm0AE2cnflb
         NJoQDJmUFgy6UcJRWemojKhi3Kzom3oQKHGA6TsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 229/323] dlm: rearrange async condition return
Date:   Wed,  9 Aug 2023 12:41:07 +0200
Message-ID: <20230809103708.584007326@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
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
index 7912ef3706e26..54ed11013d062 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -152,26 +152,25 @@ int dlm_posix_lock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
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



