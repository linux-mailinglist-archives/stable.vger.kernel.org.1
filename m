Return-Path: <stable+bounces-172454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8924CB31D41
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79057BA49FA
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCC9334385;
	Fri, 22 Aug 2025 14:59:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC562334382;
	Fri, 22 Aug 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874792; cv=none; b=GtadpbxQKJZnAR1nw7THHDrMqWtQqMq4BmP7yzmy8dkvQCYeyscfHDjVO5IlaOoRLi3PqGz8FYEhHAhcUd0Ye77V/D0Yzoo8ECm9ufv01tbfvaDqW5JhXXps6O3cnMXaniUgqTCqN1Z/FnqklcsyMT13RXNxflnMQaB1of/5pGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874792; c=relaxed/simple;
	bh=UpjmrSVz2v3UklwM+ux83+DBGR8x4f1FN2dpxeY57XQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j47/w66uA7qDTln4VXYc43b+vJT1WP78quMJaGEGnC1rtVpyimJhR7i8+1t50kB0yR4iCOdEFLuK4iau6QqZUAHPx70L7tFYH+um5cVdgpqFtA+B8lbHzqspTgIW1qTnFXkK+RAWC8/wYHIingY+56g+wWe041qMLXmy+0yBZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E370FC4CEED;
	Fri, 22 Aug 2025 14:59:51 +0000 (UTC)
Date: Fri, 22 Aug 2025 16:59:49 +0200
From: Greg KH <greg@kroah.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.16 0/9] 6.16.3-rc1 review
Message-ID: <2025082238-playing-empower-69e5@gregkh>
References: <20250822123516.780248736@linuxfoundation.org>
 <20250822144937.GF2771@pc21.mareichelt.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822144937.GF2771@pc21.mareichelt.com>

On Fri, Aug 22, 2025 at 04:49:37PM +0200, Markus Reichelt wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > This is the start of the stable review cycle for the 6.16.3 release.
> > There are 9 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> Hi Greg
> 
> 6.16.3-rc1 compiles on x86_64 (Xeon E5-1620 v2, Slackware64-15.0),
> and boots & runs on x86_64 (AMD Ryzen 5 7520U, Slackware64-current).
> 
> No regressions observed, apart from the one already mentioned for
> 6.16.2-rc1.
> Thus I tested 6.16.3-rc1 with V3 of the patch and it seems to work ok:
> https://lore.kernel.org/stable/20250821105806.1453833-1-wangzijie1@honor.com/

Yeah, that one needs to get into Linus's tree, hopefully soon...

