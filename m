Return-Path: <stable+bounces-141996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4DDAAD9C4
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 10:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468D7505598
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 08:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C0122128E;
	Wed,  7 May 2025 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTHbY5Xu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36019D087;
	Wed,  7 May 2025 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746605356; cv=none; b=q2y75LtD26cNiemBpGbBue1+I3ddi6f+ljzgDEePAQfDgQszPDyU/o1CUMjSZhRQ4ciZqccEpLrZeTeq9+fHsEI88P8kNve9oyFi3SzRBo30b0gEO0gI8r4TPdP1KE8LPOfF/UTKSEyF/IF+ISWtLa0RyMeDcq/jpXyqrWtYtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746605356; c=relaxed/simple;
	bh=QE7e2KY0A+q2dpAbO61o5sBZfaxAZhLRk3k9BFApyzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJt5BgKrzXMVCNdn1hkHxAXODgiZy3iHNleIi+OWUtBEcNSJ1frwt6UGIZKSdwQrWinaJUcyOH9p1AHWK4MGxpBmCZyFXifGRy8ZMxd9f8+cJCKY2aOb8a4ofeOAPQ0yMm8eBsfEBnOHRcnrv0406KC6Fa+zsR4N1N+vES6Z2fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTHbY5Xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DA6C4CEE7;
	Wed,  7 May 2025 08:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746605356;
	bh=QE7e2KY0A+q2dpAbO61o5sBZfaxAZhLRk3k9BFApyzw=;
	h=From:To:Cc:Subject:Date:From;
	b=LTHbY5XurQEDiBofBKW8WiSyrtIO2pcmDH9VCHGwB3qiimPrcNVxJUfSPtpXyXvhA
	 q8XgDDj2e919Pgw9PfyoXQBLNhN5RVvUL2f0d4IpQCYWvB3pOnFwBigDCgi0tSr9qw
	 tf1q+EFef6627grKzj9u2TN+UOiQVDFCtEK8AmRENF6652sl7G4Lv0wXthZ1/2RI3A
	 tqFltVgdbp0D5YPZ8AdXaHxpnCZDrwxqW1kEMHfbwwmVffjBIKc8W0evyaTb9o5kd1
	 lOkQq/hTC4mwckyrqEFotoK/R/Q50JIombVSMvpVC8BV0of+MWBJy7m/DbwCtxqZ3u
	 hraE1Ih5+3Iew==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] f2fs: fix to return correct error number in f2fs_sync_node_pages()
Date: Wed,  7 May 2025 16:08:38 +0800
Message-ID: <20250507080838.882657-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If __write_node_folio() failed, it will return AOP_WRITEPAGE_ACTIVATE,
the incorrect return value may be passed to userspace in below path,
fix it.

- sync_filesystem
 - sync_fs
  - f2fs_issue_checkpoint
   - block_operations
    - f2fs_sync_node_pages
     - __write_node_folio
     : return AOP_WRITEPAGE_ACTIVATE

Cc: stable@vger.kernel.org
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ec74eb9982a5..69308523c34e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2092,10 +2092,14 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
 			ret = __write_node_folio(folio, false, &submitted,
 						wbc, do_balance, io_type, NULL);
-			if (ret)
+			if (ret) {
 				folio_unlock(folio);
-			else if (submitted)
+				folio_batch_release(&fbatch);
+				ret = -EIO;
+				goto out;
+			} else if (submitted) {
 				nwritten++;
+			}
 
 			if (--wbc->nr_to_write == 0)
 				break;
-- 
2.49.0


