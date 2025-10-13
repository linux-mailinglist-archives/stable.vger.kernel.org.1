Return-Path: <stable+bounces-184359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9226BD3D05
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378D9188016A
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C930B51B;
	Mon, 13 Oct 2025 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GgsRZlVP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A530B512;
	Mon, 13 Oct 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367207; cv=none; b=UJoY+FkRLW/qdCUpi2AEuDBsVmXFfhVRHz8CWQgzEpfIsSBxss3gK6+gaDD33OZlls9jwqcW9aLejLJTD99U64kNyArCyJEJg3HGUfCnqmAeX5GE1cqIRoUbtoOb6r0QKseGhuFDerpg9AYCy4I5Atpv2l1KZa7Zs5NPXXbokl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367207; c=relaxed/simple;
	bh=74tKqXOWownIlsEOOBwhdSdrfnd4Qe61YRpk9b1KDGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI5RVKDiCbeoUEXjsUFLSjdOl++htL19+HpIBX9/oMDAO31Ls5ORiRsu3JAtwZGorynhe/lqWsaYXkc1Ty/YMZGTsw9Q73PEARohI3H4ICRjDOupJ2u+6FIeJpz761PwE+U0qDHqQiFOysJtDz67VO4KG8B2BqWAtc+qLCd+pHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GgsRZlVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61217C16AAE;
	Mon, 13 Oct 2025 14:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367206;
	bh=74tKqXOWownIlsEOOBwhdSdrfnd4Qe61YRpk9b1KDGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgsRZlVPNyWIiLYPwWE5x0CWmG9+vEOqw6Rm/df1gIShwjuypRkcDUItAT3qOvLPc
	 FL2osNwD5D8RlYqRPjZW4AibsX8FWsLiMAALln5Kog0uyk6JN/3D4cuUKGsj0AOXs8
	 te9E23sR8/F8AEu7kC+CHbYYfOgADZWPWuuPHIps=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitaly Grigoryev <Vitaly.Grigoryev@kaspersky.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 122/196] fs: ntfs3: Fix integer overflow in run_unpack()
Date: Mon, 13 Oct 2025 16:44:55 +0200
Message-ID: <20251013144319.109444587@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144314.549284796@linuxfoundation.org>
References: <20251013144314.549284796@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 12d8682f33b53..340a4cbe8b5ca 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/log2.h>
+#include <linux/overflow.h>
 
 #include "debug.h"
 #include "ntfs.h"
@@ -982,12 +983,16 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 
 			if (!dlcn)
 				return -EINVAL;
-			lcn = prev_lcn + dlcn;
+
+			if (check_add_overflow(prev_lcn, dlcn, &lcn))
+				return -EINVAL;
 			prev_lcn = lcn;
 		} else
 			return -EINVAL;
 
-		next_vcn = vcn64 + len;
+		if (check_add_overflow(vcn64, len, &next_vcn))
+			return -EINVAL;
+
 		/* Check boundary. */
 		if (next_vcn > evcn + 1)
 			return -EINVAL;
@@ -1148,7 +1153,8 @@ int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn)
 			return -EINVAL;
 
 		run_buf += size_size + offset_size;
-		vcn64 += len;
+		if (check_add_overflow(vcn64, len, &vcn64))
+			return -EINVAL;
 
 #ifndef CONFIG_NTFS3_64BIT_CLUSTER
 		if (vcn64 > 0x100000000ull)
-- 
2.51.0




