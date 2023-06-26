Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDF573E89B
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjFZS1c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjFZS1Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:27:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0FD1708
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A35D460F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91BDC433C0;
        Mon, 26 Jun 2023 18:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804007;
        bh=1s+3K2boAs13FPzN8Y58AAOHn3J/E5gF7TQ/ZhrrL1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H743W4mSx9zHj9YUxUIi1d9ejIE3YpTkPzmsQqpiEpL6/z5BJgil2NZFeyxoT4HV1
         eqmoEW+3HBOfs9RwuAC/pqe8vjcwE8ox5zHb28nSbdcuXQxbbAwkNW9SStLTLzqMp6
         xond+L4ArRy5yRQ1nwzbmQKO7tSpKqB4sxcq0CI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chih-Yen Chang <cc85nod@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 010/170] ksmbd: validate command payload size
Date:   Mon, 26 Jun 2023 20:09:39 +0200
Message-ID: <20230626180800.993822956@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

commit 2b9b8f3b68edb3d67d79962f02e26dbb5ae3808d upstream.

->StructureSize2 indicates command payload size. ksmbd should validate
this size with rfc1002 length before accessing it.
This patch remove unneeded check and add the validation for this.

[    8.912583] BUG: KASAN: slab-out-of-bounds in ksmbd_smb2_check_message+0x12a/0xc50
[    8.913051] Read of size 2 at addr ffff88800ac7d92c by task kworker/0:0/7
...
[    8.914967] Call Trace:
[    8.915126]  <TASK>
[    8.915267]  dump_stack_lvl+0x33/0x50
[    8.915506]  print_report+0xcc/0x620
[    8.916558]  kasan_report+0xae/0xe0
[    8.917080]  kasan_check_range+0x35/0x1b0
[    8.917334]  ksmbd_smb2_check_message+0x12a/0xc50
[    8.917935]  ksmbd_verify_smb_message+0xae/0xd0
[    8.918223]  handle_ksmbd_work+0x192/0x820
[    8.918478]  process_one_work+0x419/0x760
[    8.918727]  worker_thread+0x2a2/0x6f0
[    8.919222]  kthread+0x187/0x1d0
[    8.919723]  ret_from_fork+0x1f/0x30
[    8.919954]  </TASK>

Cc: stable@vger.kernel.org
Reported-by: Chih-Yen Chang <cc85nod@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/smb2misc.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -351,6 +351,7 @@ int ksmbd_smb2_check_message(struct ksmb
 	int command;
 	__u32 clc_len;  /* calculated length */
 	__u32 len = get_rfc1002_len(work->request_buf);
+	__u32 req_struct_size;
 
 	if (le32_to_cpu(hdr->NextCommand) > 0)
 		len = le32_to_cpu(hdr->NextCommand);
@@ -373,17 +374,9 @@ int ksmbd_smb2_check_message(struct ksmb
 	}
 
 	if (smb2_req_struct_sizes[command] != pdu->StructureSize2) {
-		if (command != SMB2_OPLOCK_BREAK_HE &&
-		    (hdr->Status == 0 || pdu->StructureSize2 != SMB2_ERROR_STRUCTURE_SIZE2_LE)) {
-			/* error packets have 9 byte structure size */
-			ksmbd_debug(SMB,
-				    "Illegal request size %u for command %d\n",
-				    le16_to_cpu(pdu->StructureSize2), command);
-			return 1;
-		} else if (command == SMB2_OPLOCK_BREAK_HE &&
-			   hdr->Status == 0 &&
-			   le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_20 &&
-			   le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_21) {
+		if (command == SMB2_OPLOCK_BREAK_HE &&
+		    le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_20 &&
+		    le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_21) {
 			/* special case for SMB2.1 lease break message */
 			ksmbd_debug(SMB,
 				    "Illegal request size %d for oplock break\n",
@@ -392,6 +385,14 @@ int ksmbd_smb2_check_message(struct ksmb
 		}
 	}
 
+	req_struct_size = le16_to_cpu(pdu->StructureSize2) +
+		__SMB2_HEADER_STRUCTURE_SIZE;
+	if (command == SMB2_LOCK_HE)
+		req_struct_size -= sizeof(struct smb2_lock_element);
+
+	if (req_struct_size > len + 1)
+		return 1;
+
 	if (smb2_calc_size(hdr, &clc_len))
 		return 1;
 


