Return-Path: <stable+bounces-7735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 879A4817608
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9E41C251E2
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162773493;
	Mon, 18 Dec 2023 15:41:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED213768F3
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28b0016d989so1214404a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702914061; x=1703518861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrMOOs89xoJftut9PT+9z/9iDaRiYvEwfhmRPk4GIkM=;
        b=C5MEBlZEQhNDwhJTm5GAp1yXRQZPF/4+sxCl5rP/wbI9pGikURGbg5UthBPEPKJG++
         10Z8Z5sLWfYHGG4l3K2ZdAdhzS3XpwSQSDsddcZUekjypHObdbJREg0APy7RqgNe6ROS
         jHbnd9hiYmv0IpZquCCfpwM9+7lvoxahmB1qLygMyi2iN2MhFwM64WrQiZ1NFlR32Wm1
         +W1EUG3Y1kJWPaLoSZu8xzohp/8LGc9hmWT7Kh9/FFo7wYXTmJM/aApQhYeEestq3+4d
         tyy8LDLVCdy6iJGHd6ghtDXVnmXE/wGAuLvwC83P6ZEK4Q91+sQeCfAiVqBTLsY6Q+1w
         Pa8Q==
X-Gm-Message-State: AOJu0YxnVU4RrEbxlm5bhFq5DU1aSf/nuxIytU9T7SqSp8UVjt37od9Z
	7vi5UNIOpcINIs9g1rVL21k=
X-Google-Smtp-Source: AGHT+IHANXNn6qX1CZsnMs3u8sj2WEbEBeUC1IagbiarBZqTF91t6Y7kZFvjEcvgSZofvpCpwjdWWA==
X-Received: by 2002:a17:90b:3b87:b0:28b:7643:e65c with SMTP id pc7-20020a17090b3b8700b0028b7643e65cmr664921pjb.56.1702914061358;
        Mon, 18 Dec 2023 07:41:01 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:41:00 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 106/154] ksmbd: return a literal instead of 'err' in ksmbd_vfs_kern_path_locked()
Date: Tue, 19 Dec 2023 00:34:06 +0900
Message-Id: <20231218153454.8090-107-linkinjeon@kernel.org>
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

[ Upstream commit cf5e7f734f445588a30350591360bca2f6bf016f ]

Return a literal instead of 'err' in ksmbd_vfs_kern_path_locked().

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index e58fbbfda7b2..7d239d3f8dbd 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1209,7 +1209,7 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 
 	err = ksmbd_vfs_path_lookup_locked(share_conf, name, flags, path);
 	if (!err)
-		return err;
+		return 0;
 
 	if (caseless) {
 		char *filepath;
-- 
2.25.1


