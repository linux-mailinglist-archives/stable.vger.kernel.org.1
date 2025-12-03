Return-Path: <stable+bounces-198214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CADC7C9F196
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 14:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 801964E12F3
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EA62DA769;
	Wed,  3 Dec 2025 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D3Ulj++Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223921A444;
	Wed,  3 Dec 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764767786; cv=none; b=mLnOL72IhE6t0ROU3ZoI1bmTytYQ/1WxaA3d4GiHJksQYiwpGipz+Tttbq67wKqGm0O6RSbK7LwwBHtQINa0thfnHCyg9uZ+aBbAd4feeFYUhgAlCav60olRLOCD7muzQicSBcCkPtFt1qmAwhE7g6AT0rYDnu3VPOuSdlbhVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764767786; c=relaxed/simple;
	bh=5Q/Sncw4s+HWoGDkeydHV4aJbl7K9APtQ12f0kpjqa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIv9JChy8gbpCRHBOIWfUbY48GLg56iAxpLvJAVWWlvL4mQYT2KES9jlEr88ZItOmVU9hVHQyvB48He/8Oxj6AydR5PRxGIJSdMv40yQF/GS1BASNyErqdx3DPo6uvzkKJjqEzceIpKNiNd0GTPfNytv4zD5oKVtfZbjr7RY5Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D3Ulj++Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1956AC116B1;
	Wed,  3 Dec 2025 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764767785;
	bh=5Q/Sncw4s+HWoGDkeydHV4aJbl7K9APtQ12f0kpjqa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D3Ulj++QyUVaEXwFe62X7NH0lCAM2n1DligZpsB2DiOoATlXMfc+g6JcGPozoduqy
	 hKd14FfDJ27/pCfWZGp9hcaB0SFj9Ng8FA9YhEvuQjam5YNc+LgA9i8qSPqZpJbxMr
	 F4Z1vMEamBB0sl0drBvm9cJw+aNEvA00l7Ivt97Y=
Date: Wed, 3 Dec 2025 14:16:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: stable@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	alexey.makhalov@broadcom.com, yin.ding@broadcom.com,
	tapas.kundu@broadcom.com
Subject: Re: [PATCH v6.12 0/4] sched: The newidle balance regression
Message-ID: <2025120310-likeness-subscript-f811@gregkh>
References: <20251203112027.1738141-1-ajay.kaher@broadcom.com>
 <CAD2QZ9bGLRL5NyUak-=dDPyTkmrzu-22Q2tURfxUmM9Rs+c72Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD2QZ9bGLRL5NyUak-=dDPyTkmrzu-22Q2tURfxUmM9Rs+c72Q@mail.gmail.com>

On Wed, Dec 03, 2025 at 05:23:05PM +0530, Ajay Kaher wrote:
> Greg, following upstream patches will directly apply to v6.17, so I am
> not sending for v6.17:
> 
> https://github.com/torvalds/linux/commit/d206fbad9328ddb68ebabd7cf7413392acd38081.patch
> https://github.com/torvalds/linux/commit/e78e70dbf603c1425f15f32b455ca148c932f6c1.patch
> https://github.com/torvalds/linux/commit/08d473dd8718e4a4d698b1113a14a40ad64a909b.patch
> https://github.com/torvalds/linux/commit/33cf66d88306663d16e4759e9d24766b0aaa2e17.patch

Please don't use github for kernel stuff....

Anyway, these are not in a -rc kernel yet, so I really shouldn't be
taking them unless the author/maintainer agrees they should go in
"right now".  And given that these weren't even marked as cc: stable in
the first place, why the rush?

Also, you forgot about 6.18.y, right?

thanks,

greg k-h

