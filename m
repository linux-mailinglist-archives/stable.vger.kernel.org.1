Return-Path: <stable+bounces-203383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E924CDCF35
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 18:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A85BB303D32F
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 17:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D445230DEAD;
	Wed, 24 Dec 2025 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mwV8vjej"
X-Original-To: stable@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B2D2D97AC;
	Wed, 24 Dec 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766597653; cv=none; b=mcmS4NbPrmjhu7UvcSe3DN/8g22mxeTQEPjRHGoMqDH/WTD5JZxjfG8onpBfGy6ywvBbPJC8ygAonnMJzLIiLaeq40C8FVMp8s9E7ZvNtsO9wKiDQtdAOPPxm9z0RnQfP3F4SAK95FSX+Ienht0STb3ef9K4twmh4e4+8Sl7hCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766597653; c=relaxed/simple;
	bh=Ogk/dngzVOmKb1C80LeAS2BE01H8MPAYx/arFDCFiok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IvB7j0O3QE4oHJwTxNOyvUyh6St58I6UQhANQuSNarzG+CsZ8AlIwXTBmDNWhh9y8aAocObDF9bq3XfpVOWwHN9yT+rYyjScghl1WqyAhg7Ufe3nK51ECRepcdhWEghSLLf8pFlF8NLN0jSFAShScA3Fw6FBOsQGPDOZ6rX5uoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mwV8vjej; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1766597645;
	bh=Mq4W7sDg/Agh00nn/sSC9HgKzw4XSoLV+yJE0vShXuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mwV8vjejIZtBnu/BJjgSoh3W8IJpP5EO2IJSE+RFcgANHPCeB+IvJzRN24gfE2q/n
	 G+qD4TBldsguubC1CzBWgXCZk9cHb6JJGcRY0+A68Qolw2M5dEs2l38UfCj2pM6HFG
	 zfNMYKNSyAO0TChR5iBq28RBTxRKjHoXd2P0MfRXFoUsisfj5/1OkkG+ZYy2SnC+my
	 Q3y321qFZXstB2beDmbgavxfWHzwRRAUR8ARIBm37KXRnsVj0a/kUoQ9sD8N6/7ODe
	 oeJ8PR6D2iPQjP+61hbSwEncWMcef/vyaEQ4YYzfsF7E1LmAPdHZDFUMvSs4268PC9
	 3lTVo5ib/oSyw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4dbzWd36bLzfHp;
	Wed, 24 Dec 2025 12:34:05 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	stable@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1 1/3] mm: Add missing static initializer for init_mm::mm_cid.lock
Date: Wed, 24 Dec 2025 12:33:56 -0500
Message-Id: <20251224173358.647691-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251224173358.647691-1-mathieu.desnoyers@efficios.com>
References: <20251224173358.647691-1-mathieu.desnoyers@efficios.com>
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


