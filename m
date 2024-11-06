Return-Path: <stable+bounces-91290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04509BED50
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74970282706
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6121F9408;
	Wed,  6 Nov 2024 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gYOMu3kb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188891F8F0F;
	Wed,  6 Nov 2024 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898299; cv=none; b=mLkicVyMgABwAioN9qIPySnEfRVCuGZlfg8lmGvHLUm9LOEpfo4PUhhbiEifCg4VlLuYQWVeJaDoHG8xVjr59wRWSyX9UjVLqi/ll01Xovc15q80jXFYZPWrEzSNQSa4ZXJVdvP8oHoimB41G7cZMMJ1YXVey5yMVZh0+ysF+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898299; c=relaxed/simple;
	bh=vxtPCtfQyLx2ihf2cbqpP+G/MiYb5MgDgy7fHyag/7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iclyn0PYcanDf8M7wLmvNMw+eIKSE+0K12a2ex7eM4Rp7aWyN1FqBYPlU0qtEQXYgsgaFGt/LHY5BAJeuHez3GNTYJSJF7FvTg1wuFPmRkX9FVjjXn5rDz9fxci3depAmZyt41wXmypR1wXT3EiYs1GOwH7uf4WQ6DEd2BV8nTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gYOMu3kb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53461C4CECD;
	Wed,  6 Nov 2024 13:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898298;
	bh=vxtPCtfQyLx2ihf2cbqpP+G/MiYb5MgDgy7fHyag/7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gYOMu3kb9Q0DDdGqtsj7TqSZfo2Myd87B8gvGWPle4VYsWWAS8z5e+97oIjD4U8yG
	 Agl5xWXEXDadUUiyJ9M1e85kxOXT54r9w7mvtIo4whJXGfOnu7VBKh7vhtBgPMGW7j
	 X7b7H/dIJIxhqv+Rl1/a2dV58zJzUt3qgpjNIkeA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5.4 154/462] f2fs: avoid potential int overflow in sanity_check_area_boundary()
Date: Wed,  6 Nov 2024 13:00:47 +0100
Message-ID: <20241106120335.320187551@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

commit 50438dbc483ca6a133d2bce9d5d6747bcee38371 upstream.

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
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/super.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2488,9 +2488,9 @@ static inline bool sanity_check_area_bou
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



