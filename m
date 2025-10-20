Return-Path: <stable+bounces-188056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C8EBF152B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8282918A56CA
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865A4231C9F;
	Mon, 20 Oct 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4q32CJd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427292F5A02
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964564; cv=none; b=F3Om8ALUsQfUok43pWnxQ3HhjMKi7zdEBR8xDYgs1E7xiJWoSU9ZO59Q4zq5zGVF/USOiz+SlAv4xrE21ZJHEmLzx32Jkx2ImbxREXihczwmIMbSZmNgq44JZ48iQWYt06TOJy+wAei73eXmKJty17pBeKVuSTIXv2aKoo+n3hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964564; c=relaxed/simple;
	bh=WdtznGyLICVRTf4lOL+c3jnnA03QC9vAIlYNViOECuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZ8yYMv62OVGx/+4x7q/9OJcPscoFduUO1PMX7QE/6Zsrw2VIML6nwKbf8x30cd20KgeRdK+VZQfiJg2LprwLOtgU3Zs75M+i3gWg4u/P8exh4FjD7HELWmvRb/lu/lklTctLwrzUbALdzEdCBGBglaI3OrsEK+FQXVG/yReW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4q32CJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18673C4CEF9;
	Mon, 20 Oct 2025 12:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964563;
	bh=WdtznGyLICVRTf4lOL+c3jnnA03QC9vAIlYNViOECuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C4q32CJdDwfLTLd5ExG3YHMBAcGeyrqVMpHY2T1WZMNBXC2CU8Da83Bryys2c+apM
	 RESTL2KfSVh4J6c1pXCtzU0jJd07XN2nWkMIA81Vt8uYrPC+KykBlH2mYCAsxlasoJ
	 MdqkdeR+BbRACsege1zhZIPPRFFInhHqxC108S+R8TNmg46Sql0xnuO7YdY13iICcl
	 gVsBvZLPgYqHsDh7IjjGHst2wR1oRaW5K6UY97c+HaFyhzlOvl2aoIV+wYuNwnJjgz
	 uNpoJqv0MjDKZzCeUTDRNxpb6kGYZT70QxAMY1//Vt3qZEdlfGXknQ41swEpRe41ls
	 A/Q517laHZOOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] xfs: rename the old_crc variable in xlog_recover_process
Date: Mon, 20 Oct 2025 08:49:19 -0400
Message-ID: <20251020124920.1757717-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101615-delirious-unicycle-3115@gregkh>
References: <2025101615-delirious-unicycle-3115@gregkh>
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
index e009bb23d8a28..6542c8d34a65b 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2854,20 +2854,19 @@ xlog_recover_process(
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
@@ -2878,11 +2877,11 @@ xlog_recover_process(
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


