Return-Path: <stable+bounces-105779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634D49FB19F
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B777E18848E8
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8B71B0F30;
	Mon, 23 Dec 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rhIRzvfm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723619E971;
	Mon, 23 Dec 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970112; cv=none; b=spXySADXAJrl0RQPRaTSVnk7+3HJ2bJT+ZXWdQco4Nwk7m+IVW+PQf5x0uPSxvrG4tU2E+hlxvEwUfgciAqcu5oB4rw7PIa7x+LPTcCzNDiYWpq22QPxBUrVuYUvQ4+o6nQy6tOEKwU1AR6RYMtxitDaGhqusLVZSLWKuQESwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970112; c=relaxed/simple;
	bh=GtFmunejWUNkg8eGRxqepe8mQkDwfbn0XkiJeyVMaqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJ8TL/a6lVAt4P5u5woAV/GaZv/4oNizPe6x7owzjr0UFtIIBVM4psay2G8JrhXEnX3tzLd84dESyk4DeqdJ4d4cg8WcLaJm50gfv2ZVwijf+JKGGYfCtDAv89zNG3czi1CE000lk9CVBP8SKs9SDWA6E/pVdCqPHXOccf/HWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rhIRzvfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40C8C4CED4;
	Mon, 23 Dec 2024 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970112;
	bh=GtFmunejWUNkg8eGRxqepe8mQkDwfbn0XkiJeyVMaqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rhIRzvfm0jm93XFPRXWcfFx72a2AvrObvESjm65RfpFbqWA//KC8OmtZ/JBsSOrmi
	 ZxqO1fZWtHaefIJPSfHqWpCerpiNPulNbj1suW95jz4xEaj0FnNGwjz0hKImufrDjv
	 v2j0Y6NLoaOSSnNEr9+D4f8hjOYMVQpbjnDOmNGo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frankie Fisher <frankie@terrorise.me.uk>,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.12 117/160] btrfs: tree-checker: reject inline extent items with 0 ref count
Date: Mon, 23 Dec 2024 16:58:48 +0100
Message-ID: <20241223155413.201795976@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
References: <20241223155408.598780301@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit dfb92681a19e1d5172420baa242806414b3eff6f upstream.

[BUG]
There is a bug report in the mailing list where btrfs_run_delayed_refs()
failed to drop the ref count for logical 25870311358464 num_bytes
2113536.

The involved leaf dump looks like this:

  item 166 key (25870311358464 168 2113536) itemoff 10091 itemsize 50
    extent refs 1 gen 84178 flags 1
    ref#0: shared data backref parent 32399126528000 count 0 <<<
    ref#1: shared data backref parent 31808973717504 count 1

Notice the count number is 0.

[CAUSE]
There is no concrete evidence yet, but considering 0 -> 1 is also a
single bit flipped, it's possible that hardware memory bitflip is
involved, causing the on-disk extent tree to be corrupted.

[FIX]
To prevent us reading such corrupted extent item, or writing such
damaged extent item back to disk, enhance the handling of
BTRFS_EXTENT_DATA_REF_KEY and BTRFS_SHARED_DATA_REF_KEY keys for both
inlined and key items, to detect such 0 ref count and reject them.

CC: stable@vger.kernel.org # 5.4+
Link: https://lore.kernel.org/linux-btrfs/7c69dd49-c346-4806-86e7-e6f863a66f48@app.fastmail.com/
Reported-by: Frankie Fisher <frankie@terrorise.me.uk>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/tree-checker.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1527,6 +1527,11 @@ static int check_extent_item(struct exte
 					   dref_offset, fs_info->sectorsize);
 				return -EUCLEAN;
 			}
+			if (unlikely(btrfs_extent_data_ref_count(leaf, dref) == 0)) {
+				extent_err(leaf, slot,
+			"invalid data ref count, should have non-zero value");
+				return -EUCLEAN;
+			}
 			inline_refs += btrfs_extent_data_ref_count(leaf, dref);
 			break;
 		/* Contains parent bytenr and ref count */
@@ -1539,6 +1544,11 @@ static int check_extent_item(struct exte
 					   inline_offset, fs_info->sectorsize);
 				return -EUCLEAN;
 			}
+			if (unlikely(btrfs_shared_data_ref_count(leaf, sref) == 0)) {
+				extent_err(leaf, slot,
+			"invalid shared data ref count, should have non-zero value");
+				return -EUCLEAN;
+			}
 			inline_refs += btrfs_shared_data_ref_count(leaf, sref);
 			break;
 		case BTRFS_EXTENT_OWNER_REF_KEY:
@@ -1611,8 +1621,18 @@ static int check_simple_keyed_refs(struc
 {
 	u32 expect_item_size = 0;
 
-	if (key->type == BTRFS_SHARED_DATA_REF_KEY)
+	if (key->type == BTRFS_SHARED_DATA_REF_KEY) {
+		struct btrfs_shared_data_ref *sref;
+
+		sref = btrfs_item_ptr(leaf, slot, struct btrfs_shared_data_ref);
+		if (unlikely(btrfs_shared_data_ref_count(leaf, sref) == 0)) {
+			extent_err(leaf, slot,
+		"invalid shared data backref count, should have non-zero value");
+			return -EUCLEAN;
+		}
+
 		expect_item_size = sizeof(struct btrfs_shared_data_ref);
+	}
 
 	if (unlikely(btrfs_item_size(leaf, slot) != expect_item_size)) {
 		generic_err(leaf, slot,
@@ -1689,6 +1709,11 @@ static int check_extent_data_ref(struct
 				   offset, leaf->fs_info->sectorsize);
 			return -EUCLEAN;
 		}
+		if (unlikely(btrfs_extent_data_ref_count(leaf, dref) == 0)) {
+			extent_err(leaf, slot,
+	"invalid extent data backref count, should have non-zero value");
+			return -EUCLEAN;
+		}
 	}
 	return 0;
 }



