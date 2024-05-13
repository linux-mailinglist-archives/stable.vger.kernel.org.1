Return-Path: <stable+bounces-43622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D808C4152
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EC4281C80
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7720314F9FB;
	Mon, 13 May 2024 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cUPsnSEj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3542B35F0C
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605285; cv=none; b=DKGySxVxg2PhDPpr/bpGJnummVhYrb7myEXRFtWRdM7BCLZGv9/Xgg+fI8XpsfBEOFKcsKB5cd6UKmAKTPjXLX5l9N7z0/T3vR47cwBEsGfdbtOIbBn+VRjLDiFNJp0sVRFryuFEy16VhIoycbsxdVudirIAttmkot8HmQQRJWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605285; c=relaxed/simple;
	bh=6ON4LUEE+Rbq1NLk/ZnRoa6bjMKnWHbZPKy30eOyaNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zbinm2Qj+n3+1h+M4V2/gXceSJR2xpwMOT/XAdB20INBQ1RMVXir+q6wZHZZHAfZ1XHbQdt003lrDkIipk5RfSL7zy26vvUBVwhOR8JPeZksAJPbKMDwa/arxycd6ookd0Ow9dYy9UoATAo5uCH5SHw4ZA7V9hLeKJh4U8ub4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cUPsnSEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A99C32781;
	Mon, 13 May 2024 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715605284;
	bh=6ON4LUEE+Rbq1NLk/ZnRoa6bjMKnWHbZPKy30eOyaNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cUPsnSEjVJBxFIQsIMspZlh2JvZCVN3rGATx/KmhpEUrjBfI+ulfqDnayqL0JhUC9
	 2yrHDJlimdATZy9FcK09pniSvtZgTzr9SO7zc63nOSrZ4NWWTPGlgZsT5uc4AA3FA/
	 hTrcLncPvVJ39z5ohJJWzb2/hAH7YOScppVHtbvY=
Date: Mon, 13 May 2024 15:01:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Elder <elder@linaro.org>
Cc: stable@vger.kernel.org
Subject: Re: Old commit back-port
Message-ID: <2024051337-illusion-cannot-34af@gregkh>
References: <c655924f-7c16-46af-8d1f-e201f82328ad@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c655924f-7c16-46af-8d1f-e201f82328ad@linaro.org>

On Wed, May 01, 2024 at 02:50:05PM -0500, Alex Elder wrote:
> This commit landed in Linux v5.16, and should have been back-ported
> to stable branches:
>   0ac10b291bee8 arm64: dts: qcom: Fix 'interrupt-map' parent address cells
> 
> It has three hunks, and the commit can be cherry-picked directly
> into the 5.15.y and 5.10.y stable branches.  The first hunk fixes
> a problem first introduced in Linux v5.2, so that hunk (only) should
> be back-ported to v5.4.y.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> 
> Is there anything further I need to do?  If you'd prefer I send
> patches, I can do that also (just ask).  Thanks.
> 
> 					-Alex
> 
> 
> Rob's original fix in Linus' tree:
>   0ac10b291bee8 arm64: dts: qcom: Fix 'interrupt-map' parent address cells
> This first landed in v5.16.
> 
> The commit that introduced the problem in the first hunk:
>   b84dfd175c098 arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes
> This first landed in v5.2, so back-port to v5.4.y, v5.10.y, v5.15.y.
> 
> The commit that introduced the problem in the second hunk:
>   5c538e09cb19b arm64: dts: qcom: sdm845: Add first PCIe controller and PHY
> This first landed in v5.7, so back-port to v5.10.y, v5.15.y
> 
> The commit that introduced the problem in the third hunk:
>   42ad231338c14 arm64: dts: qcom: sdm845: Add second PCIe PHY and controller
> This first landed in v5.7 also
> 
> 
> 

I'm confused, I applied this to 5.10.y and 5.15.y now, but it did not
apply to 5.4.y, and I did not understand the "first-third" type comments
about hunks here, sorry.  Can you just provide a working backport for
5.4.y?

thanks,

greg k-h

