Return-Path: <stable+bounces-273459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nlq2Ir0WU2rLWwMAu9opvQ
	(envelope-from <stable+bounces-273459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 06:23:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2DB743D41
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 06:23:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qq.com header.s=s201512 header.b=xruTzNT7;
	dmarc=pass (policy=quarantine) header.from=qq.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273459-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273459-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 992173013694
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 04:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F33368957;
	Sun, 12 Jul 2026 04:22:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5036D517;
	Sun, 12 Jul 2026 04:22:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783830176; cv=none; b=cu9oJmWBXwhFsK+pee7cUzX1kefWpgBVHaGpfntOxSMHPHe/3TF4dsLL5d36G4I9j9J1Jq3TDpM3PpXfEJ6fgk0xGb1L0vUyGgLZr6W9MmLzcCURgj0ichwqqS8+/eveRdk+UuGVrQBCb83TEmShcsdr9lM3JBhlh0tirE85rqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783830176; c=relaxed/simple;
	bh=xfxIhc4z+Alp8fORc5THEntX1RrXLkDRhAlpn3SPs4Y=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=WywzqxPDkc1CU+YIjx3dUyRvngdM3vOXDqNDxPUiGoPyotkcyjVc3BuaRj+09GNc9rBDTRnOMJNthCbD8elNlBV1j1ZjBvoSyNsL0SBwg6n4QAMVqWMy+8iJL226m2Xs0AJo5nv1ZTdP4ow+aH9C++uFf18NEbwgciSyIXrMS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xruTzNT7; arc=none smtp.client-ip=162.62.58.211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783830159; bh=KSDhMoPd3ihE+t6hcCHAPJNoN3BVqRYqqXOAh6XN9jY=;
	h=From:To:Cc:Subject:Date;
	b=xruTzNT7o8kpRsheZ+40DCPSW2cOJn6IJbGdpK31NYIJyfqJVD8XjXZQ+TNxaVW7R
	 qGvjkMf4EfHQaPacuR1I5LPZrCyZrmFHSAqd+r5hiB7uqkVR6lrDvQm+ac/zQvvQRf
	 nASC1owwc8ANt+Pa8PSyLCdHE1WjDV6k3DCptVRI=
Received: from ubuntu.. ([218.196.207.7])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 5A485AF5; Sun, 12 Jul 2026 12:22:36 +0800
X-QQ-mid: xmsmtpt1783830156tvghcsyj4
Message-ID: <tencent_73CA9825AA069E0BC5194FA9102FB7618807@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0CdQfjEgEZATKR6JQmESvT/WIBz8zFcQerVIguzRyILvpkaKoSke
	 aEoz8+vx0rDqxqrK5CdYJ8EasefVPHYyi/QGLBOJr/DrlO7yM3MEbLipRB9dTG93ZX0pYAX6Ici4
	 2nILbovBJn5Sn+hO5g2gvfM5zE+7JzsSy4ML4vzAzuWeyjxz2H+BJGbBuo56Z8AMMUdfHIOaLK90
	 jpF8lYCUAe8jxroIVFaJXTz81ayvTdUHwIuxH69fyYIZPBnhXldIzZj2uy8/xtzPK8eCMxeNdTwt
	 mAZvjHn8Fn/FUU9Eis03s/1flt4Qzq1NOHOuNOAsUGwN9+0M/20st9XoarE6L8OArmJWZYPjpHN0
	 Wc6E7uT30poIVrF/2Ooy/t0fMbuUoG8kQ3YGJZvbdTWppgntlmiMqcy/9kMYcS88pcNNlOwwvKeF
	 dlaXCATjQof3D3LQO/gxR69rP6X/YQxwcGEoqAPXXcKG/i0GvMBo0hktUiFMYTsZoJjJFqAYkvY5
	 3WYUWNUib6McFWlA/rzKw2C/HFRVaELmBYuDTw5hD9IeesO6IpdW+lhP8n+XYPI812tD4GUm3g9B
	 a8yGEXkB0YgcpRfNg3bEaFZ4+drYHrV8+zB5ivACa3qbXv8IotPkbhxHsdgXuMXFjktQxsqOWGYD
	 cK/UqsOKg5yglFN5fVD/t7cOJ/soyLt5hMijsBSro5L9GffZzfBqWl7neJgvW+bZxyY54zkzWSX9
	 QOiM269wGr/mMvX8aF9EX7ogCwL/mDnicjcGIauIfPv0SSdLuMnhyfjl285g2xOEaN8Eatkg33sI
	 Bs03esmaIvOvvyVlYL9VdbiO3ZG9qbAUkDzFTFYWfQn8W8QZ5vjLa33PhnYiiF+HmMfampT2SuFo
	 2H40tPCdH4hkToS9JDKFIjXLpXzgNDwlanlUhhwoxKiOFfJRWcb1v+XK3QqGWQaxL/hLr5NFiVT5
	 UdaX/HrUOMKJoBdNFHtxHzyjpRRGneKOpBY81/IP6pDUvveX9VhPbFoycUzL0MwkMPNJi79m0eu2
	 SqyJ4Fb/bjKGz/RM1fgIFLMY1f8lxq8jMiwxsVCqiT5BazagWbCSsy2/0ifek=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Guanghui Yang <3497809730@qq.com>
To: linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-kernel@vger.kernel.org,
	Guanghui Yang <3497809730@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: drop recovered reloc root refs on recovery failure
Date: Sun, 12 Jul 2026 04:22:32 +0000
X-OQ-MSGID: <20260712042232.1744156-1-3497809730@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273459-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-btrfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-kernel@vger.kernel.org,m:3497809730@qq.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[3497809730@qq.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[qq.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[fb.com,suse.com,vger.kernel.org,qq.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[3497809730@qq.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC2DB743D41

During relocation recovery, each fs root gets a reference to its relocation
root. If loading or adding a later root fails, or if the first transaction
commit fails, btrfs_recover_relocation() jumps to out_unset before
merge_reloc_roots() and clean_dirty_subvols().

put_reloc_control() drops the list-owned relocation root references, but it
does not clear fs_root->reloc_root or drop the references owned by those
pointers. Mount cleanup only drops them when BTRFS_FS_ERROR is set, so an
error such as -ENOMEM while processing a later root can leave references
behind.

Keep temporary references to the fs roots associated during recovery. On
failure, clear their reloc_root pointers and drop the corresponding
references. Once the first transaction commit succeeds, drop only the
temporary fs root references and let the normal merge and cleanup paths
handle the relocation roots.

Fault injection on a pending-relocation image confirmed the cleanup gap.
With an injected first-commit failure, 25 fs roots had reloc_root set with
fs_error=0. With this fix, the same failure path drops that count to 0
before mount fails.

Fixes: f44deb7442ed ("btrfs: hold a ref on the root->reloc_root")
Cc: stable@vger.kernel.org
Signed-off-by: Guanghui Yang <3497809730@qq.com>
---
 fs/btrfs/relocation.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index fb85bc8b345c..0d71cd80917f 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -5525,6 +5525,25 @@ static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
 	return ret;
 }
 
+static void release_recovered_fs_roots(struct list_head *roots,
+				       bool drop_reloc_refs)
+{
+	struct btrfs_root *root;
+	struct btrfs_root *next;
+
+	list_for_each_entry_safe(root, next, roots, reloc_dirty_list) {
+		list_del_init(&root->reloc_dirty_list);
+		if (drop_reloc_refs) {
+			struct btrfs_root *reloc_root = root->reloc_root;
+
+			ASSERT(reloc_root);
+			root->reloc_root = NULL;
+			btrfs_put_root(reloc_root);
+		}
+		btrfs_put_root(root);
+	}
+}
+
 /*
  * recover relocation interrupted by system crash.
  *
@@ -5534,6 +5553,7 @@ static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
 int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 {
 	LIST_HEAD(reloc_roots);
+	LIST_HEAD(recovered_roots);
 	struct btrfs_key key;
 	struct btrfs_root *fs_root;
 	struct btrfs_root *reloc_root;
@@ -5650,7 +5670,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 			ret = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_end_transaction(trans);
-			goto out_unset;
+			goto out_drop_reloc_refs;
 		}
 
 		ret = __add_reloc_root(reloc_root, rc);
@@ -5659,15 +5679,17 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_put_root(fs_root);
 			btrfs_end_transaction(trans);
-			goto out_unset;
+			goto out_drop_reloc_refs;
 		}
+		ASSERT(list_empty(&fs_root->reloc_dirty_list));
 		fs_root->reloc_root = btrfs_grab_root(reloc_root);
-		btrfs_put_root(fs_root);
+		list_add_tail(&fs_root->reloc_dirty_list, &recovered_roots);
 	}
 
 	ret = btrfs_commit_transaction(trans);
 	if (ret)
-		goto out_unset;
+		goto out_drop_reloc_refs;
+	release_recovered_fs_roots(&recovered_roots, false);
 
 	merge_reloc_roots(rc);
 
@@ -5683,6 +5705,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	ret2 = clean_dirty_subvols(rc);
 	if (ret2 < 0 && !ret)
 		ret = ret2;
+out_drop_reloc_refs:
+	release_recovered_fs_roots(&recovered_roots, true);
 out_unset:
 	unset_reloc_control(rc);
 	reloc_chunk_end(fs_info);
-- 
2.34.1


