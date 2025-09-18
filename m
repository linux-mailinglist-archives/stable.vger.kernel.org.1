Return-Path: <stable+bounces-174079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56976B36161
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0B43BA29B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABC624166F;
	Tue, 26 Aug 2025 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v0v1TlgE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E421B9DA;
	Tue, 26 Aug 2025 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213435; cv=none; b=LIZtOTEMaCZrOavAbYL6EcNv0T3yPajt/grAzNebK0TyCGb7oXoJMZbQX2235I2Gqy7gZvwAlbNFA+LUmeBd+g6NV1cFA2VPpHGkQ80RSFVbFHpp+RMLnErppguaYAqnfZDwFW5AOR94FyDKEMMY6RQqIIBlQj9y0hfJa29wDak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213435; c=relaxed/simple;
	bh=7y+CgFMq3cCSRMGZ/yBrPwLenK+wC/Pmb2zrgENipoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDr3c8iM7iJsVI66h6eDw+UDFgkPNUW71r2TwPHZ2rHARnafCnxOJVU218KBxkTNxQ5S9NUw5q+/rVwrtfBcLYuM7hUAhiH0/GnioXa3/F4iMmtCcBHx+NqO9F4dSz9ZE+F6qMB6oz8jK04t7nIbEscxx4zD2fDtpfouTnfKZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v0v1TlgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F618C4CEF1;
	Tue, 26 Aug 2025 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213435;
	bh=7y+CgFMq3cCSRMGZ/yBrPwLenK+wC/Pmb2zrgENipoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v0v1TlgESf+hd0b9EHHDyL04JruakXoJM52hu8SMg/mjXndodRiEbttUHNk39o/lE
	 tYtr9CD+THqCU7yZdqFMhEnwBN4DavbM08i/Osd3ZWbcUwRpuP5rfyxevIWQet64Dy
	 ht3/wrHGIA8ryiom81jkGrB9+Wlj8PJfv42MMCuE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Dilger <adilger@whamcloud.com>,
	Li Dongyang <dongyangli@ddn.com>,
	Alex Zhuravlev <bzzz@whamcloud.com>,
	Oleg Drokin <green@whamcloud.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.6 348/587] ext4: check fast symlink for ea_inode correctly
Date: Tue, 26 Aug 2025 13:08:17 +0200
Message-ID: <20250826111001.767542279@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Dilger <adilger@dilger.ca>

commit b4cc4a4077268522e3d0d34de4b2dc144e2330fa upstream.

The check for a fast symlink in the presence of only an
external xattr inode is incorrect.  If a fast symlink does
not have an xattr block (i_file_acl == 0), but does have
an external xattr inode that increases inode i_blocks, then
the check for a fast symlink will incorrectly fail and
__ext4_iget()->ext4_ind_check_inode() will report the inode
is corrupt when it "validates" i_data[] on the next read:

    # ln -s foo /mnt/tmp/bar
    # setfattr -h -n trusted.test \
               -v "$(yes | head -n 4000)" /mnt/tmp/bar
    # umount /mnt/tmp
    # mount /mnt/tmp
    # ls -l /mnt/tmp
    ls: cannot access '/mnt/tmp/bar': Structure needs cleaning
    total 4
     ? l?????????? ? ?    ?        ?            ? bar
    # dmesg | tail -1
    EXT4-fs error (device dm-8): __ext4_iget:5098:
        inode #24578: block 7303014: comm ls: invalid block

(note that "block 7303014" = 0x6f6f66 = "foo" in LE order).

ext4_inode_is_fast_symlink() should check the superblock
EXT4_FEATURE_INCOMPAT_EA_INODE feature flag, not the inode
EXT4_EA_INODE_FL, since the latter is only set on the xattr
inode itself, and not on the inode that uses this xattr.

Cc: stable@vger.kernel.org
Fixes: fc82228a5e38 ("ext4: support fast symlinks from ext3 file systems")
Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
Reviewed-by: Li Dongyang <dongyangli@ddn.com>
Reviewed-by: Alex Zhuravlev <bzzz@whamcloud.com>
Reviewed-by: Oleg Drokin <green@whamcloud.com>
Reviewed-on: https://review.whamcloud.com/59879
Lustre-bug-id: https://jira.whamcloud.com/browse/LU-19121
Link: https://patch.msgid.link/20250717063709.757077-1-adilger@dilger.ca
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -146,7 +146,7 @@ static int ext4_meta_trans_blocks(struct
  */
 int ext4_inode_is_fast_symlink(struct inode *inode)
 {
-	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+	if (!ext4_has_feature_ea_inode(inode->i_sb)) {
 		int ea_blocks = EXT4_I(inode)->i_file_acl ?
 				EXT4_CLUSTER_SIZE(inode->i_sb) >> 9 : 0;
 



