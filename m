Return-Path: <stable+bounces-139235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E950EAA574E
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA7F1B658DA
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7682D269B;
	Wed, 30 Apr 2025 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L35QR6tW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F162D113D
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048441; cv=none; b=fLdGsEwYl2VdyegWANfKwF0SuW2wjWrFUclXFtJAwT6sAd76B2mLWaArj4sJPz8W2t7G8irsc7y7He9wz9ExBz3B+3+fG1Ie2fK41i+AWHuF9+KbkbJb26bz6yDicEbOFEdIs5H+9mN4TTKTKhifrrejeIMxEKFp52j/qI3bpdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048441; c=relaxed/simple;
	bh=Dg85V2x8zlbxi12dr4xsOWrR9DHZyr+oB1pXRwN5VuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCJpv79CqXz1x6EWojQurqFmkwqQ314I/NR/1RF2z/h4yEOehzuJPiQYzrG7cKKMA6Da7+SZyt9jVMrmO18LlrsWt4ATgt6BuKiw8zAZHsIGqhRD3rBOQMTZykiLnlRSUnLiuEOsXepKsuwPESQVhIGuLicsUcyVF6pkoXxzeWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L35QR6tW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so340175b3a.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048439; x=1746653239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEeCOmoTsbVycaCQklaBqHh0oAdpokYkHdiX8COnf5Y=;
        b=L35QR6tWXlV9h1NtaeEpwFeD4NUNMSw2p/bZLZOKnnEWSR/T6hW+cs675n3LBeZ9Nd
         ALAxfcyI7nZq57CTIJLjpyNH7ueT08Vts0CixyfH4bpGsZ+AEBOwO31M6VNmJT8Yb05z
         x0EJew3ishn+RNsftKwOW6mykJOPU+P+R8BDAN7sZ5I01dWk1fZ/oAH2iJ/e9KzsrL7h
         o65RB5ZFayiZH3jCCvfcaw0Oi9ueiFqIdFLobQ+x5i1AHSWdBFUbWx6ixwRyWvm4C7VU
         7hJ98AwIYGEZwGHlgJfbAPda10uK2Nllqspj/B2SWkUgYrgwcfBjdTJzq9F17An/lQRJ
         mPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048439; x=1746653239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEeCOmoTsbVycaCQklaBqHh0oAdpokYkHdiX8COnf5Y=;
        b=o9EHBILGxFouieKxdPZymT9MOFilHtcz1i2ntUR0mgocc9m6TAJpWWhGBDyu9PxFci
         +6sWH7xQI1X/l9ceb50aDu81AUvxOPXMnallMgI7tg29ynA1QqJVtAiVC61VmVozpXys
         vndJooe2x2KBNHrMJxI+UY+i2NQi/cOD4MkjwJ0LhQS3hFBwmO9qxqIg/nzkS+PYgBgV
         TTsQmLpfcXqMA0D9ChSF5135MI508niBngE55A1Cw8FxaOIFDUbdvsbYIrr3nQaRcbrD
         QbG1aL7QGPdHZ5A69MRMim1G0LbJ9h31Fjg9Kk2rERtKm8ZamXYYoVQH3jp5fDIp5Yab
         y47w==
X-Gm-Message-State: AOJu0YxN9L4+kMJpZsJso5qUmsY1cLjUQ9XbaV5CyKZFJJtLy9q1y0Em
	SQYv4dQJRlGL7KWHB+2EBXQ0EeQVINaCAi4xIQ95/PX+JsXR1yBL/i5exN38
X-Gm-Gg: ASbGncvcPTSnMpbD5v0m972Rj5g1rk9c57Y9IVOLfkcljuz5DsWU7Tli5YdDLyIxZL/
	IxoCIMSbPsMIqjer4jjExoRCH4rZiZB+S0E4WAduXbWLv/lhc7u+7KXwmsomXLtKiX06M4g/ccR
	8lVQgaBnBhKX9puY6dcap/22/MM2sow724xuDs1xTuZWRMVsMD+TjAY40pGuoH8mLqyiwVnNx/3
	EE2FAZPnwNlVSc6pxDYHoxLa/IHHx8hUA1Ud1A+CBM45ZWW0iBBs4WT/Bc0gJH6EjMlhJpsCOSX
	GoDeiGGEBCQhi8VOQWs1bdrx/stXvsvSSALU1bptEK04trhTQq0Ps0gpckqmrOYU2glH
X-Google-Smtp-Source: AGHT+IFtPBU/tN055UQnNfp3ROSPJ+qZQoL8+OjzW0rkcGZ5m+TUg6EaSgbHCoxTKNmoSDHzU4Eb9A==
X-Received: by 2002:a05:6a00:2406:b0:736:476b:fcd3 with SMTP id d2e1a72fcca58-74038aba0e3mr8192226b3a.24.1746048439329;
        Wed, 30 Apr 2025 14:27:19 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:18 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Zhang Yi <yi.zhang@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 08/16] xfs: match lock mode in xfs_buffered_write_iomap_begin()
Date: Wed, 30 Apr 2025 14:26:55 -0700
Message-ID: <20250430212704.2905795-9-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430212704.2905795-1-leah.rumancik@gmail.com>
References: <20250430212704.2905795-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit bb712842a85d595525e72f0e378c143e620b3ea2 ]

Commit 1aa91d9c9933 ("xfs: Add async buffered write support") replace
xfs_ilock(XFS_ILOCK_EXCL) with xfs_ilock_for_iomap() when locking the
writing inode, and a new variable lockmode is used to indicate the lock
mode. Although the lockmode should always be XFS_ILOCK_EXCL, it's still
better to use this variable instead of useing XFS_ILOCK_EXCL directly
when unlocking the inode.

Fixes: 1aa91d9c9933 ("xfs: Add async buffered write support")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 60d9638cec6d..f6ca27a42498 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1127,37 +1127,37 @@ xfs_buffered_write_iomap_begin(
 	/*
 	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
 	 * them out if the write happens to fail.
 	 */
 	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_NEW);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	xfs_iunlock(ip, lockmode);
 	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
 
 found_imap:
 	seq = xfs_iomap_inode_sequence(ip, 0);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	xfs_iunlock(ip, lockmode);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
 
 found_cow:
 	seq = xfs_iomap_inode_sequence(ip, 0);
 	if (imap.br_startoff <= offset_fsb) {
 		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
 		if (error)
 			goto out_unlock;
 		seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
-		xfs_iunlock(ip, XFS_ILOCK_EXCL);
+		xfs_iunlock(ip, lockmode);
 		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
 					 IOMAP_F_SHARED, seq);
 	}
 
 	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	xfs_iunlock(ip, lockmode);
 	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0, seq);
 
 out_unlock:
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	xfs_iunlock(ip, lockmode);
 	return error;
 }
 
 static int
 xfs_buffered_write_delalloc_punch(
-- 
2.49.0.906.g1f30a19c02-goog


