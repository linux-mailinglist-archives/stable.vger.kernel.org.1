Return-Path: <stable+bounces-256518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPP3HXouGWrmsAgAu9opvQ
	(envelope-from <stable+bounces-256518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:13:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D468E5FDCB1
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E045F3032F6F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E639DBFA;
	Fri, 29 May 2026 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFoMaHX4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080CE36D512
	for <stable@vger.kernel.org>; Fri, 29 May 2026 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034896; cv=none; b=imLzZ36nJzp3Dux4KwDxHkYaBMLz+ZBWiIDo1iwCm+jWdQFwKwCERcx2EChrQ2v5mU6xTz478PWC8ZzZtGPAkPhYmM/yardv9C5cmBmGI8alOJaSsI6vSMrifuEGMOASLkNZunytUDi2daQa6Bk5wz0OfH1SiI4eD6mEx8HkDcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034896; c=relaxed/simple;
	bh=HHC6e+kD/9SrX7+OVxyl7mUnMFwBNgh86D5aLKZXzRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWZSPS7jMU21TKxYbBKA5d+F7X+FOKbhZBxtXAmfzbCIa9fh3cgyHC3Tvhnn1aQheJfepaWpISthFd4XrtOkDqZXCSZ7wvMbdMnFwYmnZhTfIr04Ukn089Pz5SCtwD+DAb6dV+w37AxO8JTUeVbk/QvdNoFEBnHiJYSFNBagSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFoMaHX4; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304b8ced372so4022019eec.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 23:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780034894; x=1780639694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAYqt2vh2yfr426P6OZcPGX7qTEFDCZm7KXgv2UYgjw=;
        b=EFoMaHX4GAONe+IvOSTmsqigKs80LGBRUHUvyCuQv7UGefqvNlVism4AROPgrfipWx
         zb8vYMwIY2VXeTGP/BeAhBb4NdhWJoS00FCRLi2ykPzqC5Rp5yF4/V8byNNmpoj+Z1Hs
         kHg33o0kkb0vXM4yiRrzKdt/jsHYLZg06ykFpdHBw/1+wYr5EQh6H2t8LXYNG28Fl+zL
         XHEyJT3dPmJZqSp7orLcWOWu+yEVrasmUp7AiywkII1qCtcvOG6mTtd/mzG55ITTsQR2
         CNC6GR3IWz0l5hEyKbuTH3cXzKh8THmOYWfXP79rDpNaA1URY/Zfn2kI2x+IKuBIi6x9
         NacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780034894; x=1780639694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KAYqt2vh2yfr426P6OZcPGX7qTEFDCZm7KXgv2UYgjw=;
        b=CpCXt7I4exgCcpVuH4DbmEvPI+TGcydZ2hp+t8WeoyBerGncBijQXkTa2LD8UzBVHg
         2t3CPkjMGujiOHw1LYtJzQsOJ0Wp9TanEJSmQkMSdBb9qDiUPYkjkjRKb6arfeD7rqVz
         amsWeZWJ25m47nCohbpQAKACFGr9Z3PDLmATSo7ntw0vPCcIhvDaF/x6819+DtWb6OJu
         JJw0zmbLb7gLs/mBa99M7+lJJusXLq0YjVnJ82cPWUC+tHx347mbbEX1Uh5ImkaaEh88
         K+vqyfInRrKXCKn1UOqExnmO9sKlldS97n3tTsw1oxp6MoHvGjPYSx5kGLqpo81pFzE9
         EqJw==
X-Gm-Message-State: AOJu0YwH8eLIkNrhKKw58Q66GoVWhJG4ZWhCjUgoHaxdWP//flyt6iEu
	bgcq8H8TAau+y37sInQU+JM39PrKdRF6GJ/aP99EIMZ0GPj9G1bIdl1+lXHEREuyksI=
X-Gm-Gg: Acq92OFJSEAzAM69mwVNwWkgwXT9+qh+d56uQDVIEw4lEnqkmVrwic0nW1gefJ7ZiJH
	17hb4aThVPrSiH6bF9OgRF/vs2Ow3NYcoBC7BAUIVC86+CHTXDGxcqAyA5x8Oq0Op6+CnqQRd7G
	hyCWA0VH4Q7qQMplx/shOfJ0T2MnZ5EXrjJ6DJUl4eRv/xKu/xSImfH9PLBklrjQdBteh4HTOil
	gI52VnaD9tdZQrFUOkc93IwFZ9G6Z5W9Tr582AFCLqS2w/HaJ1W419+gbtkmrtdSZ0IVtGcJFJW
	dSf2ZC/juHL8GU2bLfAuyTf/cBkGZYNVaOuK73HdfkiM1sNWmLA65REBEUg43c63x2ATMTUj2DC
	eww5HJYkaRKlX9DkVJCWZ6BJg17pXRpiRFa0LrHI417je/zazelyU1EGbIPks+0Q1eJXZKgJSjm
	dcz0E4fY9RMLTwX+EK53ixpnslyNP91F+/Pjy5GAL2oFg8j4YFrhmMFXEW4BT1NQdVmQzjSVbqk
	swCuBB/7JcWLXWMxBdsOt6TXQ==
X-Received: by 2002:a05:7301:e2b:b0:2be:1f58:32a3 with SMTP id 5a478bee46e88-304eb228f05mr682330eec.29.1780034893923;
        Thu, 28 May 2026 23:08:13 -0700 (PDT)
Received: from localhost.localdomain ([2600:381:9b0d:7988:3c9b:bcf6:17d8:5fef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed578c48sm637742eec.20.2026.05.28.23.08.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 May 2026 23:08:13 -0700 (PDT)
From: Ian Klatzco <iklatzco@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	peterz@infradead.org,
	yeoreum.yun@arm.com,
	David Wang <00107082@163.com>,
	Ian Klatzco <iklatzco@gmail.com>
Subject: [PATCH 6.12.y] perf: Fix dangling cgroup pointer in cpuctx
Date: Thu, 28 May 2026 23:06:57 -0700
Message-Id: <20260529060658.69703-1-iklatzco@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAB=irMzhVj6B=T6XS7VyN9K_5Q+gCHD7dsw7fKSPWuNfjEATvA@mail.gmail.com>
References: <CAB=irMzhVj6B=T6XS7VyN9K_5Q+gCHD7dsw7fKSPWuNfjEATvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,infradead.org,arm.com,163.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-256518-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iklatzco@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email]
X-Rspamd-Queue-Id: D468E5FDCB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yeoreum Yun <yeoreum.yun@arm.com>

[ Upstream commit 3b7a34aebbdf2a4b7295205bf0c654294283ec82 ]

Commit a3c3c6667("perf/core: Fix child_total_time_enabled accounting
bug at task exit") moves the event->state update to before
list_del_event(). This makes the event->state test in list_del_event()
always false; never calling perf_cgroup_event_disable().

As a result, cpuctx->cgrp won't be cleared properly; causing havoc.

Fixes: a3c3c6667("perf/core: Fix child_total_time_enabled accounting bug at task exit")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: David Wang <00107082@163.com>
Link: https://lore.kernel.org/all/aD2TspKH%2F7yvfYoO@e129823.arm.com/
Signed-off-by: Ian Klatzco <iklatzco@gmail.com>
---
 kernel/events/core.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fce2bac6dae..9099c0cc933b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2096,18 +2096,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	if (event->group_leader == event)
 		del_event_from_groups(event, ctx);
 
-	/*
-	 * If event was in error state, then keep it
-	 * that way, otherwise bogus counts will be
-	 * returned on read(). The only way to get out
-	 * of error state is by explicit re-enabling
-	 * of the event
-	 */
-	if (event->state > PERF_EVENT_STATE_OFF) {
-		perf_cgroup_event_disable(event, ctx);
-		perf_event_set_state(event, PERF_EVENT_STATE_OFF);
-	}
-
 	ctx->generation++;
 	event->pmu_ctx->nr_events--;
 }
@@ -2457,6 +2445,10 @@ __perf_remove_from_context(struct perf_event *event,
 		state = PERF_EVENT_STATE_DEAD;
 	}
 	event_sched_out(event, ctx);
+
+	if (event->state > PERF_EVENT_STATE_OFF)
+		perf_cgroup_event_disable(event, ctx);
+
 	perf_event_set_state(event, min(event->state, state));
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
-- 
2.47.3


