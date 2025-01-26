Return-Path: <stable+bounces-110479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8915A1C92F
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868131887CD4
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B061B042D;
	Sun, 26 Jan 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVbQuCX6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6D31ADFE3;
	Sun, 26 Jan 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903022; cv=none; b=uJplCqnwKMu6Njb4esmkfh0fuCxYrJh1sEsO3rqLO1rJjkb3QkFPB4qfcmqxiXBFWd82Tsk9yGjS9Xb/lrOEdYwph6P3cd+6Q/W1fbMdR5e6/MJS3DJMeqwikefnZVKo7I7ppqNfNdkweb7nhX4uIUozSbhhH0Vbh/L/bPCWIgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903022; c=relaxed/simple;
	bh=jC7ZXxoCMYRHVRA2/CZ00IYwyyAn0crOLqb08fNqUrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJSr7H/4z6p1DIyIbFC+nHfLNu/yEPbuzrNfLTX4wk1dswRMb+h7KD1IoK+Yu8KAX+ouvBbdI5HwNkVYZBzaxaDm+ycIaCNLSMKly/3vsIz919wxxgWQjR9fcjDL3qbJ3cnNj6PNKkKCtwuW9Aq50X1pY5BR6Ta+nS52TM4FIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVbQuCX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EE4C4CEE3;
	Sun, 26 Jan 2025 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903022;
	bh=jC7ZXxoCMYRHVRA2/CZ00IYwyyAn0crOLqb08fNqUrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XVbQuCX6tO4X+dKOBKYAXkUyQxRAiIQDH49XS3SMU59w0GpQePrcYBUnjG4L6SGxL
	 bjzZajCaA8iWF5gF2gJy4eyttoIcRokK3b3xl505HQ7Ybc+tEpCMvPs7QtKXsU1EIE
	 XqS12YUmJUoNnwfzNbxY6+Dso+7t3bjjSr5f3hZl2zc/JxMt2mkTa88Io3BMUVPDvz
	 zkgPK1rJDmUjvwLex0Nckx9PMkmUbvW/BCmnAsOrXzByR9Caq1QzTZNXlzPYD/FW2K
	 7CmLxZTZdC8v+4COgiY18lp/XX3THT1lDWzmruECwGvtsL9g4N4Gu/bVkvKizWRXQU
	 vkPLkAzoN+QCQ==
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
Subject: [PATCH AUTOSEL 6.13 5/7] locking/ww_mutex/test: Use swap() macro
Date: Sun, 26 Jan 2025 09:50:08 -0500
Message-Id: <20250126145011.925720-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145011.925720-1-sashal@kernel.org>
References: <20250126145011.925720-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
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
index 5d58b2c0ef98b..bcb1b9fea5880 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/test-ww_mutex.c
@@ -404,7 +404,7 @@ static inline u32 prandom_u32_below(u32 ceil)
 static int *get_random_order(int count)
 {
 	int *order;
-	int n, r, tmp;
+	int n, r;
 
 	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
 	if (!order)
@@ -415,11 +415,8 @@ static int *get_random_order(int count)
 
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


