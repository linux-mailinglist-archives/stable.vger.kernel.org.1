Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B20F75255C
	for <lists+stable@lfdr.de>; Thu, 13 Jul 2023 16:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjGMOli (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 13 Jul 2023 10:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjGMOlh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 13 Jul 2023 10:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19EF2702
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 07:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689259249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qi8sOM1Fwy6UoMm9AVpPCrwHoOD27cN4FT58wjcPlJw=;
        b=LIpieO8SsKlQWkkAi9eDs8dqDn9yipRlqEkOLJVqusVUqZdfiFrlawEnkIexXjPTCEcAxw
        uRdTGETIzAYS7hU12Qt5IZPeYYHbohiTohgE4ifB2Qs/u7GBpTNpJGx0EiFDxVjq08Euhr
        j6RavDVrlNdxPXmF2m9ZP/zKrn9pj3w=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-E4yepMChP5mxOs4PLexKXg-1; Thu, 13 Jul 2023 10:40:48 -0400
X-MC-Unique: E4yepMChP5mxOs4PLexKXg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1A42382C04C
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 14:40:47 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0705492C13;
        Thu, 13 Jul 2023 14:40:47 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org, agruenba@redhat.com
Subject: [PATCH v6.5-rc1 1/2] fs: dlm: introduce DLM_PLOCK_FL_NO_REPLY flag
Date:   Thu, 13 Jul 2023 10:40:28 -0400
Message-Id: <20230713144029.3342637-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch introduces a new flag DLM_PLOCK_FL_NO_REPLY in case an dlm
plock operation should not send a reply back. Currently this is kind of
being handled in DLM_PLOCK_FL_CLOSE, but DLM_PLOCK_FL_CLOSE has more
meanings that it will remove all waiters for a specific nodeid/owner
values in by doing a unlock operation. In case of an error in dlm user
space software e.g. dlm_controld we get an reply with an error back.
This cannot be matched because there is no op to match in recv_list. We
filter now on DLM_PLOCK_FL_NO_REPLY in case we had an error back as
reply. In newer dlm_controld version it will never send a result back
when DLM_PLOCK_FL_NO_REPLY is set. This filter is a workaround to handle
older dlm_controld versions.

Fixes: 901025d2f319 ("dlm: make plock operation killable")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c                 | 23 +++++++++++++++++++----
 include/uapi/linux/dlm_plock.h |  1 +
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 70a4752ed913..7fe9f4b922d3 100644
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
@@ -433,6 +433,21 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 	if (check_version(&info))
 		return -EINVAL;
 
+	/* Some old dlm user space software will send replies back,
+	 * even if DLM_PLOCK_FL_NO_REPLY is set (because the flag is
+	 * new) e.g. if a error occur. We can't match them in recv_list
+	 * because they were never be part of it. We filter it here,
+	 * new dlm user space software will filter it in user space.
+	 *
+	 * In future this handling can be removed.
+	 */
+	if (info.flags & DLM_PLOCK_FL_NO_REPLY) {
+		pr_info("Received unexpected reply from op %d, "
+			"please update DLM user space software!\n",
+			info.optype);
+		return count;
+	}
+
 	/*
 	 * The results for waiting ops (SETLKW) can be returned in any
 	 * order, so match all fields to find the op.  The results for
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

