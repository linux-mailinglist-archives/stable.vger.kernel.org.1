Return-Path: <stable+bounces-128661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE609A7EA6B
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEA3443C8C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FDB25F7B0;
	Mon,  7 Apr 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyJeMUan"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2513525F7A1;
	Mon,  7 Apr 2025 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049621; cv=none; b=m3fE4YDmUZEOdriT7DS9/6RSakP7+BjFihIWru/SsIuq5A+F5FkvUHoOi424lSJDYJfUGOSzkgsXBDjFu5Lk/hLlSjH3BEO5s28RrN3ESEAKEYmHfI5a1ggquzHBtMFf0ZpHXECM7Rnq9uEsLcWT3LPq/5DtUlPirwt9E3jRJus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049621; c=relaxed/simple;
	bh=elxLAKKp8j6ZCIT0dvsNLUQT3EdRnCS04EG7mh6WIfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i7TU91RrdBStBNJxDuspqo+t7/E3Ht5xTAjTYl81HZIw4wwI3QfPpdShpJ2svWbmXEGORn+oWvQma3KEbupmc7E706ecjoc51o7R/qpiDrIn+jSn9O0ckEPcST7xqb/NKRKmNbHhe5FMWWa/c0hMTqgqLgqt4rVGISWWwHA6UZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyJeMUan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33911C4CEE9;
	Mon,  7 Apr 2025 18:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049621;
	bh=elxLAKKp8j6ZCIT0dvsNLUQT3EdRnCS04EG7mh6WIfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uyJeMUanZ4ltiZugiuwtPgdpM62JXTf3rPspM/5ZxZuBecMsBKEYsfiYifqPttP+y
	 NUIEVXo4kZOfK0DAo8h1AJeJDxRL6LxyNRu+ME7NhIwrVIzMmjI44DYXe5U+W5NwGu
	 mvTStl134ogXa5SzSBqzTAEo2lO1mU9+4IGxALLu2Bx8mOLmn7qSTmvXI/akQp/EtE
	 b4ENUW6VtUd/9MVoLe4LBKp1Z9lsrCO3B5+6Bm0YtqER8OP9E1IGYNNbnHb4jpxSxl
	 ST2V73b9DrVTzt+mr9vDc1GAHv1H8vjEjUPVTnsbiGfdzIfrLjDvWKMup7DBqXmqgY
	 0nWCcwk5oH+Vg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 03/22] fs/ntfs3: Fix WARNING in ntfs_extend_initialized_size
Date: Mon,  7 Apr 2025 14:13:13 -0400
Message-Id: <20250407181333.3182622-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181333.3182622-1-sashal@kernel.org>
References: <20250407181333.3182622-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.22
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
index d537b1506dca5..bf685392996d1 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -410,6 +410,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 	}
 
 	if (extend_init && !is_compressed(ni)) {
+		WARN_ON(ni->i_valid >= pos);
 		err = ntfs_extend_initialized_size(file, ni, ni->i_valid, pos);
 		if (err)
 			goto out;
-- 
2.39.5


