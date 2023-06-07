Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A00725F82
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 14:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjFGMbu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 08:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbjFGMb0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 08:31:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C261FEA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 05:31:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FE9C63E5E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 12:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB33C433D2;
        Wed,  7 Jun 2023 12:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686141070;
        bh=XXS+xh48URWxzSc0JjnE4unz90txZSwl4oYCWEcUcUk=;
        h=Subject:To:Cc:From:Date:From;
        b=QEKeLmpTdZo19YqWlWPecuOTDQbTFEcYPUilTTyEX6oLTmDBUTPTORBRv3bnbT58L
         xog5U/3KvWEvc3MvvHoZw9NzW9bbJSHEbZ+4hzQYPOnbpdLILmXcrIBLXAo4AbOjy0
         BH+/d903QtL4Xzv2qsg2HeJiCxzOwIC4HWKBD8cU=
Subject: FAILED: patch "[PATCH] ksmbd: fix slab-out-of-bounds read in smb2_handle_negotiate" failed to apply to 5.15-stable tree
To:     h3xrabbit@gmail.com, linkinjeon@kernel.org, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 07 Jun 2023 14:31:07 +0200
Message-ID: <2023060707-profanity-submitter-e855@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
git cherry-pick -x d738950f112c8f40f0515fe967db998e8235a175
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023060707-profanity-submitter-e855@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d738950f112c8f40f0515fe967db998e8235a175 Mon Sep 17 00:00:00 2001
From: Kuan-Ting Chen <h3xrabbit@gmail.com>
Date: Fri, 19 May 2023 22:59:28 +0900
Subject: [PATCH] ksmbd: fix slab-out-of-bounds read in smb2_handle_negotiate

Check request_buf length first to avoid out-of-bounds read by
req->DialectCount.

[ 3350.990282] BUG: KASAN: slab-out-of-bounds in smb2_handle_negotiate+0x35d7/0x3e60
[ 3350.990282] Read of size 2 at addr ffff88810ad61346 by task kworker/5:0/276
[ 3351.000406] Workqueue: ksmbd-io handle_ksmbd_work
[ 3351.003499] Call Trace:
[ 3351.006473]  <TASK>
[ 3351.006473]  dump_stack_lvl+0x8d/0xe0
[ 3351.006473]  print_report+0xcc/0x620
[ 3351.006473]  kasan_report+0x92/0xc0
[ 3351.006473]  smb2_handle_negotiate+0x35d7/0x3e60
[ 3351.014760]  ksmbd_smb_negotiate_common+0x7a7/0xf00
[ 3351.014760]  handle_ksmbd_work+0x3f7/0x12d0
[ 3351.014760]  process_one_work+0xa85/0x1780

Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index bec885c007ce..83c668243c95 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1053,16 +1053,16 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 		return rc;
 	}
 
-	if (req->DialectCount == 0) {
-		pr_err("malformed packet\n");
+	smb2_buf_len = get_rfc1002_len(work->request_buf);
+	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
+	if (smb2_neg_size > smb2_buf_len) {
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		rc = -EINVAL;
 		goto err_out;
 	}
 
-	smb2_buf_len = get_rfc1002_len(work->request_buf);
-	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
-	if (smb2_neg_size > smb2_buf_len) {
+	if (req->DialectCount == 0) {
+		pr_err("malformed packet\n");
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		rc = -EINVAL;
 		goto err_out;

