Return-Path: <stable+bounces-273188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OnEiDbbMUGr85AIAu9opvQ
	(envelope-from <stable+bounces-273188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 12:43:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDD5739CCF
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 12:43:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=kZOIdi3K;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273188-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273188-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC2C330215A8
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 10:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE44C40C5C9;
	Fri, 10 Jul 2026 10:42:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515C40BCC3
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 10:42:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680163; cv=none; b=L898smFvnfnn4g/0o4SU0RR7bOAjjXEdwC5mUhTkV34xN/VqGFRlVXZ4RyuBFnsqP4dtMl9ICVqf9e27pZ1wHMY8VpHqlhPADjGsN96CC4UQ9ikcHKdIXISVuHKqnCTifxuk2iyW2PgEjlcoPDCF/LMITnI6g2a0Mru7ZLhYpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680163; c=relaxed/simple;
	bh=UvP4r/8ewMUaNP1Qd8YFWvOIYOukjYVtZmQg7stOH5k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qJ6Bq9A4BWA+rF3/OXQbsCZj4pucBf0nkMmezCsn5VsMxl8+hdDjnvBffdJuLxejXN5o9OPNGCxZZd+lyld6buAQ1Zu2mBaSE4vv8/9YJGwoRnR4b+TpFamU0eBIsrop3iMsPxEZsMZ5Gcp8DKIxW7w7EbAc0du7LmeAa2An84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZOIdi3K; arc=none smtp.client-ip=209.85.221.73
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-474170b59dfso430624f8f.3
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 03:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783680160; x=1784284960; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XVV0CZtE+jAiIp2jucN5t1l22tPDkrJA7DCQqcEcxvk=;
        b=kZOIdi3KXb3aoAVzQvLKUsN/9X0efRxK1ON7dA2Cz3NG+TeEsrvEUISPT8upgsYVYf
         Renbijt8S68VZeHqEcvz9IsGSUGokzGFpvj6o0kR0mvzlfIk7sLmnAgbhxNui8X68n8c
         e2f1YGouJyOE2dSoDxeWIOt+PxstzS4d9oa0qflK2EToH1vxGA9CK+mnk5rTqjbSXwJl
         pwM/AsHyEa99Flunqq3Xd+xlHt0FdIb0QxvkJRMpLHXme/2/ARW/viD1Meh27yr4Uqo3
         9fiEIODonELxO/t6V8lcnKirJ/FJM6bKwuPmqUWPSYvGOjibpM4BL6qaD/CeV4lp64Ly
         AIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783680160; x=1784284960;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XVV0CZtE+jAiIp2jucN5t1l22tPDkrJA7DCQqcEcxvk=;
        b=B6bbPzJfz6Wg9Dd+fEy69umWJuKvmwJs8/SvqKUJ7lGynID/Csi8P2kVt75eD79yYN
         dTrEoplTZg3sgOyBG8cGD9zrYjwpZ9vCvd6ZEs+KFCMmy2hrkYm1TUftlTSj2Y9MRccY
         qpFF05wSPsQBww8HZKMW2DLZWqm5+ZQ/ICrcCYqHm4pA/44iJnsQLjyldeDnzR0uD4wq
         u4OaVshLNn581kkAjE1qy0MhPS+mSKpxj9l6sgGRa2dnrLie2tN2SA07U31yrkFrmLzr
         bsg+n9gbBU3hhk1nxSTlXkCkNZFf7YSBezMlUttd5g/5316o9dJPh0o0a5UeXN23A/sJ
         c9KA==
X-Forwarded-Encrypted: i=1; AHgh+Rrgqy13EAxXLj9vaho3d+GQT+gMOc1+Tw+EehPovszECESUZMFVHOS23SrR157g9PunUvSuHN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7rRJVymQEvWz3ui4rFbuu0AMbKlI7Ibc3f93CMLANdjLP5+D
	UBlS4xPhDG0fSMU24iETBAmDm9rAF1p7rk/vua3jLftevnQYIzODtP6YWslZkX0oeFAWdzT6LEk
	o4X4EkgYTGyux8A==
X-Received: from wrse13.prod.google.com ([2002:adf:fc4d:0:b0:476:4ac9:27db])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6217:b0:493:e9c2:ba60 with SMTP id 5b1f17b1804b1-493ec7a7a26mr63789625e9.22.1783680159801;
 Fri, 10 Jul 2026 03:42:39 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:42:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIvMUGoC/yXMTQ6CMBBA4auQWTtJaZMSvIpxIWXQ0aZtOvyGc
 HerLL/FezsIZSaBa7VDppmFYyioLxW41yM8CbkvBq20VU2tUBIHHPPmo/vgEL2Py5TQGO2ssaT 6toXSpkwDr//v7X5apu5NbvzN4Di+0UfLwnkAAAA=
X-Change-Id: 20260710-spin-trylock-followup-332c636e0d99
X-Mailer: b4 0.15.2
Message-ID: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
Subject: [PATCH 0/2] mm/page_alloc: couple of followups for recent cleanups
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Harry Yoo <harry@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	sashiko-bot@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:shakeel.butt@linux.dev,m:harry@kernel.org,m:ast@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:jackmanb@google.com,m:sashiko-bot@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jackmanb@google.com,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-273188-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BDD5739CCF

These patches are technically orthogonal to each other I'm just sending
them as a series to avoid someone needing to deal with the (trivial)
conflicts.

Based on mm-new, depends on
https://lore.kernel.org/all/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com/

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (2):
      mm/page_alloc: don't spin_trylock() in NMI on UP
      mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK

 mm/page_alloc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)
---
base-commit: 9d6a99520ac667ab6c1dbed364169b68d38f1a5c
change-id: 20260710-spin-trylock-followup-332c636e0d99

Best regards,
--  
Brendan Jackman <jackmanb@google.com>


