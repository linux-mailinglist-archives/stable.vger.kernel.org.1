Return-Path: <stable+bounces-190551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EF6C108A0
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA16567449
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79093332ECD;
	Mon, 27 Oct 2025 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NUSHtvHt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35917332EB2;
	Mon, 27 Oct 2025 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591585; cv=none; b=qgrjL/c5vDI1ZTAorWqx3af7tatvHrlm2fLKHjQTRQQuF/r50GRBaw2ig1pfyHS2u/XNnSi61JN1kmPBZ80xHjSUfjqT/ssk1JCFmW6BNe+y8S+7hyf+EgHbfoW71FxePlew5yQXEEI+7+NhxLn54LAuh3Nn9yOO/9g3h8LoyFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591585; c=relaxed/simple;
	bh=GpHlWv2XZEXFb6hFKjskfnvWUqCtWRV0dhW0Lke8e9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AemlG3YSKVGG9bhZ3Dd3V8iaO3Seuve1hJoORTnD9GssgkJ1l1SzgF+IXYAYGYFiiwzrhpldUHgru+hR4ds5bkE2fwXBU81725JTRgXNpLDrWW9PpripmbQQBbT/GBUMHTDY+Kie9KpMLIDkmtqp2sk/3ILRO6MwpAYhYt1pA04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NUSHtvHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD766C4CEF1;
	Mon, 27 Oct 2025 18:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761591585;
	bh=GpHlWv2XZEXFb6hFKjskfnvWUqCtWRV0dhW0Lke8e9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUSHtvHtMSIeCa6sLza7HGhEMV/OFuLruXNd4BccyUBfL0A9eI2DuahoDKxKbsrEi
	 YxS3TvVuPognNy3wmvF5ZOWdNzEVM6+KgBcXh4nxAjTrVw9PtSq2hFwTbcOLoPEZH4
	 AoIKd1z5PHQEARKqVRkXzfsEOERjRm7GoLnrOgkU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Barry Song <song.bao.hua@hisilicon.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 253/332] sched/fair: Trivial correction of the newidle_balance() comment
Date: Mon, 27 Oct 2025 19:35:06 +0100
Message-ID: <20251027183531.523542144@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183524.611456697@linuxfoundation.org>
References: <20251027183524.611456697@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Barry Song <song.bao.hua@hisilicon.com>

[ Upstream commit 5b78f2dc315354c05300795064f587366a02c6ff ]

idle_balance() has been renamed to newidle_balance(). To differentiate
with nohz_idle_balance, it seems refining the comment will be helpful
for the readers of the code.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20201202220641.22752-1-song.bao.hua@hisilicon.com
Stable-dep-of: 17e3e88ed0b6 ("sched/fair: Fix pelt lost idle time detection")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9f8cb265589b3..802c97a05f57e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10808,7 +10808,7 @@ static inline void nohz_newidle_balance(struct rq *this_rq) { }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
- * idle_balance is called by schedule() if this_cpu is about to become
+ * newidle_balance is called by schedule() if this_cpu is about to become
  * idle. Attempts to pull tasks from other CPUs.
  *
  * Returns:
-- 
2.51.0




