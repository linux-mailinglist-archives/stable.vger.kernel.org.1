Return-Path: <stable+bounces-240594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OEYBig662nRJwAAu9opvQ
	(envelope-from <stable+bounces-240594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:38:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2369845C504
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37021300106F
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 09:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10CD38AC71;
	Fri, 24 Apr 2026 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zzpy7w6P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B31B3890EE
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777023523; cv=none; b=KbvJUkiDEB9f3pYUIzJLYksNM9rqaVXygkfPqQyCM7ZKE8ratQLhFZH7sW9pke2nFDAkQvCBnsnFOWGvtZKBSXmee0xbbWK5Lu5UHWx8rQqW0e1vdobqzrxSiznDv5idOQTbXw/dGtyNU1OoPOa1Ew0ObhQgUDVliyOjhzVHAx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777023523; c=relaxed/simple;
	bh=lhMMqxiZP1omtaNWZwjeDqnvNpofzAxvB/aqfEakHJU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hog4ouym5CxLB57UhahYjWape8a6LpnYeJwyE2xfN5J5kKYbgSURaSZgWIM4Za08HejKOzT+2cYc8U2lBV96FiQpL76A5gqoBOWKFKrA1OqV5uMbb0hO+GnTvas4w6f9L27XLtrXM46kKVnM6t/OqZwXitn3jam1u146Of/YLBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zzpy7w6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F3FC19425;
	Fri, 24 Apr 2026 09:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777023523;
	bh=lhMMqxiZP1omtaNWZwjeDqnvNpofzAxvB/aqfEakHJU=;
	h=Subject:To:Cc:From:Date:From;
	b=Zzpy7w6PZRq2ZAGuDe/2mIjEsVz4OoRNTiZEtsm6V6lhsVV0ML1CY16PNWBDwxUZY
	 ocYtpcisfp1ccNuEZv/TNoLJX5c4B+v8hZmYR/8eVpyNDfbq6CqMcZrMD6ZGH9V8CU
	 QqIPVKo20qmK8ZR+TLGF5wbrDdm5pggpXF0vwalQ=
Subject: FAILED: patch "[PATCH] f2fs: fix UAF caused by decrementing sbi->nr_pages[] in" failed to apply to 5.10-stable tree
To: yangyongpeng@xiaomi.com,chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Apr 2026 11:38:35 +0200
Message-ID: <2026042435-dreary-backshift-e993@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2369845C504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240594-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,xiaomi.com:email,appspotmail.com:email]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2d9c4a4ed4eef1f82c5b16b037aee8bad819fd53
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042435-dreary-backshift-e993@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


