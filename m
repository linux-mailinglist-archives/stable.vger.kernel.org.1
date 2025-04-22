Return-Path: <stable+bounces-135098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E40A96832
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE583A544A
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9219027BF7B;
	Tue, 22 Apr 2025 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sPZa1rf6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16920127A
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322708; cv=none; b=qX6NdGa2NDcro4UsaVbvrB4GTeurgbXJjZueouZeh/suA0pXRRxD2m4PEfgOJqAIK4AE5Ww/hTShzN+QgEqsrAj29+3wb1LJxciWaH/gwbeOOYZR/EHHivP7hvP8NZCoHS26rfEduRW7wHsPrPx5NEFfgTRqejZ2/EcoMln51xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322708; c=relaxed/simple;
	bh=8/DHp2YkJdqoctJLBpzq3p8MQOrSyaT2oZsTc1JTuh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LF+Huuz/FVZOSm44pS23IUCbzg0a3fwSjn+P5u7ihKcsDMYl+5c94lEkKjrtgY7nDbD2vV6UyZdAEgHAG0pbAya2tnx6fPfrjwZVxVzEB/kEg0jmfF9ZPSb8haIJ6wMvVwjLnyduAtEpV9oStRT+wwQ4sSVppAC+S8xYn0T9T2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sPZa1rf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6F0C4CEE9;
	Tue, 22 Apr 2025 11:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745322707;
	bh=8/DHp2YkJdqoctJLBpzq3p8MQOrSyaT2oZsTc1JTuh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPZa1rf6KRFpoTAlkop2RJMUiLbScRwXjlmoPlV0xYx7RY0ALYH0GRtMP1ZBqKA/j
	 QtHUs0aFSZBxjoFDofWW7iYuKRd5+YHSlmck2Y56oB55eO00/9Opzp3oNBV887Y3c9
	 w6eXQbHs3sV5LrbhrtcxALUeCtCDgSdqCxbY0NY0=
Date: Tue, 22 Apr 2025 13:51:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 0/3] Preserve the request order in the block layer
Message-ID: <2025042223-subsiding-parka-b064@gregkh>
References: <20250418175401.1936152-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418175401.1936152-1-bvanassche@acm.org>

On Fri, Apr 18, 2025 at 10:53:58AM -0700, Bart Van Assche wrote:
> Hi Greg,
> 
> In kernel v6.10 the zoned storage approach was changed from zoned write
> locking to zone write plugging. Because of this change the block layer
> must preserve the request order. Hence this backport of Christoph's
> "don't reorder requests passed to ->queue_rqs" patch series. Please
> consider this patch series for inclusion in the 6.12 stable kernel.
> 
> See also https://lore.kernel.org/linux-block/20241113152050.157179-1-hch@lst.de/.

You sent this twice, right?  I'll grab this "second" version as I'm
guessing they were the same?

thanks,

greg k-h

