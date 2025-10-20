Return-Path: <stable+bounces-188053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF74BF14FB
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F021884EB4
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EA923B60A;
	Mon, 20 Oct 2025 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXwLInTv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D851C3306
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964447; cv=none; b=Ap0Yp89/EofJ3A8dMWtFDzmaPblpUJuTU+DK4UYgk7HTG+71gtQwQ2TvZ2VmTJLi9z+up4pyb/ZSHsKrtc96gulgyPi7KtCxaf84VOATbuN/NShLF+RusiJkBJ4+8PYrbYrsHnXMoVOTphKnySh9mxwVcgaIMm7SQR0uXmrEpOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964447; c=relaxed/simple;
	bh=RhbmDtN0lmLKFyjzdVQFvg6jv6kadkuDzQkQ/zCoO7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZTbgbHzAUionn7lJgpCNZEMwPibkdJHvb99uxU96KVP+6NJg9bjgYG0voiahpK49v3IinP+u9KdI7F1SDGJKoBzgPu2Ba2G59rRzlLz4Vx8lTNsPGPALemLwSNt87fElQ9x1xLeKqxldmwdMKAlCj684keR1bHzPhNTnPY0ARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXwLInTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3A4C4CEF9;
	Mon, 20 Oct 2025 12:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964446;
	bh=RhbmDtN0lmLKFyjzdVQFvg6jv6kadkuDzQkQ/zCoO7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXwLInTvOic2fGd53EWe5Z0Jla4eSV0/TUO+2DtVMZUVs/tnnfZX2x5aYpexoMcsW
	 c1P6EwMLvIi7Sb5uxes96W7P3tKmg02nft+F/U387fLZA2JypwNOFFVMYWe5Ypk3Ua
	 8gSCROn7tSx0SHXQNng6TfLd7AqMpkW8hC3r8jLxp3U/cBu6tuP3xDWOq5r3eniR5/
	 lWaRv8BjMyvA/9T89dsSRS1L8/rtOh8aLORmgJ+SzR1jw/qpdSiZetKcXMrdLeJ4Ak
	 vmo2+ZtUPzBfwkAXfXef2/hp6o16MeiFEv/Xii2R33s18KKnFekn0Afv9+Vaqjagsw
	 Ay4n7G5KzWZnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] xfs: rename the old_crc variable in xlog_recover_process
Date: Mon, 20 Oct 2025 08:47:22 -0400
Message-ID: <20251020124723.1757183-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101615-hunter-bonfire-f320@gregkh>
References: <2025101615-hunter-bonfire-f320@gregkh>
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
index 60382eb499610..eedcae996e51e 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2860,20 +2860,19 @@ xlog_recover_process(
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
@@ -2884,11 +2883,11 @@ xlog_recover_process(
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


