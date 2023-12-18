Return-Path: <stable+bounces-7696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B2F8175D6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA9EB1F2355A
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477535D72D;
	Mon, 18 Dec 2023 15:39:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56BF5A874
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28b866dabdcso556499a91.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913938; x=1703518738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXnthhEIT+z4HcmouvebYbcpssQpMXsgb55UE6UfBQo=;
        b=h/Mr22py71vaNPFoWAxJdJND2Mi38ipzSqJM8j9nZte078UC4ybt+orflGYHIog0qM
         u85lh5gqgYeSGdUyC3En98YD/KgJLfF4ec3cld+KP/SC7rAk3F19LDcDrEvLQxu4UDi7
         vfhl0DNnKDZzQVQRPvfkGyE9e5lJV36Qe+RyqjAnuJEjYS9YmFgdQoXh16iWsFh1gnYs
         WHL15NIOpv5HWXCSw0Y55RiXC0oY5ZY7U/5aOPrxH6cpOfy4QUS4Ry0phQ6yyOAtu6PO
         7OAjAgLjlAsrsE9MuPMWc+X13oTJ4eCldvtAAx52gkE8A5yqCMx0hYdyaNCtBdx/uVZB
         cNMw==
X-Gm-Message-State: AOJu0YwCzemTLf1GnQe0NEW4OB/BMQzdgfodqx8EHkNmPogNFvg3NH5B
	pPps/hZOOePP30UGyLXWdBU=
X-Google-Smtp-Source: AGHT+IFzvHWKaJ9Zio1vdyj80jX1KtS16QSPBoG3J/N1K0PN7Yp9lCwJwbcLHPdRiElzGgILdi0lDQ==
X-Received: by 2002:a17:90b:3695:b0:28b:6e3c:9c17 with SMTP id mj21-20020a17090b369500b0028b6e3c9c17mr587625pjb.85.1702913937957;
        Mon, 18 Dec 2023 07:38:57 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:57 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 067/154] ksmbd: Fix resource leak in smb2_lock()
Date: Tue, 19 Dec 2023 00:33:27 +0900
Message-Id: <20231218153454.8090-68-linkinjeon@kernel.org>
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

[ Upstream commit 01f6c61bae3d658058ee6322af77acea26a5ee3a ]

"flock" is leaked if an error happens before smb2_lock_init(), as the
lock is not added to the lock_list to be cleaned up.

Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 08d416beb88e..c29c22490f8d 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6907,6 +6907,7 @@ int smb2_lock(struct ksmbd_work *work)
 		if (lock_start > U64_MAX - lock_length) {
 			pr_err("Invalid lock range requested\n");
 			rsp->hdr.Status = STATUS_INVALID_LOCK_RANGE;
+			locks_free_lock(flock);
 			goto out;
 		}
 
@@ -6926,6 +6927,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    "the end offset(%llx) is smaller than the start offset(%llx)\n",
 				    flock->fl_end, flock->fl_start);
 			rsp->hdr.Status = STATUS_INVALID_LOCK_RANGE;
+			locks_free_lock(flock);
 			goto out;
 		}
 
@@ -6937,6 +6939,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    flock->fl_type != F_UNLCK) {
 					pr_err("conflict two locks in one request\n");
 					err = -EINVAL;
+					locks_free_lock(flock);
 					goto out;
 				}
 			}
@@ -6945,6 +6948,7 @@ int smb2_lock(struct ksmbd_work *work)
 		smb_lock = smb2_lock_init(flock, cmd, flags, &lock_list);
 		if (!smb_lock) {
 			err = -EINVAL;
+			locks_free_lock(flock);
 			goto out;
 		}
 	}
-- 
2.25.1


