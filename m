Return-Path: <stable+bounces-192580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E464C39624
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 08:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 466973B6D3E
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 07:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707092E0401;
	Thu,  6 Nov 2025 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jz5G/zQh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44F2E03E3
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413800; cv=none; b=EqOZxCruIeYf4gtIbt+DXO2WpiPqH07UalmuFrDsLjkSZw0prVjODNNzR8G07GIPHfU/6Psda4wvSVDtyo2dl3+1lF27cWX/8IjI5KRdKRoLSGvUzSu6yWVY8wirTR5o6Er0ZRVt+vhCW91yZ8nLaFMMct59A9VUqEm5qbhrwkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413800; c=relaxed/simple;
	bh=Q4smI1xAyCu8g3/jmZ395Lc4HnNYBGcSUEn6FwNiP90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXX+/M4l/EMj5/oQfkO0xVWbPufYqp3m2q+vXd3OwU/d9Ppnojxg+jVTD/FqpBqeYpDzpK17oBduNctJZIwp7GnrVx5BTHFnUl3iaHMc3ZCmeAn67ZNs1d/KClaADv/0e+klAB4rDrdzwA9vqSUg83XYbK2saITwzGDA7mulc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jz5G/zQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA6CC4CEFB;
	Thu,  6 Nov 2025 07:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762413799;
	bh=Q4smI1xAyCu8g3/jmZ395Lc4HnNYBGcSUEn6FwNiP90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jz5G/zQhs99/m8+DWi2sI6QvxdTADgxNvR4HOswKzJ6vc5HVpIFfJfQzJykpLgmDD
	 2eN/ObvDi5b+uKEdo4GZblc0RZWhvIaRlA7V2waHUbT+gTPAnLr1+sC1d+1ToAOV4i
	 uSZDSiglPC0Z/bvNVj8k5qHkNzhu4NLouxLWE2pQ=
Date: Thu, 6 Nov 2025 16:23:16 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Ivan Vera <ivanverasantos@gmail.com>
Cc: git@amd.com, Peter Korsgaard <peter@korsgaard.com>,
	stable@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Ivan Vera <ivan.vera@enclustra.com>
Subject: Re: [PATCH v6.6-LTS] nvmem: zynqmp_nvmem: unbreak driver after
 cleanup
Message-ID: <2025110655-imprecise-baton-f507@gregkh>
References: <20251105123619.18801-1-ivan.vera@enclustra.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105123619.18801-1-ivan.vera@enclustra.com>

On Wed, Nov 05, 2025 at 01:36:19PM +0100, Ivan Vera wrote:
> From: Peter Korsgaard <peter@korsgaard.com>
> 
> Commit 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
> changed the driver to expect the device pointer to be passed as the
> "context", but in nvmem the context parameter comes from nvmem_config.priv
> which is never set - Leading to null pointer exceptions when the device is
> accessed.
> 
> Fixes: 29be47fcd6a0 ("nvmem: zynqmp_nvmem: zynqmp_nvmem_probe cleanup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>
> Reviewed-by: Michal Simek <michal.simek@amd.com>
> Tested-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
> State: upstream (c708bbd57d158d9f20c2fcea5bcb6e0afac77bef)
> (cherry picked from commit 94c91acb3721403501bafcdd041bcd422c5b23c4)

Neither of these git ids are valid, where did you get them from?

thanks,

greg k-h

