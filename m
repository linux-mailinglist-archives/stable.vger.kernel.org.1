Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E4E7C436C
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 00:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjJJWFq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 18:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjJJWFp (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 18:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A083F9D
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696975500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyjLW3S2EBOpnkOEcsiDvZUk5PtFmpO8kvxKHqouP28=;
        b=ag2yUDVycg1y8kaoJEp9H/ZzJjkBl/EM6FEipIZRnBA8ePRuA4MqSuZP5Y+b4v1jcx2oio
        YIFH8tJJ7ENdF82gvSczR9kheDbQ+467Ix4pT74dm8EHxIvOqSH0NnksnH/J4QjbS68D19
        9p2YmurhgIRW0t6sRGYBYcSZ8yr0QBg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-fUtmXuWDOh2cLKJzViPU9A-1; Tue, 10 Oct 2023 18:04:59 -0400
X-MC-Unique: fUtmXuWDOh2cLKJzViPU9A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE4258F5DA5;
        Tue, 10 Oct 2023 22:04:58 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD30263F45;
        Tue, 10 Oct 2023 22:04:58 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, gfs2@lists.linux.dev,
        christophe.jaillet@wanadoo.fr, stable@vger.kernel.org,
        aahringo@redhat.com
Subject: [PATCH RESEND 8/8] dlm: slow down filling up processing queue
Date:   Tue, 10 Oct 2023 18:04:48 -0400
Message-Id: <20231010220448.2978176-8-aahringo@redhat.com>
In-Reply-To: <20231010220448.2978176-1-aahringo@redhat.com>
References: <20231010220448.2978176-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
have a message burst when we e.g. create 1 million locks. If we put more
and more new messages to process in the processqueue we will soon run out
of memory.

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
2.39.3

