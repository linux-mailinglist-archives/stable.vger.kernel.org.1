Return-Path: <stable+bounces-128634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C812FA7EA27
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77A93BD94D
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4B125A329;
	Mon,  7 Apr 2025 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyxsU0fe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5325A323;
	Mon,  7 Apr 2025 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049557; cv=none; b=pjdDix+X5ppmiIFyBg4j9paZWD5sDAQR+VroQaoz7hkqCbQkanbB22sYKDZp/ypnSWegowBcfZGk5RQdRilx5jkRKHp9JJIpL63V5WKNKBja/pYRBv4jRzt5FRudOWqpkqlQFSH7vV2MZjApv3MYxGVe8UZFpMofGSTkT/M3kwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049557; c=relaxed/simple;
	bh=XE7uARy8TrDfHVYd19jG/8rCCQVFqJnfrETDYgva40Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ok0+u8NfZxNWbMG35yBPGgvz+S181oEUvagRPsRFmx9qf85SNw0cr8THLzh+XQ5JAS/LPXksNGux7GjMRD8VqvpzZ9fjBp1unAiDlrxYs2GqqmsuQsjNUZ3mdWwyr2lgPf0HsImFbZxoBu+Zb9xlIhSbxsfF5/XwBApuXtKtqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyxsU0fe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78A7C4CEE9;
	Mon,  7 Apr 2025 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049556;
	bh=XE7uARy8TrDfHVYd19jG/8rCCQVFqJnfrETDYgva40Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GyxsU0feoYsgAIMWNjc52VAexmBqEMy3XQiKDYwJyjBGOMVM0Ft98Tyc/Cl2TFn0M
	 Z9ZG/2Qw1XwXwbQd28q/1cgvKYUBR7kEi5LVQDChvAo7w7++bvh9tvbHtykvZR1Yxb
	 hKrohvGAOLeDQSVj/auU/IOWkAq8nzRRfgCS1pVZ8rCGV3CDghFoXQKdf84eFt7Dq9
	 LmoQ/XlzjjA4wSGBAZ03L4j/iKAZVhxIG91npd93Lq+yE/hTtqiHYFipdjrKA8urcp
	 LyvoSuH8F3P2EgghEo+fXuedP3OzXxsKy+z95mwjVNlEPkfZ/FdUUiIirgWbGT7TpB
	 Ymkag6+aO/n6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 05/28] fs/ntfs3: Fix WARNING in ntfs_extend_initialized_size
Date: Mon,  7 Apr 2025 14:11:55 -0400
Message-Id: <20250407181224.3180941-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181224.3180941-1-sashal@kernel.org>
References: <20250407181224.3180941-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.10
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


