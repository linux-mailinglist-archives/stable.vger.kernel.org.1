Return-Path: <stable+bounces-73769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825F896F138
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 12:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBA59B21516
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D411C8FD9;
	Fri,  6 Sep 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5P/tgNP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A5F1C871F
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618062; cv=none; b=AnVUkyIhl5ryOyo6pcpJUcj1N2BJsRGVa98FsC/1FfVuM9dUL3d+wN+GTLNafrcOBIZNfJ06igIPV3v1/j24OhFFKNL8Mr/9URlXRxz3Rbq/ToF7HX20ZqFQTxMRFXf4jn1tJsWgldf2aux9KHjH6cHSWXTJByN92KIIEqhzgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618062; c=relaxed/simple;
	bh=ViXUmpQDszYlkQlzX071qyK4hcQQ/D6TR+RQVOMzaV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TS3RDtql9hMvgvz1PQl5jtOTK+EwEH86gooiuX8u6P+05bri2MVLP94+MlCKWJvlM1aoW8XMjFUSX/prNRvog8AKur9AYd5mIdc+AgwhzZQz7fUzlScL6F8MWRTuz69Jfwb7ALb2+RW9VPoRSYuIx5sHjki9xL3mC2xSLjywYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5P/tgNP; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093ba310b0so984150a34.2
        for <stable@vger.kernel.org>; Fri, 06 Sep 2024 03:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725618059; x=1726222859; darn=vger.kernel.org;
        h=content-transfer-encoding:cifs:mime-version:message-id:date:subject
         :cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJsv/z5yQu7mIgQJ1nCtV0vzTbPyXVJOauc542Rh/Qc=;
        b=G5P/tgNPaGP3BLLJA+SIrPAnSWwEYdtu4cUhnoLyUlJHY02WIedwuMjH8fJ/s5AsFp
         x3aBj57FMgQH4qBtHm3VSP6VTjE0A1xc3Yf0en8JeRK/qWMSDyejRTUPE24k6wxev7KM
         /WrBHQfuYbWt4BokKXU/7A1DHEwHt01Bt9huV1qVrhQUiFDF4O4k1XoKyOZ0ElHWGi1j
         FIhaNABrVKHPrIU11jlUumJ5eJffauAueQwp2fEMbnWwDcqYLQhXu86kdZZQgHza0Eg6
         RsfKOvsa8kiUR8une2gQ5WcDvPuCcshU5k+eYW2E89OcWgNmQPZYL1tHmG3IT0d2gLNI
         zgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618059; x=1726222859;
        h=content-transfer-encoding:cifs:mime-version:message-id:date:subject
         :cc:to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJsv/z5yQu7mIgQJ1nCtV0vzTbPyXVJOauc542Rh/Qc=;
        b=rZAkn/EhMNDwUrH//3syMGh1Fzxbp1+zDhaiLwpMHqN/BFheklpkFGTswwDk2bwaY3
         SVWKPdcZW4Kwg/qvZAZI050M/1pi9kRYSY72/Oi+lYTq0VTO0GkXdUIK/TGjQJbp8W5G
         r6Xe/OAwjNnpybYguYy8HRtO+smeMyKdQPNi7mN5BnxOzIpJQKYb+l2yQhl3tZZggSfo
         ZJ49Rp193l1l32d6MdpijKkYM7PI2s/HJTfFqnrj1o3ESrbl1E1bdeHb0ul0YYIWPb+d
         3jsQi2u4DT4MXSqn3dgGiZormd6I9Vqinb8P/qqqz4vjFAbDU8m5XKjls4nNoFlprfBH
         bKSg==
X-Gm-Message-State: AOJu0YwLAsO9VK8FiueRqx4rzKCk+NDpPEo4REXv8UhGWJPPAOrNf9LT
	hQMrAAVM+6DLg45Q5EGuafhdww5LgcDs8b/IB6jVF8xMpaJ+oa7ZNNWY1to0
X-Google-Smtp-Source: AGHT+IFKQeMo392jBS7ov0eaoTFCPti6zFlS7xwF43NX+Byjt4Pg9K5eoYJSPhGEFEWpMevm/BG0+g==
X-Received: by 2002:a05:6358:299:b0:1aa:a19e:f195 with SMTP id e5c5f4694b2df-1b8385bc294mr246059355d.4.1725618059082;
        Fri, 06 Sep 2024 03:20:59 -0700 (PDT)
Received: from met-Virtual-Machine.. ([131.107.147.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbda7811sm4603548a12.60.2024.09.06.03.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:20:58 -0700 (PDT)
From: meetakshisetiyaoss@gmail.com
To: stable@vger.kernel.org
Cc: smfrench@gmail.com,
	nspmangalore@gmail.com,
	bharathsm.hsk@gmail.com,
	lsahlber@redhat.com,
	Bharath SM <bharathsm@microsoft.com>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>
Subject: [5.15 Backport] cifs: Check the lease context if we actually got a lease
Date: Fri,  6 Sep 2024 06:20:18 -0400
Message-ID: <20240906102040.28993-1-meetakshisetiyaoss@gmail.com>
X-Mailer: git-send-email 2.46.0.46.g406f326d27
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
cifs: Check the lease context if we actually got a lease
Content-Transfer-Encoding: 8bit

This patch fixes a directory lease bug on the smb client and
prevents it from incorrectly caching the directories if the
server returns an invalid lease state. The patch is in
6.3 kernel, requesting backport to stable 5.15.
I have cherry-picked the patch for 5.15 kernel below

From 2bb51b129ceb884145c3527f8c04817cc00d0e6e Mon Sep 17 00:00:00 2001
From: Ronnie Sahlberg <lsahlber@redhat.com>
Date: Fri, 17 Feb 2023 13:35:00 +1000
Subject: [PATCH] cifs: Check the lease context if we actually got a lease

Some servers may return that we got a lease in rsp->OplockLevel
but then in the lease context contradict this and say we got no lease
at all.  Thus we need to check the context if we have a lease.
Additionally, If we do not get a lease we need to make sure we close
the handle before we return an error to the caller.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: stable@vger.kernel.org
Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
---
 fs/cifs/smb2ops.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index b725bd3144fb..6c30fff8a029 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -886,8 +886,6 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		goto oshr_exit;
 	}
 
-	atomic_inc(&tcon->num_remote_opens);
-
 	o_rsp = (struct smb2_create_rsp *)rsp_iov[0].iov_base;
 	oparms.fid->persistent_fid = o_rsp->PersistentFileId;
 	oparms.fid->volatile_fid = o_rsp->VolatileFileId;
@@ -897,8 +895,6 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 
 	tcon->crfid.tcon = tcon;
 	tcon->crfid.is_valid = true;
-	tcon->crfid.dentry = dentry;
-	dget(dentry);
 	kref_init(&tcon->crfid.refcount);
 
 	/* BB TBD check to see if oplock level check can be removed below */
@@ -907,14 +903,16 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		 * See commit 2f94a3125b87. Increment the refcount when we
 		 * get a lease for root, release it if lease break occurs
 		 */
-		kref_get(&tcon->crfid.refcount);
-		tcon->crfid.has_lease = true;
 		rc = smb2_parse_contexts(server, rsp_iov,
 				&oparms.fid->epoch,
 				    oparms.fid->lease_key, &oplock,
 				    NULL, NULL);
 		if (rc)
 			goto oshr_exit;
+
+		if (!(oplock & SMB2_LEASE_READ_CACHING_HE))
+			goto oshr_exit;
+
 	} else
 		goto oshr_exit;
 
@@ -928,7 +926,10 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 				(char *)&tcon->crfid.file_all_info))
 		tcon->crfid.file_all_info_is_valid = true;
 	tcon->crfid.time = jiffies;
-
+	tcon->crfid.dentry = dentry;
+	dget(dentry);
+	kref_get(&tcon->crfid.refcount);
+	tcon->crfid.has_lease = true;
 
 oshr_exit:
 	mutex_unlock(&tcon->crfid.fid_mutex);
@@ -937,8 +938,15 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	SMB2_query_info_free(&rqst[1]);
 	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
 	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
-	if (rc == 0)
+	if (rc) {
+		if (tcon->crfid.is_valid)
+			SMB2_close(0, tcon, oparms.fid->persistent_fid,
+				   oparms.fid->volatile_fid);
+	}
+	if (rc == 0) {
 		*cfid = &tcon->crfid;
+		atomic_inc(&tcon->num_remote_opens);
+	}
 	return rc;
 }
 
-- 
2.46.0.46.g406f326d27


