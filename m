Return-Path: <stable+bounces-9103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DABF8820A39
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17F371C218C4
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA4A17D3;
	Sun, 31 Dec 2023 07:17:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBC31844
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1f055438492so6187887fac.3
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704007062; x=1704611862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTnElEoxXMhKlRrnRoASj8n6lJFXlE0jSsvJuKOTrbE=;
        b=dmY37y/tKrV1JgcrYj0Hjjl9hNXY0LeHGWoS9XN7dKaDehse2phKbfDacXrbTqEtK4
         HDtOSdWAAqkK9cIwuw+hwNAnUpVamXpnl2Gt5H0MEIxF9GUCEoD0c+qhOaBl8br3A1Ic
         ajdfa3WKSQZvosy7l6Q8T1hqkmaa7Om5YKTqrKBjkWAhbPuw6rwdrD5HKCZDmdtQ9+Dm
         j6nilYmwvnj+6yjxzQx8pSZ70At+doMgqmjgjtYxOx46nH6cUKzqd9Nc4sdnzhdqZ6uz
         /FXTixnivpMoOvcjs04BmsI6UE3Btq2N7yBA9unaJ3zVmUuzBsOO5F1Z3nzHRoVO1uNI
         Ecgw==
X-Gm-Message-State: AOJu0YywKfwjUR5tRA9lFhscht8mD1BdAhXr8ToozuPzRwFWIm95xKrR
	Fs6JCy9SHk7AEdcP8LCi5Jc=
X-Google-Smtp-Source: AGHT+IGfBinK4Mbq7trVXDTrbWxw44VgNQ3caNvp1/fa15HPzGN7ldFSjitdqjg5Dk4qo7qhqxVJww==
X-Received: by 2002:a05:6870:1706:b0:204:a24:9bc6 with SMTP id h6-20020a056870170600b002040a249bc6mr16627504oae.91.1704007062188;
        Sat, 30 Dec 2023 23:17:42 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:17:41 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 69/73] ksmbd: downgrade RWH lease caching state to RH for directory
Date: Sun, 31 Dec 2023 16:13:28 +0900
Message-Id: <20231231071332.31724-70-linkinjeon@kernel.org>
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

[ Upstream commit eb547407f3572d2110cb1194ecd8865b3371a7a4 ]

RWH(Read + Write + Handle) caching state is not supported for directory.
ksmbd downgrade it to RH for directory if client send RWH caching lease
state.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/oplock.c  | 9 +++++++--
 fs/smb/server/oplock.h  | 2 +-
 fs/smb/server/smb2pdu.c | 8 ++++----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 7346cbfbff6b..f8ac539b2164 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1398,10 +1398,11 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
 /**
  * parse_lease_state() - parse lease context containted in file open request
  * @open_req:	buffer containing smb2 file open(create) request
+ * @is_dir:	whether leasing file is directory
  *
  * Return:  oplock state, -ENOENT if create lease context not found
  */
-struct lease_ctx_info *parse_lease_state(void *open_req)
+struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir)
 {
 	struct create_context *cc;
 	struct smb2_create_req *req = (struct smb2_create_req *)open_req;
@@ -1419,7 +1420,11 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 		struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-		lreq->req_state = lc->lcontext.LeaseState;
+		if (is_dir)
+			lreq->req_state = lc->lcontext.LeaseState &
+				~SMB2_LEASE_WRITE_CACHING_LE;
+		else
+			lreq->req_state = lc->lcontext.LeaseState;
 		lreq->flags = lc->lcontext.LeaseFlags;
 		lreq->epoch = lc->lcontext.Epoch;
 		lreq->duration = lc->lcontext.LeaseDuration;
diff --git a/fs/smb/server/oplock.h b/fs/smb/server/oplock.h
index ad31439c61fe..672127318c75 100644
--- a/fs/smb/server/oplock.h
+++ b/fs/smb/server/oplock.h
@@ -109,7 +109,7 @@ void opinfo_put(struct oplock_info *opinfo);
 
 /* Lease related functions */
 void create_lease_buf(u8 *rbuf, struct lease *lease);
-struct lease_ctx_info *parse_lease_state(void *open_req);
+struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir);
 __u8 smb2_map_lease_to_oplock(__le32 lease_state);
 int lease_read_to_write(struct oplock_info *opinfo);
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index dbdb380e994e..9222c68b0214 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2732,10 +2732,6 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	}
 
-	req_op_level = req->RequestedOplockLevel;
-	if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
-		lc = parse_lease_state(req);
-
 	if (le32_to_cpu(req->ImpersonationLevel) > le32_to_cpu(IL_DELEGATE)) {
 		pr_err("Invalid impersonationlevel : 0x%x\n",
 		       le32_to_cpu(req->ImpersonationLevel));
@@ -3215,6 +3211,10 @@ int smb2_open(struct ksmbd_work *work)
 		need_truncate = 1;
 	}
 
+	req_op_level = req->RequestedOplockLevel;
+	if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
+		lc = parse_lease_state(req, S_ISDIR(file_inode(filp)->i_mode));
+
 	share_ret = ksmbd_smb_check_shared_mode(fp->filp, fp);
 	if (!test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_OPLOCKS) ||
 	    (req_op_level == SMB2_OPLOCK_LEVEL_LEASE &&
-- 
2.25.1


