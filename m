Return-Path: <stable+bounces-9085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 603FA820A26
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBEA282FB5
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4251844;
	Sun, 31 Dec 2023 07:16:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C0B17C3
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb9d54575cso4997923b6e.2
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007001; x=1704611801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1voDNXeZgBSFhGjppmTuaSQCqgCdcApHBxQlDi7/IGY=;
        b=RbgYvjyYBUrNd9GJ/ZDnkEpu74jszezH2bnMLU5fJiJdsdGpLzOGyTfEV35DlSakUj
         HZGBktHesCddqDqVbD1+Zhg2Ng+glpUai3VJNsv4MAG8AHhNS85MIH1DqMoEv37n+lAE
         ghSaTRWLGh/hvO1o85ejX4tR/Dk6tDNo0iu3hg/6S6fTXa44Z56+rvUGdOG4jADTKmwp
         /zVu/O7WGgGxouLVjQ71niL5omIRcWJUCxllvwARfw1tN9LNqW1VMh2JVF9A79Q7BXbd
         4dwAgiwdXzCcDniKrqbyfGTbXkdyDmSWTbRMHce5u5WhgMZhtXF/V1Vlf1ANI2Y6GWYZ
         FujQ==
X-Gm-Message-State: AOJu0YysyWCNGXJE5x3/eJG3znQdxMCMeuAVgDamy8QrNKwDw1u2cXYi
	joIRaAD3Ux+GBVTE6AiS7Dw=
X-Google-Smtp-Source: AGHT+IFjQpmoChDHOHnHaKQxzB0ftYLAMJ466bDJcw+WxxjHcYLgUfGsbuK0BaK4zyFsenCFqJKnQA==
X-Received: by 2002:a05:6808:3595:b0:3bb:9330:4c60 with SMTP id cp21-20020a056808359500b003bb93304c60mr11761086oib.110.1704007001544;
        Sat, 30 Dec 2023 23:16:41 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:16:41 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 51/73] ksmbd: fix potential double free on smb2_read_pipe() error path
Date: Sun, 31 Dec 2023 16:13:10 +0900
Message-Id: <20231231071332.31724-52-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 1903e6d0578118e9aab1ee23f4a9de55737d1d05 ]

Fix new smatch warnings:
fs/smb/server/smb2pdu.c:6131 smb2_read_pipe() error: double free of 'rpc_resp'

Fixes: e2b76ab8b5c9 ("ksmbd: add support for read compound")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 4f6491f4eafa..ad2ac378d6a3 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6152,12 +6152,12 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		memcpy(aux_payload_buf, rpc_resp->payload, rpc_resp->payload_sz);
 
 		nbytes = rpc_resp->payload_sz;
-		kvfree(rpc_resp);
 		err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
 					     offsetof(struct smb2_read_rsp, Buffer),
 					     aux_payload_buf, nbytes);
 		if (err)
 			goto out;
+		kvfree(rpc_resp);
 	} else {
 		err = ksmbd_iov_pin_rsp(work, (void *)rsp,
 					offsetof(struct smb2_read_rsp, Buffer));
-- 
2.25.1


