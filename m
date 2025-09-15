Return-Path: <stable+bounces-179651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D65B585B8
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 22:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E5A18888DD
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 20:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFBC28FA91;
	Mon, 15 Sep 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i2sSuvkv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208BC28CF7C
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757966968; cv=none; b=kXZZp9OWdWXD+rT94+FrE08gsUIGdCjZINuTEJgVFQHhc9IjGqPTePxj36zjYuF+HfkHXWV+ODbaR9flpLRC1rczpthFyX+XC6Fap5AJk4XNollBs7HICZZkkD8dcF4AAppKcCVmyX6m1/B6iFurK7n3L5nyOvHVPSY/mYskQ/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757966968; c=relaxed/simple;
	bh=77t96hOaTl3mMLmTlusEoP+rCh6LcSN9TjqYu/CWHEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u6sF/BxTSkjpbG33I/cNw3Z3JhXsD4VqknECwq94TOc+GBsm+ny10jpnkErNJwG1Y7xtGQcU9uEw/K3SNKcPhVg0QsPz+otgP+79Eaq4e4HE4bcRW4up0KGHUlrJuXgarBNjSiUBArULFl0zNdRCbZSf9NkBvDsNPVRRFIgYsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i2sSuvkv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e09eaf85dso2718237a91.1
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 13:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757966966; x=1758571766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1irnAaC7Dgk7HdImUgdg3erV0zSH2B8o0J/F+rFZfQ=;
        b=i2sSuvkv99ir/sx98CDiGAjB0qVQy9XIOi79I7pOeAnPY4nxz5f10neTL/ZW9kvwpz
         7Ja/hsdVUDuCOp06BL+D+XyEzlcx0hmUpO+a8abRmzFyEvWTF/o3y1H0gZSr5YWmrVBd
         MiW9BxkHLcRNK9VQLwGyr7hFFroQ3MOk7ESxUFqL6rqCrILJD1CHErP8NkDVnZFgxiS2
         X9co992y+d/PRHb0CoqbcACBT5nb50FP2Z9ImkBAQt2bkjEvHPwhHO+tBF3hOU05Dd+q
         5GxB8ih73LD0Irk6Fa6UoeyHGwbRA8De+YsMkqmRweJgoEQ6+RJ+qgXPOSlOmL2N5ba0
         AVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757966966; x=1758571766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1irnAaC7Dgk7HdImUgdg3erV0zSH2B8o0J/F+rFZfQ=;
        b=cHm4/2gbyGQEJGr2TaXWJqHPdbN0my78lTQGoHlLxxwiCCcYrMWjeTCMTWM3AM4MzF
         c3ScvPEOCOaB8OJxauY1iO6fCi/Io5rkGjCc47XpXbOWQ2nislfcCTpdkR7KznrVZVbX
         33CPfCuptB09fKWZr9HSEjq7wzCRdEIa5klGyk9rNM3i/1iY1KRi1E20BLRb/2/Gu1u4
         /yEjNWyHJdXwQ4VPSlF1CWamtYAIZlRExjEU7xkxS72uY0fCtCwd7rlWdo+pPXZD1SW0
         xPYam1BTifr9RF4H8RXdGoi9ha+6nSPer8kjFwE/8m9n7G+sALtlBo8672yt3L/bYtVw
         vREA==
X-Forwarded-Encrypted: i=1; AJvYcCVmL3XrxouEeOMSpKaRvKPmu/PCncBcOKcScqtGii3TUYwvAISaxssOUr8GwJyssJti/ALInpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYjsbpJ5vaby/ATVJNPXrBjQshzjkD3o4VVolstmCgs54CfkQ6
	ySOfwkCfUhzrdjgvlsifxOwwztNMfLmY99vyziTRMSa3YWQ4azhHX1M3zGWC5EL9JZ5jGSFkvrV
	VXCU8bA==
X-Google-Smtp-Source: AGHT+IGvKewiOGnHoWDqmlqcJxcDGi3xUQdfSPuLW445AIGj+JDuHNOrwmjURPZbSnfYa96dSkMxZkvKBCg=
X-Received: from pjbee16.prod.google.com ([2002:a17:90a:fc50:b0:321:c441:a0a])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5743:b0:32d:601d:f718
 with SMTP id 98e67ed59e1d1-32de4facb32mr15187043a91.31.1757966966323; Mon, 15
 Sep 2025 13:09:26 -0700 (PDT)
Date: Mon, 15 Sep 2025 13:09:18 -0700
In-Reply-To: <20250915200918.3855580-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915200918.3855580-1-surenb@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915200918.3855580-3-surenb@google.com>
Subject: [PATCH 2/2] slab: mark slab->obj_exts allocation failures unconditionally
From: Suren Baghdasaryan <surenb@google.com>
To: vbabka@suse.cz
Cc: akpm@linux-foundation.org, cl@gentwo.org, rientjes@google.com, 
	roman.gushchin@linux.dev, harry.yoo@oracle.com, shakeel.butt@linux.dev, 
	alexei.starovoitov@gmail.com, usamaarif642@gmail.com, 00107082@163.com, 
	souravpanda@google.com, kent.overstreet@linux.dev, surenb@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

alloc_slab_obj_exts() should mark failed obj_exts vector allocations
independent on whether the vector is being allocated for a new or an
existing slab. Current implementation skips doing this for existing
slabs. Fix this by marking failed allocations unconditionally.

Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to mark failed slab_ext allocations")
Reported-by: Shakeel Butt <shakeel.butt@linux.dev>
Closes: https://lore.kernel.org/all/avhakjldsgczmq356gkwmvfilyvf7o6temvcmtt5lqd4fhp5rk@47gp2ropyixg/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org # v6.10+
---
 mm/slub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index af343ca570b5..cab4e7822393 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2029,8 +2029,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 			   slab_nid(slab));
 	if (!vec) {
 		/* Mark vectors which failed to allocate */
-		if (new_slab)
-			mark_failed_objexts_alloc(slab);
+		mark_failed_objexts_alloc(slab);
 
 		return -ENOMEM;
 	}
-- 
2.51.0.384.g4c02a37b29-goog


