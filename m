Return-Path: <stable+bounces-195226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528FC724BD
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 07:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3721834D3DD
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 06:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69026ED40;
	Thu, 20 Nov 2025 06:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Z4UnWF2l"
X-Original-To: stable@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2EF21B9C9
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 06:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763618851; cv=none; b=Vn1e9abdF9vgNbbBzIx+nfjsetO6vOjoimf2rOc5pVVQPYXBRD6SGqhHprzXpFR75ZgvIe49vbUPcCpETulItVX8EN1WYogxM8N5xlS7/WhyWWd0/b3nAOsmHst1py4lZAhhqoQXzlrvsqqfRgNDb0ED/cEkL6KaY0nC6gzWpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763618851; c=relaxed/simple;
	bh=YsoUHth/gJLQtcu8ot5YNJI91JpOj/5QAUUy+WxFiUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1ZbQ7neDDazd0MM2r7YGptLIYyxtlY2nUGCWl7OdcvdNyAgR+Vtm4k5cunmN4zT0YMj/WbfHAt5lnQ+r6sHBqEkbNWo3KwzCVLRWTU5QGTx+CEeCPMl8dpBKLjpytMDdkKxVDnu/Fu3dtVGk+7q2a9i2wdh7JY9Y+xWn8IPQX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Z4UnWF2l; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763618846; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+adqPRtuRy06LhWm23J9UDBt68o9Fdy/99QuV8jd99s=;
	b=Z4UnWF2lOUH91O3vYshkdRBXZVL+Kt5HhMC/YfpLAkckwn57nl7cJPavQkQUh3e/KX++pOqu2TnsUmZxyS5sSVek9LETPLZONTGTr7d0+0NE6lPg5d4xLtZKHdtXXT15DTEkm0MpzagEi0eoG7JBF7AXXhui0NlhZJn0sLnbt8I=
Received: from 30.74.144.115(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WssFsdR_1763618844 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 20 Nov 2025 14:07:25 +0800
Message-ID: <128d64e1-6a7a-419f-928d-c8681ba8f2f3@linux.alibaba.com>
Date: Thu, 20 Nov 2025 14:07:24 +0800
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
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr
Cc: linux-mm@kvack.org, stable@vger.kernel.org
References: <20251119235302.24773-1-richard.weiyang@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251119235302.24773-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/11/20 07:53, Wei Yang wrote:
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
> 
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

