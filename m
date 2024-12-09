Return-Path: <stable+bounces-100161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 718BC9E9348
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9861885DF3
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D621CFF0;
	Mon,  9 Dec 2024 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gFsLVP1p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92491EB2E;
	Mon,  9 Dec 2024 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745950; cv=none; b=WxrBQIUX2F/SI7D2Ev7ZozJ7WPzDpsj2LAY2nCPAtSV4SoAniEVCKfwDkEtSxIb/8mExgVuwiHBTE+rI/9ju/wbBEczA6msT9mYq/9vwHrr7GoFNHG27gAX4HRzzFKjgikZWalwgRNH40+Gh8TgQTNorlK5C3SZkNOfNRX3gRuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745950; c=relaxed/simple;
	bh=44LiKAAls0MmfGKugZKjB+/2LOUIwjZMjV5s6O3il3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggP/mDFim28VYBYQz7zliNwICBa8eoUH2hesUM1/LPFKckHTgjUE5dnW/L1z6dciO+32aAlYcZA2mzOG6j2rYYnrZXtp/QaTzocVhde65DAf86WOnc8Vve8mHEik8JHfQN8Bnfrm+uOxKD2OwEfxe0l2IobnnD5J3MSEcTWRsT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gFsLVP1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5794C4CED1;
	Mon,  9 Dec 2024 12:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733745947;
	bh=44LiKAAls0MmfGKugZKjB+/2LOUIwjZMjV5s6O3il3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFsLVP1pDF8i/9BYqlFTqksHec3LfSit1gP1Z6+twlswdErOlaKFUaw3zQuYLyBUq
	 yS6LzVlcmNsH55C2svVZyWkzJZj7ZX/lIkJqNVtC0Vfs0ksKp+qYrxUmw6yLWjUu7l
	 WeE83CRPTGVlfpYD+5laTM+NsSBDcbcsjj82ndm0=
Date: Mon, 9 Dec 2024 13:05:39 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH for stable 5.4 v2] usb: dwc3: gadget: fix writing NYET
 threshold
Message-ID: <2024120926-uncolored-lip-b571@gregkh>
References: <20241209-dwc3-nyet-fix-5-4-v2-1-66a67836ae70@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241209-dwc3-nyet-fix-5-4-v2-1-66a67836ae70@linaro.org>

On Mon, Dec 09, 2024 at 11:50:57AM +0000, André Draszik wrote:
> Before writing a new value to the register, the old value needs to be
> masked out for the new value to be programmed as intended, because at
> least in some cases the reset value of that field is 0xf (max value).
> 
> At the moment, the dwc3 core initialises the threshold to the maximum
> value (0xf), with the option to override it via a DT. No upstream DTs
> seem to override it, therefore this commit doesn't change behaviour for
> any upstream platform. Nevertheless, the code should be fixed to have
> the desired outcome.
> 
> Do so.
> 
> Fixes: 80caf7d21adc ("usb: dwc3: add lpm erratum support")
> Cc: stable@vger.kernel.org # 5.4 (needs adjustment for 5.10+)
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
> * has been marked as v2, to be in line with the 5.10+ patch
> * for stable-5.10+, the if() test is slightly different, so a separate
>   patch has been sent for it for the patch to apply.

What is the git id of this in Linus's tree?

thanks,

greg k-h

