Return-Path: <stable+bounces-155165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9620AE1F5D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584894A7738
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C1E2DFF17;
	Fri, 20 Jun 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQaPn3th"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B672DCBFC
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434402; cv=none; b=FP1gBFAvLVeXPhBa+52QAPHcdjYYfxfrExvKUhmE7WIWoxgTkShSbmDqXRmlce1n5nys4HeWPXXhLldXvVEB4EmN3bBqf6IK2f2petQY1KCq3qZb7CvacDcqETCJaSKz/ErG0KQPGOheLt9n41/jR4evCXxmYtuk8ZmInkm3o8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434402; c=relaxed/simple;
	bh=cgYK5zL/t3cCEL6oBtGAm7p4hA5atud8qd8DNZQFNIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I0wrklYGpYcpNUTb7Z1J/LWbF8PH7F1KxOi41YbZbMSV5hFtNe2i4Txp8VwcXJnmWZztbAgZKjKas3ZPKmaqZ+Db6/QNprCkaSf/svzsNPQ+zutGJyDbdAlCfjknoWWhjdJLQS7xJOuuZfGjsZbsOAB9EenAOXJtHSZTR089zGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EQaPn3th; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a44e608379so52758301cf.2
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750434400; x=1751039200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+gqSzDrqfN1FIzooCH3U/vYXBDGoIJOBuY28y8ITyKA=;
        b=EQaPn3th0hfmj7v9rWBj2OAneTfaMOynxoMa77Dd0EvAsLt3TsYW4dI00cEkJYTlQg
         sOvg6UzGEF01gbApb5IXEycWHeWYcvD9tDdtg1WXvoUUfCLQ9jNQCyOnU4tiPwIQRpjE
         zS/o5vxknLNoiYyPE76t45w8mVELjAFffOHNY9/+gfWaPZ+aRYwwt8vbFbXptXgxCVvc
         AUX6Fb+bW7YmGqlM+J2HRIfNOmaHPQobEu7XdvizaXVeYKA1v1EsJwBCGAycSwyLcTHN
         zxgs8m+TJ/k0bbYn6tZNWMP2Nf6rBFCyybAdmtsFLlkq9Swtj0ghVOGBkYRQr6ej8DDB
         zlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434400; x=1751039200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gqSzDrqfN1FIzooCH3U/vYXBDGoIJOBuY28y8ITyKA=;
        b=t70SISDEKLwXrHTS8EE9F9APiZurerPid9Ofqi9GU5DgQYpqMh8SS+cHeWy6TB5fJQ
         zy+KqmNLoqXqoyjE8IRT/MAcCyMdLnSX+8C9varucCV3vqTosXI4ef1vczT/DcV/E/2K
         Y/mNTPYWEO5ODjucuLsa/TX9t8Efl1LF6HjUzcSLXMg06cKDseh/C+cNb1VrgYC7N1Zy
         b0QKMt22jVz30nvN89WjXJmIlP6qEVRrE887zUZJNlHQWN3HdES6SpArQWIwzhspu9sR
         9IHIycwD5NDW25asOm3Qab+9Y1+L5j81R8XeGSGXwvh7sEnAcfC93xb0eXTQsdxH/EgP
         SMBg==
X-Gm-Message-State: AOJu0YwfJrLUyYU2C9wzTxt4bmnildTq/UaUozsrjE0M4d6m2ybg4a4S
	lXWYnxhrGkTkrgwQRM4YbZ0EHkWbOCTDnjzswliLaDZQcf9iCJ6vBxw8Gbw6xKas9qIHZlZLA/E
	zu6C1SiuO1Ri+ZmpS0xcFUwKiysbEcEALy4hcFHLGuhqg7edd7uZjbUltUkQI27cPkP45VU2I4T
	QX/XaRyGiBfc+LuEcsJcmyb/cBwsDp7byN2Gmhchl7X59r0RU=
X-Google-Smtp-Source: AGHT+IH5L+LFOL16Rrf73QtI0gCdd1Xfq96CjouPEXp3wypjL8ceqdeLDM3A/bXZyKoEMbejwNCnnOh0A8ip0A==
X-Received: from qtbbc10.prod.google.com ([2002:a05:622a:1cca:b0:4a4:2e9d:515c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4d46:b0:4a6:f99c:3962 with SMTP id d75a77b69052e-4a77a2e6717mr54634481cf.46.1750434399859;
 Fri, 20 Jun 2025 08:46:39 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:46:20 +0000
In-Reply-To: <20250620154623.331294-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025062025-unengaged-regroup-c3c7@gregkh> <20250620154623.331294-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620154623.331294-4-edumazet@google.com>
Subject: [PATCH 5.15.y 4/7] net_sched: sch_sfq: use a temporary work area for
 validating configuration
From: Eric Dumazet <edumazet@google.com>
To: stable@vger.kernel.org
Cc: Octavian Purdila <tavip@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"

From: Octavian Purdila <tavip@google.com>

commit 8c0cea59d40cf6dd13c2950437631dd614fbade6 upstream.

Many configuration parameters have influence on others (e.g. divisor
-> flows -> limit, depth -> limit) and so it is difficult to correctly
do all of the validation before applying the configuration. And if a
validation error is detected late it is difficult to roll back a
partially applied configuration.

To avoid these issues use a temporary work area to update and validate
the configuration and only then apply the configuration to the
internal state.

Signed-off-by: Octavian Purdila <tavip@google.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/sched/sch_sfq.c | 56 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 505209a932ab73a91a0b15f990d4c9d7a206a05a..0d916146a5a39b492a89067e19b81628bd72f5d1 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -628,6 +628,15 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	struct red_parms *p = NULL;
 	struct sk_buff *to_free = NULL;
 	struct sk_buff *tail = NULL;
+	unsigned int maxflows;
+	unsigned int quantum;
+	unsigned int divisor;
+	int perturb_period;
+	u8 headdrop;
+	u8 maxdepth;
+	int limit;
+	u8 flags;
+
 
 	if (opt->nla_len < nla_attr_size(sizeof(*ctl)))
 		return -EINVAL;
@@ -653,36 +662,59 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
 		return -EINVAL;
 	}
+
 	sch_tree_lock(sch);
+
+	limit = q->limit;
+	divisor = q->divisor;
+	headdrop = q->headdrop;
+	maxdepth = q->maxdepth;
+	maxflows = q->maxflows;
+	perturb_period = q->perturb_period;
+	quantum = q->quantum;
+	flags = q->flags;
+
+	/* update and validate configuration */
 	if (ctl->quantum)
-		q->quantum = ctl->quantum;
-	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
+		quantum = ctl->quantum;
+	perturb_period = ctl->perturb_period * HZ;
 	if (ctl->flows)
-		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
+		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-		q->divisor = ctl->divisor;
-		q->maxflows = min_t(u32, q->maxflows, q->divisor);
+		divisor = ctl->divisor;
+		maxflows = min_t(u32, maxflows, divisor);
 	}
 	if (ctl_v1) {
 		if (ctl_v1->depth)
-			q->maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
+			maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
 		if (p) {
-			swap(q->red_parms, p);
-			red_set_parms(q->red_parms,
+			red_set_parms(p,
 				      ctl_v1->qth_min, ctl_v1->qth_max,
 				      ctl_v1->Wlog,
 				      ctl_v1->Plog, ctl_v1->Scell_log,
 				      NULL,
 				      ctl_v1->max_P);
 		}
-		q->flags = ctl_v1->flags;
-		q->headdrop = ctl_v1->headdrop;
+		flags = ctl_v1->flags;
+		headdrop = ctl_v1->headdrop;
 	}
 	if (ctl->limit) {
-		q->limit = min_t(u32, ctl->limit, q->maxdepth * q->maxflows);
-		q->maxflows = min_t(u32, q->maxflows, q->limit);
+		limit = min_t(u32, ctl->limit, maxdepth * maxflows);
+		maxflows = min_t(u32, maxflows, limit);
 	}
 
+	/* commit configuration */
+	q->limit = limit;
+	q->divisor = divisor;
+	q->headdrop = headdrop;
+	q->maxdepth = maxdepth;
+	q->maxflows = maxflows;
+	WRITE_ONCE(q->perturb_period, perturb_period);
+	q->quantum = quantum;
+	q->flags = flags;
+	if (p)
+		swap(q->red_parms, p);
+
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > q->limit) {
 		dropped += sfq_drop(sch, &to_free);
-- 
2.50.0.rc2.701.gf1e915cc24-goog


