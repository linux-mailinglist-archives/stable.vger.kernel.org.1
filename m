Return-Path: <stable+bounces-225274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJXTH/Xps2l6dAAAu9opvQ
	(envelope-from <stable+bounces-225274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 11:41:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4100B281A15
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 11:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 714373035E22
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 10:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C0B36CE19;
	Fri, 13 Mar 2026 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jORxnQ/C"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA322F83A0
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398439; cv=none; b=ZX/ZRx9ZO6VH9Tk46D7Mv1iaRQoheO1RIdkVuVPqUX3MV1TkwmupyvlgACT9nX4N7DSK5X2tz8q4Jq9mqBojet0FERsXHuQjliHcwsslR5RwB57yf2ISj2jHIerCVAKj03lF3XD35cjekM5vTj3uF5C7I9Eyrj5KfHQ5Z98X/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398439; c=relaxed/simple;
	bh=dIlaKi4NWjNsJGDT++udD7TlSA304Lh7dGgoYE6KiXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OT8z3OwC+y+TpUYu05IW/5UZtvrW9cRu4aMyPPgILNAFiYAH7mwY4twqYDIh/ktB9+WgEZLGhe8KU2ZAVltgmb5hXM/N+YUxbmus5YNKqZz6XBeqSMBv26ic3S76UUpMkxj+N070xDPFXgrs1haVyY9NzCdUZp1iRM6BGG0F8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jORxnQ/C; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b3805934-fb0c-4834-85ea-964ce006050e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773398435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bRz0a5rDf3B7IZQUMIebticNEhlGjLTFEMcGXq89IU=;
	b=jORxnQ/CClGmZiyZq5YW/ui3uCz8vIxhsfkcXEcQkLuaZqufBN9zXYt+nV5DXaBTlThPnN
	O6vuRlNHol4OE/ixrrJ0fAFgtvrTmXUcL5JngaiSvjRnCV7XdPLs2LbV6iMu7vNhpvYawx
	fqBAxtD6NBt934ZI4NcyFvqw7yG7gRU=
Date: Fri, 13 Mar 2026 13:40:29 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm: migrate: requeue destination folio on deferred
 split queue
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>, SeongJae Park <sj@kernel.org>
Cc: npache@redhat.com, david@kernel.org, ziy@nvidia.com, willy@infradead.org,
 linux-mm@kvack.org, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
 hannes@cmpxchg.org, rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 richard.weiyang@gmail.com, stable@vger.kernel.org
References: <20260312104723.1351321-1-usama.arif@linux.dev>
 <20260313001630.80081-1-sj@kernel.org>
 <20260312175241.01b876f3b325264f43312d79@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260312175241.01b876f3b325264f43312d79@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225274-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,nvidia.com,infradead.org,kvack.org,intel.com,gmail.com,cmpxchg.org,sk.com,gourry.net,linux.alibaba.com,vger.kernel.org,meta.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,cmpxchg.org:email]
X-Rspamd-Queue-Id: 4100B281A15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 13/03/2026 03:52, Andrew Morton wrote:
> On Thu, 12 Mar 2026 17:16:30 -0700 SeongJae Park <sj@kernel.org> wrote:
> 
>>> By the time migrate_folio_move() runs, partially mapped folios without a
>>> pin have already been split by migrate_pages_batch().  So only two cases
>>> remain on the deferred list at this point:
>>>   1. Partially mapped folios with a pin (split failed).
>>>   2. Fully mapped but potentially underused folios.
>>> The recorded partially_mapped state is forwarded to deferred_split_folio()
>>> so that the destination folio is correctly re-queued in both cases.
>>>
>>> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
>>> Fixes: dafff3f4c850 ("mm: split underused THPs")
>>
>> Seems the commit is merged in 6.12.  And I assume the user impact on
>> THP-shrinker enabled systems is visible.  If so, should we Cc stable@ ?
> 
> I think the user impact should be visible to backport, but the
> changelog is elusive on details?
> 


The original patches added THPs to deferred_list at fault/collapse, they
got removed but not added back to the list after migration.
This patch adds them to the deferred_list on migration. The user would
not expect the THPs to get removed from deferred_list on migration, so
this fixes user expectations.

I have CC-ed stable@vger.kernel.org to this email. Should I resend the patch
with CC stable in commit message?


