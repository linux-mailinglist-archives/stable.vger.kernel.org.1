Return-Path: <stable+bounces-233254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KKvB+hs0Gkd7gYAu9opvQ
	(envelope-from <stable+bounces-233254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 03:44:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B77D399819
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 03:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09034303FAF1
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 01:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D5428CF5D;
	Sat,  4 Apr 2026 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXr3C9g2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D9328850D
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775267038; cv=none; b=fnWYTinq+k5/64MyVRicLj3lW9YD+duM0UmEyqDat1EFmP+8e60mLseEja2VroCiRSX34VsoBr3hAzAVWG2rzXhFQfLPosSHyXtShF1IVEYJza5g4gmpsrlUPk+lMTPfujIZo7d95PmNeW+EcDYHgJE22By4tRyTB0Wpzi/J5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775267038; c=relaxed/simple;
	bh=o+mXn+mO3TOBOhs6Vj4ImptTHtx9x7UXnCndYtnzSCE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=mHciysPF8Os9ARDNja8B1kJJPNsy6sEWnbXqKrsAxPRyUf+a/F+sUYHGPEf+pNiFlICWL1npPyO+xAIALFJjcOeUw06sItBM47BtncC4L/n2WZpIAbZGh7y3bqbxM3Y7dS98wI6UpETCyDedGTglE8DY6NHg8SqnfMslNkOYI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXr3C9g2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad9516a653so11335135ad.0
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 18:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775267037; x=1775871837; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mSmUlQx+7wcM8hvk6KgWAN6mYWx05Ua8pH5lZ6mYZjw=;
        b=nXr3C9g2rOFq3lOWtfJXdm1R3NpHTu0T5mbjoqhvOlZ9h18+ISrPrL4zOUB/n+NNrB
         SHEf23xnLEPX/yTwckXO60RlK5cx6bJLu4CLZpJ6GRhUnAxc/ARpRIN/ziZy4zLNrCEq
         PCptii73YhlofADub/f6Z7mOeowVBjS+LTCtxtGz3wN+g06GowochDaJUc8f5zh5mQOG
         fjydkerhn2of1EDtc9N2L+ThYnMV4qQxlC7UvyjzTDE7lwNh5Xis44qUOW9+i/MyDdRm
         IV+BXh6LNwwnHlFIGbXi8u0atoU76iTmq8pLH/Vd/9uhYE51qLVGibdJ41EWk3AlGhKv
         dFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775267037; x=1775871837;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mSmUlQx+7wcM8hvk6KgWAN6mYWx05Ua8pH5lZ6mYZjw=;
        b=UpDdYVxkTa1V7OhK2CLQ07AVgnE9rpZN8986kNlBDEoP2Zz4v+Bo3Xogez4VktrdzC
         wIXf3vjiMM9v+xQMg8yRAFGDJPGLwnbMUcj/K/RQla6B4fySTf6dnhKoqNMHM3txXWMX
         oA8OtU59b9F0wYiWOFoT6eDFXkxAjVEouo/Naqr1u7P4zI7C21DB4Hsyc+f+03vbD5rJ
         jDlQg2ircTtqZSKDcaYzjqckG77q6Xf48jZ76i1g9dXlP01SCCox33MOVwTq8TRw9N+v
         iKE7hgQFx3AbIQVNjYC5RNtEVx9hWMNZfCp2FYC7TVJzBAG86AjG+g7QCXHYzZhb6f07
         MGPw==
X-Forwarded-Encrypted: i=1; AJvYcCXnlV6Qhq8f0hhMiY7sUrPXH+P0uTpSJauJr/txYPpUjxs/ISQGwfGz4vmLKF5IzDUxQoa3jck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZCAtXFzzBse1FyGc25m1ztEkzHz6RdERiIRX0GqF4ABAcYXY4
	65tjls470wtvSU4uaPCkjHUstKbDuSz4NG3rwCczAMUrS7Tct7MC8lg5
X-Gm-Gg: AeBDievnrdaPlDvzTHAahsGPjcscNVboMFUgmIilVrEmV7O/XVLgadSNXoqWU326wfC
	BWbGasNSmzgSlmAbg41Lg39ROR6shJDdS5+z+e23xHhyk1KluP7MfatjAhk9TjwafCG77+GFOwa
	tzScuJXOS/CdA09ZknRoIF9Ewo/HCZfqoMn7cbr3UH23UqEvCuTPDD1i1AzbmfSaXzxbZrqKaaP
	a2E7X2yVxcdfGVm/B7iuiw5E549T7DKqJU+8b5kwo3RUBKwQCEU5kOYnfQ66o/4gD/MUtqu4Ccy
	o04X3PbO+AvZBgT6XsTjAgdmoYQhZwfXMPVdMfZpH5bMFrYIj9XYabhTEZMXm7Xzw3ddd5XDz7y
	nOxo4qAkQoeVFdasWTJ6It8Y0v3O2PLtOJPUmx7+rdBH3D0g5J3J19fnO7sEcgwZd1OgAD/fYEP
	5ZweAkZFeLeJFH7KAWp3hIzH0/kEObYM31
X-Received: by 2002:a17:903:1ae3:b0:2b0:afad:7aad with SMTP id d9443c01a7336-2b2818016c3mr52841215ad.45.1775267036795;
        Fri, 03 Apr 2026 18:43:56 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbca2sm65157255ad.73.2026.04.03.18.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 18:43:56 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Salvatore Dipietro <dipiets@amazon.it>, linux-kernel@vger.kernel.org
Cc: dipiets@amazon.it, alisaidi@amazon.com, blakgeof@amazon.com, abuehaze@amazon.de, dipietro.salvatore@gmail.com, willy@infradead.org, stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>, "Darrick J.
 Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order allocation
In-Reply-To: <20260403193535.9970-2-dipiets@amazon.it>
Date: Sat, 04 Apr 2026 06:43:06 +0530
Message-ID: <bjfzmst9.ritesh.list@gmail.com>
References: <20260403193535.9970-1-dipiets@amazon.it> <20260403193535.9970-2-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[amazon.it,amazon.com,amazon.de,gmail.com,infradead.org,vger.kernel.org,kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233254-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazon.it:email]
X-Rspamd-Queue-Id: 7B77D399819
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Let's cc: linux-mm too.

Salvatore Dipietro <dipiets@amazon.it> writes:

> Commit 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> introduced high-order folio allocations in the buffered write
> path. When memory is fragmented, each failed allocation triggers

Isn't it the right thing to do i.e. run compaction, when memory is
fragmented? 

> compaction and drain_all_pages() via __alloc_pages_slowpath(),
> causing a 0.75x throughput drop on pgbench (simple-update) with 
> 1024 clients on a 96-vCPU arm64 system.
>

I think removing the __GFP_DIRECT_RECLAIM flag unconditionally at the
caller may cause -ENOMEM. Note that it is the __filemap_get_folio()
which retries with smaller order allocations, so instead of changing the
callers, shouldn't this be fixed in __filemap_get_folio() instead?

Maybe in there too, we should keep the reclaim flag (if passed by
caller) at least for <= PAGE_ALLOC_COSTLY_ORDER + 1

Thoughts?

-ritesh

