Return-Path: <stable+bounces-114255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185FA2C528
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 15:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF403A2B3F
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0BC23ED52;
	Fri,  7 Feb 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGN/NFMA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FE423CEF7
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938326; cv=none; b=ermLgNjoBBsU+k/YGSnfh+apPiP2dGYTqNot2e0+aOzz/cWl8EYdJiOAbbvjSNb0munKKHxKGTUZqh433ZlY+xeh+UaKUBQmpIGviF3zK5p0pqiUiZg/CxfxEar8gacNWpn55gXzbrCTBjfvfYA4QhWhakfA3C6BJYqnj93C5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938326; c=relaxed/simple;
	bh=rY9TjibT3LSHIpTinfpR0Fkvvl+P828HkqdMYp5z7x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC05giWy2gnF66LMZoe1oOEFOoO8ojMU0kd55tTxuSU6xuQ6cEg3Y8A4BWhcDmZ6c9LaKdVyBJacQW19+mOBpqAVBs0+FijC9Qa1aJ0LiL27FyqpJ6+h5D4WBLMMn9I5HssAx+qNJn6r/Ye27bvOdPez7rBH+X5HX9JdsfPNSDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGN/NFMA; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2166360285dso38450675ad.1
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 06:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738938323; x=1739543123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6vap5U9Qo0v3fULFaum+jl2/tTPCXiHBK7O9j9LcM8=;
        b=kGN/NFMAZ40Wc8JZxmuqKQvoV5hEb9dCp1dWrA+c4qJBo5wX0+shHAmsL2IufKbDcD
         KalHArJUH0eSvTbW0GDRgLYtpjdV1i+L6NdyG9y7WmNJFP8KvZ9X6sJ86kVewyPRu93G
         SrB3sJxwljvQDDXuLtX3G4GEK6OXwwTJTJtU7SCf0peYPDu53KHi8VIFEFcoV5rUJxxL
         rjB6u6bJCC/VCXtY/pbRT/6TPSnnYY6jKN0IZ+PlGWK98hWsfNs189qjF0fmzOPGNOPm
         lWt+lBOM3K03t4edW5KtClUjFVTyF63ihfPE1U5QtQk6MoqJhkTg96UIom2VAtVWpzSX
         ax8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738938323; x=1739543123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6vap5U9Qo0v3fULFaum+jl2/tTPCXiHBK7O9j9LcM8=;
        b=GgsTpstdqu+blLQXgDJ6XTRK/yj+ngkf81JO3sEo8adu/X7HNQaDNc71mziPy9gwTx
         5sfxprNfHsd7mjLC5i5QwKRxfRwdhUbzoXMeDIP+gyfEi/xibAbTn8n0JIoekybHScy8
         iPWNkRt1XhI7/W00cFOeFm1Fk1qj/tQUFhMrC7PC3/KCA4bF/KPWjaryF1bUSpRom91W
         NMRXICIkMS6oF8aAoQshbPWDx2ImNZQARTwXGQ/+o6+RbSLOArUJGStY/Fo7Qgjim14R
         6fjk+viwaoRt/ogG6b29JhVJJQluql0DH2YoCVrshADkx78RBiWAz/k9duD11r1nTXjf
         So2w==
X-Gm-Message-State: AOJu0YxZaFfVk/HukBI0KJm2cfyfbtEG1vDv6nPMzxHIKZ2i2Zsmr+E2
	BoADnSLdEoZclCTD3v4+gi9Ujp7kgxxnBLUJOEACVWNosqF5d1alX92yTQ==
X-Gm-Gg: ASbGncs977gv6OPT/Oj7lW5rswf+JOrMoTB8Hm9h9GASzxShGGNE0mfV8YD+T2M9O2l
	mDSCUNKAWYrfqET6SIa0GEGJa+1VrN/Uqt/z0kbQhRr2lRQHmPZJ/rmR9OIcP/gaEbArKFOepnX
	FLNP4w1CoHosoum7E/oaO5p1bHr4cxEVUVqwIAnf3FIfizACu6+qaykMsJlnvYXGhMPtKExI5bX
	q8RPrWpAbGqH44FNbyFb4ZdFd+0GHnGMIs4PvTVNHqRMsK7K8adSSGWWYNerm1yshAU7/2GqhqS
	CkGZY1QH7lOa/goq14dyPLyR0OVSGGLCxCbEEi4MKHd/TDJp7RTWlHTOfQ==
X-Google-Smtp-Source: AGHT+IHj2r1lX1yxo21Xdkj82+km0kCmyu29btDnbb5+rLDEdKYfhXfoPHynjXsyaSI9YH/xxJa+qg==
X-Received: by 2002:a17:902:f60a:b0:216:7410:7e14 with SMTP id d9443c01a7336-21f4e7597fcmr58701455ad.34.1738938323181;
        Fri, 07 Feb 2025 06:25:23 -0800 (PST)
Received: from carrot.. (i222-151-22-8.s42.a014.ap.plala.or.jp. [222.151.22.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3655164bsm31174055ad.85.2025.02.07.06.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 06:25:22 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 5.10 5.15 2/3] nilfs2: do not force clear folio if buffer is referenced
Date: Fri,  7 Feb 2025 23:23:48 +0900
Message-ID: <20250207142512.6129-3-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207142512.6129-1-konishi.ryusuke@gmail.com>
References: <20250207142512.6129-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit ca76bb226bf47ff04c782cacbd299f12ddee1ec1 upstream.

Patch series "nilfs2: protect busy buffer heads from being force-cleared".

This series fixes the buffer head state inconsistency issues reported by
syzbot that occurs when the filesystem is corrupted and falls back to
read-only, and the associated buffer head use-after-free issue.

This patch (of 2):

Syzbot has reported that after nilfs2 detects filesystem corruption and
falls back to read-only, inconsistencies in the buffer state may occur.

One of the inconsistencies is that when nilfs2 calls mark_buffer_dirty()
to set a data or metadata buffer as dirty, but it detects that the buffer
is not in the uptodate state:

 WARNING: CPU: 0 PID: 6049 at fs/buffer.c:1177 mark_buffer_dirty+0x2e5/0x520
  fs/buffer.c:1177
 ...
 Call Trace:
  <TASK>
  nilfs_palloc_commit_alloc_entry+0x4b/0x160 fs/nilfs2/alloc.c:598
  nilfs_ifile_create_inode+0x1dd/0x3a0 fs/nilfs2/ifile.c:73
  nilfs_new_inode+0x254/0x830 fs/nilfs2/inode.c:344
  nilfs_mkdir+0x10d/0x340 fs/nilfs2/namei.c:218
  vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
  do_mkdirat+0x264/0x3a0 fs/namei.c:4280
  __do_sys_mkdirat fs/namei.c:4295 [inline]
  __se_sys_mkdirat fs/namei.c:4293 [inline]
  __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

The other is when nilfs_btree_propagate(), which propagates the dirty
state to the ancestor nodes of a b-tree that point to a dirty buffer,
detects that the origin buffer is not dirty, even though it should be:

 WARNING: CPU: 0 PID: 5245 at fs/nilfs2/btree.c:2089
  nilfs_btree_propagate+0xc79/0xdf0 fs/nilfs2/btree.c:2089
 ...
 Call Trace:
  <TASK>
  nilfs_bmap_propagate+0x75/0x120 fs/nilfs2/bmap.c:345
  nilfs_collect_file_data+0x4d/0xd0 fs/nilfs2/segment.c:587
  nilfs_segctor_apply_buffers+0x184/0x340 fs/nilfs2/segment.c:1006
  nilfs_segctor_scan_file+0x28c/0xa50 fs/nilfs2/segment.c:1045
  nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1216 [inline]
  nilfs_segctor_collect fs/nilfs2/segment.c:1540 [inline]
  nilfs_segctor_do_construct+0x1c28/0x6b90 fs/nilfs2/segment.c:2115
  nilfs_segctor_construct+0x181/0x6b0 fs/nilfs2/segment.c:2479
  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2587 [inline]
  nilfs_segctor_thread+0x69e/0xe80 fs/nilfs2/segment.c:2701
  kthread+0x2f0/0x390 kernel/kthread.c:389
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
  </TASK>

Both of these issues are caused by the callbacks that handle the
page/folio write requests, forcibly clear various states, including the
working state of the buffers they hold, at unexpected times when they
detect read-only fallback.

Fix these issues by checking if the buffer is referenced before clearing
the page/folio state, and skipping the clear if it is.

[konishi.ryusuke@gmail.com: adjusted for page/folio conversion]
Link: https://lkml.kernel.org/r/20250107200202.6432-1-konishi.ryusuke@gmail.com
Link: https://lkml.kernel.org/r/20250107200202.6432-2-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+b2b14916b77acf8626d7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b2b14916b77acf8626d7
Reported-by: syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=d98fd19acd08b36ff422
Fixes: 8c26c4e2694a ("nilfs2: fix issue with flush kernel thread after remount in RO mode because of driver's internal error or metadata corruption")
Tested-by: syzbot+b2b14916b77acf8626d7@syzkaller.appspotmail.com
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/nilfs2/page.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 93f24fa3ab10..ce5947cf4bd5 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -388,24 +388,44 @@ void nilfs_clear_dirty_pages(struct address_space *mapping)
 /**
  * nilfs_clear_dirty_page - discard dirty page
  * @page: dirty page that will be discarded
+ *
+ * nilfs_clear_dirty_page() clears working states including dirty state for
+ * the page and its buffers.  If the page has buffers, clear only if it is
+ * confirmed that none of the buffer heads are busy (none have valid
+ * references and none are locked).
  */
 void nilfs_clear_dirty_page(struct page *page)
 {
 	BUG_ON(!PageLocked(page));
 
-	ClearPageUptodate(page);
-	ClearPageMappedToDisk(page);
-	ClearPageChecked(page);
-
 	if (page_has_buffers(page)) {
-		struct buffer_head *bh, *head;
+		struct buffer_head *bh, *head = page_buffers(page);
 		const unsigned long clear_bits =
 			(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 			 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
 			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
 			 BIT(BH_Delay));
+		bool busy, invalidated = false;
 
-		bh = head = page_buffers(page);
+recheck_buffers:
+		busy = false;
+		bh = head;
+		do {
+			if (atomic_read(&bh->b_count) | buffer_locked(bh)) {
+				busy = true;
+				break;
+			}
+		} while (bh = bh->b_this_page, bh != head);
+
+		if (busy) {
+			if (invalidated)
+				return;
+			invalidate_bh_lrus();
+			invalidated = true;
+			goto recheck_buffers;
+		}
+
+		bh = head;
 		do {
 			lock_buffer(bh);
 			set_mask_bits(&bh->b_state, clear_bits, 0);
@@ -413,6 +433,9 @@ void nilfs_clear_dirty_page(struct page *page)
 		} while (bh = bh->b_this_page, bh != head);
 	}
 
+	ClearPageUptodate(page);
+	ClearPageMappedToDisk(page);
+	ClearPageChecked(page);
 	__nilfs_clear_page_dirty(page);
 }
 
-- 
2.43.5


