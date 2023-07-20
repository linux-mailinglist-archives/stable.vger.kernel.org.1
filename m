Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE3375AFA0
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 15:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjGTNZb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 09:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjGTNZb (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 09:25:31 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA61810F5
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:25:29 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b9d80e33fbso4937025ad.0
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859529; x=1690464329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WhQRUMsjHuyBdC8HHQSVlCJjultQAjg+qiWp3b375c=;
        b=Nu2QSVC3kmRBECBOgCSNGbHTPdaV+8Bx1p0oFUfgUTTFf/BSjdVaH8rn+vxeOz1L3J
         l2POnPVyx094eQ+ZnuZQ/8Z/yB/DZ4jaQqT3nncmhOXZv27XPTzKcmswq3yGpRhhe/x1
         vfe9qysHN1tLjOJhCvYH28WjCa7b/j/tiqaT4FnQyPzDJgmdiZEyn+0DZU3zBuoDgs3F
         6MxU14xrF4L9+vJQEPHmHA2bLwyBx3o/3Dot1iRt/SRupa9b2Q+ARnqB6CIIwfmhadlb
         BZyhfGjfEG8Veo0nLEyYhj+TBLcaVAhersMecKxEBZ30OpC5vfphsHZyx8cqkd5sbKVx
         t7oQ==
X-Gm-Message-State: ABy/qLYNUKYVsTDVybW5mN/DGXEVHzGH1CxeRbXzM0zp7W2Z7sdKwwg/
        hlD+9aCNdqKkILFRebWhP5cix1NHHWc=
X-Google-Smtp-Source: APBJJlEtC7lqQm6Q4/S/fbuXoLMPIYFLlJG/qIWHfgvWt6sibU8d5nRjzhBOGZn3tom0e3Omac2qBw==
X-Received: by 2002:a17:902:7d86:b0:1b8:8670:541 with SMTP id a6-20020a1709027d8600b001b886700541mr4581111plm.25.1689859529121;
        Thu, 20 Jul 2023 06:25:29 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id jg19-20020a17090326d300b001b9bebb7a9dsm1336039plb.90.2023.07.20.06.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:25:28 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stfrench@microsoft.com,
        smfrench@gmail.com, Namjae Jeon <linkinjeon@kernel.org>,
        Chih-Yen Chang <cc85nod@gmail.com>
Subject: [5.15.y PATCH 2/4] ksmbd: validate command payload size
Date:   Thu, 20 Jul 2023 22:23:29 +0900
Message-Id: <20230720132336.7614-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720132336.7614-1-linkinjeon@kernel.org>
References: <20230720132336.7614-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
---
 fs/ksmbd/smb2misc.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index abc18af14f04..ad805b37b81d 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -352,6 +352,7 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 	int command;
 	__u32 clc_len;  /* calculated length */
 	__u32 len = get_rfc1002_len(work->request_buf);
+	__u32 req_struct_size;
 
 	if (le32_to_cpu(hdr->NextCommand) > 0)
 		len = le32_to_cpu(hdr->NextCommand);
@@ -374,17 +375,9 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
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
@@ -393,6 +386,14 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
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
 
-- 
2.25.1

