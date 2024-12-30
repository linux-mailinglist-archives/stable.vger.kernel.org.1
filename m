Return-Path: <stable+bounces-106260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C649FE3C1
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 09:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC457161B8A
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 08:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445211A08B8;
	Mon, 30 Dec 2024 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ki2T/Oov"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F491A0B06
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735547918; cv=none; b=dvjLOxjG6ea4F5H5lAtlJSo/35EV/fmCbkWVtDfvoJbfYD5CcqL6oOiyCQu2wAerJ/otYiMojlEn+i4ehKmTifkFVB7658BoAye8H+TQrvrqwnoRue85b0XfJoZCSppwZx4HUMkABcslR3B7vyk2lzFev2sNoWebkuAOx5XYt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735547918; c=relaxed/simple;
	bh=hujzbWXcTDkR+FVxYccHv7/rkcHz8CCXVUnPL5r3oOs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O1MbwdgStP1Th0FsdlRMXMUaaSoMHNo+LjEHiU6SzompnRLiHXwakQ1HzOOMIzYFZlU+UKbLQtHJMsTJfuCr/HWPWDjPJNqUpdkrbNTOvQZ/HzVipCnc7poQfzgONU0hm/JfnPXadOV3GZ2HQy8eVrmRhfPd5XzPSzrEo+8m1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ki2T/Oov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9D7C4CED0;
	Mon, 30 Dec 2024 08:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735547917;
	bh=hujzbWXcTDkR+FVxYccHv7/rkcHz8CCXVUnPL5r3oOs=;
	h=Subject:To:Cc:From:Date:From;
	b=ki2T/Oov5KE0NWq1bzpzyW25CuoD6w0725QsUrW84yj+1KQKJM0Xh/WBiB0wugQbH
	 qk4rbiW5qPIiIyEjdQYBb+dYMCAw5REY88ZAawpz6BMNe4kFcDRn/6ZbZHt6DQzVEW
	 9AwpTXCzibpflfBu1VsqNUpDYsP+5bV8sAi+PDYg=
Subject: FAILED: patch "[PATCH] btrfs: fix transaction atomicity bug when enabling simple" failed to apply to 6.6-stable tree
To: sunjunchao2870@gmail.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Dec 2024 09:38:35 +0100
Message-ID: <2024123034-luxury-clumsily-dce2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f2363e6fcc7938c5f0f6ac066fad0dd247598b51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024123034-luxury-clumsily-dce2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2363e6fcc7938c5f0f6ac066fad0dd247598b51 Mon Sep 17 00:00:00 2001
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Wed, 11 Dec 2024 19:13:15 +0800
Subject: [PATCH] btrfs: fix transaction atomicity bug when enabling simple
 quotas

Set squota incompat bit before committing the transaction that enables
the feature.

With the config CONFIG_BTRFS_ASSERT enabled, an assertion
failure occurs regarding the simple quota feature.

  [5.596534] assertion failed: btrfs_fs_incompat(fs_info, SIMPLE_QUOTA), in fs/btrfs/qgroup.c:365
  [5.597098] ------------[ cut here ]------------
  [5.597371] kernel BUG at fs/btrfs/qgroup.c:365!
  [5.597946] CPU: 1 UID: 0 PID: 268 Comm: mount Not tainted 6.13.0-rc2-00031-gf92f4749861b #146
  [5.598450] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
  [5.599008] RIP: 0010:btrfs_read_qgroup_config+0x74d/0x7a0
  [5.604303]  <TASK>
  [5.605230]  ? btrfs_read_qgroup_config+0x74d/0x7a0
  [5.605538]  ? exc_invalid_op+0x56/0x70
  [5.605775]  ? btrfs_read_qgroup_config+0x74d/0x7a0
  [5.606066]  ? asm_exc_invalid_op+0x1f/0x30
  [5.606441]  ? btrfs_read_qgroup_config+0x74d/0x7a0
  [5.606741]  ? btrfs_read_qgroup_config+0x74d/0x7a0
  [5.607038]  ? try_to_wake_up+0x317/0x760
  [5.607286]  open_ctree+0xd9c/0x1710
  [5.607509]  btrfs_get_tree+0x58a/0x7e0
  [5.608002]  vfs_get_tree+0x2e/0x100
  [5.608224]  fc_mount+0x16/0x60
  [5.608420]  btrfs_get_tree+0x2f8/0x7e0
  [5.608897]  vfs_get_tree+0x2e/0x100
  [5.609121]  path_mount+0x4c8/0xbc0
  [5.609538]  __x64_sys_mount+0x10d/0x150

The issue can be easily reproduced using the following reproducer:

  root@q:linux# cat repro.sh
  set -e

  mkfs.btrfs -q -f /dev/sdb
  mount /dev/sdb /mnt/btrfs
  btrfs quota enable -s /mnt/btrfs
  umount /mnt/btrfs
  mount /dev/sdb /mnt/btrfs

The issue is that when enabling quotas, at btrfs_quota_enable(), we set
BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE at fs_info->qgroup_flags and persist
it in the quota root in the item with the key BTRFS_QGROUP_STATUS_KEY, but
we only set the incompat bit BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA after we
commit the transaction used to enable simple quotas.

This means that if after that transaction commit we unmount the filesystem
without starting and committing any other transaction, or we have a power
failure, the next time we mount the filesystem we will find the flag
BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE set in the item with the key
BTRFS_QGROUP_STATUS_KEY but we will not find the incompat bit
BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA set in the superblock, triggering an
assertion failure at:

  btrfs_read_qgroup_config() -> qgroup_read_enable_gen()

To fix this issue, set the BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA flag
immediately after setting the BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE.
This ensures that both flags are flushed to disk within the same
transaction.

Fixes: 182940f4f4db ("btrfs: qgroup: add new quota mode for simple quotas")
CC: stable@vger.kernel.org # 6.6+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a6f92836c9b1..f9b214992212 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1121,6 +1121,7 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	fs_info->qgroup_flags = BTRFS_QGROUP_STATUS_FLAG_ON;
 	if (simple) {
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_SIMPLE_MODE;
+		btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
 		btrfs_set_qgroup_status_enable_gen(leaf, ptr, trans->transid);
 	} else {
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
@@ -1254,8 +1255,6 @@ int btrfs_quota_enable(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->qgroup_lock);
 	fs_info->quota_root = quota_root;
 	set_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags);
-	if (simple)
-		btrfs_set_fs_incompat(fs_info, SIMPLE_QUOTA);
 	spin_unlock(&fs_info->qgroup_lock);
 
 	/* Skip rescan for simple qgroups. */


