Return-Path: <stable+bounces-198198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE691C9EDCF
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A36973A642D
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE92F5483;
	Wed,  3 Dec 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Fa9O9KeQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D0D2F5339
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762021; cv=none; b=Mo8yaEhJUtUFgs8uIBz1xPweBAuElAVj8YgZpaGcl9sd6vZJN25TpPbGU0h37p5LCztxZPuIQhuITJMyYRApeg8M5sMeEj6t+lwIPVm2thciRnE+XtATryj0EgdvUhVxct7Zahho6eyKkdHGLjOvQQkCaabXwM4cERAZGblmSaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762021; c=relaxed/simple;
	bh=1gdc28kwhY19UQraDdo+Rzp2Og6mCveOvOii9v+y3lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aJd6sJRySwjI2EhycgguEWDnocUNkueGvppWpQaLLy6gdEpMWZvj343Z8YMu9NaNGeTa5c0DkYJ42z/QO+bKq6I0C1WEPQNc/sLB4DMMJmmfxUcIZstjN+k6vnMojpfhgGjxbb1dzcHbeqOVV29PSTTMLyW0yInZT9VGGB68/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Fa9O9KeQ; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-29558061c68so80255585ad.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762019; x=1765366819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Brn42TT1Ey4jdpd/BGskKy4rpvE127k8ANXujp7zLgY=;
        b=DKPDNPiIa/sS6JqrvGARE9VmDnA6QXk/AVMHxiQuLko1D3NEbGQD7o3iapQVxLetuP
         1w8Zc5ToYbEzCcfWYDa148EjbArgf/eTV1QVV6pRAAvfDzTHW7UaSs49AEG0kgNsv+q3
         1hzrDQZRhjcSEW74BW2070943qfzxWfk72Xor3utUGXi21gElWJARcn20LEaOFB8XjEj
         pDgMbymcnnlV5psUcJmUbzneualFj2STnkwlUJfGN1ZJfNvV7vYYBAYO/8aRz3Q95Oev
         j8PR5ZT6L+ZFvLHTRLOAmsSAgUXXbhxOmvnBZxEWhE4Dh7vc7rOUnCMoZ4DjEdeeOJ33
         2O5g==
X-Gm-Message-State: AOJu0YybYdKOqSSMg7jYj0AmX1MdVtgdmO30ulq3LIccJaoTrl4ZTYkz
	DMqAsPaBh45eYbz/89PYchFpHcVCkLKf2pcS/vBKE1J+0NxFbCfduFbJUPQY/N96NK4LHP+Usz9
	Zs0pmIdXevnGKzLMtC71qaNlRzdqCCocZD/j8BbTgs+3B/3fL2XY9CuKOtkHgk55fpuv9wD+g6h
	2Z+wyVKi33438E8MGXVLEHB6JsT6A+kzMTNO/yRRgbNdUA2cdhxzyc3W56nIq8g5WhYTSU4PlsX
	eO5ruaDpmA=
X-Gm-Gg: ASbGncvODyz13rK7UPH1pqUj7QuJ5xLDaNOO43OA9fLdeBrZt2X5CcBMJLeCO6/i35A
	i1zx8lZIn0x6GHwG9EVHvUwcBZ2QwQmwgSBmsgUbT29KXsvQPoHBg3bV+DeuVTxX9nPcaiEvl3O
	ptel0+cqMLqTqxJj/ywGzDc83vjD3T4nXeh2IX5bWRW3lnyKTte6gy7iHmbTofC7ndUwMb5G/4j
	xZiXkcQjifqAbx7jl7Se879EVpw9bc1li1mXR1CTA3rQzVyewn23BoZGkFjTdfz7hRyqYaoUS1x
	3mDbqxDj3JMpbxmi16ExAi5MfFpUW2sKxYjuTJmxN1Ams7r/r++j0QqsUMTWxGpvqJ+wINvIPS+
	WnVNqya9b74OlnLxKCy2lSTR90Wi1uTuxT3e0xgfPaVkZD+eehfaroeYXl74g21HMVaHV/+XQUD
	/+nMQ4uG818QrFZZIOxFxia9o0ZxryJPAdHVJOfS0ZRw==
X-Google-Smtp-Source: AGHT+IEnYwRj9AesiutdpuwULSPLimtc0D036sWVMjBRlhCngr95oVpFyvvifi1JItSRYTAeekzX6epEsR/Y
X-Received: by 2002:a17:903:246:b0:295:a1a5:bae9 with SMTP id d9443c01a7336-29d6833a056mr19423695ad.8.1764762019473;
        Wed, 03 Dec 2025 03:40:19 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29bce44a37csm25994325ad.20.2025.12.03.03.40.19
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:40:19 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b9ceccbd7e8so11427236a12.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764762017; x=1765366817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Brn42TT1Ey4jdpd/BGskKy4rpvE127k8ANXujp7zLgY=;
        b=Fa9O9KeQJrmuJnYbn3aXC5HldDURzEwZIlhNIi0XbdcnHb+eJxWTLBVAEEaQ8MIDUB
         9Vc4bR/Vu0f5Csz67C29cR3Ojh7zJnSmHKDfSdh5UCE35b3+gKEcokiaomEh/6AUnUVl
         wWb3tP51qeQqvMuvvkTrCbwJWOT2nyxjpuVs4=
X-Received: by 2002:a05:7300:d09:b0:2a4:3593:9686 with SMTP id 5a478bee46e88-2ab92d39d8amr1444479eec.3.1764762017464;
        Wed, 03 Dec 2025 03:40:17 -0800 (PST)
X-Received: by 2002:a05:7300:d09:b0:2a4:3593:9686 with SMTP id 5a478bee46e88-2ab92d39d8amr1444441eec.3.1764762016700;
        Wed, 03 Dec 2025 03:40:16 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b1ceeesm63324781eec.5.2025.12.03.03.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:40:16 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Adam Li <adamli@os.amperecomputing.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Chris Mason <clm@meta.com>
Subject: [PATCH v6.6 1/4] sched/fair: Revert max_newidle_lb_cost bump
Date: Wed,  3 Dec 2025 11:22:52 +0000
Message-Id: <20251203112255.1738272-2-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251203112255.1738272-1-ajay.kaher@broadcom.com>
References: <20251203112255.1738272-1-ajay.kaher@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Peter Zijlstra <peterz@infradead.org>

commit d206fbad9328ddb68ebabd7cf7413392acd38081 upstream.

Many people reported regressions on their database workloads due to:

  155213a2aed4 ("sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails")

For instance Adam Li reported a 6% regression on SpecJBB.

Conversely this will regress schbench again; on my machine from 2.22
Mrps/s down to 2.04 Mrps/s.

Reported-by: Joseph Salisbury <joseph.salisbury@oracle.com>
Reported-by: Adam Li <adamli@os.amperecomputing.com>
Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reported-by: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Chris Mason <clm@meta.com>
Link: https://lkml.kernel.org/r/20250626144017.1510594-2-clm@fb.com
Link: https://lkml.kernel.org/r/006c9df2-b691-47f1-82e6-e233c3f91faf@oracle.com
Link: https://patch.msgid.link/20251107161739.406147760@infradead.org
[ Ajay: Modified to apply on v6.6 ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 kernel/sched/fair.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7f23b866c..842d54a91 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11710,14 +11710,8 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
 		/*
 		 * Track max cost of a domain to make sure to not delay the
 		 * next wakeup on the CPU.
-		 *
-		 * sched_balance_newidle() bumps the cost whenever newidle
-		 * balance fails, and we don't want things to grow out of
-		 * control.  Use the sysctl_sched_migration_cost as the upper
-		 * limit, plus a litle extra to avoid off by ones.
 		 */
-		sd->max_newidle_lb_cost =
-			min(cost, sysctl_sched_migration_cost + 200);
+		sd->max_newidle_lb_cost = cost;
 		sd->last_decay_max_lb_cost = jiffies;
 	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
 		/*
@@ -12403,17 +12397,10 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
+			update_newidle_cost(sd, domain_cost);
+
 			curr_cost += domain_cost;
 			t0 = t1;
-
-			/*
-			 * Failing newidle means it is not effective;
-			 * bump the cost so we end up doing less of it.
-			 */
-			if (!pulled_task)
-				domain_cost = (3 * sd->max_newidle_lb_cost) / 2;
-
-			update_newidle_cost(sd, domain_cost);
 		}
 
 		/*
-- 
2.40.4


