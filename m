Return-Path: <stable+bounces-195240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD519C731B2
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 10:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0238D4E5FD0
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC0930DEC8;
	Thu, 20 Nov 2025 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWbw+OUy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E3E3101D3
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630680; cv=none; b=QKJjXOpmno1MV6ArM0wrLo4G+xLFlBnBguePDjpRay3pPIpk/abhG4TwBUAG3YDSo6ay9SVjzN2U+t41h+zuKBgSb6eYawNhxqg2wdkLu68JPrTQxlqkoKuZiPpuBNTZ2s/fzIhcQ357ymZvtHVL0GSW85m9uy8jMBY+PoCTT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630680; c=relaxed/simple;
	bh=yMpM6nvcM1itHRSp8tmlbz1cYUJ/Loqws7g5zCaxfzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDCImiQw/wxD/eqsWnH9P2DD4eBCpyQWlVvIR8yFqaxl8SsspTaae80+iJbVJYXoVYIIWOC9kI3VKuyGX0ZcI4lBJxjf71n0YpAPfetF/qTy3N+iFUVEmsIjK8ZMb99ISjcu5T27eWhESjGXCcCec4+uZcMBJcrpN8aUA1E7SSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWbw+OUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5A8C4CEF1;
	Thu, 20 Nov 2025 09:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763630679;
	bh=yMpM6nvcM1itHRSp8tmlbz1cYUJ/Loqws7g5zCaxfzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KWbw+OUy0Wv5wFZ6Y8BGC1yDMPrd1YgLC8xh53gmso8bTjGeqsB4zWE+kJUflx3UE
	 ViUBcBqTk/fhkjBp216aqkVvOgzV4GQYWxE/rABw44iVPQVzV8a5q7EOHTRja2YB9X
	 yaA6ul6O0ng8UAgA+ERWORkBsfp3c8Rdd9RYRTsZ2IQtAmijeV1W2QajdmJicONMGT
	 LU4LyeqPE+H5oHQ7tN0AR6sCKJDSes2RlmSaAXwvF/ZbB9l/CnIsnBMrYDbSNYS0/W
	 Nf2N7hOFKS5mEuRlmO1bGEM4xzpwmv+stVvqMwILPri2deacRUMvObwIZBMjkdeG99
	 hiy2SdVL5mvbA==
Message-ID: <21c6ef2d-6836-47cf-9529-6838a940d06f@kernel.org>
Date: Thu, 20 Nov 2025 10:24:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] mm/huge_memory: fix NULL pointer deference when
 splitting folio
To: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: linux-mm@kvack.org, stable@vger.kernel.org
References: <20251119235302.24773-1-richard.weiyang@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251119235302.24773-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 00:53, Wei Yang wrote:
> Commit c010d47f107f ("mm: thp: split huge page to any lower order
> pages") introduced an early check on the folio's order via
> mapping->flags before proceeding with the split work.
> 
> This check introduced a bug: for shmem folios in the swap cache and
> truncated folios, the mapping pointer can be NULL. Accessing
> mapping->flags in this state leads directly to a NULL pointer
> dereference.
> 
> This commit fixes the issue by moving the check for mapping != NULL
> before any attempt to access mapping->flags.
> 
> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
> Cc: <stable@vger.kernel.org>

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

