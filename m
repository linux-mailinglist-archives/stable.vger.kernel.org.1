Return-Path: <stable+bounces-203170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E23CD467B
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 00:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A717A30038E7
	for <lists+stable@lfdr.de>; Sun, 21 Dec 2025 23:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B454279327;
	Sun, 21 Dec 2025 23:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YNn1W6LL"
X-Original-To: stable@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295D2765ED;
	Sun, 21 Dec 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766359794; cv=none; b=TMkIAX9NnGGKjid+hdEpnpP50A85ydKkhaluROJwSkrccso7RIYEwBmyHfN9s3zqnTOFSdFkAAYuYc37kp+vjns/8eihm2deDDnQh2kMSBbMYQ3lDaINaQk8kAQ5g/iGaxxtqQwYT3kPE/ozF9QzE7ACuhFxu2HeN8Kai+RVuNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766359794; c=relaxed/simple;
	bh=Ogk/dngzVOmKb1C80LeAS2BE01H8MPAYx/arFDCFiok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AW3UNh9FfB1+IDi9Lhg1jRRd9MFDnTAx/tjXW7CJoVvC9pH7mhwQwqtROJEjJKCxuk5BuPkhaKWHfs7BCRowl1/O/2NjWJ1Qp8XL9RCmXivnREK0vlMzHiTqEuh1UT5skQqqOiVeAWo1gDfkSJLi0Y71oo+H9D9D08C45uZuGK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=YNn1W6LL; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1766359786;
	bh=Mq4W7sDg/Agh00nn/sSC9HgKzw4XSoLV+yJE0vShXuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNn1W6LLVQr7r81fgVrE3iNKt1NbFU1kaCmp41f1sr3h67Na+MJcI6xiUNS/yf9zp
	 VkeHEXt1ZmtVZVS2CEuqTCeQH48lrGG8jrtI8lnMVc20Co8UZho3SC4D373TD/SJrX
	 A/fasWo/5zs6dywhjCNWiinaPJKgo59T75k91mbbLOfwb/xcnDeF3R0G+AtwX8c9qY
	 02HNkcn5w0M++hHJLUyABFY0rNbaqp+c0jXbKUANKkMPg+58+jQwIG7kAy603gQg8Z
	 CdRlGvUD2nW9jaO4APDzwk68vlYWVextGyqAZD/yG8PR5lRk8Bz5eB6n8hDE8tHr1n
	 4sgCmvYJbvonA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:6450:b8a1:16cf:5ecf])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4dZHYQ0bfbzd8N;
	Sun, 21 Dec 2025 18:29:46 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Brown <broonie@kernel.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/5] mm: Add missing static initializer for init_mm::mm_cid.lock
Date: Sun, 21 Dec 2025 18:29:22 -0500
Message-Id: <20251221232926.450602-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251221232926.450602-1-mathieu.desnoyers@efficios.com>
References: <20251221232926.450602-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize the mm_cid.lock struct member of init_mm.

Fixes: 8cea569ca785 ("sched/mmcid: Use proper data structures")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/init-mm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index 4600e7605cab..a514f8ce47e3 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -44,6 +44,9 @@ struct mm_struct init_mm = {
 	.mm_lock_seq	= SEQCNT_ZERO(init_mm.mm_lock_seq),
 #endif
 	.user_ns	= &init_user_ns,
+#ifdef CONFIG_SCHED_MM_CID
+	.mm_cid.lock = __RAW_SPIN_LOCK_UNLOCKED(init_mm.mm_cid.lock),
+#endif
 	.cpu_bitmap	= CPU_BITS_NONE,
 	INIT_MM_CONTEXT(init_mm)
 };
-- 
2.39.5


