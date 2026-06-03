Return-Path: <stable+bounces-260020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7DPKBfr5H2oNtgAAu9opvQ
	(envelope-from <stable+bounces-260020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:55:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ED6636583
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 11:55:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=YfPoiDZK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260020-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260020-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8B3130A7D68
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 09:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A94441029;
	Wed,  3 Jun 2026 09:52:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241A37104D
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 09:52:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480361; cv=none; b=GJ0BsrSYgmaPAcyAj7coK+3psyUVHinqvpa+X25E1UNm8lHpkhi3mVNtzCMy3li2cvNfZBGRDXyZUcVR5M2JfZSGD3WmZtYJ4MObSgQaOwNxvlXYnDK5//94zqLaQruALrhJkdqsSCHWJTEXAp2H4iLDw8mWUu7BNr3vKLW8sP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480361; c=relaxed/simple;
	bh=YY53cw2KFoXP90UlUZOe1zK95d0DwsY3YnKMfN7jpPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghBHCAs1BYKbEBXw9VDIcHdzRwWD5/e4tAUeUn09R2NiEZuV522KYSfdJJFecqbrtk19A6NdpRlZ04gphohKOY0v2opxRSQEOlGG5QDa+IEsZc4cOrzkzENf/d4Dr082HEbL+R8y4Igpz7JVHiz9NoGaMyHrPvadna7xc/QsVp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YfPoiDZK; arc=none smtp.client-ip=95.215.58.187
Message-ID: <bcf95603-a04b-489e-8edf-b6bc4a42192c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780480358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9y161r+C4QaUQPCPFY8+/eWlsInhIknGyIgcTTS+Zk=;
	b=YfPoiDZKbBT/Gq1znLBKg7M/pnDycgPCLsUnM5pAO6QSkWDgpjnE7JiGWJ53PHqcdOxqMg
	0qVAErTuGUhQr6r9xL+flbasJvM6idM4nP8luELXc01opatOy4V0+ugM4O3laFOVhqmCwH
	53iUQ2lbj07rnJO5W0YktFF9XUCDvWE=
Date: Wed, 3 Jun 2026 10:52:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/mincore: handle non-swap entries before !CONFIG_SWAP
 guard
To: Pedro Falcato <pfalcato@suse.de>, stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, jannh@google.com,
 liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ljs@kernel.org, vbabka@kernel.org, chrisl@kernel.org, kasong@tencent.com,
 baoquan.he@linux.dev, youngjun.park@lge.com, hannes@cmpxchg.org,
 riel@surriel.com, shakeel.butt@linux.dev, kas@kernel.org,
 kernel-team@meta.com, stable@vger.kernel.org
References: <20260602172247.279421-1-usama.arif@linux.dev>
 <ah8XqXQycZdbYFG9@pedro-suse.lan>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <ah8XqXQycZdbYFG9@pedro-suse.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:jannh@google.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:vbabka@kernel.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:baoquan.he@linux.dev,m:youngjun.park@lge.com,m:hannes@cmpxchg.org,m:riel@surriel.com,m:shakeel.butt@linux.dev,m:kas@kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260020-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71ED6636583



On 02/06/2026 18:51, Pedro Falcato wrote:
> On Tue, Jun 02, 2026 at 10:22:47AM -0700, Usama Arif wrote:
>> mincore_swap() also fields migration/hwpoison entries (and shmem
>> swapin-error entries), which can exist on !CONFIG_SWAP builds when
>> CONFIG_MIGRATION or CONFIG_MEMORY_FAILURE is enabled.  The
>> !IS_ENABLED(CONFIG_SWAP) guard ran before the non-swap-entry early
>> return, so mincore_pte_range() can spuriously WARN and report these
>> pages nonresident on !CONFIG_SWAP kernels.
>>
>> Move the guard below the non-swap-entry check so only true swap
>> entries trip the WARN, and migration/hwpoison entries take the
>> existing "uptodate / non-shmem" path.
>>
>> Fixes: 1f2052755c15 ("mm/mincore: use a helper for checking the swap cache")
>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> 
> LGTM, thanks!
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> 
> Maybe Cc: stable@kernel.org ?
> 

Ah yes, I have cc-ed stable in the reply to this email, but probably that
is not enough?

Thanks

