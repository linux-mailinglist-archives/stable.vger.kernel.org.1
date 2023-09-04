Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F74791D23
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjIDSf3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244040AbjIDSf3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:35:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DEA9E
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:35:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 13CF7CE0F94
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C48C433C8;
        Mon,  4 Sep 2023 18:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852522;
        bh=s1ayyN+hlj4vegq5Uv9oDwQn3xRt4Ks4GMkqvqTqjg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEqK1uJmHkS/5qnovLebeQyo1cb0PUHUCHz0RjSrCTvxMyOjcHNc/tC1uoOR8X/pO
         ebcCvKRIxYL8dXnzyg90UjyJUfeoyP8+7yszCISyVWeDlbjAJ8mcpUmn01qBB9ePIb
         5RShW1OjBxY5ZbEn8zeJqcwZLVangWpOxaQ2KFYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 05/31] ksmbd: reduce descriptor size if remaining bytes is less than request size
Date:   Mon,  4 Sep 2023 19:30:13 +0100
Message-ID: <20230904182947.248062359@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
References: <20230904182946.999390199@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit e628bf939aafb61fbc56e9bdac8795cea5127e25 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/transport_rdma.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1366,24 +1366,35 @@ static int smb_direct_rdma_xmit(struct s
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
@@ -1395,7 +1406,7 @@ static int smb_direct_rdma_xmit(struct s
 
 	/* build rdma_rw_ctx for each descriptor */
 	desc_buf = buf;
-	for (i = 0; i < desc_len / sizeof(*desc); i++) {
+	for (i = 0; i < desc_num; i++) {
 		msg = kzalloc(offsetof(struct smb_direct_rdma_rw_msg, sg_list) +
 			      sizeof(struct scatterlist) * SG_CHUNK_SIZE, GFP_KERNEL);
 		if (!msg) {


