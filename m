Return-Path: <stable+bounces-192586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8A6C39AA3
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 09:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E0BC4F05FB
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 08:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E4E3090CC;
	Thu,  6 Nov 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XTvvrpoR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C245D308F35
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 08:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419111; cv=none; b=higTbEqYre5+yOaZO9/L1y9gfoTanere0Wvt14mlZcUxf++Q7LQnlMEmUDzAuuctmyNzWgzM65pq6sbxv3aMcK4YX2Y+rlQSUS8lkj0K8el48dW9sYJUMWD9EXkxuS68AZBYPWY88ORPB4HhvSohZM4uAHdTRMfyBLi3eSjoHh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419111; c=relaxed/simple;
	bh=zK0S99FPFCi/S/L36RVIQVUHv+WlGVV/PTMs0K2j/D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJJPXQdPtY29rEumX/7AFT0fg322WywjtaLNaXDihDcPFULUsS8f71vOhwyFdRz+jDnhK4sfKUZwRfpv2QSIHtIWHt6ojP/PNYQYJF55S7CvxGGAghzdL3r9K9IB+X2Ehki34D9AgXu466+n/IRD8By+nZ22itK2w4c3wQ8DvLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XTvvrpoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8270DC4CEF7;
	Thu,  6 Nov 2025 08:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762419111;
	bh=zK0S99FPFCi/S/L36RVIQVUHv+WlGVV/PTMs0K2j/D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTvvrpoRIcWjCsIipzVGxsnrS9JaazgOO7cSUmJ7Pr9cZTXWw14uoXVkM4xaxUfIf
	 FAlpIXYfOk0xaAfQdVPL8GmoPFvrizlKLNMuuD5D2NgsCu1bcCz4UbJWGhiJz6AGYy
	 1IHfLdu9NWe1GENJk+IPz2CBVL9e2M7PVzEbl/qw=
Date: Thu, 6 Nov 2025 17:51:47 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Peter Korsgaard <peter@korsgaard.com>
Cc: Ivan Vera <ivanverasantos@gmail.com>, git@amd.com,
	stable@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Ivan Vera <ivan.vera@enclustra.com>
Subject: Re: [PATCH v6.6-LTS] nvmem: zynqmp_nvmem: unbreak driver after
 cleanup
Message-ID: <2025110624-huskiness-viewless-50fd@gregkh>
References: <20251105123619.18801-1-ivan.vera@enclustra.com>
 <2025110655-imprecise-baton-f507@gregkh>
 <87frar7gqz.fsf@dell.be.48ers.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frar7gqz.fsf@dell.be.48ers.dk>

On Thu, Nov 06, 2025 at 08:38:28AM +0100, Peter Korsgaard wrote:
> >>>>> "Greg" == Greg KH <gregkh@linuxfoundation.org> writes:
> 
>  > On Wed, Nov 05, 2025 at 01:36:19PM +0100, Ivan Vera wrote:
>  >> From: Peter Korsgaard <peter@korsgaard.com>
>  >> 
>  >> Commit 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
>  >> changed the driver to expect the device pointer to be passed as the
>  >> "context", but in nvmem the context parameter comes from nvmem_config.priv
>  >> which is never set - Leading to null pointer exceptions when the device is
>  >> accessed.
>  >> 
>  >> Fixes: 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
>  >> Cc: stable@vger.kernel.org
>  >> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
>  >> Reviewed-by: Michal Simek <michal.simek@amd.com>
>  >> Tested-by: Michal Simek <michal.simek@amd.com>
>  >> Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
>  >> State: upstream (c708bbd57d158d9f20c2fcea5bcb6e0afac77bef)
>  >> (cherry picked from commit 94c91acb3721403501bafcdd041bcd422c5b23c4)
> 
>  > Neither of these git ids are valid, where did you get them from?
> 
> git describe --contains c708bbd57d158d9f20c2fcea5bcb6e0afac77bef
> next-20250505~21^2~1^2
> 
> I guess it should have been fe8abdd175d7b547ae1a612757e7902bcd62e9cf
> instead, E.G. what ended up in master?

We can't take stuff in stable unless it is in Linus's tree.

thanks,

greg k-h

