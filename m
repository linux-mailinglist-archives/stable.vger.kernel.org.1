Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB81972C13B
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbjFLK5h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbjFLK5X (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D36A5B
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77B4A62424
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:45:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEA8C433D2;
        Mon, 12 Jun 2023 10:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566705;
        bh=T5IHk6a4GPIfuBTxRyUwaBni4MjUoAnVUSFmZIWYxmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fO38HkAdgSWH/KdkPeuRr3MDD+n8HWvL3vwlpYGrgE4a4FZ87G19l0Tc8gn52mFIm
         xVRkp2Rmvi7LEzOGjLiygc4K5HsqAie4fFzltxsMf8/Mw9AzXKvvBBCQUWpIB+jJB0
         rk85LEiBdduZIMdlc0iDI0wRBraBV3ikJHRcIjTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chih-Yen Chang <cc85nod@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 126/132] ksmbd: fix out-of-bound read in parse_lease_state()
Date:   Mon, 12 Jun 2023 12:27:40 +0200
Message-ID: <20230612101715.942142800@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

commit fc6c6a3c324c1b3e93a03d0cfa3749c781f23de0 upstream.

This bug is in parse_lease_state, and it is caused by the missing check
of `struct create_context`. When the ksmbd traverses the create_contexts,
it doesn't check if the field of `NameOffset` and `Next` is valid,
The KASAN message is following:

[    6.664323] BUG: KASAN: slab-out-of-bounds in parse_lease_state+0x7d/0x280
[    6.664738] Read of size 2 at addr ffff888005c08988 by task kworker/0:3/103
...
[    6.666644] Call Trace:
[    6.666796]  <TASK>
[    6.666933]  dump_stack_lvl+0x33/0x50
[    6.667167]  print_report+0xcc/0x620
[    6.667903]  kasan_report+0xae/0xe0
[    6.668374]  kasan_check_range+0x35/0x1b0
[    6.668621]  parse_lease_state+0x7d/0x280
[    6.668868]  smb2_open+0xbe8/0x4420
[    6.675137]  handle_ksmbd_work+0x282/0x820

Use smb2_find_context_vals() to find smb2 create request lease context.
smb2_find_context_vals validate create context fields.

Cc: stable@vger.kernel.org
Reported-by: Chih-Yen Chang <cc85nod@gmail.com>
Tested-by: Chih-Yen Chang <cc85nod@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/oplock.c |   70 ++++++++++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 44 deletions(-)

--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1415,56 +1415,38 @@ void create_lease_buf(u8 *rbuf, struct l
  */
 struct lease_ctx_info *parse_lease_state(void *open_req)
 {
-	char *data_offset;
 	struct create_context *cc;
-	unsigned int next = 0;
-	char *name;
-	bool found = false;
 	struct smb2_create_req *req = (struct smb2_create_req *)open_req;
-	struct lease_ctx_info *lreq = kzalloc(sizeof(struct lease_ctx_info),
-		GFP_KERNEL);
+	struct lease_ctx_info *lreq;
+
+	cc = smb2_find_context_vals(req, SMB2_CREATE_REQUEST_LEASE, 4);
+	if (IS_ERR_OR_NULL(cc))
+		return NULL;
+
+	lreq = kzalloc(sizeof(struct lease_ctx_info), GFP_KERNEL);
 	if (!lreq)
 		return NULL;
 
-	data_offset = (char *)req + le32_to_cpu(req->CreateContextsOffset);
-	cc = (struct create_context *)data_offset;
-	do {
-		cc = (struct create_context *)((char *)cc + next);
-		name = le16_to_cpu(cc->NameOffset) + (char *)cc;
-		if (le16_to_cpu(cc->NameLength) != 4 ||
-		    strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
-			next = le32_to_cpu(cc->Next);
-			continue;
-		}
-		found = true;
-		break;
-	} while (next != 0);
-
-	if (found) {
-		if (sizeof(struct lease_context_v2) == le32_to_cpu(cc->DataLength)) {
-			struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
-
-			memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-			lreq->req_state = lc->lcontext.LeaseState;
-			lreq->flags = lc->lcontext.LeaseFlags;
-			lreq->duration = lc->lcontext.LeaseDuration;
-			memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
-			       SMB2_LEASE_KEY_SIZE);
-			lreq->version = 2;
-		} else {
-			struct create_lease *lc = (struct create_lease *)cc;
-
-			memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-			lreq->req_state = lc->lcontext.LeaseState;
-			lreq->flags = lc->lcontext.LeaseFlags;
-			lreq->duration = lc->lcontext.LeaseDuration;
-			lreq->version = 1;
-		}
-		return lreq;
-	}
+	if (sizeof(struct lease_context_v2) == le32_to_cpu(cc->DataLength)) {
+		struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
-	kfree(lreq);
-	return NULL;
+		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
+		lreq->req_state = lc->lcontext.LeaseState;
+		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->duration = lc->lcontext.LeaseDuration;
+		memcpy(lreq->parent_lease_key, lc->lcontext.ParentLeaseKey,
+				SMB2_LEASE_KEY_SIZE);
+		lreq->version = 2;
+	} else {
+		struct create_lease *lc = (struct create_lease *)cc;
+
+		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
+		lreq->req_state = lc->lcontext.LeaseState;
+		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->duration = lc->lcontext.LeaseDuration;
+		lreq->version = 1;
+	}
+	return lreq;
 }
 
 /**


