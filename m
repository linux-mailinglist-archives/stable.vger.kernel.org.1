Return-Path: <stable+bounces-227402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNO/NQiSvGlU0gIAu9opvQ
	(envelope-from <stable+bounces-227402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 01:17:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFF82D46D8
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 01:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEADC3014FC2
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 00:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24CE1D5CD1;
	Fri, 20 Mar 2026 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCo6WmQt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3464
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773965829; cv=none; b=l5/BMweX6pVvlv5q/UkkJtZpbgyvRPUpGm4u0pzKIQ8Pv/mOJiXv9bds1gHj1JOxCP2/trK8+nOJXOiNHueq/sjwPgnYb7uSM3KeJw1lhCfIlRAWhsccO90v4cy1tDEmMdtaiercCuJvyBOx9ZrMzNTZea1IGKrxgZ4GqnB6Cos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773965829; c=relaxed/simple;
	bh=DRvglRk+oxAw0Npov6pDPXquwHWxNWhJANBTNcgixfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTIsHfGu4B6vVp1V25DVTEWIUMHDc+2XLVkxnwpu/fkdNiIFh2qxCNkYN/iXED1PYPDJ3vWMY4myjdGIdswKvKVOB2gFZdC2npSzzMZOt2wKfn+34HhEuXtIPzh0USPIzH2w+pmA7tvHwBIzbn8hQ6Udevp3fX9NfB9Ztx49jLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCo6WmQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9758AC19424;
	Fri, 20 Mar 2026 00:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773965829;
	bh=DRvglRk+oxAw0Npov6pDPXquwHWxNWhJANBTNcgixfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCo6WmQtfAYBmCanW5bQbJvcsvAGd8+6zI7GV2KODnJIZuXkhNtop3QsdlpDULtG5
	 Yj+dUl5LS7eWK0TtkZpN4s2QcmZA/68oDAdKaa96+fMFEBKz70x5rpYG1MiLyTzsXA
	 P7DScXVNxf2VsCwlaJC670q6gk/KhDF8ubwxaZbo7iz4rNoT3UMoIOv3L7MS4IPYqm
	 ala0O8MZ36OLCUMFUnYmMiWRj3Zdw4xck8JvV3OiXVL86tfH5BwZ2KgPD3glrGTWiU
	 S6p50xy4ZeAfvbVHslxKfqhgqmxwHZF6D+vAXO1+Go6z/Ojm0iGyFxzjD08wjW1G60
	 b2vFc2NxfSwsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Anand Jain <asj@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] btrfs: fix transaction abort on set received ioctl due to item overflow
Date: Thu, 19 Mar 2026 20:17:04 -0400
Message-ID: <20260320001704.3248188-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031753-musket-tidiness-7d03@gregkh>
References: <2026031753-musket-tidiness-7d03@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227402-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BFF82D46D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 87f2c46003fce4d739138aab4af1942b1afdadac ]

If the set received ioctl fails due to an item overflow when attempting to
add the BTRFS_UUID_KEY_RECEIVED_SUBVOL we have to abort the transaction
since we did some metadata updates before.

This means that if a user calls this ioctl with the same received UUID
field for a lot of subvolumes, we will hit the overflow, trigger the
transaction abort and turn the filesystem into RO mode. A malicious user
could exploit this, and this ioctl does not even requires that a user
has admin privileges (CAP_SYS_ADMIN), only that he/she owns the subvolume.

Fix this by doing an early check for item overflow before starting a
transaction. This is also race safe because we are holding the subvol_sem
semaphore in exclusive (write) mode.

A test case for fstests will follow soon.

Fixes: dd5f9615fc5c ("Btrfs: maintain subvolume items in the UUID tree")
CC: stable@vger.kernel.org # 3.12+
Reviewed-by: Anand Jain <asj@kernel.org>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ A whole bunch of small things :) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.h     |  2 ++
 fs/btrfs/ioctl.c     | 21 ++++++++++++++++++--
 fs/btrfs/uuid-tree.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a9926fb10c491..15affee7c6d11 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2869,6 +2869,8 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 			u64 subid);
 int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 			u64 subid);
+int btrfs_uuid_tree_check_overflow(struct btrfs_fs_info *fs_info,
+				   u8 *uuid, u8 type);
 int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info);
 
 /* dir-item.c */
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4a35d51dfef8a..7889745eb5c8a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4486,6 +4486,25 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 		goto out;
 	}
 
+	received_uuid_changed = memcmp(root_item->received_uuid, sa->uuid,
+				       BTRFS_UUID_SIZE);
+
+	/*
+	 * Before we attempt to add the new received uuid, check if we have room
+	 * for it in case there's already an item. If the size of the existing
+	 * item plus this root's ID (u64) exceeds the maximum item size, we can
+	 * return here without the need to abort a transaction. If we don't do
+	 * this check, the btrfs_uuid_tree_add() call below would fail with
+	 * -EOVERFLOW and result in a transaction abort. Malicious users could
+	 * exploit this to turn the fs into RO mode.
+	 */
+	if (received_uuid_changed && !btrfs_is_empty_uuid(sa->uuid)) {
+		ret = btrfs_uuid_tree_check_overflow(fs_info, sa->uuid,
+						     BTRFS_UUID_KEY_RECEIVED_SUBVOL);
+		if (ret < 0)
+			goto out;
+	}
+
 	/*
 	 * 1 - root item
 	 * 2 - uuid items (received uuid + subvol uuid)
@@ -4501,8 +4520,6 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	sa->rtime.sec = ct.tv_sec;
 	sa->rtime.nsec = ct.tv_nsec;
 
-	received_uuid_changed = memcmp(root_item->received_uuid, sa->uuid,
-				       BTRFS_UUID_SIZE);
 	if (received_uuid_changed &&
 	    !btrfs_is_empty_uuid(root_item->received_uuid)) {
 		ret = btrfs_uuid_tree_remove(trans, root_item->received_uuid,
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 28525ad7ff8cb..aee89c7293f65 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -226,6 +226,52 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 	return ret;
 }
 
+/*
+ * Check if we can add one root ID to a UUID key.
+ * If the key does not yet exists, we can, otherwise only if extended item does
+ * not exceeds the maximum item size permitted by the leaf size.
+ *
+ * Returns 0 on success, negative value on error.
+ */
+int btrfs_uuid_tree_check_overflow(struct btrfs_fs_info *fs_info,
+				   u8 *uuid, u8 type)
+{
+	struct btrfs_path *path = NULL;
+	int ret;
+	u32 item_size;
+	struct btrfs_key key;
+
+	if (WARN_ON_ONCE(!fs_info->uuid_root)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	btrfs_uuid_to_key(uuid, type, &key);
+	ret = btrfs_search_slot(NULL, fs_info->uuid_root, &key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+	if (ret > 0) {
+		ret = 0;
+		goto out;
+	}
+
+	item_size = btrfs_item_size(path->nodes[0], path->slots[0]);
+
+	if (sizeof(struct btrfs_item) + item_size + sizeof(u64) >
+	    BTRFS_LEAF_DATA_SIZE(fs_info))
+		ret = -EOVERFLOW;
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 static int btrfs_uuid_iter_rem(struct btrfs_root *uuid_root, u8 *uuid, u8 type,
 			       u64 subid)
 {
-- 
2.51.0


