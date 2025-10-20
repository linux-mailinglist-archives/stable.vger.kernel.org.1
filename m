Return-Path: <stable+bounces-188051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB26EBF149D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFAC24E7DDE
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631FF2C0F7D;
	Mon, 20 Oct 2025 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bez7+S8D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AE258EF5
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964242; cv=none; b=u7MW0rli3hD656gbgTA4YDMdNt5kiCZl1Qpfnfj11P7mf+wYoq1UmmNdY1j1LMEJfcUZGSts7oLVuRv0VZtvLA3+0qobA8PLK+FUdehmzgMgnjEw3Q6q7sh0wMnWD38Oshw4Qyim1x4e5tjMwrBuNtLcx5drHiwsTvQ81FhBuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964242; c=relaxed/simple;
	bh=i3462GGfRqBmvWrSvGYR1FPVV1NKTZPiqszuBH0uHJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npsGDZuo3FiCVmt67hXiqy0gVwQp1vvx11P2v8Dmsl+51iEMwjsabm6vLoR3Cbi+tENm2MxC08YZat76nVmXEDa8lj/cUCX4FPAR4gkTfa4SXj7sZSHaJ/kZfPFVQ6irjHRjpHquRtsAGXV6WV7MkLmzEJ5EX0U3fBcFhcE+KSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bez7+S8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F7BC4CEF9;
	Mon, 20 Oct 2025 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964241;
	bh=i3462GGfRqBmvWrSvGYR1FPVV1NKTZPiqszuBH0uHJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bez7+S8DLrFP7s5F0/GyeC+UG4DA0MG4meIZ4oinW0sX0pI5gY8Tr9Tr5Il+fpDRV
	 3IDhQeK/iSicQnzP/bUP/nFOJNoRnQmqgHsBRegAZKv1IA/RWdPNselcfSjmYlWyD4
	 0z52j+BMtDVvpspC9uBybDCbl9lHUEl55yWm38+HHp2mXE+RQa64t85zS3TBP8dV8R
	 eG8QNp2H1ZEzp6qY/aHDDc1sYOUgroibCLIQMEY/SEt2my3QayFz4nKzDT3mcrMrpA
	 7/lrE92PW/zHPzqI3gwhW+ok0CGROULIv/P9DP21ig6Fn2dpEutK0LlgIt6R8iFzn0
	 XgiHUWqWtYIzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] xfs: rename the old_crc variable in xlog_recover_process
Date: Mon, 20 Oct 2025 08:43:57 -0400
Message-ID: <20251020124358.1756227-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101614-down-dicing-0c7e@gregkh>
References: <2025101614-down-dicing-0c7e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 0b737f4ac1d3ec093347241df74bbf5f54a7e16c ]

old_crc is a very misleading name.  Rename it to expected_crc as that
described the usage much better.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: e747883c7d73 ("xfs: fix log CRC mismatches between i386 and other architectures")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_log_recover.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 704aaadb61cf2..4d5af8d508eb6 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2890,20 +2890,19 @@ xlog_recover_process(
 	int			pass,
 	struct list_head	*buffer_list)
 {
-	__le32			old_crc = rhead->h_crc;
-	__le32			crc;
+	__le32			expected_crc = rhead->h_crc, crc;
 
 	crc = xlog_cksum(log, rhead, dp, be32_to_cpu(rhead->h_len));
 
 	/*
 	 * Nothing else to do if this is a CRC verification pass. Just return
 	 * if this a record with a non-zero crc. Unfortunately, mkfs always
-	 * sets old_crc to 0 so we must consider this valid even on v5 supers.
-	 * Otherwise, return EFSBADCRC on failure so the callers up the stack
-	 * know precisely what failed.
+	 * sets expected_crc to 0 so we must consider this valid even on v5
+	 * supers.  Otherwise, return EFSBADCRC on failure so the callers up the
+	 * stack know precisely what failed.
 	 */
 	if (pass == XLOG_RECOVER_CRCPASS) {
-		if (old_crc && crc != old_crc)
+		if (expected_crc && crc != expected_crc)
 			return -EFSBADCRC;
 		return 0;
 	}
@@ -2914,11 +2913,11 @@ xlog_recover_process(
 	 * zero CRC check prevents warnings from being emitted when upgrading
 	 * the kernel from one that does not add CRCs by default.
 	 */
-	if (crc != old_crc) {
-		if (old_crc || xfs_has_crc(log->l_mp)) {
+	if (crc != expected_crc) {
+		if (expected_crc || xfs_has_crc(log->l_mp)) {
 			xfs_alert(log->l_mp,
 		"log record CRC mismatch: found 0x%x, expected 0x%x.",
-					le32_to_cpu(old_crc),
+					le32_to_cpu(expected_crc),
 					le32_to_cpu(crc));
 			xfs_hex_dump(dp, 32);
 		}
-- 
2.51.0


