Return-Path: <stable+bounces-128604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA5AA7E9C1
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0D4172947
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2517D254AE1;
	Mon,  7 Apr 2025 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOShRb9+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE823254876;
	Mon,  7 Apr 2025 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049479; cv=none; b=Z2PVPhQe1+rgkQOs1izWhKVsEqLF2WEEbBDusr421FJd1f00IAmlh8/v/kEWVG2SoAjHJHsXnVelNHYo/RJ2mAZvvS0FK61M7UQ9HQiPJDJZmbcFaPAmP0lv1zXZxPSVbsAcmpftgz5RfSInIT2mET7FRFHtvJS2/OBQyHeRwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049479; c=relaxed/simple;
	bh=XE7uARy8TrDfHVYd19jG/8rCCQVFqJnfrETDYgva40Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D4lLWmBSIETxVJU3A/IYY3AVNVCHyAZqOxnjqlUGkhr8XpieHtyUCXNyJavML8yy3ZP/I1ZvXL5wRIfd22lsiHckMgBl0Wva9kplIu2PTdPGLfCEsq0niUdkWFWMcfNrBYMvNB56Uk11YiCox7mKQ8mvxJGbL+4L9lOCY/bqTeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOShRb9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82312C4CEE7;
	Mon,  7 Apr 2025 18:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049479;
	bh=XE7uARy8TrDfHVYd19jG/8rCCQVFqJnfrETDYgva40Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOShRb9+dBSn7eXIU4/mxrQgXE8E4GktzB5PSh0Z9g7sCtOjkeTKZ+Z2mx/WhrFn+
	 l4McBou+yLxbN0cs49iZ5jQsI0+9xa/vxSqprqFl0htzDo+9tbG7wms1r/7ctB+j6S
	 vXUxq/yf06+5fgwsiaWWJlgTFPtkHQ+VNrsoXeH6pXGrfYg0cpPCpjzv+VJaBkq+/a
	 AlV3vGv0NplgkzKcYzaDO0j9/BFgHMmxNhV9FgE/6XdMb7AI1C5QqW2UFUHFmN7/8k
	 65gGTXJ1LkE0IUI9G/w7NLLyaJ0n3j22n4z51xzYSk3dC0XIwuLNcoZlj/NkylIq7l
	 ZS8mLJMLSXJtg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 07/31] fs/ntfs3: Fix WARNING in ntfs_extend_initialized_size
Date: Mon,  7 Apr 2025 14:10:23 -0400
Message-Id: <20250407181054.3177479-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181054.3177479-1-sashal@kernel.org>
References: <20250407181054.3177479-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
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
index d3a31bad21f9d..4d9d84cc3c6f5 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -412,6 +412,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 	}
 
 	if (extend_init && !is_compressed(ni)) {
+		WARN_ON(ni->i_valid >= pos);
 		err = ntfs_extend_initialized_size(file, ni, ni->i_valid, pos);
 		if (err)
 			goto out;
-- 
2.39.5


