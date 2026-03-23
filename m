Return-Path: <stable+bounces-228656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPvTDP1NwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:28:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D8E2F48D8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 188EC301E72A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4F837E2FC;
	Mon, 23 Mar 2026 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sYZyhMVH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE75199FAB;
	Mon, 23 Mar 2026 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275733; cv=none; b=SNFvW4Q/9LRz4/wZE7BBmqQvHBbNR7cX7Dgvn8KDun/p3FpkDRLxmnZIFVt9VEChQFmeFAVmdp/TWOx0s19Q4x8/jQbeyP9mfyOHRR/RWxLT14UWQ3dUuP5XEGYxw/fuTY9SwOWjlKV/QaNjasA+d6ywiqAPHty/rRkq+lATHC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275733; c=relaxed/simple;
	bh=KK2hKtzacJxl90A4ZrwFTujzcSC5hi8lMHtDCYTtqFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/6sXBOaVBw0xPCTxc0QS+eCBxGiAyqQZh6AplVBQY2nTiwa5yYxYl2dDPLGL7ZMHpr4E2rlWT6ktMsXchB4ikx6SZuDZ+prrGNZhdYHN2LjQkVpGrF6myGXoc07AqQeXOhgkOraaSzPzWZjh6WarQz6iKPx9yQfAa+cD7STJp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sYZyhMVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982AFC4CEF7;
	Mon, 23 Mar 2026 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774275733;
	bh=KK2hKtzacJxl90A4ZrwFTujzcSC5hi8lMHtDCYTtqFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYZyhMVH2M00iurBdRm4l8bI4OhW0DkmxQr96HoV7Iqjlnf0TOAi1qQD/GmM/veoD
	 43kRiNMurDe5k1hKYqlpH4FuFE/jWi9olbAUiOqpm1sjm30M35VNkvxCpfzJQLqEft
	 iiAr9MYwT61O6VDkN9izKBC2GdoY9bJ97TX1VVyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.12 201/460] btrfs: fix transaction abort on set received ioctl due to item overflow
Date: Mon, 23 Mar 2026 14:43:17 +0100
Message-ID: <20260323134531.477528176@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228656-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 45D8E2F48D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 87f2c46003fce4d739138aab4af1942b1afdadac upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ioctl.c     |   21 +++++++++++++++++++--
 fs/btrfs/uuid-tree.c |   38 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/uuid-tree.h |    2 ++
 3 files changed, 59 insertions(+), 2 deletions(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4097,6 +4097,25 @@ static long _btrfs_ioctl_set_received_su
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
@@ -4112,8 +4131,6 @@ static long _btrfs_ioctl_set_received_su
 	sa->rtime.sec = ct.tv_sec;
 	sa->rtime.nsec = ct.tv_nsec;
 
-	received_uuid_changed = memcmp(root_item->received_uuid, sa->uuid,
-				       BTRFS_UUID_SIZE);
 	if (received_uuid_changed &&
 	    !btrfs_is_empty_uuid(root_item->received_uuid)) {
 		ret = btrfs_uuid_tree_remove(trans, root_item->received_uuid,
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -229,6 +229,44 @@ out:
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
--- a/fs/btrfs/uuid-tree.h
+++ b/fs/btrfs/uuid-tree.h
@@ -12,6 +12,8 @@ int btrfs_uuid_tree_add(struct btrfs_tra
 			u64 subid);
 int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, const u8 *uuid, u8 type,
 			u64 subid);
+int btrfs_uuid_tree_check_overflow(struct btrfs_fs_info *fs_info,
+				   const u8 *uuid, u8 type);
 int btrfs_uuid_tree_iterate(struct btrfs_fs_info *fs_info);
 int btrfs_create_uuid_tree(struct btrfs_fs_info *fs_info);
 int btrfs_uuid_scan_kthread(void *data);



