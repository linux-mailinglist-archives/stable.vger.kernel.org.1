Return-Path: <stable+bounces-179675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEECBB58C0E
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 04:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817D82A6402
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 02:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC36222566;
	Tue, 16 Sep 2025 02:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gCV8RQ/Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496E4E571;
	Tue, 16 Sep 2025 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757991281; cv=none; b=oAg7UsGi9UeY2k0o/0nYIU4+32LqLcHPvk57CO/BMDeW58gfMYCMGARVXs0gLEgiqrRUnohEp/SRubSAtdAacajAtOepoWvA9hZnLjq8RJb0vcd0/7kZctoA/oE0ltIex9lCsgQQJaGAkmOM9/BBRjAModJCoOyFyKO84FNaakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757991281; c=relaxed/simple;
	bh=FSXamsz51GyhPZeRXCy10g3ECsbExx4flqf03FwCSJw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jF+MeoReA5Y9OWRGjmy5CyCbPXQ1yNSJD3FtEfTlhTM6jHjlUeQbmBek1eu9wx2YjkTjGdaPgSV9RpS1s7+9Kgp6/kswbrVcmfoP49Hh3D47Z7RqjY2KC0YNrDt4kOhNz/3Kt7xuuIotGtOFEe5B4nPm2ZZwKsdSGzf6kuJXvDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gCV8RQ/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75183C4CEF1;
	Tue, 16 Sep 2025 02:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757991280;
	bh=FSXamsz51GyhPZeRXCy10g3ECsbExx4flqf03FwCSJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gCV8RQ/YFvjq4gwgXdRs5tHtMrlKZR1F12Wni3SnQxHcz6NXQQUai8J4rQW2WJD/K
	 /g9eftk7RH0teioVEnlOL4yYCa6ydmVpXO2YTb+LF2dZQX4Uxc3OfQ9DuKSpmT1ep6
	 hCLQIG/U2XbLcdc0ZX8s1o6Nb9Ki4Ggmzciqvpwo=
Date: Mon, 15 Sep 2025 19:54:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joe Perches <joe@perches.com>
Cc: Donet Tom <donettom@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin
 <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, Wei Yang
 <richard.weiyang@gmail.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Giorgi Tchankvetadze
 <giorgitchankvetadze1997@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/ksm: Fix incorrect KSM counter handling in
 mm_struct during fork
Message-Id: <20250915195439.fa6d52c3f3bbe6380ad65660@linux-foundation.org>
In-Reply-To: <8d7be334af3944f990b56c80a70b7691763c3af8.camel@perches.com>
References: <cover.1757946863.git.donettom@linux.ibm.com>
	<4044e7623953d9f4c240d0308cf0b2fe769ee553.1757946863.git.donettom@linux.ibm.com>
	<20250915164248.788601c4dc614913081ec7d7@linux-foundation.org>
	<8d7be334af3944f990b56c80a70b7691763c3af8.camel@perches.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 19:14:47 -0700 Joe Perches <joe@perches.com> wrote:

> On Mon, 2025-09-15 at 16:42 -0700, Andrew Morton wrote:
> > On Mon, 15 Sep 2025 20:33:04 +0530 Donet Tom <donettom@linux.ibm.com> wrote:
> []
> > > Fixes: 7609385337a4 ("ksm: count ksm merging pages for each process")
> > 
> > Linux-v5.19
> > 
> > > Fixes: cb4df4cae4f2 ("ksm: count allocated ksm rmap_items for each process")
> > 
> > Linux-v6.1
> > 
> > > Fixes: e2942062e01d ("ksm: count all zero pages placed by KSM")
> > 
> > Linux-v6.10
> > 
> > > cc: stable@vger.kernel.org # v6.6
> > 
> > So how was Linux-v6.6 arrived at?
> []
> > (Cc Joe.  Should checkpatch say something about this)?
> 
> Probably not. Parsing variants of versions seems, umm, difficult.

I was thinking simpler.  If the Fixes: count exceeds one, ask
"wtf are you asking of the -stable maintainers"?


