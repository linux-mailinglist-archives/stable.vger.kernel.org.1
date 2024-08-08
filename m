Return-Path: <stable+bounces-65976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD594B45B
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 02:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F161C21570
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 00:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4420ED;
	Thu,  8 Aug 2024 00:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1wqw3MW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB820E6;
	Thu,  8 Aug 2024 00:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723078766; cv=none; b=Y4QkH/X9V2IOofJ0TFp0BNbgU0YRsMaQpZG+Pw5dMNnnvlimBh0VjyGB5IBCYTyJmmzynSe+ewHNiu57+NTFjeQfDY1a46yulhi2KFb7Npwxz5OVBbm7bR1R0bWz6XMg05BmVLbSIJB322N57N13sGl1jOIOmS9Eh6AY50yf5QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723078766; c=relaxed/simple;
	bh=IvJYIBE3hjcBepXyYa5KPKw5I13hnxhgH0Nqj0N0pSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jx6w9l6ICE/wldtCXn7I+7pf5uvDYNGOrOiUkBdriPLuzUdXKWtObJb25h1aXQgGTNQK9I0TrCz8MTH1u6UgPieCY6NROHzIHDa+/hTgDIrsdGpnS4a6BOAkgCgBEvt/nKZrQr2zR19UjE1CubI1aGq/sg+02ygKrOiMuMNbm+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1wqw3MW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17182C32781;
	Thu,  8 Aug 2024 00:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723078766;
	bh=IvJYIBE3hjcBepXyYa5KPKw5I13hnxhgH0Nqj0N0pSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1wqw3MWxce4y0N9F/vXM5IiHBxaugOvUdrISTvX2o8cp4J3TLRuqs4bcDEA5Y/DC
	 AIxD8YH2MBvLNzh2omDH8MYWjmO4gSPdgoqeiMbXxVOA2ftuy6v1LGXfHKbC2ticIl
	 /LQ4fCq+PB2XqLPGAYv0cF/x0EnauyxnaA/tO8gyYGGOrSC1PfSH5T7BMJCcX9r0zn
	 +KuNoi+7a0pGa9K6kj0IXTNHcb5IA9Ija2XB7ZVYJTh5DTNJ/b/dWQniwJJwTKK3FJ
	 DtmAEZFymqgLaZO+sZkbX5FIVY9gmFifrZ2EEdB3OuWBzMtSAJEi739mb6GF+TrlrI
	 8Hagh7WAQ5ZBA==
Date: Wed, 7 Aug 2024 20:59:24 -0400
From: Sasha Levin <sashal@kernel.org>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: gregkh@linuxfoundation.org, yangge1116@126.com, hch@infradead.org,
	david@redhat.com, peterx@redhat.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [v6.6-stable PATCH] mm: gup: stop abusing try_grab_folio
Message-ID: <ZrQYbLGWVf9zOT1p@sashalap>
References: <20240806193037.1826490-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240806193037.1826490-1-yang@os.amperecomputing.com>

On Tue, Aug 06, 2024 at 12:30:36PM -0700, Yang Shi wrote:
>commit f442fa6141379a20b48ae3efabee827a3d260787 upstream
>
>A kernel warning was reported when pinning folio in CMA memory when
>launching SEV virtual machine.  The splat looks like:

[snip]

This doesn't compile on 6.6...

mm/huge_memory.c: In function 'follow_devmap_pud':
mm/huge_memory.c:1213:8: error: implicit declaration of function 'try_grab_page'; did you mean 'try_get_page'? [-Werror=implicit-function-declaration]
  1213 |  ret = try_grab_page(page, flags);
       |        ^~~~~~~~~~~~~
       |        try_get_page

-- 
Thanks,
Sasha

