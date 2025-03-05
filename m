Return-Path: <stable+bounces-120441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDE2A5017B
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 15:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3D33A83A6
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 14:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDA424A076;
	Wed,  5 Mar 2025 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="URx8cpxt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2946C24A05D
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183788; cv=none; b=g0HrbOuLNnt+6eS9tJ1GLhnhZ74mK7C28dq9G9RoaPHwKnKJqbeCexIy8JGO4cYRO0KRFNDEs/3sc6zG7vBJnOp779+YQ4pnxyvGsNS/wqtPvCtEeN466PJP5D41qg5QhDKjf4gMlX4qHc1yLduzb26nfIZ5uVOEtxyYguEpfg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183788; c=relaxed/simple;
	bh=j1y6A2Q2EaSQYbKNYkM4i+/qmrLcGUyuLIMAiLnvL50=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSZXKurcpRsSWjW5BmGJIYiLSfXNREL8KiY6y8pdflKPgG1R6p7kcEhGDqcIXzh2SiQ34tWiVnGvAlteMSieinELB8cOCzoeT+7uM5+nwkXxNAexzaN7r/b/Nk7YGjGVjjHD2cdK2ACwThVaseVa6wq+OwzKM6GGizR0yku4sdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=URx8cpxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C202C4CED1;
	Wed,  5 Mar 2025 14:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741183787;
	bh=j1y6A2Q2EaSQYbKNYkM4i+/qmrLcGUyuLIMAiLnvL50=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=URx8cpxtoctLl7PH5NEg2r63eRVjB3TQC82gcy+f4Spu4p6uqvIThSHRqH2NSIIQW
	 LbhMzaFovadpHz5dLW83v8EYbfCwvPE1Y0YvR6E9Cj/ID/3k4f2h20o3FTQjgjRfcy
	 NJWZMgYJPJIWBLrSh/icthXM5cMEPoynw/eTIs+A=
Date: Wed, 5 Mar 2025 15:09:44 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
	Sergei Golovan <sgolovan@debian.org>, 1087809@bugs.debian.org,
	1086028@bugs.debian.org, 1093200@bugs.debian.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	debian-mips@lists.debian.org, Ben Hutchings <benh@debian.org>
Subject: Re: Please apply 8fa507083388 ("mm/memory: Use exception ip to
 search exception tables") (and one required dependency) to v6.1.y
Message-ID: <2025030537-chance-swizzle-3678@gregkh>
References: <Z79tTfjD-rCIa6EV@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z79tTfjD-rCIa6EV@eldamar.lan>

On Wed, Feb 26, 2025 at 08:36:45PM +0100, Salvatore Bonaccorso wrote:
> Hi Greg, hi Sasha
> 
> A while back the following regression after 4bce37a68ff8 ("mips/mm:
> Convert to using lock_mm_and_find_vma()") was reported:
> https://lore.kernel.org/all/75e9fd7b08562ad9b456a5bdaacb7cc220311cc9.camel@xry111.site/
> affecting mips64el. This was later on fixed by 8fa507083388
> ("mm/memory: Use exception ip to search exception tables") in 6.8-rc5
> and which got backported to 6.7.6 and 6.6.18.
> 
> The breaking commit was part of a series covering a security fix
> (CVE-2023-3269), and landed in 6.5-rc1 and backported to 6.4.1, 6.3.11
> and 6.1.37.
> 
> So far 6.1.y remained unfixed and in fact in Debian we got reports
> about this issue seen on the build infrastructure when building
> various packages, details are in:
> https://bugs.debian.org/1086028
> https://bugs.debian.org/1087809
> https://bugs.debian.org/1093200
> 
> The fix probably did not got backported as there is one dependency
> missing which was not CC'ed for stable afaics.
> 
> Thus, can you please cherry-pick the following two commits please as
> well for 6.1.y?
> 
> 11ba1728be3e ("ptrace: Introduce exception_ip arch hook")
> 8fa507083388 ("mm/memory: Use exception ip to search exception tables")
> 
> Sergei Golovan confirmed as well by testing that this fixes the seen
> issue as well in 6.1.y, cf. https://bugs.debian.org/1086028#95
> 
> Thanks in advance already.

Now queued up, thanks.

greg k-h

