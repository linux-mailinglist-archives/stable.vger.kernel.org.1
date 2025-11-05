Return-Path: <stable+bounces-192525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3CEC36BBD
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 17:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1726A18922B0
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B70311955;
	Wed,  5 Nov 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijEkyMqm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311E86334;
	Wed,  5 Nov 2025 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360286; cv=none; b=qYbsYYxSSlillNyqRe1Iq0Y9TMV/5Y4bGM4RUgFNsC8XwFZU12ZVkhZcCVSTgdufByWNjUS1Z9jo0uIEqQMZu+FTOsKGsmrkztXPSjxNQjzMJVArSPKvFa2ig7/4Qei6Xc7caWjr0j6VW/7I3p6OyhS4m/RlMOLYNBqSwx9AAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360286; c=relaxed/simple;
	bh=TmRrpB0daG+yPB62aM1A8jn2xEuVx2ZGsuNa8VIp1BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prRT+WS/WYi49fcjnJTBPw38N/+jYY23/nYA1ngRn/h+ZJ8qxfb2Kcu/CuihTB2nUazny4LcApXD3XnHUebRIfjqTi8b0zRCiNeLtv6MxUmcmEQ/C1l/JGnGlEq4VhcY+H7ftVWG4MX/JOQ+rLGOAVwsug9QjPvGWgjgNR17/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijEkyMqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01482C116B1;
	Wed,  5 Nov 2025 16:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762360285;
	bh=TmRrpB0daG+yPB62aM1A8jn2xEuVx2ZGsuNa8VIp1BE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ijEkyMqmeSjERxDhaNRmHwC2BUD941UDTprg2ZbUH/lkPuqTb6gaoQ7rolMqAh2cU
	 9twtFfFUOOTh7H0k574+fak4UatdGPaPkx19NaI7ix+tBaFaywtHqm1KV8WJ7x0Yv4
	 zG0ogxLM7btV1owwW6q38fT+OA0No40QP6TVlL1dK2sVe7+C2cb9YOXLV2JonKjWSV
	 q/83Kcw4DjS4gbBViscwdwh6UX4a2nFYWsnpbVm3PVmm8qEKq5IzwMOM/lbNvxnfVJ
	 KVXNSVz90pH1NquNUMff6nvLcz6F6aUrKvBZYVZtw5xcdCWpT4fg0Ov0Oluw76yQEY
	 bAonIW4CjndSA==
Message-ID: <cb1d2b13-6eb0-466b-a541-0d97940fc184@kernel.org>
Date: Wed, 5 Nov 2025 17:31:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: fix folio split check for anon folios in
 swapcache.
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Wei Yang <richard.weiyang@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251105162910.752266-1-ziy@nvidia.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251105162910.752266-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.25 17:29, Zi Yan wrote:

Nit: drop trailing "." in subject.

I'm sure Andrew can fix that up :)

> Both uniform and non uniform split check missed the check to prevent
> splitting anon folios in swapcache to non-zero order. Fix the check.
> 
> Fixes: 58729c04cf10 ("mm/huge_memory: add buddy allocator like (non-uniform) folio_split()")
> Reported-by: "David Hildenbrand (Red Hat)" <david@kernel.org>
> Closes: https://lore.kernel.org/all/dc0ecc2c-4089-484f-917f-920fdca4c898@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Thanks!

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

