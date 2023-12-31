Return-Path: <stable+bounces-9038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4928209F6
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AD11C20978
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C69517D3;
	Sun, 31 Dec 2023 07:13:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD817C7
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9b51093a0so4147163b3a.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006837; x=1704611637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xU4KMXDx1vlNLMYWaqDPbn64dvK5obg9vwS4ta+Lkq0=;
        b=atQnIbxxAGet62KIbPS1hSzLzjg67pMOmVB+vfoboRx7rk1hltnn+lGAtFdHAIc0U7
         B0+JNk+X9N2aima9ZgHJUAjVGkYNGPxBl1MNbutFAtbvhh9vjTZBk8IvB6NxSVJSZsS/
         VAyaf0cI4yvfRIYUuONfYVkBUWwHw1y+lz6CXudfTrlNvugZB/BJyMAEuVrji05CHW7p
         MIyY61KxcPru0IlLYzM1pllMq8XdGsYvco9F4JcyhH9sJxqw1QVZl502yQ3bz/6Y6f2k
         uzRFcfLoSEra2tKN9CRk/s3+tOxTWZvhbAw7q02G7FUsI/lbE9BqcfEP8Fx/IhUl230G
         Vkeg==
X-Gm-Message-State: AOJu0Yy4G1teXpVHXQI8YjJV9PVG2qb6kH90ZQ9hA1tQlYxNTYc9F8pS
	oGx+EkgolY8VGUffcUNWKFxkKtGbHM0=
X-Google-Smtp-Source: AGHT+IEkBxG1HqIEeZNFbdOWSfBJgfuqDlM5ji4XrRGCBt75hAHIVeIy7/HQewQfoyBiKX3kAXCVXA==
X-Received: by 2002:aa7:8517:0:b0:6d9:aab9:c75c with SMTP id v23-20020aa78517000000b006d9aab9c75cmr12090220pfn.23.1704006837094;
        Sat, 30 Dec 2023 23:13:57 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:13:56 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Marios Makassikis <mmakassikis@freebox.fr>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 04/73] ksmbd: Fix resource leak in smb2_lock()
Date: Sun, 31 Dec 2023 16:12:23 +0900
Message-Id: <20231231071332.31724-5-linkinjeon@kernel.org>
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

From: Marios Makassikis <mmakassikis@freebox.fr>

[ Upstream commit 01f6c61bae3d658058ee6322af77acea26a5ee3a ]

"flock" is leaked if an error happens before smb2_lock_init(), as the
lock is not added to the lock_list to be cleaned up.

Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 554214fca5b7..21d0416f1101 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6951,6 +6951,7 @@ int smb2_lock(struct ksmbd_work *work)
 		if (lock_start > U64_MAX - lock_length) {
 			pr_err("Invalid lock range requested\n");
 			rsp->hdr.Status = STATUS_INVALID_LOCK_RANGE;
+			locks_free_lock(flock);
 			goto out;
 		}
 
@@ -6970,6 +6971,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    "the end offset(%llx) is smaller than the start offset(%llx)\n",
 				    flock->fl_end, flock->fl_start);
 			rsp->hdr.Status = STATUS_INVALID_LOCK_RANGE;
+			locks_free_lock(flock);
 			goto out;
 		}
 
@@ -6981,6 +6983,7 @@ int smb2_lock(struct ksmbd_work *work)
 				    flock->fl_type != F_UNLCK) {
 					pr_err("conflict two locks in one request\n");
 					err = -EINVAL;
+					locks_free_lock(flock);
 					goto out;
 				}
 			}
@@ -6989,6 +6992,7 @@ int smb2_lock(struct ksmbd_work *work)
 		smb_lock = smb2_lock_init(flock, cmd, flags, &lock_list);
 		if (!smb_lock) {
 			err = -EINVAL;
+			locks_free_lock(flock);
 			goto out;
 		}
 	}
-- 
2.25.1


