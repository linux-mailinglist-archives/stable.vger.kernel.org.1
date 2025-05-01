Return-Path: <stable+bounces-139316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 783A2AA60CF
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387883BA995
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB4A1F4C90;
	Thu,  1 May 2025 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cb75BCo/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8518C011;
	Thu,  1 May 2025 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746113824; cv=none; b=f5S1bAOr5zo4xDLZRhGqrY0iO1fzVIC53TtCElzSLrcueO3fGuF4YGtOratyxYfgikf4xEOFN4fx4fEVetwYG8h8UCOMAHYCUv0Vj2YtA55AP6e+r2bLzwNlkbIWK8af6E+VMxh0qF756KmZlWsOUMKtca9U56vp9emXiM+94fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746113824; c=relaxed/simple;
	bh=cmR2HZvWWbjN4vgXaQS/6TxoTDS4aFO2IW+vqZLr+ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5nn9N988zaLMwA6YPdzY5l0iOvqkXepWg47/3/68voFKvqSReHyr6hCpmPcrKwHobem2pVbkaKe3S/MiwOXaSlI/LuMFLikfKi/gnz8Ju9llwh+o5j0t9GYZ6jIiSfi3MZiIagijhxBCPOsaUyF/z2erFCs7DDdutch9x53l3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cb75BCo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DDDC4CEED;
	Thu,  1 May 2025 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746113824;
	bh=cmR2HZvWWbjN4vgXaQS/6TxoTDS4aFO2IW+vqZLr+ZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cb75BCo/UkfXkPrrygBxb3F+wIHkObt/ILrhJXUh6hqaYLEELC4sw/rQmo3FmlsTE
	 qpYnGvnrhu1+OYkh25NajRiQCUzmcsoKZykMefplUyv3QK13SVXHnpyFEFUxgcXT2a
	 Ug6GtpBV6ZY4E0EVWLOKm9th85w66UP9PlMtvODE=
Date: Thu, 1 May 2025 17:36:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	John Youn <John.Youn@synopsys.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc2: gadget: Fix enter to hibernation for UTMI+
 PHY
Message-ID: <2025050138-attempt-skewer-726d@gregkh>
References: <8bacf7428d29d7fc2e5a94e5931f12d7df60c732.1745312619.git.Minas.Harutyunyan@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bacf7428d29d7fc2e5a94e5931f12d7df60c732.1745312619.git.Minas.Harutyunyan@synopsys.com>

On Tue, Apr 22, 2025 at 09:16:52AM +0000, Minas Harutyunyan wrote:
> For UTMI+ PHY, according to programming guide, first should be set
> PMUACTV bit then STOPPCLK bit. Otherwise, when the device issues
> Remote Wakeup, then host notices disconnect instead.
> For ULPI PHY, above mentioned bits must be set in reversed order:
> STOPPCLK then PMUACTV.
> 
> Fixes: 4483ef3c1685 ("usb: dwc2: Add hibernation updates for ULPI PHY")
> Cc: stable@vger.kernel.org
> Reported-by: Tomasz Mon <tomasz.mon@nordicsemi.no>
> Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
> ---
> Changes in v2:
>  - Added Cc: stable@vger.kernel.org
> ---
>  drivers/usb/dwc2/gadget.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)

Does not apply to 6.15-rc4 at all, can you rebase and resubmit this?

thanks,

greg k-h

