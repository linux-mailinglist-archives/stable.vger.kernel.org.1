Return-Path: <stable+bounces-128711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EECF6A7EAD2
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338951889E8C
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0ED2698B9;
	Mon,  7 Apr 2025 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZF+E8iq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F522698AD;
	Mon,  7 Apr 2025 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049723; cv=none; b=T1PTWg2qzZoQ59yJAbxIddF74C+zkLY0dPk8f5dVErC5AtpgiFJx3CKOBx8UO1tlmz8nW829sv2qP4sAxqOX/eOfE1m7ajhX/ehaTo1NP1qCib2N3LpVbNoAQLDCWA6fJc+Ho0SkNSKhgHh3b2r+fqSdxcUKu2wO8IUpWZTOdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049723; c=relaxed/simple;
	bh=vRa1TO2Rx5LoC2wlUI1YrSfJryZk3hAm+vk+Ej7ZReY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VvKchJFnKsmL7irtai7kWyI1+xnV7uxOedS0GU80q6repwUcY/Vu6eP0xDBTH5ocR6/BgE/symp7GdBSaaTIfOnTNyvB3fI6hMXJDf9mZgiY0pRrKB0+twSllJu/WMNpgDeb43JQUEhebgDAELRIHmFZquS3peqfc9h2B2O2nV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZF+E8iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C245BC4CEDD;
	Mon,  7 Apr 2025 18:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049722;
	bh=vRa1TO2Rx5LoC2wlUI1YrSfJryZk3hAm+vk+Ej7ZReY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZF+E8iqcAlm3JAJdCj1Y9epb3XqbQRN2+CW5BWRKdbmT0L1rbWvoIcA6/8b6va94
	 My3blRk0pw2qAktAS7w5XcYe4J63R37Hxt5spHYoeFmfwXD+lft1edH5pxDFwQ2Rkf
	 EcjqHDFzlbFs6ntfcFSo2y5vTtAmJ3hKYQGYAWnAhHqepIRmkJypLE/z8IwdGz/xGQ
	 IbCcX9leILDTP3Y2TfUkG6wBMlI8UXA9t3hwh/QVP7nT3L0iZT+UEpb3a2AmAGZsXf
	 5XCU83Fwnri3slqTpxYIrEPhT30UEO49NOQ93P5Pjobv+cogBsDX6jcp/6M8FRt3aU
	 C13lIrPZFgFhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+e37dd1dfc814b10caa55@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 2/8] fs/ntfs3: Fix WARNING in ntfs_extend_initialized_size
Date: Mon,  7 Apr 2025 14:15:08 -0400
Message-Id: <20250407181516.3183864-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181516.3183864-1-sashal@kernel.org>
References: <20250407181516.3183864-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index 2d5d234a4533d..74cf9c51e3228 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -435,6 +435,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 	}
 
 	if (extend_init && !is_compressed(ni)) {
+		WARN_ON(ni->i_valid >= pos);
 		err = ntfs_extend_initialized_size(file, ni, ni->i_valid, pos);
 		if (err)
 			goto out;
-- 
2.39.5


