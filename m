Return-Path: <stable+bounces-9037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBDC8209F7
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF55B21705
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DA917C2;
	Sun, 31 Dec 2023 07:13:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A86E184C
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbbf5a59b7so3497661b6e.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:13:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006833; x=1704611633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENV0U1ctp0lZ/L7fnKB2LxFecZX3KvSDH5OLF9rmqAA=;
        b=wOxQaIn5b2F4KXK7jdJRkCFjWeq/CJU+NtJ1sakeHV4VQm3w4OcA9LT2f8CCN3EBni
         Nk4Zqul1/EnfjkgIZYvGFYJYcrrU3+poHLRF51VC5okeQ9KkjHovhZWflJh3bIC4mdFS
         IH4zsJFt5Ake5DZCo0t+R3CQ0L1IW3IfV699Plqb8LQl6Jndhmi5ljTq9hFYRcnnkyJw
         QZZdd4ZFE2//jaMmo5ANtiD/xnjCx0HyN+c2BblKL0utUSrwnlfYhpIsPoN/s+m3ma0R
         GjEQZz4/IyuvmV7WyGU94i907m/vPkhL7WJsk7MTl2HCuM5hGQBM/mZe4Bv21RSLqttg
         LUWg==
X-Gm-Message-State: AOJu0YzxEu3U+8RhZh4/Sw+yrfI4lCF/e2MQCjDLc/3Vfn2JQB/TxT8U
	rEWfB40dGg2j421+yI0F8Mc=
X-Google-Smtp-Source: AGHT+IHUC6n3I0Ande6ziL3t66AWr9UStzkQIFdk4wJSDJ9opIZFeqmb7zoHDGENVCCQb5xnbGbtgA==
X-Received: by 2002:a05:6808:10c2:b0:3bb:f921:7d5d with SMTP id s2-20020a05680810c200b003bbf9217d5dmr1485292ois.103.1704006833313;
        Sat, 30 Dec 2023 23:13:53 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:13:52 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Jeff Layton <jlayton@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 03/73] ksmbd: use F_SETLK when unlocking a file
Date: Sun, 31 Dec 2023 16:12:22 +0900
Message-Id: <20231231071332.31724-4-linkinjeon@kernel.org>
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 7ecbe92696bb7fe32c80b6cf64736a0d157717a9 ]

ksmbd seems to be trying to use a cmd value of 0 when unlocking a file.
That activity requires a type of F_UNLCK with a cmd of F_SETLK. For
local POSIX locking, it doesn't matter much since vfs_lock_file ignores
@cmd, but filesystems that define their own ->lock operation expect to
see it set sanely.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f5a46b683163..554214fca5b7 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6845,7 +6845,7 @@ static int smb2_set_flock_flags(struct file_lock *flock, int flags)
 	case SMB2_LOCKFLAG_UNLOCK:
 		ksmbd_debug(SMB, "received unlock request\n");
 		flock->fl_type = F_UNLCK;
-		cmd = 0;
+		cmd = F_SETLK;
 		break;
 	}
 
@@ -7228,7 +7228,7 @@ int smb2_lock(struct ksmbd_work *work)
 		rlock->fl_start = smb_lock->start;
 		rlock->fl_end = smb_lock->end;
 
-		rc = vfs_lock_file(filp, 0, rlock, NULL);
+		rc = vfs_lock_file(filp, F_SETLK, rlock, NULL);
 		if (rc)
 			pr_err("rollback unlock fail : %d\n", rc);
 
-- 
2.25.1


