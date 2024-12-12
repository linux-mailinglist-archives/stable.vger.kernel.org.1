Return-Path: <stable+bounces-103894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C15A79EF999
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EAA287585
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8AA223711;
	Thu, 12 Dec 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KPhjBwDk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14539223E60;
	Thu, 12 Dec 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025920; cv=none; b=NQK5bOM4LWesxyq2Th8f1PXbYOy4OWVGY3Kan51kwuPwQrCpJtnvRonI7/zk7BXt+SCzCdDcEOydhb161kF3lWIWA4qFHrKgC5TG2dS7hCWmNXd3bLhR7czjTO3GhSySNPUJFotJ/6r8ingocGZpzo0yyJzPACbUBLH3ceErReY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025920; c=relaxed/simple;
	bh=zFNmZLEv3s2UoaHFYRmHKXkQIJYcRZ1oOSynagA3kAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mr9IfkpIirK5D6vEAgv0UHUPApzYrY2wDNLzGqegsJFJk+P3F3p3b9eVsgY6Tahw/gBBz0clxatzVqpFd5ll2ZJZY13380nnu6qaL7UcayQxbC0AFcb4s9GNhKqkpDQiY1PwZlZH9oFMfvy4EVenudvhaBiqjTcnc6TSdYI85A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KPhjBwDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F7FC4CECE;
	Thu, 12 Dec 2024 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025919;
	bh=zFNmZLEv3s2UoaHFYRmHKXkQIJYcRZ1oOSynagA3kAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPhjBwDkpvbkecFAw0ge8tKI4hoYMr3QXB3qmtzqFOJWVcI4t1ITo50MSXDDuxBM8
	 c/c7rdhbtFF3obHzlZf5FRWtvGM/tPsbyf8tO4Hao3wREqgmrE4FKHK7tfvVihAC7/
	 t6TLp5jzPuGBSh1gxFVBso2OPa6si7zHtilEwSZM=
Date: Thu, 12 Dec 2024 16:17:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: cve@kernel.org, jianqi.ren.cn@windriver.com, stable@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	sashal@kernel.org, jamie.bainbridge@gmail.com, jdamato@fastly.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] net: napi: Prevent overflow of napi_defer_hard_irqs
Message-ID: <2024121246-phrase-dynamite-356d@gregkh>
References: <20241211040304.3212711-1-jianqi.ren.cn@windriver.com>
 <2024121250-preschool-napping-502e@gregkh>
 <20241212065044.09d7b377@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212065044.09d7b377@kernel.org>

On Thu, Dec 12, 2024 at 06:50:44AM -0800, Jakub Kicinski wrote:
> On Thu, 12 Dec 2024 12:41:08 +0100 Greg KH wrote:
> > On Wed, Dec 11, 2024 at 12:03:04PM +0800, jianqi.ren.cn@windriver.com wrote:
> > > From: Joe Damato <jdamato@fastly.com>
> > > 
> > > [ Upstream commit 08062af0a52107a243f7608fd972edb54ca5b7f8 ]  
> > 
> > You can't ignore the 6.6.y tree :(
> > 
> > Dropping from my review queue now.
> 
> Is it possible to instead mark CVE-2024-50018 as invalid, please?
> The change is cosmetic.

Now rejected, sorry about that.

greg k-h

