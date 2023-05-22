Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4FA70C6A9
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjEVTUt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjEVTUt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:20:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E20293
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF76A62811
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD614C433EF;
        Mon, 22 May 2023 19:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783245;
        bh=2QztrxAXePB8tzSJyUcQpqTnZNJgqG8ZMTbfZtApbBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baoX7R2k2ejny3K9er0fTh/oVy4PBoSrwEj3IClYDxk3Qk9HL6fgkcqo0AKzVrw/i
         KWfCQA/P6IuAjPpGUqCj7hsIxw0uO4qClnCKa5gf6VFYTfmy6CHwy1WeI7f05uTw1Z
         9Hyyewl9Htl+0MHcZSe+m7t/zqB1C6rgQIMucp28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chih-Yen Chang <cc85nod@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 187/203] ksmbd: fix wrong UserName check in session_user
Date:   Mon, 22 May 2023 20:10:11 +0100
Message-Id: <20230522190400.194529767@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Chih-Yen Chang <cc85nod@gmail.com>

commit f0a96d1aafd8964e1f9955c830a3e5cb3c60a90f upstream.

The offset of UserName is related to the address of security
buffer. To ensure the validaty of UserName, we need to compare name_off
+ name_len with secbuf_len instead of auth_msg_len.

[   27.096243] ==================================================================
[   27.096890] BUG: KASAN: slab-out-of-bounds in smb_strndup_from_utf16+0x188/0x350
[   27.097609] Read of size 2 at addr ffff888005e3b542 by task kworker/0:0/7
...
[   27.099950] Call Trace:
[   27.100194]  <TASK>
[   27.100397]  dump_stack_lvl+0x33/0x50
[   27.100752]  print_report+0xcc/0x620
[   27.102305]  kasan_report+0xae/0xe0
[   27.103072]  kasan_check_range+0x35/0x1b0
[   27.103757]  smb_strndup_from_utf16+0x188/0x350
[   27.105474]  smb2_sess_setup+0xaf8/0x19c0
[   27.107935]  handle_ksmbd_work+0x274/0x810
[   27.108315]  process_one_work+0x419/0x760
[   27.108689]  worker_thread+0x2a2/0x6f0
[   27.109385]  kthread+0x160/0x190
[   27.110129]  ret_from_fork+0x1f/0x30
[   27.110454]  </TASK>

Cc: stable@vger.kernel.org
Signed-off-by: Chih-Yen Chang <cc85nod@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2pdu.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1387,7 +1387,7 @@ static struct ksmbd_user *session_user(s
 	struct authenticate_message *authblob;
 	struct ksmbd_user *user;
 	char *name;
-	unsigned int auth_msg_len, name_off, name_len, secbuf_len;
+	unsigned int name_off, name_len, secbuf_len;
 
 	secbuf_len = le16_to_cpu(req->SecurityBufferLength);
 	if (secbuf_len < sizeof(struct authenticate_message)) {
@@ -1397,9 +1397,8 @@ static struct ksmbd_user *session_user(s
 	authblob = user_authblob(conn, req);
 	name_off = le32_to_cpu(authblob->UserName.BufferOffset);
 	name_len = le16_to_cpu(authblob->UserName.Length);
-	auth_msg_len = le16_to_cpu(req->SecurityBufferOffset) + secbuf_len;
 
-	if (auth_msg_len < (u64)name_off + name_len)
+	if (secbuf_len < (u64)name_off + name_len)
 		return NULL;
 
 	name = smb_strndup_from_utf16((const char *)authblob + name_off,


