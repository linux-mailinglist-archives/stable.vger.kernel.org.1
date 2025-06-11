Return-Path: <stable+bounces-152400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C62FAD4E85
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 10:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D713A738A
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 08:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9130423CEF9;
	Wed, 11 Jun 2025 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aUV4CA7G"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0F423C504
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749630906; cv=none; b=e8r80u3mbEa9DgsiAvv72QV0EpvW3SiYE80lWcEGN4McvnbsgZ4jQNuZbLwcFGRWM/RNMmrzsk6xtbPSU9u+PL++uxP3/WtdlUK2NDojkaTAKpO3knFLpP5h0oGrrxnF0JtEDHOJ026n24kejsDuvPCY9jagCCsBRGKx5CbnXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749630906; c=relaxed/simple;
	bh=sh28WoI07kRUIOUIAPoZClX6B7O6vXzsXebAB+1KS2g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gvheTCQ/Hvjs+yye82L7iSOcib/l7jj9cfON5GAsvGTwZlBwxyLpFojt3t3QyF1jHck4bnXje8YRkiTPuFvYc/N5rVNA12OPhSoGHhoOjuKFmkujn3id+HzrC9vBGk+kwxQfbt2nwr4nQTKjOBUAIRomexiKWRqN9MLgfyNzVHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aUV4CA7G; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a43ae0dcf7so4781021cf.1
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 01:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749630904; x=1750235704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IJ/Ii+kzH15uD/kklpl8P0Wjrt+djWjANqmqylLT3w4=;
        b=aUV4CA7G7bpNTtWcY7F0cLIj7pxdvL36l+IDqAjm85d28e3VXW6BjCWIckIglY/nPM
         6B9IQez8dd694RLUGLPo1AabVkudY9KZS8AT8bVeqb/Tl5TpSfUgxnHFL+vInUY6kDsC
         PrfHA3mztoqYO3kOXtQ36jhdWdOv1t40ABi6hm4D0e5Y2KkAnqFSYaGPozOPTCwfatSA
         B4++I6H5YaAoBfRBjdPlImNAgBcRr8W/vsZ0y2KTE0v3mHpGw7231LBtrUDxNqrSQqt3
         0UJmx+4wQSzLLK7mhZ1r8RSfhYIncpCgOeHzrpRCoHBC2aL58eaBaKaZqxzu9gDBhebB
         KpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749630904; x=1750235704;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJ/Ii+kzH15uD/kklpl8P0Wjrt+djWjANqmqylLT3w4=;
        b=FilciRsYvoUnl/xk5HogiJsgjGYQ+2knVL09yHo0br4AHjdbfYbGXmQlr35bM29s9Y
         m3K8rVFR/s+jPbkOVHQX/R/BY1QzNoVAtVh7+smoMuO3YGUy8u2PiFIoeL16+WVEvbrP
         G6nvOKgpfyBBUfquB6h58bHK2fy5RP4BzlRmCsSBmxSLb4twKakn1mDh67N+9w4IJFD5
         m+XoWEMZ+U6BWII2TtM1qrzmwJtFlTjrBAvzDmMblf6nXkHRh02WRefMco6sgtjWYnJx
         SYvl6X+95p1cA0BiSsxE8vxh12OJ+jGBQuFKaIUSoc5cnLyV4037TIbFI9SyBjDVC0IC
         IbIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfKRwaiqdgbJQZfiLbq45dmAnDWfMMylF6Gn+nWYMdD+txMawYOkjoDSIfwh16JVqPmy10QQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJfLM1HXBlfleGxLCbjEBp9KqcGeQN8hG+oD++AHskzzkqQyI
	WlDX3/tYBdzc6hMiCYs0lVWXIzDlkNbxAPATmQ12ImWNqCNszKn6a2Fd8d2XqQ2xC7j9cqmYZG8
	Y0zs/hU7YhQ/+mQ==
X-Google-Smtp-Source: AGHT+IHw9sP/8Wq7IkSrM4UC8Nhhb2G5uH2e5zWZM44KSph1JcvfbhuuK/JHaueoOQppzQT9FDzSJA+zFpr+MA==
X-Received: from qvblx13.prod.google.com ([2002:a05:6214:5f0d:b0:6fb:461:b629])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5dc8:0:b0:6fa:c4cd:cca3 with SMTP id 6a1803df08f44-6fb2c3274edmr41060906d6.14.1749630903742;
 Wed, 11 Jun 2025 01:35:03 -0700 (PDT)
Date: Wed, 11 Jun 2025 08:35:01 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611083501.1810459-1-edumazet@google.com>
Subject: [PATCH net] net_sched: sch_sfq: reject invalid perturb period
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Gerrard Tai <gerrard.tai@starlabs.sg>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Gerrard Tai reported that SFQ perturb_period has no range check yet,
and this can be used to trigger a race condition fixed in a separate patch.

We want to make sure ctl->perturb_period * HZ will not overflow
and is positive.

Tested:

tc qd add dev lo root sfq perturb -10   # negative value : error
Error: sch_sfq: invalid perturb period.

tc qd add dev lo root sfq perturb 1000000000 # too big : error
Error: sch_sfq: invalid perturb period.

tc qd add dev lo root sfq perturb 2000000 # acceptable value
tc -s -d qd sh dev lo
qdisc sfq 8005: root refcnt 2 limit 127p quantum 64Kb depth 127 flows 128 divisor 1024 perturb 2000000sec
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_sfq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 77fa02f2bfcd56a36815199aa2e7987943ea226f..a8cca549b5a2eb2407949560c2b6b658fb7a581f 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -656,6 +656,14 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
 		return -EINVAL;
 	}
+
+	if (ctl->perturb_period < 0 ||
+	    ctl->perturb_period > INT_MAX / HZ) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
+		return -EINVAL;
+	}
+	perturb_period = ctl->perturb_period * HZ;
+
 	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
 					ctl_v1->Wlog, ctl_v1->Scell_log, NULL))
 		return -EINVAL;
@@ -672,14 +680,12 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	headdrop = q->headdrop;
 	maxdepth = q->maxdepth;
 	maxflows = q->maxflows;
-	perturb_period = q->perturb_period;
 	quantum = q->quantum;
 	flags = q->flags;
 
 	/* update and validate configuration */
 	if (ctl->quantum)
 		quantum = ctl->quantum;
-	perturb_period = ctl->perturb_period * HZ;
 	if (ctl->flows)
 		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-- 
2.50.0.rc0.642.g800a2b2222-goog


