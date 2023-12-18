Return-Path: <stable+bounces-7631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE6F817557
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE8C1C22A8A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E953D54B;
	Mon, 18 Dec 2023 15:35:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A33D540
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28b866dabdcso549183a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:35:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913720; x=1703518520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1PQ1i4q/YYo106dRwOjheeFa2O4hOasML6yK2IBil8=;
        b=h8fNPblFBqbG4UVuk8YVnNONl+jg+8CwSoIQ13GwQzH2I6JqRVtyFxHGJr0/USkGdL
         D3tuxWfm0LiLjN/R1h5HXIjOlv3MpC0MHcl9nHCS5IZEpfyq9wzEUFBhEXEXPNl7bat/
         EM3TnoYPBgKskhzYYb8d202WXusLtW972UZQMFMC98wozpp03cmqpj93dq7TOGiRORoO
         n+U5NPs8m1qJf7/zWDiv8f84C9tKun9c+oxE/GiBNbKazLRvUj7leMelWF/gkdpYAG2b
         cjMkQb0FQ3P1kfycm2crYhhjbTG5gLKVSEuxVq88DUmQqeH5sNit59aKs++9QSJwlHoc
         1JSg==
X-Gm-Message-State: AOJu0YxHz741K+dMELdBEyYe0btht+NfYi9vOUTVOZEBSOjxRtVdthaA
	goodFwquVOpKC8S6sMXUQh4=
X-Google-Smtp-Source: AGHT+IEYjRIuSmMHnIV24iCC0UBgbqL+ESDTP08jApC4CFik80va67H93kPQKHgN45KjJyfGDigBYg==
X-Received: by 2002:a17:90a:ba8a:b0:28b:4e25:c777 with SMTP id t10-20020a17090aba8a00b0028b4e25c777mr784111pjr.27.1702913720035;
        Mon, 18 Dec 2023 07:35:20 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:35:19 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Ralph Boehme <slow@samba.org>,
	Tom Talpey <tom@talpey.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 002/154] ksmdb: use cmd helper variable in smb2_get_ksmbd_tcon()
Date: Tue, 19 Dec 2023 00:32:22 +0900
Message-Id: <20231218153454.8090-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralph Boehme <slow@samba.org>

[ Upstream commit 341b16014bf871115f0883e831372c4b76389d03 ]

Use cmd helper variable in smb2_get_ksmbd_tcon().

Cc: Tom Talpey <tom@talpey.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Steve French <smfrench@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Ralph Boehme <slow@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 656c627d1bdf..d41ff22d07f2 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -95,11 +95,12 @@ struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn
 int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 {
 	struct smb2_hdr *req_hdr = work->request_buf;
+	unsigned int cmd = le16_to_cpu(req_hdr->Command);
 	int tree_id;
 
-	if (work->conn->ops->get_cmd_val(work) == SMB2_TREE_CONNECT_HE ||
-	    work->conn->ops->get_cmd_val(work) ==  SMB2_CANCEL_HE ||
-	    work->conn->ops->get_cmd_val(work) ==  SMB2_LOGOFF_HE) {
+	if (cmd == SMB2_TREE_CONNECT_HE ||
+	    cmd ==  SMB2_CANCEL_HE ||
+	    cmd ==  SMB2_LOGOFF_HE) {
 		ksmbd_debug(SMB, "skip to check tree connect request\n");
 		return 0;
 	}
-- 
2.25.1


