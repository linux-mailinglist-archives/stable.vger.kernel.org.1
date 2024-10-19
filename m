Return-Path: <stable+bounces-86894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FA59A4B8C
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 08:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AC11C21FE7
	for <lists+stable@lfdr.de>; Sat, 19 Oct 2024 06:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE60A1DA2E0;
	Sat, 19 Oct 2024 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="snMSzj0X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFE918C910;
	Sat, 19 Oct 2024 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729319672; cv=none; b=R9ba6DHKHCksD7fdMMs9OIgeeRfG6HzyZDDIyS3FzkuIRdJJumhe8NnHq/Fg5U6LEj+sWmekuJlgLVmdYFlEt6NaamY05wCAv2/RGRBuycARLHTqSjW3LCPBRu8/rkV5FGonchsJQbgr+5cfZGp15+fwme7b0gFLowlb0eO8sYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729319672; c=relaxed/simple;
	bh=wY92Dl0LL/ot+1HeSKZlAYBEs7Oo6C1rY3KydewsF5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUyMBWfIso3htNHt7aRs80vtqYdq4yPZTGdCbS4JquDSZ028LD1p97IQDNP+QjV2x2znijDKIoP80DVUKsiN1C8oDHP5fbQ7puqV3BxTSL33/febjkOagX08g3ELURLmt5u6x4jyl8XpovBtxsdEq3EvpJlaVN9CxoiwnmAWhCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=snMSzj0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E60C4CEC5;
	Sat, 19 Oct 2024 06:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729319672;
	bh=wY92Dl0LL/ot+1HeSKZlAYBEs7Oo6C1rY3KydewsF5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snMSzj0Xzu0wcdhjyqt9aOP4+FOkYalz496NNz1W8wDi25EzkKL/ScOrRu1scO5DE
	 W/sl0AEqQJCCKoFFlHQSnduGPBwkUlKcLWuivY50NvP4KoYnkYEMLPsdtRBJ2KCEhg
	 ZCRLPxZdkoDV56++hiTtwRTKbt8jIxgUYgaC6xKY=
Date: Sat, 19 Oct 2024 08:34:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Faisal Hassan <quic_faisalh@quicinc.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] xhci: Fix Link TRB DMA in command ring stopped
 completion event
Message-ID: <2024101914-upheld-dander-d1af@gregkh>
References: <20241018195953.12315-1-quic_faisalh@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018195953.12315-1-quic_faisalh@quicinc.com>

On Sat, Oct 19, 2024 at 01:29:53AM +0530, Faisal Hassan wrote:
> During the aborting of a command, the software receives a command
> completion event for the command ring stopped, with the TRB pointing
> to the next TRB after the aborted command.
> 
> If the command we abort is located just before the Link TRB in the
> command ring, then during the 'command ring stopped' completion event,
> the xHC gives the Link TRB in the event's cmd DMA, which causes a
> mismatch in handling command completion event.
> 
> To handle this situation, an additional check has been added to ignore
> the mismatch error and continue the operation.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Faisal Hassan <quic_faisalh@quicinc.com>

What commit id does this fix?

thanks,

greg k-h

