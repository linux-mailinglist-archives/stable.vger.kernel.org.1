Return-Path: <stable+bounces-273221-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +BCMAMfoUGop8QIAu9opvQ
	(envelope-from <stable+bounces-273221-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 14:42:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5857473ADD2
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 14:42:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fCVFfO9m;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273221-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273221-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BF76301CFDF
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCE7421896;
	Fri, 10 Jul 2026 12:41:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5F8408626;
	Fri, 10 Jul 2026 12:41:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783687317; cv=none; b=S8P2HLApPiYL/ecYLDYZuR8UP84knYdmsEK8iShwLEmWGS8ojk6qDls45y5tUT40Eh0RhpwnTkWqlvooDEfGDinDcC/E9HY8g3kVeGXKjqQ92Yh7P4YF0DQo+fnxScFq9M5HF+t6bJ8oyakxXguPW4yWcyeEMdmpuQiFoQcGk2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783687317; c=relaxed/simple;
	bh=S2IeHExeWGCelQ6yRVBVZdCGRMLLewZl+jKUKSaK+X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VaIQMT6CAIFpmlTpx5wAdYCq7sEWmoVKeQmuRXyLpc4UYaeyRGRJdgNQh++ouSG5p1KBL962uIad5BrmECnvikc1Yr2XVLPwSI/tBgJ6UngnuibS0i1hbPHE/j2BAazw/B/FUV9Gy06JglXX9EfPQaW+pwAy7rnMtQBnCC8SUi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCVFfO9m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530D21F000E9;
	Fri, 10 Jul 2026 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783687316;
	bh=Ul3sRLhwjrxQoJQnvumZ0PUhmDQ8XYv0aOjCqcjQNpM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fCVFfO9m4IzAP/wLQyhgQloMt80bQ5IwGpNIuTW9LwD9oZ/XvQAcTOdJGAM/c7dJE
	 r9Yk5/nzIgBnh1LNVNhCLeoKT26eV18U8A9jSCt0j0pLm/rdT1CNRPYczRHWWE1cQO
	 XLBswv9UmPxB0abMYjaKn2EyKBUvcG9DL04WZ9jEOqnQG1c+D5vdeBK4X9KBOnhOdE
	 XUfM0AMy1Lh4Xh+hTvqWoh0ICLqxxg9a/jf5K+uizSCB/32YFTH45pnS7L+qZVduIc
	 Y2P7dZTpm7THC3xWck3OwjF7SLg3wluXoKTppqOOvGN2RfOT8qJEa5vxM2ieFTU1fj
	 Y8mvSwMOrzgQQ==
Message-ID: <a160217b-c0aa-4ef8-bbf6-e75a8ff25cea@kernel.org>
Date: Fri, 10 Jul 2026 14:41:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mm/huge_memory: skip device-private PMDs in
 madvise_free_huge_pmd
To: Usama Arif <usama.arif@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
 balbirs@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 byungchul@sk.com, dev.jain@arm.com, gourry@gourry.net, jannh@google.com,
 joshua.hahnjy@gmail.com, lance.yang@linux.dev, liam@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
 matthew.brost@intel.com, npache@redhat.com, rakie.kim@sk.com,
 ryan.roberts@arm.com, vbabka@kernel.org, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, shakeel.butt@linux.dev, hannes@cmpxchg.org
Cc: stable@vger.kernel.org
References: <20260710105557.1987433-1-usama.arif@linux.dev>
 <20260710105557.1987433-4-usama.arif@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260710105557.1987433-4-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:usama.arif@linux.dev,m:akpm@linux-foundation.org,m:apopple@nvidia.com,m:balbirs@nvidia.com,m:baohua@kernel.org,m:baolin.wang@linux.alibaba.com,m:byungchul@sk.com,m:dev.jain@arm.com,m:gourry@gourry.net,m:jannh@google.com,m:joshua.hahnjy@gmail.com,m:lance.yang@linux.dev,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:matthew.brost@intel.com,m:npache@redhat.com,m:rakie.kim@sk.com,m:ryan.roberts@arm.com,m:vbabka@kernel.org,m:ying.huang@linux.alibaba.com,m:ziy@nvidia.com,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,m:stable@vger.kernel.org,m:joshuahahnjy@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[david@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,nvidia.com,kernel.org,linux.alibaba.com,sk.com,arm.com,gourry.net,google.com,gmail.com,infradead.org,vger.kernel.org,kvack.org,intel.com,redhat.com,cmpxchg.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273221-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5857473ADD2

On 7/10/26 12:55, Usama Arif wrote:
> madvise_free_pte_range() checks pmd_trans_huge(*pmd) unlocked, then
> madvise_free_huge_pmd() takes pmd_trans_huge_lock(). pmd_is_huge()
> returns true for a device-private PMD, so orig_pmd can be device-private
> and enter the !pmd_present() branch.
> 
> Skip device-private PMDs in that non-present branch and continue to out
> before calling pmd_folio(). Downgrade the check to VM_WARN_ON_ONCE() so
> an unexpected PMD softleaf logs a warning rather than panicking. Drop
> the thp_migration_supported() guard: it expands to
> IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_SOFTLEAF), and both
> pmd_is_migration_entry() and pmd_is_device_private_entry() already
> return false when that config is not selected, so the guard suppresses
> only the case where the warning would already be silent.
> 
> Potential trigger: an HMM-based GPU driver races with madvise(MADV_FREE):
> migrate_vma_pages() flips the PMD to a device-private entry between the
> caller's pmd_trans_huge() check and the callee's pmd_trans_huge_lock().
> 
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Balbir Singh <balbirs@nvidia.com>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David

