Return-Path: <stable+bounces-179842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD4BB7DE13
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792FE583E4C
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB4E1EB1AA;
	Wed, 17 Sep 2025 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eYRPSmYr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C8236D;
	Wed, 17 Sep 2025 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112573; cv=none; b=BrneFoe/Qh0CjSOvpN0sGA6kmEnBaykwI6w6PUIKgn1/9aToaQ8TYuj2cJYsrZXiM5kfmb/YON3LCG9Eo3RraP5rDTd9A8JSLGRurTZeUp+Nuupntii7qgkpIxs27zZI6K75WGif8xwAwQXqh4nzqX905I9NrTIstkFJ8/MsGvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112573; c=relaxed/simple;
	bh=y3Q+akLcrPa41NdCBFCUOTJXTcb5+5rRJ/OKOP8ZzVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEXLySazbsvuyKhrwQJ+Ic0BROT5OG3QH5nOEkUQj7eBrT9DWUDZcM/IXZY7cXSDSweyGKZdHiK5qgHyXV5+fu7ElOZGySDHuuOMdXOSFlF4frHRv2uCTGw7I/583fIlSNHA8aKsLShXnH4CbuZIiNr8amNjZKmF7hV0AEd5U6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eYRPSmYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD515C4CEF0;
	Wed, 17 Sep 2025 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112573;
	bh=y3Q+akLcrPa41NdCBFCUOTJXTcb5+5rRJ/OKOP8ZzVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYRPSmYrZVurwyJw1cY+oHK2BRcVFt3F9feFREZc+egJXy/21rM0E5IN06P2p9jnR
	 ifstOFkEEoIleGNXP+ij9h/J5C7J618TiIPiHCsUL6FUorGJb7ns3SjkKkW7WMAPxd
	 1LjTeUv0hh4KZsPgvnyniOLZpCYDU67qpu/iRZ3s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com,
	Edward Adam Davis <eadavis@qq.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 004/189] fuse: Block access to folio overlimit
Date: Wed, 17 Sep 2025 14:31:54 +0200
Message-ID: <20250917123351.956584397@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 9d81ba6d49a7457784f0b6a71046818b86ec7e44 ]

syz reported a slab-out-of-bounds Write in fuse_dev_do_write.

When the number of bytes to be retrieved is truncated to the upper limit
by fc->max_pages and there is an offset, the oob is triggered.

Add a loop termination condition to prevent overruns.

Fixes: 3568a9569326 ("fuse: support large folios for retrieves")
Reported-by: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2d215d165f9354b9c4ea
Tested-by: syzbot+2d215d165f9354b9c4ea@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f2c049f..5150aa25e64be 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1893,7 +1893,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	index = outarg->offset >> PAGE_SHIFT;
 
-	while (num) {
+	while (num && ap->num_folios < num_pages) {
 		struct folio *folio;
 		unsigned int folio_offset;
 		unsigned int nr_bytes;
-- 
2.51.0




