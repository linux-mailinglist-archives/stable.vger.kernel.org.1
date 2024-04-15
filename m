Return-Path: <stable+bounces-39777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8458A54B4
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E753B243C9
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB58F2A8D3;
	Mon, 15 Apr 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wutytgjK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B211E4B1;
	Mon, 15 Apr 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191782; cv=none; b=Hm8FZsu95tzQ797RT7IsxmzpGkf4NfhpEsxHBQnyCMoXEcThgGEX0mWwjmZVkNI8O3UlUJ4+zTI+wRJWPizcb1RJy+cDNqH+98n3EE6aRfPBoOhigHpOxgMyTbr6IJLywI98Vw0dtH1SEslPxP+qlOcL9pec0Qtytqz1Latni+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191782; c=relaxed/simple;
	bh=BoYu5BjcFDcfL7vBOMA5m2pBCi61aJ6d19XQaKljkhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0sJixURpqOGUR41WZtaiVxvl8pYfvEx5epKEx2yg3GF5mvQ80wrtE2sJEjYh2F98jM/A5BnP1keLuBQbYpzOgSjpNUddgNluEr14Ex1YHYpe/OUJp3PYKaMhEqQ0/JvJhRo/Gdc9HLUw/EQf8sf8hoy7JOSMg+05Ytyx3doNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wutytgjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3714C113CC;
	Mon, 15 Apr 2024 14:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191782;
	bh=BoYu5BjcFDcfL7vBOMA5m2pBCi61aJ6d19XQaKljkhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wutytgjKEs/nKhBv9duQiA9kRzkyUA8gLUb9Ze1Afz2XedRLQTs22Ty9eiP0w1nlU
	 nCo6MClZXPG+7+1Na1xEHVoeQ/U+AORd1FyXXNCZRlRPMgbWP0n0ivtA/hWsmT/Ggc
	 VFuqNAx+LW2OKsIYKWKFOzVpArqmJkG5grIF0wBE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 082/122] btrfs: qgroup: convert PREALLOC to PERTRANS after record_root_in_trans
Date: Mon, 15 Apr 2024 16:20:47 +0200
Message-ID: <20240415141955.836560883@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
References: <20240415141953.365222063@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Burkov <boris@bur.io>

commit 211de93367304ab395357f8cb12568a4d1e20701 upstream.

The transaction is only able to free PERTRANS reservations for a root
once that root has been recorded with the TRANS tag on the roots radix
tree. Therefore, until we are sure that this root will get tagged, it
isn't safe to convert. Generally, this is not an issue as *some*
transaction will likely tag the root before long and this reservation
will get freed in that transaction, but technically it could stick
around until unmount and result in a warning about leaked metadata
reservation space.

This path is most exercised by running the generic/269 fstest with
CONFIG_BTRFS_DEBUG.

Fixes: a6496849671a ("btrfs: fix start transaction qgroup rsv double free")
CC: stable@vger.kernel.org # 6.6+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/transaction.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -715,14 +715,6 @@ again:
 		h->reloc_reserved = reloc_reserved;
 	}
 
-	/*
-	 * Now that we have found a transaction to be a part of, convert the
-	 * qgroup reservation from prealloc to pertrans. A different transaction
-	 * can't race in and free our pertrans out from under us.
-	 */
-	if (qgroup_reserved)
-		btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
-
 got_it:
 	if (!current->journal_info)
 		current->journal_info = h;
@@ -756,8 +748,15 @@ got_it:
 		 * not just freed.
 		 */
 		btrfs_end_transaction(h);
-		return ERR_PTR(ret);
+		goto reserve_fail;
 	}
+	/*
+	 * Now that we have found a transaction to be a part of, convert the
+	 * qgroup reservation from prealloc to pertrans. A different transaction
+	 * can't race in and free our pertrans out from under us.
+	 */
+	if (qgroup_reserved)
+		btrfs_qgroup_convert_reserved_meta(root, qgroup_reserved);
 
 	return h;
 



