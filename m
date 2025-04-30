Return-Path: <stable+bounces-139242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8D7AA5756
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3301C00053
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5102D26AC;
	Wed, 30 Apr 2025 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azCrCj4a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E501C2D26A8
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048449; cv=none; b=AN5ZkToFwDw8rMc9wtA81MGg9iwNMST3KNOMiRwCsEUdJ/YekOwygyC/cPj55/FmFBZ1vy0mL74dEnPrxaU6+x9jKeVVMZuXtZOaZVdVuPMWNp8YFZXz8IricknJ6l+WziONswxt9J1kh3WuzGXYU96LK0a4YEdIt0dV7+WI/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048449; c=relaxed/simple;
	bh=I+4+9+D422yjMjIvVDl9gmDM/KotGX9XL1lBphgXMJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmSJxwkxCVxiDIW0OGCvIJSrjNHe40z1+HjK0WFYbx/xDISQouoPa9ZfO07hLFoIZAOuc9LB18qOooMuVbXouhgD4c6OzhMixf6F/4Nsw7U+IevPYzpa3uDuMRbH9BQ44h5HKXjfpRdaPlA5DQfQ1Cb3CEzjVZrYj4KxKKTzYXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azCrCj4a; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso537126b3a.2
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048447; x=1746653247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9Ulw4ZHzhE+MtCh/TShIXp4puYjxJjlrwSuV9HZ3j0=;
        b=azCrCj4a5W+XF94iGeKrefO9ODzwWp92JHI3adcUcb5hzb7Ao626Qluo20SiVFTifR
         Gp4Q0XduE7MXQz4TjYcAIzFyheFbWy/1oPtWhAbqU4acx+3FQGUnNo0JO2MzxS7jmIed
         JsXcWHKfDwT50YqEimWUtsfryl0sE9KjyvAQ8dmUVgic2ndtVeavHDp9hoZ3UgXwqAOv
         f4SrN3ABfOU/te96V9kjRYzooi/y8HZ5J5AbyRlX4/JUq9Wq2LmObZpCURtdSbmmeZY3
         mlOsiN+D4Rwfk4LDlMJjovBC3TVNLhMHWSyA6arK1nVkdJ63u47Nc28FHgpCeKa1Of04
         sLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048447; x=1746653247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9Ulw4ZHzhE+MtCh/TShIXp4puYjxJjlrwSuV9HZ3j0=;
        b=htB9juavshze6b2fKRsYKWRY3R2cIYFD3fZeyQBgdWNz+dSp5Z1oqrnbNQwDAG2iuI
         uUZ1RiJZknLVl0B1Z7vNvd67YZG0kGt3nebSCorvGEP2MZWd6sHE17aPh8RxPeh+mwUQ
         EZLnVLaMYlrRjUjo/ErYOQG8hxC5MKlR4qQsnTkVcsxfyEYQepH9AM1tx4U8PSF9EneO
         UkWyI2bPeMswf2re+MRudaICZEG8dmFm8NsvK2Fcg2lHpoeKa8u2Lb35UQvBw+2UqH1U
         GnUSmuSs9mptZ/aNJQFFlSZfxLCSi0rEqyQJCmUPxkZgab5OabtxZJEFO5Tz++jFdlTl
         En4w==
X-Gm-Message-State: AOJu0YyMlbpiC9lf69yI/utH/le8sqzHLnLflbZG3cYhD7dNzUcj2EYF
	+sVlv//S44vMPKZUjOhr306aeeWZBkUGv+bAqp0dGpXxQgMZjssPHh+CPWLQ
X-Gm-Gg: ASbGncsMapq3ZmQPcdc5wK6lxFoU2wauRk1+roNElT3eUSpj0JcjTNXbrcFUCcx3QjM
	ECb+q9A7Gx2295MT78X4beyrEYoO9AZ2xa/BEHL6iPxfQ7NdUU5MmFiN2KIKGNq60afzU5SRSzk
	NOZ9yOhln1LdoTmorfB9BdYfq3NubrqYc4bPCQwXuqyrOC5N2hxYdfeAMuopwRLn9sXgZIGmnSu
	qZ7gDGv5AnLmHRyBl9KppU6or0EYK/CvuMBMY3iifOYHTco/BBdsYfniQ7an9EvgT2csI81Pocu
	GSC7UI1UyxvmAFmQSa0jsg8gLFVWR8XzHnHMsQ9KKTu0xFDAy/rshwtqVeoIz04xpCuV
X-Google-Smtp-Source: AGHT+IGZA9iqNhcwvaqpb5pVvt/1UPlSy5Xa0wexi7bgvD63lUraCk8L62Tn9MNweOwFC6oTpLk96g==
X-Received: by 2002:a05:6a20:d04d:b0:201:85f4:ad21 with SMTP id adf61e73a8af0-20aa43808f9mr7190427637.31.1746048447008;
        Wed, 30 Apr 2025 14:27:27 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:26 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 15/16] xfs: allow unlinked symlinks and dirs with zero size
Date: Wed, 30 Apr 2025 14:27:02 -0700
Message-ID: <20250430212704.2905795-16-leah.rumancik@gmail.com>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 1ec9307fc066dd8a140d5430f8a7576aa9d78cd3 ]

For a very very long time, inode inactivation has set the inode size to
zero before unmapping the extents associated with the data fork.
Unfortunately, commit 3c6f46eacd876 changed the inode verifier to
prohibit zero-length symlinks and directories.  If an inode happens to
get logged in this state and the system crashes before freeing the
inode, log recovery will also fail on the broken inode.

Therefore, allow zero-size symlinks and directories as long as the link
count is zero; nobody will be able to open these files by handle so
there isn't any risk of data exposure.

Fixes: 3c6f46eacd876 ("xfs: sanity check directory inode di_size")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_inode_buf.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 127c9a698d9f..3c611c8ac158 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -368,14 +368,17 @@ xfs_dinode_verify_fork(
 	 */
 	if (whichfork == XFS_DATA_FORK) {
 		/*
 		 * A directory small enough to fit in the inode must be stored
 		 * in local format.  The directory sf <-> extents conversion
-		 * code updates the directory size accordingly.
+		 * code updates the directory size accordingly.  Directories
+		 * being truncated have zero size and are not subject to this
+		 * check.
 		 */
 		if (S_ISDIR(mode)) {
-			if (be64_to_cpu(dip->di_size) <= fork_size &&
+			if (dip->di_size &&
+			    be64_to_cpu(dip->di_size) <= fork_size &&
 			    fork_format != XFS_DINODE_FMT_LOCAL)
 				return __this_address;
 		}
 
 		/*
@@ -509,13 +512,23 @@ xfs_dinode_verify(
 
 	mode = be16_to_cpu(dip->di_mode);
 	if (mode && xfs_mode_to_ftype(mode) == XFS_DIR3_FT_UNKNOWN)
 		return __this_address;
 
-	/* No zero-length symlinks/dirs. */
-	if ((S_ISLNK(mode) || S_ISDIR(mode)) && di_size == 0)
-		return __this_address;
+	/*
+	 * No zero-length symlinks/dirs unless they're unlinked and hence being
+	 * inactivated.
+	 */
+	if ((S_ISLNK(mode) || S_ISDIR(mode)) && di_size == 0) {
+		if (dip->di_version > 1) {
+			if (dip->di_nlink)
+				return __this_address;
+		} else {
+			if (dip->di_onlink)
+				return __this_address;
+		}
+	}
 
 	fa = xfs_dinode_verify_nrext64(mp, dip);
 	if (fa)
 		return fa;
 
-- 
2.49.0.906.g1f30a19c02-goog


