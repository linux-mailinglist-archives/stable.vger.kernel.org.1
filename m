Return-Path: <stable+bounces-198200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8FEC9EDD3
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D005B3451E4
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8532F617F;
	Wed,  3 Dec 2025 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AB8/2xrR"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D262F5A22
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762024; cv=none; b=E8BiSHmxmEYFgMfl9fM5z1XJLAIcUcXTMetJNoTB77pHuz6/2v2TrD0++7ilsoYtqKbxkLMpl025Pl576Vzqn3ByHYD+HTdvfH147zlDR7KjUjjOnEYC2zyZHhXRRzaSDIwt348I0w0ARLBPcRk/GGTMI1v+7u7/b//XA4rtkxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762024; c=relaxed/simple;
	bh=9EPDhCCtWaRo4rHvSMa36kDhj/Pz8zBcRzcppxUZU6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=En+AcTQ6LDyCZGJ36IYkgxABVrLqpXVWzBHaW5TecGD9TIKCSL0TNb9UM05POal5P2/CHpnP7h0qNbgS6xYR55UF+S/ymJdDwlPLSFz1JmcVuTObzzthAhsCtmWZO683lm9YfX3JYVCZfIQm4GlU0vNM2K74eGBE22bL5+Zs6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AB8/2xrR; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-3f0ec55ce57so4357842fac.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762021; x=1765366821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1iH4y3Zrgl56i/VHQKgTMa01v/ge6GrCshnPXW5Ao8U=;
        b=NWBCwPHMj/0KfiJtx2+dfHU0ffOVZucSY6+ZPSYbOty3aGd+cQG9hezWcRATslCsrO
         k4DSR9x6q5H/xbo0x/VQkGXifSLHRx3XXMdCz7oTn7vGqxCM46zL2G5ygcvDvxifUPw3
         koFZTrsg78mvGfRjlLXLQfSPGLu6nlbkZxh8PTiTAlUTTdwvOXY2nihAGCP0mb81qj8Y
         eEqV12Xi0tffvkeHPcFWV6RgyUoY7ijoMwF6/d7IElYsEToGHiZA47f6rLvcy00ixrF3
         zkzcWzb3Btv2XNL61NhcVcIRTOM6jTscC3n3q/bhkDxAvNB55I8nI0puXz+d3IjGr8YU
         yxVQ==
X-Gm-Message-State: AOJu0Yx2AFQ7nxIFM8feDa45z/XEncH+vyymsHt5QrmVmW/O2fzQCOMz
	FBqpXRg8qKev1+mszXRrta9W6w+sJlaDdAmxLdQcAkAT/Bk5Stpw3qAvCN4xgk/1ld6lIXr6itS
	H/kCjhjfscZv3HCxEPs7BRLmYoqjwu4eSYz1XyoKOFAA8KxmgafYlxPZUu5ixT/hbj5/OH7sjgK
	mT6lRG/Bq1vzpr0Nxe8V7IqgmKGmeFyYge99vtUu8sMwFsGLPPnCMQfRplhC8iyO9L7sqNVF44P
	omRb/VDqrY=
X-Gm-Gg: ASbGncs8zDj2SxetijY1xhGxVxjbi+66/xyjBeoX4ETQaJxFGZMOYgw6mz3Hq1LHXoj
	ttVPFuBwbAUgSdSqjXvBDU8SrwzOcW0kpzqyc6ihJmqM2WbqLbWUFG8g+4a85Hka9yK8Wkb3ouM
	Lz6Th1N74w7lnhJgRvbUZbERFFPFG81+ucjf92DrmUKJ5nwG1g8hrjVozNv4RCId2xAIZj/xPjr
	KViA45PiJz2NdnOsiN7ctktqHUcUHpJLamNkvbC6/O0hJrsy2sr6glYm3Um+TOlbtFJU+6hXxBT
	Cy9Vj3pXgRvL0CqeM/epBJaxDjHUUR+GVFBOKcFtuZbW13ccCq0YP5fgi0lMqAJULhyHtrw3LrV
	OBx73fFmZzXen0lXF21F4mKkGQiAqUky4kVAMnQ8jL1fLGS+hIhFVQU0Ozn8sHY1A1M+t5xgPe8
	pDCrEykrHD07pv8OxbJpVbia2qpn3PNwoj1S90vFm2GJiH
X-Google-Smtp-Source: AGHT+IFhIR8rdrtDXQN0WiHOa3/kOjpiAb+QbIlVfdvVmPhVGNhlhaTS86LKSFitZKp70Df6eNSYRrSWBeRn
X-Received: by 2002:a05:6870:95a4:b0:3e7:e458:6699 with SMTP id 586e51a60fabf-3f1691c00fdmr1107889fac.20.1764762021555;
        Wed, 03 Dec 2025 03:40:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3f0dcfe902esm1990191fac.12.2025.12.03.03.40.21
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:40:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b99d6bd6cc9so11063163a12.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764762020; x=1765366820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iH4y3Zrgl56i/VHQKgTMa01v/ge6GrCshnPXW5Ao8U=;
        b=AB8/2xrRsmJY1SqLLMRtCGW5LrZAlJLipFOHhN06PQ1uk7N24w2hZRwHlIWBm6brzD
         YQFo3GuirYp7lT34BNz4Cjo7gVDPnHLmnsVssSGdl3Fnpba6MsdlQtokcA6uS+awux4f
         ivWhunC49HuOwmCIWXt7W5jqfZ0kHHJcSBuRI=
X-Received: by 2002:a05:7300:6c89:b0:2a4:75f1:fb27 with SMTP id 5a478bee46e88-2ab92e37150mr1660520eec.25.1764762019657;
        Wed, 03 Dec 2025 03:40:19 -0800 (PST)
X-Received: by 2002:a05:7300:6c89:b0:2a4:75f1:fb27 with SMTP id 5a478bee46e88-2ab92e37150mr1660479eec.25.1764762019027;
        Wed, 03 Dec 2025 03:40:19 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b1ceeesm63324781eec.5.2025.12.03.03.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:40:18 -0800 (PST)
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
	Chris Mason <clm@meta.com>
Subject: [PATCH v6.6 3/4] sched/fair: Small cleanup to update_newidle_cost()
Date: Wed,  3 Dec 2025 11:22:54 +0000
Message-Id: <20251203112255.1738272-4-ajay.kaher@broadcom.com>
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

commit 08d473dd8718e4a4d698b1113a14a40ad64a909b upstream.

Simplify code by adding a few variables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Chris Mason <clm@meta.com>
Link: https://patch.msgid.link/20251107161739.655208666@infradead.org
[ Ajay: Modified to apply on v6.6 ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 kernel/sched/fair.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e47bf8d6c..f93a6a12e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11706,22 +11706,25 @@ void update_max_interval(void)
 
 static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
 {
+	unsigned long next_decay = sd->last_decay_max_lb_cost + HZ;
+	unsigned long now = jiffies;
+
 	if (cost > sd->max_newidle_lb_cost) {
 		/*
 		 * Track max cost of a domain to make sure to not delay the
 		 * next wakeup on the CPU.
 		 */
 		sd->max_newidle_lb_cost = cost;
-		sd->last_decay_max_lb_cost = jiffies;
-	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
+		sd->last_decay_max_lb_cost = now;
+
+	} else if (time_after(now, next_decay)) {
 		/*
 		 * Decay the newidle max times by ~1% per second to ensure that
 		 * it is not outdated and the current max cost is actually
 		 * shorter.
 		 */
 		sd->max_newidle_lb_cost = (sd->max_newidle_lb_cost * 253) / 256;
-		sd->last_decay_max_lb_cost = jiffies;
-
+		sd->last_decay_max_lb_cost = now;
 		return true;
 	}
 
-- 
2.40.4


