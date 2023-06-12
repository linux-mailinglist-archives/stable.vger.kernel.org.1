Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF5672C142
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbjFLK5v (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237087AbjFLK5b (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:57:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153746A7F
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9388615CB
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CECC433D2;
        Mon, 12 Jun 2023 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566724;
        bh=ibt+xPjHXkzCPoRIhuuj2GUWRMZk+hsKwYw3AjyAOYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNiOHfC/kixJHJkm4de5f6LT9yZM8uS04p6KK0OIJCSjyy1uZ0tAEgrZRkzjVdRwL
         CcO5yhkpd7JBtr9qxKnD20FkqdPm8N2JUd3g1nur9fzknzmrSyo8NQkW1vAw3wjtlr
         OSQMmT/XHy0W8313NJStlkwCtcZWV5U9Tzg4HgIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chih-Yen Chang <cc85nod@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 127/132] ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop
Date:   Mon, 12 Jun 2023 12:27:41 +0200
Message-ID: <20230612101715.982275996@linuxfoundation.org>
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

commit 368ba06881c395f1c9a7ba22203cf8d78b4addc0 upstream.

The length field of netbios header must be greater than the SMB header
sizes(smb1 or smb2 header), otherwise the packet is an invalid SMB packet.

If `pdu_size` is 0, ksmbd allocates a 4 bytes chunk to `conn->request_buf`.
In the function `get_smb2_cmd_val` ksmbd will read cmd from
`rcv_hdr->Command`, which is `conn->request_buf + 12`, causing the KASAN
detector to print the following error message:

[    7.205018] BUG: KASAN: slab-out-of-bounds in get_smb2_cmd_val+0x45/0x60
[    7.205423] Read of size 2 at addr ffff8880062d8b50 by task ksmbd:42632/248
...
[    7.207125]  <TASK>
[    7.209191]  get_smb2_cmd_val+0x45/0x60
[    7.209426]  ksmbd_conn_enqueue_request+0x3a/0x100
[    7.209712]  ksmbd_server_process_request+0x72/0x160
[    7.210295]  ksmbd_conn_handler_loop+0x30c/0x550
[    7.212280]  kthread+0x160/0x190
[    7.212762]  ret_from_fork+0x1f/0x30
[    7.212981]  </TASK>

Cc: stable@vger.kernel.org
Reported-by: Chih-Yen Chang <cc85nod@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/connection.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -296,6 +296,9 @@ bool ksmbd_conn_alive(struct ksmbd_conn
 	return true;
 }
 
+#define SMB1_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb_hdr))
+#define SMB2_MIN_SUPPORTED_HEADER_SIZE (sizeof(struct smb2_hdr) + 4)
+
 /**
  * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
  * @p:		connection instance
@@ -352,6 +355,9 @@ int ksmbd_conn_handler_loop(void *p)
 		if (pdu_size > MAX_STREAM_PROT_LEN)
 			break;
 
+		if (pdu_size < SMB1_MIN_SUPPORTED_HEADER_SIZE)
+			break;
+
 		/* 4 for rfc1002 length field */
 		/* 1 for implied bcc[0] */
 		size = pdu_size + 4 + 1;
@@ -379,6 +385,12 @@ int ksmbd_conn_handler_loop(void *p)
 			continue;
 		}
 
+		if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
+		    SMB2_PROTO_NUMBER) {
+			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
+				break;
+		}
+
 		if (!default_conn_ops.process_fn) {
 			pr_err("No connection request callback\n");
 			break;


