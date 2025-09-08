Return-Path: <stable+bounces-178951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC5BB49874
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 20:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E9D20313B
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 18:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3F5314A9C;
	Mon,  8 Sep 2025 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4/X6H2o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FF5238C03
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356740; cv=none; b=Qi8Cunt1r0RqoJfwcjnou4nwEsU7/6v4NutsO0HtGnw9YlhuHh2m7K9vPgefejgnWx65gbAhaI162prLo6wgBcqknQiKh2avYe0TR/fOVKuXzDWDGnETgloyJ6gneoa+OrCUhbRz0XaqJCCLW4ag9ump4G1pFhMGqc6bhr1L5iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356740; c=relaxed/simple;
	bh=0aLftogJXqoIWWe4laGlDFdflN8QGLLmLhaDeB8/GsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsgAP0aq+GhbGo7h7K7rw71cduAu9LBgRvgfBYcZIVLv2Y4FFA9CO5vvIwhHnVokpzaZNFU/8v6hyVYcuAhk5oPgMTtw4lX/H9yo6gGSDh5i/+J8PERCcafKLkiGUFd5R8kLdG/HOmiiwylaNVjqXP+eEHz5H7DtMMxC1tq06K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4/X6H2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CC3C4CEF1;
	Mon,  8 Sep 2025 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757356740;
	bh=0aLftogJXqoIWWe4laGlDFdflN8QGLLmLhaDeB8/GsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4/X6H2oiyt4Ys2lLlhnMQXVBVMgTkfYKompJpgzTCV5JY37gJ3SWXGuJ6uTjCEYB
	 OoA0BPUR87eVVeBFrxEly2hzkNIR7Y4c7alZ+k9IXC0zQiSnURanrR8G50xCYdU9yj
	 Amw6VtFWdLvqHWtUNTiJdN2u0gPY1mQq6jJ6LOIWo5d2sGOI5eJkJJZetFguDEzcI7
	 NfKyU1Ne9/xw5tfiq4za1m8ZcJJJvRj9zhSWCSy/uKO+T28u/8ncc/SxUQL70UYuuT
	 6nSM3PSCKXTxZtEhWLrnceBhDpaS4513TapYNpFQQnjTQSoG9LawK2U9hiAm3PZmSm
	 rumIhGY8Kbw+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mtd: Add check for devm_kcalloc()
Date: Mon,  8 Sep 2025 14:38:57 -0400
Message-ID: <20250908183857.1816448-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041746-tummy-size-5785@gregkh>
References: <2025041746-tummy-size-5785@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

[ Upstream commit 2aee30bb10d7bad0a60255059c9ce1b84cf0130e ]

Add a check for devm_kcalloc() to ensure successful allocation.

Fixes: 78c08247b9d3 ("mtd: Support kmsg dumper based on pstore/blk")
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/mtdpstore.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index 5594a22c01375..e86b6c9c44d30 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -423,6 +423,9 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
 	cxt->badmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
 
+	if (!cxt->rmmap || !cxt->usedmap || !cxt->badmap)
+		return;
+
 	cxt->dev.total_size = mtd->size;
 	/* just support dmesg right now */
 	cxt->dev.flags = PSTORE_FLAGS_DMESG;
-- 
2.51.0


