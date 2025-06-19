Return-Path: <stable+bounces-154787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C216EAE02C5
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 12:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEEF3189E011
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D812248A5;
	Thu, 19 Jun 2025 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eb6tu/4s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E340224234;
	Thu, 19 Jun 2025 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329335; cv=none; b=fzT1fTnmNpNOALCliR24yfV8gRDmhBrNDJbGue4fdi9/Oy1r13Ni5a/bdiUyeaWfp6xKdkKXZDQIKn3oE7yG6aTOTfTnLZhHDBC815frp/wyeXfikcQs5exRXcTD+lTJH50sYnd0AkpYhaIogR5NRyLBUPkWuip8FGQuBzoU05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329335; c=relaxed/simple;
	bh=/ovHqXT6Fuayc9VrPcOHFmgWIiw9d4rNMOeKWBJe2sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YREnClHfTWZ98YHbiJxrWUPgB/ZcUE9NJG8SZ3G2eWBh5MDDsEFDY6HFK8oaa0ULsna2TGE/tNlB2FoTd5sN9OyNXs4dwimiri8Dpmb1CGkS7mOlkfBAeL+M0KNuQNHug9wy0F1GVJsfShrE3onbYf+FjPYGYP972BHQ008TZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eb6tu/4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93D4C4CEED;
	Thu, 19 Jun 2025 10:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750329335;
	bh=/ovHqXT6Fuayc9VrPcOHFmgWIiw9d4rNMOeKWBJe2sQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eb6tu/4snZMbu+FSby+w2x7UTIGWGyj0wQPJAokfSP0MsD7cyHSTNYqhNpBNdx6hV
	 ONv05hsBPHjr/EgSOFWqoK9iKp9hJ+f3KKv/G1KaPHm80lzy26m1bhkfHd3s9i6j/X
	 hVlzNOytczBBG7gh69CK8ym3OwvLCBDB+JWlZ+00=
Date: Thu, 19 Jun 2025 12:35:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	John Youn <John.Youn@synopsys.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v 4] usb: dwc2: gadget: Fix enter to hibernation for
 UTMI+ PHY
Message-ID: <2025061922-tripping-obsolete-abfd@gregkh>
References: <35036b774510b46191500985ca6db57390d4a246.1748856956.git.Minas.Harutyunyan@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35036b774510b46191500985ca6db57390d4a246.1748856956.git.Minas.Harutyunyan@synopsys.com>

On Tue, Jun 03, 2025 at 07:16:32AM +0000, Minas Harutyunyan wrote:
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
>  Changes in v4:
>  - Rebased on top of Linux 6.15-rc6
>  Changes in v3:
>  - Rebased on top of 6.15-rc4
>  Changes in v2:
>  - Added Cc: stable@vger.kernel.org
> 
>  drivers/usb/dwc2/gadget.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)

Fails to apply on top of 6.16-rc2 :(


