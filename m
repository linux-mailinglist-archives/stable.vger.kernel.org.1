Return-Path: <stable+bounces-185230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A36BD52BA
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 18:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5293B58AF
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6055E30BB99;
	Mon, 13 Oct 2025 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S2AoohcG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C11C30EF93;
	Mon, 13 Oct 2025 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369703; cv=none; b=EMRqgBUgPvQsBmpea2gcwfvQeh98aJJ05g+HdD5Rvc6Yi2GD9HB+hAhJMynp8+SeHm48NJ9ePXrjYYDs+x3SQ5MFMuiNNpSVYOHejKaQQz/c5uYPNHEIP1CY5QvcwrOtwu7rLxMk/3Gffe5CJHGrRfarIUeXGnM3m58b5JgmlzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369703; c=relaxed/simple;
	bh=DN/TJmPC1hKu9EBA7/wllwWnX+RYTaNbCkRu0zH//Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvjV6NqxQON4OGZ68Mxe6CpkVbp/MW9/cZvS8mA44+T8bAhDiOLncj0NEj1tDSKS/SBkccatLgGrxZwLq6WmjWZaWHaOJUlAA4A1hsPd43w23Ji4wmqiNrXXYFlhY4ECwGgjWSZii3p5t2sXBZIVu+bOjOeLiFf4/DRLomAbAAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S2AoohcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FE9C4CEE7;
	Mon, 13 Oct 2025 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369703;
	bh=DN/TJmPC1hKu9EBA7/wllwWnX+RYTaNbCkRu0zH//Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2AoohcG0m+qzzDCyVs7vQiNiyERkwlzsVE3ixO9s3Zg3T5FWT7PmSsW6sHYwpOtt
	 27KYr5fqwbqmecwfMiRrsH7yXvpWM+4vjvHuVzcmwVmrMxJ4XPXvgtaZID2fYpADzB
	 dzz/EzHF7W1vbZMlwwZzacP/2HiSEv0dH/4utja4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitaly Grigoryev <Vitaly.Grigoryev@kaspersky.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 338/563] fs: ntfs3: Fix integer overflow in run_unpack()
Date: Mon, 13 Oct 2025 16:43:19 +0200
Message-ID: <20251013144423.514529539@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Grigoryev <Vitaly.Grigoryev@kaspersky.com>

[ Upstream commit 736fc7bf5f68f6b74a0925b7e072c571838657d2 ]

The MFT record relative to the file being opened contains its runlist,
an array containing information about the file's location on the physical
disk. Analysis of all Call Stack paths showed that the values of the
runlist array, from which LCNs are calculated, are not validated before
run_unpack function.

The run_unpack function decodes the compressed runlist data format
from MFT attributes (for example, $DATA), converting them into a runs_tree
structure, which describes the mapping of virtual clusters (VCN) to
logical clusters (LCN). The NTFS3 subsystem also has a shortcut for
deleting files from MFT records - in this case, the RUN_DEALLOCATE
command is sent to the run_unpack input, and the function logic
provides that all data transferred to the runlist about file or
directory is deleted without creating a runs_tree structure.

Substituting the runlist in the $DATA attribute of the MFT record for an
arbitrary file can lead either to access to arbitrary data on the disk
bypassing access checks to them (since the inode access check
occurs above) or to destruction of arbitrary data on the disk.

Add overflow check for addition operation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Signed-off-by: Vitaly Grigoryev <Vitaly.Grigoryev@kaspersky.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/run.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 6e86d66197ef2..88550085f7457 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/log2.h>
+#include <linux/overflow.h>
 
 #include "debug.h"
 #include "ntfs.h"
@@ -982,14 +983,18 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 
 			if (!dlcn)
 				return -EINVAL;
-			lcn = prev_lcn + dlcn;
+
+			if (check_add_overflow(prev_lcn, dlcn, &lcn))
+				return -EINVAL;
 			prev_lcn = lcn;
 		} else {
 			/* The size of 'dlcn' can't be > 8. */
 			return -EINVAL;
 		}
 
-		next_vcn = vcn64 + len;
+		if (check_add_overflow(vcn64, len, &next_vcn))
+			return -EINVAL;
+
 		/* Check boundary. */
 		if (next_vcn > evcn + 1)
 			return -EINVAL;
@@ -1153,7 +1158,8 @@ int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn)
 			return -EINVAL;
 
 		run_buf += size_size + offset_size;
-		vcn64 += len;
+		if (check_add_overflow(vcn64, len, &vcn64))
+			return -EINVAL;
 
 #ifndef CONFIG_NTFS3_64BIT_CLUSTER
 		if (vcn64 > 0x100000000ull)
-- 
2.51.0




