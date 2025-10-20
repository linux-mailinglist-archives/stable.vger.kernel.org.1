Return-Path: <stable+bounces-188049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A979DBF1488
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5912918A278C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EED2BE03D;
	Mon, 20 Oct 2025 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC+yqlAf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A9258CE1
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964209; cv=none; b=WVUmpUaVOvg5wIMt5tty3G8mmAnOZU/AUwLxKdiN6YZLag/njuqBO5+a9lU3fstkQJLHN1QEHpZ8ioL8JCwpT2KiNtcdNjXp9T0D8JWRA81MoiSOlPG+Em5KxkrwJXny7V9mc5tuWdlnCBAxbVJToTvpMeVyHtEw15GdhQkp3gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964209; c=relaxed/simple;
	bh=62Yh6z2xWmoVpu7uZgBGuIRNl0qouniRdW6glZ7ENjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJD83JUo+Q+b3ShjSQlG9Nr0Wl2Wn6gWxbeOjWltCa3ZWTJaD+Ftzf4afLfhpvct4XvRgop0dIDj9+lvE2B/HM5P8pdY4BHqylzWwBt883CzePSs26SEsJ/Zkm9PGJE1pDdPq2sEADRjfcitzthTH2am507y9iq1OL17FNjU+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC+yqlAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1E6C4CEF9;
	Mon, 20 Oct 2025 12:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760964209;
	bh=62Yh6z2xWmoVpu7uZgBGuIRNl0qouniRdW6glZ7ENjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FC+yqlAfW8YuA9OPEVc78gAQ5IWSDrvonb0vC17UA0JQ4u+CaQEa4j5QlNZk91lXT
	 TKtCyklrh4IESTZAumdSS7VBOr7WTz+E1j8lqCkRU3UzR/ZTo0pH/hvoJSShyHqr5A
	 ybX4x/T5y8YzK+nhrg/XhJEtxkpz4nHOxXlVjVZAqrekzpksPvTcSGDLooEl0T85+O
	 36NOnuPIAs0xY0GRasW8nToKK4ftvPhWWh549/zEj2JagRuAtLwPIyXTvTzMyRL1GB
	 KpgGicKqmgOfXpc5XaA8MCR5WuZ2cn3LW8fzkknil9LhIIBMPsan7E8dqxHfive3qt
	 IhzcCoHWbSrdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/2] xfs: rename the old_crc variable in xlog_recover_process
Date: Mon, 20 Oct 2025 08:43:24 -0400
Message-ID: <20251020124325.1755939-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101613-unworldly-lumpiness-b4a6@gregkh>
References: <2025101613-unworldly-lumpiness-b4a6@gregkh>
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
index e6ed9e09c0271..0a4db8efd9033 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2894,20 +2894,19 @@ xlog_recover_process(
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
@@ -2918,11 +2917,11 @@ xlog_recover_process(
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


