Return-Path: <stable+bounces-153377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A6DADD40C
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8111765FE
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A187F2F2353;
	Tue, 17 Jun 2025 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fo1j3oSv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3382F2346;
	Tue, 17 Jun 2025 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175763; cv=none; b=nZG/ctjMUXI3W7vos4CNYwQTiWToPBzh9rQFexNMnseJ/Z3tAwQaCHVR5Fd5NGw+vXU5t5rrU2CX/C20nMp7wni7MU5ZtkPZtYNkJ8/S1FF5JvBXBIbxGHoZ9RfTl3gseqkUuESz5GMLdyQuXX7F+u1QHeYSPp/l41ae9SlGaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175763; c=relaxed/simple;
	bh=MogzHdUdEzlVvhgFdYxuJwGJQbd8DtyZ0x5B0sQSBeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlwFgHVPXNaSEQ/ZaaVpacDjCGkNmaRzX9Nr/mbgmsHk3LkzRvESZyanXEkyPGrs9tIOIpKsiz5jqnBg5w+s7nie0eLP6OzGVzF2QUFhkIT3CkAizPcQoHVur7pQecp1F/IB3on50mxqHn5tpUzeaPqTv3wRBXi/+/8xCqdF1jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fo1j3oSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB03C4CEE3;
	Tue, 17 Jun 2025 15:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175763;
	bh=MogzHdUdEzlVvhgFdYxuJwGJQbd8DtyZ0x5B0sQSBeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fo1j3oSvSL9E6CjlipVGNkUIwttmCLIC07UdOezJz39bhsxJC9PwSVfHNpwb1jfMp
	 yWXjT/FzR5V/iQPJwbnWVM3g2v6tI127oIlbJDoQvYccersV77vOP3Luc/6Kb2Ugiq
	 a42jTwu0RutFTL6jtgh78CuoXzR4srO9hEAi38QU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com,
	Lizhi Xu <lizhi.xu@windriver.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 120/780] fs/ntfs3: Add missing direct_IO in ntfs_aops_cmpr
Date: Tue, 17 Jun 2025 17:17:08 +0200
Message-ID: <20250617152456.386125207@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lizhi Xu <lizhi.xu@windriver.com>

[ Upstream commit 8b26c8c376b29cf29710fbfd093df194cefe26ad ]

The ntfs3 can use the page cache directly, so its address_space_operations
need direct_IO. Exit ntfs_direct_IO() if it is a compressed file.

Fixes: b432163ebd15 ("fs/ntfs3: Update inode->i_mapping->a_ops on compression state")
Reported-by: syzbot+e36cc3297bd3afd25e19@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e36cc3297bd3afd25e19
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 3e2957a1e3605..0f0d27d4644a9 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -805,6 +805,10 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		ret = 0;
 		goto out;
 	}
+	if (is_compressed(ni)) {
+		ret = 0;
+		goto out;
+	}
 
 	ret = blockdev_direct_IO(iocb, inode, iter,
 				 wr ? ntfs_get_block_direct_IO_W :
@@ -2068,5 +2072,6 @@ const struct address_space_operations ntfs_aops_cmpr = {
 	.read_folio	= ntfs_read_folio,
 	.readahead	= ntfs_readahead,
 	.dirty_folio	= block_dirty_folio,
+	.direct_IO	= ntfs_direct_IO,
 };
 // clang-format on
-- 
2.39.5




