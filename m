Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2455D75D359
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjGUTJh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjGUTJf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:09:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC1C30F1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:09:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 356C961D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4405DC433C7;
        Fri, 21 Jul 2023 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966572;
        bh=HvZUa077giHemqNzcSICA/4gLZG1ZBMbr9f7lLX6Sg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fH0f8+9S7yJ+TEoEhpZPjXbeeWSaoU1sEYfXnASNm78HubQ+uGS/TQxVrUsE5Hkcn
         dAJcg+GvC0izPfT5/bx7vOrSTzKEXrzLaRJhRVsvSXJ/3AwI17gnHVM1ZVdtIcr7HG
         nL6LLLbKbSSHcsnl2wJkqjp95OGD+AslHw5orrgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chih-Yen Chang <cc85nod@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15 392/532] ksmbd: validate command payload size
Date:   Fri, 21 Jul 2023 18:04:56 +0200
Message-ID: <20230721160635.740534714@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
@@ -352,6 +352,7 @@ int ksmbd_smb2_check_message(struct ksmb
 	int command;
 	__u32 clc_len;  /* calculated length */
 	__u32 len = get_rfc1002_len(work->request_buf);
+	__u32 req_struct_size;
 
 	if (le32_to_cpu(hdr->NextCommand) > 0)
 		len = le32_to_cpu(hdr->NextCommand);
@@ -374,17 +375,9 @@ int ksmbd_smb2_check_message(struct ksmb
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
@@ -393,6 +386,14 @@ int ksmbd_smb2_check_message(struct ksmb
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
 


