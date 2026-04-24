Return-Path: <stable+bounces-240704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NZPA5By62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:39:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB4645F543
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28FC53034DC8
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974783D5241;
	Fri, 24 Apr 2026 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyHuqq4J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AED3563D4
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037621; cv=none; b=Ds3ZTAUAI+JDGkKDucVhmj7riSh/8hCgGuGv6Qnc2qXJP5HLU5yW1142+R9fZ57JnjltufXxag+lBgXP3ta9wWKfMd9SZo8mr2SwYEGHT9otK9PTcXjKwCwxe9DDG+dwcFgZtL5+elBzdCfYmSByzyp+8gub7j5PsRUV6FChhMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037621; c=relaxed/simple;
	bh=WYPrjfBFRuZgh65mblX6Gmf/yc+CRxJaBTdjAvXEC+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnMmT8eGaplF/fN9z/DctzbN2iz9DpkqvDSjfPEnZ6HT422xvKmlZZIcBn7Ga7mzbVPtKQXVKbTk1PVvBR+iTqwnswH1jqwID6Fr+eEVe7YbOFaz4nY/oCJuYr44SSc/D4kbKKnbLrbcET3jtlIw5/Q8UH/2esvJnxaXNfYoAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyHuqq4J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43313C19425;
	Fri, 24 Apr 2026 13:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777037621;
	bh=WYPrjfBFRuZgh65mblX6Gmf/yc+CRxJaBTdjAvXEC+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyHuqq4J61/tBS7qmFyK82TDNllRMBfz8T3tyFUtFPWJsq38fkkYuX4pt0CDgMnW0
	 rRw809ei538uYios0YyiV8ot6Ja90X8mxpATK7aFO41ICbip+WUBWmSF0xzesEGH28
	 FKBWqwWdfXStFlVAyhp8uSv6r6PEhDeib2ULhs1efLdQ9B4oHTAK11D2ipWvbDxx/u
	 d4N7nRIqin1k/U99R5GnaRn5IWaq3LqJliOJEHj0A3/xmDgK1gvb+espYoCOUsgzLt
	 v5M8WRvm5qw7nAiIKoUI9PApfGAKcP3+R2oJrba9PzFnIViu/1nTK476AipMiIxmYG
	 nk6y/lzuUPCnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
	stable@kernel.org,
	syzbot+6e4cb1cac5efc96ea0ca@syzkaller.appspotmail.com,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] f2fs: fix UAF caused by decrementing sbi->nr_pages[] in f2fs_write_end_io()
Date: Fri, 24 Apr 2026 09:33:38 -0400
Message-ID: <20260424133338.1965493-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042434-ultra-craving-a7e9@gregkh>
References: <2026042434-ultra-craving-a7e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6EB4645F543
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240704-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,6e4cb1cac5efc96ea0ca];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

[ Upstream commit 2d9c4a4ed4eef1f82c5b16b037aee8bad819fd53 ]

The xfstests case "generic/107" and syzbot have both reported a NULL
pointer dereference.

The concurrent scenario that triggers the panic is as follows:

F2FS_WB_CP_DATA write callback          umount
                                        - f2fs_write_checkpoint
                                         - f2fs_wait_on_all_pages(sbi, F2FS_WB_CP_DATA)
- blk_mq_end_request
 - bio_endio
  - f2fs_write_end_io
   : dec_page_count(sbi, F2FS_WB_CP_DATA)
   : wake_up(&sbi->cp_wait)
                                        - kill_f2fs_super
                                         - kill_block_super
                                          - f2fs_put_super
                                           : iput(sbi->node_inode)
                                           : sbi->node_inode = NULL
   : f2fs_in_warm_node_list
    - is_node_folio // sbi->node_inode is NULL and panic

The root cause is that f2fs_put_super() calls iput(sbi->node_inode) and
sets sbi->node_inode to NULL after sbi->nr_pages[F2FS_WB_CP_DATA] is
decremented to zero. As a result, f2fs_in_warm_node_list() may
dereference a NULL node_inode when checking whether a folio belongs to
the node inode, leading to a panic.

This patch fixes the issue by calling f2fs_in_warm_node_list() before
decrementing sbi->nr_pages[F2FS_WB_CP_DATA], thus preventing the
use-after-free condition.

Cc: stable@kernel.org
Fixes: 50fa53eccf9f ("f2fs: fix to avoid broken of dnode block list")
Reported-by: syzbot+6e4cb1cac5efc96ea0ca@syzkaller.appspotmail.com
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ folio => page ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9bc66ead42d02..5afa634cda645 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -356,6 +356,8 @@ static void f2fs_write_end_io(struct bio *bio)
 
 		f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
 					page->index != nid_of_node(page));
+		if (f2fs_in_warm_node_list(sbi, page))
+			f2fs_del_fsync_node_entry(sbi, page);
 
 		dec_page_count(sbi, type);
 
@@ -367,8 +369,6 @@ static void f2fs_write_end_io(struct bio *bio)
 				wq_has_sleeper(&sbi->cp_wait))
 			wake_up(&sbi->cp_wait);
 
-		if (f2fs_in_warm_node_list(sbi, page))
-			f2fs_del_fsync_node_entry(sbi, page);
 		clear_page_private_gcing(page);
 		end_page_writeback(page);
 	}
-- 
2.53.0


