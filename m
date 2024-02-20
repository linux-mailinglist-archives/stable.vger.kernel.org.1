Return-Path: <stable+bounces-20923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E585C656
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95911C20A7A
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1750151CF1;
	Tue, 20 Feb 2024 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SCFFUCgE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92F151CCD;
	Tue, 20 Feb 2024 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462797; cv=none; b=n26FQWWzfEDDwfdT9kkhLS+AlCJEndufCP/3c55YvywgONoAu1+OwjfuCSCqX8z0wGFa+1+DbDeVXnbq78gMUj4jKMcGQVWuwZV68uN3GI/8pF360Jf9W9NbjXweVGMytHFBOqZSaBBVLByniRoZQJ41vRLxEBTQNb6z0JCNuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462797; c=relaxed/simple;
	bh=f7Hp22WmiKSgmQaJ1WrcATKXBzWRgqSPTsp+Q7l0g8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EENy80m91T66s1bOKXbUNcVDEUfmqA1GY/yxU+jxjcuesFeWKWkGIrkp9Xn+bx79nUCfmGlrxtRLGNsWbsuIrUEXIkANNGtveOWCXgqppXBIHErY5gtb2F4lQ0z0cmeHoPvKfM878Su0LsA7f1dF+99TGtkd7kb0dN+9ZFr2dXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SCFFUCgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD194C433F1;
	Tue, 20 Feb 2024 20:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708462797;
	bh=f7Hp22WmiKSgmQaJ1WrcATKXBzWRgqSPTsp+Q7l0g8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SCFFUCgEkIRZG70mxF1boFmE7nJivhn866LgrEmKkVetbGlfNoIiqbiBnZ72UwIkr
	 0Xbrz0xIJe73Od8m+1hLQw5f/P4Q0RS77pvyCWGoHgwnSRjlnoIxtvGSnfcwrK+YnA
	 JV58UJCV+9ROwFbVmGT32FuP6u9ZwRs1nzaTZxGE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 010/197] btrfs: reject encoded write if inode has nodatasum flag set
Date: Tue, 20 Feb 2024 21:49:29 +0100
Message-ID: <20240220204841.390296343@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220204841.073267068@linuxfoundation.org>
References: <20240220204841.073267068@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -10774,6 +10774,13 @@ ssize_t btrfs_do_encoded_write(struct ki
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



