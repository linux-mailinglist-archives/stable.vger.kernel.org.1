Return-Path: <stable+bounces-130962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A82A80761
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83484C56F6
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B230269820;
	Tue,  8 Apr 2025 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JSXfkfyK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E12690D6;
	Tue,  8 Apr 2025 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115121; cv=none; b=i+aSRgB6OLOBs2b+KiRAhEIk4oYXvs8KNUwpNJPLswJbITEelOdhWF8iO04DXvoaiEAGayzxrwCS9DLgVoaG/rM4UFfK8LX2Rsi4KTXDbMs3Sfsq6RVKCiddAHJ273Tdl6gUVzhAhiOCtZZsLl6DRUmpxA8gUD6rti7r77bCKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115121; c=relaxed/simple;
	bh=5Cie7A9nrQsFOOhxMqRqcwwjT2bObwTaIc66Y1SEIV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxA5l1+3TJg3iedA2qOxZDazwvb0MFdJwqHI2x+p7RRL48lbLE0JLacHYfkmx6RoOAbp3uUbcccsj2mf+djWvyVZb9UgNZq2etwnO49FVi9vxqie5Tk0H1byBEpcyom2tv4e8MgMSlApf08tHEto9+16+tQxmgtNFzrejWHJAA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JSXfkfyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF52C4CEE5;
	Tue,  8 Apr 2025 12:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115121;
	bh=5Cie7A9nrQsFOOhxMqRqcwwjT2bObwTaIc66Y1SEIV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JSXfkfyK08py2wUpU2WKOAYEnKe3gTRNvInkq3WJtaUS2gYx3gi05weHOg6je18CF
	 nYvg5mo3Nc4XvTD5KonDQkv9TuO/kYqU6KZqjmrFNs/YWnUWreTi+rQQFiNhWAOD5/
	 D+ePFoLJg2hxwuRCzWlC1ssYwofsSSWISf+9WF9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 357/499] fs/9p: fix NULL pointer dereference on mkdir
Date: Tue,  8 Apr 2025 12:49:29 +0200
Message-ID: <20250408104900.137244227@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Schoenebeck <linux_oss@crudebyte.com>

[ Upstream commit 3f61ac7c65bdb26accb52f9db66313597e759821 ]

When a 9p tree was mounted with option 'posixacl', parent directory had a
default ACL set for its subdirectories, e.g.:

  setfacl -m default:group:simpsons:rwx parentdir

then creating a subdirectory crashed 9p client, as v9fs_fid_add() call in
function v9fs_vfs_mkdir_dotl() sets the passed 'fid' pointer to NULL
(since dafbe689736) even though the subsequent v9fs_set_create_acl() call
expects a valid non-NULL 'fid' pointer:

  [   37.273191] BUG: kernel NULL pointer dereference, address: 0000000000000000
  ...
  [   37.322338] Call Trace:
  [   37.323043]  <TASK>
  [   37.323621] ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
  [   37.324448] ? page_fault_oops (arch/x86/mm/fault.c:714)
  [   37.325532] ? search_module_extables (kernel/module/main.c:3733)
  [   37.326742] ? p9_client_walk (net/9p/client.c:1165) 9pnet
  [   37.328006] ? search_bpf_extables (kernel/bpf/core.c:804)
  [   37.329142] ? exc_page_fault (./arch/x86/include/asm/paravirt.h:686 arch/x86/mm/fault.c:1488 arch/x86/mm/fault.c:1538)
  [   37.330196] ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:574)
  [   37.331330] ? p9_client_walk (net/9p/client.c:1165) 9pnet
  [   37.332562] ? v9fs_fid_xattr_get (fs/9p/xattr.c:30) 9p
  [   37.333824] v9fs_fid_xattr_set (fs/9p/fid.h:23 fs/9p/xattr.c:121) 9p
  [   37.335077] v9fs_set_acl (fs/9p/acl.c:276) 9p
  [   37.336112] v9fs_set_create_acl (fs/9p/acl.c:307) 9p
  [   37.337326] v9fs_vfs_mkdir_dotl (fs/9p/vfs_inode_dotl.c:411) 9p
  [   37.338590] vfs_mkdir (fs/namei.c:4313)
  [   37.339535] do_mkdirat (fs/namei.c:4336)
  [   37.340465] __x64_sys_mkdir (fs/namei.c:4354)
  [   37.341455] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
  [   37.342447] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Fix this by simply swapping the sequence of these two calls in
v9fs_vfs_mkdir_dotl(), i.e. calling v9fs_set_create_acl() before
v9fs_fid_add().

Fixes: dafbe689736f ("9p fid refcount: cleanup p9_fid_put calls")
Reported-by: syzbot+5b667f9a1fee4ba3775a@syzkaller.appspotmail.com
Signed-off-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Message-ID: <E1tsiI6-002iMG-Kh@kylie.crudebyte.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_inode_dotl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 143ac03b7425c..3397939fd2d5a 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -407,8 +407,8 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 			 err);
 		goto error;
 	}
-	v9fs_fid_add(dentry, &fid);
 	v9fs_set_create_acl(inode, fid, dacl, pacl);
+	v9fs_fid_add(dentry, &fid);
 	d_instantiate(dentry, inode);
 	err = 0;
 	inc_nlink(dir);
-- 
2.39.5




