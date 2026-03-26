Return-Path: <stable+bounces-230407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH4MHdWQxGnH0gQAu9opvQ
	(envelope-from <stable+bounces-230407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 02:50:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4DF32E07A
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 02:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EAD7302FB3E
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 01:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60CA38D009;
	Thu, 26 Mar 2026 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1SX0G77"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD7F38C42F
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 01:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774489803; cv=none; b=YM2j3x191/g3sqKspfELIz2Gg2gK8HmMWWAlGLFXQnU+3RmDFvLWb6rPCYeEI6kvlAg4/V7mAjKns1FXwpvkNaL8CWoOayE31dMYNdpvZjBPcBRLkZR99lKiUnfUo2vaAoHm/P4AfXXFELbfNlmS7oGAfv4OTqUXMhj+16kCwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774489803; c=relaxed/simple;
	bh=vXMXYMYIoQKHO6fd2/dna8bchdpHdXeovEdBpkksInI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hsTbV6+ef6L0IS26p+lwCn65bZztQlHqfiHU0Sso3EgRLOoyFFEHWM7DwsHKeKg5JFGXXdbEoVwI1kCrR9r/fWQHNpvYwTzoPT9syi8ysOBxKRMtpvFp9DdiA4V892AsjBqZSq+ThV1hd2RZTO3gHcmbAEIcKvoa4acLF3pH/CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1SX0G77; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b0603ee486so2800205ad.0
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 18:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774489800; x=1775094600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QxTNaZTRgWPw4ysbs0jY11Mq8fxrjhMIBT1HTTIxZN4=;
        b=s1SX0G77yhPp76sdYqCXcjWn8KVG5QCSodXGtULEqA1sWmPylp6q2FkTY+6vl9bJ6t
         Zfu74bzROQAkkksWJ8WINE5Dca73RsJWIjnLuGhZjdxN1edfM2GkZAzFjPzH9DSyfgoq
         guI/8/z1tEnk4BPv80aurpAyNpyAooSZMUd5msN1ggICccrfvupqZjA+k7iuU6XT4ES6
         KmEb/trywvSfX4ISzpKkM4SLlYcXDwbq4exQ+ZG5CM0CMDIsCVEt/Ha1/Ht2uv+bTdZk
         I8vFXGQcoLE8zv03pPKLi5lmIdksoZYSYTSS+JIxpDbHGKevic1+WD9G7/T6AIXNIp3X
         31zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774489800; x=1775094600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxTNaZTRgWPw4ysbs0jY11Mq8fxrjhMIBT1HTTIxZN4=;
        b=K2jCdksaTOWdQpDdSesC0Tqsy72W9ywihAqc+W/E6jbApCjsIMktjaTNZGaSw6DCYz
         6LLixHGDz+ISg/SxNU7iHfZrdQy90DDrPCfS+E2xzFWok0IOPA3AJ3ZVttL7T5ZhamII
         URfvQnvbp6LJvgmq39sc/9r7mhL1k3RGGeuD9IP8t79XoRVqAdvxAuC163ggfwCNBDd7
         nxciDWLG6YCFv01tQbBovVUDRKr61BhgJEiNOwLEVPlLF88n+1dZ9RvWymdKCMEqd95P
         FlJuUMFx9xqF7DzaznJNrfPCKl8bMhapL7ybWKj01FZKJnZQNid57EbkRwBWNH1k+KGY
         idXg==
X-Forwarded-Encrypted: i=1; AJvYcCVz5xjJZHd+RSOfIfW/ZIcXGuL3zV8dbRkuJHkcxz/xvXIyx1Y0AUIDWK7+A0i8qC5+SGe9QHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWsbDxcZGO2fqEEi/BKgJxGI4Y74vnNPKN059WhfuQkuc6YoIu
	sUvwiNy+VYQ5IBHAaj/nfunvCrj9GCvHKttLf1g8fWUpI8CtjFHkE7r3
X-Gm-Gg: ATEYQzzVpCCdtWdFDSiLJh+FQpS+tQMLLHXvI0zI03Ic0mSHVhwRDICVOE2JwztxBsb
	A2nWvYdmjDvaydHsJ+hCep7YfF2Ap1cLJQsrTo86V8/OHlcgKsTPSr+3gSR6azFoHpMfQKnOVT9
	0ij58aswOEm5yOz8DxifxP5h6yWxaM1rIQpXZNBEpSjWUp8hvqvf8EdCUDGgv6y0PlTqS57mzqP
	mzBjnTINdTgqiWFKzKILBrEA4PuRKlYNL7nAvrRkxOPKG1IxeyEXQOTxMOp06ioxqyQqfyhpe7X
	j29c5/K/OF++RhBR0yLErof49YNkwW3Nel0hORJVdI97YGv5KN5RBODw5RHbN7biuf0x2p3AC33
	DOm+F5XENSF+IzrW87/VBDJCpd3Tm7smpDq9EIdBb5NcvSbsNhlsCCgCCddO8KMdUXNyteg9spY
	87AqdyK9bj+TtlNMyW6r+oAuw+T9ghhQN6No+hJdWEnPpxgw6jlL4polrS2YzQcJi0mffwDIjRY
	51OEYs=
X-Received: by 2002:a17:902:e882:b0:2ae:ceeb:fa5f with SMTP id d9443c01a7336-2b0b0ab4906mr65557315ad.28.1774489800043;
        Wed, 25 Mar 2026 18:50:00 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:aa3b:c188:588e:e0f2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc783099sm14399215ad.18.2026.03.25.18.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 18:49:59 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+63056bf627663701bbbf@syzkaller.appspotmail.com
Cc: Deepanshu Kartikey <Kartikey406@gmail.com>,
	stable@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] btrfs: fix hung task when cloning inline extent races with writeback
Date: Thu, 26 Mar 2026 07:19:53 +0530
Message-ID: <20260326014953.16727-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230407-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,63056bf627663701bbbf];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email]
X-Rspamd-Queue-Id: 1D4DF32E07A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Deepanshu Kartikey <Kartikey406@gmail.com>

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


When cloning an inline extent, clone_copy_inline_extent() calls
copy_inline_to_page() which locks an extent range in the destination
inode's io_tree, dirties a page with the inline data, and sets
BTRFS_INODE_NO_DELALLOC_FLUSH on the inode. At this point i_size is
still 0 since clone_finish_inode_update() has not been called yet.

Then clone_copy_inline_extent() calls start_transaction() which may
block waiting for the current transaction to commit. While blocked,
the transaction commit calls btrfs_start_delalloc_flush() which calls
try_to_writeback_inodes_sb(), queuing a kworker to flush the clone
destination inode.

The kworker calls btrfs_writepages() -> extent_writepage() and since
i_size is still 0, the dirty page appears to be beyond EOF. This
causes extent_writepage() to call folio_invalidate() ->
btrfs_invalidate_folio() -> btrfs_lock_extent() which blocks forever
because the clone operation holds that lock, creating a circular
deadlock:

  clone   -> waits for transaction commit to finish
  commit  -> waits for kworker writeback to finish
  kworker -> waits for extent lock held by clone

Additionally any periodic background writeback that races with the
clone operation before i_size is updated will also block on the same
extent lock causing a hung task warning.

The flag BTRFS_INODE_NO_DELALLOC_FLUSH was introduced by commit
3d45f221ce62 to prevent this deadlock but was only checked inside
start_delalloc_inodes(), which is only reached through the btrfs
metadata reclaim path. The transaction commit path goes through
try_to_writeback_inodes_sb() which is a VFS function that bypasses
start_delalloc_inodes() entirely, so the flag was never checked there.

Fix this by checking BTRFS_INODE_NO_DELALLOC_FLUSH at the top of
btrfs_writepages() and returning early if set. This catches all
writeback paths since every writeback on a btrfs inode eventually
calls btrfs_writepages(). The inode will be safely written after the
clone operation finishes and clears the flag, at which point all
locks are released and i_size is properly updated.

Also change the local variable type from 'struct inode *' to
'struct btrfs_inode *' to avoid the double BTRFS_I() conversion.

Fixes: 3d45f221ce62 ("btrfs: fix deadlock when cloning inline extent and low on free metadata space")
CC: stable@vger.kernel.org
Reported-by: syzbot+63056bf627663701bbbf@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/btrfs/extent_io.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5f97a3d2a8d7..f7df7c0c8955 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2698,21 +2698,54 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 
 int btrfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
-	struct inode *inode = mapping->host;
+	struct btrfs_inode *inode = BTRFS_I(mapping->host);
 	int ret = 0;
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.wbc = wbc,
 		.opf = REQ_OP_WRITE | wbc_to_write_flags(wbc),
 	};
 
+	/*
+	 * If this inode is being used for a clone/reflink operation that
+	 * copied an inline extent into a page of the destination inode, skip
+	 * writeback to avoid a deadlock or a long blocked task.
+	 *
+	 * The clone operation holds the extent range locked in the inode's
+	 * io_tree for its entire duration. Any writeback attempt on this
+	 * inode will block trying to lock that same extent range inside
+	 * writepage_delalloc() or btrfs_invalidate_folio(), causing a
+	 * hung task.
+	 *
+	 * When writeback is triggered from the transaction commit path via
+	 * btrfs_start_delalloc_flush() -> try_to_writeback_inodes_sb(),
+	 * this becomes a true circular deadlock:
+	 *
+	 *   clone   -> waits for transaction commit to finish
+	 *   commit  -> waits for kworker writeback to finish
+	 *   kworker -> waits for extent lock held by clone
+	 *
+	 * The flag BTRFS_INODE_NO_DELALLOC_FLUSH was already checked in
+	 * start_delalloc_inodes() but only for the btrfs metadata reclaim
+	 * path. The transaction commit path goes through
+	 * try_to_writeback_inodes_sb() which bypasses that check entirely
+	 * and calls btrfs_writepages() directly.
+	 *
+	 * By checking the flag here we catch all writeback paths. The inode
+	 * will be safely written after the clone operation finishes and
+	 * clears BTRFS_INODE_NO_DELALLOC_FLUSH, at which point all locks
+	 * are released and writeback can proceed normally.
+	 */
+	if (test_bit(BTRFS_INODE_NO_DELALLOC_FLUSH, &inode->runtime_flags))
+		return 0;
+
 	/*
 	 * Allow only a single thread to do the reloc work in zoned mode to
 	 * protect the write pointer updates.
 	 */
-	btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
+	btrfs_zoned_data_reloc_lock(inode);
 	ret = extent_write_cache_pages(mapping, &bio_ctrl);
 	submit_write_bio(&bio_ctrl, ret);
-	btrfs_zoned_data_reloc_unlock(BTRFS_I(inode));
+	btrfs_zoned_data_reloc_unlock(inode);
 	return ret;
 }
 
-- 
2.43.0


