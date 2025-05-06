Return-Path: <stable+bounces-140489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E06A2AAA94A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C721BA0B33
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D951F35C874;
	Mon,  5 May 2025 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spVKWHEl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE7359DED;
	Mon,  5 May 2025 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484971; cv=none; b=RiWMEiwo8+dUmXeWcSA93/wsqKkq3nzbFTJPaMmRunATEiPwYlNnsvHlApLzYNN8dEzdHTU8iPYn9WybT5VjxR0wVQEIDMvouU+kri8Xfr9Bx4hAHbF7egHrl1MIHOjWIotpJ+BdMio0pniVyeaN2ycTGJoqLvmP7ovwqHU2gcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484971; c=relaxed/simple;
	bh=voUt6UCtPflvDhsBYQZpXVfdDV5XzYCSHE3Hzu1CIcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N5C5Kr2BO3qfBurYLtRvQpSF8qN4hw82IlbiBjP24Wv0CZYviEupZALz+QtBXVnlbye2wPQtvBN4tdcpUCClanDzhL1K4Rf0uQdbfxI2TYRS3QdQ6RADluNt87jRTfZia++Qv+342YsyoEOUFTJg0Mjki3KHUGBWxXqvd0PApT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spVKWHEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39835C4CEEF;
	Mon,  5 May 2025 22:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484971;
	bh=voUt6UCtPflvDhsBYQZpXVfdDV5XzYCSHE3Hzu1CIcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spVKWHElt90Al0ZVOpU01VXBnY3mM9da0r24+/lnYfjG5AH1DC61z1JpAYeRoBvxU
	 cIPgvtS3+HtiaLUl8CGw3tQNZh8HaEC4GG9GOsUTkLM+bbhMzja7IuuSW6CkjlQRBV
	 DdpFwVCF3qOWuSDara7PxTgOiRcsm6tte4dzAwF7hh8eQIj2iI7C85h1fR0PTIwdJo
	 Nrdb1o77wqTePvGYRf6MZuER74I9yIe48lXxjB8SnoRa/BHSjEn+QP5fQBxTWrfvS/
	 fSuIki2dhXrm0Qn6WxE8cfycXUKN6hb/huZ10avO3euEAtqEr0Rksjm4qQXlbwE2hw
	 9RM7up4CWi0/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 102/486] jbd2: do not try to recover wiped journal
Date: Mon,  5 May 2025 18:32:58 -0400
Message-Id: <20250505223922.2682012-102-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit a662f3c03b754e1f97a2781fa242e95bdb139798 ]

If a journal is wiped, we will set journal->j_tail to 0. However if
'write' argument is not set (as it happens for read-only device or for
ocfs2), the on-disk superblock is not updated accordingly and thus
jbd2_journal_recover() cat try to recover the wiped journal. Fix the
check in jbd2_journal_recover() to use journal->j_tail for checking
empty journal instead.

Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250206094657.20865-4-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/recovery.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 667f67342c522..f85f401526c54 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -287,19 +287,20 @@ static int fc_do_one_pass(journal_t *journal,
 int jbd2_journal_recover(journal_t *journal)
 {
 	int			err, err2;
-	journal_superblock_t *	sb;
-
 	struct recovery_info	info;
 
 	memset(&info, 0, sizeof(info));
-	sb = journal->j_superblock;
 
 	/*
 	 * The journal superblock's s_start field (the current log head)
 	 * is always zero if, and only if, the journal was cleanly
-	 * unmounted.
+	 * unmounted. We use its in-memory version j_tail here because
+	 * jbd2_journal_wipe() could have updated it without updating journal
+	 * superblock.
 	 */
-	if (!sb->s_start) {
+	if (!journal->j_tail) {
+		journal_superblock_t *sb = journal->j_superblock;
+
 		jbd2_debug(1, "No recovery required, last transaction %d, head block %u\n",
 			  be32_to_cpu(sb->s_sequence), be32_to_cpu(sb->s_head));
 		journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;
-- 
2.39.5


