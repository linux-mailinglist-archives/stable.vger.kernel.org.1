Return-Path: <stable+bounces-7659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0748175A7
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FAD1F2122E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC57E4FF6A;
	Mon, 18 Dec 2023 15:37:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F5760AA
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so2608718a12.2
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:36:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913819; x=1703518619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmacX3IH2G3TN2zjO2AmlRQf3OCwD/IL/dEpQTAdDJw=;
        b=PrgozackGf+68Etkf18SjUjS1X/Cqi97k5Er9FjcJaJv9gs6BFNhSkLPu6s0zqtWoF
         +WsIcLa3+KeCsagPXg5LdPDDAEAqmM1X8T7iT4qVndOBacUkGL0TH5Zco5PLhVW40Ktj
         SO+jRwwHv9FOk5Xqp7WirU4T0UvlmAzYT+gNsjGWwL0Sqfmnz2qGh3NE5y9D5N8MoHry
         XaWDK4vPismuMLaJrMNLDSMoJHX+tdO6rIGSPcmhtNMBAB/hTIw5y2uh74Iv9l8Tt8md
         g52y+z21uAtoWyrrBvS832IO/oqAHyWJ1yIIDR0XcQE63J1KUXpyrMchyaf8zHRtKLzX
         bW3A==
X-Gm-Message-State: AOJu0Yw2+kG5C+0RWzU+H5no8HsU2Uyfql+RyFe4tqgIGy2ObuqRK7IQ
	yVFkmUig7GKTTW+Y/xBsF0n5Ht6WmIo=
X-Google-Smtp-Source: AGHT+IFx9XJlkMIqXS4WBC8XJRwDrvJJb9BiHwtv7/DkFTzV8Mwhuyi+dmuah7rxbKCToYoCm9dKsg==
X-Received: by 2002:a17:90a:39ce:b0:28b:490b:9f15 with SMTP id k14-20020a17090a39ce00b0028b490b9f15mr1644008pjf.97.1702913819411;
        Mon, 18 Dec 2023 07:36:59 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:36:58 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Steve French <stfrench@microsoft.com>,
	Paulo Alcantara <pc@cjr.nz>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 5.15.y 030/154] smb3: fix ksmbd bigendian bug in oplock break, and move its struct to smbfs_common
Date: Tue, 19 Dec 2023 00:32:50 +0900
Message-Id: <20231218153454.8090-31-linkinjeon@kernel.org>
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

From: Steve French <stfrench@microsoft.com>

[ Upstream commit c7803b05f74bc3941b127f3155671e1944f632ae ]

Fix an endian bug in ksmbd for one remaining use of
Persistent/VolatileFid that unnecessarily converted it (it is an
opaque endian field that does not need to be and should not
be converted) in oplock_break for ksmbd, and move the definitions
for the oplock and lease break protocol requests and responses
to fs/smbfs_common/smb2pdu.h

Also move a few more definitions for various protocol requests
that were duplicated (in fs/cifs/smb2pdu.h and fs/ksmbd/smb2pdu.h)
into fs/smbfs_common/smb2pdu.h including:

- various ioctls and reparse structures
- validate negotiate request and response structs
- duplicate extents structs

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/oplock.c  | 4 ++--
 fs/ksmbd/smb2pdu.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index e1d854609195..2e52ebc209d2 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -657,8 +657,8 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 		rsp->OplockLevel = SMB2_OPLOCK_LEVEL_NONE;
 	rsp->Reserved = 0;
 	rsp->Reserved2 = 0;
-	rsp->PersistentFid = cpu_to_le64(fp->persistent_id);
-	rsp->VolatileFid = cpu_to_le64(fp->volatile_id);
+	rsp->PersistentFid = fp->persistent_id;
+	rsp->VolatileFid = fp->volatile_id;
 
 	inc_rfc1001_len(work->response_buf, 24);
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 2dc67809a2c7..6b4132ea1956 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -7995,8 +7995,8 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 	char req_oplevel = 0, rsp_oplevel = 0;
 	unsigned int oplock_change_type;
 
-	volatile_id = le64_to_cpu(req->VolatileFid);
-	persistent_id = le64_to_cpu(req->PersistentFid);
+	volatile_id = req->VolatileFid;
+	persistent_id = req->PersistentFid;
 	req_oplevel = req->OplockLevel;
 	ksmbd_debug(OPLOCK, "v_id %llu, p_id %llu request oplock level %d\n",
 		    volatile_id, persistent_id, req_oplevel);
@@ -8091,8 +8091,8 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 	rsp->OplockLevel = rsp_oplevel;
 	rsp->Reserved = 0;
 	rsp->Reserved2 = 0;
-	rsp->VolatileFid = cpu_to_le64(volatile_id);
-	rsp->PersistentFid = cpu_to_le64(persistent_id);
+	rsp->VolatileFid = volatile_id;
+	rsp->PersistentFid = persistent_id;
 	inc_rfc1001_len(work->response_buf, 24);
 	return;
 
-- 
2.25.1


