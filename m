Return-Path: <stable+bounces-34825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6737A89410E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EEA1C2134E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8A748CE0;
	Mon,  1 Apr 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kSf5uxWW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13348781;
	Mon,  1 Apr 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989426; cv=none; b=je7cdxopJMeF0KSM7uXzc3vv5C7798BdoUwR+AS8V5BKkFgzbJb0fQ9EyEEumH0Kx8KzKj/JMreFOYIOUJk8tdHhE7dcG4EsnNeOLxgeEOcqMJpEFJAkBf1lMHxPPcj1xbUjT1nI2QJwSgcAMeiWZT7W8aSGZ7lzTiWmrVzN214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989426; c=relaxed/simple;
	bh=7qvIGOxsUd17CYn8w+W3jh9Sy0WP/lNV7wwKPuvGzcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbCAqjs5sGTHikTKNJjMsrlU2PWZ9ou0/Fnkk/SKL1MiY/hUCkQzNi4/LAwkWg7d5kisE1c1YCDpvmy2voDjmhE6wAGo6o/CRpY1FnzwGUgcVduIBwTZuKY6RjxFXogBRcAaruvbGDpQXhfww5U7bnoN1fA/lR0LpXhNUFbHrQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kSf5uxWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12464C433F1;
	Mon,  1 Apr 2024 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989426;
	bh=7qvIGOxsUd17CYn8w+W3jh9Sy0WP/lNV7wwKPuvGzcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kSf5uxWWxRtEtNL3XpIvHMjCL96FkNgTarwe1Z0W4B2mse5PQ188VTr6nLsZX3txb
	 zPAmFMxs+q1g/qiw3bMxIR3vmF93Ux2xtv3S8y6ERlDOZvExte//UnkjvvjnuUm30/
	 hXsV4GAV4u7qL25KtJHRjHtwsBUL/Z8IgbOpovp8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 044/396] bounds: support non-power-of-two CONFIG_NR_CPUS
Date: Mon,  1 Apr 2024 17:41:33 +0200
Message-ID: <20240401152549.242569843@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
References: <20240401152547.867452742@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

[ Upstream commit f2d5dcb48f7ba9e3ff249d58fc1fa963d374e66a ]

ilog2() rounds down, so for example when PowerPC 85xx sets CONFIG_NR_CPUS
to 24, we will only allocate 4 bits to store the number of CPUs instead of
5.  Use bits_per() instead, which rounds up.  Found by code inspection.
The effect of this would probably be a misaccounting when doing NUMA
balancing, so to a user, it would only be a performance penalty.  The
effects may be more wide-spread; it's hard to tell.

Link: https://lkml.kernel.org/r/20231010145549.1244748-1-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 90572890d202 ("mm: numa: Change page last {nid,pid} into {cpu,pid}")
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bounds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bounds.c b/kernel/bounds.c
index b529182e8b04f..c5a9fcd2d6228 100644
--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -19,7 +19,7 @@ int main(void)
 	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
 	DEFINE(MAX_NR_ZONES, __MAX_NR_ZONES);
 #ifdef CONFIG_SMP
-	DEFINE(NR_CPUS_BITS, ilog2(CONFIG_NR_CPUS));
+	DEFINE(NR_CPUS_BITS, bits_per(CONFIG_NR_CPUS));
 #endif
 	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
 #ifdef CONFIG_LRU_GEN
-- 
2.43.0




