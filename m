Return-Path: <stable+bounces-168355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BE2B2347D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C37116C5A4
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1792FD1C2;
	Tue, 12 Aug 2025 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y1PZSM9Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0B72F5E;
	Tue, 12 Aug 2025 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023902; cv=none; b=Schua4aY4765xz43PwjjgXfO8JO0cxzqDIz/Ctw2IQJV3aldjadHiKtuHt4mer12OLH6aGKUlYuz/U3hB6URBgIYhdG4vszWMsIeTLwvt2VcOeP9a7BioRe3PlEJ8jXzwrXOWgIgr5kg+JbrHYL5vsfLSFk/IvTbzSOTbRdtayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023902; c=relaxed/simple;
	bh=eI27JcJHuPQvmgPdbW1S8DcUvljXbJVxEosZjoAj6eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nL+6lHpQ5ylfjY6nJAZEmuU5jdlLutDepf6PhdPaQJgekBNiZuf74yBTU6K5Zp4ocSVXXyqAUNuYZV5dUJLRlEHakrtlCQsHpCXtDsgseU1R06WR6AHSBPL/U7WAf89+GHver7/xy8qTm5mH+vNUhXM1DowttmJ0FE8rEPbpyJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y1PZSM9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15811C4CEF0;
	Tue, 12 Aug 2025 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023902;
	bh=eI27JcJHuPQvmgPdbW1S8DcUvljXbJVxEosZjoAj6eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1PZSM9QyrNdKlAID04VoyhdHCmTnH2GcIzeG4Ik7ZaiKomrbv4ijwEXh47IiGl2e
	 0QZGu6EQjEM8J8MjSASTCAfzckcfZW0/IQXFwEi9HMUSxuMAjbM1afOAEcG823gxCo
	 x7pMusee9/QLGPvMoGQ23RkR2dNot310cdlyX3TQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>,
	Juri Lelli <juri.lelli@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 216/627] sched/deadline: Reset extra_bw to max_bw when clearing root domains
Date: Tue, 12 Aug 2025 19:28:31 +0200
Message-ID: <20250812173427.502881829@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juri Lelli <juri.lelli@redhat.com>

[ Upstream commit fcc9276c4d331cd1fe9319d793e80b02e09727f5 ]

dl_clear_root_domain() doesn't take into account the fact that per-rq
extra_bw variables retain values computed before root domain changes,
resulting in broken accounting.

Fix it by resetting extra_bw to max_bw before restoring back dl-servers
contributions.

Fixes: 2ff899e351643 ("sched/deadline: Rebuild root domain accounting after every update")
Reported-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # nuc & rock5b
Link: https://lore.kernel.org/r/20250627115118.438797-3-juri.lelli@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/deadline.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ef5b5c045769..135580a41e14 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3007,7 +3007,14 @@ void dl_clear_root_domain(struct root_domain *rd)
 	int i;
 
 	guard(raw_spinlock_irqsave)(&rd->dl_bw.lock);
+
+	/*
+	 * Reset total_bw to zero and extra_bw to max_bw so that next
+	 * loop will add dl-servers contributions back properly,
+	 */
 	rd->dl_bw.total_bw = 0;
+	for_each_cpu(i, rd->span)
+		cpu_rq(i)->dl.extra_bw = cpu_rq(i)->dl.max_bw;
 
 	/*
 	 * dl_servers are not tasks. Since dl_add_task_root_domain ignores
-- 
2.39.5




