Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F09773535B
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjFSKog (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjFSKoO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:44:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81F010D9
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 396D360B80
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49112C433CA;
        Mon, 19 Jun 2023 10:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171431;
        bh=KROgIx2Er8HXLtBPRTdwlTcysasgjv094XjzHte/AWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uODCrHnDjyoXjBxSc7bvbbM2bXlaav3fLx8RhvPkepGybOzJgzJwVhF1/PvIH4KYz
         qIgRBfdzUUpqpH9MMy1Hf4wGcrzOTqzV0E1Eo5A4pfLgizCYqXceLQ4uOVRXNtcCpy
         MdhTuqCYSUUxnV4bUdGXU/izyHW1D6MMIE5BUhtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chih-Yen Chang <cc85nod@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 009/166] ksmbd: validate smb request protocol id
Date:   Mon, 19 Jun 2023 12:28:06 +0200
Message-ID: <20230619102155.127272954@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 1c1bcf2d3ea061613119b534f57507c377df20f9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/connection.c |  5 +++--
 fs/ksmbd/smb_common.c | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index bf8531b80a182..e1d2be19cddfa 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -366,8 +366,6 @@ int ksmbd_conn_handler_loop(void *p)
 			break;
 
 		memcpy(conn->request_buf, hdr_buf, sizeof(hdr_buf));
-		if (!ksmbd_smb_request(conn))
-			break;
 
 		/*
 		 * We already read 4 bytes to find out PDU size, now
@@ -385,6 +383,9 @@ int ksmbd_conn_handler_loop(void *p)
 			continue;
 		}
 
+		if (!ksmbd_smb_request(conn))
+			break;
+
 		if (((struct smb2_hdr *)smb2_get_msg(conn->request_buf))->ProtocolId ==
 		    SMB2_PROTO_NUMBER) {
 			if (pdu_size < SMB2_MIN_SUPPORTED_HEADER_SIZE)
diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index 95afb6b23a91c..05d7f3e910bf4 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
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
-- 
2.39.2



