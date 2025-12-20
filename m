Return-Path: <stable+bounces-203131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E43CD2C83
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 10:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05088300B91A
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4C305E01;
	Sat, 20 Dec 2025 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWuVbxjg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55E930497C
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766224183; cv=none; b=e25AD+VWguCVL2q9SvboLiXWFhdSpeFuE6du0i4/h0FYOaoXI5LEju5CYRSZGPJtYJoDenspIT+D7mqw/o9kufsw08h9dpLpo74i/BIG2lbLc/gjAf6TdCwX8WQ2/+G3jHXegJTsDoHVyaaqhVD7Ux28mBvO5N/y4+YFhVogOPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766224183; c=relaxed/simple;
	bh=8vPBBIVGC/F5q2+wWMM4e4vlGTNbzIZZ4fuMbWYwOnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a+s0uUtec+WmYzHJUHelTapI/iTJ7YjEQxHGB6BQCshaE599OVDSwkbCyEhVrxR7pfxGEY5DIRJo0J3FdJ03Z712PPhXrkpsPeZcIDaKge0GBteDwCme6on5WMzGOu9ct7Hca71ldZApWm6XAFVxawNlgWXfSqbTn0lT7N7F+80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWuVbxjg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a1022dda33so21726725ad.2
        for <stable@vger.kernel.org>; Sat, 20 Dec 2025 01:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766224181; x=1766828981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j7IJxF6HMphYNWv4fklqBcjfxDWSKokfkAddGStMOYE=;
        b=KWuVbxjg3KwXfxmai9CNjkjgxmb6duf7JQ/izyBn06seeeWlM4wdtJMetCzE5AdLTY
         wOlBQV20iGsOHMiSFYGiNB8kUe18ZbKyCXrAyNT5j2nyuG3ISIr5HWtBNQi4TZxfoIiW
         ZuvCmC+Krb2mAWLxsfVD8n3Oacay1PFA05FM5vMB1wyFnuxC1YTEteFHzFjFvqOW+H/J
         G/7JUPRgromvd8iX0sJUPoZUGt22gctLS6oqWg0X6Gqy5/cNXO5OI2ssrXNjXo/Dsqbb
         cjn66Ff7X/gcl/GLMtK0XRGS19ZIAkRvNWG3OCJqGoZZdyVOpdbBrtOYFtArcHQaWGVt
         tHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766224181; x=1766828981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7IJxF6HMphYNWv4fklqBcjfxDWSKokfkAddGStMOYE=;
        b=Jj+HJZR282gbaEZT/FOWiw2k44j3nOLj9qZYtKvd24sx/TPRN6H23IuScRgLRYD66h
         2yYum1yUMF5qttSoOWHk6GKVtjSbge76vuAG07PoeMOQxrI19/5siiRcGI32g/Teni99
         r4zjc4C5SyY+quPQmtkVtMeivLIJ+qX+ocDH3lgoyCiY6l5cLhfoUL6Dzakz3VkTvy93
         qJ7D090PxrnnMzYV4vL/k6yFGPbqvCL84Sr8AN6FFz21NB2SLagmKbym59cAq8FWp+T5
         VKe1/UsFIfSwZXRJTofULHaPY3SR+jYkvLEBzVyQMto9dIm1PKCrMfpgZdfACerLRAIx
         6mhA==
X-Forwarded-Encrypted: i=1; AJvYcCXcR3cdfN0g2nID0PpZWW76grUsKqXzOp+ys78wxJ5Rov/BNnnduE3JSGgG7/DDeKLl3SP77xE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ECGJEuoknlabOIPoRQBGtbRQD9a2z0PASdCrztvtbGaohwvo
	wC8jszn6m8U4goxJPlb/L7FDOnupTNZhfwjH5DwnqUynnu9eR6HbUwg3
X-Gm-Gg: AY/fxX6+oOtHluBFxGEvpQIWqWoLDWc3q+x4GzERKdG89B0tWr5iQbkqVl3B01Kdh4y
	NNj5MvTbP6pXbXIUbtM6El2AfCzpOgekw7I+d48pWSGIx+IjVxigmW79IWFPI9hQAoa+dQNpP5/
	3Y8v8f2JWvOA408cmAdlMeaUgdHIC8Ii7ejZnEyZzXUO+ZPs4J4r/yIPJxSbxafGZR0/bBLgphP
	UCQ7EtDOMTEzj+snnSJKJhBm2hdhEhfO+TGnw41Sg7w4b4710/j4zbIYgHiDk9qopZEjePK/lb6
	r3a8DWTPjoNA73vl4DJjHMX2y+lmC5Yz7GgBgwB0vndKDSECB9XuDTTCT3OrVPHqSUcwdG1N7u7
	XFweGWA4NVIjFITN3v6vAM+8uLR4gTzXUPBDxNACJYLoWiobP4hQj3YxABh9zFyhyRSJDgy3gKh
	0q6amBRdc8nGzu1zjwdkCp/RSgunGz
X-Google-Smtp-Source: AGHT+IHMytYlzWCq2SFmQytqElgOtJeFb21rSHQ0neO72vPgyAQ4/pAf5fT0MOb+oYKbYoeapmzQNg==
X-Received: by 2002:a17:903:38c3:b0:269:82a5:f9e9 with SMTP id d9443c01a7336-2a2f2836764mr57108345ad.29.1766224180679;
        Sat, 20 Dec 2025 01:49:40 -0800 (PST)
Received: from localhost.localdomain ([111.125.231.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66bd3sm45107635ad.1.2025.12.20.01.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 01:49:40 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Prithvi Tambewagh <activprithvi@gmail.com>,
	syzbot+af14efe17dfa46173239@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] ocfs2: Add check for total number of chains in chain list
Date: Sat, 20 Dec 2025 15:19:28 +0530
Message-Id: <20251220094928.134849-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions ocfs2_reserve_suballoc_bits(), ocfs2_block_group_alloc(),
ocfs2_block_group_alloc_contig() and ocfs2_find_smallest_chain() trust
the on-disk values related to the allocation chain. However, KASAN bug
was triggered in these functions, and the kernel panicked when accessing
redzoned memory. This occurred due to the corrupted value of `cl_count`
field of `struct ocfs2_chain_list`. Upon analysis, the value of `cl_count`
was observed to be overwhemingly large, due to which the code accessed
redzoned memory.

The fix introduces an if statement which validates value of `cl_count`
(both lower and upper bounds). Lower bound check ensures the value of
`cl_count` is not zero and upper bound check ensures that the value of
`cl_count` is in the range such that it has a value less than the total
size of struct ocfs2_chain_list and maximum number of chains that can be
present, so as to fill one block.

Reported-by: syzbot+af14efe17dfa46173239@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=af14efe17dfa46173239
Tested-by: syzbot+af14efe17dfa46173239@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 fs/ocfs2/suballoc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index f7b483f0de2a..7ea63e9cc4f8 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -671,6 +671,21 @@ static int ocfs2_block_group_alloc(struct ocfs2_super *osb,
 	BUG_ON(ocfs2_is_cluster_bitmap(alloc_inode));
 
 	cl = &fe->id2.i_chain;
+	unsigned int block_size = osb->sb->s_blocksize;
+	unsigned int max_cl_count =
+	(block_size - offsetof(struct ocfs2_chain_list, cl_recs)) /
+	sizeof(struct ocfs2_chain_rec);
+
+	if (!le16_to_cpu(cl->cl_count) ||
+	    le16_to_cpu(cl->cl_count) > max_cl_count) {
+		ocfs2_error(osb->sb,
+			    "Invalid chain list: cl_count %u "
+			    "exceeds max %u",
+			    le16_to_cpu(cl->cl_count), max_cl_count);
+		status = -EIO;
+		goto bail;
+	}
+
 	status = ocfs2_reserve_clusters_with_limit(osb,
 						   le16_to_cpu(cl->cl_cpg),
 						   max_block, flags, &ac);

base-commit: 36c254515dc6592c44db77b84908358979dd6b50
-- 
2.34.1


