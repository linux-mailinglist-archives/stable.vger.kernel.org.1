Return-Path: <stable+bounces-104216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133649F2106
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 22:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31141166A25
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 21:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABE11A76B7;
	Sat, 14 Dec 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ECaYaYhO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F2137E
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734213046; cv=none; b=GraSpkRqMm5/4/0R31ZdBrdONOW+LedHqZpzqOFg63AplL7edBhNZjhcecb6+th6ekDs/jqUTIGtS1/+ek1xj0sUXuUG0ZQkIa6BzTq2QW6MSXWnqTjDBgoMQf2OOrXdNzD25F01bigz7T2zSx1xlYHUgqj7dRsPZ6iIpHsuHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734213046; c=relaxed/simple;
	bh=Ug3Q8SWpNYXz//e/TGN3QtfgzZ4EYV+xoliXuHwqTZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQoqppMBEG1Fyu4W7Iwxa58HodhGYZKrgdt+oca2NMm6Kp4T8GRrcenROKkc7CkEmZDlkT8YMhDVtww1k+ZfbiW7lPJu6TJwMtNSHjNAfgFQO8mSdiECsXhv+CfahBPUKbBpXMfIQktbRSIQReKWIZFuN+z93kFT2QfIHqGLCe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ECaYaYhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00070C4CED1;
	Sat, 14 Dec 2024 21:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734213045;
	bh=Ug3Q8SWpNYXz//e/TGN3QtfgzZ4EYV+xoliXuHwqTZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECaYaYhOvwnfwY4K9HDpaKCi5GM7l+smYwNUr7w9U16HAgl+NrhbNdFWbzeTAnnQD
	 BQvQ2vsvJGx+wnFBkNnvo7ZdlcP6tbZUIH/UVfboagENzJSgt9DSjjXTV0fLI/bDKU
	 onLemTGxKAcudnVGwC16CbSn30acTs7kjcHE+fXI=
Date: Sat, 14 Dec 2024 22:50:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sherry Yang <sherry.yang@oracle.com>, Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.15.y, 5.10.y] exfat: fix potential deadlock on
 __exfat_get_dentry_set
Message-ID: <2024121456-surgery-scenic-7221@gregkh>
References: <20241214091651-0af6196918c18d20@stable.kernel.org>
 <CE0C9579-A635-4702-B8B3-896E3F035044@oracle.com>
 <2024121419-cupcake-fantasy-92dd@gregkh>
 <4a77e8e8-ccf4-4149-9ccc-a33245df4759@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a77e8e8-ccf4-4149-9ccc-a33245df4759@oracle.com>

On Sun, Dec 15, 2024 at 03:11:16AM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 14/12/24 23:36, Greg KH wrote:
> > On Sat, Dec 14, 2024 at 05:57:01PM +0000, Sherry Yang wrote:
> > > Hi,
> > > 
> > > > On Dec 14, 2024, at 6:26 AM, Sasha Levin <sashal@kernel.org> wrote:
> > > > 
> > > > [ Sasha's backport helper bot ]
> > > > 
> > > > Hi,
> > > > 
> > > > The upstream commit SHA1 provided is correct: 89fc548767a2155231128cb98726d6d2ea1256c9
> > > > 
> > > > WARNING: Author mismatch between patch and upstream commit:
> > > > Backport author: Sherry Yang <sherry.yang@oracle.com>
> > > > Commit author: Sungjong Seo <sj1557.seo@samsung.com>
> > > > 
> > > > 
> > > > Status in newer kernel trees:
> > > > 6.12.y | Present (exact SHA1)
> > > > 6.6.y | Present (different SHA1: a7ac198f8dba)
> > > > 6.1.y | Not found
> > > > 5.15.y | Not found
> > > 
> > > I didn’t backport the commit to linux-stable-6.1.y, because 6.1.y didn’t backport the culprit commit
> > > a3ff29a95fde ("exfat: support dynamic allocate bh for exfat_entry_set_cache”), so not influenced.
> > > 
> > > However, both linux-stable-5.15.y and linux-stable-5.10.y actually backported the culprit commit. So I’m trying to fix it on 5.15.y and 5.10.y.
> > > 
> > > Let me know if you have more questions about it.
> > 
> > That's confusing, why doesn't 6.1.y have that commit?  Shouldn't we also
> > add it there along with this one?
> > 
> 
> https://lore.kernel.org/all/20230809103650.353831735@linuxfoundation.org/#t
> 
> Commit a3ff29a95fde ("exfat: support dynamic allocate bh for
> exfat_entry_set_cache”) which is present in 5.10.y and 5.15.y but not in
> 6.1.y is added as a stable-dependency "Stable-dep-of: d42334578eba ("exfat:
> check if filename entries exceeds max filename length") ", but
> this(d42334578eba - filename length check) is present in 6.1.y without
> commit a3ff29a95fde , so probably stable-dep-of is not accurate.
> 
> Given that now we already have a3ff29a95fde ("exfat: support dynamic
> allocate bh for exfat_entry_set_cache”) to 5.15.y and 5.10.y, I think we
> should add it and the fix to 6.1.y as well.
> 
> For 6.1.y here are the upstream commits: (Starting from 1 -- cleanly applies
> and builds fine, haven't done any exfat related testing though.)
> 1. a3ff29a95fde ("exfat: support dynamic allocate bh for
> exfat_entry_set_cache”)
> 2. commit: 89fc548767a2 ("exfat: fix potential deadlock on
> __exfat_get_dentry_set")
> 
> Let me know if you want me to send two patches instead, I can do that.

Yes, please do!

thanks,

greg k-h

