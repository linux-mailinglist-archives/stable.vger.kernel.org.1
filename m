Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E61791CFD
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbjIDSdw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239229AbjIDSdw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:33:52 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94836E41
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ED87CCE0F9A
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61A9C433C8;
        Mon,  4 Sep 2023 18:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852423;
        bh=4Dlzmvusp+puZgU2Gd8xFqKe5rKRe28yedlr9D2w8mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1pGpyC69qUqYCwiiJBZThZdoEQNel00AcqVj4iFWxNEgf1t68wVr7rck5ki8dz1vG
         yGW82+AqXHin+3Qq/sTO9O2MJUYvniWU2xojBXsB5vJF2X//2C6xAgv7LDXXZDrE2P
         N0q8BCT1vnWuND7nSbc1LGihuxdiBCgMt6HHXGcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.4 04/32] ksmbd: replace one-element array with flex-array member in struct smb2_ea_info
Date:   Mon,  4 Sep 2023 19:30:02 +0100
Message-ID: <20230904182948.104610739@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
References: <20230904182947.899158313@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namjae Jeon <linkinjeon@kernel.org>

commit 0ba5439d9afa2722e7728df56f272c89987540a4 upstream.

UBSAN complains about out-of-bounds array indexes on 1-element arrays in
struct smb2_ea_info.

UBSAN: array-index-out-of-bounds in fs/smb/server/smb2pdu.c:4335:15
index 1 is out of range for type 'char [1]'
CPU: 1 PID: 354 Comm: kworker/1:4 Not tainted 6.5.0-rc4 #1
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop
Reference Platform, BIOS 6.00 07/22/2020
Workqueue: ksmbd-io handle_ksmbd_work [ksmbd]
Call Trace:
 <TASK>
 __dump_stack linux/lib/dump_stack.c:88
 dump_stack_lvl+0x48/0x70 linux/lib/dump_stack.c:106
 dump_stack+0x10/0x20 linux/lib/dump_stack.c:113
 ubsan_epilogue linux/lib/ubsan.c:217
 __ubsan_handle_out_of_bounds+0xc6/0x110 linux/lib/ubsan.c:348
 smb2_get_ea linux/fs/smb/server/smb2pdu.c:4335
 smb2_get_info_file linux/fs/smb/server/smb2pdu.c:4900
 smb2_query_info+0x63ae/0x6b20 linux/fs/smb/server/smb2pdu.c:5275
 __process_request linux/fs/smb/server/server.c:145
 __handle_ksmbd_work linux/fs/smb/server/server.c:213
 handle_ksmbd_work+0x348/0x10b0 linux/fs/smb/server/server.c:266
 process_one_work+0x85a/0x1500 linux/kernel/workqueue.c:2597
 worker_thread+0xf3/0x13a0 linux/kernel/workqueue.c:2748
 kthread+0x2b7/0x390 linux/kernel/kthread.c:389
 ret_from_fork+0x44/0x90 linux/arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x1b/0x30 linux/arch/x86/entry/entry_64.S:304
 </TASK>

Cc: stable@vger.kernel.org
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/server/smb2pdu.c |    2 +-
 fs/smb/server/smb2pdu.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4310,7 +4310,7 @@ static int smb2_get_ea(struct ksmbd_work
 		if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
 			name_len -= XATTR_USER_PREFIX_LEN;
 
-		ptr = (char *)(&eainfo->name + name_len + 1);
+		ptr = eainfo->name + name_len + 1;
 		buf_free_len -= (offsetof(struct smb2_ea_info, name) +
 				name_len + 1);
 		/* bailout if xattr can't fit in buf_free_len */
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -361,7 +361,7 @@ struct smb2_ea_info {
 	__u8   Flags;
 	__u8   EaNameLength;
 	__le16 EaValueLength;
-	char name[1];
+	char name[];
 	/* optionally followed by value */
 } __packed; /* level 15 Query */
 


