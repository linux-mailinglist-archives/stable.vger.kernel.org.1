Return-Path: <stable+bounces-186249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227C4BE6E43
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 09:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95404241A1
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 07:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C623112BF;
	Fri, 17 Oct 2025 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PlN5iAAV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F7310631;
	Fri, 17 Oct 2025 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684919; cv=none; b=sm28RFfqHHkTmZIhLBOrdncZkWgWh2KbjS9kZYBpyLByvmVUr0JssbyJYMU021k45OXzmTbAgU/IvMmaCpbdoZSxogw9ahFiLevzsll4VkNKM8VFZ6rdl32gOphjyyKMMb6pMH6gOd6VQ5sw5IWJo54R2ehv68lS0VjmcrtD9o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684919; c=relaxed/simple;
	bh=y3A8UFbhIHfnjmL8SSSVLEJdomH+VBXzyz4jFtrYdQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIu2SWq/5coY7X3fe+1kXyrG2kY3CTc0t8VvdWbG5cBv7E18pvVKnLd6tjVQX2v4J92HHVw1SrY+npJLAlXG8tFPhlbYMTe2dqvn+0W8AjDhv71lHEs4Le+lC9iBNiKnA7IHfO/rPSX81vOfJytRGv9Qqis2GXYsv2ZEGysK8W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PlN5iAAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15576C4CEE7;
	Fri, 17 Oct 2025 07:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760684917;
	bh=y3A8UFbhIHfnjmL8SSSVLEJdomH+VBXzyz4jFtrYdQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PlN5iAAVMVKIhf/P///IxkO8IRuSQAvaDa11Iv3qY8HMYbAimhMrR1NLqHqAY5KxX
	 dhIybQEVM9IJ47Fbr+Vq4Gfw1eQii32qEuS3LSO5bgCscGgG6HZYuyBF5xHj5lUTd6
	 vTsXcYn7hEg+3wfq1ZmHYuafEpnzyGM7yGDbU4Gw=
Date: Fri, 17 Oct 2025 09:08:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.4-6.17 0/2] arm64: errata: Apply workarounds for
 Neoverse-V3AE
Message-ID: <2025101708-antsy-steadier-5ab6@gregkh>
References: <20251016111208.3983300-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016111208.3983300-1-ryan.roberts@arm.com>

On Thu, Oct 16, 2025 at 12:12:04PM +0100, Ryan Roberts wrote:
> Hi All,
> 
> This series is a backport intended for all supported stable kernels (5.4-6.17)
> of the recent errata workarounds for Neoverse-V3AE, which were originally posted
> at:
> 
>   https://lore.kernel.org/all/20250919145832.4035534-1-ryan.roberts@arm.com/
> 
> ... and were originally merged upstream in v6.18-rc1.
> 
> I've tested that these patches apply to 5.4-6.12 without issue, but there is a
> trivial conflict to resolve in silicon-errata.rst for it to apply to 6.16 and
> 6.17. Are you happy to deal with that or should I send a separate series?

Please resend a separate series for that, and then resend this series as
well, marked for the specific kernel releases that they are for.

thanks,

greg k-h

