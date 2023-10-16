Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C47CA24F
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjJPIss (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjJPIsr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:48:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBDDB4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:48:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B87FC433C8;
        Mon, 16 Oct 2023 08:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446125;
        bh=zSwoDARdqXy9TAIOMMj5HivSPCW7M/9iNK2FMS5WAk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0F5WfJCm+w5S8gFLvNG4H1i32kyllJygXGrtFP5GiA/jyvXMCNgG8AtLPWtDkQy2u
         OB8wngqy1rV+zDnkaPIkCPLFGmZF0Rb21Rwn8GN+xzCD/I8SmEw1/DqGgdjrfJjAm3
         8ZwAzjCfzJcRVBOYla5hSj4ikoFm+vgOXsKliUM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH 5.15 073/102] tee: amdtee: fix use-after-free vulnerability in amdtee_close_session
Date:   Mon, 16 Oct 2023 10:41:12 +0200
Message-ID: <20231016083955.645189532@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rijo Thomas <Rijo-john.Thomas@amd.com>

commit f4384b3e54ea813868bb81a861bf5b2406e15d8f upstream.

There is a potential race condition in amdtee_close_session that may
cause use-after-free in amdtee_open_session. For instance, if a session
has refcount == 1, and one thread tries to free this session via:

    kref_put(&sess->refcount, destroy_session);

the reference count will get decremented, and the next step would be to
call destroy_session(). However, if in another thread,
amdtee_open_session() is called before destroy_session() has completed
execution, alloc_session() may return 'sess' that will be freed up
later in destroy_session() leading to use-after-free in
amdtee_open_session.

To fix this issue, treat decrement of sess->refcount and removal of
'sess' from session list in destroy_session() as a critical section, so
that it is executed atomically.

Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tee/amdtee/core.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -217,12 +217,12 @@ unlock:
 	return rc;
 }
 
+/* mutex must be held by caller */
 static void destroy_session(struct kref *ref)
 {
 	struct amdtee_session *sess = container_of(ref, struct amdtee_session,
 						   refcount);
 
-	mutex_lock(&session_list_mutex);
 	list_del(&sess->list_node);
 	mutex_unlock(&session_list_mutex);
 	kfree(sess);
@@ -272,7 +272,8 @@ int amdtee_open_session(struct tee_conte
 	if (arg->ret != TEEC_SUCCESS) {
 		pr_err("open_session failed %d\n", arg->ret);
 		handle_unload_ta(ta_handle);
-		kref_put(&sess->refcount, destroy_session);
+		kref_put_mutex(&sess->refcount, destroy_session,
+			       &session_list_mutex);
 		goto out;
 	}
 
@@ -290,7 +291,8 @@ int amdtee_open_session(struct tee_conte
 		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
 		handle_close_session(ta_handle, session_info);
 		handle_unload_ta(ta_handle);
-		kref_put(&sess->refcount, destroy_session);
+		kref_put_mutex(&sess->refcount, destroy_session,
+			       &session_list_mutex);
 		rc = -ENOMEM;
 		goto out;
 	}
@@ -331,7 +333,7 @@ int amdtee_close_session(struct tee_cont
 	handle_close_session(ta_handle, session_info);
 	handle_unload_ta(ta_handle);
 
-	kref_put(&sess->refcount, destroy_session);
+	kref_put_mutex(&sess->refcount, destroy_session, &session_list_mutex);
 
 	return 0;
 }


