Return-Path: <stable+bounces-155162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 423C5AE1F64
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB52189BD61
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AC92DF3F2;
	Fri, 20 Jun 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xjoHspjx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11562D4B6F
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434399; cv=none; b=IxCDk64xSOcPpJp5QZwcpshibXds7hgpzTPYAwWDDhcqn4jVRBaErULgUxLJeagEUd7XF11Eb1t67fQiRa5Pxlt8R2Anhi5HUNwR2zVDBvNGZaAJaL1MegfkQRJEZQqlD2UC/bSIb7+uuDQ+8X3H/Bp31j+61m3It1uSNr9TDAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434399; c=relaxed/simple;
	bh=ZY2IXHXPtTCe5OEItyXLujHmIHOIO7faU9qVDllJdjo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K/5ifLCvwqrVSpZa1ipjr3ZSLVyEgRFRtN6lee4XgKLD1r9vNrkSOWMvfCzziNh1Zp3kNk3OY2+KGZbsTBjdvY4MFFK/CqtbpVg9IJhE/f71tW3YxySHWNQubd/v1+6afYPcG3LzafnnZlovzsDQ1eTQp14dHZxcs5LxmrejFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xjoHspjx; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a57fea76beso39153761cf.0
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750434395; x=1751039195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bRUn8WBzwJBMklo3ymZFURpoQavq4fPmFT3/rj0REg4=;
        b=xjoHspjxZwv7UF48ARdQjQAj8Bj3fzKDRkGctUQA3dek8iTmzNx11wimQP9qXP9r17
         nUbE295cNfDCMYdRQiZPP9HFvGqE6LkDOAmaiFVIHbseZqQL1BwZOzZNed35F+7NV8Uo
         7lb9l80GTMZxT8XITLEWnMwDrQFpT7JrKaqdSd8B08F3D2y/Gab+kRvzHJI6gIbB34F0
         +dVatJ0cmwh48EjwGUUtKF8Pg1Beo/vlNdSNhEyrikI3tXCFVCfjKjQ+kV4+NvV7y0J6
         2WeKtYBkRyUv2rQvjwXq8CcMuo1dHW6at7nZlAKiAxE+kZo0jrJfIytcM2T+OlnJlKUB
         nytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434395; x=1751039195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRUn8WBzwJBMklo3ymZFURpoQavq4fPmFT3/rj0REg4=;
        b=s++nZjlZSTa8Jx9S4SZaGMS0Yo+jNtXg8p9u/eSHNbBOmnkpQI+J0qLMxAkp1qhtY5
         uDSnpLzT7YHDopSx6/EcNl81Gkw8PPSdaH/IL8Giia5XyzIL6UtiWxLHM/3TRYaxhG3Z
         z1694YePIfhbnfda/sxLOFhLDFCzsK0fUTuQOKHZKYUU7PA2KZ2gZcDn/x1nB0Zp4K+j
         fD1wRwDJldJXC8qKM7jmN1djOAWrM/01bgK/3hLXJiHbVJ2PjO+yAwWgG9E3q6PTJfMR
         DHRIdSQ8nKlEbP/2f0+Kv8IMWH7u2tah16DH1ehyV12cDYjgBh9R9er4NzD0n2HGDLNM
         xmqg==
X-Gm-Message-State: AOJu0YyuWHf2fT7VuxeINvczuhCeRKEMWoAvXuowQijnc09uA4kfiAJj
	YnJmcChmXLLTZzlhnUEwlJMzBJPvcZwQk5KkHsihsN5KjXaN3UFmA8uND/0VvAusy3HMu+quwV4
	lYPYhbKHgwbXU4T2truUwRu383N9Bedil1JLUwvXskAYX0l4QawuzsnYvpM3yqfVk1kkgnZYy3i
	ieDb/CMvaogOIxdoJvArSJlKQWQeO8etFbsfwnEAuT5DlqVrE=
X-Google-Smtp-Source: AGHT+IH3vFyDKwsSqix2Gn+nT/Idwl2bLQGrl6DQbA4pZOPesw6/Y4YOtt/9J20cpe+GoKF/kZJtICexfXTjVA==
X-Received: from qtbfy22.prod.google.com ([2002:a05:622a:5a16:b0:4a4:379a:b887])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:7692:b0:4a7:8106:6cbb with SMTP id d75a77b69052e-4a781069c57mr11971211cf.17.1750434395464;
 Fri, 20 Jun 2025 08:46:35 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:46:17 +0000
In-Reply-To: <2025062025-unengaged-regroup-c3c7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025062025-unengaged-regroup-c3c7@gregkh>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620154623.331294-1-edumazet@google.com>
Subject: [PATCH 5.15.y 1/7] net_sched: sch_sfq: annotate data-races around q->perturb_period
From: Eric Dumazet <edumazet@google.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

commit a17ef9e6c2c1cf0fc6cd6ca6a9ce525c67d1da7f upstream.

sfq_perturbation() reads q->perturb_period locklessly.
Add annotations to fix potential issues.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240430180015.3111398-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/sched/sch_sfq.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index f8e569f79f1367563bf92793dbd2a9c0a4ce957b..d6299eb12a8164bcaa0594d3ac2829531bfac588 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -608,6 +608,7 @@ static void sfq_perturbation(struct timer_list *t)
 	struct Qdisc *sch = q->sch;
 	spinlock_t *root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	siphash_key_t nkey;
+	int period;
 
 	get_random_bytes(&nkey, sizeof(nkey));
 	spin_lock(root_lock);
@@ -616,8 +617,12 @@ static void sfq_perturbation(struct timer_list *t)
 		sfq_rehash(sch);
 	spin_unlock(root_lock);
 
-	if (q->perturb_period)
-		mod_timer(&q->perturb_timer, jiffies + q->perturb_period);
+	/* q->perturb_period can change under us from
+	 * sfq_change() and sfq_destroy().
+	 */
+	period = READ_ONCE(q->perturb_period);
+	if (period)
+		mod_timer(&q->perturb_timer, jiffies + period);
 }
 
 static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
@@ -659,7 +664,7 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt)
 		q->quantum = ctl->quantum;
 		q->scaled_quantum = SFQ_ALLOT_SIZE(q->quantum);
 	}
-	q->perturb_period = ctl->perturb_period * HZ;
+	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
 	if (ctl->flows)
 		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
@@ -721,7 +726,7 @@ static void sfq_destroy(struct Qdisc *sch)
 	struct sfq_sched_data *q = qdisc_priv(sch);
 
 	tcf_block_put(q->block);
-	q->perturb_period = 0;
+	WRITE_ONCE(q->perturb_period, 0);
 	del_timer_sync(&q->perturb_timer);
 	sfq_free(q->ht);
 	sfq_free(q->slots);
-- 
2.50.0.rc2.701.gf1e915cc24-goog


