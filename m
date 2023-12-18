Return-Path: <stable+bounces-7684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 735748175C6
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2138D283DB0
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618445BF8F;
	Mon, 18 Dec 2023 15:38:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57F5BF84
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28b406a0fbfso2456916a91.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913901; x=1703518701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWyKglnftc9L6nDXCnwmRo6zM5ZNs0FaoSIQGYQBb2k=;
        b=OHPR2VASWJwDPQWw/7PiXNgkegF5UPMSEzIbOln/RPtD+N76HCIjwqdMSUZOLlYrNy
         22+AzyDD7hsU2VKHbfK77l9p8C1O4FKa4hdOA38M6BrkVZiP48PhAYu3rFzvEUtGvI72
         19tUqwL8/+CMODcIgdhjXHnQIginZB+0Bilwwmqv6UjSW1BOQLXb0L2lDmp6ruwReLNS
         Mao4pnE2ZVclI80sssODgnqklEJdWMZO0qgy161bfSzm8/iAj+QSkq4sLWGFq+x/LIxL
         lJhP/nIyC3uZmutGg2sWu3Wf1GSAsPQ1WC7F1fwMBLRbnuo7rW77/9vq9bmMKxVtl07o
         nBwA==
X-Gm-Message-State: AOJu0Yy/mCAkAPDh8euq24hlWQcWjaolxmWRm0lKg2yJnMFDf1XKoe1u
	YVzQe/gGnCL3bOl+foVsO0o=
X-Google-Smtp-Source: AGHT+IEkO30BqxmNlIWiOmhpUKUEPVKkhRivY5iXt3cM6F2qPJ1c5FfzxNcuNhqziP+2NXt0EZIX8Q==
X-Received: by 2002:a17:90b:1bd0:b0:28b:52f3:3dc1 with SMTP id oa16-20020a17090b1bd000b0028b52f33dc1mr1465152pjb.50.1702913901366;
        Mon, 18 Dec 2023 07:38:21 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:38:20 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 055/154] ksmbd: fill sids in SMB_FIND_FILE_POSIX_INFO response
Date: Tue, 19 Dec 2023 00:33:15 +0900
Message-Id: <20231218153454.8090-56-linkinjeon@kernel.org>
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

[ Upstream commit d5919f2a1459083bd0aaede7fc44e945290e44df ]

This patch fill missing sids in SMB_FIND_FILE_POSIX_INFO response.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/smb2pdu.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 9e9ba815ffa3..85678fcabe3c 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4754,7 +4754,9 @@ static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
 {
 	struct smb311_posix_qinfo *file_info;
 	struct inode *inode = file_inode(fp->filp);
+	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
 	u64 time;
+	int out_buf_len = sizeof(struct smb311_posix_qinfo) + 32;
 
 	file_info = (struct smb311_posix_qinfo *)rsp->Buffer;
 	file_info->CreationTime = cpu_to_le64(fp->create_time);
@@ -4771,10 +4773,24 @@ static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
 	file_info->HardLinks = cpu_to_le32(inode->i_nlink);
 	file_info->Mode = cpu_to_le32(inode->i_mode & 0777);
 	file_info->DeviceId = cpu_to_le32(inode->i_rdev);
-	rsp->OutputBufferLength =
-		cpu_to_le32(sizeof(struct smb311_posix_qinfo));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb311_posix_qinfo));
-	return 0;
+
+	/*
+	 * Sids(32) contain two sids(Domain sid(16), UNIX group sid(16)).
+	 * UNIX sid(16) = revision(1) + num_subauth(1) + authority(6) +
+	 *		  sub_auth(4 * 1(num_subauth)) + RID(4).
+	 */
+	id_to_sid(from_kuid_munged(&init_user_ns,
+				   i_uid_into_mnt(user_ns, inode)),
+				   SIDUNIX_USER,
+				   (struct smb_sid *)&file_info->Sids[0]);
+	id_to_sid(from_kgid_munged(&init_user_ns,
+				   i_gid_into_mnt(user_ns, inode)),
+				   SIDUNIX_GROUP,
+				   (struct smb_sid *)&file_info->Sids[16]);
+
+	rsp->OutputBufferLength = cpu_to_le32(out_buf_len);
+	inc_rfc1001_len(rsp_org, out_buf_len);
+	return out_buf_len;
 }
 
 static int smb2_get_info_file(struct ksmbd_work *work,
@@ -4894,8 +4910,8 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
 			rc = -EOPNOTSUPP;
 		} else {
-			rc = find_file_posix_info(rsp, fp, work->response_buf);
-			file_infoclass_size = sizeof(struct smb311_posix_qinfo);
+			file_infoclass_size = find_file_posix_info(rsp, fp,
+					work->response_buf);
 		}
 		break;
 	default:
-- 
2.25.1


