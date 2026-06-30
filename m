Return-Path: <stable+bounces-269988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cuBSCBjXQ2rFjwoAu9opvQ
	(envelope-from <stable+bounces-269988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 16:47:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A45CF6E58E8
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 16:47:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=FmJRX50X;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269988-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269988-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F723303AD8B
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 14:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254784192F1;
	Tue, 30 Jun 2026 14:47:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A340410D09
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 14:47:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830867; cv=none; b=S/biMiigZvkqs50va7xTjYW06ua8v6wJEQwDRWdTV8A/vngYRTGLEEiA5R3+LhG/1oPYiblyRhVkPIU5w2wdoCnmYlS42mMZvd4BSvKZUNxy7V3JAAmOjAbDvbJrUjtm+jATNcYCI7TOmCaLgCHKx+gcQR+6X8SAs9eM85RjgcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830867; c=relaxed/simple;
	bh=I/zLi514bfgMzHbULipHGX78klpg+H8YN/GCoHJja18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6u5UZ4QdRaS0Y2z/97VyaWW/3QL9qWVtelH5gkfyCtaM92vbbSAzus3Nz1o7AVHbR2tGuOlaVGizGu5pCnO7HoekicoDml4mEciD1UOmXbgTvEsts3ADjuO38JtHfquAcpE4Uvi7rXAokd5/9gq4CuomvpHsZAYmqjFfciX8N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FmJRX50X; arc=none smtp.client-ip=95.215.58.180
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782830854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ec4y5CC9osX1Fg3YZN+Ow/rvBlJD1nIcT1j8LM/GIAs=;
	b=FmJRX50XWFqK5QpU/Lvd2417iY8koi8gFcrrlCJZ0ywgG9BIYPSxM1kBham4gcZRtHT+3C
	HssL7y8kdeHl0btKk6Tdd1envqSoEJNhkTWliRUtxC/hZY0yn+CRBrH+UO+Tjmy9mlxfPr
	bBh65Em9nvNfgtDhFGZPfLqWE4cVp4w=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: vbabka@kernel.org,
	ziy@nvidia.com,
	akpm@linux-foundation.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ljs@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	yuzhao@google.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] mm/page_alloc: free allocated PFNs if the range does not match
Date: Tue, 30 Jun 2026 22:47:14 +0800
Message-Id: <20260630144714.66550-1-lance.yang@linux.dev>
In-Reply-To: <d44ae8a5-ec70-456b-92a0-ce7ccabf6917@kernel.org>
References: <d44ae8a5-ec70-456b-92a0-ce7ccabf6917@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:vbabka@kernel.org,m:ziy@nvidia.com,m:akpm@linux-foundation.org,m:surenb@google.com,m:mhocko@suse.com,m:jackmanb@google.com,m:hannes@cmpxchg.org,m:ljs@kernel.org,m:liam@infradead.org,m:rppt@kernel.org,m:yuzhao@google.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:lance.yang@linux.dev,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269988-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sashiko.dev:url,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A45CF6E58E8


On Tue, Jun 30, 2026 at 03:39:56PM +0200, David Hildenbrand (Arm) wrote:
>On 6/30/26 09:44, Vlastimil Babka (SUSE) wrote:
>> On 6/30/26 03:35, Zi Yan wrote:
>>> When using __GFP_COMP in alloc_contig_frozen_range(), if the allocated
>>> range does not match the requested one, the code errors out with EINVAL
>>> without freeing the allocated PFNs and causes free page leaks. Fix it by
>>> calling release_free_list() in the error path.
>>>
>>> The issue is reported by Sashiko[1].
>> 
>> So this?
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> 
>>> Fixes: e98337d11bbd ("mm/contig_alloc: support __GFP_COMP")
>>> Link: https://sashiko.dev/#/patchset/20260628-keep-subpage-private-zero-at-free-v1-0-f4ce3930d10f@nvidia.com [1]
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> Cc: stable@vger.kernel.org
>> 
>> Hm well, it's a path that warns, can only happen due to a development error?
>> Not sure we care about stable then. Anyway.
>> 
>
>If someone would run into the WARN we would already be in Fixes: territory.
>
>it's a path that should never be executed. If it does, the real issue must be fixed.
>
>So (a) I don't think this is stable material (b) I am skeptical that this is
>even a Fixes and (c) I am wondering whether we should touch this *at all*.

FWIW, this patch looks fine defensively, but probably not a stable
material unless we know a real caller can hit it :)

Cheers, Lance

