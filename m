Return-Path: <stable+bounces-128697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4D7A7EAA3
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A52D7A5EE3
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0207A267B64;
	Mon,  7 Apr 2025 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLmBwDfa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22DD267B1F;
	Mon,  7 Apr 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049695; cv=none; b=fyQ9b6eB4LWEbeiLZJX60CORnikVaIjs9zjHOjLvfYGxVLDOeH7KB7Zox+ryUbxnKnMerVsCdIB0RRU+bfyIuXcIy2PMQ2/dcc9fKV7nkCoQgyim1eNm/hAUAofdhqxSMLWpyFUuB4lSA7yhkFw0RABZODncVtMMiee+FeDgRUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049695; c=relaxed/simple;
	bh=nXY8em9monBQsY1lfRU5oYpVAbgufBykXkdRAmedgp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hzEanhX15aDX8h6SacWSyA/yy4FPXQYksh6Un/Q9V375ip+4aBiDSs5v6voC2adjMZuIVhnv9qPrfVVgD5y+o6vU8wzM96NgrBnkVPtISD+MTnKdaCMjT7sY4jtQbfewEhLgcyBcp9Upx10v3bVj95HK0vepaJyT0iVJOybwD6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLmBwDfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE54C4CEE9;
	Mon,  7 Apr 2025 18:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049695;
	bh=nXY8em9monBQsY1lfRU5oYpVAbgufBykXkdRAmedgp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLmBwDfa8fMiR1CMn3x76cU3JGHulzjaNOG85lrBOjcAIYPpNnU3i8glKqq8Oyh7W
	 G5rWna7f6Rphn32DsNcQr0nAId93c0l8l3BTqAaJeTUyhBCN8VPdlxqkgtTiCOd/y/
	 PFf5lwBWD/SkIU4IaCFBj2AjpWHShvnb6mNmK3AEkkhYKLGV4rg5SGEdOZ7ts2i4uY
	 8eBEurN07j5EHhLS6DX2y2O6joP8P83aQSnmH1p1ad/6lU0//3mzZ7PxbCal2OGcMe
	 rECVaeBfQQ2tGRakbnV1jjA5JTINGIVThqJzrvhMtonJ3IT7BBlejZxnBfc8OUHFu/
	 LvuSkyf//ZtAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 02/13] fs/ntfs3: Fix WARNING in ntfs_extend_initialized_size
Date: Mon,  7 Apr 2025 14:14:36 -0400
Message-Id: <20250407181449.3183687-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181449.3183687-1-sashal@kernel.org>
References: <20250407181449.3183687-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.133
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit ff355926445897cc9fdea3b00611e514232c213c ]

Syzbot reported a WARNING in ntfs_extend_initialized_size.
The data type of in->i_valid and to is u64 in ntfs_file_mmap().
If their values are greater than LLONG_MAX, overflow will occur because
the data types of the parameters valid and new_valid corresponding to
the function ntfs_extend_initialized_size() are loff_t.

Before calling ntfs_extend_initialized_size() in the ntfs_file_mmap(),
the "ni->i_valid < to" has been determined, so the same WARN_ON determination
is not required in ntfs_extend_initialized_size().
Just execute the ntfs_extend_initialized_size() in ntfs_extend() to make
a WARN_ON check.

Reported-and-tested-by: syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e37dd1dfc814b10caa55
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 72e25842f5dc9..46eec986ec9ca 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -354,6 +354,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 	}
 
 	if (extend_init && !is_compressed(ni)) {
+		WARN_ON(ni->i_valid >= pos);
 		err = ntfs_extend_initialized_size(file, ni, ni->i_valid, pos);
 		if (err)
 			goto out;
-- 
2.39.5


