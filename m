Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A026FAA12
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjEHK6u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbjEHK6e (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:58:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD8433869
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45E39629D3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389C0C433EF;
        Mon,  8 May 2023 10:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543439;
        bh=Qy8xd7JDmZ9kKX/gKU4UFtMu3Z6S1B/9bToEhDlyF0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BElvUGpBXzbVF5cGgSdDbLuiN2OwBMYvt+3duaQefYLnFQdCJrBApELOJdC+DTq5X
         lPPv02l3N424Nu/AK8q+60jecATi0ay8KazlFUty62wc7sIW/x9EHXxTii/H3aPbwT
         iVjP4zMaoJTnNsDfI88tE6R7h4IyXbn9X7WUsMp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bob Peterson <rpeterso@redhat.com>,
        Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>
Subject: [PATCH 6.3 091/694] fs: dlm: fix DLM_IFL_CB_PENDING gets overwritten
Date:   Mon,  8 May 2023 11:38:46 +0200
Message-Id: <20230508094435.485236674@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Aring <aahringo@redhat.com>

commit a034c1370ded2ae6cbdc73a78241b3ed98c86d3d upstream.

This patch introduce a new internal flag per lkb value to handle
internal flags which are handled not on wire. The current lkb internal
flags stored as lkb->lkb_flags are split in upper and lower bits, the
lower bits are used to share internal flags over wire for other cluster
wide lkb copies on other nodes.

In commit 61bed0baa4db ("fs: dlm: use a non-static queue for callbacks")
we introduced a new internal flag for pending callbacks for the dlm
callback queue. This flag is protected by the lkb->lkb_cb_lock lock.
This patch overlooked that on dlm receive path and the mentioned upper
and lower bits, that dlm will read the flags, mask it and write it
back. As example receive_flags() in fs/dlm/lock.c. This flag
manipulation is not done atomically and is not protected by
lkb->lkb_cb_lock. This has unknown side effects of the current callback
handling.

In future we should move to set/clear/test bit functionality and avoid
read, mask and writing back flag values. In later patches we will move
the upper parts to the new introduced internal lkb flags which are not
shared between other cluster nodes to the new non shared internal flag
field to avoid similar issues.

Cc: stable@vger.kernel.org
Fixes: 61bed0baa4db ("fs: dlm: use a non-static queue for callbacks")
Reported-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/dlm/ast.c          |    9 ++++-----
 fs/dlm/dlm_internal.h |    5 ++++-
 fs/dlm/user.c         |    2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

--- a/fs/dlm/ast.c
+++ b/fs/dlm/ast.c
@@ -45,7 +45,7 @@ void dlm_purge_lkb_callbacks(struct dlm_
 		kref_put(&cb->ref, dlm_release_callback);
 	}
 
-	lkb->lkb_flags &= ~DLM_IFL_CB_PENDING;
+	clear_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags);
 
 	/* invalidate */
 	dlm_callback_set_last_ptr(&lkb->lkb_last_cast, NULL);
@@ -103,10 +103,9 @@ int dlm_enqueue_lkb_callback(struct dlm_
 	cb->sb_status = status;
 	cb->sb_flags = (sbflags & 0x000000FF);
 	kref_init(&cb->ref);
-	if (!(lkb->lkb_flags & DLM_IFL_CB_PENDING)) {
-		lkb->lkb_flags |= DLM_IFL_CB_PENDING;
+	if (!test_and_set_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags))
 		rv = DLM_ENQUEUE_CALLBACK_NEED_SCHED;
-	}
+
 	list_add_tail(&cb->list, &lkb->lkb_callbacks);
 
 	if (flags & DLM_CB_CAST)
@@ -209,7 +208,7 @@ void dlm_callback_work(struct work_struc
 		spin_lock(&lkb->lkb_cb_lock);
 		rv = dlm_dequeue_lkb_callback(lkb, &cb);
 		if (rv == DLM_DEQUEUE_CALLBACK_EMPTY) {
-			lkb->lkb_flags &= ~DLM_IFL_CB_PENDING;
+			clear_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags);
 			spin_unlock(&lkb->lkb_cb_lock);
 			break;
 		}
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -211,7 +211,9 @@ struct dlm_args {
 #endif
 #define DLM_IFL_DEADLOCK_CANCEL	0x01000000
 #define DLM_IFL_STUB_MS		0x02000000 /* magic number for m_flags */
-#define DLM_IFL_CB_PENDING	0x04000000
+
+#define DLM_IFL_CB_PENDING_BIT	0
+
 /* least significant 2 bytes are message changed, they are full transmitted
  * but at receive side only the 2 bytes LSB will be set.
  *
@@ -246,6 +248,7 @@ struct dlm_lkb {
 	uint32_t		lkb_exflags;	/* external flags from caller */
 	uint32_t		lkb_sbflags;	/* lksb flags */
 	uint32_t		lkb_flags;	/* internal flags */
+	unsigned long		lkb_iflags;	/* internal flags */
 	uint32_t		lkb_lvbseq;	/* lvb sequence number */
 
 	int8_t			lkb_status;     /* granted, waiting, convert */
--- a/fs/dlm/user.c
+++ b/fs/dlm/user.c
@@ -884,7 +884,7 @@ static ssize_t device_read(struct file *
 		goto try_another;
 	case DLM_DEQUEUE_CALLBACK_LAST:
 		list_del_init(&lkb->lkb_cb_list);
-		lkb->lkb_flags &= ~DLM_IFL_CB_PENDING;
+		clear_bit(DLM_IFL_CB_PENDING_BIT, &lkb->lkb_iflags);
 		break;
 	case DLM_DEQUEUE_CALLBACK_SUCCESS:
 		break;


