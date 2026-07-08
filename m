Return-Path: <stable+bounces-272748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9v2qJKbNTmquUQIAu9opvQ
	(envelope-from <stable+bounces-272748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 00:22:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F407C72ADBD
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 00:22:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=e6L2RIgo;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272748-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272748-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE721300F14B
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 22:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E188A3FCB0B;
	Wed,  8 Jul 2026 22:22:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F653ED3CD
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 22:22:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783549340; cv=none; b=VJMVXQYisNNYA7mKMFdIFRiqzHuaRsq0F4OOYh90XmVB+v77+J9jVHL96Mc2FsM7Kvxiu+kz7IFlejid425mhuu8nmR+vHxi9llLQgvHv5X7BPjlov/jI2kzoYI9ALDlPPe8hr+T6AGWaIV4/BqUYoKFN38bpUobZAyMl6n2le8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783549340; c=relaxed/simple;
	bh=kB2vyd29/wFkOJxb5hRcwtTn9qeEKRW33ZRyUqco3QM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uIl4d6wjs7XYvKILbyY9K1cQuvNZM8DUbh8D9/1YzZvh7INRTJ6tutTFAzhgPF4PVIc9IoZzY1jj79WpN1ah9P5R0oMwZUO/4u0vjY5biwUgODmo7mCT8NMy5Kb3pY7SZN1ZHl/Omvhxcc0jS4Tl/gjaBmGadsHM8Mrr5Zh8LqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6L2RIgo; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2cceabd70f5so25820355ad.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783549339; x=1784154139; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YfstwW5fdgPHEqzlTVyIef12ZG3uZSmm4XPE4cEuyck=;
        b=e6L2RIgoTh8mnqCkHnP0+ZK71peQgkP8YNh/WlR+ATBMGq6DZ8o96A9K2C2aL0IlnA
         Z/T7Qf/3GkJHArJA0iSatCqK2d4oOrHfqItHodozNjkcfcUICLwcGPxbc6oDzW8CMp8O
         FNEoaSWBw00ePuwW9EGxvXmY3DVx2xnoPSYH9nE2w9hIKeafSVvE+zUaCPRxQkJBjTDI
         aqzY/k/auYgCxoTbbtbsXz4K2qhtqSiyruVlZ7I2LSZXAolfFDdi+6Od5as39CciPQfy
         Z85lym3TePLfE+Qj5oqmibLHLw1rdfSrqxqK87xS88J+4X4/7gbvMfA52O8JBKJliwzm
         Ny0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783549339; x=1784154139;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YfstwW5fdgPHEqzlTVyIef12ZG3uZSmm4XPE4cEuyck=;
        b=KsYPLyP2OD9xoJD2RLPBImrJqwRd61ChZh81/ppPt+hmz02BkJpmeMBXdX/El+kI7Z
         wowEVp6UV/X71l6GRdPTahgJCcJ/681PRBZxujV7EWfPmxzlEEJavApO0nZLK7ztq77i
         +OjSWjE5HIrZQ3EAjRv8MwhS1J3NTnirKAuL0zFrNqELtGU7qhN5P7IKb4MJjuhvGxBF
         7aJvTyPtDLdN+19ccHpRu5uk8tTQjnpLJBcZbh2y6wr0lLgUC8PesyjTwDRJF7xtilPt
         PIYD1ML0Wjy6mukVK+/LNSy9kyi2oMLQMwi0D8vek0fYA4jFzX+Da/w4Pz4gl25OZWDb
         QhjA==
X-Forwarded-Encrypted: i=1; AHgh+RrYqqOKf2MOV038Sg/mYoca3Q2WUFcXl5Vz+bFM2qn7QIlW+bTylCM2RqT5JJ1l+Nv/51fwrHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEq0webEI4r+Y2vF5fI+QEexssmEaPjLFiDLNako/dtMY7SMRY
	py9JW2Gw8DZbtBqsfbfbrDQAt+kkqYu5ZAt7c00QjkH4+z1evzYXpqqNXkE5vcLo3leliZD1asy
	yAPwy5sYeREsZbOaV4xk7UJGbIQ==
X-Received: from plbkm4.prod.google.com ([2002:a17:903:27c4:b0:2cc:e88e:4245])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2306:b0:2ca:ca48:c380 with SMTP id d9443c01a7336-2ccea3a7a6cmr42757595ad.47.1783549338708;
 Wed, 08 Jul 2026 15:22:18 -0700 (PDT)
Date: Wed,  8 Jul 2026 15:22:10 -0700
In-Reply-To: <20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708-hugetlb-alloc-failure-fixes-v2-0-c7f27cbb462b@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <cover.1783549129.git.ackerleytng@google.com>
Subject: [POC PATCH 0/3] Reproducers for hugetlb allocation failure issues
From: Ackerley Tng <ackerleytng@google.com>
To: devnull+ackerleytng.google.com@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, david@kernel.org, 
	erdemaktas@google.com, fvdl@google.com, joshua.hahnjy@gmail.com, 
	jthoughton@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mawupeng1@huawei.com, muchun.song@linux.dev, nphamcs@gmail.com, 
	osalvador@suse.de, peterx@redhat.com, rientjes@google.com, 
	shakeel.butt@linux.dev, stable@vger.kernel.org, vannapurve@google.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272748-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:devnull+ackerleytng.google.com@kernel.org,m:ackerleytng@google.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:erdemaktas@google.com,m:fvdl@google.com,m:joshua.hahnjy@gmail.com,m:jthoughton@google.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:mawupeng1@huawei.com,m:muchun.song@linux.dev,m:nphamcs@gmail.com,m:osalvador@suse.de,m:peterx@redhat.com,m:rientjes@google.com,m:shakeel.butt@linux.dev,m:stable@vger.kernel.org,m:vannapurve@google.com,m:devnull@kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ackerleytng@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,kernel.org,gmail.com,vger.kernel.org,kvack.org,huawei.com,linux.dev,suse.de,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,ackerleytng.google.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[subpool_shared_leak.sh:url,subpool_leak_max_size.sh:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F407C72ADBD

Please see separate patches for details!

Ackerley Tng (3):
  Reproducer for false restoration on shared HugeTLB mappings
  Reproducer for subpool usage leak
  Reproducer for allocation failure due to cgroup v2 memory limits

 cgroup_v2_allocation_failure.c | 160 +++++++++++++++++++++++++++++++++
 subpool_leak_max_size.sh       |  71 +++++++++++++++
 subpool_shared_leak.c          |  29 ++++++
 subpool_shared_leak.sh         |  86 ++++++++++++++++++
 4 files changed, 346 insertions(+)
 create mode 100644 cgroup_v2_allocation_failure.c
 create mode 100755 subpool_leak_max_size.sh
 create mode 100644 subpool_shared_leak.c
 create mode 100755 subpool_shared_leak.sh

--
2.55.0.795.g602f6c329a-goog

