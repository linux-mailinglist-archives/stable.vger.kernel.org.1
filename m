Return-Path: <stable+bounces-198199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4756AC9EDD8
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C1DD04E4E93
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8132F60A6;
	Wed,  3 Dec 2025 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fK2ZBqBi"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852DC2F5480
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762022; cv=none; b=JcoKTT7nAHxOU4pq0xCXE0nApr1YNDrH69QTRgUYwl4aT0mHy+yom05DY2aljxo7DbDxa6Cs7C/yoA2q4a/N+rG6BC9kk/JZjkfR+p4K6FDdJo8RF8BvlB9L7+TIBaFhM392dztwEFUS2rucmLrF0wN0HVnRfnWE4TcXtZ3sI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762022; c=relaxed/simple;
	bh=TXO5NRp5c5ShzA2cY2ZOV+GiFeT9eyDUZ2fy1Hg+chk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YpX3egZalQzSLetifq5E46avCimQvAe5d1HLR3PL/o9e6iUMflGNcELULZJlh1EUsYMWuG5hsXLZu/KkL5T3SRgJFM8QAAh2gVWeEvcVDPD69VJ0ypVrZ7rt21/8om4fIPYkVPb+kEpXD2lbNg4B8AWKcfDWH8o4XJ4TgYZFMNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fK2ZBqBi; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8824ce98111so97185106d6.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762020; x=1765366820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7amVhtvbqglJSO4BYYfWbBRtTIKW47Hm7wnmb8VHueI=;
        b=MWDJuDedM/9t8YlfIUk5R9i1JxrVNfD9dBn0mm9MxYA1bxDs4lVqceeohjWBvfM31u
         x8F+hGNfpAnjXE8CHpTRFGYcrjik3J06KCSrzFgNzY7ByzuO3SwjQBnq1YVZOq52EUMe
         Cngm0cvG6z0wpLCQGk7MijqCHs/++ZUs2eUnm0dghyXPWAVVSSEV4B/jmpXjqRrGcgXi
         eziXSWT4iL0pASyP/yqk1kkmpnbp0dh6KnAP/dSM/Ka2WkxNUw0x0HlaA78GKCb+j1PO
         0O8HDNOnHVtA3dSvH17YvfEGbjVeB314EY2CCwc2A7LUOAhykaNBzwLQFv7VaKaWKGoz
         oE3A==
X-Gm-Message-State: AOJu0YzIeaLKyy4k0f52scavYKKMivYXCywiCGPLbdxGc1+lAwmvgwSC
	CdoUjSJz0SEiH8nkSLzHVgevLvrCazvjepNUuGy/9sEUPoepSlRtLtQMJ/qvkp+R2jUqcUbHteo
	YTE1frKpRAYkpom+tZVLTR6IzmcAoiXWDvXCVuNPsTAuQrbuexbNSSdlZCIAYDtIES5XDWj8vs1
	fHXh2CfPx3qB8cOuS4QdfqRXRQE+Hx1eI2BG2udH7MN2Aeib7appyFzA+MBpTY6rdQSL4YZYbWa
	kAX864ocN4=
X-Gm-Gg: ASbGncuEVhHgDcMMW+o1R+c4Qw/nA6I8Xwghndr+nB1CIBw+Q44h2PgZ8BR1xx+NGdM
	UX7nRSYNoNTnPsy3Yq3ZcxwfiCEZXQwwHsg3LeWKPULLJV5l3JJ13E0zd1OT9w23stjuujDOw5t
	m8HB/bDQrHeOAC/pTfhm7UlgNIt8SUYy6tajjUxty6UfLxx2lYHCAO6jq1niM1mz8b5AWzZKwS4
	YV5pYd93Zwt5idOJdydF3ozebGzLN01zxMZjdAwApqhh1m9ZUCe/smW63kM8km4qUhedI0thdZa
	MTxfDrNfLsJiuP6nDhoNSP67JXNriVy5Oi25AKgIJQAAYXcdIqFB1MC06vlgHOk2bTlzxJ5AI55
	ejF1k8XWZ/VcFsSw1wCxkIF2FeyIU6h0pnTO7o8lr3JtGXB3WRVQrmbcUvlr8sqY/dpaMN0MkPD
	MixfKG2aJZ7X254hZm12W0bd4ZDWeIJKAMTIoojFEMxKmU
X-Google-Smtp-Source: AGHT+IEt0Edq/YJy6WQZ2FaBqxffwetdaHQvkLC6lxCGT4/EluHNHmX6y5EgbQoRrrUwMhN3K/3SK5U7dQSh
X-Received: by 2002:a05:6214:460c:b0:882:401c:e384 with SMTP id 6a1803df08f44-888195ac953mr24251106d6.61.1764762020274;
        Wed, 03 Dec 2025 03:40:20 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88652ae6291sm25166556d6.17.2025.12.03.03.40.19
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:40:20 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so9587710a12.0
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764762019; x=1765366819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7amVhtvbqglJSO4BYYfWbBRtTIKW47Hm7wnmb8VHueI=;
        b=fK2ZBqBiRBeNq/UQhVvx6VRGeTfb6yIU+aeXNSnebEzsvrfTJ+oS0mIYaO0ugKaYTH
         3uyJhIKIqJj6/fyhlDMfUCc1YHPmnLMzvS5jS18ZikzzBpC/20FR/pPEv4OFupkp9SBh
         LXermbLj8qu4shKxOZEomFL0sZ10JQI342Af0=
X-Received: by 2002:a05:693c:800d:b0:2a4:617a:419f with SMTP id 5a478bee46e88-2ab92da3943mr1071072eec.2.1764762018709;
        Wed, 03 Dec 2025 03:40:18 -0800 (PST)
X-Received: by 2002:a05:693c:800d:b0:2a4:617a:419f with SMTP id 5a478bee46e88-2ab92da3943mr1071036eec.2.1764762017869;
        Wed, 03 Dec 2025 03:40:17 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965b1ceeesm63324781eec.5.2025.12.03.03.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:40:17 -0800 (PST)
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
Subject: [PATCH v6.6 2/4] sched/fair: Small cleanup to sched_balance_newidle()
Date: Wed,  3 Dec 2025 11:22:53 +0000
Message-Id: <20251203112255.1738272-3-ajay.kaher@broadcom.com>
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

commit e78e70dbf603c1425f15f32b455ca148c932f6c1 upstream.

Pull out the !sd check to simplify code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Chris Mason <clm@meta.com>
Link: https://patch.msgid.link/20251107161739.525916173@infradead.org
[ Ajay: Modified to apply on v6.6 ]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 kernel/sched/fair.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 842d54a91..e47bf8d6c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12362,14 +12362,15 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
+	if (!sd) {
+		rcu_read_unlock();
+		goto out;
+	}
 
 	if (!READ_ONCE(this_rq->rd->overload) ||
-	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
-
-		if (sd)
-			update_next_balance(sd, &next_balance);
+	    this_rq->avg_idle < sd->max_newidle_lb_cost) {
+		update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
-
 		goto out;
 	}
 	rcu_read_unlock();
-- 
2.40.4


