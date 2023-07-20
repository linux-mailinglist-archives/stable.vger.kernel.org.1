Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45FC75AFA1
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 15:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjGTNZe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 09:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjGTNZd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 09:25:33 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F0171E
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:25:33 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1b8a44ee159so4805105ad.3
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859532; x=1690464332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhlAu1eICXeBI1J16lD6+kJmM3QBdBRmM+5AcndDW4M=;
        b=jpPGvbcJgoCcXjHuDsiFzreo4vStD1O6+V+bcdrcg8RCTLTeZS/zq3Xnj/s5d2m36f
         1Fh0uz1QaQ1SrP9YJOyRo5lI5EiOfxyVbSHsHMQvB/bPAbwg/ZErfdjs67wF0PEj9who
         9C4/ZkxinhQtl6iUal/HVR0fLb4030sZQW8IHNEXmNyu77fW9S3Bch1CuU3KyR8bXoFF
         gRXI4BH/N0t0Qw5LEtRePbPSEfiKVnic8b1GRGLNZAPFNqOR7eBakvfqJcf5ubbjJQin
         sxiK6fm4Z+8UTITfMxXX6Cu36y7AL4pQZu9Pz4LQi4NKLrE/C2rLW6niD7pEEWKRk0/q
         x/JA==
X-Gm-Message-State: ABy/qLY/mUhI64gsNKvbGwmXxrv1xqH2Mq8fjSmA7QJsaHBnTlqxSaaC
        UvEGhfr6O7WpMQ8WwoLyl8sGm1CaEXU=
X-Google-Smtp-Source: APBJJlEPW8pBuJ1ujRGy6Umpwfjl6zU6mq16cLGznMJvFd68KwMlzzDANc8uTBpDSht0mqMGPYvOng==
X-Received: by 2002:a17:902:700b:b0:1b6:a972:4414 with SMTP id y11-20020a170902700b00b001b6a9724414mr1702827plk.3.1689859532524;
        Thu, 20 Jul 2023 06:25:32 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id jg19-20020a17090326d300b001b9bebb7a9dsm1336039plb.90.2023.07.20.06.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:25:32 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stfrench@microsoft.com,
        smfrench@gmail.com, Namjae Jeon <linkinjeon@kernel.org>,
        zdi-disclosures@trendmicro.com
Subject: [5.15.y PATCH 3/4] ksmbd: fix out-of-bound read in smb2_write
Date:   Thu, 20 Jul 2023 22:23:30 +0900
Message-Id: <20230720132336.7614-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720132336.7614-1-linkinjeon@kernel.org>
References: <20230720132336.7614-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 5fe7f7b78290638806211046a99f031ff26164e1 upstream.

ksmbd_smb2_check_message doesn't validate hdr->NextCommand. If
->NextCommand is bigger than Offset + Length of smb2 write, It will
allow oversized smb2 write length. It will cause OOB read in smb2_write.

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21164
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2misc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index ad805b37b81d..c24674fc1904 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -352,10 +352,16 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 	int command;
 	__u32 clc_len;  /* calculated length */
 	__u32 len = get_rfc1002_len(work->request_buf);
-	__u32 req_struct_size;
+	__u32 req_struct_size, next_cmd = le32_to_cpu(hdr->NextCommand);
 
-	if (le32_to_cpu(hdr->NextCommand) > 0)
-		len = le32_to_cpu(hdr->NextCommand);
+	if ((u64)work->next_smb2_rcv_hdr_off + next_cmd > len) {
+		pr_err("next command(%u) offset exceeds smb msg size\n",
+				next_cmd);
+		return 1;
+	}
+
+	if (next_cmd > 0)
+		len = next_cmd;
 	else if (work->next_smb2_rcv_hdr_off)
 		len -= work->next_smb2_rcv_hdr_off;
 
-- 
2.25.1

