Return-Path: <stable+bounces-169475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233D7B257E6
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 01:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2144356644F
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 23:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637912FC89D;
	Wed, 13 Aug 2025 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="CGZN+wLh"
X-Original-To: stable@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B76A27462
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129344; cv=none; b=CNmjETxZ4KkvUpZW6XKhbGLKHeA4WhzGc646+kh7UWKklcRAnZL12VUQX5+oGn6vVBsc35NAXQvm8Tiup+cc40+DHpDadDEMgAHSvo0wTD8yQ9ot9ED6axW9zNO5D7oqqOIimq8ah7u9mOZEZGJUTfuqJMogQfZToPSI244Gzmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129344; c=relaxed/simple;
	bh=ID/XhcsZ1I9A4MuqTcwii6NkisXSNXT4PxssY0Mn0+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p720wzoBEfQzqNKzeZ5afc11CK85WzlhQQqGg8Agg572of+Ir2+eqmZmpCz5KQLhorEFgBNNmkwgvL7CM+44YQKvHBVePvmES4m82YeZ4Wbu96Lx3X4REPM8Fu6CbzoKL007xFNMTFrs4aTNR31AzP1JIPGcC6rdRPi+BodgHMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=CGZN+wLh; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C5263240103
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 01:55:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1755129340;
	bh=IYHIn5JSU8VSd8NOfCAC/zA9MrgSiWojfu5wlTp5OM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:From;
	b=CGZN+wLhF/1CoNyu5CkBaE5nYQRH8dY/Pb/6ygSZY+UbRbZUDvv/WL4oj3IKjnZc5
	 x4y6d9lftGqmNUB7pNoIR4zQ2d96PHsGf3UuWI+OuTaK1e05BwNMu98AjWQDjb00eJ
	 h5+FiD9G6Z9M5GQv20jhx7UxcXUdjPf5nKupItrTi5NZaziR3Ssz3hcCpTO9ZwwJ0u
	 YoyHb5fihVQGEMixMlOEKBW88siexNrt1QZjoXQHubuaExvM404wese4cGNnr0mU4X
	 Xi5hwzRcATq552ZlEqlgOTxqpRQtKZNkzW0YwKuB67boPH5o6KpBWsyHvKTdqusjC3
	 I2It8BR3fROTyDkkkgdH8U0j3eJvbNvOK5DTXsyaOU4TZbqFavuqBToodhYU/OvZqf
	 vkG8hUB9nYf1Vge+P+04UaO9fS7BZvbzfZ/bLFofoPIl26AQHPYN3jMMWOuWH6Ffcz
	 UePc6A6rhUKnKhW4rbYEzBQfNl8xFnZaYbtKOIS/Ym+zv8AK0Ld
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4c2QHH6HMgz9rxB;
	Thu, 14 Aug 2025 01:55:39 +0200 (CEST)
From: Charalampos Mitrodimas <charmitro@posteo.net>
Date: Wed, 13 Aug 2025 23:55:40 +0000
Subject: [PATCH v2] debugfs: fix mount options not being applied
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-debugfs-mount-opts-v2-1-0ca79720edc6@posteo.net>
X-B4-Tracking: v=1; b=H4sIAPAlnWgC/32NTQ6DIBBGr2Jm3WmASLFdeY/GhT+DsigYBk0bw
 91LPUCX7yXf+w5gio4YHtUBkXbHLvgC6lLBuPR+JnRTYVBCadGIGicattkyvsLmE4Y1Mar+1kz
 G1NIKDWW4RrLufUafXeHFcQrxc37s8mf/5naJEodR6Htt+kYMul0DJwpXTwm6nPMXX9NVN7UAA
 AA=
X-Change-ID: 20250804-debugfs-mount-opts-2a68d7741f05
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
 Eric Sandeen <sandeen@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Charalampos Mitrodimas <charmitro@posteo.net>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755129339; l=2895;
 i=charmitro@posteo.net; s=20250727; h=from:subject:message-id;
 bh=ID/XhcsZ1I9A4MuqTcwii6NkisXSNXT4PxssY0Mn0+c=;
 b=dZJVD0srAHdSEDZDm3EWOOOs5F4h9CiKbhDcW5oNz7T3pf4qAoMFbiFKMGiOpVeesWmcaNWE2
 EBuMvHrR/JIDt1gzwNH21NNB8XfuJZEj3kIHGuwr7sLD0+0tiAn4TDt
X-Developer-Key: i=charmitro@posteo.net; a=ed25519;
 pk=/tpM70o3uGkbo2oePEdVimUYLyVTgpnPq4nwoG0pFsM=

Mount options (uid, gid, mode) are silently ignored when debugfs is
mounted. This is a regression introduced during the conversion to the
new mount API.

When the mount API conversion was done, the line that sets
sb->s_fs_info to the parsed options was removed. This causes
debugfs_apply_options() to operate on a NULL pointer.

Fix this by following the same pattern as the tracefs fix in commit
e4d32142d1de ("tracing: Fix tracefs mount options"). Call
debugfs_reconfigure() in debugfs_get_tree() to apply the mount options
to the superblock after it has been created or reused.

As an example, with the bug the "mode" mount option is ignored:

  $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
  $ mount | grep debugfs_test
  debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
  $ ls -ld /tmp/debugfs_test
  drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test

With the fix applied, it works as expected:

  $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
  $ mount | grep debugfs_test
  debugfs on /tmp/debugfs_test type debugfs (rw,relatime,mode=666)
  $ ls -ld /tmp/debugfs_test
  drw-rw-rw- 37 root root 0 Aug  2 17:28 /tmp/debugfs_test

Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220406
Cc: stable@vger.kernel.org
Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
Changes in v2:
- Follow the same pattern as e4d32142d1de ("tracing: Fix tracefs mount options")
- Add Cc: stable tag
- Link to v1: https://lore.kernel.org/r/20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net
---
 fs/debugfs/inode.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index a0357b0cf362d8ac47ff810e162402d6a8ae2cb9..c12d649df6a5435050f606c2828a9a7cc61922e4 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -183,6 +183,9 @@ static int debugfs_reconfigure(struct fs_context *fc)
 	struct debugfs_fs_info *sb_opts = sb->s_fs_info;
 	struct debugfs_fs_info *new_opts = fc->s_fs_info;
 
+	if (!new_opts)
+		return 0;
+
 	sync_filesystem(sb);
 
 	/* structure copy of new mount options to sb */
@@ -282,10 +285,16 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int debugfs_get_tree(struct fs_context *fc)
 {
+	int err;
+
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
 		return -EPERM;
 
-	return get_tree_single(fc, debugfs_fill_super);
+	err = get_tree_single(fc, debugfs_fill_super);
+	if (err)
+		return err;
+
+	return debugfs_reconfigure(fc);
 }
 
 static void debugfs_free_fc(struct fs_context *fc)

---
base-commit: 3c4a063b1f8ab71352df1421d9668521acb63cd9
change-id: 20250804-debugfs-mount-opts-2a68d7741f05

Best regards,
-- 
Charalampos Mitrodimas <charmitro@posteo.net>


