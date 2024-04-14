Return-Path: <stable+bounces-36807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BF989C1C0
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5641F21B60
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA4381726;
	Mon,  8 Apr 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yQ17MxbT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6336F08E;
	Mon,  8 Apr 2024 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582402; cv=none; b=gqGfEeX2ojEd7H8lGU/6WkrnKeZtnTFksUPJFAHziaYBKKvnQA/LB/wCmbf3ecOvkadbMhsT7qTOSIsU+a4oPmoLfVttFvGfJIPQHc3tyVyWCStr82bFp/W0fHA2eYRidYJvFgI68YcRA6e3DQkgIXdB2aKDvHN+cEcZURC2zeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582402; c=relaxed/simple;
	bh=7LIMZ7coKxjCn/D48AiCmROpN9kjVapI8MxnGYO/+zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSzgTulno6fyHxIEJ4s+xYbBWEd/pnXKLPL3iAICXres74fI1jCA6AzTwt8Gb8YtKJ+T3GTRhzMoisfxuTpWULpGRnGjN7cZx8lwtgNUPIX/ynG5XuELsGwWdYHeZwfxXrrERYn+XCemz3xzl5BS1ms/Sdl6Vpry5a91/y7N1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yQ17MxbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B87C433F1;
	Mon,  8 Apr 2024 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582401;
	bh=7LIMZ7coKxjCn/D48AiCmROpN9kjVapI8MxnGYO/+zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yQ17MxbTZuzWwg01n9YFpkAUF9nreRxKmGk3NOWd0rAnmsu3DhRTAfDnYE9hYNXzJ
	 GUG8HUTe1CoTWnyu/QSvluYekqqxSFs/KlF6s81SpeEg28/9aRO8N2/T+TlO3krVFm
	 HQuo6LdFc7qnvA2ESRI1F0MFPvsqhj15xThqTv/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 102/138] s390/pai: rename structure member users to active_events
Date: Mon,  8 Apr 2024 14:58:36 +0200
Message-ID: <20240408125259.404630852@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
References: <20240408125256.218368873@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 58354c7d35d35dd119ada18ff84a6686ccc8743f ]

Rename structure member users to active_events to make it consistent
with PMU pai_ext. Also use the same prefix syntax for increment and
decrement operators in both PMUs.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Stable-dep-of: e9f3af02f639 ("s390/pai: fix sampling event removal for PMU device driver")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_pai_crypto.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 68a6132937f3e..a7e815563f411 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -35,7 +35,7 @@ struct pai_userdata {
 struct paicrypt_map {
 	unsigned long *page;		/* Page for CPU to store counters */
 	struct pai_userdata *save;	/* Page to store no-zero counters */
-	unsigned int users;		/* # of PAI crypto users */
+	unsigned int active_events;	/* # of PAI crypto users */
 	unsigned int refcnt;		/* Reference count mapped buffers */
 	enum paievt_mode mode;		/* Type of event */
 	struct perf_event *event;	/* Perf event for sampling */
@@ -58,8 +58,8 @@ static void paicrypt_event_destroy(struct perf_event *event)
 	mutex_lock(&pai_reserve_mutex);
 	debug_sprintf_event(cfm_dbg, 5, "%s event %#llx cpu %d users %d"
 			    " mode %d refcnt %d\n", __func__,
-			    event->attr.config, event->cpu, cpump->users,
-			    cpump->mode, cpump->refcnt);
+			    event->attr.config, event->cpu,
+			    cpump->active_events, cpump->mode, cpump->refcnt);
 	if (!--cpump->refcnt) {
 		debug_sprintf_event(cfm_dbg, 4, "%s page %#lx save %p\n",
 				    __func__, (unsigned long)cpump->page,
@@ -174,7 +174,7 @@ static int paicrypt_busy(struct perf_event_attr *a, struct paicrypt_map *cpump)
 	}
 	debug_sprintf_event(cfm_dbg, 5, "%s sample_period %#llx users %d"
 			    " mode %d refcnt %d page %#lx save %p rc %d\n",
-			    __func__, a->sample_period, cpump->users,
+			    __func__, a->sample_period, cpump->active_events,
 			    cpump->mode, cpump->refcnt,
 			    (unsigned long)cpump->page, cpump->save, rc);
 	mutex_unlock(&pai_reserve_mutex);
@@ -260,7 +260,7 @@ static int paicrypt_add(struct perf_event *event, int flags)
 	struct paicrypt_map *cpump = this_cpu_ptr(&paicrypt_map);
 	unsigned long ccd;
 
-	if (cpump->users++ == 0) {
+	if (++cpump->active_events == 1) {
 		ccd = virt_to_phys(cpump->page) | PAI_CRYPTO_KERNEL_OFFSET;
 		WRITE_ONCE(S390_lowcore.ccd, ccd);
 		__ctl_set_bit(0, 50);
@@ -291,7 +291,7 @@ static void paicrypt_del(struct perf_event *event, int flags)
 	if (!event->attr.sample_period)
 		/* Only counting needs to read counter */
 		paicrypt_stop(event, PERF_EF_UPDATE);
-	if (cpump->users-- == 1) {
+	if (--cpump->active_events == 0) {
 		__ctl_clear_bit(0, 50);
 		WRITE_ONCE(S390_lowcore.ccd, 0);
 	}
-- 
2.43.0




