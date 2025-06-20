Return-Path: <stable+bounces-155168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE2DAE1F66
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F9818801FB
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159BB2DE1FE;
	Fri, 20 Jun 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3bBaTUX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D742DFA35
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434406; cv=none; b=ujLDFi76ycVsnWjkJ9r33HHSrlUuEorXPXF1m4sMUbnsiOab9krWo18Dv4/JHdaghvJX1l5fs5AWdCzJ6AgLW/3uif/dpelylgkTGABmTqiujsjbnIwwo6XRwyJ5Y1jbWNIaw3dBZDSBubKeiewH6k0av1A1tfed04TRXvoNQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434406; c=relaxed/simple;
	bh=K1YuYj9sBibNv/j8b7QS4KdQXhHWTbs2OkutMttoVEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A0dyuytT3O14qm58fsQfyPRXJqWj5419951x08Phx+q9YQP81dePmpIuNDXU6xPrFc5kMNk1dkrjcTqOteTB29tjH3NkekKDicbgf+Rsv+NtSqgKLccPuuIp+mxrBSGGMFLjMeYkwueMB3rZjtMttYLCmpquJBSq+aKX98/cf3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3bBaTUX; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a587c85a60so41308041cf.2
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750434404; x=1751039204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0reMMWX+5SwPOhU8v99sOMU9TtPt4fwahRCAHnqHelQ=;
        b=A3bBaTUXYjZXRuKn4RYRs+PEoTmuYI09xWK45TrhMzoBKE4uOTiJT4J0yMRdYpPgO/
         MCuP+OwyN/RKlbivWzMvW+YdlypJekzBvCnDyBWOlE6xAFZz6cVo0VevUJF8FLdkmu1D
         pc796BUQLYJxpZ9GZw477uXZRhbF6IuzJY5jonwO1d3wczMHJ0WiR+UGVOdVNgIXTEVj
         N1LWc7yom1J7TVY0x1TV4rrL1hrVuTnTI9rTgcTZA/0MPKB7FipXtQk2F7XzC/vHmUuj
         vGwu47602feQfyoTIV/tKLWWRfrkTWPCbrxS/MG+U12jhok2A+D9ltcsBHhVCrUj+01r
         vwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434404; x=1751039204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0reMMWX+5SwPOhU8v99sOMU9TtPt4fwahRCAHnqHelQ=;
        b=gAyz01QPhwj5hz4GN8yfQIfWGNi6AN4WQLzOYgE23choi3wqyCg/q6p4LSGhqIYHfx
         DOWosJCn1Xyn5SfG4JOYzVViWw4F95RNfP+x8rTRvMMLQbppa90Q6oK/SOhBq1ndjMGE
         DsZmFfSsc2IC5USK2XPVahvdTBTcS3Kq8aUtBL1yWlyQMtva3wTAcDBybERr8XRPCqAX
         +UygUAwTsQRCLZV5R5IMG7LPYrNH0yC2rjM7IxCju3pCcQrsGXpZBMli0wJQiyj/VKIC
         6YAED9ZZ6NKxxpqs56asV10qolxMHTJsCCDnzkFBcdY7nBaNgJgEJfjM/5SWV2Ed5ktS
         Es/A==
X-Gm-Message-State: AOJu0YyjqowNPzwD7lrymZWWO3blenHuZMS9VbBn5FQ37y748PGrOKXZ
	hOzaB2cF3KDdLCNhW3TuzPklku+7M71DMvvGHfP/C6TW8yNdvXZS2lQ3QAPQitWg3sxa1KuAZ2N
	JGEWRoi4QCYz5R+cWJA9pduNNTNkF3rPONPZ2bK5Z+zre7vqIEXS+SGa1XtUXIOtTR0HvC4topQ
	FWjAiZMW5OvhxT0ujL2wZoh89B+ffogFb+moiVi1wmoCCQMAA=
X-Google-Smtp-Source: AGHT+IETlLUowZUjQZuLY9pXBowRMUmvCdKZEaOmjzgoOXxifurGXtBFF1Mwr+CZ6wm+w5hIyuFXXBmH4Y3Ahg==
X-Received: from qtbfg6.prod.google.com ([2002:a05:622a:5806:b0:4a4:34c8:f8bf])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:a40f:b0:4a7:d86:d32a with SMTP id d75a77b69052e-4a7807bcb9amr20098081cf.21.1750434404340;
 Fri, 20 Jun 2025 08:46:44 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:46:23 +0000
In-Reply-To: <20250620154623.331294-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025062025-unengaged-regroup-c3c7@gregkh> <20250620154623.331294-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620154623.331294-7-edumazet@google.com>
Subject: [PATCH 5.15.y 7/7] net_sched: sch_sfq: reject invalid perturb period
From: Eric Dumazet <edumazet@google.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Gerrard Tai <gerrard.tai@starlabs.sg>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

commit 7ca52541c05c832d32b112274f81a985101f9ba8 upstream.

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
Link: https://patch.msgid.link/20250611083501.1810459-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/sched/sch_sfq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 29e17809d1a70258ca268d450289c63a272fbee4..cd089c3b226a7a6fbd63479d2f16b6150f53c82b 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -653,6 +653,14 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -669,14 +677,12 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
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
2.50.0.rc2.701.gf1e915cc24-goog


