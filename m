Return-Path: <stable+bounces-274785-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yv0tLylNV2qWIwEAu9opvQ
	(envelope-from <stable+bounces-274785-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:04:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D57C275C34F
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:04:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tGax7jb5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274785-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274785-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77069301BA45
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECBF3ED113;
	Wed, 15 Jul 2026 09:04:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16DF3E6399
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 09:04:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106248; cv=none; b=ivG5V37lo3h4ph6ctj0Xeq0vyCyfNi9n3XvE+rKY98LLby6ZjOJH8q725oi8UgBqGdpSQeGbY3UKi/n8HgtAYIH5vAy9sZlLO8vVbHuMJVv5SBxFZylnrk7Ix/3L5K3gqzyUO09pJxnm0CFboiOc2vnVGZEGoPUeIQqg0RNAWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106248; c=relaxed/simple;
	bh=QtZuuTXeL7qNONG+T6jPjUHti24E2NJ208VyfSfoXUo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nFbCk+Bhn+x13P6AtoK3EKMkof2RIgFjpqQumJaWYCaQYUYVK7gdABmGH4ZhGZR2SPd2rbU+S4a77TsMCuBOKnpGfqiS13YhVpdhlHlvcnj8fxU+O/fJ8yvpF9jtLSzbg0prb4SRzYjnNPbpJhUlQ5gblewVgdStqkwO2GknNR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tGax7jb5; arc=none smtp.client-ip=209.85.128.73
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493e9ea2c77so42312995e9.0
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784106241; x=1784711041; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IDIP0De1XSMLmGN2HWgFiSuT2CRNSpjj0NqoKtySel0=;
        b=tGax7jb5W/EsfKztXgXjZYq+KuIrfZSgjvQw/Lq2AbPRdvB8Jpah3jM4NGdYV/WnBD
         D00jdWc5pT7QwROQsyC36PYV3e+qXYhSHnSa8jJGO/V+6akplHEeTssdPhGpgsn2JmUJ
         8WeHzyrSwRPzusYIrOn4kFk924Ha5oi+zTkgYg5SVm8AlVX30QRNWbwT9jCfdoopqewT
         GJi6TgRTpeN8mFDpwnnl+rKLOmrxpue/tQE5P6Ux4Gq1Ju2yqWCWDfRuWeE0D2xJdAqJ
         agWyTZyDDQDOjEyLk7G6Nu3hKWkLT3yucHyMlio1/FqkaGUIU808IcaOlTIiax9vafal
         PkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784106241; x=1784711041;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IDIP0De1XSMLmGN2HWgFiSuT2CRNSpjj0NqoKtySel0=;
        b=l0UqHtw8tarUfp+oqWJIiuKY7rQenjwajxWLMleyfnJhSB8UlhRVK2AqfIxgUK8039
         syctmjOXWqyGV98z3dlH0Kob6qcFLiXk2nnywyxDAGBwmIHelb6O+tbTAvo63dIXmzIK
         Utm1jQSB3T89qc6nmxvLely3U7KehSkvyS4/EmIkT3WCmRMCGTQKeICPGCYzyPiuTqu+
         F6UX6Uaa1l7ioVXGhbqga9jR4tPjQ4mg1niIdCIORjSwVaNoyvpV3vyhMOWPz/Omf6pE
         sVV2FQntyyoMooVy+UeJMBUNve9bIwH9h5mKuztoYqtFcSNP1Lw4knRZwheInTqmMK7D
         v+8A==
X-Forwarded-Encrypted: i=1; AHgh+RqqHCx0tumx6JjJylS6mMO2oN7sHBrWoYttdcp5fOuTg4W4u3UEF9QhYs/reeQ6NopHqJ8oK8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Y126XvliwvCuGoMM0wKhcWZiH2IbImUauUp+AveEdrpK4zPs
	kcwc9PH1TUT+oADXEpHy5ubuLbgt0w8Zx6QztHMO93cZccW92LHKBzbmLB/QzMymVvMg+h0Y6RC
	RniILP2tKUch0VQ==
X-Received: from wmbh17.prod.google.com ([2002:a05:600c:a111:b0:493:ad14:710b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1507:b0:493:9b02:484c with SMTP id 5b1f17b1804b1-4953c289549mr13387055e9.29.1784106241314;
 Wed, 15 Jul 2026 02:04:01 -0700 (PDT)
Date: Wed, 15 Jul 2026 09:03:57 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP1MV2oC/yWMSwqDQBAFryK9TsOMEX9XCS500monMiPTGgLi3
 W1186B4VG0gFJkE6mSDSD8WDl7BPhJwY+sHQn4rQ2rS3BQ2w3aagkMfdL/Y858E6WlyW5qs7Ko KVJwjXYd6r+ZmWbsPueUswb4fl4/FI3YAAAA=
X-Change-Id: 20260714-alloc-nolock-fixes-e30618048b99
X-Mailer: b4 0.15.2
Message-ID: <20260715-alloc-nolock-fixes-v1-0-fadc49952dda@google.com>
Subject: [PATCH 0/2] mm/page_alloc: fixes for free_pages_nolock() on RT/UP
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jackmanb@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hannes@cmpxchg.org,m:ziy@nvidia.com,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:ast@kernel.org,m:harry@kernel.org,m:shakeel.butt@linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jackmanb@google.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274785-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D57C275C34F

First patch was originally part of a different series but Andrew asked
for it to be separate:
https://lore.kernel.org/all/20260710170311.e22bfd21c658e8357ceddeec@linux-foundation.org/

Pre-existing bugs found by Sashiko during review of this other series:
https://lore.kernel.org/all/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com/

I have not reproduced these bugs, and I suspect there is no real-world
user that is affected by them.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Brendan Jackman (2):
      mm/page_alloc: don't spin_trylock() in NMI on UP
      mm/page_alloc: don't spin_trylock() when disallowed in free_one_page()

 mm/page_alloc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
---
base-commit: 83c85fdab41ef98198bdbd731cebc9a15a185dcc
change-id: 20260714-alloc-nolock-fixes-e30618048b99

Best regards,
--  
Brendan Jackman <jackmanb@google.com>


