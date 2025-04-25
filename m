Return-Path: <stable+bounces-136666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF59A9C080
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622BE3AFA17
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 08:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5686122F76B;
	Fri, 25 Apr 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0uOxWEh0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06953635
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568671; cv=none; b=EbBDTqGOVLM1hid7jZpRaeweog54zzzs57VVP/JMz/6uJlrz7s9aJfltKh779iR/Ew33QjccGcnhPRjbtTPZQpttcBgh7OBm4hUjJn1z+HrW7CaDKu3/u/2VV1tQRDIsXpMF5uehCeSDmMQbzfMhxbYRkjbBRhLcJz02HJP1YQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568671; c=relaxed/simple;
	bh=ZKQNZwWBsSxCtnlvJXQh+UL77LyzNvGwXC6khUsRyzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUsE9gcgKnPsdApD+CW60eXahYgpbtSGFE3XZAevOlhLFrA5TOuFti7S5ZF2RaBpehGVUTcqopyYneX5XSly9typp1a9wOOb1HCBt9IzdKlj4g15tfJ/u+W3IIFTYXNjZAUpBDuQZ+86JnyAAFWECHMt1lN1CBCe2xDplHdi2cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0uOxWEh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B6BC4CEEA;
	Fri, 25 Apr 2025 08:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745568670;
	bh=ZKQNZwWBsSxCtnlvJXQh+UL77LyzNvGwXC6khUsRyzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0uOxWEh0wJv6V7vI4ARgMoVZUCTL7A/BXhYsMDQhptwwk89IMjNouX0jS9oM0UcGE
	 9d2aeuQKwcexd4igPZldN2KeSLS3IL1xAfcy52k3PKo3hQtD0JCm5DB4E67Z6K0Xfd
	 K8M1FSZGJ98AS1x6hGhsUrJT5XdHtaB5cTbGG7Hw=
Date: Fri, 25 Apr 2025 10:11:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, peter.ujfalusi@ti.com, vkoul@kernel.org,
	Chuhong Yuan <hslester96@gmail.com>
Subject: Re: [PATCH 2/3 v5.4.y] dmaengine: ti: edma: add missed operations
Message-ID: <2025042501-morale-helpful-95e4@gregkh>
References: <2025042315-tamer-gaffe-8de0@gregkh>
 <20250424060634.50722-1-hgohil@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424060634.50722-1-hgohil@mvista.com>

On Thu, Apr 24, 2025 at 06:06:33AM +0000, Hardik Gohil wrote:
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
> Signed-off-by: Hardik Gohil <hgohil@mvista.com>
> ---
>  drivers/dma/ti/edma.c | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)

No upstream git id?

