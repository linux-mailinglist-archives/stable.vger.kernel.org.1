Return-Path: <stable+bounces-101146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2079EEB10
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B557516BBF9
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7D9217707;
	Thu, 12 Dec 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lylv3tdq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745821577D;
	Thu, 12 Dec 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016518; cv=none; b=ahNgBt4ug6f+aWN1ut8NHooIzT77wmngKSmt7n8gN0ljr7CVEUtBlUM3fuVVEJQVMAytk5t6/5cVC2YuFHr+lUh0v3fdfHwXZnq5nOqxwrfKtR7cHkFT4iJ9797BFdfqWLPXdymrEf+UH8Eyc03NvTdkfS59mETi+mWSyREl4mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016518; c=relaxed/simple;
	bh=aOeU6W5tXDwkIGcn5ozMgkar1XMew8EvT/WRYcpx/eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9V4T1bBjk6vAoh8Hxeg2UV6K5+PMGkSfMvICQTe6z+WdmWY9Wf6GKKAp2HPWtoBQlivV8/hWtldOyTUrERNmpkab7MCPmeKPOaz8MNjwQo6wxkF4I+HeoeYSbhUm/nCo8lrPt6XxU6dWA1S4qq54/9C4vb/3l+jt4ySTgMXbeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lylv3tdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4D4C4CECE;
	Thu, 12 Dec 2024 15:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734016518;
	bh=aOeU6W5tXDwkIGcn5ozMgkar1XMew8EvT/WRYcpx/eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lylv3tdqpXU9XMNlc97/Rm958SNyBucKEaYDysFVvWjA7mliAopFj/P7vEC2kNolh
	 icNnPnSG+wUXcgxXfPwLllovRhZIv17Xag5twuxCBxHmxDsSc5zbRKdQ3vkyvKnCQ6
	 Fjw+y0ErB/kzKjEAGjooVM/FU0MfXP2AKLMSiYXg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	Fabian Vogt <fvogt@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 220/466] btrfs: avoid unnecessary device path update for the same device
Date: Thu, 12 Dec 2024 15:56:29 +0100
Message-ID: <20241212144315.478043501@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 2e8b6bc0ab41ce41e6dfcc204b6cc01d5abbc952 ]

[PROBLEM]
It is very common for udev to trigger device scan, and every time a
mounted btrfs device got re-scan from different soft links, we will get
some of unnecessary device path updates, this is especially common
for LVM based storage:

 # lvs
  scratch1 test -wi-ao---- 10.00g
  scratch2 test -wi-a----- 10.00g
  scratch3 test -wi-a----- 10.00g
  scratch4 test -wi-a----- 10.00g
  scratch5 test -wi-a----- 10.00g
  test     test -wi-a----- 10.00g

 # mkfs.btrfs -f /dev/test/scratch1
 # mount /dev/test/scratch1 /mnt/btrfs
 # dmesg -c
 [  205.705234] BTRFS: device fsid 7be2602f-9e35-4ecf-a6ff-9e91d2c182c9 devid 1 transid 6 /dev/mapper/test-scratch1 (253:4) scanned by mount (1154)
 [  205.710864] BTRFS info (device dm-4): first mount of filesystem 7be2602f-9e35-4ecf-a6ff-9e91d2c182c9
 [  205.711923] BTRFS info (device dm-4): using crc32c (crc32c-intel) checksum algorithm
 [  205.713856] BTRFS info (device dm-4): using free-space-tree
 [  205.722324] BTRFS info (device dm-4): checking UUID tree

So far so good, but even if we just touched any soft link of
"dm-4", we will get quite some unnecessary device path updates.

 # touch /dev/mapper/test-scratch1
 # dmesg -c
 [  469.295796] BTRFS info: devid 1 device path /dev/mapper/test-scratch1 changed to /dev/dm-4 scanned by (udev-worker) (1221)
 [  469.300494] BTRFS info: devid 1 device path /dev/dm-4 changed to /dev/mapper/test-scratch1 scanned by (udev-worker) (1221)

Such device path rename is unnecessary and can lead to random path
change due to the udev race.

[CAUSE]
Inside device_list_add(), we are using a very primitive way checking if
the device has changed, strcmp().

Which can never handle links well, no matter if it's hard or soft links.

So every different link of the same device will be treated as a different
device, causing the unnecessary device path update.

[FIX]
Introduce a helper, is_same_device(), and use path_equal() to properly
detect the same block device.
So that the different soft links won't trigger the rename race.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1230641
Reported-by: Fabian Vogt <fvogt@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/volumes.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 920df7585b0d1..5e75a4e3a5be5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -732,6 +732,42 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb)
 	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
 }
 
+static bool is_same_device(struct btrfs_device *device, const char *new_path)
+{
+	struct path old = { .mnt = NULL, .dentry = NULL };
+	struct path new = { .mnt = NULL, .dentry = NULL };
+	char *old_path = NULL;
+	bool is_same = false;
+	int ret;
+
+	if (!device->name)
+		goto out;
+
+	old_path = kzalloc(PATH_MAX, GFP_NOFS);
+	if (!old_path)
+		goto out;
+
+	rcu_read_lock();
+	ret = strscpy(old_path, rcu_str_deref(device->name), PATH_MAX);
+	rcu_read_unlock();
+	if (ret < 0)
+		goto out;
+
+	ret = kern_path(old_path, LOOKUP_FOLLOW, &old);
+	if (ret)
+		goto out;
+	ret = kern_path(new_path, LOOKUP_FOLLOW, &new);
+	if (ret)
+		goto out;
+	if (path_equal(&old, &new))
+		is_same = true;
+out:
+	kfree(old_path);
+	path_put(&old);
+	path_put(&new);
+	return is_same;
+}
+
 /*
  * Add new device to list of registered devices
  *
@@ -852,7 +888,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				MAJOR(path_devt), MINOR(path_devt),
 				current->comm, task_pid_nr(current));
 
-	} else if (!device->name || strcmp(device->name->str, path)) {
+	} else if (!device->name || !is_same_device(device, path)) {
 		/*
 		 * When FS is already mounted.
 		 * 1. If you are here and if the device->name is NULL that
-- 
2.43.0




