Return-Path: <stable+bounces-15508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3AD838DA3
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 12:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67FA1F24C9E
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54295D900;
	Tue, 23 Jan 2024 11:40:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA005D8E6
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010057; cv=none; b=SydDPubpeHJtYUe5xvBF2/vw48OjQkXtyTdvLcmTI+lU5lzMVuw4g1mWLEgj2OpDg4DF3CcegQAo5ZXP7z7sfgqMnbQTI8Y30TyQeOBXDConCcfuZhYsMHkIY4HcIRDvOTzk/GKVGn2bCetODbL1iZu4eybQ91PjkV9f3Lj5VBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010057; c=relaxed/simple;
	bh=JHQEJmrNv/tm+xNCOP9NGIE18icLNJAfiUdTtrnS1a4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JmzAmQcXlwDKxAOGPcFOIvuUXYpdiT/IclLpiRywWD3wG3vFNYoQgO5KCRfwWSv7tyM5S7KCBgmqre862+cm32cor7UKkTObLMpFysO+xCRLjtRkJU3ojKgYopcOS6ODTicWR3a9GdBqiraVg3qF50NiJ1g3J1YCc3gkX178cTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6dbbcb1aff8so2719547b3a.3
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 03:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010055; x=1706614855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SnrKpnr2aCnU0mJD1lWD4rX4eTjWCSz819Wt2853O0=;
        b=hP6Y98tfaPoJ3PaDyjtvkJFsaOWgmiX2b/w99xB2ZI9lbQbqmUV0T0o57HpyTW7FmJ
         N/M5t8HF922gD+RU/1opCCPxFCy1KUXGTOXgbCFTlzVkzx8G94Iv9/aTjuBiNRwl3/5Q
         Bwz06g59/pnp55XTN+ULMfp8pvg1SHMrMFKLjV0lo1YOzHumxR70P7BHbGj+w4hgkHWO
         lUpxmKepraYkUaGXGugNeqW16uQRjOD4XXr4noZjHt8GEqPbhlt+HwZluq51tGiwrKhL
         4AN7rqNObOjmF/J1jUdd0knoP++v/rSr6bwGi19kbabvRduw4oVFvtUjuhKha6c10VRk
         aroA==
X-Gm-Message-State: AOJu0YzVgvmWD10YT+6f/k3A5/LGm9dCZKFKL9nrqEJeDn4AyPniAk6P
	ftpHjwfpl4abyf30ENPCb+KggJTl6MRsIGfwYa/UR1/KSItnxvrF
X-Google-Smtp-Source: AGHT+IGzQzjaIq8F+d6x1m/bH3OGdz3PEZTfH0HKDZU8CTnmH4jJPFxKHR9/ebDIS6bPZQuKwSeWZQ==
X-Received: by 2002:a05:6a00:4c11:b0:6db:b1d8:586e with SMTP id ea17-20020a056a004c1100b006dbb1d8586emr3309833pfb.23.1706010055589;
        Tue, 23 Jan 2024 03:40:55 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id p15-20020a63c14f000000b005cfb6e7b0c7sm7543359pgi.39.2024.01.23.03.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 03:40:55 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6.y 4/5] ksmbd: send lease break notification on FILE_RENAME_INFORMATION
Date: Tue, 23 Jan 2024 20:40:30 +0900
Message-Id: <20240123114031.199004-5-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123114031.199004-1-linkinjeon@kernel.org>
References: <20240123114031.199004-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 3fc74c65b367476874da5fe6f633398674b78e5a ]

Send lease break notification on FILE_RENAME_INFORMATION request.
This patch fix smb2.lease.v2_epoch2 test failure.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/oplock.c  | 12 +++++++-----
 fs/smb/server/smb2pdu.c |  1 +
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 3209ace41ab4..53dfaac425c6 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -541,14 +541,12 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 				continue;
 			}
 
-			if (lctx->req_state != lease->state)
-				lease->epoch++;
-
 			/* upgrading lease */
 			if ((atomic_read(&ci->op_count) +
 			     atomic_read(&ci->sop_count)) == 1) {
 				if (lease->state != SMB2_LEASE_NONE_LE &&
 				    lease->state == (lctx->req_state & lease->state)) {
+					lease->epoch++;
 					lease->state |= lctx->req_state;
 					if (lctx->req_state &
 						SMB2_LEASE_WRITE_CACHING_LE)
@@ -559,13 +557,17 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 				    atomic_read(&ci->sop_count)) > 1) {
 				if (lctx->req_state ==
 				    (SMB2_LEASE_READ_CACHING_LE |
-				     SMB2_LEASE_HANDLE_CACHING_LE))
+				     SMB2_LEASE_HANDLE_CACHING_LE)) {
+					lease->epoch++;
 					lease->state = lctx->req_state;
+				}
 			}
 
 			if (lctx->req_state && lease->state ==
-			    SMB2_LEASE_NONE_LE)
+			    SMB2_LEASE_NONE_LE) {
+				lease->epoch++;
 				lease_none_upgrade(opinfo, lctx->req_state);
+			}
 		}
 		read_lock(&ci->m_lock);
 	}
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8747fd32b25b..6ddfe3fef55f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5581,6 +5581,7 @@ static int smb2_rename(struct ksmbd_work *work,
 	if (!file_info->ReplaceIfExists)
 		flags = RENAME_NOREPLACE;
 
+	smb_break_all_levII_oplock(work, fp, 0);
 	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
 out:
 	kfree(new_name);
-- 
2.25.1


