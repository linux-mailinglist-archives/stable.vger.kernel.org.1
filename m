Return-Path: <stable+bounces-7695-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 799438175D5
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862C81C24E64
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426A44239A;
	Mon, 18 Dec 2023 15:38:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53CC5BFBC
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cd8e2988ddso361705a12.3
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913935; x=1703518735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xisYVzfAW59qn08YJGYG0qYl1g83NMHYv2BhXzufTA=;
        b=CzIN94ZYIjZpstEjckYeBL19YF7hWHvYGfvFEgtgKxVz5IXNN87KsyTYBjJWROqxDA
         ACVduiiXbbH3+xOopUV8wLQpEk8G4tPkSiFbjxtXTIATBAyyCrRjmNoCuomgEcHj3IP3
         eSYKKRWA/EZcrPlD0IbVSFQlK+/DCeFG2WVJRfltfBX+TvhQ6o/jUv+gtcg4gsMGadbR
         2wJh/3XyKvMViBAHjPIq7Qd4TFh2npWuj5PndQ79YsuxyMVmYpAlYjnfLONId4mOYGGc
         uQBk6Po54kfLJmQ4KZgdOCEZgGpZOzSa6o57MRtIT/7OXmyoFjN1abPl7JOju0rANRKh
         0rFA==
X-Gm-Message-State: AOJu0YzLKWkhUViU22NVy5IL3AmDJzdUMDdoizjaxgAtVa2kXrs4Rzh9
	pvzeIIStNGVff+RYG31C6/o=
X-Google-Smtp-Source: AGHT+IHJXqrqroYZeKEKfDgYuZShQsIw+iemJtS3dkb0O2M54I3sVJSZ3GGIuXoy29zqtdBymaUICg==
X-Received: by 2002:a17:90a:3c88:b0:28b:3aa8:ce89 with SMTP id g8-20020a17090a3c8800b0028b3aa8ce89mr1416480pjc.43.1702913935008;
        Mon, 18 Dec 2023 07:38:55 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:54 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Jeff Layton <jlayton@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 066/154] ksmbd: use F_SETLK when unlocking a file
Date: Tue, 19 Dec 2023 00:33:26 +0900
Message-Id: <20231218153454.8090-67-linkinjeon@kernel.org>
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
 fs/ksmbd/smb2pdu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index a40c737ae280..08d416beb88e 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -6803,7 +6803,7 @@ static int smb2_set_flock_flags(struct file_lock *flock, int flags)
 	case SMB2_LOCKFLAG_UNLOCK:
 		ksmbd_debug(SMB, "received unlock request\n");
 		flock->fl_type = F_UNLCK;
-		cmd = 0;
+		cmd = F_SETLK;
 		break;
 	}
 
@@ -7181,7 +7181,7 @@ int smb2_lock(struct ksmbd_work *work)
 		rlock->fl_start = smb_lock->start;
 		rlock->fl_end = smb_lock->end;
 
-		rc = vfs_lock_file(filp, 0, rlock, NULL);
+		rc = vfs_lock_file(filp, F_SETLK, rlock, NULL);
 		if (rc)
 			pr_err("rollback unlock fail : %d\n", rc);
 
-- 
2.25.1


