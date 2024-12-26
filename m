Return-Path: <stable+bounces-106166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 130879FCDD2
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 22:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD501883352
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 21:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465D619007E;
	Thu, 26 Dec 2024 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khbiYrkO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CAC18A935
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735247806; cv=none; b=CivmsRqpiZAUxM+YsLBkAogAbtUNKkb+d9A7EW9krG7z3bYzejygRMkjH0HLzeHmRgImYjM22gDJ7uIfsQGTziQtv8TrGFNSVTv7hFkVm8tSrBYt2QezH9Xxz3OeSbLA2AOMU6KE7es2m28gRrKqjPOeeUTJtVp/j71apABKo9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735247806; c=relaxed/simple;
	bh=0Vz0NIwoGlPJliaqwoFyHwwhZ47+H56/giuVcAlhyf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SmJSCxR6/kVVtI57WxhCNKDgcmvkn6TRWp1gXKv3aMFD7NNm3+HUMgDHNWY7AMYMRr+hP4UD++SmRUZuXSoRDVe/5H8dOGkYtn5fNt1PHxLwauqQuUKCixRI8nBlD711i6YAgr3E+mkAPuSjck4I0Od23cbVftko4Qhk90Q0zag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khbiYrkO; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2166f9f52fbso135220515ad.2
        for <stable@vger.kernel.org>; Thu, 26 Dec 2024 13:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735247804; x=1735852604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pfuXd0GrahP2NIiXLpGEz1njL3PbfzffRJS1JIIbtb4=;
        b=khbiYrkOkNU1Np+lvgaZh/WbNo+r3w5FAyxSMcHc+5jzhbkFEMTEB4AnowB3EtzE7x
         AcaNJMmC40jWe6H01mVliRZ5o7006Huy2quHX59T3tRCj2jy+v0RD58cFWbMBOVGYS1S
         3WkqkPGzqk1+6y5uwI4Wu6Z6LYQGavgDyPiUiAycZXJoVEAZ118S01ZcvNLypR3Z3tV9
         045LIjDnP2aaxp+/a+QJqVAwzOhPc5/pzv8qgc8RL05j9kSgWEImHrnGdmgk6HU/RC6m
         9Dp4plL4oo7KRVuM0fNlniTSlowyzE5OXuPfn6rtgk+O2mUu6gttB3b+v8qvgDmLYOiL
         DSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735247804; x=1735852604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfuXd0GrahP2NIiXLpGEz1njL3PbfzffRJS1JIIbtb4=;
        b=M2UMdeUZAy5jg7NLxRY3u5AjETqQY1Wf3SphKuIAjgOwwyMw4Jm94qmk5k/w/UM+eB
         mjfTRzQzZMw0J0AsN1QD26pekyWCGfrLxzJwZiySD+QzDIZzJtSsHLOD8GydjOCv2eEl
         wLIzeqDTM2QxUVsbm0lBkgrJMt4nUCpihUM1hXXX3pWe6NnCbUWyS+y19z+izKRPe4OR
         JIKUc2r24Pc6IVO6fiDNhRIMFNKGXHQZgmqkWYtJ/w9wuBDmUuTsLj9qbFzxyhxid/Vz
         enSz/tuopgk2FRtNE3z/AGvXzbYoVZaZn/gQMuqHe7hhxQhHE9YQ4tjLWVcbHOu5XRfQ
         uW8g==
X-Forwarded-Encrypted: i=1; AJvYcCUTMUlB9634zbf48qLczPqK19RhWeHGe98G7AOtC0L3itLq2mBW87E52olIHWXHthfD8M1ah2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzk262IuOLqxhs/QgJHPBEJXXOuez/k0oLv9vON9vEzrT+sZ72
	kZ3wOq/uteZtttorRkJ1S99McFOfX8YtRBuP4RBWTzngclY8xEClCzD/Ya6fcyHRSrs0vYBiSjC
	PqQ==
X-Google-Smtp-Source: AGHT+IG8zt0lLXNRNgHLYZTdR0wBOYsPANFDIrRsTRrEqiRTBTz8an+nFbGCK3hSlS4zlLagTqqkdmVyqFw=
X-Received: from pgbcq3.prod.google.com ([2002:a05:6a02:4083:b0:7fd:50ab:dc45])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce0e:b0:216:3d72:1712
 with SMTP id d9443c01a7336-219e6f38292mr386695025ad.48.1735247804120; Thu, 26
 Dec 2024 13:16:44 -0800 (PST)
Date: Thu, 26 Dec 2024 13:16:39 -0800
In-Reply-To: <20241226211639.1357704-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241226211639.1357704-1-surenb@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241226211639.1357704-2-surenb@google.com>
Subject: [PATCH 2/2] alloc_tag: skip pgalloc_tag_swap if profiling is disabled
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, yuzhao@google.com, 00107082@163.com, 
	quic_zhenhuah@quicinc.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When memory allocation profiling is disabled, there is no need to swap
allocation tags during migration. Skip it to avoid unnecessary overhead.

Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org
---
 lib/alloc_tag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 4c373f444eb1..4e5d7af3eaa2 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -197,6 +197,9 @@ void pgalloc_tag_swap(struct folio *new, struct folio *old)
 	union codetag_ref ref_old, ref_new;
 	struct alloc_tag *tag_old, *tag_new;
 
+	if (!mem_alloc_profiling_enabled())
+		return;
+
 	tag_old = pgalloc_tag_get(&old->page);
 	if (!tag_old)
 		return;
-- 
2.47.1.613.gc27f4b7a9f-goog


