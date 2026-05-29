Return-Path: <stable+bounces-256519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB05KaAtGWogrwgAu9opvQ
	(envelope-from <stable+bounces-256519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:09:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B0D5FDC5A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A6C3305C510
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B0336D512;
	Fri, 29 May 2026 06:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qE9OuFe6"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96921E097
	for <stable@vger.kernel.org>; Fri, 29 May 2026 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780034904; cv=none; b=cNhXqSwnwro5K6sTcx8q8OhGDmnfFw/IAGjWUIYwuMytsOOw8el7yJZ3SrCidiweP66viQV1+J9KCIQA8UDmGiYQ2+j1GjoZerGIWGdESF0sHJ52WP4jSBNCKmaSGOCNHSb4K2vm8W5VSrbIb+L+2gKxdduB0tatjzhPPxmQqOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780034904; c=relaxed/simple;
	bh=LnibKwQpOlJb46nJLQJXqOxe6+XkRwc4fqRIjM3B9hE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CCwNSZT/xcd4Kx/z2esj3h6mwF9Q0aJ44KER5HrC0VzNEU3SwLtggeWLEAZKYJnabRKAAtkqIdq1S8SNrYh3asDqJ/jgE7+7oKFDqVbNXrTo0pnRhIicaetnjvfSmBGA4Ck/yUqQ0P3citEiqGI2fhxJCXyUJjlurWV7uJYlnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qE9OuFe6; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304b8ced372so4022141eec.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 23:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780034902; x=1780639702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfOCqyAcCU6kRgfu94uoahS3a9se4soGGGXVfKTWfOw=;
        b=qE9OuFe6ibDO7+0cTj9uOB7gBlpz5a0oSh8jvxk4wNeow5OV6jRfTiBR1G1fgI1QqG
         lpBkd8JrB19EZWuVOI54pYM73oiICr58X4RvwdGUKb0lRjFu+eN1/HVbTPQlAgqF0CWf
         shMvjEHXca1fWPSN+G5bRBQt88zTh8+jXwr+POkNkibfNhZeAVo3uXITKGxAVqxYTV/t
         SA548FAcUUS2UnmcVVIZbPeiCNXiiIkIyEfBpXgg19+hk8R1Gz2OYJ1HHi/CoICvu+OH
         xxtZ39WuFxXFm/eVLMA4CPEzuwp8H1Z+TPacRWW4tvgYCG6qnVrw6hbs3HP45PAMGmd4
         HAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780034902; x=1780639702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mfOCqyAcCU6kRgfu94uoahS3a9se4soGGGXVfKTWfOw=;
        b=ke1Zm/r2YqoU9bvVYndg/0A9QSJZFcmT3IzYFWQDFkrFkEZvSBs4DbENzpf8a1O/UA
         Ae7Rw4iDz8GH3aQX23UqcFcWNkTsG/IncoiyyXtQiy2U8rbQ9TKlPmWhT7ZQty/TgoKP
         oHNnSsaM4akJAf6gnkJ0mpa+sctUg8V+AtBlv5mdlSKfx7a0BKGlgwl9BH4aCo5ALfTm
         qVReB8bc3DiCR1XxQ0zSempfh/ff4Nv6bP5GBro52AQcCjGrjYH9ZOQDzj9lbn0GHztC
         0nQI4XOMHuId9majPpBwuEYhO+KFttdTp+lyZ1fVyHi4QqS8wYxTq1pwF0cwarD6YKqg
         vXBg==
X-Gm-Message-State: AOJu0YzO95NzEAc/fJeoWbnx0P8nwvC3B3NZ5ChU23wI+GLp5I4T66Mi
	EgyfshiLJsyuPglj9r+2PQBzDqrHZGx2TN/F2Pt6dNsuOh2riasHs3bPS+b+kaHLdxs=
X-Gm-Gg: Acq92OGx9BJwywlTOrhSah48vfjHnOrazqsXJs0WdPo3dBP5W3fxI0Ge63r0GATBYXn
	+fWqUBNB9lsf3ZfghPWfPcGWx+G4+d30TTJRegIFA4roeO5VB17Zo7gmg+MwvcJOCk3JSiIoBVu
	cPwbeuYnJXx1OICtKUwiMN4g/DK/CEuoj8vcF8jR3g0gSFYiEid7YLeNmxsJ8ZFNfsC2fiUDZ8E
	20VMIFryNuIiWmdqatFaN1cA6JkTQHEGSsuDJuKx4vBbdR24RI1x3m+lkLBYmPI0irRTg0fr7QS
	1hY4gHl5+besxDYweOsXzzVmeDOykE53KR8++3YzlWfOMCnkCl7UnIFe0n26vwotEauzZv+BiJ1
	TjC5RLx494/Goqpydb5kSusXGtCqSAI8mZPS5G7LX0dI059AXxgV+LAqTlOVuOyMigjeKQLKJj6
	6hZvgcGh6iMpXmjnk2hpaClE7aeMwt2gasx95DSgt26YV+e6b7+OMKGg4cEchoL14OjGAsNFzhp
	YBV9CdjLDXkwrKkwDz5Xx9nQg==
X-Received: by 2002:a05:7300:8ca7:b0:304:5a53:7dac with SMTP id 5a478bee46e88-304eb1d10c2mr616545eec.25.1780034896962;
        Thu, 28 May 2026 23:08:16 -0700 (PDT)
Received: from localhost.localdomain ([2600:381:9b0d:7988:3c9b:bcf6:17d8:5fef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed578c48sm637742eec.20.2026.05.28.23.08.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 May 2026 23:08:16 -0700 (PDT)
From: Ian Klatzco <iklatzco@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	peterz@infradead.org,
	yeoreum.yun@arm.com,
	David Wang <00107082@163.com>,
	Ian Klatzco <iklatzco@gmail.com>
Subject: [PATCH 6.6.y] perf: Fix dangling cgroup pointer in cpuctx
Date: Thu, 28 May 2026 23:06:58 -0700
Message-Id: <20260529060658.69703-2-iklatzco@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260529060658.69703-1-iklatzco@gmail.com>
References: <CAB=irMzhVj6B=T6XS7VyN9K_5Q+gCHD7dsw7fKSPWuNfjEATvA@mail.gmail.com>
 <20260529060658.69703-1-iklatzco@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,infradead.org,arm.com,163.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-256519-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:email,arm.com:email]
X-Rspamd-Queue-Id: 38B0D5FDC5A
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
index eba5eb6fcb87..a4187dea6402 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2056,18 +2056,6 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
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
@@ -2401,6 +2389,10 @@ __perf_remove_from_context(struct perf_event *event,
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


