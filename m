Return-Path: <stable+bounces-78631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F7998D101
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89271C2172B
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933511CEE98;
	Wed,  2 Oct 2024 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X7/lvJOd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8C1642B
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864203; cv=none; b=rLEwEkh9CNZkj3/ztXv9YOlD7pPa5NKVUw97qsdBNLbzre5/OEWZklsZofSvPXjCCfkm8Msl118f1Aa1f98QUgb1ADO9BkfrkkWOn0UZnVgoY1E+04b+WHR3IEw5JsDLDIJdD+Ckk1a4siNjl97xL3T7AqReQuoQDxoo9t+vA64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864203; c=relaxed/simple;
	bh=TP6VPhzY+A3o52hd+maO0eWny0bfWHY3ndX/tyI+4xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3zX8SxKeoUbAeo0pLUGexDTVHhLTmFPqdwlG0Nz8Cehv9lB5b0vtqWtb4hm4BwWoCB9wnWaEGeCV0WCkUoItRwCO99e/E7dAUjACwJoHn/7SUZSEPSooZL1KIMzryX4V5nvHW7ZtgCFs8SOcgvbvzQUqRUtGP1hjMEjD8FwzPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X7/lvJOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95344C4CEC5;
	Wed,  2 Oct 2024 10:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727864203;
	bh=TP6VPhzY+A3o52hd+maO0eWny0bfWHY3ndX/tyI+4xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X7/lvJOdb78rh4LE2WfBlrlynJsMCwPjaLixSsFOkbhEoIbILmqaARzjOeZ6FxetU
	 ms1XuEEbVPhU+5K56SuSXeCtjGKYHJnEixV15+/vFozdYjV60Wij8GU5e/EJyb1trr
	 JJQ5MoJ0aGASR5mo851JmzBrbDPdj+yZb3sFu0Uw=
Date: Wed, 2 Oct 2024 12:16:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Georg =?iso-8859-1?Q?M=FCller?= <georgmueller@gmx.net>
Cc: stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: Stable request: wifi: mt76: do not run mt76_unregister_device()
 on unregistered hw
Message-ID: <2024100221-flight-whenever-eedb@gregkh>
References: <f520eda3-0831-4590-b337-3bfd85096922@gmx.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f520eda3-0831-4590-b337-3bfd85096922@gmx.net>

On Wed, Oct 02, 2024 at 11:55:52AM +0200, Georg Müller wrote:
> commit 41130c32f3a18fcc930316da17f3a5f3bc326aa1 upstream
> 
> This was not marked as stable (but has a Fixes: tag), but causes the USB stack
> to crash with 6.1.x kernels.
> 
> The patch does not apply when cherry-picking because of the context.
> Should I send the patch again with updated context so that it applies without
> conflicts?

Yes, please submit a working, tested, patch and we will be glad to apply
it.

thanks,

greg k-h

