Return-Path: <stable+bounces-255869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIurA9aoGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:43:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E855F963B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A28E314A369
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E318A2F8E88;
	Thu, 28 May 2026 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UFeeh1Bu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB15DDC5;
	Thu, 28 May 2026 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000105; cv=none; b=YGu+gT8Bo+kYfCiS5/QnoYYmMXQ+6JnicNcA1g0jkjaJw9AggEiPCV/X/sM01o+7/397tbM/0PPvQMICyt3Th03T5I/pyLlrMoaTdVf9XPHJ1P7b/aXJwTAKCVY9TWEURT0RRQoXwycSOBIQOHfJzHqZ290ljfpY25LrXl1Gj0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000105; c=relaxed/simple;
	bh=J0GFwJj4NzqFzYMNOd8QCsSKP28mWNczW7alQs/ZrdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/cxLSzwjE6Om5BzN/NbXebF/ktMJa0m7ixTZxfXyMnXDAqLuDf0hGuqCa+JIxIM6aLfEhPA8cu+feA0VAxKbf9NJtGU+51A6VWzrrOC+tTVSl1GzsTeUlsYPHnc/jRyptqLUd8K2zH7XrLNdCsCEU/LFLsrKfHoIFF+QgwX/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UFeeh1Bu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A70A1F000E9;
	Thu, 28 May 2026 20:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000104;
	bh=JEusPUpmA96RXDElESvr5tUVP54lDYlQMBZo93bcrYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UFeeh1BukS30RZ7628iGiu9C5a21b08KjyzBunQAo7PwX1lW8IFmN60bOFifPzB9O
	 IO9QedD1BlBT9/pWhbYOzMy/SrJx43uJNFX6tsmyj33VhKzMj0o1jM8GCWMIQ9z5Y/
	 7nQ5hnOvzmuwoV7eirxdok8JmfNBe6V4Ucfk67Gw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 303/377] btrfs: check for subvolume before deleting squota qgroup
Date: Thu, 28 May 2026 21:49:01 +0200
Message-ID: <20260528194647.134514861@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255869-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email]
X-Rspamd-Queue-Id: 74E855F963B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Burkov <boris@bur.io>

[ Upstream commit 1e92637722ae4bd417f7a37e8d1485dc23b93935 ]

The invariant that we want to maintain with subvolume qgroups is that
the qgroup can only be deleted if there is no root. With squotas, we
thought that it was sufficient to just check the usage, because we
assumed that deleting a subvolume will drive it's qgroups usage to 0,
and thus 0 usage implies no subvolume.

However, this is false, for two reasons:

- A subvol whose extents are all from before squotas was enabled.
- A subvol that was created in this transaction and for which we have
  not yet run any delayed refs.

In both cases, deleting the qgroup breaks the desired invariant and we
are left with a subvolume with no qgroup but squotas are enabled.

Fix this by unifying the deletion check logic between full qgroups and
squotas. Squotas do all the same checks *and* the additional usage == 0
check, which is the one extra rule peculiar to squotas.

Link: https://lore.kernel.org/linux-btrfs/adnBhWfJQ1n3hZC8@merlins.org/
Fixes: a8df35619948 ("btrfs: forbid deleting live subvol qgroup")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 50 +++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c7bc2065bcd68..a0d364e009d88 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1723,32 +1723,24 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	return ret;
 }
 
-static bool can_delete_parent_qgroup(struct btrfs_qgroup *qgroup)
-
+static bool can_delete_parent_qgroup(struct btrfs_fs_info *fs_info, struct btrfs_qgroup *qgroup)
 {
 	ASSERT(btrfs_qgroup_level(qgroup->qgroupid));
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		squota_check_parent_usage(fs_info, qgroup);
 	return list_empty(&qgroup->members);
 }
 
 /*
- * Return true if we can delete the squota qgroup and false otherwise.
- *
- * Rules for whether we can delete:
- *
- * A subvolume qgroup can be removed iff the subvolume is fully deleted, which
- * is iff there is 0 usage in the qgroup.
- *
- * A higher level qgroup can be removed iff it has no members.
- * Note: We audit its usage to warn on inconsitencies without blocking deletion.
+ * Because a shared extent can outlive its owning subvolume, we cannot delete a
+ * subvol squota qgroup until all of the extents it owns are gone, even if the
+ * subvolume itself has been deleted.
  */
-static bool can_delete_squota_qgroup(struct btrfs_fs_info *fs_info, struct btrfs_qgroup *qgroup)
+static bool can_delete_squota_subvol_qgroup(struct btrfs_fs_info *fs_info,
+					    struct btrfs_qgroup *qgroup)
 {
 	ASSERT(btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE);
-
-	if (btrfs_qgroup_level(qgroup->qgroupid) > 0) {
-		squota_check_parent_usage(fs_info, qgroup);
-		return can_delete_parent_qgroup(qgroup);
-	}
+	ASSERT(btrfs_qgroup_level(qgroup->qgroupid) == 0);
 
 	return !(qgroup->rfer || qgroup->excl || qgroup->rfer_cmpr || qgroup->excl_cmpr);
 }
@@ -1762,14 +1754,11 @@ static int can_delete_qgroup(struct btrfs_fs_info *fs_info, struct btrfs_qgroup
 {
 	struct btrfs_key key;
 	BTRFS_PATH_AUTO_FREE(path);
-
-	/* Since squotas cannot be inconsistent, they have special rules for deletion. */
-	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
-		return can_delete_squota_qgroup(fs_info, qgroup);
+	int ret;
 
 	/* For higher level qgroup, we can only delete it if it has no child. */
 	if (btrfs_qgroup_level(qgroup->qgroupid))
-		return can_delete_parent_qgroup(qgroup);
+		return can_delete_parent_qgroup(fs_info, qgroup);
 
 	/*
 	 * For level-0 qgroups, we can only delete it if it has no subvolume
@@ -1785,10 +1774,21 @@ static int can_delete_qgroup(struct btrfs_fs_info *fs_info, struct btrfs_qgroup
 		return -ENOMEM;
 
 	/*
-	 * The @ret from btrfs_find_root() exactly matches our definition for
-	 * the return value, thus can be returned directly.
+	 * Any subvol qgroup, regardless of mode, cannot be deleted if the
+	 * subvol still exists.
+	 */
+	ret = btrfs_find_root(fs_info->tree_root, &key, path, NULL, NULL);
+	/*
+	 * btrfs_find_root returns <0 on error, 0 if found, and >0 if not,
+	 * so the "found" and "error" cases match our desired return values.
 	 */
-	return btrfs_find_root(fs_info->tree_root, &key, path, NULL, NULL);
+	if (ret <= 0)
+		return ret;
+
+	/* Squotas require additional checks, even if the subvol is deleted. */
+	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
+		return can_delete_squota_subvol_qgroup(fs_info, qgroup);
+	return 1;
 }
 
 int btrfs_remove_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
-- 
2.53.0




