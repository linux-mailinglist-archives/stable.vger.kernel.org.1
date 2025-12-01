Return-Path: <stable+bounces-197696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5DEC965EA
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 10:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CCD0343433
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D012FA0F3;
	Mon,  1 Dec 2025 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp5KPLRL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A425A2FE04D
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764581104; cv=none; b=gJ2muGiZPdiYJw+Qc2AAdhUepgPqnAYMu94ngtoqHVHcevDRrxfoKFHlzNNtl2kVr8lhz/G+0PONLX6i3dg82FtdSdGhXngOeVBK+ETVEbB01r1HpOlKnE0xhwD+c1UssCYTP9XJva4euFyMBoUMQx23zZ1NsNkBZCkNkJvsMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764581104; c=relaxed/simple;
	bh=d9GBTfOrFJjQNQxndzxCPwaJdkYd9QaUiqFnCs8pM8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ir1H2R8/M+v68rMlNc4rw58Zkb1nKhzITCJAPdsFSrznVBGCrsw3ZJ1LRzLnEdyi2Z+YsqrCi2XrgmMLhhdb2fFl8G3yCKZ0uihgpgYmeTj9BtnW0jKVPHIrx2pKLktRSsj7N0J7Mey7Hs2DcfjTiW+LM5BOQMvKTdHHnovdsSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp5KPLRL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-298287a26c3so47323045ad.0
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 01:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764581101; x=1765185901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qERR8P+/o4ObMaf4NL7eL/6PohQaFQTnCKkZHGpKlnM=;
        b=Cp5KPLRL66V+BLxH8ke8ZrenzCDZZGSRDrtvsDhxtQK8NE2++nJgwRCZIbSO8H6nJG
         EE5lzP7azUsPNI8S95h6lv3yVje5m2tIA9d+HvwAFBswi6hbL6ko9lJUt7nL+7Da9GLn
         tdB3nITbOHH1GAP+BLrUJ86QiL2DR8JdATkG5ABvKXxxp3m+S7BMNXKA5bkVp5A7akAZ
         ghGmRFxjh597lG1j9221drPe3dA0GRl1/RmvDxKqyHtb9DtpqfyjhoKzM/bePl+y+Oe7
         HebRo/UXS7W8Dd5FRDxRDp3+eBiiGSAicgruCY6CglKsV+07LGRB9YxTlBtA/swSHeD2
         iT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764581101; x=1765185901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qERR8P+/o4ObMaf4NL7eL/6PohQaFQTnCKkZHGpKlnM=;
        b=libnjvHREvaV013zl4+JghUnJEQUtt36JwCHtgOPpnMw1cJpN7N9GxR0meTT7rueMW
         biuG17UmMBOsyc3cDsHUVF7hVJdm5vHbAvTaBBSjVcEG4sv96+usc56lR+8Jv5jqNjFI
         PkyE2fW7DYU/iTlXvE/NQEMVz/u253bJluUa+YZRe1UbwoWzuunduhLnuoJuw6ix/jLS
         Nae1Z8eMsVjbfGCsuIMgFADVgkvc846Xo+97rFN1mlMFaKlRk1lHjsQulQ1VKjvcGq1i
         rzpbjBRKV3u+wXUPhZSE5RJC4Zwr0OuIvJ3E1Ehdv2bPK8UHw9gil/aqvEH3RUg5T6Q8
         CSLg==
X-Forwarded-Encrypted: i=1; AJvYcCXeMi/WrO3Qdw2wOjFI2w9YSPqnhA88w0RSH/tiPwNj84oMRMd29sXn3gKt4JP75QvglE32HKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTMF+mZOvqhHJ6m/tlLE7kGOuAcxW83grOo6x+ZQpVDTsTUP2M
	/FABUjtbtxxmIAI/a/H1QqhE5no+QuH8PLgEKM+BZmKPLhEVIxV3W45PPv80sN4lw10=
X-Gm-Gg: ASbGnct/cMGSzrN9QtQ0L42z6U3dNKllTwH2qGTJ/AuEtQksPmP/byWtbOhfAl/7cXf
	VzO3/2EmvWjc5jMQk19TmH2eumGyvAoPhdFZeji/7dGgtqgctH6+oqUGSghaVJB9xe4Pl/Eg6+x
	jvqkWmV4Y8pnmYhFriXlZrcML84RS2EJzvVXo3hkgSPkq7a12VLnvYneAGQCTBlcaNpwr+2/WpM
	OdvM24rGI3EpbY4S1bForuF+44zGXkmZlUVCMbH1zTrdgSL0tQQgXivb/pbjgrlmJ37SdfP7QMA
	pKMtKyb1FzAIRqE0lYjwcLdRUs2ScHVOiA9yBm3sdCMY4SspccCoutYw5OoeipbM1pDH+ynk2xR
	j+cWSCHAuuQFkKTOR+CNT84GtMy1J6yx+gcNHRekqq4IvkgymZwU/8fgkY2tiZlEAFKx8Fz4UH0
	Mo7054iycOsaWXOJ+lS3AykPJOEtI=
X-Google-Smtp-Source: AGHT+IFXnf0d/pxuEm+gHoXJiVlLVuf56GuwzRCPB2DmvUZXgNgKDE4fu8biWpWXfSyNlaPjS17cGw==
X-Received: by 2002:a17:903:2c10:b0:298:42ba:c437 with SMTP id d9443c01a7336-29b6bf75998mr389621755ad.50.1764581100937;
        Mon, 01 Dec 2025 01:25:00 -0800 (PST)
Received: from localhost.localdomain ([114.79.136.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce441e59sm118620605ad.33.2025.12.01.01.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:25:00 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+96d38c6e1655c1420a72@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] ocfs2: fix kernel BUG in ocfs2_find_victim_chain
Date: Mon,  1 Dec 2025 14:54:49 +0530
Message-Id: <20251201092450.84991-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a kernel BUG in ocfs2_find_victim_chain() because the
`cl_next_free_rec` field of the allocation chain list is 0, triggring the
BUG_ON(!cl->cl_next_free_rec) condition and panicking the kernel.

To fix this, `cl_next_free_rec` is checked inside the caller of
ocfs2_find_victim_chain() i.e. ocfs2_claim_suballoc_bits() and if it is
equal to 0, ocfs2_error() is called, to log the corruption and force the
filesystem into read-only mode, to prevent further damage.

Reported-by: syzbot+96d38c6e1655c1420a72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=96d38c6e1655c1420a72
Tested-by: syzbot+96d38c6e1655c1420a72@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
v1->v2:
 - Remove extra line before the if statement in patch
 - Add upper limit check for cl->cl_next_free_rec in the if condition

 fs/ocfs2/suballoc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 6ac4dcd54588..1257c39c2c11 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -1992,6 +1992,13 @@ static int ocfs2_claim_suballoc_bits(struct ocfs2_alloc_context *ac,
 	}
 
 	cl = (struct ocfs2_chain_list *) &fe->id2.i_chain;
+	if (!le16_to_cpu(cl->cl_next_free_rec) ||
+	    le16_to_cpu(cl->cl_next_free_rec) > le16_to_cpu(cl->cl_count)) {
+		status = ocfs2_error(ac->ac_inode->i_sb,
+					"Chain allocator dinode %llu has 0 chains\n",
+					(unsigned long long)le64_to_cpu(fe->i_blkno));
+		goto bail;
+	}
 
 	victim = ocfs2_find_victim_chain(cl);
 	ac->ac_chain = victim;

base-commit: 939f15e640f193616691d3bcde0089760e75b0d3
-- 
2.34.1


