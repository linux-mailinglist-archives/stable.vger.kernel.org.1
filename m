Return-Path: <stable+bounces-228938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AvPAG1XwWmBSQQAu9opvQ
	(envelope-from <stable+bounces-228938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:08:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0C12F5D6B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8427E3096099
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5017A3AE6E1;
	Mon, 23 Mar 2026 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lFZX6bYf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1189E23B62C;
	Mon, 23 Mar 2026 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277545; cv=none; b=leQsY/mNJdQ/8sjfC0xfGn/PZRuXxbtJd2cyvhY1LeiaFwdXQ0Lcq0JKY2hAM9g+0ftmV3oLsNE3GrNbNLw9bbO2SZoTMRCX8bSAkiD7eOo/ur9tzG7encnRBSWmxC/p9DLedth+E+R9R+FeOPNP9g9kvIxLiNuJpjGZnHP9/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277545; c=relaxed/simple;
	bh=9DwxnOcl1VdT6xIUCLsqeez4/BkOKQwG15PPWsIoo/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KX1jdocKZehOYZfA6SLHRkUcsueTDkmf3HXwlwL7P5FQ717LQA8X+DYdNyBsbWitTiPE06rsg8hyjQmAZqRrnljTKLCIO5cTBVvdcBVH0nJom8y5OKP5Bdynh3MXcdUCG7BewHuDGvsz5uIDtWwM0EJIwYNrPYxx4qya547qtL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lFZX6bYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88634C4CEF7;
	Mon, 23 Mar 2026 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277544;
	bh=9DwxnOcl1VdT6xIUCLsqeez4/BkOKQwG15PPWsIoo/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lFZX6bYfwGLdNzzshxWpmh6y2UPm17JtTSvkFxC3nfdynoncSFNhd25fUPpTfcnqq
	 JifvHHxYo8IWqa7FGL7wQe4oMSjqUBwXDV1cMAoVeMHShhG52hhqFd7P1EWkff/7hw
	 NMfn0draPNcm9JqaVtTUmmCNto54E5mCy4OU0mIs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 019/567] btrfs: read raid stripe tree from disk
Date: Mon, 23 Mar 2026 14:38:59 +0100
Message-ID: <20260323134534.243214873@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228938-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8D0C12F5D6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit 515020900d447796bc2f0f57064663617a11b65d ]

If we find the raid-stripe-tree on mount, read it from disk. This is
a backward incompatible feature. The rescue=ignorebadroots mount option
will skip this tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 511dc8912ae3 ("btrfs: fix incorrect key offset in error message in check_dev_extent_item()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-rsv.c       |  6 ++++++
 fs/btrfs/disk-io.c         | 18 ++++++++++++++++++
 fs/btrfs/fs.h              |  1 +
 include/uapi/linux/btrfs.h |  1 +
 4 files changed, 26 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 97084ea3af0cc..07bf07431a7f4 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -354,6 +354,11 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 		min_items++;
 	}
 
+	if (btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE)) {
+		num_bytes += btrfs_root_used(&fs_info->stripe_root->root_item);
+		min_items++;
+	}
+
 	/*
 	 * But we also want to reserve enough space so we can do the fallback
 	 * global reserve for an unlink, which is an additional
@@ -405,6 +410,7 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
 	case BTRFS_EXTENT_TREE_OBJECTID:
 	case BTRFS_FREE_SPACE_TREE_OBJECTID:
 	case BTRFS_BLOCK_GROUP_TREE_OBJECTID:
+	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
 		root->block_rsv = &fs_info->delayed_refs_rsv;
 		break;
 	case BTRFS_ROOT_TREE_OBJECTID:
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3c26e91a8055f..89e98f9cc2026 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1179,6 +1179,8 @@ static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
 		return btrfs_grab_root(fs_info->block_group_root);
 	case BTRFS_FREE_SPACE_TREE_OBJECTID:
 		return btrfs_grab_root(btrfs_global_root(fs_info, &key));
+	case BTRFS_RAID_STRIPE_TREE_OBJECTID:
+		return btrfs_grab_root(fs_info->stripe_root);
 	default:
 		return NULL;
 	}
@@ -1259,6 +1261,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_put_root(fs_info->fs_root);
 	btrfs_put_root(fs_info->data_reloc_root);
 	btrfs_put_root(fs_info->block_group_root);
+	btrfs_put_root(fs_info->stripe_root);
 	btrfs_check_leaked_roots(fs_info);
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
@@ -1812,6 +1815,7 @@ static void free_root_pointers(struct btrfs_fs_info *info, bool free_chunk_root)
 	free_root_extent_buffers(info->fs_root);
 	free_root_extent_buffers(info->data_reloc_root);
 	free_root_extent_buffers(info->block_group_root);
+	free_root_extent_buffers(info->stripe_root);
 	if (free_chunk_root)
 		free_root_extent_buffers(info->chunk_root);
 }
@@ -2287,6 +2291,20 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
 		fs_info->uuid_root = root;
 	}
 
+	if (btrfs_fs_incompat(fs_info, RAID_STRIPE_TREE)) {
+		location.objectid = BTRFS_RAID_STRIPE_TREE_OBJECTID;
+		root = btrfs_read_tree_root(tree_root, &location);
+		if (IS_ERR(root)) {
+			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
+				ret = PTR_ERR(root);
+				goto out;
+			}
+		} else {
+			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
+			fs_info->stripe_root = root;
+		}
+	}
+
 	return 0;
 out:
 	btrfs_warn(fs_info, "failed to read root (objectid=%llu): %d",
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index d24d41f7811a6..b8b9ce8921baf 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -371,6 +371,7 @@ struct btrfs_fs_info {
 	struct btrfs_root *uuid_root;
 	struct btrfs_root *data_reloc_root;
 	struct btrfs_root *block_group_root;
+	struct btrfs_root *stripe_root;
 
 	/* The log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 6f776faaa791c..7b499b90bb779 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -333,6 +333,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
 #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
+#define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.51.0




