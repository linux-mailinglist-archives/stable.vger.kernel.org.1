Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C65D709B39
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 17:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjESPWX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 11:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjESPWW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 11:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D611A6
        for <stable@vger.kernel.org>; Fri, 19 May 2023 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684509692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=69xY3Y/BguJT9rPxZeZj/wxsVAUQXBLCe0yLxAe0wto=;
        b=XVXWYpEx5hOKt/fkQJrSL3efyX5tewRo4VUQPmieI3qx2bk6lfCbWUBco8VUShc+5lGfJt
        0sLPj76bTqMobDcP6gNnmSYNvgWxNt/G8Ny6tTIfVHJyDVHnToI4nsL+plvxzs89NRaVtL
        RN9ksizO1Wb2OZRMiS1OA2HlqwlYzcM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-e4oddCzyM2mZQbmOwh7oNA-1; Fri, 19 May 2023 11:21:30 -0400
X-MC-Unique: e4oddCzyM2mZQbmOwh7oNA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E5FE8002BF
        for <stable@vger.kernel.org>; Fri, 19 May 2023 15:21:30 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72D9B4F2DE0;
        Fri, 19 May 2023 15:21:30 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, agruenba@redhat.com,
        stable@vger.kernel.org, aahringo@redhat.com
Subject: [PATCH v6.4-rc2 3/5] fs: dlm: switch posix lock to killable only
Date:   Fri, 19 May 2023 11:21:26 -0400
Message-Id: <20230519152128.65272-3-aahringo@redhat.com>
In-Reply-To: <20230519152128.65272-1-aahringo@redhat.com>
References: <20230519152128.65272-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch will revert commit a6b1533e9a57 ("dlm: make posix locks
interruptible"). It was probably introduced to reach the fcntl()
F_SETLKW requirement to make fcntl() calls interruptible, see:

"F_SETLKW (struct flock *):

 As for F_SETLK, but if a conflicting lock is held on the file,
 then wait for that lock to be released. If a signal is caught
 while waiting, then the call is interrupted and (after the signal
 handler has returned) returns immediately (with return value -1
 and errno set to EINTR; see signal(7))."

This requires to interrupt the current plock operation in question
sitting in the wait_event_interruptible() waiting for op->done becomes
true. This isn't currently the case as do_unlock_close() will act like
the process was killed as it unlocks all previously acquired locks which
can occur into data corruption because the process still thinks it has
the previously acquired locks still acquired.

To test this behaviour a ltp testcase was created [0]. After this patch
the process can't be interrupted anymore which is against the API
but considered currently as a limitation of DLM. However it will stop to
unlock all previously acquired locks and the user process isn't aware of
it.

It requires more work in DLM to support such feature as intended. It
requires some lock request cancellation request which does not yet
exists for dlm plock user space communication. As this feature never
worked as intended and have side effects as mentioned aboe this patch moves
the wait to killable again.

[0] https://gitlab.com/netcoder/ltp/-/blob/dlm_fcntl_owner_testcase/testcases/kernel/syscalls/fcntl/fcntl42.c

Cc: stable@vger.kernel.org
Fixes: a6b1533e9a57 ("dlm: make posix locks interruptible")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.31.1

