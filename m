Return-Path: <stable+bounces-26960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80762873820
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 14:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F611F220A5
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 13:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA26130E57;
	Wed,  6 Mar 2024 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A39kwWOI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F231E519
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709733098; cv=none; b=fCLqX5E7n5foN50JzRqetBuCLP2k65zmgleowUbe24iOf1iMUygbBH6a8G9PJsKry1cYrWtOlUp98xXkme6hwhV6PgmPtRO0jrwVu/ao/Z5628IDdtX9g5ABKxK0unETdvU61CInpVPQombyRVHORRZGkg4A9PiFY/FDIa0yIvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709733098; c=relaxed/simple;
	bh=aiFjeCBLulfJTYlTDxGvoYCYsPSgBsu9exnZA8T53gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXcytXWNDdR2hiPk6ZJcr2ryffANaWPPOLVTwU874mHPmEpFb1UFggYLdG2y+TZ0Zyrs6rHXsa0fXwQdM76XWXfx/rsqVfdurtHVXmOzaRt3Q/dXzbeXWGW4Kx4v46u+EgSM4WjUlHPMUfkz7V2mx2wXE4uEsv8DNSkGHeK/hEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A39kwWOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10904C433F1;
	Wed,  6 Mar 2024 13:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709733097;
	bh=aiFjeCBLulfJTYlTDxGvoYCYsPSgBsu9exnZA8T53gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A39kwWOIlN1tTvGMCgnNtPrPW9Fv6IcBNiZI2hvUTXJozcUFomlewZYJGyyyLxKnS
	 zJlSqf8PwyNHfST8+bRmJnmXjKVrSqXglYebU+JW24pES/McMZq7mbvRhlaLS0Iixp
	 he8weUxWetwiKKdKoVewjeqPWSSPVwr0QcrwXoiE=
Date: Wed, 6 Mar 2024 13:51:34 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, stable@vger.kernel.org,
	linux-mm@kvack.org, Charan Teja Kalla <quic_charante@quicinc.com>,
	"\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: Re: [PATCH STABLE v6.1.y] mm/migrate: set swap entry values of THP
 tail pages properly.
Message-ID: <2024030649-utilize-budding-380d@gregkh>
References: <20240305161313.90954-1-zi.yan@sent.com>
 <2024030506-quotable-kerosene-6820@gregkh>
 <0910e8f0-5490-4d08-ac64-da4077a1e703@redhat.com>
 <2024030527-footrest-cathedral-5e15@gregkh>
 <075777FD-8EA9-446F-A52C-96AF43170EA7@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <075777FD-8EA9-446F-A52C-96AF43170EA7@nvidia.com>

On Tue, Mar 05, 2024 at 06:13:39PM -0500, Zi Yan wrote:
> On 5 Mar 2024, at 17:32, Greg KH wrote:
> 
> > On Tue, Mar 05, 2024 at 11:09:17PM +0100, David Hildenbrand wrote:
> >> On 05.03.24 23:04, Greg KH wrote:
> >>> On Tue, Mar 05, 2024 at 11:13:13AM -0500, Zi Yan wrote:
> >>>> From: Zi Yan <ziy@nvidia.com>
> >>>>
> >>>> The tail pages in a THP can have swap entry information stored in their
> >>>> private field. When migrating to a new page, all tail pages of the new
> >>>> page need to update ->private to avoid future data corruption.
> >>>>
> >>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >>>> ---
> >>>>   mm/migrate.c | 6 +++++-
> >>>>   1 file changed, 5 insertions(+), 1 deletion(-)
> >>>
> >>> What is the git commit id of this change in Linus's tree?
> >>
> >> Unfortunately, we had to do stable-only versions, because the backport
> >> of the "accidental" fix that removes the per-subpage "private" information
> >> would be non-trivial, especially for pre-folio-converison times.
> >>
> >> The accidental fix is
> >>
> >> 07e09c483cbef2a252f75d95670755a0607288f5
> >
> > None of that is obvious at all here, we need loads of documentation in
> > the changelog text that says all of that please.
> 
> How about?
> 
> Before 07e09c483cbe ("mm/huge_memory: work on folio->swap instead of
> page->private when splitting folio"), when a THP is added into swapcache,
> each of its subpages has its own swapcache entry and need ->private pointing
> to the right swapcache entry. THP added to swapcache function is added in
> 38d8b4e6bdc87 ("mm, THP, swap: delay splitting THP during swap out").
> When THP migration was added in 616b8371539a6 ("mm: thp: enable thp migration in generic path"), it did not take care of swapcached THP's subpages,
> neither updated subpage's ->private nor replaced subpage pointer in
> the swapcache. Later, e71769ae5260 ("mm: enable thp migration for shmem thp")
> fixed swapcache update part. Now this patch fixes the subpage ->private
> update part.

That's better than what is there now :)

So yes, please resend all of these with the new text and then we can
queue them up.

thanks,

greg k-h

