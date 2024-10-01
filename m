Return-Path: <stable+bounces-78475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F1198BBC8
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50E01F22A80
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF6D3209;
	Tue,  1 Oct 2024 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BbBnKZPg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BBA1A08AD
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784381; cv=none; b=e/BFE1c7j39SEeZzg9R0tmSbr/fWhft6Sed7Om7ce85OJG5/BZ4D/EmEBKU41mQrct0+TqTr75wxft+5TCsHPB5bT+3PyfcKtASBeFitz4CiSVZrHOP2u4qjybzIprunGIqq+OcBygRLldy0LXwOhFaVGMXGjYG4PlgBdHiQ66A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784381; c=relaxed/simple;
	bh=U1hFVSQ6C20VJJg3F6HQK3XmfNqQ1puWKLtxX7Fqgk0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N3/2mk70rj5YjELSL0IPwW9OUL+AMgGjwcSl2WHBeMbCxEh6OSQDHw1OwndC7fxxmgbc/DiwlbpUS9EyTim7Zqo3TaqIiUbp03hQZtjuCYKVvLzE1uA4XZv0INQytbwM4xKTkYR6ivRrFSl/MmzortVYJMD7L9L+XVXsbHIv7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BbBnKZPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFF4C4CEC6;
	Tue,  1 Oct 2024 12:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727784380;
	bh=U1hFVSQ6C20VJJg3F6HQK3XmfNqQ1puWKLtxX7Fqgk0=;
	h=Subject:To:Cc:From:Date:From;
	b=BbBnKZPgaoj0oOA7aCb+A3zMP/7nrYvQhHDehOp2ZEUjHhCkeRu5XtuSALOkyxTSe
	 Z/WN0dQRdawx2WxWRM/LHgNqULzp2EvD4aCgNwPc4cPUkMf97E55lCElHHU/y56OiN
	 PVlvUAAruxvY1KIGTVLG6ae8LGtPTTZSriIQdWjU=
Subject: FAILED: patch "[PATCH] btrfs: subpage: fix the bitmap dump which can cause bitmap" failed to apply to 6.6-stable tree
To: wqu@suse.com,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 14:06:17 +0200
Message-ID: <2024100117-venture-unloving-3135@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 77b0b98bb743f5d04d8f995ba1936e1143689d4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100117-venture-unloving-3135@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

77b0b98bb743 ("btrfs: subpage: fix the bitmap dump which can cause bitmap corruption")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 77b0b98bb743f5d04d8f995ba1936e1143689d4a Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Fri, 30 Aug 2024 16:35:48 +0930
Subject: [PATCH] btrfs: subpage: fix the bitmap dump which can cause bitmap
 corruption

In commit 75258f20fb70 ("btrfs: subpage: dump extra subpage bitmaps for
debug") an internal macro GET_SUBPAGE_BITMAP() is introduced to grab the
bitmap of each attribute.

But that commit is using bitmap_cut() which will do the left shift of
the larger bitmap, causing incorrect values.

Thankfully this bitmap_cut() is only called for debug usage, and so far
it's not yet causing problem.

Fix it to use bitmap_read() to only grab the desired sub-bitmap.

Fixes: 75258f20fb70 ("btrfs: subpage: dump extra subpage bitmaps for debug")
CC: stable@vger.kernel.org # 6.6+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 631d96f1e905..f8795c3d2270 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -902,8 +902,14 @@ void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info, struct fol
 }
 
 #define GET_SUBPAGE_BITMAP(subpage, subpage_info, name, dst)		\
-	bitmap_cut(dst, subpage->bitmaps, 0,				\
-		   subpage_info->name##_offset, subpage_info->bitmap_nr_bits)
+{									\
+	const int bitmap_nr_bits = subpage_info->bitmap_nr_bits;	\
+									\
+	ASSERT(bitmap_nr_bits < BITS_PER_LONG);				\
+	*dst = bitmap_read(subpage->bitmaps,				\
+			   subpage_info->name##_offset,			\
+			   bitmap_nr_bits);				\
+}
 
 void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 start, u32 len)


