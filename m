Return-Path: <stable+bounces-138657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062F7AA18F1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 20:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170EF1BC7353
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CFA24633C;
	Tue, 29 Apr 2025 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x4zbPEex"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E4B21ABC8;
	Tue, 29 Apr 2025 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949942; cv=none; b=dePR/YPtlS7IMHS43cU2VFpXSjAO2PDbrqYaXP+qbkoSDP0r9J0PJIELH3o/GpEkQp9aiB0PLyKkd8XPb6n14ADkOfzYfTVuoDOoZ9Yu3TuE+H6UVQgX4QYciJIzfp0T5Ug6n4yYj13FY/YNBkhGvhlAFcmu3i0zg3n1V+IVtuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949942; c=relaxed/simple;
	bh=AHqcK4mrqYJrgNk3h1GAd6vVztWwS+qOsoHWBuSn5b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtp+eZxJcHyqyG0dxIlhKKHVR62z2P/rrowN8OJ+0/RVKtMDifIUc81YkVxzFzriVV1m11j/dvP04khZ4tEzpBK3MWnVYN+coRrQtk+efR9J7Xf9fMepOdsh6IKXs6k9IX5aHGdNYotz2TInTSe9nqoNhx7k66UpwYQezfrRWrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x4zbPEex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710CDC4CEEA;
	Tue, 29 Apr 2025 18:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949941;
	bh=AHqcK4mrqYJrgNk3h1GAd6vVztWwS+qOsoHWBuSn5b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x4zbPEexOjIikIWHSIgeP7jjH0pwUrVDcJDU3HvKjjN/8+J7Iq0hxlOrU/L4pky39
	 t5DIe76LFMGwDnSJGx3fik2y1jlfVcnZMb3nkCA8M0kT4hXyNuwDAVA4DPfWRkay4f
	 keHkpAw9gl5/6hyDtQmmc/EKf77xu9Azv9nbb+kM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edward Adam Davis <eadavis@qq.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com
Subject: [PATCH 6.1 106/167] fs/ntfs3: Fix WARNING in ntfs_extend_initialized_size
Date: Tue, 29 Apr 2025 18:43:34 +0200
Message-ID: <20250429161056.033285991@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161051.743239894@linuxfoundation.org>
References: <20250429161051.743239894@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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




