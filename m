Return-Path: <stable+bounces-62461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB0C93F2D1
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C6F1F22B51
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EFE145354;
	Mon, 29 Jul 2024 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nLkHtIAP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vxxWEbg+"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF7D144D1C;
	Mon, 29 Jul 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249248; cv=none; b=Ds0YC0VmzTEdury+kiWz1Q+JzrV46C/3wu4t4ACGgK7ZCQCadU3uXEtgmlPLWiXAJlSZnmj5E0ijXSAzWdwT6YjRm648WAYyKo9v+wT4a/1ueMdRomHkiV2dKb5ImbT3qRP+U9ojh+eOpdjeXAPAK0jK8A5mpA22A2gWG1NLGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249248; c=relaxed/simple;
	bh=1Gu/BwbVyxNpNEF2ghbILEElXyBh4CHct/dZDeV0MBc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L4PxsxupK5yw0sIMWu7l2XnPV32s2nNsXJ9HRtU2EaANoSAdjOCGSk4vB5T+3msOePk3cGiNsXcjhclZOIGnFBzkDarW7LffwNEbfxx9V3e1+QlOF1IYaVizYxn+Uv8PL5VBgL8UxzCMPco0cJi/LbMhPRLb47VMtTKB9mdyhwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nLkHtIAP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vxxWEbg+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7qTIvPVCEXEdQ+t7xlLPFPDr6k3pN/0/6MLHA6SjIc=;
	b=nLkHtIAPVoSEJNtvOC+3QNuaobQw/LNcwtQ2bPMfyBL3XLzA7f1rzoUJ0ID7k0xZpNkGxm
	ugIALmhusNiUUhAEMsO2RJ3HqIeZUCTRaZWxu+VgfsZZzCtsOILp2o0cvhjxxXEPDoejaB
	SbCo+PWtgp+7EzDHjca7AiDfAjNJOuvExUgaFfOS6dXjX6B0xs/dLw0bxQD4/Of/ZJbONj
	pZQQVcgUFfvYFQEcbcmiWm3PxBRp0Xq/CmSVpNkbHLjlJYiVgUOfl0dkvB1Wlst8Vrcyw3
	v57OpBUjX4l04/vd/dJ8dGjJ0jd70gHN1B6TwwgVAlJxyUvmgkog1FVK1Uf4XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7qTIvPVCEXEdQ+t7xlLPFPDr6k3pN/0/6MLHA6SjIc=;
	b=vxxWEbg+F0Rc0aD96wAoYccPbYoF7Ri92H/ql+ve5KnzrQYQaezss38g/OKTxejAkna8+i
	0ELJRoGU4sS2sVDg==
From: "tip-bot2 for Youssef Esmat" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/core: Clear prev->dl_server in CFS pick fast path
Cc: Youssef Esmat <youssefesmat@google.com>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <7f7381ccba09efcb4a1c1ff808ed58385eccc222.1716811044.git.bristot@kernel.org>
References:
 <7f7381ccba09efcb4a1c1ff808ed58385eccc222.1716811044.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924493.2215.13390344179986374598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a741b82423f41501e301eb6f9820b45ca202e877
Gitweb:        https://git.kernel.org/tip/a741b82423f41501e301eb6f9820b45ca202e877
Author:        Youssef Esmat <youssefesmat@google.com>
AuthorDate:    Mon, 27 May 2024 14:06:49 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:35 +02:00

sched/core: Clear prev->dl_server in CFS pick fast path

In case the previous pick was a DL server pick, ->dl_server might be
set. Clear it in the fast path as well.

Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: Youssef Esmat <youssefesmat@google.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/7f7381ccba09efcb4a1c1ff808ed58385eccc222.1716811044.git.bristot@kernel.org
---
 kernel/sched/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e61da3b..1074ae8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5840,6 +5840,13 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 
 		/*
+		 * This is a normal CFS pick, but the previous could be a DL pick.
+		 * Clear it as previous is no longer picked.
+		 */
+		if (prev->dl_server)
+			prev->dl_server = NULL;
+
+		/*
 		 * This is the fast path; it cannot be a DL server pick;
 		 * therefore even if @p == @prev, ->dl_server must be NULL.
 		 */

