Return-Path: <stable+bounces-155022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8ECAE16ED
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2BF1883DC5
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8F927E063;
	Fri, 20 Jun 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RllWVL6u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB87727CB2A
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750410138; cv=none; b=rMoAgH8Nll0/DF5ATHKkLEmV2WNfpnSTOg9O+SVtzcC52jTeMFBBdA5LYvW3cckcMfnRaQ6RiXmguuYsOZjURG2pEvE5xDajqNu6Ur0rQuJUvDUGTV1cU9wspNMyyExLabsxDgxqhwBABBQpMDbinQtVfhNfWZoB+tMTI1MFZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750410138; c=relaxed/simple;
	bh=07UFR25tJv51THf2iNM8NctTTJHJW11O4UQD9YIhknE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WUjmOZpShM5F463WrdKVoIF6VQNpEvGBH2/nLT1k25Aaa7A25l3dq6pbx6QEjXzOiXVwQXt8Knr9wulJgmZFv6Yi3TocOsZz7MarV+CIrYEvzP/epIG0kWG2tGLlNfYfSrGV1zL1dcuLB0fKYPNZ35IET3OXtmHDJGTgTzfssC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RllWVL6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDC1C4CEE3;
	Fri, 20 Jun 2025 09:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750410137;
	bh=07UFR25tJv51THf2iNM8NctTTJHJW11O4UQD9YIhknE=;
	h=Subject:To:Cc:From:Date:From;
	b=RllWVL6u5NxVW6zpWKFg8nFB3o5p1X1ywovzCm1tDwdhmdyn2nRS9cCqn13P/OQ0m
	 Vnzav8X0nQ7pwS20tzf7z2ZojkaufCQCcYvrfon1L+q/S3QZdTtovE0xQ1Ehjx6sGt
	 J3vlXowiqcykBZhAZYKLVq91tl8h6mWj0ntDh63o=
Subject: FAILED: patch "[PATCH] ext4: ensure i_size is smaller than maxbytes" failed to apply to 5.4-stable tree
To: yi.zhang@huawei.com,jack@suse.cz,libaokun1@huawei.com,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 11:02:12 +0200
Message-ID: <2025062011-unaired-system-c935@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 1a77a028a392fab66dd637cdfac3f888450d00af
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062011-unaired-system-c935@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1a77a028a392fab66dd637cdfac3f888450d00af Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Tue, 6 May 2025 09:20:09 +0800
Subject: [PATCH] ext4: ensure i_size is smaller than maxbytes

The inode i_size cannot be larger than maxbytes, check it while loading
inode from the disk.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun1@huawei.com>
Link: https://patch.msgid.link/20250506012009.3896990-4-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 01038b4ecee0..ca1f7a0dd8f8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4966,7 +4966,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		ei->i_file_acl |=
 			((__u64)le16_to_cpu(raw_inode->i_file_acl_high)) << 32;
 	inode->i_size = ext4_isize(sb, raw_inode);
-	if ((size = i_size_read(inode)) < 0) {
+	size = i_size_read(inode);
+	if (size < 0 || size > ext4_get_maxbytes(inode)) {
 		ext4_error_inode(inode, function, line, 0,
 				 "iget: bad i_size value: %lld", size);
 		ret = -EFSCORRUPTED;


