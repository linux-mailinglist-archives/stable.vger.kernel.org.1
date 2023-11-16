Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666F57ED977
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 03:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344538AbjKPC24 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 21:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344540AbjKPC2z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 21:28:55 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B310119E;
        Wed, 15 Nov 2023 18:28:50 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc5b6d6228so2814205ad.2;
        Wed, 15 Nov 2023 18:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101730; x=1700706530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1s4ooQ7Et0dowHvzAL7bxzfQoGL4SlRouIUhaWbXdGg=;
        b=bo423cMpkNFR5YEBpssVOkJk33Pdlp/gTPT2v1OYmQb0sMTLkqQ9KhadmlbYjyaVt8
         fV+dt5Rz533IjrPTrU5kXjJHrduc53YoIEwwTQDKrJRhly/om7WbXLyWy65eWrAxcy7G
         WnahYvDLNJD/ZuLkZgeVEMWR3jgV3ZlaZiUNokcw/7TlCzCLbBaTeRuxbVZrzujYXpDZ
         +oGc4PzCwX5i0WWcro5MIQ5rIrhXkYbkskSi4I5L0jaz4Mfy2pJ8ZDmEfQIA42uLJ1Zw
         eLcCPZ8ncnpSUyIpy41WcgO9M3NL37LuB2aQeqDt/qKMrj/QBI1pLPoK+3/9gwJOBK49
         PtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101730; x=1700706530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1s4ooQ7Et0dowHvzAL7bxzfQoGL4SlRouIUhaWbXdGg=;
        b=uMGf3/8RnN776G2ej60tf4K9Lv4yMkiSLXOm2O2PErj3c/uiB6Y0ruslvfxZ2907Ff
         SaeQlYFkoTN5oa0ddL8sEj3GaZ/QKdy1fi+Z6ARUxVpy1I9gDiMvMyngfYVZOXOje04f
         fORb11WsdzeGoMo1NrduBQW9vuXrjzAT+bQ2OssHZoRK0ZsFsKG1b5kDLbsklHpqUP/I
         YvqqS47Uy91LK0Y8LfKWB1UdyJY6Ko+0em2Olc0Q/9b/wN69m2OZmxH7ajzD1CBMLK0a
         MciYMvLZzWeq56+EFYdPMt+doTlD92T8w95OpqmreO+A26WJG5bah6hfgCAUSoqkv8Ey
         aYDg==
X-Gm-Message-State: AOJu0Yzrxpw1KAY9LEmR49fVz8QBCUWr+m77K3dVVvP/ka2u72M8QTa5
        ZOwqcpfhWlK3wZrtOSPVbiIGR2CwpY1uyg==
X-Google-Smtp-Source: AGHT+IFmjvAIcJL9vxhIWrWUzc2h4Q7B5bNd01TuaU7wLEiHJoXbUih9LZC3wMi/O8JjhWCIVSxjQA==
X-Received: by 2002:a17:902:db0a:b0:1cb:dc81:379a with SMTP id m10-20020a170902db0a00b001cbdc81379amr1180935plx.53.1700101729973;
        Wed, 15 Nov 2023 18:28:49 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2a3:200:25ea:d6bb:623c:d6a0])
        by smtp.gmail.com with ESMTPSA id j9-20020a170903024900b001b8b1f6619asm8087072plh.75.2023.11.15.18.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:28:49 -0800 (PST)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     stable@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, amir73il@gmail.com,
        chandan.babu@oracle.com, fred@cloudflare.com,
        Wengang Wang <wen.gang.wang@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Chandan Babu R <chandanbabu@kernel.org>
Subject: [PATCH 5.15 12/17] xfs: Fix false ENOSPC when performing direct write on a delalloc extent in cow fork
Date:   Wed, 15 Nov 2023 18:28:28 -0800
Message-ID: <20231116022833.121551-12-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116022833.121551-1-leah.rumancik@gmail.com>
References: <20231116022833.121551-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chandan Babu R <chandan.babu@oracle.com>

[ Upstream commit d62113303d691bcd8d0675ae4ac63e7769afc56c ]

On a higly fragmented filesystem a Direct IO write can fail with -ENOSPC error
even though the filesystem has sufficient number of free blocks.

This occurs if the file offset range on which the write operation is being
performed has a delalloc extent in the cow fork and this delalloc extent
begins much before the Direct IO range.

In such a scenario, xfs_reflink_allocate_cow() invokes xfs_bmapi_write() to
allocate the blocks mapped by the delalloc extent. The extent thus allocated
may not cover the beginning of file offset range on which the Direct IO write
was issued. Hence xfs_reflink_allocate_cow() ends up returning -ENOSPC.

The following script reliably recreates the bug described above.

  #!/usr/bin/bash

  device=/dev/loop0
  shortdev=$(basename $device)

  mntpnt=/mnt/
  file1=${mntpnt}/file1
  file2=${mntpnt}/file2
  fragmentedfile=${mntpnt}/fragmentedfile
  punchprog=/root/repos/xfstests-dev/src/punch-alternating

  errortag=/sys/fs/xfs/${shortdev}/errortag/bmap_alloc_minlen_extent

  umount $device > /dev/null 2>&1

  echo "Create FS"
  mkfs.xfs -f -m reflink=1 $device > /dev/null 2>&1
  if [[ $? != 0 ]]; then
  	echo "mkfs failed."
  	exit 1
  fi

  echo "Mount FS"
  mount $device $mntpnt > /dev/null 2>&1
  if [[ $? != 0 ]]; then
  	echo "mount failed."
  	exit 1
  fi

  echo "Create source file"
  xfs_io -f -c "pwrite 0 32M" $file1 > /dev/null 2>&1

  sync

  echo "Create Reflinked file"
  xfs_io -f -c "reflink $file1" $file2 &>/dev/null

  echo "Set cowextsize"
  xfs_io -c "cowextsize 16M" $file1 > /dev/null 2>&1

  echo "Fragment FS"
  xfs_io -f -c "pwrite 0 64M" $fragmentedfile > /dev/null 2>&1
  sync
  $punchprog $fragmentedfile

  echo "Allocate block sized extent from now onwards"
  echo -n 1 > $errortag

  echo "Create 16MiB delalloc extent in CoW fork"
  xfs_io -c "pwrite 0 4k" $file1 > /dev/null 2>&1

  sync

  echo "Direct I/O write at offset 12k"
  xfs_io -d -c "pwrite 12k 8k" $file1

This commit fixes the bug by invoking xfs_bmapi_write() in a loop until disk
blocks are allocated for atleast the starting file offset of the Direct IO
write range.

Fixes: 3c68d44a2b49 ("xfs: allocate direct I/O COW blocks in iomap_begin")
Reported-and-Root-caused-by: Wengang Wang <wen.gang.wang@oracle.com>
Signed-off-by: Chandan Babu R <chandan.babu@oracle.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: slight editing to make the locking less grody, and fix some style things]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Chandan Babu R <chandanbabu@kernel.org>
---
 fs/xfs/xfs_reflink.c | 198 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 163 insertions(+), 35 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 628ce65d02bb..793bdf5ac2f7 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -340,9 +340,41 @@ xfs_find_trim_cow_extent(
 	return 0;
 }
 
-/* Allocate all CoW reservations covering a range of blocks in a file. */
-int
-xfs_reflink_allocate_cow(
+static int
+xfs_reflink_convert_unwritten(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	struct xfs_bmbt_irec	*cmap,
+	bool			convert_now)
+{
+	xfs_fileoff_t		offset_fsb = imap->br_startoff;
+	xfs_filblks_t		count_fsb = imap->br_blockcount;
+	int			error;
+
+	/*
+	 * cmap might larger than imap due to cowextsize hint.
+	 */
+	xfs_trim_extent(cmap, offset_fsb, count_fsb);
+
+	/*
+	 * COW fork extents are supposed to remain unwritten until we're ready
+	 * to initiate a disk write.  For direct I/O we are going to write the
+	 * data and need the conversion, but for buffered writes we're done.
+	 */
+	if (!convert_now || cmap->br_state == XFS_EXT_NORM)
+		return 0;
+
+	trace_xfs_reflink_convert_cow(ip, cmap);
+
+	error = xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
+	if (!error)
+		cmap->br_state = XFS_EXT_NORM;
+
+	return error;
+}
+
+static int
+xfs_reflink_fill_cow_hole(
 	struct xfs_inode	*ip,
 	struct xfs_bmbt_irec	*imap,
 	struct xfs_bmbt_irec	*cmap,
@@ -351,25 +383,12 @@ xfs_reflink_allocate_cow(
 	bool			convert_now)
 {
 	struct xfs_mount	*mp = ip->i_mount;
-	xfs_fileoff_t		offset_fsb = imap->br_startoff;
-	xfs_filblks_t		count_fsb = imap->br_blockcount;
 	struct xfs_trans	*tp;
-	int			nimaps, error = 0;
-	bool			found;
 	xfs_filblks_t		resaligned;
-	xfs_extlen_t		resblks = 0;
-
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
-	if (!ip->i_cowfp) {
-		ASSERT(!xfs_is_reflink_inode(ip));
-		xfs_ifork_init_cow(ip);
-	}
-
-	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
-	if (error || !*shared)
-		return error;
-	if (found)
-		goto convert;
+	xfs_extlen_t		resblks;
+	int			nimaps;
+	int			error;
+	bool			found;
 
 	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
 		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
@@ -385,17 +404,17 @@ xfs_reflink_allocate_cow(
 
 	*lockmode = XFS_ILOCK_EXCL;
 
-	/*
-	 * Check for an overlapping extent again now that we dropped the ilock.
-	 */
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
 	if (error || !*shared)
 		goto out_trans_cancel;
+
 	if (found) {
 		xfs_trans_cancel(tp);
 		goto convert;
 	}
 
+	ASSERT(cmap->br_startoff > imap->br_startoff);
+
 	/* Allocate the entire reservation as unwritten blocks. */
 	nimaps = 1;
 	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
@@ -415,26 +434,135 @@ xfs_reflink_allocate_cow(
 	 */
 	if (nimaps == 0)
 		return -ENOSPC;
+
 convert:
-	xfs_trim_extent(cmap, offset_fsb, count_fsb);
-	/*
-	 * COW fork extents are supposed to remain unwritten until we're ready
-	 * to initiate a disk write.  For direct I/O we are going to write the
-	 * data and need the conversion, but for buffered writes we're done.
-	 */
-	if (!convert_now || cmap->br_state == XFS_EXT_NORM)
-		return 0;
-	trace_xfs_reflink_convert_cow(ip, cmap);
-	error = xfs_reflink_convert_cow_locked(ip, offset_fsb, count_fsb);
-	if (!error)
-		cmap->br_state = XFS_EXT_NORM;
+	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
+
+out_trans_cancel:
+	xfs_trans_cancel(tp);
 	return error;
+}
+
+static int
+xfs_reflink_fill_delalloc(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	struct xfs_bmbt_irec	*cmap,
+	bool			*shared,
+	uint			*lockmode,
+	bool			convert_now)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	int			nimaps;
+	int			error;
+	bool			found;
+
+	do {
+		xfs_iunlock(ip, *lockmode);
+		*lockmode = 0;
+
+		error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, 0, 0,
+				false, &tp);
+		if (error)
+			return error;
+
+		*lockmode = XFS_ILOCK_EXCL;
+
+		error = xfs_find_trim_cow_extent(ip, imap, cmap, shared,
+				&found);
+		if (error || !*shared)
+			goto out_trans_cancel;
+
+		if (found) {
+			xfs_trans_cancel(tp);
+			break;
+		}
+
+		ASSERT(isnullstartblock(cmap->br_startblock) ||
+		       cmap->br_startblock == DELAYSTARTBLOCK);
+
+		/*
+		 * Replace delalloc reservation with an unwritten extent.
+		 */
+		nimaps = 1;
+		error = xfs_bmapi_write(tp, ip, cmap->br_startoff,
+				cmap->br_blockcount,
+				XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0,
+				cmap, &nimaps);
+		if (error)
+			goto out_trans_cancel;
+
+		xfs_inode_set_cowblocks_tag(ip);
+		error = xfs_trans_commit(tp);
+		if (error)
+			return error;
+
+		/*
+		 * Allocation succeeded but the requested range was not even
+		 * partially satisfied?  Bail out!
+		 */
+		if (nimaps == 0)
+			return -ENOSPC;
+	} while (cmap->br_startoff + cmap->br_blockcount <= imap->br_startoff);
+
+	return xfs_reflink_convert_unwritten(ip, imap, cmap, convert_now);
 
 out_trans_cancel:
 	xfs_trans_cancel(tp);
 	return error;
 }
 
+/* Allocate all CoW reservations covering a range of blocks in a file. */
+int
+xfs_reflink_allocate_cow(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	struct xfs_bmbt_irec	*cmap,
+	bool			*shared,
+	uint			*lockmode,
+	bool			convert_now)
+{
+	int			error;
+	bool			found;
+
+	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	if (!ip->i_cowfp) {
+		ASSERT(!xfs_is_reflink_inode(ip));
+		xfs_ifork_init_cow(ip);
+	}
+
+	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
+	if (error || !*shared)
+		return error;
+
+	/* CoW fork has a real extent */
+	if (found)
+		return xfs_reflink_convert_unwritten(ip, imap, cmap,
+				convert_now);
+
+	/*
+	 * CoW fork does not have an extent and data extent is shared.
+	 * Allocate a real extent in the CoW fork.
+	 */
+	if (cmap->br_startoff > imap->br_startoff)
+		return xfs_reflink_fill_cow_hole(ip, imap, cmap, shared,
+				lockmode, convert_now);
+
+	/*
+	 * CoW fork has a delalloc reservation. Replace it with a real extent.
+	 * There may or may not be a data fork mapping.
+	 */
+	if (isnullstartblock(cmap->br_startblock) ||
+	    cmap->br_startblock == DELAYSTARTBLOCK)
+		return xfs_reflink_fill_delalloc(ip, imap, cmap, shared,
+				lockmode, convert_now);
+
+	/* Shouldn't get here. */
+	ASSERT(0);
+	return -EFSCORRUPTED;
+}
+
 /*
  * Cancel CoW reservations for some block range of an inode.
  *
-- 
2.43.0.rc0.421.g78406f8d94-goog

