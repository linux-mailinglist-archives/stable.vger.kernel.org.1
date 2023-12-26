Return-Path: <stable+bounces-8579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6276C81E6FE
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 11:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D041F2211B
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 10:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B94E1A5;
	Tue, 26 Dec 2023 10:54:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA64CE1F
	for <stable@vger.kernel.org>; Tue, 26 Dec 2023 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28c7c422ad9so292228a91.3
        for <stable@vger.kernel.org>; Tue, 26 Dec 2023 02:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703588054; x=1704192854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8fy9kS1fRyKFoBsaADhaTLdVMcrnoHblkFvtu/BD58=;
        b=k/7crfY1jrb3/C6zpRlgIb0Kcfr/Wc2x4OOp2SctEYcZBxB79gPA9WQmNLxni5sKiQ
         k3Q5jEBLMLLLhIcinzs4YrRP1l6/ZgaT84ONtKx28wgMzyJprkymljZvurMh7Q5sQYxX
         nw7wM0PlK+twIsOSMtKI1K9zHgxUnzHCM75LotC/cVWBeta/xnjYaVGKbDuNxZxev6QN
         W15wggSz2TvsVFJVQUoBlr1GWySipyrxs/YVD9pE1FBYrbBakS4HJ4nF9kepDU1aDKjB
         JpXw9NINGs8SubW38iLr3bsO2A/o5MdshtZyXSI6pnNB4GrepRwjRTIFibW4AETVoxFj
         hTJw==
X-Gm-Message-State: AOJu0YxDW26qToxYHy6Z4+p8JOJLKHNAgdoqKUUzk2mLTbdjMYRrHZ0p
	mn3no7SYzVxkzBNABlB/kVISLtjGSCw=
X-Google-Smtp-Source: AGHT+IHYTyiLWneHOe2UsWFdcLYP/nU+GZ7czA8GplVDTdzOkSdFWsmV5SdQqSVqYfJdrzNQTn+jmA==
X-Received: by 2002:a17:90a:f004:b0:28c:2786:48be with SMTP id bt4-20020a17090af00400b0028c278648bemr2034910pjb.49.1703588053809;
        Tue, 26 Dec 2023 02:54:13 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id sg4-20020a17090b520400b0028be1050020sm10874972pjb.29.2023.12.26.02.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:54:11 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 4/8] ksmbd: downgrade RWH lease caching state to RH for directory
Date: Tue, 26 Dec 2023 19:53:29 +0900
Message-Id: <20231226105333.5150-5-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226105333.5150-1-linkinjeon@kernel.org>
References: <20231226105333.5150-1-linkinjeon@kernel.org>
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
 fs/ksmbd/oplock.c  | 9 +++++++--
 fs/ksmbd/oplock.h  | 2 +-
 fs/ksmbd/smb2pdu.c | 8 ++++----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 24716dbe7108..600312e2c6c2 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
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
diff --git a/fs/ksmbd/oplock.h b/fs/ksmbd/oplock.h
index ad31439c61fe..672127318c75 100644
--- a/fs/ksmbd/oplock.h
+++ b/fs/ksmbd/oplock.h
@@ -109,7 +109,7 @@ void opinfo_put(struct oplock_info *opinfo);
 
 /* Lease related functions */
 void create_lease_buf(u8 *rbuf, struct lease *lease);
-struct lease_ctx_info *parse_lease_state(void *open_req);
+struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir);
 __u8 smb2_map_lease_to_oplock(__le32 lease_state);
 int lease_read_to_write(struct oplock_info *opinfo);
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 7ce5746f9167..6a3cd6ea3af1 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2729,10 +2729,6 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	}
 
-	req_op_level = req->RequestedOplockLevel;
-	if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
-		lc = parse_lease_state(req);
-
 	if (le32_to_cpu(req->ImpersonationLevel) > le32_to_cpu(IL_DELEGATE_LE)) {
 		pr_err("Invalid impersonationlevel : 0x%x\n",
 		       le32_to_cpu(req->ImpersonationLevel));
@@ -3212,6 +3208,10 @@ int smb2_open(struct ksmbd_work *work)
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


