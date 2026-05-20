Return-Path: <stable+bounces-249784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMZ1J/BwDWroxQUAu9opvQ
	(envelope-from <stable+bounces-249784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:29:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE86589C4B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F4007300443E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14F137754B;
	Wed, 20 May 2026 08:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mf4Y5h71"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA12C343886
	for <stable@vger.kernel.org>; Wed, 20 May 2026 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265770; cv=none; b=R2tJssNg3tvB8Hv5aGmbyaXYmclWIJtz3fWntSSdWzR+pYsED/EecHditD6xIhj1Lu11sdGQc0UTYuJaqA73oiZesoP7swiCr5406KVyxJbDim1nfxP2HOwE2mqXbFSPmWIrjLtKTymMAdyY+oyeNCoRZIsUahTAHLbgrdts/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265770; c=relaxed/simple;
	bh=Toc6Hf57MsxqjcmT4Wwv1Dez0FV6nEjIiy/BCwrLaT4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=twdG3eX0vnJF8Ryf/UlNI5SsWERbVaLrXbB3Bro13QWAoJWex4xHF77KytcZdaLB6W1Ygev/n82KrdtCIhML1cuYAEJonM/FaZ1jdgk/oX1yVcVme9pkzFLfUHHfQv977KK+TnHnvvw+9P3eY4/Cpgj54+ytXGyM0qQ4/K6sHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mf4Y5h71; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779265765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Toc6Hf57MsxqjcmT4Wwv1Dez0FV6nEjIiy/BCwrLaT4=;
	b=Mf4Y5h71GBTlwpU539Q7BpbVNRdZ4P70r5Ia7Es3et5LVM7XirXAvHh+DSzRgnXo4Isqhf
	fzM5loPs05h0o8nqF5QaXHMdq3VFxROeF3cusFoOziqnTOf3todhElqflVEhbui9kRCBXr
	mcY0tPrqWBVx11r1sUlF6cEeNOFwu78=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] mm/cma_debug: fix invalid accesses for inactive CMA areas
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <55481a8b-dcfc-4bef-ba59-aa0b43dca88b@kernel.org>
Date: Wed, 20 May 2026 16:28:32 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Frank van der Linden <fvdl@google.com>,
 Stefan Strogin <stefan.strogin@gmail.com>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Michal Nazarewicz <mina86@mina86.com>,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1420350-1A8F-4470-8E86-F6D3D9F42CD6@linux.dev>
References: <20260520061025.3971821-1-songmuchun@bytedance.com>
 <55481a8b-dcfc-4bef-ba59-aa0b43dca88b@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249784-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[bytedance.com,linux-foundation.org,kvack.org,kernel.org,infradead.org,google.com,suse.com,gmail.com,mina86.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6EE86589C4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On May 20, 2026, at 16:19, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 5/20/26 08:10, Muchun Song wrote:
>> cma_activate_area() can fail after allocating range bitmaps. Its =
cleanup
>> path frees those bitmaps, but only clears cma->count and
>> cma->available_count. It leaves cma->nranges and each range's count =
in
>> place, so cma_debugfs_init() can still register debugfs files for an =
area
>> that never activated successfully.
>>=20
>> That exposes two problems. Reading the bitmap file can make debugfs =
walk a
>> freed range bitmap and trigger an invalid memory access. Reading =
maxchunk
>> can also take cma->lock even though that lock is initialized only on =
the
>> successful activation path.
>>=20
>> Fix this by creating debugfs entries only for CMA areas that reached
>> CMA_ACTIVATED.
>>=20
>> Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if =
requested")
>> Fixes: 2e32b947606d ("mm: cma: add functions to get region pages =
counters")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>=20
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks.

>=20
> cma_sysfs_init() also traverses all cma_area_count. Does it make sense =
to expose
> them there?

It is better to hide them from users. A separate cleanup patch is better =
since
there is no critical issue when accessing those sysfs files.

Thanks,
Muhcun

>=20
> --=20
> Cheers,
>=20
> David



