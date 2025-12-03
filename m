Return-Path: <stable+bounces-198205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F468C9EE17
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F48C34B1B6
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7698E2F656C;
	Wed,  3 Dec 2025 11:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eCvtRU7S"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFCE2F617F
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762215; cv=none; b=TQFHB67DOX900OGPRPYTyonx3SuqBHgMGT7T54k0E6A4d/JZaOc7bZJMX1O62giRrkTZy8ZIy8eAew8XO1aGx9PGCQMCDlkltZ1iYcpHvJlZLjxQpNOvxy6wPODEaIeFKiEyMCux9R8tzu4iTpsCUHWClmqaIwVRoTO7Ifo3EO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762215; c=relaxed/simple;
	bh=4J7PIolAnA+0ar2aFpYpjYwUmB3rJDZiGwj5VvC7eK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CO1GFKpHHDG2X0oksxv0/eDiX/lrKMBSnTPS8z44awZQRJH+yepgav0cmvv3096YvtcD4vpVR0Woo4K7Cgchn3tBOqq85pDYSkdu9emq5a85wWeRa0TcHrDqEKe7qoV+31gw8R7tFV7Vj+OppmZtMV+9Pke1SeUXgnqJtQA7k5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eCvtRU7S; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-4ee257e56aaso8134201cf.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762212; x=1765367012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ciwg4/3mhwvtZ0RPA5sXQX/xfpLeKOSvzNQ2tetDUpM=;
        b=K60jWRSvFKBBuexGkRegQGfKMz5l9/r/s1iEy97zZxKYeIxhiZj+nckl1iBeMHJLb0
         4wxxPvGwqToHxmUCer0ssQsy0WkC4uyk7Dmrc13ltbk16rhyDq8qWHH4JV2/FtkSqQkO
         OFY7pc3EAdseoMXIKVgVMQfqdr30DK0uHs5XY4rZlfJ+buc/T3FU6TbTBDCAJecZare4
         h+wq2vW5lYaVH9+85R+P846viryRmxOX6B648PnDPhmtbi+NJgp0EFJkLdOczf2ceP88
         Os67sHmVt9fm2KEUxC7uBYKsGrqiu/up9x4g4IEtv5WLy1KdqZ7c9o7gy9vejOQsSfWD
         UIVw==
X-Gm-Message-State: AOJu0YxTgMbuM8/tH1+7hjfwDUJZxalEIZp16S2I5SIIaY3XG4D8Hrcz
	bXYqoWD8wGVS4h+qiOaJIgrTvVpcYstcMzEzmxjptDl1NhFIjXO61ePlwkF3BL9KKYc+UssRaP3
	MIpNtgAhMMNZnmgKTDD8sMS+1f8RdIg0VWn+W/bE5pe60QofOHIQ5Eaf8eOO34odFl5lxldYY+T
	E++8WQSzpg1zpfLa8VsmmN0Q+/7HceRNKiRtJUlOHP1MEcrMAgbHeqh0/4Xm/2b87dQT+vfPPKy
	pAyYF3tRMQ=
X-Gm-Gg: ASbGnct43zQt2dWhptXlXfKnbt6n5HarnO3x0XIuaBksghYzJVRR/W8xsMnzp93xbWg
	hMFduIWOSHDqYHXRXJVA+1sWmt1wf8aJJCH+ChpiQL7LPI5cyS9B9qfpLZ1egQel9reK2Jm1fG6
	BHoQZ9cA7DyWTdePMRBWt1oMHf+Lpu72y06kB0aDJkrNXYhv8a7ocXFoi4dcWVhX5ZG9xbrCB66
	V+0aTNGYDjvkqnWYlVr0BbEtv58vrSfJ6gUkPqLGyfLHJssfn3YUSdUAeLnMlyzOsZZ2xSp9qx+
	sdlP65k0h2PUwrMu6w5oG3/+p01f2aF6H/GgD00F/uhJM0IscEU6OqvfgGXyCEs6FAeNj3u0jrE
	o8KteK+8Vyz45aFsonuTnhi+MhiwUfQ0gi2KNtvdDfB9WCXo+4wTav8Uw/+/q64ksIermEGsvHO
	El/dMp60xuaOHpatNbrhKB3FwBVmCPZx4UTDmIJREaz4QO
X-Google-Smtp-Source: AGHT+IGKGmYubeFNoDM8LilAMkvDrwr2sJxfVddJIdzYoQ+zTN0NtXIr2KHyz9lkBGZ5b2RSoQnPt8KB0FCK
X-Received: by 2002:a05:622a:1451:b0:4ed:7fe3:7be7 with SMTP id d75a77b69052e-4f008994a36mr88325691cf.24.1764762212249;
        Wed, 03 Dec 2025 03:43:32 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-886524c9996sm25287936d6.11.2025.12.03.03.43.32
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:43:32 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b52a20367fso202595085a.1
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764762211; x=1765367011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ciwg4/3mhwvtZ0RPA5sXQX/xfpLeKOSvzNQ2tetDUpM=;
        b=eCvtRU7S2TvoYVerT7b6TmljL9Gma0+FVwnVaYKew/yGaH7ChZcJlSJjMoK+hn9Msu
         R1TJejhYZw+w9qyjT370GQkgsmC4s/sRnI5r6D2uxVCUuF5VZE2vOyns5rB2yMJFF4Wn
         faqPACpF8KPZ77Y+NMX1Am5+A3K/1tWdzbxOQ=
X-Received: by 2002:a05:620a:2681:b0:8b2:dd78:9288 with SMTP id af79cd13be357-8b5ac0684b3mr900417285a.13.1764762211458;
        Wed, 03 Dec 2025 03:43:31 -0800 (PST)
X-Received: by 2002:a05:620a:2681:b0:8b2:dd78:9288 with SMTP id af79cd13be357-8b5ac0684b3mr900413085a.13.1764762210951;
        Wed, 03 Dec 2025 03:43:30 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1b65bbsm1284727985a.33.2025.12.03.03.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:43:30 -0800 (PST)
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
Subject: [PATCH v6.1 3/4] sched/fair: Small cleanup to update_newidle_cost()
Date: Wed,  3 Dec 2025 11:25:51 +0000
Message-Id: <20251203112552.1738424-4-ajay.kaher@broadcom.com>
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

commit 08d473dd8718e4a4d698b1113a14a40ad64a909b upstream.

Simplify code by adding a few variables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Chris Mason <clm@meta.com>
Link: https://patch.msgid.link/20251107161739.655208666@infradead.org
[ Ajay: Modified to apply on v6.1 ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 kernel/sched/fair.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9a7aa83ca..2f296e2af 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10937,22 +10937,25 @@ void update_max_interval(void)
 
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


