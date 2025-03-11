Return-Path: <stable+bounces-124062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CA9A5CC76
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CF13B7C30
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F63262D10;
	Tue, 11 Mar 2025 17:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zj+xuUeK"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647A92627EA
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715028; cv=none; b=AYPDlI2oHXgKhogVhqSg8G6KzdAf0zZ/KAtdYg2mgAyqBrbTUWr12wZMhuRnz+Pd5Jx/svt2F8r/Za3Cie/Cte5gSFzNZFtEZZe4KyvqpFIDn6J56bg8pJJhUWhlRLiydLupTMbRkrlpZ9qikMf8JzTGm6UpzvlDFI67Vm0NbAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715028; c=relaxed/simple;
	bh=mwqIUO6GubDvGdChTEAp1WQ1CGCgw+sdch0DVw2xwpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VThmIlRruAK9QVBkbvKEkQFA2qOzRoyVKnZxz+xNQjyjhEHjxD5DpKxPT7jNQXfK584Je4aQt9efaUZZ/rbnKpB1YMQMxkWu7Rkr3Hq32KeITrDPnBYHPfnq6EpQQjN9KIkg3ld7UpV2Q0ep3I3TsyGvR6A/fjut6BAjrssSStQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zj+xuUeK; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Mar 2025 10:43:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741715024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5ZkBJI6v/5D02kNvu+7gC8a86sGJJTqIcjJAcv0UWE=;
	b=Zj+xuUeKRDkXnT7ete5SA8EufMHTscL1sLsd3kezN8SbIQHDFvHPVbP18P8F6Uqbz3auEm
	iskvvACv/emTa/T76y3BNOy4UNrw65cv6CPJugAEzJcM22US9nxTL54nFJ5jxtNK80QSN8
	88EdRuwBtg4aqCMq58UOYjuGfOLpGa8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: drain obj stock on cpu hotplug teardown
Message-ID: <vr3bx3ahrdk53htnovmliyrr4byezgq6vaxdqpfe7mxj77xknv@qthti7keaqhv>
References: <20250310230934.2913113-1-shakeel.butt@linux.dev>
 <20250311153032.GB1211411@cmpxchg.org>
 <orewawh6kpgrbl4jlvpeancg4s6cyrldlpbqbd7wyjn3xtqy5y@2edkh5ffbnas>
 <Z9Bkn63LE4JRB3x7@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9Bkn63LE4JRB3x7@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 11, 2025 at 04:28:15PM +0000, Roman Gushchin wrote:
[...]
> > 
> > Anyways I wanted a simple fix for the backports and in parallel I am
> > working on cleaning up all the stock functions as I plan to add multi
> > memcg support.
> 
> Really curious to see patches/more details here, I have some ideas here
> as well (nothing materialized yet though).
> 

My eventual goal is to add support for multi memcg stock to solve the
charging cost of incoming networking traffic in multi-tenant
environment. In the cleanups my plan is to reduce the number of irq
disable operations in the most common paths and explore if for task
context we can do without any irq disabling operation (possibly by
separate stocks for in_task and !in_task contexts).

