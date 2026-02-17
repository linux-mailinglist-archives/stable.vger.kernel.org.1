Return-Path: <stable+bounces-216849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKHoCyKHlGmWFQIAu9opvQ
	(envelope-from <stable+bounces-216849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:20:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BC514D876
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 410BA30293DB
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5944523BCED;
	Tue, 17 Feb 2026 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwQ1cu7O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D88622424C
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341599; cv=none; b=QRsYS7NnegENXm9otnz2LFh34pKsBjeg0xQPRPsIrOctUboP5Th9kdfE7BpUPtG0zPk53+jguUKWJNPBeQdX3cUI9q31mTfsC41cnU5dVBprJDX9GByShuROZFXKyx3xD9IVsIJWF+NJA4uHqv/T4laPUFSPfxSoiDqGQ0/G+Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341599; c=relaxed/simple;
	bh=0qu+xXrRXaZ5NprmhEkOBj0+pYsBwMTR6Qbu5PZSi7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktQoYOZscqdEi7Z1YABMTpkodhImLjPQ6bodx1hA0x7ncV0fFOp/9Sql0MHCqp+VHRdMLvK6K2LNF+dfuKskkUq0NlWdSXXb+an641f9sN/XphS8AZEZpH0mcEK1i6yPaLS4qzKTV9MLQlXNDHSlCKxOZGNtpt68U5aKfvpt7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwQ1cu7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B34C4CEF7;
	Tue, 17 Feb 2026 15:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771341598;
	bh=0qu+xXrRXaZ5NprmhEkOBj0+pYsBwMTR6Qbu5PZSi7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XwQ1cu7OShY1iVO0zCXU1xlz3jT1t+CFUKkgCaReESM7zNbjifZwO9cEbELxihVTB
	 kGgBPD+zx+SwL7aEZXTveEOs6RRnOiknd4oCW46LpZeMn7rSvPmxdh0EEtc7ULjV+Z
	 PdcL+7ERXc96o6dsLOK+yXr44b3+AEdRyB5LB0AG/otTapB8YgWnSBoehPFbdsKw4j
	 WP0tD/LUFyvzCSDHMZxLGtCzjgju+WnGz/cDmQWsk8Oy7zHDkAvMFvGIVZshBjbz8P
	 hNpYGUUpamfGMtI/O4hVZeMKJET2fgr9s5D7r3dmqIZqWE0fd8w3PScSYMEGBNOLOl
	 PPa74nrThbQ2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	syzbot+b4444e3c972a7a124187@syzkaller.appspotmail.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] f2fs: fix to avoid UAF in f2fs_write_end_io()
Date: Tue, 17 Feb 2026 10:19:55 -0500
Message-ID: <20260217151955.3678030-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021708-pellet-surname-cfb8@gregkh>
References: <2026021708-pellet-surname-cfb8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216849-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,b4444e3c972a7a124187];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 85BC514D876
X-Rspamd-Action: no action

From: Chao Yu <chao@kernel.org>

[ Upstream commit ce2739e482bce8d2c014d76c4531c877f382aa54 ]

As syzbot reported an use-after-free issue in f2fs_write_end_io().

It is caused by below race condition:

loop device				umount
- worker_thread
 - loop_process_work
  - do_req_filebacked
   - lo_rw_aio
    - lo_rw_aio_complete
     - blk_mq_end_request
      - blk_update_request
       - f2fs_write_end_io
        - dec_page_count
        - folio_end_writeback
					- kill_f2fs_super
					 - kill_block_super
					  - f2fs_put_super
					 : free(sbi)
       : get_pages(, F2FS_WB_CP_DATA)
         accessed sbi which is freed

In kill_f2fs_super(), we will drop all page caches of f2fs inodes before
call free(sbi), it guarantee that all folios should end its writeback, so
it should be safe to access sbi before last folio_end_writeback().

Let's relocate ckpt thread wakeup flow before folio_end_writeback() to
resolve this issue.

Cc: stable@kernel.org
Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint for better performance")
Reported-by: syzbot+b4444e3c972a7a124187@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b4444e3c972a7a124187
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ folio => page ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ea831671e3ad2..fb3ef2d211591 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -357,14 +357,20 @@ static void f2fs_write_end_io(struct bio *bio)
 				page_folio(page)->index != nid_of_node(page));
 
 		dec_page_count(sbi, type);
+
+		/*
+		 * we should access sbi before end_page_writeback() to
+		 * avoid racing w/ kill_f2fs_super()
+		 */
+		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
+				wq_has_sleeper(&sbi->cp_wait))
+			wake_up(&sbi->cp_wait);
+
 		if (f2fs_in_warm_node_list(sbi, page))
 			f2fs_del_fsync_node_entry(sbi, page);
 		clear_page_private_gcing(page);
 		end_page_writeback(page);
 	}
-	if (!get_pages(sbi, F2FS_WB_CP_DATA) &&
-				wq_has_sleeper(&sbi->cp_wait))
-		wake_up(&sbi->cp_wait);
 
 	bio_put(bio);
 }
-- 
2.51.0


