Return-Path: <stable+bounces-83696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E15099BEBF
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0BF1F22DDB
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864E7145346;
	Mon, 14 Oct 2024 03:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DycT9Gjo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3CC1448C1;
	Mon, 14 Oct 2024 03:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878331; cv=none; b=LbfFydZiaNWBJXdzXmoMTJPGAO3h4ycSdfpMEefBC+DHw5584oiNnQ3+ewQ57V66EblpZ8FEb/toEXDUG3LShmGgOs2K+lq6G/ZPBZOAst3E6Gq81DG6vpF55TXRJfqb3nBHU+rGEgvROY6d2a1UThwdGeq6cMAJpO2L8XzrPfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878331; c=relaxed/simple;
	bh=+pCTZq5gffnwaGyI/JHSLk7jHCYopxjr2+PXu0oiK6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tQLQtB97jPQJlXbMQeJCKmLWlvfT5G24LRH7KjWG3l69Urq2gx1SL8O25Zr1nMWjh3tLNsp75metXDEe2hXUELZiRgLY+/rqAo/BKxinGizs1znDcCv6iWzb48axVbATX3hks2ROt+pCa7XW3T6TUheHz4wpNtfegwQ0Uk7K7Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DycT9Gjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F25C4CEC3;
	Mon, 14 Oct 2024 03:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878331;
	bh=+pCTZq5gffnwaGyI/JHSLk7jHCYopxjr2+PXu0oiK6I=;
	h=From:To:Cc:Subject:Date:From;
	b=DycT9GjoPxIaU0BIyDncmcuVT+Y1SvwePfrR5F6iRGtOsHetR4zA/j2go+NBXNRUi
	 yKockxdcmMGHbMT2cj9qPUK1ckS4JAf468P7I1xtUtVf1Ofi8UQEMp8+w8pLqqdtyY
	 w2zHmbgfyYIYA22FcXzeMhXiZkTn9czwVt070UzfGKcdkDKNCkJaEdoCoN+7JXTSX1
	 qYligrq6O7j9XDCWU8XvLcwvJ65VQ/aTIkBA8DRlhTLpvunXqVGzRXPMcYDFlqoAlw
	 XdFRpzCMqrDV6pOag5/EiGew7OCvkU4EoZxUYC/GDuqhkDMJDV0nF4KBtkRlYAtXpp
	 UIVnb9PGdxHEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 01/10] fs/ntfs3: Check if more than chunk-size bytes are written
Date: Sun, 13 Oct 2024 23:58:36 -0400
Message-ID: <20241014035848.2247549-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Andrew Ballance <andrewjballance@gmail.com>

[ Upstream commit 9931122d04c6d431b2c11b5bb7b10f28584067f0 ]

A incorrectly formatted chunk may decompress into
more than LZNT_CHUNK_SIZE bytes and a index out of bounds
will occur in s_max_off.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/lznt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index 28f654561f279..09db01c1098cd 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -236,6 +236,9 @@ static inline ssize_t decompress_chunk(u8 *unc, u8 *unc_end, const u8 *cmpr,
 
 	/* Do decompression until pointers are inside range. */
 	while (up < unc_end && cmpr < cmpr_end) {
+		// return err if more than LZNT_CHUNK_SIZE bytes are written
+		if (up - unc > LZNT_CHUNK_SIZE)
+			return -EINVAL;
 		/* Correct index */
 		while (unc + s_max_off[index] < up)
 			index += 1;
-- 
2.43.0


