Return-Path: <stable+bounces-7643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C909B817572
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA941C20ABF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C253B3D54A;
	Mon, 18 Dec 2023 15:36:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00649895
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3ac28ae81so12266685ad.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913763; x=1703518563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBXwHscawigJorZpfyrpisUsvEaeLzMtB3kmQIN91EY=;
        b=kk2fwwJKdh9C9/mhIpeh7jq5Ocv8UaEuJ08My49nBIkbxfzh9alQS6735t1Ir5+XJ8
         M3JgI4mFAwHXC0CNA2mjdq38SxTZ29aZovuXGLdtgw7NBziicDS3gbAF5l5KmYmREwA1
         cjwCgsnTX/6qWKl3la9Y0evsAOOlTEViWsSYl4DvQU57MpXcnkPIIZ7+fF+ajWkWMRcn
         dDEFEIMmI4s4iWnyUyGeiSujPz2s6XrVpBggRsn2akjbqDe2Svh8AXu/Evi80gBJ/5uA
         6pMwDN79hHE8bt+VuJfqrSLj4TZgcFmmL8WdS5pzaxAwTRrmA4EdT8rM0xaRfcMaxhGE
         AtZA==
X-Gm-Message-State: AOJu0YynFF2dp5aO7u1k0k6mPeSUnls80ViY98WJgiTRROej+MhaY5zw
	iEzX9SYQ5flgAgArmOiJseA=
X-Google-Smtp-Source: AGHT+IFEPgxlV1TERJSCG3P2KN66HiQnm+ncPDJBUK02HuBLTB0CgIF4I/5Rx0LLUI115nu57zdWaA==
X-Received: by 2002:a17:90b:38c8:b0:286:da6d:c41 with SMTP id nn8-20020a17090b38c800b00286da6d0c41mr10861136pjb.70.1702913763550;
        Mon, 18 Dec 2023 07:36:03 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:03 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 014/154] ksmbd: Delete an invalid argument description in smb2_populate_readdir_entry()
Date: Tue, 19 Dec 2023 00:32:34 +0900
Message-Id: <20231218153454.8090-15-linkinjeon@kernel.org>
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

[ Upstream commit f5c381392948dcae19f854b9586b806654f08a11 ]

A warning is reported because an invalid argument description, it is found
by running scripts/kernel-doc, which is caused by using 'make W=1'.
fs/ksmbd/smb2pdu.c:3406: warning: Excess function parameter 'user_ns'
description in 'smb2_populate_readdir_entry'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 475d6f98804c ("ksmbd: fix translation in smb2_populate_readdir_entry()")
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 3118ef0aae50..5980b625a0f9 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3466,7 +3466,6 @@ static int dentry_name(struct ksmbd_dir_info *d_info, int info_level)
  * @conn:	connection instance
  * @info_level:	smb information level
  * @d_info:	structure included variables for query dir
- * @user_ns:	user namespace
  * @ksmbd_kstat:	ksmbd wrapper of dirent stat information
  *
  * if directory has many entries, find first can't read it fully.
-- 
2.25.1


