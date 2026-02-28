Return-Path: <stable+bounces-220127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDJTAzAqo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:47:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DBB1C519E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B416310EA75
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2124481256;
	Sat, 28 Feb 2026 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/m4Gzut"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7497748124C;
	Sat, 28 Feb 2026 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300037; cv=none; b=PPQTg+UhC54l7LjgAjz05tbKucA8UsVwK98AJIkHUUFbF5NuCFRTQIKD4NQ5uDyIAtM9+wm6r6xfvKfox5jN+tO3QxEPdWS/jt4MCt76NvdGfyfNDfRypsql/YvnHN/3A8W/t13XdS12utJRmmQo5+5Hg2E6T7hKfgtAgA5WRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300037; c=relaxed/simple;
	bh=shKv+VDd4E1VGWSIsBcGikJ997ldocGnM8jUq154LlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afbUd+Y1taYXibnMbLHPsaHghruSjEY8OgFCQRdaaHym+ct6Ymt19HQXFELdHL8TC2v6sU7/0hcwuGHDttynHUx/jytMGBiEkWOT746W+w6eZ1p/bruM9JBDuTlg/MZ9EHmgNxiDfqg6Ud5uKaVJ54EoaamQjTYrQ4ycv83iYo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/m4Gzut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9702FC19424;
	Sat, 28 Feb 2026 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300037;
	bh=shKv+VDd4E1VGWSIsBcGikJ997ldocGnM8jUq154LlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/m4GzutPo+MdStrTkHiZBhbLLHHzNSGIRL1W+GO7MrAqJ+x+ydC3P2xxdIFHjAjo
	 aNuMkIi5vsLbJ6MRlFQW6uhaUD2ItOpIjIgofO22Wj2jIeCOty+MTU1iNSpfFLH6fS
	 PcY4495GJ3skksR+ufL11jkSnVSDHAEjjVFkwEMt4VxJpzxUqyExisQUboyDc1Uk9b
	 Ouir6AEJTDObdoKaL4dggRhxmomXF8ITA5sydL+7u0q1/6d1wByzTkS4e0RDVSU1N2
	 S9HToHt1Z+uT3AkekyCgD9/iFLEgeHmvqWYAVBciRokJA6iqQ4xKEpBPDg3NsHhWza
	 aud9vI1f0UoTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 049/844] btrfs: don't BUG() on unexpected delayed ref type in run_one_delayed_ref()
Date: Sat, 28 Feb 2026 12:19:22 -0500
Message-ID: <20260228173244.1509663-50-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220127-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bur.io:email,suse.com:email]
X-Rspamd-Queue-Id: 97DBB1C519E
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit c7d1d4ff56744074e005771aff193b927392d51f ]

There is no need to BUG(), we can just return an error and log an error
message.

Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e4cae34620d19..1bf081243efb2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1761,32 +1761,36 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_extent_op *extent_op,
 			       bool insert_reserved)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret = 0;
 
 	if (TRANS_ABORTED(trans)) {
 		if (insert_reserved) {
 			btrfs_pin_extent(trans, node->bytenr, node->num_bytes);
-			free_head_ref_squota_rsv(trans->fs_info, href);
+			free_head_ref_squota_rsv(fs_info, href);
 		}
 		return 0;
 	}
 
 	if (node->type == BTRFS_TREE_BLOCK_REF_KEY ||
-	    node->type == BTRFS_SHARED_BLOCK_REF_KEY)
+	    node->type == BTRFS_SHARED_BLOCK_REF_KEY) {
 		ret = run_delayed_tree_ref(trans, href, node, extent_op,
 					   insert_reserved);
-	else if (node->type == BTRFS_EXTENT_DATA_REF_KEY ||
-		 node->type == BTRFS_SHARED_DATA_REF_KEY)
+	} else if (node->type == BTRFS_EXTENT_DATA_REF_KEY ||
+		   node->type == BTRFS_SHARED_DATA_REF_KEY) {
 		ret = run_delayed_data_ref(trans, href, node, extent_op,
 					   insert_reserved);
-	else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY)
+	} else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY) {
 		ret = 0;
-	else
-		BUG();
+	} else {
+		ret = -EUCLEAN;
+		btrfs_err(fs_info, "unexpected delayed ref node type: %u", node->type);
+	}
+
 	if (ret && insert_reserved)
 		btrfs_pin_extent(trans, node->bytenr, node->num_bytes);
 	if (ret < 0)
-		btrfs_err(trans->fs_info,
+		btrfs_err(fs_info,
 "failed to run delayed ref for logical %llu num_bytes %llu type %u action %u ref_mod %d: %d",
 			  node->bytenr, node->num_bytes, node->type,
 			  node->action, node->ref_mod, ret);
-- 
2.51.0


