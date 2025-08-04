Return-Path: <stable+bounces-166504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68595B1A92D
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 20:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326A1189F8BB
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9C723BD1B;
	Mon,  4 Aug 2025 18:28:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3E71D9A5D
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754332128; cv=none; b=dPB/3dil5bYEmmNdTn90e7aQJvr5ROowsMgm36RHgA+ZSsZBrQyviZVgiq1IlXk3TgUiTUa2vol4ncxGV4CEBdUMrWPWKXXaQLzYY1WcZPCiO+pQuO4U3Ivf3SG+NUh5tRxnLtezISqkyvwL46iBxSwhXlp+hPQasvOProOYdxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754332128; c=relaxed/simple;
	bh=FiJnOQlBQyeI08kYMdOXsV/miH190eaWcTaSnphce34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSqZFJWRti3xi/G+pW6d7+kLkeVuSLAvHAE0QTQhqmrkhcB+zevPKyUKQV4bP1ZSEQaYJP3TnfqFPRnsCGyF5s8vsf0UD/403OBognpCI/zbVc+wSMomQTIh+fWOBU538HMhXmaixN/1tfSuOgwdjLyDWIL/NYOP/g4APE3H+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AE3C4CEE7;
	Mon,  4 Aug 2025 18:28:44 +0000 (UTC)
Date: Mon, 4 Aug 2025 19:28:42 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Waiman Long <llong@redhat.com>, Gu Bowen <gubowen5@huawei.com>,
	stable@vger.kernel.org, linux-mm@kvack.org,
	Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH] mm: Fix possible deadlock in console_trylock_spinning
Message-ID: <aJD72syGyJs203Mw@arm.com>
References: <20250730094914.566582-1-gubowen5@huawei.com>
 <20250801153303.cee42dcfc94c63fb5026bba0@linux-foundation.org>
 <5ca375cd-4a20-4807-b897-68b289626550@redhat.com>
 <20250801205323.70c2fabe5f64d2fb7c64fd94@linux-foundation.org>
 <aJCir5Wh362XzLSx@arm.com>
 <o2gpvdtxqrdfrsbayorvzvjqcreb45puojpgfye7dimbuuvbdt@gxquukahrxo7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o2gpvdtxqrdfrsbayorvzvjqcreb45puojpgfye7dimbuuvbdt@gxquukahrxo7>

On Mon, Aug 04, 2025 at 05:34:10AM -0700, Breno Leitao wrote:
> On Mon, Aug 04, 2025 at 01:08:15PM +0100, Catalin Marinas wrote:
> 
> > I'm surprised we haven't seen these until recently. Has printk always
> > allocated memory?
> 
> I can talk about netconsole, and the answer is yes!
> 
> weird enought, lockdep never picked this issue, and I have a few set of
> hosts running kmemleak and lockdep for a while.
> 
> This time was different because I have decided to invstiage the code,
> and found the deadlock. Still, no lockdep complain at all.

I guess it's because kmemleak is quiet in general, unless problems are
found, and lockdep never registered this combination - printk() called
with the kmemleak_lock held.

Thanks for investigating.

-- 
Catalin

