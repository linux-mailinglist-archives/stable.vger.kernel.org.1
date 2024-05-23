Return-Path: <stable+bounces-45959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9866F8CD4BD
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5298C283411
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F5014A4DC;
	Thu, 23 May 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtEjefmp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464D013A897;
	Thu, 23 May 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470999; cv=none; b=Yejt0hxtLYkjWtQz1VVEx4cGpZrNxjnMzz7YFXq5vf6QK6zCNPZ+eukARB00Sm8QDm+6SU4Q5G3/XKWBNpVLAhyBtb2fQ+eCToJtJfjAOYu4vMrp9anI8duGJ5XEZrFPjNCaJNjiMIzn7+/3yOcg1zj3iadNA4grA9SN7bBMdQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470999; c=relaxed/simple;
	bh=Rk4yXUP9gRTWbd2b0oejhcUnoZA8VySiJ7FWn7BIDGU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qZS3YLhFE7TZ/PUANf9Tl8DxiQgqplVyEfiYOFUbjO9Gh8UmkqzZPkG/wm6oyhSGt/Bd+6pkbCFj2RUaP9papSNVs0SQofzRm8VoTal6MIxHMZ+feKgctr/RlXz7gxGNpCSd+7s7CC6gMACuT0B70hkzG16goGNMYvjX7vGptUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtEjefmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A8BC3277B;
	Thu, 23 May 2024 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716470999;
	bh=Rk4yXUP9gRTWbd2b0oejhcUnoZA8VySiJ7FWn7BIDGU=;
	h=From:To:Cc:Subject:Date:From;
	b=YtEjefmpxgRonDoRO53ZOxb0h9X1hV1MABIRTkpEcM46Fdu7FjXI2mZZXdX+2m2Nu
	 gzLkYAJe9ws3crPFQqXzYzrX+fgu+oifo1GrCAlJzDQLaNSGmjZA7pkX9Or8UwWcBG
	 HurnlUeJCuT060TU+kxrTlk4md+95Q2HoyWJoc4HWc9gSG14KpFuLMGacmM0/NMRlE
	 4VDbWSEmQPJ6/YOYQc5AS2XsxBR4yJxpv7Vc4s9nYqjb9uuoB+1+jNP8KAaMuWmgsH
	 HPFE8+7iOd47xNbmfEk/BGIewPeFKzkGzjZMzoLjHZOUAQkYo9/YZzyznnUful6Xwo
	 8dlJNjnq7+Tbg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH] f2fs: fix to force buffered IO on inline_data inode
Date: Thu, 23 May 2024 21:29:48 +0800
Message-Id: <20240523132948.2250254-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It will return all zero data when DIO reading from inline_data inode, it
is because f2fs_iomap_begin() assign iomap->type w/ IOMAP_HOLE incorrectly
for this case.

We can let iomap framework handle inline data via assigning iomap->type
and iomap->inline_data correctly, however, it will be a little bit
complicated when handling race case in between direct IO and buffered IO.

So, let's force to use buffered IO to fix this issue.

Cc: stable@vger.kernel.org
Reported-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index db6236f27852..e038910ad1e5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -851,6 +851,8 @@ static bool f2fs_force_buffered_io(struct inode *inode, int rw)
 		return true;
 	if (f2fs_compressed_file(inode))
 		return true;
+	if (f2fs_has_inline_data(inode))
+		return true;
 
 	/* disallow direct IO if any of devices has unaligned blksize */
 	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
-- 
2.40.1


