Return-Path: <stable+bounces-132444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF78A87FD8
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88353A54BF
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EAB29C33A;
	Mon, 14 Apr 2025 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EI2XkybK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1BF18DB1E;
	Mon, 14 Apr 2025 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631769; cv=none; b=eAht4MnrsMMRG5qbfj67vIVOc39eoPGPMTOdbfHTdIgkWbP7z8yaMUQ5GU1FBeJiyMEFTkb+zCFHmh/dac2Mpg63ruGQlKSSreHSSjS+Uzo3kkhMeZEEZUNz15G4iyQ6a5atSwbZXSnRDe2aO5XFDyqwd14sHSgeyyLousqdXZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631769; c=relaxed/simple;
	bh=FMWtW+o1uT+r35n5Hb+us7G0Kb9T1gTgVib0b4w3FPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/6zWEwJOW0pQ/4wr2kpVBGsZwiAhwxABvzns7xurXb0zXB/+nKPQHNCxFGuyigSAzqKK8YxwjOR5P9eqa/31/4b0WCjM/NYFeN1E9XY2rwaIZvCRwxraOmsFeTifKitY3BUjz057Z5HRD/wBeg1Q4rw/XLOCxoxCx2DYwxPpAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EI2XkybK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE41FC4CEE2;
	Mon, 14 Apr 2025 11:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744631768;
	bh=FMWtW+o1uT+r35n5Hb+us7G0Kb9T1gTgVib0b4w3FPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EI2XkybKBYF1oZT73oCK8uMk9JiB8UxEgKfaMZ5Xa2mn6u0DnCb0TDR33sO0tqAf1
	 7e2+m5fjvKCdGFV3p3nYqi4KPnsUh5qVr5sGZuXrgBOOeSZZVkdNAIJLhcKtauFxnm
	 ychkYXa0lhXqHkViR65z2PCWc2QrbwOcPOF4Fu+M=
Date: Mon, 14 Apr 2025 13:56:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Patch "x86/mm/ident_map: Fix theoretical virtual address
 overflow to zero" has been added to the 6.14-stable tree
Message-ID: <2025041450-filled-varnish-f9d3@gregkh>
References: <20250414103727.580274-1-sashal@kernel.org>
 <nk543is45cokcdjnnovpopirhqlejfp3xgzs4wdpjyyskumw5w@fbw5bqq3x3mt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nk543is45cokcdjnnovpopirhqlejfp3xgzs4wdpjyyskumw5w@fbw5bqq3x3mt>

On Mon, Apr 14, 2025 at 02:36:55PM +0300, Kirill A. Shutemov wrote:
> On Mon, Apr 14, 2025 at 06:37:27AM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     x86/mm/ident_map: Fix theoretical virtual address overflow to zero
> > 
> > to the 6.14-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      x86-mm-ident_map-fix-theoretical-virtual-address-ove.patch
> > and it can be found in the queue-6.14 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> It was explicitly called out that no backporting needed:
> 
> >     [ Backporter's note: there's no need to backport this patch. ]

Now dropped thanks,

greg k-h

