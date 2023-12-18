Return-Path: <stable+bounces-7677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C58175B8
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11961283CAC
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B181F498A0;
	Mon, 18 Dec 2023 15:38:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CC54238C
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28ade227850so2539454a91.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913880; x=1703518680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2Y76aVz5GmC8fhi/aJA8sBgs09rDzP9YAj+STz6hOo=;
        b=RNWY4VGc9pNSKCiPAce3DVIgNW7h/bBY3g98G+Zea1YY2iQ5o7sxFsgStdQH4A+jGQ
         NQn+uLQ+E4hfYGiDcTy/fgZjP6K2pCR05uSalMJW+AxcMSIHkfRfX5m2Rpfh+oP+Z169
         Ff1bpqfJMtGYY4Voj77R/V+BcQrKOhYJc+JsIklx9SGxeJdYunT9gV5TzTVyl3J7UpYD
         NwQJhEAyFvnQwZp2st2OQ0R88MZGAS3d5iYenUQNFPrJzWOenawW5KOtTr0xXPBi4jhi
         PYhlmTC4y8JKDhh0k10T8+FkLVGWuifxJeL5ujX0N6ujlQVqktGjPAcr52TvWoJqVZGQ
         xGcQ==
X-Gm-Message-State: AOJu0YxeYUb9tf0oENZ39hl31UuwK2J1oIVpQS7GxLUrVoSW0pL8ZxoF
	EyCTpiwEnrWJ/GdFztCC9elA49fXsvg=
X-Google-Smtp-Source: AGHT+IGWtO0p3gc58V775yMQGZyNpIDjLzvqDPxsfHiFbKx3zIN4cclFG8Yt3PIZtaaQmKUXz4mjlw==
X-Received: by 2002:a17:90a:d16:b0:28b:2c7d:7552 with SMTP id t22-20020a17090a0d1600b0028b2c7d7552mr2543860pja.42.1702913879809;
        Mon, 18 Dec 2023 07:37:59 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:59 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 048/154] ksmbd: don't open-code file_path()
Date: Tue, 19 Dec 2023 00:33:08 +0900
Message-Id: <20231218153454.8090-49-linkinjeon@kernel.org>
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

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 2f5930c1d7936b74eb820c5b157011994c707a74 ]

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index f74f2ffa0f07..5ca491e73c6d 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5449,7 +5449,7 @@ static int smb2_rename(struct ksmbd_work *work,
 	if (!pathname)
 		return -ENOMEM;
 
-	abs_oldname = d_path(&fp->filp->f_path, pathname, PATH_MAX);
+	abs_oldname = file_path(fp->filp, pathname, PATH_MAX);
 	if (IS_ERR(abs_oldname)) {
 		rc = -EINVAL;
 		goto out;
@@ -5584,7 +5584,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 	}
 
 	ksmbd_debug(SMB, "link name is %s\n", link_name);
-	target_name = d_path(&filp->f_path, pathname, PATH_MAX);
+	target_name = file_path(filp, pathname, PATH_MAX);
 	if (IS_ERR(target_name)) {
 		rc = -EINVAL;
 		goto out;
-- 
2.25.1


