Return-Path: <stable+bounces-135152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97BA9724B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 18:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DFB9176C3C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448902949F3;
	Tue, 22 Apr 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2C4lA0fQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4275293B72
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338495; cv=none; b=aQ/zdb0kpqa3p23C2VPWz6Yv7nN8fEAIOHGaDep3oT6GLxmWnaPjeEpVOJ2ux5E5G88yEjGGaaVJNff1xX1roRS0j+x6CaNHtgWljuCtMrqeGg9ZVczIJudnA6dmvivLS2qopFbJWTHfn7Vd7Z0bMz1WaVrjNW2rfoFglIxNlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338495; c=relaxed/simple;
	bh=GUidbDDv4YnBsKiICbH9Tp2Asbk4f3O+KDXl4QotSDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bphGnmZJvMxTZW38oZInR1xfYv39XIlvwHmEiP8vlHHmbiPdMLMJOnt7XhKRE7JF6HEeSIxjnmh/JjxLcaE2xZ2oheKQp02yYdNlzqKA61qbKccW4NnoEw4Crls97LTCOqrxtqUZHQRvgwRNye+X2Gc4+spyeUdgbWJEFZCxYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2C4lA0fQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED4DC4CEF7;
	Tue, 22 Apr 2025 16:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745338495;
	bh=GUidbDDv4YnBsKiICbH9Tp2Asbk4f3O+KDXl4QotSDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2C4lA0fQG7rj6bC3nsq/68VV+4XtIV1B6Tp6pnpiOK72MyOIDzRmvSdlYadHQgKu6
	 oOhxXqI2kmEbK1CJCWYmx45kS7scFu+yObrx49tJPt7uO4SlEFxWRx1rbzcUoDvNZ8
	 nwF5loCK0EUqgntVP8r4AWhZj73QEPozDT55/nLc=
Date: Tue, 22 Apr 2025 18:14:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, peter.ujfalusi@ti.com, vkoul@kernel.org,
	Chuhong Yuan <hslester96@gmail.com>
Subject: Re: [PATCH 2/3 v5.4.y] dmaengine: ti: edma: add missed operations
Message-ID: <2025042253-pajamas-deprive-e058@gregkh>
References: <2025042230-equation-mule-2f3d@gregkh>
 <20250422151709.26646-1-hgohil@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422151709.26646-1-hgohil@mvista.com>

On Tue, Apr 22, 2025 at 03:17:08PM +0000, Hardik Gohil wrote:
> From: Chuhong Yuan <hslester96@gmail.com>
> 
> The driver forgets to call pm_runtime_disable and pm_runtime_put_sync in
> probe failure and remove.
> Add the calls and modify probe failure handling to fix it.
> 
> To simplify the fix, the patch adjusts the calling order and merges checks
> for devm_kcalloc.
> 
> Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Link: https://lore.kernel.org/r/20191124052855.6472-1-hslester96@gmail.com
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Why did you not sign off on this?

And where is patch 1/3?

Please take a pause, and redo this after testing that you have it
correct locally, before sending it out again.

Also, properly version your patch series.

thanks,

greg k-h

