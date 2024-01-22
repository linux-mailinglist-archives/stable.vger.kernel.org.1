Return-Path: <stable+bounces-14107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B1837F8C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B8429148C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8FB63409;
	Tue, 23 Jan 2024 00:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RFo75rJ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE31627E3;
	Tue, 23 Jan 2024 00:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971183; cv=none; b=cZbvSGzKHdlEEBvzasVr4USWioesuCg1vKh+uMxovNk5jiBIuri92JYHQA6knsAoF9a57VVqiEf+mQIlBSudSrvdocDK7wwYZG2ZtX75FGv+ZkhJ6IfZ9KmKj4yrSxlj+gr5P1JOhXdx8xAxALk37XxyjeGYA33teaXZzFiS9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971183; c=relaxed/simple;
	bh=FxX1+vH7VlhfXN6e04ssZ6Rsn7pGbprokYW55PC0HaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAgxawzfEcT8cwTFvaTmOpeeKXFit/Cs7AVjtyxqfj5faVZ4Xwl6JIoeCPz6WxTWCqZRMuwrPvOfMSoAbmm+jvPL0JgzL0RXHiLFVRAO/mkvs5wIF1SRVmdvgTXNJwUInaUv3ehGqZew7Bt83LBZ3e0pbzfsjuKs2Hr3EwlWSt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RFo75rJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FD7C433F1;
	Tue, 23 Jan 2024 00:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971183;
	bh=FxX1+vH7VlhfXN6e04ssZ6Rsn7pGbprokYW55PC0HaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RFo75rJ9vf8mAHVP3TY+wiD+i+SBvHQr88ZBQaIob2/4IzrYQiEkuWnH1CcZJoIZx
	 VXHnEzubgjLwc2WuUnrv2B3lcD1lygENVAode1/JeVWMxmnPtgx81rkN/rvQjIKEU6
	 MSOyJ0VQdHGO9tma+pg0n7AwIhUbqO6mozgxUSrk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 199/417] f2fs: fix to check compress file in f2fs_move_file_range()
Date: Mon, 22 Jan 2024 15:56:07 -0800
Message-ID: <20240122235758.826052750@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
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

[ Upstream commit fb9b65340c818875ea86464faf3c744bdce0055c ]

f2fs_move_file_range() doesn't support migrating compressed cluster
data, let's add the missing check condition and return -EOPNOTSUPP
for the case until we support it.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9b9fb3c57ec6..3f2c55b9aa8a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2821,6 +2821,11 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out;
 	}
 
+	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst)) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	ret = -EINVAL;
 	if (pos_in + len > src->i_size || pos_in + len < pos_in)
 		goto out_unlock;
-- 
2.43.0




