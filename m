Return-Path: <stable+bounces-268717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YJfGIh7xPWq48wgAu9opvQ
	(envelope-from <stable+bounces-268717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 05:25:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B4A6C9EB1
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 05:25:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="WLMnuF//";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268717-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268717-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3A6A30347E2
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 03:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F42EEE63;
	Fri, 26 Jun 2026 03:25:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3F3C1F
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 03:25:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782444313; cv=none; b=dGoXpdgumFUIWiLO8PqAH85QfBlSo/++uSu1f65GUV3cllwnxX+RcLEJ01mLkLnr8yIFpLR+xZ/ANFj8ltz0FbTR+ZIS0K0tY9u2Q5dwlGn6MrbofuFagcfqqlJFWmTpYCfP0XV4oUV6up3Q2HMzMIdVG4TUXa/sMr4wsdt5Th8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782444313; c=relaxed/simple;
	bh=Ux5+lGJwP6LBbsjx9rLhMSCweHr13fiQdtUrbhOlobM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Tv06IZVeVORlXDhVtiD9a5G0octvUsLnnK4/RJ0SbruV5IPm1d7Dd1zsNKPdaKrXhJp/QFzdce9zK5zx0QAsEKfktJmZhMD9cVGWE2tZ5YJe8GboU3LwN0z4uSG+mcM3R2eY2NBOzfEDdw4ub+Qsk61OSRKfqdvFOg4N/HaZYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WLMnuF//; arc=none smtp.client-ip=95.215.58.182
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782444309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OAXxVgUjspFRwFL/RkyK5xtXWU1EaEUoL3fXnAC+ilY=;
	b=WLMnuF//u9tPPAqJrZxZn4i0N40nEjPTUdUTFBNYBZ7b+NqKnvWWIXEkhC2M94T7rwC5nt
	slSAhdl1ejlz0D1vl4f8SzrXb1zgQXA9z6YzMaCN5NYNf/Q2xuiUPczuiuecOgCXc09z/z
	7EQW8Ec7zgRmcMiA6NYQYQjWZW0fcio=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 2/5] mm/rmap: use huge_ptep_get() in try_to_migrate_one()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260625112955.3254283-3-dev.jain@arm.com>
Date: Fri, 26 Jun 2026 11:24:28 +0800
Cc: osalvador@suse.de,
 akpm@linux-foundation.org,
 ljs@kernel.org,
 david@kernel.org,
 liam@infradead.org,
 riel@surriel.com,
 vbabka@kernel.org,
 harry@kernel.org,
 jannh@google.com,
 lance.yang@linux.dev,
 kas@kernel.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 rcampbell@nvidia.com,
 apopple@nvidia.com,
 ziy@nvidia.com,
 matthew.brost@intel.com,
 joshua.hahnjy@gmail.com,
 rakie.kim@sk.com,
 byungchul@sk.com,
 gourry@gourry.net,
 ying.huang@linux.alibaba.com,
 mel@csn.ul.ie,
 nao.horiguchi@gmail.com,
 ak@linux.intel.com,
 j-nomura@ce.jp.nec.com,
 pfalcato@suse.de,
 dave.hansen@intel.com,
 tglx@kernel.org,
 jpoimboe@kernel.org,
 ryan.roberts@arm.com,
 anshuman.khandual@arm.com,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <35399716-4B47-4492-8168-B1F0AEFF6672@linux.dev>
References: <20260625112955.3254283-1-dev.jain@arm.com>
 <20260625112955.3254283-3-dev.jain@arm.com>
To: Dev Jain <dev.jain@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268717-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:osalvador@suse.de,m:akpm@linux-foundation.org,m:ljs@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:riel@surriel.com,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:lance.yang@linux.dev,m:kas@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:rcampbell@nvidia.com,m:apopple@nvidia.com,m:ziy@nvidia.com,m:matthew.brost@intel.com,m:joshua.hahnjy@gmail.com,m:rakie.kim@sk.com,m:byungchul@sk.com,m:gourry@gourry.net,m:ying.huang@linux.alibaba.com,m:mel@csn.ul.ie,m:nao.horiguchi@gmail.com,m:ak@linux.intel.com,m:j-nomura@ce.jp.nec.com,m:pfalcato@suse.de,m:dave.hansen@intel.com,m:tglx@kernel.org,m:jpoimboe@kernel.org,m:ryan.roberts@arm.com,m:anshuman.khandual@arm.com,m:stable@vger.kernel.org,m:dev.jain@arm.com,m:joshuahahnjy@gmail.com,m:naohoriguchi@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[suse.de,linux-foundation.org,kernel.org,infradead.org,surriel.com,google.com,linux.dev,kvack.org,vger.kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,csn.ul.ie,linux.intel.com,ce.jp.nec.com,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,arm.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3B4A6C9EB1



> On Jun 25, 2026, at 19:29, Dev Jain <dev.jain@arm.com> wrote:
> 
> try_to_migrate_one() is used by folio migration to replace a present
> mapping with a migration entry. For hugetlb folios, page_vma_mapped_walk()
> returns the pte pointer to the hugetlb folio in pvmw.pte, but the code
> reads the huge pte entry with ptep_get().
> 
> On arches which provide their own huge_ptep_get() to dereference a huge
> pte pointer, accessing via ptep_get() would cause pte_pfn(), pte_present()
> etc to misbehave.
> 
> It is not clear whether this has a trivially visible effect to userspace.
> 
> Use huge_ptep_get() to dereference a huge pte pointer.
> 
> Commit a98a2f0c8ce1 copied the bug from try_to_unmap_one into
> try_to_migrate_one.
> 
> Fixes: a98a2f0c8ce1 ("mm/rmap: split migration into its own function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dev Jain <dev.jain@arm.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.	


