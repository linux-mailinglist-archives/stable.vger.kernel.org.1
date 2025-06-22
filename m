Return-Path: <stable+bounces-155239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B57BAE2EDD
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 10:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A164B172CB8
	for <lists+stable@lfdr.de>; Sun, 22 Jun 2025 08:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFFD190498;
	Sun, 22 Jun 2025 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fo3LkfxZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41E23597E
	for <stable@vger.kernel.org>; Sun, 22 Jun 2025 08:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750581340; cv=none; b=jCV5mKOSqqebOEjdFeq3AddCmedMi9WVa0LAVNH55pDLDFkQdbKPCJM0/y25HLZReBwfTkME10Wlec8U9TXjd2TqxNBt3qCkxsZWmbTzH4OJjQR+7IZenY0BGK20FI8eAloLk9cPqfYRpUYxE1Do1RqMbSNKPZRHLf8Wfk1rRa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750581340; c=relaxed/simple;
	bh=8H3ki6n3RJLYYDG2gYPYC+2e3PYZsje8Nwi2pou0264=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q17kKgg97Ti8kWOgVHPH1DwybVg92TiA7ga58SJ0RQhPhqAvfzl55XEXTUe+DGnP23xg/Yw9m2PB2Fw3DJblCp8Ky9gPwry2kCaS/bn0KJcY7ieoJ4B3HeQFxYwRuhncnF4F2LfvAsa+32i9B9FWvujRVA/WZJU7uri8E0LTkZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fo3LkfxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09304C4CEE3;
	Sun, 22 Jun 2025 08:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750581336;
	bh=8H3ki6n3RJLYYDG2gYPYC+2e3PYZsje8Nwi2pou0264=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fo3LkfxZ+uRYm+Uioe/y+/lCqZDDiE6hTu5Akyo+AaRtQ77tIuM6ykWmpfHqIJMnn
	 6jyoYNobd/deoWhdjz3KgP20lzcVJYpB22swTBYC0tlSm1Ix4HJ+BUXExjHyjeYS/6
	 aWEqvE6dZA88qcdwRGtMn2rsByL0OIpRU/bKVHlk=
Date: Sun, 22 Jun 2025 10:35:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	tavip@google.com, edumazet@google.com
Subject: Re: [PATCH 5.15.y 0/5] Backport few sfq fixes
Message-ID: <2025062204-battered-appeasing-617e@gregkh>
References: <20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com>
 <9ddde997-df26-41d8-b51d-90572eb2c9dc@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ddde997-df26-41d8-b51d-90572eb2c9dc@oracle.com>

On Sat, Jun 21, 2025 at 11:30:36PM +0530, Harshit Mogalapalli wrote:
> Hi stable maintainers,
> 
> 
> On 15/06/25 20:54, Harshit Mogalapalli wrote:
> > commit: 10685681bafc ("net_sched: sch_sfq: don't allow 1 packet limit")
> > fixes CVE-2024-57996 and commit: b3bf8f63e617 ("net_sched: sch_sfq: move
> > the limit validation") fixes CVE-2025-37752.
> > 
> 
> Ping on this patch series:
> 5.15.y: https://lore.kernel.org/all/20250615152427.1364822-1-harshit.m.mogalapalli@oracle.com/
> - [1]
> 
> 5.10.y: https://lore.kernel.org/all/20250615175153.1610731-1-harshit.m.mogalapalli@oracle.com/
> 
> But looks like Eric sent these 5 recently as a part of a 7 patch series to
> 5.15.y here:
> https://lore.kernel.org/all/20250620154623.331294-1-edumazet@google.com/
> 
> 
> Just to avoid any confusion adding context here. I feel like Eric's patch
> series is better as it includes two more new fixes than my series while the
> first 5 backports are exactly same.

I'll take Eric's patches.  Should we also drop your 5.10 series or go
with them for that tree instead?

thanks,

greg k-h

