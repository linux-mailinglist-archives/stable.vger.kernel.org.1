Return-Path: <stable+bounces-84480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA51799D067
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1791D1C2343B
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB1E1B85DB;
	Mon, 14 Oct 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E2ehSwBZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0871AB6FF;
	Mon, 14 Oct 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918156; cv=none; b=PybQ6fzFMkzgZSaS1OIm9q9aXo4WpAWMBA2LGMlaE9+P89ZdbrKtNSUO7TBVC2pqSRfuoc3s7u0dLk7CaH93md1mOszc3cRnMEmjWB38kEd+WXfm2XE1iRujQwB9Wp8U7iLN8rX1aedvqNT8FwcvwRWYQ5ignOj4/0PI1kdcO4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918156; c=relaxed/simple;
	bh=vJfCOaii6gbZcenaFId91+WRmT6TvA/ffJ4GGMg4gm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgRK1cZhARDR9XTelqk3AQJLP4jKCwouB/Eu9k6Rl/e3HX/6o6R8wWRmBVLCPTF38uthnRo9nUxBfRXRH/jZezyA161lvhrH3VjDVxkUN1EflLft+6uuJM8UUvPnKP0r8eZh0GAhOhBFJJxC5lKSaZUPRx/HI/4a7IZCNaU2HpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E2ehSwBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6C4C4CEC3;
	Mon, 14 Oct 2024 15:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918156;
	bh=vJfCOaii6gbZcenaFId91+WRmT6TvA/ffJ4GGMg4gm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2ehSwBZM/ruvVcRalWeS8L+l/mMbS4vdK1galfknpJ1NagFk9Bg0XXF4rorZ6dtI
	 qksVcbjTi4wZoRiNaNIGKEKs20whynZkzvbOmE7dKeFHehY1Z58HvEwVtDgZ/huuHn
	 qBkumxokw1Ts5DUBaRQH3tELNsGaXaPFoN4fAIWQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 240/798] f2fs: atomic: fix to truncate pagecache before on-disk metadata truncation
Date: Mon, 14 Oct 2024 16:13:14 +0200
Message-ID: <20241014141227.348059295@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit ebd3309aec6271c4616573b0cb83ea25e623070a ]

We should always truncate pagecache while truncating on-disk data.

Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c9f0bb8f8b210..8a1a38a510893 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2171,6 +2171,10 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
 	} else {
 		/* Reuse the already created COW inode */
+		f2fs_bug_on(sbi, get_dirty_pages(fi->cow_inode));
+
+		invalidate_mapping_pages(fi->cow_inode->i_mapping, 0, -1);
+
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-- 
2.43.0




