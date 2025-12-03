Return-Path: <stable+bounces-198203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B45C9EE08
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA01B4E557F
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A3D2F60C7;
	Wed,  3 Dec 2025 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c33GpDac"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F28C2F5A1A
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762210; cv=none; b=uSmykSpsyGOdNdd4m/1NIGpdOagnH9DM0h500xcnDBixKMaamaMj5L3YAjsjLprHWWUwRcjb4qxP6gW04UFKRouBUh2eGpSSmCCuCe1uLL8wGy9hdrTuR4Y/+0RRtLnIt4f/7JWarcOug6+XBTb6392EZidFkXCjdcObf3EVvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762210; c=relaxed/simple;
	bh=0haK8KYriPaTG6SlT0IxDG6YPomgA9ogsrkebaJgMvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Alb0awlyQOwW4CN0WD4dxrJs5psYGKz1taYEFP+dyi+cQVp+YyCCSWf3x0aUBAt9X90jKvuxMOqMJq5KpxhJpv8pEj012HD0SjaFrllTMBNn2i3Wj5raDdbwsBO77CC1Z1mlDIdKPl3+eH3EFlpSRvBo+9GIdiVNOUQXvgz4mGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c33GpDac; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2984dfae043so57504745ad.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762208; x=1765367008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PH4ANwBhxoAuPZERs6KPB00evBiCDrU2sux4zg9pefE=;
        b=ZUnciXus4Y/mFOJBA4GMjoYqqNP3BnWrFcXLqovK3VWbFDeWIyjXmCjP4BeibP6lGY
         s3h9NpvFNnFxlHieCedpfRLs6AVgdUIa5CK9s0u6ZqprJoTAflait4ur4sJ5YPmY1iVv
         Epeg0TfDogu5E6zyzh0ZCf0JbHti0M0QwmHI5M+u3vW5Bluao5vA8Y2KYs+JVKKsRR63
         4Dx7s371nLEunwba4kNG57VKi7DLH+PWGOV88ObMBL+QJuWMY3qgHB4lqpEmE4tdh8DU
         5a2UyX9IahdclCQIGR4ipYBwQfTTilH6ABII/hJUugScY0bZm7ar676G8tjSTr9ArRWK
         N6Rw==
X-Gm-Message-State: AOJu0YynprL7Jlp+B7/oW9oPaPNG8vJ6ufnsxwf4+DgtWCf/FPLwBheX
	JtAEr2gr+vGLWFX6YPiwdZddrv7StX2/JMsZ7BYpnK5dR5JwZg/GH9HnBAutFRtDpHkte+WS5nB
	FqZuyTJcMvnehPcsB9+3YCthb0ozx1w41UWdgQvtCKtUoH1Xxoe0cYEQK7NskfmruRsqC2W/iL3
	sK8IbKqvRKXcySJvLLZvRpuifajrp2pv07sew2GRpV5TNhtEpcPI/7Hg3RsaS5ONJOCwrjdUbci
	hSsXlxyO20=
X-Gm-Gg: ASbGnctjuYNyyiFwOvyL7RpelG/1Gh+MDHzYD5RkdGZj3FCmXwr5EYLiE7odT0Khf0s
	6gtCoIXWTbRYZGC8pwiA75l4RKMk4bTYbg/YrHIcZDu7mnlxTgCPgb5BtRR9M2yES6yJ7gjNZYd
	rU/cN5b44lSUQGUEdFiZihtBf6bWQ6qC/Ffo/i91hF3eYLcXq710CLXxvNRSdmy/yri8VMz/mo+
	mFaD997rd9bZSerCj+olQnnyJh+IFqHj3Fv/TMVqeb1UTGKMayU5h58qm7W7+R9MrB1S0bx5txa
	669MxGFFUW28VtuBCMK+pRQOWCA+EMQ9B2dznhKRjyjFRvgbQK2E4X86vvgfPq7eHOcD1c0WM5x
	9BUJtTXeGh4R2iDXyhu6hmqVB4WaCXZK9bGai0sBhPIDENoyFLILzcn2MEZT+SkeLAH2B+BZ30+
	NkQBgNDV2qcm4kfjBg2Jc2WWa8Z76P30kwIaxRcmVQkok0
X-Google-Smtp-Source: AGHT+IHK4xxPe+rKQnNWml/Pb+jjUNfpwKPLolo1vgadp/BmeG3gcYepKcG47rkZgUMMyLhX2+JS6HF+gYid
X-Received: by 2002:a17:903:458d:b0:295:6e0:7b0d with SMTP id d9443c01a7336-29d683e9b80mr23756615ad.56.1764762208008;
        Wed, 03 Dec 2025 03:43:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29bce41bc81sm24780905ad.13.2025.12.03.03.43.27
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:43:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2f0be2cf0so1901721985a.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764762206; x=1765367006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PH4ANwBhxoAuPZERs6KPB00evBiCDrU2sux4zg9pefE=;
        b=c33GpDacu4sKVV4JVk/MiC3oBzKDaPajZvZN4Ke74wseoS+hHOLl4VXDIRVOmslLsa
         h4MG/15feVz7u4lRMHLSlbh9A5iSKA+s+ZyVvwYYNxzSIBQWLiZ9acmMvKsqnbS/XRd/
         NNv7gqx6Z32tkuQHYdiW0ZHiJ5rZu7a2c/aGg=
X-Received: by 2002:a05:620a:4049:b0:8b2:e87e:1093 with SMTP id af79cd13be357-8b5e47a151emr228688385a.3.1764762206406;
        Wed, 03 Dec 2025 03:43:26 -0800 (PST)
X-Received: by 2002:a05:620a:4049:b0:8b2:e87e:1093 with SMTP id af79cd13be357-8b5e47a151emr228684385a.3.1764762205927;
        Wed, 03 Dec 2025 03:43:25 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1b65bbsm1284727985a.33.2025.12.03.03.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:43:25 -0800 (PST)
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
Subject: [PATCH v6.1 1/4] sched/fair: Revert max_newidle_lb_cost bump
Date: Wed,  3 Dec 2025 11:25:49 +0000
Message-Id: <20251203112552.1738424-2-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251203112552.1738424-1-ajay.kaher@broadcom.com>
References: <20251203112552.1738424-1-ajay.kaher@broadcom.com>
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
[ Ajay: Modified to apply on v6.1 ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 kernel/sched/fair.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b6795bf15..f5a041bc3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10941,14 +10941,8 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
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
@@ -11630,17 +11624,10 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
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


