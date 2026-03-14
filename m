Return-Path: <stable+bounces-225449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJjCCfHjtWkN6gAAu9opvQ
	(envelope-from <stable+bounces-225449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 23:40:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B999528F5C5
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 23:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 078C730055B8
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 22:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5DA37B00F;
	Sat, 14 Mar 2026 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iynWM0D4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D90D288C39;
	Sat, 14 Mar 2026 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773528044; cv=none; b=ch7REdsorb1KU5/P5qdZ+kIqistoYSaW1MKi4+KwL5nJtiGWL+GUhMntrlfZoBaFFVAIOMwzIsWllUMomDLZOdf01wbJ47x59BsxC/KuGJKMcFCFj9HuyrndEga6v32TUmt7pkp02B6YxPvNDjz1K8NkVLVX9OD+jOCXTODhcYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773528044; c=relaxed/simple;
	bh=sV9PTCvMW2uwYIYWoDT7NCvHOX9y6njZbgMbRie3eZw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fvtRv3IAq9FrNs1pgvajPrZSIvARkYaIwQHE4GgFhF8Bvmg3YV8GoruMvGczG+o00RWKpHahwavqCxVzyjbEsrH6JMam3eV5TQHjNAv9xRH/2HHwEsQQvTGWRj0lETABUp6NHvaTT3ANqwL2UnFepUGFJ1tXODqpZDqz2c5Szbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iynWM0D4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A489C116C6;
	Sat, 14 Mar 2026 22:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773528044;
	bh=sV9PTCvMW2uwYIYWoDT7NCvHOX9y6njZbgMbRie3eZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iynWM0D4SUypA8wlnsvN9Nb8wXTGYvUrZyHq3YXnX4a0GasUjitdrA6P4X/aXdVlJ
	 Uty182SdFlDkGEHq8oVt4FYAu0vfPMp+tZKOE9iUJCLbHXMD0JofkLOyoRWljN8aUH
	 HmTETDXB607mjyh8boIhMKHTnk5lUM6C/K5yNkVA=
Date: Sat, 14 Mar 2026 15:40:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: SeongJae Park <sj@kernel.org>, npache@redhat.com, david@kernel.org,
 ziy@nvidia.com, willy@infradead.org, linux-mm@kvack.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, hannes@cmpxchg.org,
 rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
 ying.huang@linux.alibaba.com, apopple@nvidia.com,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 richard.weiyang@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: migrate: requeue destination folio on deferred
 split queue
Message-Id: <20260314154042.327ba957b1a8c10f64ae0169@linux-foundation.org>
In-Reply-To: <b3805934-fb0c-4834-85ea-964ce006050e@linux.dev>
References: <20260312104723.1351321-1-usama.arif@linux.dev>
	<20260313001630.80081-1-sj@kernel.org>
	<20260312175241.01b876f3b325264f43312d79@linux-foundation.org>
	<b3805934-fb0c-4834-85ea-964ce006050e@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225449-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,nvidia.com,infradead.org,kvack.org,intel.com,gmail.com,cmpxchg.org,sk.com,gourry.net,linux.alibaba.com,vger.kernel.org,meta.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:mid,linux.dev:email,cmpxchg.org:email]
X-Rspamd-Queue-Id: B999528F5C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 13:40:29 +0300 Usama Arif <usama.arif@linux.dev> wrote:

> 
> 
> On 13/03/2026 03:52, Andrew Morton wrote:
> > On Thu, 12 Mar 2026 17:16:30 -0700 SeongJae Park <sj@kernel.org> wrote:
> > 
> >>> By the time migrate_folio_move() runs, partially mapped folios without a
> >>> pin have already been split by migrate_pages_batch().  So only two cases
> >>> remain on the deferred list at this point:
> >>>   1. Partially mapped folios with a pin (split failed).
> >>>   2. Fully mapped but potentially underused folios.
> >>> The recorded partially_mapped state is forwarded to deferred_split_folio()
> >>> so that the destination folio is correctly re-queued in both cases.
> >>>
> >>> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> >>> Fixes: dafff3f4c850 ("mm: split underused THPs")
> >>
> >> Seems the commit is merged in 6.12.  And I assume the user impact on
> >> THP-shrinker enabled systems is visible.  If so, should we Cc stable@ ?
> > 
> > I think the user impact should be visible to backport, but the
> > changelog is elusive on details?
> > 
> 
> 
> The original patches added THPs to deferred_list at fault/collapse, they
> got removed but not added back to the list after migration.
> This patch adds them to the deferred_list on migration. The user would
> not expect the THPs to get removed from deferred_list on migration, so
> this fixes user expectations.

Maybe users just won't notice?

If we can't identify any benefit to userspace then I don't think this
patch meets the criteria for backporting.

> I have CC-ed stable@vger.kernel.org to this email. Should I resend the patch
> with CC stable in commit message?

That's OK, I update changelogs.  A lot.

