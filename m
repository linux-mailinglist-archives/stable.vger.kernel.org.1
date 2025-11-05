Return-Path: <stable+bounces-192553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C73EC386CF
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 00:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 232244E3A2B
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 23:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A02F3C09;
	Wed,  5 Nov 2025 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JmhHw+Tm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0C61D5151;
	Wed,  5 Nov 2025 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762387074; cv=none; b=ZtaS5pSrvaZObdWklaHhrp+HbD4EKsWuFKqvjZ50rQQvEInv+Db1YY9lay5c0DpnhlNUI5zazfInwCPabrQAal1SQgH5SEEMowwxyb/9WhUEYUxvT+rCZYWWA9KJKWzUzLTEgX+DSfiOIKEIH+9pmhbwY6j0hJu66bir00+qsr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762387074; c=relaxed/simple;
	bh=2Y3mQFTXDjBIqGVv4+kIDxm2f6jAQbNAnGy7he78Hts=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qK5+bOkaLQ/0/c4/APcOzIRlVMCWJBx6GKgh9TfZijwHF42bVObIQIv4Y43hdqhtDDAkVK/Q00u1HWYKzD0R1WdfqbzfRdVRilrye7/pAaKEENSM7FXH1nxRyNRdkUKo5Q1ePECR7IBT0OF70k1EQVd48ViFKy9xg/U57I5/xs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JmhHw+Tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68760C4CEF5;
	Wed,  5 Nov 2025 23:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762387073;
	bh=2Y3mQFTXDjBIqGVv4+kIDxm2f6jAQbNAnGy7he78Hts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JmhHw+TmiZ0zvjghAeXmox4sDcO/3+eSl2QW8OHdnfRmWJH6i/l+yb+rvx/TZKerN
	 CHU/H+43D/+hM0VrHf9mxhTR9KZ6oaQFsnaYQ8tYxHllE4XkNxaUSpL950mH1vf7NP
	 +dyRxJGUsHAKLbwgNVrgSfxL0baSDJuz6xov0xUw=
Date: Wed, 5 Nov 2025 15:57:52 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>, Wei Yang
 <richard.weiyang@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix folio split check for anon folios
 in swapcache.
Message-Id: <20251105155752.fabace52f503424c64517735@linux-foundation.org>
In-Reply-To: <20251105162910.752266-1-ziy@nvidia.com>
References: <20251105162910.752266-1-ziy@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Nov 2025 11:29:10 -0500 Zi Yan <ziy@nvidia.com> wrote:

> Both uniform and non uniform split check missed the check to prevent
> splitting anon folios in swapcache to non-zero order. Fix the check.

Please describe the possible userspace-visible effects of the bug
especially when proposing a -stable backport.

> Fixes: 58729c04cf10 ("mm/huge_memory: add buddy allocator like (non-uniform) folio_split()")
> Reported-by: "David Hildenbrand (Red Hat)" <david@kernel.org>
> Closes: https://lore.kernel.org/all/dc0ecc2c-4089-484f-917f-920fdca4c898@kernel.org/

I was hopeful, but that's "from code inspection".

> Cc: stable@vger.kernel.org
> Signed-off-by: Zi Yan <ziy@nvidia.com>


