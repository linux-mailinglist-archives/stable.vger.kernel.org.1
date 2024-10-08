Return-Path: <stable+bounces-81515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3571993E93
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7B91F23CF2
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 06:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42058143875;
	Tue,  8 Oct 2024 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnnJNVGv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DBD143880
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367465; cv=none; b=g7iNCr8P25EQkr1uTfYyILGRcJ4Aj2ttXdVvQxP1z4JWZbMU2iZMPTwls5mo4vl+9Ge0YJmkqbP8CFwOuD79zMMGpWJunuspzT8KaMw1UcktCUTW6fZHBLSvYaVwEsOay/m0EilQXm98VRKkpuJJF45VfviibYUtnu9UzUZTdLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367465; c=relaxed/simple;
	bh=WPICulLpm9uNUrOGHbZTdQkgSmjTEhlwc0/z8xmBcsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6jmJ7KSbcvChUaqyKXlzoMc8LYXgIHU69MJkHfLCuBQV7H3RdhK4C7q2bONEJ5wSH/78ENQl2n05hl6+2tJlK/qseJ+DV7SgEzINXRmieYGGRg3UjwtejvIc6Umcu+qEkdG7rzr1n9vI4eW1xP8RJycVpX90fUDe0aO0wHE0pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnnJNVGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB71FC4CECC;
	Tue,  8 Oct 2024 06:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728367464;
	bh=WPICulLpm9uNUrOGHbZTdQkgSmjTEhlwc0/z8xmBcsM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dnnJNVGvg8xtr3pBBO7N7KXSkv4mrrUsOvtq+H+iYfJ+H1oLQAk3OUPClCWJAIzhk
	 88fwTA/dVsk9HrtwSUTOax6JwhvL+ugXR3dbQVWDeS/XgM3fDDxK/Q6Hmp8x28ZT1A
	 7SNX45JMDTxNZXhOTSB3UMndK0gDgMTeP5gaRSHmPaWEST15fWRQqLwXmsff9vyitr
	 Oe0JHTmZp/It8bcM8QM7vb1/ZBcY90w+YTG7wIpqaNPkzsujDeb4Lr4wy1lqk421aC
	 wohfI2TvZs25DsOqilv1OEO/5busr/8Hg4pdfWni/7T7aJf9l0LmZfOpITT7/cy/to
	 KYIgGsZVHtMSQ==
Date: Tue, 8 Oct 2024 02:04:23 -0400
From: Sasha Levin <sashal@kernel.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Chris Down <chris@chrisdown.name>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Christoph Hellwig <hch@lst.de>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.11.y] mm: z3fold: deprecate CONFIG_Z3FOLD
Message-ID: <ZwTLZ7rgSr58pqVq@sashalap>
References: <2024100707-delta-trance-5682@gregkh>
 <20241007192116.2529593-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241007192116.2529593-1-yosryahmed@google.com>

On Mon, Oct 07, 2024 at 07:21:16PM +0000, Yosry Ahmed wrote:
>The z3fold compressed pages allocator is rarely used, most users use
>zsmalloc.  The only disadvantage of zsmalloc in comparison is the
>dependency on MMU, and zbud is a more common option for !MMU as it was the
>default zswap allocator for a long time.

Queued up, thanks!

-- 
Thanks,
Sasha

