Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277A8793EF1
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjIFOdc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 10:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjIFOdb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 10:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE741992
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 07:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694010757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cmwIzFIXNpRLUeiK4lUVg/tlamLBDpFKni0CkmWHZaY=;
        b=YNiDYAn6hs0GfxUtgGU/Pe9rp1R8WZkHbvH7Eq/S/MqxGA8fn9TU9BzOxJPV1NkIi+7CMt
        n4N32w7ub4/nd+1WEiYQA1Xrtq09lGqFsGsOOr/nxBDII1Itd+zOVuxdTvRm6MLtwcjZbH
        q+z+2txN8HTGQ3IRW04Xc2oMS2H4GJE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-4WJxtsWtNWuKXviFR_AzzQ-1; Wed, 06 Sep 2023 10:32:34 -0400
X-MC-Unique: 4WJxtsWtNWuKXviFR_AzzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C023E3C0FC99;
        Wed,  6 Sep 2023 14:32:33 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94AFE140E950;
        Wed,  6 Sep 2023 14:32:33 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, gfs2@lists.linux.dev,
        aahringo@redhat.com, stable@vger.kernel.org
Subject: [PATCH dlm/next 6/6] dlm: slow down filling up processing queue
Date:   Wed,  6 Sep 2023 10:31:53 -0400
Message-Id: <20230906143153.1353077-6-aahringo@redhat.com>
In-Reply-To: <20230906143153.1353077-1-aahringo@redhat.com>
References: <20230906143153.1353077-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

If there is a burst of message the receive worker will filling up the
processing queue but where are too slow to process dlm messages. This
patch will slow down the receiver worker to keep the buffer on the
socket layer to tell the sender to backoff. This is done by a threshold
to get the next buffers from the socket after all messages were
processed done by a flush_workqueue(). This however only occurs when we
have a burst like my dlm_bursttest [0] testcase to create 1 million locks
on module init and unlock them on module exit. If we put more and more
new messages to process in the processqueue we will soon run out of
memory. The testcase to reproduce this issue can be found at:

https://gitlab.com/netcoder/linux-public/-/blob/dlm_test_burst/fs/dlm/dlm_bursttest.c
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index f7bc22e74db2..67f8dd8a05ef 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -63,6 +63,7 @@
 #include "config.h"
 
 #define DLM_SHUTDOWN_WAIT_TIMEOUT msecs_to_jiffies(5000)
+#define DLM_MAX_PROCESS_BUFFERS 24
 #define NEEDED_RMEM (4*1024*1024)
 
 struct connection {
@@ -194,6 +195,7 @@ static const struct dlm_proto_ops *dlm_proto_ops;
 #define DLM_IO_END 1
 #define DLM_IO_EOF 2
 #define DLM_IO_RESCHED 3
+#define DLM_IO_FLUSH 4
 
 static void process_recv_sockets(struct work_struct *work);
 static void process_send_sockets(struct work_struct *work);
@@ -202,6 +204,7 @@ static void process_dlm_messages(struct work_struct *work);
 static DECLARE_WORK(process_work, process_dlm_messages);
 static DEFINE_SPINLOCK(processqueue_lock);
 static bool process_dlm_messages_pending;
+static atomic_t processqueue_count;
 static LIST_HEAD(processqueue);
 
 bool dlm_lowcomms_is_running(void)
@@ -874,6 +877,7 @@ static void process_dlm_messages(struct work_struct *work)
 	}
 
 	list_del(&pentry->list);
+	atomic_dec(&processqueue_count);
 	spin_unlock(&processqueue_lock);
 
 	for (;;) {
@@ -891,6 +895,7 @@ static void process_dlm_messages(struct work_struct *work)
 		}
 
 		list_del(&pentry->list);
+		atomic_dec(&processqueue_count);
 		spin_unlock(&processqueue_lock);
 	}
 }
@@ -962,6 +967,7 @@ static int receive_from_sock(struct connection *con, int buflen)
 		con->rx_leftover);
 
 	spin_lock(&processqueue_lock);
+	ret = atomic_inc_return(&processqueue_count);
 	list_add_tail(&pentry->list, &processqueue);
 	if (!process_dlm_messages_pending) {
 		process_dlm_messages_pending = true;
@@ -969,6 +975,9 @@ static int receive_from_sock(struct connection *con, int buflen)
 	}
 	spin_unlock(&processqueue_lock);
 
+	if (ret > DLM_MAX_PROCESS_BUFFERS)
+		return DLM_IO_FLUSH;
+
 	return DLM_IO_SUCCESS;
 }
 
@@ -1503,6 +1512,9 @@ static void process_recv_sockets(struct work_struct *work)
 		wake_up(&con->shutdown_wait);
 		/* CF_RECV_PENDING cleared */
 		break;
+	case DLM_IO_FLUSH:
+		flush_workqueue(process_workqueue);
+		fallthrough;
 	case DLM_IO_RESCHED:
 		cond_resched();
 		queue_work(io_workqueue, &con->rwork);
-- 
2.31.1

