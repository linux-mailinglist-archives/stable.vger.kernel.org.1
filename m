Return-Path: <stable+bounces-61315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0768C93B627
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 19:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E8F1C235B2
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 17:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F8215958A;
	Wed, 24 Jul 2024 17:52:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEDB15F3E2;
	Wed, 24 Jul 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843530; cv=none; b=Wvm53NabFk+eg2fNIHLKtAFHTUrrg4M+dwuLpgPoVlqC5O/dEnkt0KLCcxq7whs6tHPD1TBOFSYf4M9JkIAG33UF+Qgb8USYUx7VxKwDchaFF/dC6L2VcQlAMhbwYmatRZ0U/1HX3xzN7N3DwVY0GINw7+wR+/byncOL4U3umTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843530; c=relaxed/simple;
	bh=B/7281atFzHFPOvKrJvXjT6J/cg0WL4aRUWbsw9nUQc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SQQxK5XRi4lYz7E/fzvptQEXT4fsp5BRHfMqDp9PNLGz5heDFfdfIwnaJnNOpPWGp4lc29B0Ulrgb0Jbq97ihqigVSTDHTCXzu9rIbI2lVu5GBDr6mdN/ZHREdmKglSfX640IOOLRJA3JVNBZvlZVdVrpQNBTLDYokcdSe1od18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 24 Jul
 2024 20:52:05 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 24 Jul
 2024 20:52:05 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <stable@vger.kernel.org>
Subject: [PATCH] f2fs: avoid potential int overflow in sanity_check_area_boundary()
Date: Wed, 24 Jul 2024 10:51:58 -0700
Message-ID: <20240724175158.11928-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

While calculating the end addresses of main area and segment 0, u32
may be not enough to hold the result without the danger of int
overflow.

Just in case, play it safe and cast one of the operands to a
wider type (u64).
 
Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: fd694733d523 ("f2fs: cover large section in sanity check of super")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3959fd137cc9..4d8f38ca6fcd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3356,9 +3356,9 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
 	u32 segment_count = le32_to_cpu(raw_super->segment_count);
 	u32 log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
 	u64 main_end_blkaddr = main_blkaddr +
-				(segment_count_main << log_blocks_per_seg);
+				((u64)segment_count_main << log_blocks_per_seg);
 	u64 seg_end_blkaddr = segment0_blkaddr +
-				(segment_count << log_blocks_per_seg);
+				((u64)segment_count << log_blocks_per_seg);
 
 	if (segment0_blkaddr != cp_blkaddr) {
 		f2fs_info(sbi, "Mismatch start address, segment0(%u) cp_blkaddr(%u)",

