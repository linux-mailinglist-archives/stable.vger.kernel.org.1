Return-Path: <stable+bounces-230066-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEiPG3A/wmmCagQAu9opvQ
	(envelope-from <stable+bounces-230066-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:38:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1D0304115
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 08:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2484314A0EA
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB5D308F1D;
	Tue, 24 Mar 2026 07:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7MeUX3E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099FB32D441;
	Tue, 24 Mar 2026 07:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774337613; cv=none; b=er0EsgUmaimmKU9dJ6NcyyWD/zLANmNM/unLQTX9HnGCuFLcJ22y00SHNe9qzacDaMZpwqjl78N8NMiao1ok/Fw9SWNfZ+edu1zupASjjyJ8aCZD7r96Y4qdAX6vVFYvCdHCjq+WEktmWDZQLFxap2bt3cnnz+HzdA4NbI+wDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774337613; c=relaxed/simple;
	bh=WiAQ+4I4qCQUiHm0p1DT3+91TOXNEvDqdWg8BriPpVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ay4hPsOS2ifwkH1v62Hm+pYcbtriW24gkoc299ST5soCKnowlGMXaCPVheE7XBJze2mpDvZfe2OITt4I9doVZNpjvfm4ulEqhEr0NuIf1g11sJVCORFbWkkOFVfrR/LnMsmdFnPAHKXerRYJH9ROkjwMabKWxja42wFsz7i79Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7MeUX3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A8AC19424;
	Tue, 24 Mar 2026 07:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774337612;
	bh=WiAQ+4I4qCQUiHm0p1DT3+91TOXNEvDqdWg8BriPpVU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h7MeUX3E5ObxKZv/m6SMsQ6+Qn/Q+4droqSYSjtzmAjVRLZMHdkcC1Fmlqj6wdwRc
	 tWRh6IylSjCQCw8boOax0c+RR+4NNPjyfe3+/TQdEdV6vG3pM51qbkBaVG9Nbc7hFB
	 gbVUpdHEYNWaivvAhpsaWyaRH7XlNgeP0tg4MH9kiqITI99O0PDmQcPPwqpQ5wYNdf
	 MneSYJCmjPciXB/9rfk+wBCOU2cPRCsepDgmJGTfDBXLlIuj4T5xxtj6pvNcuHiI5I
	 VvMrzaFJipLsfN+ttu87HcVJc4felWR4T97eM5Q5KhxiltgiTW/Nod0tWormPCNo0h
	 0cpQSQNVeaRfw==
Message-ID: <47346263-ee56-4a78-b55d-7f28c617c673@kernel.org>
Date: Tue, 24 Mar 2026 08:33:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory: fix PMD/PUD checks in follow_pfnmap_start()
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 Alex Williamson <alex@shazbot.org>, Max Boone <mboone@akamai.com>,
 stable@vger.kernel.org
References: <20260323-follow_pfnmap_fix-v1-1-5b0ec10872b3@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <20260323-follow_pfnmap_fix-v1-1-5b0ec10872b3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230066-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE1D0304115
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 21:20, David Hildenbrand (Arm) wrote:
> follow_pfnmap_start() suffers from two problems:
> 
> (1) We are not re-fetching the pmd/pud after taking the PTL
> 
> Therefore, we are not properly stabilizing what the lock lock actually
> protects. If there is concurrent zapping, we would indicate to the
> caller that we found an entry, however, that entry might already have
> been invalidated, or contain a different PFN after taking the lock.
> 
> Properly use pmdp_get() / pudp_get() after taking the lock.
> 
> (2) pmd_leaf() / pud_leaf() are not well defined on non-present entries
> 
> pmd_leaf()/pud_leaf() could wrongly trigger on non-present entries.
> 
> There is no real guarantee that pmd_leaf()/pud_leaf() returns something
> reasonable on non-present entries. Most architectures indeed either
> perform a present check or make it work by smart use of flags.
> 
> However, for example loongarch checks the _PAGE_HUGE flag in pmd_leaf(),
> and always sets the _PAGE_HUGE flag in __swp_entry_to_pmd(). Whereby
> pmd_trans_huge() explicitly checks pmd_present(), pmd_leaf() does not
> do that.
> 
> Let's check pmd_present()/pud_present() before assuming "the is a
> present PMD leaf" when spotting pmd_leaf()/pud_leaf(), like other page
> table handling code that traverses user page tables does.
> 
> Given that non-present PMD entries are likely rare in VM_IO|VM_PFNMAP,
> (1) is likely more relevant than (2). It is questionable how often (1)
> would actually trigger, but let's CC stable to be sure.
> 
> This was found by code inspection.
> 
> Fixes: 6da8e9634bb7 ("mm: new follow_pfnmap API")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Should we also convert pgd_none() and p4d_none() checks to X_present() checks?

