Return-Path: <stable+bounces-128682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E726A7EA74
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01AB188E956
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12D926562B;
	Mon,  7 Apr 2025 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAXNwQzJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B1A265624;
	Mon,  7 Apr 2025 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049663; cv=none; b=h9dNn27XQ2HPl/Xhz3m6fh3T9tp4tUs7yPEtAoD4jQN4ea4tbQ3lfspXWt2IdhpFNae6Nk2Hc8ssLrJQdXd7JWjTd30G2Ma2z2YP8uWZ8xFZsTVbx3v0X5Mz8FhXll/nchgsdrJWZH2ZzuH6/fYOnOD1CoP8SCqLh5cFPDjaF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049663; c=relaxed/simple;
	bh=2DXTB/+he9rBJW+Wnf2nKqO6DyEMzbVKsBULcUOYIQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ns79w1nEwXo502d9FroXa8tQyEZDLH4Wpx9MbU+211Q+K6fzrTmHsQcG4hn/0inqpaXqBfdjivyNpr7ivj9lTb/Bt+RODUXPEVKiKE4yq4WDJqbiQX+QyB97EoiZBTfgB/rguBzdWAhM9bhJEZrh0FuxkWAbwn/IfPdg8L5Wt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAXNwQzJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC472C4CEDD;
	Mon,  7 Apr 2025 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049663;
	bh=2DXTB/+he9rBJW+Wnf2nKqO6DyEMzbVKsBULcUOYIQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAXNwQzJ6Suop2Tt+OuabXcpC3eDPzOoqhx+MlI6pfsgXFDLkotj6P0MPSWLXNNTY
	 nisVBfvg2Oak6uaG7/jfPqUq++TMCkjhcrFcV+Mc6E8+0hsx/miqo03ZKBPLdZQbv2
	 7fUDge4vUSpFEyTnKqQo6BuW4JYlSRTC2Djf3CPI7yvZNosWuI+GCKpHZH8BP4wLr7
	 CXkjMQAoxZCl6iw2D9aJ7kXrPr0qY7wLsycV2tvKTxv3LQ3qZ2H93Lyjsf3aTL5TGb
	 4lCml07rfBpwexYYAfYhy5DfLdin1YS5z7mDT38YuVRQaR+YJIaQQq077kxHd4UbQU
	 xqeGTS//sahYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 02/15] fs/ntfs3: Fix WARNING in ntfs_extend_initialized_size
Date: Mon,  7 Apr 2025 14:14:02 -0400
Message-Id: <20250407181417.3183475-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181417.3183475-1-sashal@kernel.org>
References: <20250407181417.3183475-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.86
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
index 2ecd0303f9421..4aea458216117 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -335,6 +335,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 	}
 
 	if (extend_init && !is_compressed(ni)) {
+		WARN_ON(ni->i_valid >= pos);
 		err = ntfs_extend_initialized_size(file, ni, ni->i_valid, pos);
 		if (err)
 			goto out;
-- 
2.39.5


