Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EC872B848
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 08:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjFLGsB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 02:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjFLGsA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 02:48:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4A2B0
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 23:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E38AC61F27
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 06:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBEAC433D2;
        Mon, 12 Jun 2023 06:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686551495;
        bh=ICUwY9H55MEY2j1qrJB3Jj3vZVkEQrlQDAmh5ZY6OX0=;
        h=Subject:To:Cc:From:Date:From;
        b=F0hfIPUHT0qyK6Zv9QGxmxCP1wPlwCTfaznZg2dWR6boJFPMhYQkI4/mQcYoDI2zp
         xky1Ukog81QiqZ0wGQvuJmH0FjOk+raKew4PzRnFZNbGPKvU9JHe65zd/odrnNBTth
         di6Ybpp7xjSZua9NjAlIGwJ9quWPpGN2PbKW0Yv0=
Subject: FAILED: patch "[PATCH] ksmbd: validate smb request protocol id" failed to apply to 5.15-stable tree
To:     linkinjeon@kernel.org, cc85nod@gmail.com, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 08:31:23 +0200
Message-ID: <2023061222-comic-platypus-831e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1c1bcf2d3ea061613119b534f57507c377df20f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061222-comic-platypus-831e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c1bcf2d3ea061613119b534f57507c377df20f9 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 31 May 2023 17:59:32 +0900
Subject: [PATCH] ksmbd: validate smb request protocol id

This patch add the validation for smb request protocol id.
If it is not one of the four ids(SMB1_PROTO_NUMBER, SMB2_PROTO_NUMBER,
SMB2_TRANSFORM_PROTO_NUM, SMB2_COMPRESSION_TRANSFORM_ID), don't allow
processing the request. And this will fix the following KASAN warning
also.

[   13.905265] BUG: KASAN: slab-out-of-bounds in init_smb2_rsp_hdr+0x1b9/0x1f0
[   13.905900] Read of size 16 at addr ffff888005fd2f34 by task kworker/0:2/44
...
[   13.908553] Call Trace:
[   13.908793]  <TASK>
[   13.908995]  dump_stack_lvl+0x33/0x50
[   13.909369]  print_report+0xcc/0x620
[   13.910870]  kasan_report+0xae/0xe0
[   13.911519]  kasan_check_range+0x35/0x1b0
[   13.911796]  init_smb2_rsp_hdr+0x1b9/0x1f0
[   13.912492]  handle_ksmbd_work+0xe5/0x820

Cc: stable@vger.kernel.org
Reported-by: Chih-Yen Chang <cc85nod@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index e11d4a1e63d7..2a717d158f02 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -364,8 +364,6 @@ int ksmbd_conn_handler_loop(void *p)
 			break;
 
 		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
-		if (!ksmbd_smb_request(conn))
-			break;
 
 		/*
 		 * We already read 4 bytes to find out PDU size, now
@@ -383,6 +381,9 @@ int ksmbd_conn_handler_loop(void *p)
 			continue;
 		}
 
+		if (!ksmbd_smb_request(conn))
+			break;
+
 		if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
 		    SMB2_PROTO_NUMBER) {
 			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index af0c2a9b8529..569e5eecdf3d 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -158,7 +158,19 @@ int ksmbd_verify_smb_message(struct ksmbd_work *work)
  */
 bool ksmbd_smb_request(struct ksmbd_conn *conn)
 {
-	return conn->request_buf[0] == 0;
+	__le32 *proto = (__le32 *)smb2_get_msg(conn->request_buf);
+
+	if (*proto == SMB2_COMPRESSION_TRANSFORM_ID) {
+		pr_err_ratelimited("smb2 compression not support yet");
+		return false;
+	}
+
+	if (*proto != SMB1_PROTO_NUMBER &&
+	    *proto != SMB2_PROTO_NUMBER &&
+	    *proto != SMB2_TRANSFORM_PROTO_NUM)
+		return false;
+
+	return true;
 }
 
 static bool supported_protocol(int idx)

