Return-Path: <stable+bounces-43735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECAF8C4661
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 19:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7B41C21469
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 17:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF36B224CF;
	Mon, 13 May 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Md8uiXbQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A97A2869B
	for <stable@vger.kernel.org>; Mon, 13 May 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622251; cv=none; b=OOi7JJWspsMu8Feqgp2b+kfOR6xsdYvSTEADJxm4dqz3C9udlIJ793ib8cH8RlqsZcKKjzSB1S4N2DbzfyyYfjTx5pteJSfGwJvx2dsvjtYWmacs4sYYrGsFfR7W9vL6PviDvEccWmzZs5+R9qaBmxGlPSMjXruT/1cPex97NRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622251; c=relaxed/simple;
	bh=WKQMkTia0LeeqPU2KnbotVMMJgEAgODCFfMcVJO2kpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyMfOBycdSQh5aAFgivGG2wPTdCsPECDJIck2mGNxI4Oj1z02jv1xVbtwbMg/aE7S2FEHQ21ReKpvgLE0BVDaSkjMopmQ/fkITVit1V6RW7iwkPYlOsStsmLxd3Q3kQKEAhT34yLLP/slxFrzLOq1yUZ19rvlQtIyr0IrohaMcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Md8uiXbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC56C113CC;
	Mon, 13 May 2024 17:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715622251;
	bh=WKQMkTia0LeeqPU2KnbotVMMJgEAgODCFfMcVJO2kpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Md8uiXbQsYcPF4V43PE/9OjSmEvfE4eoh0DwZn6kVDmneazof8JGmVMy4Eqbmrnfi
	 n6XwNnMv1X/siWpy/+ezDN0tfus9SutptEcFBX1LzLhFVFtmp5S6j1LEL6Pjf5FzX3
	 kNNvNx5TELHipr2qOj4a55WAFzOfZnxlAdolpPpA=
Date: Mon, 13 May 2024 19:44:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeremy Bongio <bongiojp@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Security fix from mainline: CVE-2024-26900: md: fix kmemleak of
 rdev->serial
Message-ID: <2024051333-unsolved-diaphragm-29e0@gregkh>
References: <CANfQU3y36Yz9cvh+1Vy4GTV9cB1PjwTMfoFSXWBdDmHMChRjjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANfQU3y36Yz9cvh+1Vy4GTV9cB1PjwTMfoFSXWBdDmHMChRjjg@mail.gmail.com>

On Mon, May 13, 2024 at 10:39:18AM -0700, Jeremy Bongio wrote:
> Please backport this security fix.
> 
> Subject: CVE-2024-26900: md: fix kmemleak of rdev->serial
> sha1: 6cf350658736681b9d6b0b6e58c5c76b235bb4c4
> Why: This vulnerability exists in LTS kernels.
> kernel versions to apply: 5.10, 5.15, 6.1, 6.6
> 

Please provide a working version of that commit backported after you
have tested it out, and we will be glad to apply it.

thanks,

greg k-h

