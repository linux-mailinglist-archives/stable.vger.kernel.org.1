Return-Path: <stable+bounces-198193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA63C9EDAE
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346E63A638A
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891FD2F5A13;
	Wed,  3 Dec 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RubBXCwX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFE02F5467
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764761890; cv=none; b=ht5wgKAcpOXeLGCYyr0UTHwKPcI+sA0bs785BSY8DHze0TjIcx4+p36ePahdaeD/H2ndzjGUZjOXMGUBsYY3q/QsXXWfdGYn/ZclWI/0eOUAx3dlISuyk5R/uEs6wCZWCpglviaiMDj3Q+0dUPkbO65wJlrpgF6EcgfR4jkmtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764761890; c=relaxed/simple;
	bh=3ZfId0fg17jLpmXVAs6RDt/lgvIwJmUHkgZynliI29I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ko1N1owsyQA2D6CzWOgSzemJ4QB/c/iSD0fxnvUMkDdImXFzrX8RF2Kc2DZXI0WZQoasrSisjwMFgT2thkeq03ZzA1ENgGvT+WDTQWRStu1L3eSun7uMgGadRZHZhtizcrtPex8/P0E+3BdO6fOHvsi7ifCa6Yj2EwAOQomhsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RubBXCwX; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-29844c68068so73345265ad.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764761888; x=1765366688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwoBIBoPcN27LB5ca5Kj/q9w5devdvomIojhATPdeUM=;
        b=izDnnJLWRa5EMyhZg6yMuw4HYRV/QDhedmJqwX0QdrlITJRXAEL4y2Mfe7YpyaDgSt
         s8JHmT/3XWqzblBZvKYseRNh8rGCWleO7UJACKejgnTyNn3VDm3Krbg0dnlM+lookp/6
         x/ZpwQ7vZgUpbTmwKEG4sT/cOQoAC4ZMeZhB7/HlyEQdEWpqJpA/m+sJAKtriORPjdae
         asTVv1XL84Vdk1FxQkNIRZ7TP1rz05XoGwjK6KZh3ijDzVqvJ4IMpohaQNVzJ2+da/+1
         BHz7Fe3IWDPftMVolFWYwP5/Irwuw247eFk2yBX1FTl4KS6KVwckdJ5w1XQplewnW9kZ
         L4hA==
X-Gm-Message-State: AOJu0Yy1LeGF8kdyJTJ3KHlMr0jE4Q+wOSAXA+Tnte1/VFrbIfeGXmlF
	Af2ElA4W4oiMI5EAFnihQFEqYe/9UFmOU3HOP/Phq79a/inmk2xzZJ7gsCEGx1JQDbQV7/jtSmJ
	jKYCuKCwXn6V3QHrfHWGaQEmeNjjp1FOlYhoRuXYAKATlM3qjwwQXEZ+1YLtb+owtjKBPbD8+7T
	0GJHl70Up63qaNRCqcTVGsEM7mrneMwDY4GtdBJXO5YuJhe+Fx3K5VkzgM68ZWTCwau8q4SnUgu
	dhA53c3OSc=
X-Gm-Gg: ASbGnctGrtmi1Kb3qaZcXwEJ4R8JtU2mggmX+ZA3ROUM75ZE6/eLDk+t5wAeEtviw6X
	RHVRxs5y5whuZOS0PvWdvUWqqFsAscGoLT3rA7jcDpg55XjCpgUL0qm0gYMZo+P/+yEewZMlwub
	YQt2GiLUQJgB4RKAr8cfXjRbh68hQiJ83BBEFCxiGgL47HcwOk2xje1Nh3/xe2BCTSS2pM21HaG
	68rdssAJZ3jUTS5VoPgVGeKYwraFKWODjCmthOgqZ22l9jbQjuvFQe8RE385lefqCiLvVwauQ/S
	JKQG806Bpt3I/vn+cLOwPSKV3n5lO6OCeqcyuznXXSV8zysOhcfY8XOU34FeZvMig/MPv4Ouhhu
	K7emf7wqLUU6Waq8ekr3MEcsujDsIwpAmaK5IsFrZ9NRwz3v/OMYkYry8aLFWWtiU7FqD8hOZtl
	6mFuZUDLThvGpJT9wofSYAGgEWE5wXxdMZHgqZ/0nFz6gf
X-Google-Smtp-Source: AGHT+IGp+elSGs3fVTVXLWSW1pQh8bv9aA2H4uaSCTrFJ9lzlqOO9MG/UICxdqnADXFH+dQGGSeRKBEi1TlE
X-Received: by 2002:a17:903:1b2e:b0:295:7804:13dc with SMTP id d9443c01a7336-29d683b1f12mr22897705ad.48.1764761887995;
        Wed, 03 Dec 2025 03:38:07 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29bce445afesm24967295ad.14.2025.12.03.03.38.07
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:38:07 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3437863d0easo9735971a91.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764761886; x=1765366686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwoBIBoPcN27LB5ca5Kj/q9w5devdvomIojhATPdeUM=;
        b=RubBXCwXV6eqT8DWnifQ/AefdMZqiYX9ybaKYsoG3zDHx2F1iKnFfrGqMONLOGzPbE
         sMONMT4ToazbNumYTJsLWptBi+EAyWJgsu7v2cnGmYH1jRuEmS2fqfhoM7/fdqa2UHoi
         ELhlykF8hExgHxigcJ1uD5n7wbvz7ZsS+H9w8=
X-Received: by 2002:a05:701a:c965:b0:119:e56b:9593 with SMTP id a92af1059eb24-11df0cc504amr1158027c88.24.1764761885834;
        Wed, 03 Dec 2025 03:38:05 -0800 (PST)
X-Received: by 2002:a05:701a:c965:b0:119:e56b:9593 with SMTP id a92af1059eb24-11df0cc504amr1157989c88.24.1764761885142;
        Wed, 03 Dec 2025 03:38:05 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03c232sm83169465c88.6.2025.12.03.03.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:38:04 -0800 (PST)
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
Subject: [PATCH v6.12 1/4] sched/fair: Revert max_newidle_lb_cost bump
Date: Wed,  3 Dec 2025 11:20:24 +0000
Message-Id: <20251203112027.1738141-2-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
In-Reply-To: <20251203112027.1738141-1-ajay.kaher@broadcom.com>
References: <20251203112027.1738141-1-ajay.kaher@broadcom.com>
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
[ Ajay: Modified to apply on v6.12 ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 kernel/sched/fair.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8bdcb5df0..7ba5dd10e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12223,14 +12223,8 @@ static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
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
@@ -12935,17 +12929,10 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
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


