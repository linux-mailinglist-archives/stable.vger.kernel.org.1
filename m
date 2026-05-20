Return-Path: <stable+bounces-249771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDW9LkhmDWquwgUAu9opvQ
	(envelope-from <stable+bounces-249771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:44:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15044589182
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9842E302AC06
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBE5351C27;
	Wed, 20 May 2026 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="guf+lFQy"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046633F5A8
	for <stable@vger.kernel.org>; Wed, 20 May 2026 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262719; cv=none; b=a9iQrxH2b+FnKPhyu3wPX0w87yDZK+NdFffob4eQkeEZspLnGG9xMqVFmwCxAJA8yhrb/rDoQsgrrf26fqLb3LKMYfajRwxYnYkhFjsV71YdiCrCqHFZSdV1BzBLJAOPwsgShfrvLeo38qyLZqUtMcuXtI1YVe1dn4/3d/QI9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262719; c=relaxed/simple;
	bh=W9Wf6+1EnvL4wZQtjY/HoofUXLpADwBl0zleq9Tdm84=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UCnZx3Uwd1q5l/HofmiQtTlXSAYuGopAz4pty3ikgIf6mFUYsyzLMr1YCHF9OnalZReQLtvtUSx3Nc9v7+kVabAYMpKWNSBlExGSj9+vdcvjhhmP3bAF+hP34+VsAySwzj7hTIKJ1b976VKe2VvOxab5nK9MPIsdDu2TkN6mRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=guf+lFQy; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779262706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9Wf6+1EnvL4wZQtjY/HoofUXLpADwBl0zleq9Tdm84=;
	b=guf+lFQyC1RCTuzV3Otmw4kOpcCj/qPP9u1eo5RT962dqQXAvTE7BzDrn7qejVsyAwaWPI
	4vM4H7zfd15REfct9cR5yZwiyQIf3V8R9/JS9Cz+BDABGc/MIrnH8PV+yvMzCcWIFLi8AU
	cMwZU9Ru850/P2jTlZlkrUIqjlR5ykE=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] mm/cma_debug: fix invalid accesses for inactive CMA areas
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <ag1icL5DPMVXwRta@localhost.localdomain>
Date: Wed, 20 May 2026 15:37:43 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
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
Message-Id: <BBDB1B2E-32A3-4B52-B1A1-F048B66AE47E@linux.dev>
References: <20260520061025.3971821-1-songmuchun@bytedance.com>
 <ag1icL5DPMVXwRta@localhost.localdomain>
To: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249771-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bytedance.com,linux-foundation.org,kernel.org,kvack.org,infradead.org,google.com,suse.com,gmail.com,mina86.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim,bytedance.com:email]
X-Rspamd-Queue-Id: 15044589182
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On May 20, 2026, at 15:27, Oscar Salvador (SUSE) =
<osalvador@kernel.org> wrote:
>=20
> On Wed, May 20, 2026 at 02:10:25PM +0800, Muchun Song wrote:
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
>=20
> For the change:
>=20
> Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
>=20
> About Fixes, does this mean that before c009da4258f9 ("mm, cma: =
support
> multiple contiguous ranges, if requested"), this was already =
triggerable
> after 2e32b947606d?

c009da4258f9 introduced the invalid access to bitmap file. 2e32b947606d =
introduced
the invalid access to cma->lock.

This change applies to both issues. So I added two Fixes tags.

Thanks.

>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs



