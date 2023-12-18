Return-Path: <stable+bounces-7641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF88D817568
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941951F24AE2
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A62342042;
	Mon, 18 Dec 2023 15:35:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D293D54C
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28abca51775so1260262a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913756; x=1703518556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjsHXr81oec1VJ+O2fcJW2Fe7DrJPVG5ax0FaYb0EUs=;
        b=SyCg1+3D2xgPLFO6CtKWzyFg8tDiF/UiKddCu0y4pfbMlUQ3MoA9deXzLvZisZdR/B
         1nkvhQFLlvA7g9c0LMFm97SJKhstpqFASHbPtfKtjdspluiwlgTO0qqKXvyB/Yq7W7U8
         DfzOdRaKS3//YiDs6X2caV1adrt8wrOaT8ieZqg4QZwzgGRzg/QSDxSmdDoHD8yHVK+2
         ZgGOjbSAOsoxOOySPHjiqWlfP8gt2nRbLmcW4j/sBRcaySmGc+ZaXx1ZyqXrbvHzYaLP
         yWMn0gnse3lxrg4hSNU87fVqJFtGi9bPY8f5QA0Y8DveoqIJBANqCJIJatcyDf7WiIBO
         3e1w==
X-Gm-Message-State: AOJu0YyE3k8ppbebj6GboEu2/p7Ufw0oOVJcKBEa+lgM18vfqXRC9el8
	k0aQaKo9XTKZaXxcqgj408I=
X-Google-Smtp-Source: AGHT+IGtBEYLCXmIdKvxCaPz9/gGPtAUTTmaWC6VscqHHFvph+QcQAsJWImoJeT+UiBsIScksLwSdQ==
X-Received: by 2002:a17:90a:868b:b0:28b:5172:a5be with SMTP id p11-20020a17090a868b00b0028b5172a5bemr774156pjn.69.1702913755852;
        Mon, 18 Dec 2023 07:35:55 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:35:55 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 012/154] ksmbd: Fix buffer_check_err() kernel-doc comment
Date: Tue, 19 Dec 2023 00:32:32 +0900
Message-Id: <20231218153454.8090-13-linkinjeon@kernel.org>
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

From: Yang Li <yang.lee@linux.alibaba.com>

[ Upstream commit e230d013378489bcd4b5589ca1d2a5b91ff8d098 ]

Add the description of @rsp_org in buffer_check_err() kernel-doc comment
to remove a warning found by running scripts/kernel-doc, which is caused
by using 'make W=1'.
fs/ksmbd/smb2pdu.c:4028: warning: Function parameter or member 'rsp_org'
not described in 'buffer_check_err'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: cb4517201b8a ("ksmbd: remove smb2_buf_length in smb2_hdr")
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index cf883f9575bc..0edb0a96766d 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4101,6 +4101,7 @@ int smb2_query_dir(struct ksmbd_work *work)
  * buffer_check_err() - helper function to check buffer errors
  * @reqOutputBufferLength:	max buffer length expected in command response
  * @rsp:		query info response buffer contains output buffer length
+ * @rsp_org:		base response buffer pointer in case of chained response
  * @infoclass_size:	query info class response buffer size
  *
  * Return:	0 on success, otherwise error
-- 
2.25.1


