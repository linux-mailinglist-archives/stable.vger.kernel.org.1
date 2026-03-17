Return-Path: <stable+bounces-226009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N/HDiVVuWnYAgIAu9opvQ
	(envelope-from <stable+bounces-226009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:20:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2402AABB5
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 878E230610C7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E9A3CB2C1;
	Tue, 17 Mar 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rg94zJm6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C01DF723
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753436; cv=none; b=cK/GHRSVyonztr6QpdX5qRLCoHUZeZIEwlfnffSPTsUYRW67NRY1mBQM3QJCEDLNL2fdudaE8Ila6a61FvJnkWKGhs3g0krEeBE05NG4pZjKJECcVv/xIGBBkXqSqPOCHCA74T3app2Puwx0CN8FfxhXw+9wgF9LSzjySGoaht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753436; c=relaxed/simple;
	bh=0eylARGPPzwR8oiF3ShwJq77mfiE8PJSl7CrsbO1ym0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LDtAK6ZWDOK1fK+IZGA2j2RYnHclGmn8+NmKBFrvBnORUaaLuORwXz+9WVk83NVlm0Q21YlEiXF7OYko3xxX5/NKnwRFMGLBO68P/ZqKx3j2uKTCFnDFoodZ1mf7dDf1FXAGj1K6N+hU7BwT1nVP1cqN+V15UWIDEMofEG+k8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rg94zJm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAD5C4CEF7;
	Tue, 17 Mar 2026 13:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773753436;
	bh=0eylARGPPzwR8oiF3ShwJq77mfiE8PJSl7CrsbO1ym0=;
	h=Subject:To:Cc:From:Date:From;
	b=Rg94zJm6hXLNSGwnOnvGAYSCpMBW/DzYLuGmmRoz8fHBRNqBK0IHVjMQXKKuBxyNe
	 9BmsJ8HpIWJ4WPAsKIZIUJoYOr3qJkqxUVaBwXvKsUMLKyS+rjkBREXYlRPcab/Dv0
	 UBHjMjDVPgT2gynfYX2SC/2qfAZMQnTVM0EbBQ2M=
Subject: FAILED: patch "[PATCH] btrfs: fix transaction abort on set received ioctl due to" failed to apply to 6.6-stable tree
To: fdmanana@suse.com,asj@kernel.org,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 14:15:08 +0100
Message-ID: <2026031708-makeover-flaccid-62b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226009-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 9A2402AABB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 87f2c46003fce4d739138aab4af1942b1afdadac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031708-makeover-flaccid-62b2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87f2c46003fce4d739138aab4af1942b1afdadac Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Thu, 26 Feb 2026 23:41:07 +0000
Subject: [PATCH] btrfs: fix transaction abort on set received ioctl due to
 item overflow

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

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1d22c5c05b50..56d17eedaf90 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3929,6 +3929,25 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
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
@@ -3944,8 +3963,6 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	sa->rtime.sec = ct.tv_sec;
 	sa->rtime.nsec = ct.tv_nsec;
 
-	received_uuid_changed = memcmp(root_item->received_uuid, sa->uuid,
-				       BTRFS_UUID_SIZE);
 	if (received_uuid_changed &&
 	    !btrfs_is_empty_uuid(root_item->received_uuid)) {
 		ret = btrfs_uuid_tree_remove(trans, root_item->received_uuid,
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index f24c14b9bb2f..43c17a1d3451 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -199,6 +199,44 @@ int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8
 	return 0;
 }
 
+/*
+ * Check if we can add one root ID to a UUID key.
+ * If the key does not yet exists, we can, otherwise only if extended item does
+ * not exceeds the maximum item size permitted by the leaf size.
+ *
+ * Returns 0 on success, negative value on error.
+ */
+int btrfs_uuid_tree_check_overflow(struct btrfs_fs_info *fs_info,
+				   const u8 *uuid, u8 type)
+{
+	BTRFS_PATH_AUTO_FREE(path);
+	int ret;
+	u32 item_size;
+	struct btrfs_key key;
+
+	if (WARN_ON_ONCE(!fs_info->uuid_root))
+		return -EINVAL;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	btrfs_uuid_to_key(uuid, type, &key);
+	ret = btrfs_search_slot(NULL, fs_info->uuid_root, &key, path, 0, 0);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		return 0;
+
+	item_size = btrfs_item_size(path->nodes[0], path->slots[0]);
+
+	if (sizeof(struct btrfs_item) + item_size + sizeof(u64) >
+	    BTRFS_LEAF_DATA_SIZE(fs_info))
+		return -EOVERFLOW;
+
+	return 0;
+}
+
 static int btrfs_uuid_iter_rem(struct btrfs_root *uuid_root, u8 *uuid, u8 type,
 			       u64 subid)
 {
diff --git a/fs/btrfs/uuid-tree.h b/fs/btrfs/uuid-tree.h
index c60ad20325cc..02b235a3653f 100644
--- a/fs/btrfs/uuid-tree.h
+++ b/fs/btrfs/uuid-tree.h
@@ -12,6 +12,8 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, const u8 *uuid, u8 typ
 			u64 subid);
 int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8 type,
 			u64 subid);
+int btrfs_uuid_tree_check_overflow(struct btrfs_fs_info *fs_info,
+				   const u8 *uuid, u8 type);
 int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info);
 int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
 int btrfs_uuid_scan_kthread(void *data);


