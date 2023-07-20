Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F97B75AF9F
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjGTNZ3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 09:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjGTNZ1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 09:25:27 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751C210F5
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:25:26 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b8b318c5a7so5599635ad.3
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 06:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859526; x=1690464326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COPG93mev8fMqXjLdSouxJrO2GsfWHyb7XgSFZkDMBU=;
        b=g08XU6UAsAd2Q63+XOJ6ktKhIvUlROq+KPC6p9lX6JHncR7uiStpNBtAyE+BHcXmjn
         TH+MwfaV4V55VotvRvGPkpP1wNsHeopDNUY1ZotmsYUw92F5MH4KiLWCzUJxogzesHHW
         QG7ZhBF2fl6zLbLbrevxGCMSptjpThv253aoAtLbX+evFjeB2TUHR93Hem91EeYs9Bx0
         w2arXk/+GtfTPpHjCZDrt6ynwkDKylynhMNAeyugzpSUgfyG8SMXiz3HYhWQjzcSam2b
         llmXeGctXw82oW4xm5zKUftWwleNW0geTetJb5bQTF+QueL2PNVBEQfQolzRRPD3cVvX
         y6bg==
X-Gm-Message-State: ABy/qLZrVcx5lLJI/cn/DmLpyNr/+7HQgvgNUO25zA4QxsatpoupTJMI
        CPSY2D3zpMi2A/OILu+2ZpwZyn0qdy8=
X-Google-Smtp-Source: APBJJlGy9ml2Nz1ij6RLlSpwLhSVW7aIm10kEzTRqgY68DhVH9XfLoN3p9krUzwLqDwiE+0UEFzfFA==
X-Received: by 2002:a17:903:1251:b0:1b8:6cac:ffe8 with SMTP id u17-20020a170903125100b001b86cacffe8mr27370893plh.51.1689859525679;
        Thu, 20 Jul 2023 06:25:25 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id jg19-20020a17090326d300b001b9bebb7a9dsm1336039plb.90.2023.07.20.06.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:25:25 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stfrench@microsoft.com,
        smfrench@gmail.com, Namjae Jeon <linkinjeon@kernel.org>,
        Ralph Boehme <slow@samba.org>, Tom Talpey <tom@talpey.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Hyunchul Lee <hyc.lee@gmail.com>
Subject: [5.15.y PATCH 1/4] ksmbd: use ksmbd_req_buf_next() in ksmbd_smb2_check_message()
Date:   Thu, 20 Jul 2023 22:23:28 +0900
Message-Id: <20230720132336.7614-2-linkinjeon@kernel.org>
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

From: Ralph Boehme <slow@samba.org>

commit b83b27909e74d27796de19c802fbc3b65ab4ba9a upstream.

Use ksmbd_req_buf_next() in ksmbd_smb2_check_message().

Cc: Tom Talpey <tom@talpey.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Steve French <smfrench@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Ralph Boehme <slow@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2misc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index 33a927df64f1..abc18af14f04 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -347,16 +347,11 @@ static int smb2_validate_credit_charge(struct ksmbd_conn *conn,
 
 int ksmbd_smb2_check_message(struct ksmbd_work *work)
 {
-	struct smb2_pdu *pdu = work->request_buf;
+	struct smb2_pdu *pdu = ksmbd_req_buf_next(work);
 	struct smb2_hdr *hdr = &pdu->hdr;
 	int command;
 	__u32 clc_len;  /* calculated length */
-	__u32 len = get_rfc1002_len(pdu);
-
-	if (work->next_smb2_rcv_hdr_off) {
-		pdu = ksmbd_req_buf_next(work);
-		hdr = &pdu->hdr;
-	}
+	__u32 len = get_rfc1002_len(work->request_buf);
 
 	if (le32_to_cpu(hdr->NextCommand) > 0)
 		len = le32_to_cpu(hdr->NextCommand);
-- 
2.25.1

