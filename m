Return-Path: <stable+bounces-216859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCFoCN+TlGl3FgIAu9opvQ
	(envelope-from <stable+bounces-216859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 17:14:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F714DF19
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 17:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3D173032F70
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B7136D51C;
	Tue, 17 Feb 2026 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ubq/R1GO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A12359FB0
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771344850; cv=none; b=E5md3Da09KkVnuDsKH8di3qfR8C1VCic4ULpBDwB9Csc31Ok2nKZh3HWfe+kmKU80H7SX9lXJTyb/yeTbUSoGwcaXsDNBNS0A2qeCyUuqNTTUWwD5d3tIq0M/Glow6EdCz2rTLVuXNzbImzTGgkJ2VHBHGOc4a6rDZyghLQxr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771344850; c=relaxed/simple;
	bh=S2yiqHJKkwhlX50b7n7HxAyD7tP+T/W2/lsAFHbUeAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0O76C0ejd/Zo/ocUnsv09MhX6L90pd1mNWfBFIxzXeokRyYVpnK4npw6Cm3bSsOByo/9FZtXo1jI7v0fKpYQWazt1UmzA7e1adzGBy5pplz+V41RfqCirAT0fPbJPqSLSAuaBBIjq0TAorAipTgA+A8h3h+nNQCBPJe+x0dWIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ubq/R1GO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C507FC4CEF7;
	Tue, 17 Feb 2026 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771344849;
	bh=S2yiqHJKkwhlX50b7n7HxAyD7tP+T/W2/lsAFHbUeAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ubq/R1GOsBpmhALcEQ8p8oQ9r9YodnoA3BxwKqFItelU0RYlbFU0LQIKWz3RlEwvd
	 FWUhgaum93KmeYJs5Tb9lSQV0s0YCjifVUM32ni1zfZxk4b2QGsPXdxkeji71HtFbL
	 3/ve/rFXV08G/NnFTZF1AG5dcpHkHkjWUXJwTqHvX2AvOURR+4rw3W0cEVDeLw5yYy
	 tqfr/IEPlJmGg4U8DA3P1AyxGrby1LFTvvFnvzLj4K8wmIjVAKxq7+JShOQu2hMCM5
	 vzlHkOkb3d0WLMlW6W2Tm6N269+Ypn6FigV4bw9hRuW7LIY81okKQMrKt7jZ0Bgmsj
	 9G6S1+3jXcGzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	syzbot+b4444e3c972a7a124187@syzkaller.appspotmail.com,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] f2fs: fix to avoid UAF in f2fs_write_end_io()
Date: Tue, 17 Feb 2026 11:14:07 -0500
Message-ID: <20260217161407.3762664-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026021710-tantrum-seldom-fb6c@gregkh>
References: <2026021710-tantrum-seldom-fb6c@gregkh>
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
	TAGGED_FROM(0.00)[bounces-216859-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: E81F714DF19
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
index 6798efda7d0d3..887e286d2c329 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -341,14 +341,20 @@ static void f2fs_write_end_io(struct bio *bio)
 					page->index != nid_of_node(page));
 
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


