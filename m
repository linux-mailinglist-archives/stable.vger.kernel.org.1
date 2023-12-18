Return-Path: <stable+bounces-7639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE7D817564
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DBD1C245C2
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433F83D568;
	Mon, 18 Dec 2023 15:35:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75ED3D54C
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28b9e9e83b0so419265a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913749; x=1703518549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0iqYbk2jCKyzY2t84h43tc2xdKWC2M/ZYqh/0t6/Y0=;
        b=NqNzjbMynjeBxvMOzgHjb+lsdAjyeAQwZ9WF4X51nMRoBLNzM5p7+zOWBTLRhUJLRO
         dMoaC4H3ZrSQLEaGeqn9UqbHwmyXYjPPorkHB+vqzAIeujmbp1ItJHPqzZ2wX7O3zzGQ
         og1ptoaruENls7+3lKXVEzn60YIosQsH8eU9ljErBEwc5NkAwsorsCuEIRgu8K5jHQTZ
         6PCLSAjpafdG+dqUKeNn62X0sCUS/5fSAQqDg6I+5oXPzTM0+cdjtQcVM3uPdpAy9sPL
         nZGmaJHJvkABdzGaonJoD9AFyzmjXMyjcRKG0jnFrWF+JCHtUOVFhasSstD25XbjNpe9
         VA0w==
X-Gm-Message-State: AOJu0Yx9lP3rcEwL+tuzKufPK5CiJ0TxbWA99f690YODfVw81d+vLBDA
	sNP5YGVtOVPWn3bRtB8mgnk=
X-Google-Smtp-Source: AGHT+IFpyTScrRdZNdLN8Ri63iAmvCPLu26Kl5h8rtEuKTE6PeWXqKihc7x71D/MEyPs/jDVhcc56g==
X-Received: by 2002:a17:90b:30c3:b0:28b:af88:5f8 with SMTP id hi3-20020a17090b30c300b0028baf8805f8mr92140pjb.83.1702913749105;
        Mon, 18 Dec 2023 07:35:49 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:35:48 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 010/154] ksmbd: Remove unused fields from ksmbd_file struct definition
Date: Tue, 19 Dec 2023 00:32:30 +0900
Message-Id: <20231218153454.8090-11-linkinjeon@kernel.org>
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

From: Marios Makassikis <mmakassikis@freebox.fr>

[ Upstream commit 305f8bda15ebbe4004681286a5c67d0dc296c771 ]

These fields are remnants of the not upstreamed SMB1 code.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/vfs_cache.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/ksmbd/vfs_cache.h b/fs/ksmbd/vfs_cache.h
index 448576fbe4b7..36239ce31afd 100644
--- a/fs/ksmbd/vfs_cache.h
+++ b/fs/ksmbd/vfs_cache.h
@@ -96,16 +96,6 @@ struct ksmbd_file {
 
 	int				durable_timeout;
 
-	/* for SMB1 */
-	int				pid;
-
-	/* conflict lock fail count for SMB1 */
-	unsigned int			cflock_cnt;
-	/* last lock failure start offset for SMB1 */
-	unsigned long long		llock_fstart;
-
-	int				dirent_offset;
-
 	/* if ls is happening on directory, below is valid*/
 	struct ksmbd_readdir_data	readdir_data;
 	int				dot_dotdot[2];
-- 
2.25.1


