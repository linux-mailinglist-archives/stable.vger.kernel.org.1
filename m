Return-Path: <stable+bounces-110486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC7FA1C95C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A0B18879C5
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30229158525;
	Sun, 26 Jan 2025 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgcPV+lJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0661D90C5;
	Sun, 26 Jan 2025 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903039; cv=none; b=ouOxzrfHSjCYLLmMlRLq8ZHd7fC1lq44uf6dx3D7uIU13uWB1QJBAUlq9F4V06Dp9OlAzetuTKgld9SoovBw2si9fSVwVy9b08YFGCKqfJfsqZXV5ZCVimLmRgkNVGjYq8lmxECgrdZFxwhIcvM6BOuMWuoqXl3Q+YJUV/waHjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903039; c=relaxed/simple;
	bh=UJrhZi1sKZ0tos0EX0w7OeImOqHu0EwtHEhPVttefR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VU79eYL8wl9NDNDEj6vLJEuuBkGNPngqmiT1N67HRoJrIw3fliCIuGve79GrUBfoJ8YlBHJ8HcaOUTK0wu5MhaB3f+xiKz6h211RF6+oDevq8RfA6gyaF0KsfbggDgbWNjCXoAzXYHxoq3R8hWYhPo5jm6sBexm/ZT1DOhXCblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgcPV+lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8B4C4CEE2;
	Sun, 26 Jan 2025 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903038;
	bh=UJrhZi1sKZ0tos0EX0w7OeImOqHu0EwtHEhPVttefR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sgcPV+lJrdBs07pCoc7Mlw7fSjzRLIyFYx9pMFAeivrwl+uxMahmQfBV0e7JCryhX
	 OUIdUNERlTFVOF8lTS00aCZ/2qw2r8lsqc5Rvoj6hPiBUHoa8DQ5LabNJUBz5t1P7z
	 FPjLmI02Butz1K1bJNAcvC5Ew4tLK6/4LOLWgtTCHNEIQ/53NH4iE+KzIs7vKMkKTZ
	 1nFyjmd444iVwFtVzx+zvk+sECQEOsBBngnQwPcsMX75Yuu5aWPbRaQrejpfuiqAUl
	 2MQ17F0HS1lykZN8GWJNtpeDxr7quaVJJXv7XIQsS2Z8Lu4HEmf5by4GED99eIXEDI
	 gSoymNPeUad1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@toblux.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org
Subject: [PATCH AUTOSEL 6.12 5/7] locking/ww_mutex/test: Use swap() macro
Date: Sun, 26 Jan 2025 09:50:24 -0500
Message-Id: <20250126145027.925851-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145027.925851-1-sashal@kernel.org>
References: <20250126145027.925851-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@toblux.com>

[ Upstream commit 0d3547df6934b8f9600630322799a2a76b4567d8 ]

Fixes the following Coccinelle/coccicheck warning reported by
swap.cocci:

  WARNING opportunity for swap()

Compile-tested only.

[Boqun: Add the report tags from Jiapeng and Abaci Robot [1].]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Reported-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11531
Link: https://lore.kernel.org/r/20241025081455.55089-1-jiapeng.chong@linux.alibaba.com [1]
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20240731135850.81018-2-thorsten.blum@toblux.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/test-ww_mutex.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
index 10a5736a21c22..b5c2a2de45788 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -402,7 +402,7 @@ static inline u32 prandom_u32_below(u32 ceil)
 static int *get_random_order(int count)
 {
 	int *order;
-	int n, r, tmp;
+	int n, r;
 
 	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
 	if (!order)
@@ -413,11 +413,8 @@ static int *get_random_order(int count)
 
 	for (n = count - 1; n > 1; n--) {
 		r = prandom_u32_below(n + 1);
-		if (r != n) {
-			tmp = order[n];
-			order[n] = order[r];
-			order[r] = tmp;
-		}
+		if (r != n)
+			swap(order[n], order[r]);
 	}
 
 	return order;
-- 
2.39.5


