Return-Path: <stable+bounces-139239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A34BAA5764
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7A9504416
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862FF2D1109;
	Wed, 30 Apr 2025 21:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDJoAhCh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4222D26A7
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048446; cv=none; b=hHsxUDhOaSL+AkIn5w53PFw6DpXBYooAjJEf8MyXSBDBvbF3fTc1+5i4WYt0CGM7Eg0Pc9nH+dYh9No/f9w04oPZbyAaejpBUCfLFCbOlr/eoqK622s3UFUkvzqyb2ChPZOwbNl17H2mInnHwbcaWmHO6kHqouMCDMf45/kGP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048446; c=relaxed/simple;
	bh=ywnp6v/QKKlpjYkeOkxbbj69YChktHWJPsGCm3H3QzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzPlNiXD1j7spzcsOuATRI0w+R3mO+aF3oXztgzZA4H/I5wS59xX2LpFr8hkBUbbfshD7ladTX5wZa2pDEpgjABRNwSup497nIom7klk6h5t/BS7FzDXbuUmBxmt4O1u1Tf1O7lC9wX/pilKCwxljTvA8WiauFRSCPInlpMA5i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDJoAhCh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73972a54919so406659b3a.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048444; x=1746653244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiyC9482bTLyYnk57W4mxw/mXSzETg9dArjeYlSzuzE=;
        b=DDJoAhChD5TCHgLcyfjLbioAEKdJP8BhPzIPJj+rXWPvmH3ISShb7sg11EE6dB8d+z
         0FGYpgh3o1fFLYMsv6CULaorwS89LbhUDbMjxJMPLkNMbRowxPh/0Z5O+ih62w0BM/1S
         16OEseKhPXlzn1F5eRXbjJo1tpjlGDWMT+E5yEDZU70GwiVsvtRXuXD+lkddKyLdJu8x
         az1J999BvWxNaxswHuhzCD8Ugy5/0UZPEblKBORRN7i7BTxqiYfQmKYP+nZsI9pRt2OM
         bYDKzJNrp23VlrmKoF/AqxNoRGhtM6bKkXnG4aF9wi0bkou2v6Xwnr+9SkBtGj8b4Zq/
         XsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048444; x=1746653244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiyC9482bTLyYnk57W4mxw/mXSzETg9dArjeYlSzuzE=;
        b=vvqtQPjvER5Ym0IvksD1jQ/zsSXwchmdurln3fMypsffQrTcYszR9e0GI+LaklU3nH
         Xm2xM7nRddCR1VM7/gp+mPEk3mHORCHYEq+AEDwOKVdPo18I7yft5L1cxYWqAw2/PV9K
         C7PlVicGr6Z7eGwoMlubucuOAXr/vFN7+U8MG2fYD16W7S1Xwde0cDWSqSj7TCsdJgvF
         vYoow7gyMm5ST0wlC2nWgaiRjuVWQuD7VqIm19T8hqQ8NT30jKh2RB1R67hTLRLNmvzk
         AMOKDRt4TVROIrqOY5J0jO2MVvyjH/kRh7O4Qkoic1FRa36KDkYGnuMbP/Ic5ZoHSeSe
         LKfw==
X-Gm-Message-State: AOJu0YzcMTIEC1H7EjT6ZrfVQhgSMwKxZUYJsI8UmIGh+/9tnJfScSUs
	HkJ6AxJR5vayHE+c5QIw21RcJxQ6X2qNciwWS3ogXV+3lZtHYLmP1C4nnNIV
X-Gm-Gg: ASbGncvJEr+d/emf8gjJ768u5o70eigtjx9VGE/ibeU9O3KPP6/SR+SGr250CUnkNGA
	x5VDhgLQPUZS1RCmBDWyXcM3fCKDwonfPNJDHRHjwA3cgvLDtFzUMeqypjlRvb+agu6hCZfJnbJ
	xVQ47ANW+dxCN6EfgXX2bfKwfX+wIYMfcubLUzGXTF7KMEqP7LlxiaZNsetmY607l/DG4p7oLuO
	UZqh29yW31MlN9MQrNmLPUAROhuskFmF+YzMSV2H1ydKFhhIrGF24jvt1BaT6zzn4ppLb8RUOQJ
	Wc3vbPN5d0h3nT8fCdXiDs6oxG+rMvjRowS0u7dqh5LMqBWqcT74vmVQn12wwyuZIpT0
X-Google-Smtp-Source: AGHT+IFN2VTrHpbP3E2J92WuL0eWZgyEqMcmFhEAbxlWdFUBj0fYyznVXQs4PrtKACN4CD765n0z1g==
X-Received: by 2002:a05:6a20:9c92:b0:206:ad2b:aa9a with SMTP id adf61e73a8af0-20bd86450d3mr42547637.36.1746048443751;
        Wed, 30 Apr 2025 14:27:23 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:23 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 12/16] xfs: allow symlinks with short remote targets
Date: Wed, 30 Apr 2025 14:26:59 -0700
Message-ID: <20250430212704.2905795-13-leah.rumancik@gmail.com>
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

[ Upstream commit 38de567906d95c397d87f292b892686b7ec6fbc3 ]

An internal user complained about log recovery failing on a symlink
("Bad dinode after recovery") with the following (excerpted) format:

core.magic = 0x494e
core.mode = 0120777
core.version = 3
core.format = 2 (extents)
core.nlinkv2 = 1
core.nextents = 1
core.size = 297
core.nblocks = 1
core.naextents = 0
core.forkoff = 0
core.aformat = 2 (extents)
u3.bmx[0] = [startoff,startblock,blockcount,extentflag]
0:[0,12,1,0]

This is a symbolic link with a 297-byte target stored in a disk block,
which is to say this is a symlink with a remote target.  The forkoff is
0, which is to say that there's 512 - 176 == 336 bytes in the inode core
to store the data fork.

Eventually, testing of generic/388 failed with the same inode corruption
message during inode recovery.  In writing a debugging patch to call
xfs_dinode_verify on dirty inode log items when we're committing
transactions, I observed that xfs/298 can reproduce the problem quite
quickly.

xfs/298 creates a symbolic link, adds some extended attributes, then
deletes them all.  The test failure occurs when the final removexattr
also deletes the attr fork because that does not convert the remote
symlink back into a shortform symlink.  That is how we trip this test.
The only reason why xfs/298 only triggers with the debug patch added is
that it deletes the symlink, so the final iflush shows the inode as
free.

I wrote a quick fstest to emulate the behavior of xfs/298, except that
it leaves the symlinks on the filesystem after inducing the "corrupt"
state.  Kernels going back at least as far as 4.18 have written out
symlink inodes in this manner and prior to 1eb70f54c445f they did not
object to reading them back in.

Because we've been writing out inodes this way for quite some time, the
only way to fix this is to relax the check for symbolic links.
Directories don't have this problem because di_size is bumped to
blocksize during the sf->data conversion.

Fixes: 1eb70f54c445f ("xfs: validate inode fork size against fork format")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_inode_buf.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index 601b05ca5fc2..127c9a698d9f 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -363,21 +363,41 @@ xfs_dinode_verify_fork(
 	di_nextents = xfs_dfork_nextents(dip, whichfork);
 
 	/*
 	 * For fork types that can contain local data, check that the fork
 	 * format matches the size of local data contained within the fork.
-	 *
-	 * For all types, check that when the size says the should be in extent
-	 * or btree format, the inode isn't claiming it is in local format.
 	 */
 	if (whichfork == XFS_DATA_FORK) {
-		if (S_ISDIR(mode) || S_ISLNK(mode)) {
+		/*
+		 * A directory small enough to fit in the inode must be stored
+		 * in local format.  The directory sf <-> extents conversion
+		 * code updates the directory size accordingly.
+		 */
+		if (S_ISDIR(mode)) {
+			if (be64_to_cpu(dip->di_size) <= fork_size &&
+			    fork_format != XFS_DINODE_FMT_LOCAL)
+				return __this_address;
+		}
+
+		/*
+		 * A symlink with a target small enough to fit in the inode can
+		 * be stored in extents format if xattrs were added (thus
+		 * converting the data fork from shortform to remote format)
+		 * and then removed.
+		 */
+		if (S_ISLNK(mode)) {
 			if (be64_to_cpu(dip->di_size) <= fork_size &&
+			    fork_format != XFS_DINODE_FMT_EXTENTS &&
 			    fork_format != XFS_DINODE_FMT_LOCAL)
 				return __this_address;
 		}
 
+		/*
+		 * For all types, check that when the size says the fork should
+		 * be in extent or btree format, the inode isn't claiming to be
+		 * in local format.
+		 */
 		if (be64_to_cpu(dip->di_size) > fork_size &&
 		    fork_format == XFS_DINODE_FMT_LOCAL)
 			return __this_address;
 	}
 
-- 
2.49.0.906.g1f30a19c02-goog


