Return-Path: <stable+bounces-95587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683CE9DA263
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 07:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7AF2857B3
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 06:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A10B148FE6;
	Wed, 27 Nov 2024 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWgrmNBa"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642E13D89D
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732689490; cv=none; b=ckQ/tu2VI8YZX1chVTws6kkp/Y51lz7OL2WQ17ZIHz1ecjWHtWIuagKskPlvmdP011Cv5L3SYqER47YvVPpsJyq7Y5k3smmbbrBzI3W6sMRdYVH7gUb81LyiRoz/3TtwPvYgdpCQF/RJYKZJGzez6SSOi86wqE1awExNXm93WzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732689490; c=relaxed/simple;
	bh=dGtP0OFWPFMzdrmrsHo4j1Z7kYCtxwor60WjBaEEkak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iUDf42Ut9psdThk3oHXYgnJaHFT+QiYL4948pVgs9cKC47Cv4XtXNNylNc+2RME7ffVpeJwtrp0W7s98D2BbvWjNdlcRzUBLArHWASRvMjgu/YrftyZTMJEfVB3nzYbUlEXQmOeU2r/sK0+8D3i9ppgzl3POdx7SgZ4NRN5KN3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWgrmNBa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732689487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G+YCBL5Fbtu9FqPpXsCFPCj+WxNq+b6w4EIVlKRXk0U=;
	b=NWgrmNBa+9GfvpXdv5X2ZpU1sB2cCmO6IyoFIYLHpR83H0gp9cNDIFFGBDBFg7UhYkQEFz
	OkiP7LYBPuwfMVNgz3ftgXs0G+2CfrA+q/M+DyDMWw9mEOdc5GQKQHPdA66RiHw/PY/Eo8
	55yJXoskV9fH4/A9O8Ec1M8QwXFjuj0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-cEZvrj3nOgSwjdxLCH_Z6A-1; Wed, 27 Nov 2024 01:38:05 -0500
X-MC-Unique: cEZvrj3nOgSwjdxLCH_Z6A-1
X-Mimecast-MFC-AGG-ID: cEZvrj3nOgSwjdxLCH_Z6A
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3822ec50b60so3714785f8f.0
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 22:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732689484; x=1733294284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+YCBL5Fbtu9FqPpXsCFPCj+WxNq+b6w4EIVlKRXk0U=;
        b=rcrFQ50/caUmyMYUmzsBysaXY/BPrqQDaayRUudaEuVyILAO5kLRcF9fLD184MleQm
         qohW/3WYxVMPnqrGM7NLQvBOzRTmHB4Jyw6kfA+NPNEtZdtzg8//5STyuWJgdp/VywHs
         lhshi70Ig8GQG4/K/Mhao3ITN6fzBrCwBn660jG+4fHVseBre6oiO30OMiu+CMoKHsKD
         76vsGRHO+APkR97UI6mM5lkEEEpHIIl5sf1I1xGtZpDwkVLqoCRc/buuSp3HbT54mZ7M
         93rH6skdpY3U5N8ZsAlTEr8RhmqYLqx6QC+nGYS1QDA4zpwLbJeVs4G6NJ3uuPGpoa8w
         mwUw==
X-Forwarded-Encrypted: i=1; AJvYcCWtDAmwfZb+ZyB2VdXcvOseGz4/9BtlRW3UVvV+IgPweUiUXA0HW+y83AHINE6RLh33r4DUpxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/UjwjDqOlmXP0a4t0t9ItzRKF0sjldV7dLTlXgBTBE6pTRjc
	33e829bYi1CWV8RyQHBzMxutqGddQ+aygXq1v2nWlb0GoimKSPImdhFbEKeTnSgXq9/7gqNrPTv
	jKBvfJ+hiIeI4yDQxE0cnT8bKDuLFcgUR0kRRrttHq4+oURWekdg2Rg==
X-Gm-Gg: ASbGncvM9I3joi+DzzqWEEVEdOFKQVfh271VEkcVuhMXUw4FdxYoXzJu927/tC8QFXI
	Fy+OW+uUILOQQm8cfovooy4rS68pnSeoR0nDU1EYmWs4GDpIJcGialbdHYuGJjhnr9w0uYfxRH3
	L1FTXILInHAABuxFZdcKRJUzAK11ebznDiRlqf1U+1HYLlaWdyu2sI0w0PE3m+F+G2Ds72JcPie
	0dOOD+SqF/xJPc/bDrBzJFOesFQi5nS9qIXr8DRiXvU0XW466poS13sFZfxDkn6QuJIeoKXOEH2
	q88=
X-Received: by 2002:a05:6000:1fac:b0:382:4926:98fa with SMTP id ffacd0b85a97d-385c6eddc05mr1380237f8f.40.1732689484220;
        Tue, 26 Nov 2024 22:38:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYKQMJPg1pK+Yv9OE2yE9UfK7AcAnlLcZVCkycjl/FISYqlhmKJ2bvx8Wr13qgtwDOSA3c1g==
X-Received: by 2002:a05:6000:1fac:b0:382:4926:98fa with SMTP id ffacd0b85a97d-385c6eddc05mr1380217f8f.40.1732689483910;
        Tue, 26 Nov 2024 22:38:03 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.75.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedebfsm15403742f8f.100.2024.11.26.22.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 22:38:03 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH] sched/deadline: Fix replenish_dl_new_period dl_server condition
Date: Wed, 27 Nov 2024 07:37:40 +0100
Message-ID: <20241127063740.8278-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The condition in replenish_dl_new_period() that checks if a reservation
(dl_server) is deferred and is not handling a starvation case is
obviously wrong.

Fix it.

Cc: stable@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d9d5a702f1a6..206691d35b7d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -781,7 +781,7 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 	 * If it is a deferred reservation, and the server
 	 * is not handling an starvation case, defer it.
 	 */
-	if (dl_se->dl_defer & !dl_se->dl_defer_running) {
+	if (dl_se->dl_defer && !dl_se->dl_defer_running) {
 		dl_se->dl_throttled = 1;
 		dl_se->dl_defer_armed = 1;
 	}
-- 
2.47.0


