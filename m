Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0F1752917
	for <lists+stable@lfdr.de>; Thu, 13 Jul 2023 18:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbjGMQtz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 13 Jul 2023 12:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjGMQtw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 13 Jul 2023 12:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6F930FA
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689266944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rPQCRmRZHA8zWTxe2Vh/VZ6/UYSN4ePaycOGmRaOOLI=;
        b=EpajaCpxMPP1WTbS2jybypRxwAt+Zoe3hTkCcGvhstc9Sx8XnJQjyXYwzMaFbj739sDf0B
        7WZ7QS4vMjaiP3BBzuP9vx60sR5LsaAFv5m8bOF2tdjTGcIZX7bQzt3bx4gWAD1dWQdBVL
        C2ZmoQ0eS7i0AhTPnLX7e8jnnNK0UP8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-HtWgOwaLOauUTXDT7p3ORw-1; Thu, 13 Jul 2023 12:49:02 -0400
X-MC-Unique: HtWgOwaLOauUTXDT7p3ORw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7A9F88D120
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 16:49:02 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AC522166B26;
        Thu, 13 Jul 2023 16:49:02 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org, agruenba@redhat.com
Subject: [PATCHv2 v6.5-rc1 2/3] fs: dlm: introduce DLM_PLOCK_FL_NO_REPLY flag
Date:   Thu, 13 Jul 2023 12:48:37 -0400
Message-Id: <20230713164838.3583052-3-aahringo@redhat.com>
In-Reply-To: <20230713164838.3583052-1-aahringo@redhat.com>
References: <20230713164838.3583052-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch introduces a new flag DLM_PLOCK_FL_NO_REPLY in case an dlm
plock operation should never send a reply back. Currently this is kind of
being handled in DLM_PLOCK_FL_CLOSE, but DLM_PLOCK_FL_CLOSE has more
meanings that it will remove all waiters for a specific nodeid/owner
values in by doing a unlock operation. That DLM_PLOCK_FL_CLOSE never
sends a reply back is not true in case of some user applications and
an error occurred. The new DLM_PLOCK_FL_NO_REPLY flag will tell the
user space application to never ever send a reply back. As this is
now combined with DLM_PLOCK_FL_CLOSE we can use DLM_PLOCK_FL_NO_REPLY to
check if older user space application still doing it and drop the message.

Expecting the user space applications is just copying flags from the
request to the reply, we can use now DLM_PLOCK_FL_NO_REPLY as workaround
to ignore replies from older dlm_controld versions.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c                 | 16 ++++++++++------
 include/uapi/linux/dlm_plock.h |  1 +
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 869595a995f7..1fa5b04d0298 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -96,7 +96,7 @@ static void do_unlock_close(const struct dlm_plock_info *info)
 	op->info.end		= OFFSET_MAX;
 	op->info.owner		= info->owner;
 
-	op->info.flags |= DLM_PLOCK_FL_CLOSE;
+	op->info.flags |= (DLM_PLOCK_FL_CLOSE | DLM_PLOCK_FL_NO_REPLY);
 	send_op(op);
 }
 
@@ -293,7 +293,7 @@ int dlm_posix_unlock(dlm_lockspace_t *lockspace, u64 number, struct file *file,
 		op->info.owner	= (__u64)(long) fl->fl_owner;
 
 	if (fl->fl_flags & FL_CLOSE) {
-		op->info.flags |= DLM_PLOCK_FL_CLOSE;
+		op->info.flags |= (DLM_PLOCK_FL_CLOSE | DLM_PLOCK_FL_NO_REPLY);
 		send_op(op);
 		rv = 0;
 		goto out;
@@ -392,7 +392,7 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 	spin_lock(&ops_lock);
 	if (!list_empty(&send_list)) {
 		op = list_first_entry(&send_list, struct plock_op, list);
-		if (op->info.flags & DLM_PLOCK_FL_CLOSE)
+		if (op->info.flags & DLM_PLOCK_FL_NO_REPLY)
 			list_del(&op->list);
 		else
 			list_move_tail(&op->list, &recv_list);
@@ -407,7 +407,7 @@ static ssize_t dev_read(struct file *file, char __user *u, size_t count,
 	   that were generated by the vfs cleaning up for a close
 	   (the process did not make an unlock call). */
 
-	if (op->info.flags & DLM_PLOCK_FL_CLOSE)
+	if (op->info.flags & DLM_PLOCK_FL_NO_REPLY)
 		dlm_release_plock_op(op);
 
 	if (copy_to_user(u, &info, sizeof(info)))
@@ -434,11 +434,15 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 		return -EINVAL;
 
 	/* Some dlm user space software will send replies back,
-	 * even if DLM_PLOCK_FL_CLOSE is set e.g. if an error occur.
+	 * even if DLM_PLOCK_FL_NO_REPLY is set e.g. if an error
+	 * occur as the op is unknown, etc.
+	 *
 	 * We can't match them in recv_list because they were never
 	 * be part of it.
+	 *
+	 * In the future, this handling could be removed.
 	 */
-	if (info.flags & DLM_PLOCK_FL_CLOSE)
+	if (info.flags & DLM_PLOCK_FL_NO_REPLY)
 		return count;
 
 	/*
diff --git a/include/uapi/linux/dlm_plock.h b/include/uapi/linux/dlm_plock.h
index 63b6c1fd9169..8dfa272c929a 100644
--- a/include/uapi/linux/dlm_plock.h
+++ b/include/uapi/linux/dlm_plock.h
@@ -25,6 +25,7 @@ enum {
 };
 
 #define DLM_PLOCK_FL_CLOSE 1
+#define DLM_PLOCK_FL_NO_REPLY 2
 
 struct dlm_plock_info {
 	__u32 version[3];
-- 
2.31.1

