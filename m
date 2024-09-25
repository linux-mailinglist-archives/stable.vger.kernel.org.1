Return-Path: <stable+bounces-77486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8621985DB6
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801C2285651
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBBF21C17C;
	Wed, 25 Sep 2024 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ6j/bfy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7721C176;
	Wed, 25 Sep 2024 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265991; cv=none; b=cdqo2r4vKEZMMvDguRgFydRkVzHSwG9aDS+uQwymVnoq6U1eZWxbjwCymFcbybo/oR7MjRZ90a18v39QnpVw7nYnGDRWRnYjyDsAFN22mATFZAme0YqJ0HTSkyUjbOA3EAG7cu9YYzrY+siOvK1kJN1Ve+4uk1SpyABGk1nSR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265991; c=relaxed/simple;
	bh=EO3zMFmMKBLdYWvuMS3VyKOlAkOlRsoa9ugS8Fsa7MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dThx6GqbKfEXn2IozsGXaQi8Z6bfW8ubyzAui9+fBHzBc3V+BCXPs7onR2soMr5p5Qqi59ojnm16xszJE3S9YO6p1RGlOOTfkMc+vH4YoPVfGG1tu0gbcB5qLFCEWilT/qXt5OB6mwuPh9Ic+mG2XNxmVSi/LJJ0o2KxOyMSdO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ6j/bfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463A1C4CEC7;
	Wed, 25 Sep 2024 12:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265991;
	bh=EO3zMFmMKBLdYWvuMS3VyKOlAkOlRsoa9ugS8Fsa7MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NQ6j/bfyXJcp0d4tsoLZfV5ZJKYL/W3adW2fYFW/pYGWmEldWU+jS7cPJwgZEoZdV
	 /AnoEFONTne2wXYE+2yhST+tcqIk2at3IumYZjQ8bHX8z+FdobGftKUUbBfisA5g8a
	 kF+0U5hnHJxf5w1K0EpSIBC3dtRgNDVOZtYBu+FiHHXaDqMd3uidoEhvUofFDf7jb4
	 fkEnbXiCmxLzk/hssI0NwZvG7/nMsgz/1Ac81NJPzwzSamQBV0RkvHQsoDSKQa1ALU
	 4h4dB4oylQSFXyv3d6USQC2ri5zVd9v8BE0PdJAqmijOeZ18NkqkOM/iC1ioQnamyy
	 gW0xSdNL7dUEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhao Mengmeng <zhaomengmeng@kylinos.cn>,
	syzbot+02341e0daa42a15ce130@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	gregkh@linuxfoundation.org,
	walmeida@microsoft.com,
	llfamsec@gmail.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.10 141/197] jfs: Fix uninit-value access of new_ea in ea_buffer
Date: Wed, 25 Sep 2024 07:52:40 -0400
Message-ID: <20240925115823.1303019-141-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

[ Upstream commit 2b59ffad47db1c46af25ccad157bb3b25147c35c ]

syzbot reports that lzo1x_1_do_compress is using uninit-value:

=====================================================
BUG: KMSAN: uninit-value in lzo1x_1_do_compress+0x19f9/0x2510 lib/lzo/lzo1x_compress.c:178

...

Uninit was stored to memory at:
 ea_put fs/jfs/xattr.c:639 [inline]

...

Local variable ea_buf created at:
 __jfs_setxattr+0x5d/0x1ae0 fs/jfs/xattr.c:662
 __jfs_xattr_set+0xe6/0x1f0 fs/jfs/xattr.c:934

=====================================================

The reason is ea_buf->new_ea is not initialized properly.

Fix this by using memset to empty its content at the beginning
in ea_get().

Reported-by: syzbot+02341e0daa42a15ce130@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=02341e0daa42a15ce130
Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/xattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index 2999ed5d83f5e..0fb05e314edf6 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -434,6 +434,8 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
 	int rc;
 	int quota_allocation = 0;
 
+	memset(&ea_buf->new_ea, 0, sizeof(ea_buf->new_ea));
+
 	/* When fsck.jfs clears a bad ea, it doesn't clear the size */
 	if (ji->ea.flag == 0)
 		ea_size = 0;
-- 
2.43.0


