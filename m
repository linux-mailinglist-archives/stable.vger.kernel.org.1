Return-Path: <stable+bounces-191599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ED2C1A1A4
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 12:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257D43B76EC
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891B3336EF5;
	Wed, 29 Oct 2025 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaYKugDC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45083335095;
	Wed, 29 Oct 2025 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761738324; cv=none; b=ErBh7PqkuCkp9u4+UisXnokwuVta9PaFYm14sRvBnGzgDZqtmMeVJH7jv+ikc4x1PZC0fYJxKxiWO9XcFZyqyAFr1GGzOlJpmbAzxbPXde9IsEu95Sc0vRRAzcIuCTg4oPxgPJjKvjMftLu8UPla/gdZnh37ouJuYQ5cUgWjaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761738324; c=relaxed/simple;
	bh=Z9gTj98F/1RwIRcwrL5w97Uu8Nv+KuJ0c2Vnes1C2TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSV30ANn57819JwFMEpnBbmzDuvYlNUz68cxfkqV5kufRV9FOz4ZJVUkFDLXt2r2hd9zwUKNoIDNsErwlQgF+XPifMk+YGNn4nJZrB4Qae4n9tMYY3o643HlObHocSU5xdPvAWBH6cvPEvnIlxDLc7KwPCIua2KUW9/ZHltew1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaYKugDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F1E9C4CEF7;
	Wed, 29 Oct 2025 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761738323;
	bh=Z9gTj98F/1RwIRcwrL5w97Uu8Nv+KuJ0c2Vnes1C2TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BaYKugDCgf2smiHPvIb28DXNPSUKpeXKaBRMo9BGt2C4HOcIUY2f3en5IjyInF2Wd
	 3re3T5G+7zMhmC+oUMgzwDtL+s1wxWJQlEZvGoUfmM0UrVfXSBEcVK2s3xOtXgIEVG
	 xDsvKcYGpk7qW37yMjYmRrv/D4r0MVMP3FOmCMsROWHiztJ8+g+wFWEN43JIyvfwey
	 QhSl616j9GnucJbsFczvsjaOofnaGGs6znn904EFWc4A8rdL4D2hdSIW134EuFYBgN
	 WAwZTpWyy2KFCyByQVVzCyMCQN3s/AFGb3+C2tsNi00PQTckVuNXNEydbIzEGBa0TJ
	 9I/GVQbsCm9BA==
Date: Wed, 29 Oct 2025 13:45:17 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm/mm_init: Fix hash table order logging in
 alloc_large_system_hash()
Message-ID: <aQH-TewXFLUsK3nN@kernel.org>
References: <20251028191020.413002-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028191020.413002-1-isaacmanjarres@google.com>

On Tue, Oct 28, 2025 at 12:10:12PM -0700, Isaac J. Manjarres wrote:
> When emitting the order of the allocation for a hash table,
> alloc_large_system_hash() unconditionally subtracts PAGE_SHIFT from
> log base 2 of the allocation size. This is not correct if the
> allocation size is smaller than a page, and yields a negative value
> for the order as seen below:
> 
> TCP established hash table entries: 32 (order: -4, 256 bytes, linear)
> TCP bind hash table entries: 32 (order: -2, 1024 bytes, linear)
> 
> Use get_order() to compute the order when emitting the hash table
> information to correctly handle cases where the allocation size is
> smaller than a page:
> 
> TCP established hash table entries: 32 (order: 0, 256 bytes, linear)
> TCP bind hash table entries: 32 (order: 0, 1024 bytes, linear)
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org # v5.4+
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 3db2dea7db4c..7712d887b696 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2469,7 +2469,7 @@ void *__init alloc_large_system_hash(const char *tablename,
>  		panic("Failed to allocate %s hash table\n", tablename);
>  
>  	pr_info("%s hash table entries: %ld (order: %d, %lu bytes, %s)\n",
> -		tablename, 1UL << log2qty, ilog2(size) - PAGE_SHIFT, size,
> +		tablename, 1UL << log2qty, get_order(size), size,
>  		virt ? (huge ? "vmalloc hugepage" : "vmalloc") : "linear");
>  
>  	if (_hash_shift)
> -- 
> 2.51.1.851.g4ebd6896fd-goog
> 

-- 
Sincerely yours,
Mike.

