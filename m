Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE45F79061E
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 10:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbjIBIYL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 04:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIBIYL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 04:24:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB60ECC
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 01:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 167E5CE25AE
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 08:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0733FC433C8;
        Sat,  2 Sep 2023 08:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693643044;
        bh=oDDvsYV3ACBVGMxKHfqF0DWLSzauuGdwNbXgcv4SZNg=;
        h=Subject:To:Cc:From:Date:From;
        b=M/Ghod7y4eS79iRvu7m7cvzuLBWvmung9eOEHGGgHyzUKtIgcNrDUr8WcoVjbame7
         uTjxIfuy7zaO2p7dk69tcAXl1BekV8HK1dFjM6y4My207cGTuqxNUZLlzArUbZgXLJ
         brsD61CxFtc93uGkvbimckWf5lXF32df3ZU1b/TI=
Subject: FAILED: patch "[PATCH] ksmbd: reduce descriptor size if remaining bytes is less than" failed to apply to 5.15-stable tree
To:     linkinjeon@kernel.org, stfrench@microsoft.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 02 Sep 2023 10:23:56 +0200
Message-ID: <2023090256-carbon-fantasy-667b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e628bf939aafb61fbc56e9bdac8795cea5127e25
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090256-carbon-fantasy-667b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e628bf939aafb61fbc56e9bdac8795cea5127e25 Mon Sep 17 00:00:00 2001
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 29 Aug 2023 23:40:37 +0900
Subject: [PATCH] ksmbd: reduce descriptor size if remaining bytes is less than
 request size

Create 3 kinds of files to reproduce this problem.

dd if=/dev/urandom of=127k.bin bs=1024 count=127
dd if=/dev/urandom of=128k.bin bs=1024 count=128
dd if=/dev/urandom of=129k.bin bs=1024 count=129

When copying files from ksmbd share to windows or cifs.ko, The following
error message happen from windows client.

"The file '129k.bin' is too large for the destination filesystem."

We can see the error logs from ksmbd debug prints

[48394.611537] ksmbd: RDMA r/w request 0x0: token 0x669d, length 0x20000
[48394.612054] ksmbd: smb_direct: RDMA write, len 0x20000, needed credits 0x1
[48394.612572] ksmbd: filename 129k.bin, offset 131072, len 131072
[48394.614189] ksmbd: nbytes 1024, offset 132096 mincount 0
[48394.614585] ksmbd: Failed to process 8 [-22]

And we can reproduce it with cifs.ko,
e.g. dd if=129k.bin of=/dev/null bs=128KB count=2

This problem is that ksmbd rdma return error if remaining bytes is less
than Length of Buffer Descriptor V1 Structure.

smb_direct_rdma_xmit()
...
     if (desc_buf_len == 0 || total_length > buf_len ||
           total_length > t->max_rdma_rw_size)
               return -EINVAL;

This patch reduce descriptor size with remaining bytes and remove the
check for total_length and buf_len.

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 7f222787c52c..3b269e1f523a 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1364,24 +1364,35 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 	LIST_HEAD(msg_list);
 	char *desc_buf;
 	int credits_needed;
-	unsigned int desc_buf_len;
-	size_t total_length = 0;
+	unsigned int desc_buf_len, desc_num = 0;
 
 	if (t->status != SMB_DIRECT_CS_CONNECTED)
 		return -ENOTCONN;
 
+	if (buf_len > t->max_rdma_rw_size)
+		return -EINVAL;
+
 	/* calculate needed credits */
 	credits_needed = 0;
 	desc_buf = buf;
 	for (i = 0; i < desc_len / sizeof(*desc); i++) {
+		if (!buf_len)
+			break;
+
 		desc_buf_len = le32_to_cpu(desc[i].length);
+		if (!desc_buf_len)
+			return -EINVAL;
+
+		if (desc_buf_len > buf_len) {
+			desc_buf_len = buf_len;
+			desc[i].length = cpu_to_le32(desc_buf_len);
+			buf_len = 0;
+		}
 
 		credits_needed += calc_rw_credits(t, desc_buf, desc_buf_len);
 		desc_buf += desc_buf_len;
-		total_length += desc_buf_len;
-		if (desc_buf_len == 0 || total_length > buf_len ||
-		    total_length > t->max_rdma_rw_size)
-			return -EINVAL;
+		buf_len -= desc_buf_len;
+		desc_num++;
 	}
 
 	ksmbd_debug(RDMA, "RDMA %s, len %#x, needed credits %#x\n",
@@ -1393,7 +1404,7 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 
 	/* build rdma_rw_ctx for each descriptor */
 	desc_buf = buf;
-	for (i = 0; i < desc_len / sizeof(*desc); i++) {
+	for (i = 0; i < desc_num; i++) {
 		msg = kzalloc(offsetof(struct smb_direct_rdma_rw_msg, sg_list) +
 			      sizeof(struct scatterlist) * SG_CHUNK_SIZE, GFP_KERNEL);
 		if (!msg) {

