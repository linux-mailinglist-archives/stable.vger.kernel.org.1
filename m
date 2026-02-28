Return-Path: <stable+bounces-220366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKveBcAzo2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:28:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AC59E1C5D38
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08D9F30BDCD9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F973A2AFA;
	Sat, 28 Feb 2026 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeTGDh8f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC583A2AF2;
	Sat, 28 Feb 2026 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300263; cv=none; b=WaCBH7PRkvYGp2vc8vvsXb6jfLYZEm8HWGjCvYhfkxL7M09Eq1TM2f6Gds+RFQFX5ZGT4i4JT5+dkCg2TKdu0nCqah9jmStnsux6+OXE2YGZXF7Attsc0k5Z1CWSTGoCVilGOx4Iq5hjCaglo9HxuDpes1mzt2zaAPh2zPKlboE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300263; c=relaxed/simple;
	bh=4Cwt2EojoRzLmJ1xvBNGTc8dzSl8uMY6zNPA2+D+51U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JK4C+Q5He3UDA2ZY8ErViItGs6d1Z5r8tZLHdEgXTCw6zg6GW3JVcsfvqYBhDO0zINsPyaumhi5wpPQHfjLSV1yma5fOHsVQsMDB3VurzYwgBeoPMSggDVA26/v6Krgd5vtLolqv/2U+ixUhvTlmoK8J+FIlUO+/SVYd4BiubBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeTGDh8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1B8C116D0;
	Sat, 28 Feb 2026 17:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300262;
	bh=4Cwt2EojoRzLmJ1xvBNGTc8dzSl8uMY6zNPA2+D+51U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MeTGDh8fZ1jJx9FmX1CbUJ5SELOk54xMy5Qu4Haam/XiBnw79iOu0z0rygBF9ojEL
	 i/z8u3qfRpQnWDB1d6i8LnNCwxF6GQHniXcXnnfarBaocHfNKjRl/6D/1a73vv13pY
	 8Vk0c9QtOOpyesdi2jhg7MEoV3IaKg09yc+sr0NGrPT+WgqS5nDxvtrDqN8FLCHjyh
	 paI4UNBUkPlM1cZ6fgcUjnHd7MX3zhPdsYwh327Atulop4+jXvqdKYilMRAp6+GAWo
	 /LpvTuJtNP50Py64/u5juZ3d2iZ5zCmhkj79MLfiuHUnMPRuSCApvVg4ZYJlmefolP
	 qxZoWE+6bCMOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 288/844] ext4: move ext4_percpu_param_init() before ext4_mb_init()
Date: Sat, 28 Feb 2026 12:23:21 -0500
Message-ID: <20260228173244.1509663-289-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220366-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: AC59E1C5D38
X-Rspamd-Action: no action

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 270564513489d98b721a1e4a10017978d5213bff ]

When running `kvm-xfstests -c ext4/1k -C 1 generic/383` with the
`DOUBLE_CHECK` macro defined, the following panic is triggered:

==================================================================
EXT4-fs error (device vdc): ext4_validate_block_bitmap:423:
                        comm mount: bg 0: bad block bitmap checksum
BUG: unable to handle page fault for address: ff110000fa2cc000
PGD 3e01067 P4D 3e02067 PUD 0
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 0 UID: 0 PID: 2386 Comm: mount Tainted: G W
                        6.18.0-gba65a4e7120a-dirty #1152 PREEMPT(none)
RIP: 0010:percpu_counter_add_batch+0x13/0xa0
Call Trace:
 <TASK>
 ext4_mark_group_bitmap_corrupted+0xcb/0xe0
 ext4_validate_block_bitmap+0x2a1/0x2f0
 ext4_read_block_bitmap+0x33/0x50
 mb_group_bb_bitmap_alloc+0x33/0x80
 ext4_mb_add_groupinfo+0x190/0x250
 ext4_mb_init_backend+0x87/0x290
 ext4_mb_init+0x456/0x640
 __ext4_fill_super+0x1072/0x1680
 ext4_fill_super+0xd3/0x280
 get_tree_bdev_flags+0x132/0x1d0
 vfs_get_tree+0x29/0xd0
 vfs_cmd_create+0x59/0xe0
 __do_sys_fsconfig+0x4f6/0x6b0
 do_syscall_64+0x50/0x1f0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
==================================================================

This issue can be reproduced using the following commands:
        mkfs.ext4 -F -q -b 1024 /dev/sda 5G
        tune2fs -O quota,project /dev/sda
        mount /dev/sda /tmp/test

With DOUBLE_CHECK defined, mb_group_bb_bitmap_alloc() reads
and validates the block bitmap. When the validation fails,
ext4_mark_group_bitmap_corrupted() attempts to update
sbi->s_freeclusters_counter. However, this percpu_counter has not been
initialized yet at this point, which leads to the panic described above.

Fix this by moving the execution of ext4_percpu_param_init() to occur
before ext4_mb_init(), ensuring the per-CPU counters are initialized
before they are used.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20251209133116.731350-1-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d02..5c2e931d8a533 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5604,6 +5604,10 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 			clear_opt2(sb, MB_OPTIMIZE_SCAN);
 	}
 
+	err = ext4_percpu_param_init(sbi);
+	if (err)
+		goto failed_mount5;
+
 	err = ext4_mb_init(sb);
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "failed to initialize mballoc (%d)",
@@ -5619,10 +5623,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		sbi->s_journal->j_commit_callback =
 			ext4_journal_commit_callback;
 
-	err = ext4_percpu_param_init(sbi);
-	if (err)
-		goto failed_mount6;
-
 	if (ext4_has_feature_flex_bg(sb))
 		if (!ext4_fill_flex_info(sb)) {
 			ext4_msg(sb, KERN_ERR,
@@ -5704,8 +5704,8 @@ failed_mount8: __maybe_unused
 failed_mount6:
 	ext4_mb_release(sb);
 	ext4_flex_groups_free(sbi);
-	ext4_percpu_param_destroy(sbi);
 failed_mount5:
+	ext4_percpu_param_destroy(sbi);
 	ext4_ext_release(sb);
 	ext4_release_system_zone(sb);
 failed_mount4a:
-- 
2.51.0


