Return-Path: <stable+bounces-172982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34883B35B28
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD351BA0BD4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCD533A002;
	Tue, 26 Aug 2025 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B2ypz6/8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B7338F3F;
	Tue, 26 Aug 2025 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207067; cv=none; b=awI68GCl+yS/x8ins8FHpr1o3KNr+kZBr+pn/U91Gah4LpetNHq3vvwzwofWAJq8beNMpWL9lLIdjZ6dll5NOw/bAoF7RUZij/guCkJRHelLqGs9OOgPZrhcb9yNWlxavYtQxX/ERFLAfB8yR+/mAPpPK/AsP6YUwylGiT0VPio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207067; c=relaxed/simple;
	bh=2qwVv6+sX6PG0gNsN8RTeUIrKUouVzQcHdWNy8I+tzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGCKCS5RSrCr8qwFigDU91q+DVbaTVzGgbERxQrGfCSe4ZoYp/eyZ/v5YRORBsOOJo2pGL8it5poSGQjsbIwVin0C+5lTBxu5Uut1NjSTnRDUaMp5Ol1H46Y0y7XuZGI5H/fsMJpoAQjX9Hz1DeD4oAWrV294jDCYdmFdzRfbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B2ypz6/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F57C116B1;
	Tue, 26 Aug 2025 11:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207067;
	bh=2qwVv6+sX6PG0gNsN8RTeUIrKUouVzQcHdWNy8I+tzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2ypz6/85O1/+P/edDb1DtM0NqMxhsWJ4poHzoTStYduK/WxuKzG3fSDnK5XqyA7q
	 0ueaFr88IX8m0NN1XgbTsvqV69Qx9Agf++Khoo8y1xG0aM6WcFmu8vvYSxZM6XDc13
	 SQurzZUPDIpIB+GWA8jW7gL2kKSDfd7UBG7zzAqI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Dilger <adilger@whamcloud.com>,
	Li Dongyang <dongyangli@ddn.com>,
	Alex Zhuravlev <bzzz@whamcloud.com>,
	Oleg Drokin <green@whamcloud.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.16 038/457] ext4: check fast symlink for ea_inode correctly
Date: Tue, 26 Aug 2025 13:05:22 +0200
Message-ID: <20250826110938.287890823@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -146,7 +146,7 @@ static inline int ext4_begin_ordered_tru
  */
 int ext4_inode_is_fast_symlink(struct inode *inode)
 {
-	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+	if (!ext4_has_feature_ea_inode(inode->i_sb)) {
 		int ea_blocks = EXT4_I(inode)->i_file_acl ?
 				EXT4_CLUSTER_SIZE(inode->i_sb) >> 9 : 0;
 



