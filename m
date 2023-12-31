Return-Path: <stable+bounces-9073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B04AF820A1A
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657861F21FE9
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CFD17C2;
	Sun, 31 Dec 2023 07:16:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095C717F4
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3ef33e68dso52200385ad.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006961; x=1704611761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNl4Mp2Jyz7pvmx57JIw7/lecqtKcfNqhyGm3xjBaug=;
        b=jRNDhIy2rvpGISOT17d+547FKgxIQe4ey7bYRVRi0oVV0mH7CfXBver1SKhzAMpz7o
         OOuSlabN1hSeO5got05vSBJupTwDxBORcwPQyi47U3LwKoIY2zF3OfiR0zxHkxTXAh2/
         sOmlk70FB29A/rn8XQ/bIW3SiuwQOx4Bh3b3jcVwyB5blBlFNCDtul7CoXWFin1zrVab
         zHVx5T6eUzTWtFUJ5IBbASRDeIV0WTR2WNYMhG6wh/xqekSttfpEIekqZFFXH9/GlsiV
         62JpHdlfDIi+u21ZW2lLEvzZ124T7Q59y16N/Kl9jrT+8ks20QrVu/ycuBfxTPy4K3pf
         hgbQ==
X-Gm-Message-State: AOJu0YwFY3GaRT/ajuo4doIPMQ7jqfXV6J0byMHc99XSmO9j2hDWmvch
	MO1i5n2HjIPcOxbjKlkxX9s=
X-Google-Smtp-Source: AGHT+IEO/kGecwtMv0WfqIlsXg7sc6ehswc+16IJPFek/dG+1Pyr2Bcr5VAoiCRpWAxWqgUetnedYw==
X-Received: by 2002:a17:903:6cf:b0:1d4:8277:15e0 with SMTP id kj15-20020a17090306cf00b001d4827715e0mr6273554plb.0.1704006960745;
        Sat, 30 Dec 2023 23:16:00 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:16:00 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 39/73] ksmbd: add missing calling smb2_set_err_rsp() on error
Date: Sun, 31 Dec 2023 16:12:58 +0900
Message-Id: <20231231071332.31724-40-linkinjeon@kernel.org>
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

[ Upstream commit 0e2378eaa2b3a663726cf740d4aaa8a801e2cb31 ]

If some error happen on smb2_sess_setup(), Need to call
smb2_set_err_rsp() to set error response.
This patch add missing calling smb2_set_err_rsp() on error.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 21e3cbd65911..f6055b1f1b1a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1904,6 +1904,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 				ksmbd_conn_set_need_negotiate(conn);
 			}
 		}
+		smb2_set_err_rsp(work);
 	} else {
 		unsigned int iov_len;
 
-- 
2.25.1


