Return-Path: <stable+bounces-155166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D813AE1F5E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A510162279
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD7D2DF3D1;
	Fri, 20 Jun 2025 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYkcJugJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802162DCBFC
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434405; cv=none; b=VZrMajspilFcz8BDeBrL1qElPQl047h7dsj4Ras4khfoO8IQ2JnuSq2+VL/rQxpOEvnnawwsWYVWadHfA8nHBVz+jazOFl/VUcBgdTd8NxVmSN0NQkgXKGtrzdkA0Ils+1RaiayLcD96JZmnIg7VaDM8EHBkCP/UW2welLTkml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434405; c=relaxed/simple;
	bh=RvUXr9RNiBUs+4gpgWmx4okGWF6NZL16onR7J49jqfM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EYN4QIXDqy2MmRgE9WispcjmHszQJLzeH4xcPVZR+vJXr7EpDFtkTwVEzgWn4eBwNv0apOAB5VdYw7ddy0TNhALDzVaczRDb/MKIcIQjCaLYtsHxleHpdQNtYYkKCki+pzDdZwS/geBbzHt4qflzxArbKoU4jtwrECGK5HBEA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYkcJugJ; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a6ef72a544so43096811cf.1
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750434401; x=1751039201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dHMRx8QTCVNMgNej4rfu8pcbRZVZRf5zjmMWDndGwCs=;
        b=oYkcJugJBnYij/nyRCwyu1+aF1Zx76r57mDIjLcSBIRoiPPuebgowy/Q8rl3DtlucO
         4szIIqqObS73CYKklz/K4Otjt5LcEFmOjZhae3eneHPtL/iavTIwS5rQN3cIsM5V9SQF
         wsmyngGsfVsEMJuULtA01ZY8dSuSZEZTSkQxHBN3TVeUFIuKRzHwWLHPANSXiuNnvsSB
         pe6xOP41/Lsi78vv7/3fE8nOrgyqPvUszdQRTEEYbIrWU5pTAeXpN3d7TOWtyMWpay6s
         JiOjGqlH+vfKwZwbY+Rhkt5gg5l6syFQwitPsb/qL48vWX/1YIXOLmnwr6XWQYHP3zPW
         IpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434401; x=1751039201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHMRx8QTCVNMgNej4rfu8pcbRZVZRf5zjmMWDndGwCs=;
        b=TSyrNcKt+zp7pxjncFchsEXqO4cj5DxjeQ1FgV8BHHZsdjw2pimCNhKYAz/H1gGkMY
         qiMCt/r531HAttTDCrTXvdsh41ya47UVKzgO5rghGGb7+wuJGe+bl6uj4YcxdDq2zWGQ
         OL3+aYft4yhUwr10r2V5I1R+qgxl66xXXUADddFlSFsnYlJQA9rPwIJXsY7vhW4KM7jA
         wXkPKriIqXYjPcpykDhvuApn8r7wfJ5qx0oNwwOWXBf1tyvOXc3ZlxTI88JYBETgtgGB
         1Dti+dHJFskMl5QDzAznX9ffzo82vvOYWBckFwKV6xHIL7JugpchJsQd7k4UD/ZCdanp
         yJrg==
X-Gm-Message-State: AOJu0YzaiX55GuwBaJQEPd5pWrW5c0tXW9fCw6wlaBN3gRwxyPvd23Qc
	9VslvBDt/O3XWQ6g0R02fJhuyRsLbhwrall5XVM+LodLYzsJ5kJD1XO2r8PvSXwOwSuH42FCbBA
	3JoiGXTz3EDl3+75sWOjPsshtrQ8ehPE0tdECbIqQ9L+rhHTBuSPr4l7eCDrRGHTpQAfGHN+8ly
	sK7xze+TEnaeJ/LVOOD3C7Drb/KTt7OspVSpXouoF63dI2dxM=
X-Google-Smtp-Source: AGHT+IHtLOlK7Aih0S6dXvNjp3rCjgDTBpuoy0wDPuqndmNkZZRKyHB2GH3L0X6zDQt8ZIt/XEBNJxxLTf/5tw==
X-Received: from qtbbz22.prod.google.com ([2002:a05:622a:1e96:b0:4a4:eac7:c1a0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7f4a:0:b0:4a5:912a:7697 with SMTP id d75a77b69052e-4a77a250761mr48689291cf.47.1750434401180;
 Fri, 20 Jun 2025 08:46:41 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:46:21 +0000
In-Reply-To: <20250620154623.331294-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025062025-unengaged-regroup-c3c7@gregkh> <20250620154623.331294-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620154623.331294-5-edumazet@google.com>
Subject: [PATCH 5.15.y 5/7] net_sched: sch_sfq: move the limit validation
From: Eric Dumazet <edumazet@google.com>
To: stable@vger.kernel.org
Cc: Octavian Purdila <tavip@google.com>, syzbot <syzkaller@googlegroups.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

From: Octavian Purdila <tavip@google.com>

commit b3bf8f63e6179076b57c9de660c9f80b5abefe70 upstream.

It is not sufficient to directly validate the limit on the data that
the user passes as it can be updated based on how the other parameters
are changed.

Move the check at the end of the configuration update process to also
catch scenarios where the limit is indirectly updated, for example
with the following configurations:

tc qdisc add dev dummy0 handle 1: root sfq limit 2 flows 1 depth 1
tc qdisc add dev dummy0 handle 1: root sfq limit 2 flows 1 divisor 1

This fixes the following syzkaller reported crash:

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:203:6
index 65535 is out of range for type 'struct sfq_head[128]'
CPU: 1 UID: 0 PID: 3037 Comm: syz.2.16 Not tainted 6.14.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x201/0x300 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0xf5/0x120 lib/ubsan.c:429
 sfq_link net/sched/sch_sfq.c:203 [inline]
 sfq_dec+0x53c/0x610 net/sched/sch_sfq.c:231
 sfq_dequeue+0x34e/0x8c0 net/sched/sch_sfq.c:493
 sfq_reset+0x17/0x60 net/sched/sch_sfq.c:518
 qdisc_reset+0x12e/0x600 net/sched/sch_generic.c:1035
 tbf_reset+0x41/0x110 net/sched/sch_tbf.c:339
 qdisc_reset+0x12e/0x600 net/sched/sch_generic.c:1035
 dev_reset_queue+0x100/0x1b0 net/sched/sch_generic.c:1311
 netdev_for_each_tx_queue include/linux/netdevice.h:2590 [inline]
 dev_deactivate_many+0x7e5/0xe70 net/sched/sch_generic.c:1375

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 10685681bafc ("net_sched: sch_sfq: don't allow 1 packet limit")
Signed-off-by: Octavian Purdila <tavip@google.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/sched/sch_sfq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 0d916146a5a39b492a89067e19b81628bd72f5d1..04c3aa446ad3d69c014b06e66795b8dfbc369333 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -658,10 +658,6 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		if (!p)
 			return -ENOMEM;
 	}
-	if (ctl->limit == 1) {
-		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
-		return -EINVAL;
-	}
 
 	sch_tree_lock(sch);
 
@@ -702,6 +698,12 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		limit = min_t(u32, ctl->limit, maxdepth * maxflows);
 		maxflows = min_t(u32, maxflows, limit);
 	}
+	if (limit == 1) {
+		sch_tree_unlock(sch);
+		kfree(p);
+		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
+		return -EINVAL;
+	}
 
 	/* commit configuration */
 	q->limit = limit;
-- 
2.50.0.rc2.701.gf1e915cc24-goog


