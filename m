Return-Path: <stable+bounces-21479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0451E85C917
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB0C284DE3
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C91151CEB;
	Tue, 20 Feb 2024 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB164S1u"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEC114A4E6
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464550; cv=none; b=gzpV/EdiVsMc4F4/ZUPBmxl+NqJnc16kTayv/Z12AIMd0SdIBG51ZxxDzcHfsbMHBPBtFQDXaThKj7V0tckMSa2Zr9yDTc7TmYfPGMa8PAbiuIH3tufp+RpGKIQHZJAvrbBLX2xxhdbFod6/2rf7qUhQ4q7n/Q6RUrLLZ3JwLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464550; c=relaxed/simple;
	bh=oLcpNiBHXLE3PwmdBTaeEDxExb9bW2Y7aknC/l5kDqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aSud5kkJszvIT5Pnfba6PHCG6R8c5lG/HXoBnkLnF2jNEdZOYk5L4alcbL7D4i7X62k2Q0uqLU15W+1HT9b4QNr5w0XQR6gXfWW4bg/T3vYAVCMu1+lQ7ahcUmF5p9/NLcNdlRLswpkbeYzmj9SWVZtPwwsRHIiVPvGEVXcKIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QB164S1u; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-59a8b9b327aso2182329eaf.2
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 13:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708464547; x=1709069347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CLZOFiozVwC5ME0m6wS7LFcODZPGY/Dn60kT2ULFEh0=;
        b=QB164S1ulSg5t6caWPvPCPdHcVniXgyqE4JMOfzcY4SaheXcAqzgzM2So2/sd2/fPl
         5uBeu6zLEPgZrJ8vNyGh+dR4OQrxTxgL3MIz3CRoIGdQAu80vzU/2bITSexGoW7SOak2
         3Z6LX1V555Sd0Q9ibkgqJlLQpt4An1dznnEWz+VuL1pYD9OP06LKrAijnl0VG/Ua6qd2
         rIInWZ/ts7Mppp9NsQM1284GE8s9XjugnRf/ekLXu8Wn5pItdy2Y7AwRII88Erbl3SjX
         GOqEKur1k/gaSjJg1aBS1Jwotvfrq4Plc+Zuf+esZcgC+MUNDYTbkHi/Bpub3tl9P5S/
         lVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708464547; x=1709069347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLZOFiozVwC5ME0m6wS7LFcODZPGY/Dn60kT2ULFEh0=;
        b=J/i8+rpvR7eJQZtHddJezm88nsnyuKp0X6ZzeMvqcV7pKWVUhIl1IEY0p37+W3Q9xz
         lfarYZQ6iOWTDR5bbVP11Z6kGWsMHz6rqfTwVqsh4kZDHNKGGyQbbA3/ACrzq4AaIZlk
         tPNEOQjeDplAiZ9O7ekeIBF8PufnFPHCNVHkzULn4wBGKs6R2kGXR748w4bi9EQpT7dL
         DOajheRRUQ4oC/VO9y8fgqWom5aCUnji4mRgGdcb7eSp8imue/E/738vlpMR+ry+W1ww
         EPuE3ACbNHdyblrpq1giHyA6Gw74SStPCd9ZNJH1YgtFujTL32RCBFuxeySmMIQm7hNb
         xttg==
X-Gm-Message-State: AOJu0YygmK0Am6W2yDsIMm1kcP5n1yHbJdEi1H0e/vvKAskuAEfW7oB5
	xsEmK62jU8fy13/y/3VnS/nkjl+dff1u7IMWO4mMy8zeq9dsYho335hgoEhl
X-Google-Smtp-Source: AGHT+IHPh8BxaPdawerv+SLP2rMhgeLLkh3cumd3xyuvnBpvKy54kc5z/RTocLkTUHbUIkMN3GF2tg==
X-Received: by 2002:a05:6358:7e04:b0:17b:2bc6:e843 with SMTP id o4-20020a0563587e0400b0017b2bc6e843mr13177303rwm.18.1708464547047;
        Tue, 20 Feb 2024 13:29:07 -0800 (PST)
Received: from carrot.. (i223-217-149-232.s42.a014.ap.plala.or.jp. [223.217.149.232])
        by smtp.gmail.com with ESMTPSA id h23-20020a63f917000000b005bd980cca56sm7131962pgi.29.2024.02.20.13.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:29:05 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 5.4 5.10 5.15 6.1 6.6 6.7] nilfs2: fix potential bug in end_buffer_async_write
Date: Wed, 21 Feb 2024 06:29:28 +0900
Message-Id: <20240220212928.5611-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 5bc09b397cbf1221f8a8aacb1152650c9195b02b upstream.

According to a syzbot report, end_buffer_async_write(), which handles the
completion of block device writes, may detect abnormal condition of the
buffer async_write flag and cause a BUG_ON failure when using nilfs2.

Nilfs2 itself does not use end_buffer_async_write().  But, the async_write
flag is now used as a marker by commit 7f42ec394156 ("nilfs2: fix issue
with race condition of competition between segments for dirty blocks") as
a means of resolving double list insertion of dirty blocks in
nilfs_lookup_dirty_data_buffers() and nilfs_lookup_node_buffers() and the
resulting crash.

This modification is safe as long as it is used for file data and b-tree
node blocks where the page caches are independent.  However, it was
irrelevant and redundant to also introduce async_write for segment summary
and super root blocks that share buffers with the backing device.  This
led to the possibility that the BUG_ON check in end_buffer_async_write
would fail as described above, if independent writebacks of the backing
device occurred in parallel.

The use of async_write for segment summary buffers has already been
removed in a previous change.

Fix this issue by removing the manipulation of the async_write flag for
the remaining super root block buffer.

Link: https://lkml.kernel.org/r/20240203161645.4992-1-konishi.ryusuke@gmail.com
Fixes: 7f42ec394156 ("nilfs2: fix issue with race condition of competition between segments for dirty blocks")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+5c04210f7c7f897c1e7f@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/00000000000019a97c05fd42f8c8@google.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Please queue this patch to these stable trees instead of the patch
that failed to apply to them.

This patch is tailored to account for page/folio conversion and can
be applied from v4.8 to v6.7.

Also, all the builds and tests I did on each stable tree passed.

Thanks,
Ryusuke Konishi

 fs/nilfs2/segment.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 55e31cc903d1..0f21dbcd0bfb 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1703,7 +1703,6 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
 				    b_assoc_buffers) {
-			set_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
 				if (bh->b_page != bd_page) {
 					lock_page(bd_page);
@@ -1714,6 +1713,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 				}
 				break;
 			}
+			set_buffer_async_write(bh);
 			if (bh->b_page != fs_page) {
 				nilfs_begin_page_io(fs_page);
 				fs_page = bh->b_page;
@@ -1799,7 +1799,6 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 
 		list_for_each_entry(bh, &segbuf->sb_payload_buffers,
 				    b_assoc_buffers) {
-			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
 				clear_buffer_uptodate(bh);
 				if (bh->b_page != bd_page) {
@@ -1808,6 +1807,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 				}
 				break;
 			}
+			clear_buffer_async_write(bh);
 			if (bh->b_page != fs_page) {
 				nilfs_end_page_io(fs_page, err);
 				fs_page = bh->b_page;
@@ -1895,8 +1895,9 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				 BIT(BH_Delay) | BIT(BH_NILFS_Volatile) |
 				 BIT(BH_NILFS_Redirected));
 
-			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh == segbuf->sb_super_root) {
+				set_buffer_uptodate(bh);
+				clear_buffer_dirty(bh);
 				if (bh->b_page != bd_page) {
 					end_page_writeback(bd_page);
 					bd_page = bh->b_page;
@@ -1904,6 +1905,7 @@ static void nilfs_segctor_complete_write(struct nilfs_sc_info *sci)
 				update_sr = true;
 				break;
 			}
+			set_mask_bits(&bh->b_state, clear_bits, set_bits);
 			if (bh->b_page != fs_page) {
 				nilfs_end_page_io(fs_page, 0);
 				fs_page = bh->b_page;
-- 
2.39.3


