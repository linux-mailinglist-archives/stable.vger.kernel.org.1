Return-Path: <stable+bounces-123341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70928A5C4FB
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F96189BE5D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DC625E801;
	Tue, 11 Mar 2025 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mX5Y3roC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87F325D8E8;
	Tue, 11 Mar 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705673; cv=none; b=SfMU7e9b5d3HVopx6o/I9+Hpgd8WGQeavJAdvoKcS+kSYbOFCA0qbgOsMCTD5uTLRSe2IOEhlNMFqtyzWXv6L7OGKKM+P0MPIqoRdmfnedoviy2qSU2Rp1dJEaOQ7yQQeO3QGy1GIVaygxJg7UmleL6Q0clMfhzWeZmxiOZJOkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705673; c=relaxed/simple;
	bh=4gIq/HFx0p4Mbch/tafQkGHMEXGQvh9i7WaKupkx7z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV8O9BtkqundhETFi/CtmShGYTm80MciNe+TDHmhI1dHsmI24JB82Symaj3xNjMu2Gt2/NCOrOUSYXwHtYULjo9o86sJlASimHi45rxIn7sVvetLQcbJDotaSt57vWSWuf9WtHLBEpAhtS5DTXLi/SmOVROTpfH8Qb6rRiXL9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mX5Y3roC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33A9C4CEE9;
	Tue, 11 Mar 2025 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741705673;
	bh=4gIq/HFx0p4Mbch/tafQkGHMEXGQvh9i7WaKupkx7z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mX5Y3roCvmbl5DTXM947TO6VkvmdbdNBXdMXjrSxbCc6v/XlU+e4ySfEDPm8K3qIZ
	 KdxjIGL2RKRSjKtGxH3oNmoxAKlJjAchRkE9CgH/jJwkgVmZ4INsxeG6H1bno7XSjL
	 IhopF+XntyYziDCTIiAc9C8ofu99PTGxSfocRY4U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 098/328] nilfs2: eliminate staggered calls to kunmap in nilfs_rename
Date: Tue, 11 Mar 2025 15:57:48 +0100
Message-ID: <20250311145718.787507638@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311145714.865727435@linuxfoundation.org>
References: <20250311145714.865727435@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit 8cf57c6df818f58fdad16a909506be213623a88e upstream.

In nilfs_rename(), calls to nilfs_put_page() to release pages obtained
with nilfs_find_entry() or nilfs_dotdot() are alternated in the normal
path.

When replacing the kernel memory mapping method from kmap to
kmap_local_{page,folio}, this violates the constraint on the calling order
of kunmap_local().

Swap the order of nilfs_put_page calls where the kmap sections of multiple
pages overlap so that they are nested, allowing direct replacement of
nilfs_put_page() -> unmap_and_put_page().

Without this reordering, that replacement will cause a kernel WARNING in
kunmap_local_indexed() on architectures with high memory mapping.

Link: https://lkml.kernel.org/r/20231127143036.2425-3-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: ee70999a988b ("nilfs2: handle errors that nilfs_prepare_chunk() may return")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/namei.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -428,13 +428,14 @@ static int nilfs_rename(struct inode *ol
 	old_inode->i_ctime = current_time(old_inode);
 
 	nilfs_delete_entry(old_de, old_page);
-	nilfs_put_page(old_page);
 
 	if (dir_de) {
 		nilfs_set_link(old_inode, dir_de, dir_page, new_dir);
 		nilfs_put_page(dir_page);
 		drop_nlink(old_dir);
 	}
+	nilfs_put_page(old_page);
+
 	nilfs_mark_inode_dirty(old_dir);
 	nilfs_mark_inode_dirty(old_inode);
 



