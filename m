Return-Path: <stable+bounces-21432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A53985C8DF
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77221C22360
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDB6151CD8;
	Tue, 20 Feb 2024 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qRD6cKwe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20E514A4E6;
	Tue, 20 Feb 2024 21:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464402; cv=none; b=Cov4WfcXVN+5dcAiGJNF6GDp+UizzXGFYbSrfO3OspgewBwcDtL3zDSOEViMPYaVKw2k3qRm1ENhFJl6qLc5TLCg8FcJI+1gHem+Iu6EZk5GHfIlMjTtkOn2NuQsoFOod3MWVZDmYjtJZDSZkNfhelxUtjPlKALDZyHC/74QLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464402; c=relaxed/simple;
	bh=mRGSDT9bqP/oD3loC05Rb0Gj7DC27j/pvVLyKgShats=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shS/5oZSFa4JPdnNTumq6/qvBmCCP2fiuYVMeXc0EBk7y5MBMFs2VDAEfwyRVqLopii1dGNaK6oChBiloYAsx2U93oDOpE4OzWenYp6E4Rz1dDwSQCuLXAeQU2xV3guNGjN5LjGvKbcqt2Cc6m286qqtIVt4hwv8njzwnxHQyJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qRD6cKwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B10C433F1;
	Tue, 20 Feb 2024 21:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464401;
	bh=mRGSDT9bqP/oD3loC05Rb0Gj7DC27j/pvVLyKgShats=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRD6cKwei4zqZunHDTZpiwdy5sCFuixG3CE59+mzCgbGOocz4hdcDOWHAXURjdPMA
	 Ur6LcQpdoBS6IkETXyQ/soCRBmvl8yPyBiHivs6VkFHBtEk0YCwuwjBaywLEJheF1B
	 u6RQRkCsi+gYoC11WC70VtPl4+BXdsGebnBQvyGg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.7 014/309] btrfs: reject encoded write if inode has nodatasum flag set
Date: Tue, 20 Feb 2024 21:52:53 +0100
Message-ID: <20240220205633.593466248@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 1bd96c92c6a0a4d43815eb685c15aa4b78879dc9 upstream.

Currently we allow an encoded write against inodes that have the NODATASUM
flag set, either because they are NOCOW files or they were created while
the filesystem was mounted with "-o nodatasum". This results in having
compressed extents without corresponding checksums, which is a filesystem
inconsistency reported by 'btrfs check'.

For example, running btrfs/281 with MOUNT_OPTIONS="-o nodatacow" triggers
this and 'btrfs check' errors out with:

   [1/7] checking root items
   [2/7] checking extents
   [3/7] checking free space tree
   [4/7] checking fs roots
   root 256 inode 257 errors 1040, bad file extent, some csum missing
   root 256 inode 258 errors 1040, bad file extent, some csum missing
   ERROR: errors found in fs roots
   (...)

So reject encoded writes if the target inode has NODATASUM set.

CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10233,6 +10233,13 @@ ssize_t btrfs_do_encoded_write(struct ki
 	if (encoded->encryption != BTRFS_ENCODED_IO_ENCRYPTION_NONE)
 		return -EINVAL;
 
+	/*
+	 * Compressed extents should always have checksums, so error out if we
+	 * have a NOCOW file or inode was created while mounted with NODATASUM.
+	 */
+	if (inode->flags & BTRFS_INODE_NODATASUM)
+		return -EINVAL;
+
 	orig_count = iov_iter_count(from);
 
 	/* The extent size must be sane. */



