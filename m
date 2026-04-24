Return-Path: <stable+bounces-240593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHIhCV4662nRJwAAu9opvQ
	(envelope-from <stable+bounces-240593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:39:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF59145C538
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4A5E3019F1C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1CC38AC75;
	Fri, 24 Apr 2026 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="efZiEvKV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DE53890F3
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023521; cv=none; b=QJ61qL/UGZYh4MtuWeq3RHclo9AhbKz0BOm/xEvN4eVBsjLOaST5rAaOJBCQ307ELFg6CEB6fsH8d1moJYM/h16P3kS7E7Xf1Z+joep/6tn9aMWPpWRN8L9VtxsuDwU/rUKFrEpgt9GAjY+l+99M5dBkgy/94btCCar50gEtIR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023521; c=relaxed/simple;
	bh=OZSHjjtZE3U6NeJjBIhrHvRJh/+3vd0x7Ex9zqwef4E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Htpn3USz6SJ9VzhvtuLIRmsP1tqdTrIqtEoBA5yCMaQXwjn+R7hNEiRFjrDA2nYdHNEjbMg2RUEo9A0RpZWpUdjWZ/TxotPJzdAFx/pxN0a2sgIK849wCY9yGkE+bHv+fAnAxxSeFZFQomQXUL0Rq7C4nM4YJ4LTFmQGrquvakI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=efZiEvKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4858EC19425;
	Fri, 24 Apr 2026 09:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777023520;
	bh=OZSHjjtZE3U6NeJjBIhrHvRJh/+3vd0x7Ex9zqwef4E=;
	h=Subject:To:Cc:From:Date:From;
	b=efZiEvKVT98pvtZfnGLiMzh1CpAOi1/lrY2Et4yCD1oeJJ4Fga2S5DFcoH4YvIn5D
	 3+SrazOFZA4bB2EmYfplHnIzjSNet4QoelsMgUWgG0BW5fd2CyJLaPCTj+4lnT3n+5
	 48Qf+rDCS5I6DVvVEB4Goop0dswAsB/g6H7pRFSk=
Subject: FAILED: patch "[PATCH] f2fs: fix UAF caused by decrementing sbi->nr_pages[] in" failed to apply to 6.1-stable tree
To: yangyongpeng@xiaomi.com,chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Apr 2026 11:38:34 +0200
Message-ID: <2026042434-ultra-craving-a7e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF59145C538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-240593-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xiaomi.com:email]


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2d9c4a4ed4eef1f82c5b16b037aee8bad819fd53
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042434-ultra-craving-a7e9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2d9c4a4ed4eef1f82c5b16b037aee8bad819fd53 Mon Sep 17 00:00:00 2001
From: Yongpeng Yang <yangyongpeng@xiaomi.com>
Date: Fri, 27 Feb 2026 15:30:52 +0800
Subject: [PATCH] f2fs: fix UAF caused by decrementing sbi->nr_pages[] in
 f2fs_write_end_io()

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

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 400f0400e13d..57fc9bad31bf 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -386,6 +386,8 @@ static void f2fs_write_end_io(struct bio *bio)
 				folio->index, NODE_TYPE_REGULAR, true);
 			f2fs_bug_on(sbi, folio->index != nid_of_node(folio));
 		}
+		if (f2fs_in_warm_node_list(sbi, folio))
+			f2fs_del_fsync_node_entry(sbi, folio);
 
 		dec_page_count(sbi, type);
 
@@ -397,8 +399,6 @@ static void f2fs_write_end_io(struct bio *bio)
 				wq_has_sleeper(&sbi->cp_wait))
 			wake_up(&sbi->cp_wait);
 
-		if (f2fs_in_warm_node_list(sbi, folio))
-			f2fs_del_fsync_node_entry(sbi, folio);
 		folio_clear_f2fs_gcing(folio);
 		folio_end_writeback(folio);
 	}


