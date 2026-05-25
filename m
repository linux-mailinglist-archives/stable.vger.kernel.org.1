Return-Path: <stable+bounces-254215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JRnyGCy7FGo2PwcAu9opvQ
	(envelope-from <stable+bounces-254215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:12:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9D05CED19
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2F8A30055BA
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 21:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3279A3859E3;
	Mon, 25 May 2026 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ySRfRM4l"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C7625392C
	for <stable@vger.kernel.org>; Mon, 25 May 2026 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743527; cv=none; b=mVaG5nwm4ihv9DVQduFKB7vInF1WBINOGj9IgcJzVUVSApQ9xNKdDIyl08kCzWwbe53y25Ob5KrVRZIPnrHNeDa5V3jr65EZ9RZpdF9wZ+391UMKjOOP8hVcuN7fghpL5/lhafrk6/inRYQ1Nd1dwdEKHAHy5ACqmIkt6Z69pqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743527; c=relaxed/simple;
	bh=tLrKMPihZcTU0fNWFJgkqAaVxpczgnfc6oQGD9w9pAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxWT5Dr9B0kWc/nAj9L1V/dQHQjuKSO5V3cJKOfKsa1W2Dn1AOlP6TV6y4ByNZ3+nokHa+fnV+aqrTDj6/2W2/xdufGHz/ix3fN4THXMx7D4wDK0p9G4Lf4hCwHpBt8Qegce4AdB45BidHR6LhlNmCZkIFzq4BXLGo2OwZYCCac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ySRfRM4l; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gPT8x6BFLz9v73;
	Mon, 25 May 2026 23:12:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779743521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FtKh0mjDNj+7k2LNEggixkcSjo83gVpev/y4ZE6Z3uo=;
	b=ySRfRM4lmKUZF1ouOYLCExxe/KAI/+0qOOGh4hz76ifV1cFyJvEFWJjtEIIV7EhR0wrMiL
	jZ9iwDf21g/0u9A85RRBLjrnHD37BTcqohIsQ/rr3+O+78VPE7ABwWqFkG6Qpxu1bJNs5V
	WTD18fHmZNtpNEL+irUHuSkWRNQvJiRfdKDmcDj0hfhzwaTQE7FTQipOu8jd9Kk8/vXfbK
	74ktQez85dE96pvUMn0DezrgrmkK7hdZJSYJYCqBtR3pfYokKfWcjmGYiVLHxVTDv9Yq8I
	5dn06FYweCUNfK8KPLrWfUCYmoP/KI+jxbah6Ss0hn83OMmi6i8/i2jN6qpEhg==
From: Lukas Beckmann <lbckmnn@mailbox.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Mike Galbraith <efault@gmx.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 6.12.y v2 0/5] backport missing dependencies of d66792919d4f
Date: Mon, 25 May 2026 23:11:12 +0200
Message-ID: <20260525211117.630141-1-lbckmnn@mailbox.org>
In-Reply-To: <https://lore.kernel.org/stable/20260522213120.1205100-1-lbckmnn@mailbox.org/>
References: <https://lore.kernel.org/stable/20260522213120.1205100-1-lbckmnn@mailbox.org/>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 00f10e73d21201a36c9
X-MBO-RS-META: besxxf36nj3cbsth95imxtq49wk9t3bf
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmx.de,infradead.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254215-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lbckmnn@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: DE9D05CED19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit d66792919d4f ("sched/deadline: Use revised wakeup rule for
dl_server") in the 6.12.y stable tree (upstream commit 14a857056466)
depends on five upstream commits that were not backported:

  commit cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
  commit 4717432dfd99 ("sched/deadline: Fix dl_server_stopped()")
  commit bb4700adc3ab ("sched/deadline: Always stop dl-server before changing parameters")
  commit 4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
  commit a3a70caf7906 ("sched/deadline: Fix dl_server behaviour")

Without these, cyclictest under load reports latencies up to ~50ms on
PREEMPT_RT.

For context, see the regression report:
https://lore.kernel.org/regressions/04657838-46d1-432d-95e1-eb73b930b032@mailbox.org

Testing:
Tested on two different machines with Debian's PREEMPT_RT config for about
10 hours.
Without these patches cyclictest under load spikes to ~50ms in less than
30 minutes, with the series applied the latency spikes are gone.

Thanks,
Lukas

v1: https://lore.kernel.org/stable/20260522213120.1205100-1-lbckmnn@mailbox.org/

v1 -> v2:
 - Also pick up
   4717432dfd99 ("sched/deadline: Fix dl_server_stopped()") and
   bb4700adc3ab ("sched/deadline: Always stop dl-server before changing parameters")
 - drop the conflict resolution from a3a70caf7906 as it applies cleanly now

Huacai Chen (1):
  sched/deadline: Fix dl_server_stopped()

Juri Lelli (1):
  sched/deadline: Always stop dl-server before changing parameters

Peter Zijlstra (3):
  sched/deadline: Less agressive dl_server handling
  sched/deadline: Fix dl_server getting stuck
  sched/deadline: Fix dl_server behaviour

 include/linux/sched.h   |  1 -
 kernel/sched/deadline.c | 16 +++-------------
 kernel/sched/debug.c    |  6 ++----
 kernel/sched/fair.c     | 16 +---------------
 kernel/sched/sched.h    | 37 +++++++++++++++++++++++++++++++------
 5 files changed, 37 insertions(+), 39 deletions(-)

-- 
2.54.0


