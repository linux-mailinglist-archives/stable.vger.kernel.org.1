Return-Path: <stable+bounces-267397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mF0EFvw5NWpCpQYAu9opvQ
	(envelope-from <stable+bounces-267397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 14:45:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 533516A5D76
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 14:45:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=B5Iwa2++;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267397-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-267397-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA6D03007B09
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 12:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A7B387585;
	Fri, 19 Jun 2026 12:45:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43A383C99
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 12:45:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781873126; cv=none; b=hFOihLx+5/MPiWKEFIDS4EIenUedZ6K0Dz0RZv0AeamDs+xAstPdnJW8MX9jrD6oWoVJ/JlF2hy+rC0gzLC1NlQ7JSSepf+wzB1RLtYIdsewxIZBO/neC33gycHYyddPi3Xmz7D2mXlxRifdbZ+wYWQ6Knp4h/2uipxGcZlN6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781873126; c=relaxed/simple;
	bh=TGA2JCPZEyY6tdazTpYaB8HNXLg5+WpDgvXWYYF8kao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4WWB/o9ODqFLZQTeSROQ/47Kfwi83Ufkwn/7JW0gqKpZWPP892fLeULncFozcBou0UTsjfHJHmOvVsYsuk/Y2uqkpOw+zTIR4PjeTUoq2ls6ww1HfEPnbkbPB2ZoCLBpKTANOaC7GSAglNetexzE6eiMdOAaGacLqVLz00eEy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5Iwa2++; arc=none smtp.client-ip=198.175.65.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781873125; x=1813409125;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TGA2JCPZEyY6tdazTpYaB8HNXLg5+WpDgvXWYYF8kao=;
  b=B5Iwa2++zPx5F1mZpmxKgOEO18Jtp6AzOuBoQ7U089PbHimLSAKPdfg8
   JDoYZzr+xwd3kDqJmWuLftZihBFrmowb3trRCvDTNstMRlsXAsQyQ2ygs
   DE+kRP9vdRGKLPzJy2aTmEqNNj2wHX2k3fxMbAIPmkhXVdXiTUFNi6dbY
   5qDDPA7Mfbt5F9NB93n0CWO3Li0EIkuMDgefmv/F1TWLLAKyIqp4oh6kz
   BRwm8ZV8fFIBjgUd/IAQv5+GgpojxFeDxPcCvQB7SNRH3pqc5XCjXrfDb
   hG81Yc0iSk24WB0SHx99uDUoPbHSYC8pSM9wu8F32EHPhogba2zgMBUFl
   w==;
X-CSE-ConnectionGUID: vHigh7Q8Tu2KASSiR6Ur+g==
X-CSE-MsgGUID: 9IDWz3gqQAqb1Ui+6MEdVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82813299"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="82813299"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 05:45:24 -0700
X-CSE-ConnectionGUID: 2pDFDLJBTtKUDhrtwZS5JA==
X-CSE-MsgGUID: /z4r2GaHTmC1/71lwG4Prw==
X-ExtLoop1: 1
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.211]) ([10.245.244.211])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 05:45:22 -0700
Message-ID: <4c7300dc-ab5e-464f-9704-d8da378ee1af@intel.com>
Date: Fri, 19 Jun 2026 13:45:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpu/buddy: bail out of try_harder when alignment cannot
 be honoured
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, John Olender <john.olender@gmail.com>,
 stable@vger.kernel.org
References: <20260618124755.2751205-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260618124755.2751205-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267397-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:Arunpravin.PaneerSelvam@amd.com,m:christian.koenig@amd.com,m:dri-devel@lists.freedesktop.org,m:intel-gfx@lists.freedesktop.org,m:intel-xe@lists.freedesktop.org,m:amd-gfx@lists.freedesktop.org,m:alexander.deucher@amd.com,m:timur.kristof@gmail.com,m:john.olender@gmail.com,m:stable@vger.kernel.org,m:timurkristof@gmail.com,m:johnolender@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.auld@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 533516A5D76

On 18/06/2026 13:47, Arunpravin Paneer Selvam wrote:
> The try_harder contiguous fallback could return a range whose start
> offset did not match the caller's min_block_size. Check each candidate
> against the requested alignment and reject the allocation when no
> candidate satisfies it, instead of handing back a misaligned range.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Cc: John Olender <john.olender@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/buddy.c | 33 +++++++++++++++++++++------------
>   1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index dc81fe0301ce..28ed3250ac57 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1127,13 +1127,11 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>   	struct gpu_buddy_block *block;
>   	unsigned int tree, order;
>   	LIST_HEAD(blocks_lhs);
> -	unsigned long pages;
>   	u64 modify_size;
>   	int err;
>   
>   	modify_size = rounddown_pow_of_two(size);
> -	pages = modify_size >> ilog2(mm->chunk_size);
> -	order = fls(pages) - 1;
> +	order = ilog2(modify_size) - ilog2(mm->chunk_size);
>   	if (order == 0)
>   		return -ENOSPC;
>   
> @@ -1149,31 +1147,42 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>   		while (iter) {
>   			block = rbtree_get_free_block(iter);
>   
> -			/* Allocate blocks traversing RHS */
>   			rhs_offset = gpu_buddy_block_offset(block);
> +
> +			/* Allocate blocks traversing RHS */
>   			err =  __gpu_buddy_alloc_range(mm, rhs_offset, size,
>   						       &filled, blocks);
> -			if (!err || err != -ENOSPC)
> +			if (err && err != -ENOSPC)
>   				return err;
> +			if (!err && IS_ALIGNED(rhs_offset, min_block_size))
> +				return 0;
> +			if (!err)

Should we do some kind of rhs = round_down(rhs, min_block_size) at the 
start? Just wondering if we can get something misaligned here, that 
should have succeeded if we just applied the round_down first, in some 
edge case?

> +				goto next;
>   
> -			lhs_size = max((size - filled), min_block_size);
> -			if (!IS_ALIGNED(lhs_size, min_block_size))
> -				lhs_size = round_up(lhs_size, min_block_size);
> +			lhs_size = round_up(max((size - filled), min_block_size),
> +					    min_block_size);

Can this be simplified as: round_up(size - filled, min_block_size) ?

> +
> +			if (lhs_size > rhs_offset)

What is the idea with this check?

> +				goto next;
>   
>   			/* Allocate blocks traversing LHS */
> -			lhs_offset = gpu_buddy_block_offset(block) - lhs_size;
> +			lhs_offset = rhs_offset - lhs_size;
> +
> +			if (!IS_ALIGNED(lhs_offset, min_block_size))
> +				goto next;

Would it make sense to just align the lhs down, if misaligned, instead 
of baling? If the final size we get back is slightly too large, we can 
just apply a trim at the end?

> +
>   			err =  __gpu_buddy_alloc_range(mm, lhs_offset, lhs_size,
>   						       NULL, &blocks_lhs);
>   			if (!err) {
>   				list_splice(&blocks_lhs, blocks);
>   				return 0;
> -			} else if (err != -ENOSPC) {
> +			}
> +			if (err != -ENOSPC) {
>   				gpu_buddy_free_list_internal(mm, blocks);
>   				return err;
>   			}
> -			/* Free blocks for the next iteration */
> +next:
>   			gpu_buddy_free_list_internal(mm, blocks);
> -
>   			iter = rb_prev(iter);
>   		}
>   	}
> 
> base-commit: b9e2d5cdaab05c997be3a69d9b372d7676683e1b


