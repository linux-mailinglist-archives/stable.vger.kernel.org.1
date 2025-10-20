Return-Path: <stable+bounces-188058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B50EBF1552
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D265F18A5AB8
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B69A3054FB;
	Mon, 20 Oct 2025 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGXBAWid"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE7F2F5A02
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964627; cv=none; b=EyUrBhMbrLP6jaEqz+nV4AvLX6ypOl3kpYPyxNcDuGFHfVBvN2PFWc0Vimkijez9wyOxns81Zo9ZHiFcYmM/Y4QSrJZTOiEUtRITE4ZZkZyf9TbNb/27y5zie/Uzpm1dpR4IU0anKtYZBZvrsjrv+bWTVInGP2xnaQrj3GGZfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964627; c=relaxed/simple;
	bh=lNMrO1+hN9oPYBbtcfCxB41/FFTVjorAvYLZQOAB+jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Okdqnmozm4R3mx6EaX2zBwCZld5l5dTmv6OSNedka4H8dlZlFiXZXMSRpbRAANEgV7zPetuLMC8DLRmxLI0EX+zBvgma2eY681B/GCVXa86XXirhe+K7GKElU+rtO0lKG63HEm/n38VPOgb8aaL+LUt/jkdtk8x4zoKamoBuihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGXBAWid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FF4C4CEF9;
	Mon, 20 Oct 2025 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964627;
	bh=lNMrO1+hN9oPYBbtcfCxB41/FFTVjorAvYLZQOAB+jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lGXBAWidlHwMYjlzO/CeKPCbS73OuHCHFqc2IG6LpwWHHNw56gG7ul8OF/AbHf5Jc
	 6oES0q0QgDQ5DOIuTU94EymwZomfVU8tthpI9Zpq2BJYUGODn6mTlyV2ouhOwsgJYN
	 KMRZR2th2huhfGtV76UNpQzsAFhs1/4A8UPmkwPmpJuUzsRdXDD3IyuKkWFIMTg2tL
	 WZskcyfI61hczWZYgOKviomMrRO/Zd58xU3WtpcYuImLRVqffHgJc7ongw0uM9WdS2
	 akwHeg2I7VzTU54iNJkHK0YpkjTAoivLkCw6MhjCnvBWOO8qit7BCd5zy2/Ox+OjM3
	 D+YHPgStbOUDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] xfs: rename the old_crc variable in xlog_recover_process
Date: Mon, 20 Oct 2025 08:50:23 -0400
Message-ID: <20251020125024.1758100-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101616-negligee-wrongness-0478@gregkh>
References: <2025101616-negligee-wrongness-0478@gregkh>
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
index 705cd5a60fbc9..899fd45ee1552 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2864,20 +2864,19 @@ xlog_recover_process(
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
@@ -2888,11 +2887,11 @@ xlog_recover_process(
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


