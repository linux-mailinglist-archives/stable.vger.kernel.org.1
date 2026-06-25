Return-Path: <stable+bounces-268354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N3paJmAQPWokwggAu9opvQ
	(envelope-from <stable+bounces-268354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:26:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 190C06C5156
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:26:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Y6UyviYp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268354-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268354-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 672EF3017BB0
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2628C3CF02E;
	Thu, 25 Jun 2026 11:26:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC313D88F7
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 11:26:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782386781; cv=none; b=aZ7mWTGJzBh3/GKdR1T1KxDdP2HKW/LSzRsf+hIQP6GdDw3KPEXguq4pW9fBbLzL85t/xwkxhvN2V1PVnKR1FeuRMZumKmZ0tolG56e3rvdccwRYz1AKlYOT5A6Z4SJDsgH2n1eOk7RpwCTNO8PwDly3JpH5mapnpUG+0TNbFng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782386781; c=relaxed/simple;
	bh=Uc/Rm/8WbppIw3KMH18yWQrNEi8EgOmOYl4vwnXvZPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BzyTGY00FsTjeSUIGmzzU4kPiwzLpe7IdkyVPUpUhu+gDh5pB4TJVd7wZbZJLytNHWYEQC/JWIWuYF/UH/e5SZ/F2I5BhZjJpWodNg48tdSJ8pd4G8iCfG3+Yt+uyYyhAqHIDmylVkwYdqopWNXgjm4vFhDWjkJEYEBLRszZzZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y6UyviYp; arc=none smtp.client-ip=95.215.58.177
Message-ID: <b6c11065-8e4d-4d27-baf6-e94c1db51175@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782386767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8lDCA7qPRr9jNsO+3q9qYqPG2WVRS7I1dNqVMGwaE8=;
	b=Y6UyviYpeIDfCsWOPdJyWLxNNBjydnptTaNt2p5gWx23Z2RluaCf6poV/r+diWTABfr+I0
	HIH98jXon0jcczHx7fpTBUxLcBLzRXSWHMwF4VC1cTs2Pyb/R8J9B01RgCv1HGo/3YLJNC
	J3ycJAZ3UrXM9cEZ7Csv2aPEimTX3kQ=
Date: Thu, 25 Jun 2026 19:25:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private PMD
 handling
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, balbirs@nvidia.com
Cc: akpm@linux-foundation.org, ljs@kernel.org, riel@surriel.com,
 liam@infradead.org, vbabka@kernel.org, harry@kernel.org, jannh@google.com,
 ziy@nvidia.com, sj@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
 <20260624085756.6598-1-lance.yang@linux.dev>
 <20260625095728.woikmkxb6gskth3b@master>
 <2252683e-df5d-47ce-b15d-1036bef8d063@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <2252683e-df5d-47ce-b15d-1036bef8d063@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:richard.weiyang@gmail.com,m:balbirs@nvidia.com,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:ziy@nvidia.com,m:sj@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268354-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,nvidia.com];
	FORGED_SENDER(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 190C06C5156



On 2026/6/25 18:37, David Hildenbrand (Arm) wrote:
> 
>>> CPU0: pmde = pmdp_get_lockless();   // sees PMD migration entry
>>>
>>> CPU1: remove_migration_ptes(src, dst /* device-private */)
>>>         ... via rmap_walk(dst) ...
>>>         page_vma_mapped_walk(&pvmw /* src, PVMW_MIGRATION */)
>>>           returns with PTL held for the PMD migration entry
>>>         remove_migration_pmd(new = dst page)
>>>           installs a device-private PMD
>>>         next page_vma_mapped_walk()
>>>           drops PTL via not_found()
>>>
>>> CPU0: takes PTL
>>>       pmde = *pvmw->pmd;            // now device-private PMD
>>>
>>> So when PVMW_MIGRATION is not set, current code can return not_found()
>>> before we even decode the locked PMD as a device-private entry.
>>>
>>> Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
>>> device-private entries") made the
>>>
>>> device-private PMD <-> PMD migration
>>>
>>> transition possible.
> 
> Doesn't the folio lock help here already?

Ah, yeah, I was too focused on the PTL and missed the folio lock ...
Don't have a caller like that :) Went over the fix again, nothing
else jumped out.



