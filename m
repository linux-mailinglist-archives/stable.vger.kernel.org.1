Return-Path: <stable+bounces-32951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCF988E878
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720FDB33F50
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 14:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982AD13E8B1;
	Wed, 27 Mar 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZH90KdGp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F361304BD;
	Wed, 27 Mar 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547114; cv=none; b=OYy7cOdz/pFTpJvMEAYJAC8Ewy+MtWmBYI0gR8i6FrilE1drRkIF+As0gsHVw0xlo+Y0N1d3xHDwCKsfB2u5g/Awm0WzavLLFCxbItFbJd170zq82/meFPCaagRUNM31wPry4cSxrJ3BpC60l4P64REadpO83IZ/a76pRq9RAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547114; c=relaxed/simple;
	bh=X3i5T8LB4HLDxLbAY0JtEHXpCwZlRHRq2v1tfYv9xXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWE+8XEd9Ch4CCHgRq9PTE6qkRgby+fSL1kLb9g4jbnb0zVKSVaJMUZVqZa0P1sTstuBi6S2YXB4P5gXw6Sq6Z/O5TF2amGqGPeaD5T0YH1v55ho6kfbt0jsXvDq3dm8dvMPOW/2fU//WeUHE/5X/VM5KIFVJRDc0N/L1IYRovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZH90KdGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6407C433C7;
	Wed, 27 Mar 2024 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711547114;
	bh=X3i5T8LB4HLDxLbAY0JtEHXpCwZlRHRq2v1tfYv9xXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZH90KdGp5uk97Rcp53c+d4Wd90zIim3TlvwaQbhtJvHy/XA+Fp4zDw2sbWBRQDUQM
	 3MdGIRwZz/vpzYFkBl7wyR73tMRtdGuCz+VQHKHrqhYsH/8vM8NKqB9msUl2boRuFb
	 1cB8GCskOa9AQNbbYPc+NATzvQAe84MgRHU3ffYU=
Date: Wed, 27 Mar 2024 14:45:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
Message-ID: <2024032756-sneak-coastland-47ae@gregkh>
References: <20240313164640.616049-1-sashal@kernel.org>
 <ZfNwZ2dqQfw3Fsxe@eldamar.lan>
 <ZfSV6RVweBOlKZW_@sashalap>
 <ZgJyUxKgKhjVTqI5@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgJyUxKgKhjVTqI5@eldamar.lan>

On Tue, Mar 26, 2024 at 07:59:31AM +0100, Salvatore Bonaccorso wrote:
> Hi Sasha,
> 
> On Fri, Mar 15, 2024 at 02:39:37PM -0400, Sasha Levin wrote:
> > On Thu, Mar 14, 2024 at 10:47:19PM +0100, Salvatore Bonaccorso wrote:
> > > Hi Sasha,
> > > 
> > > On Wed, Mar 13, 2024 at 12:45:27PM -0400, Sasha Levin wrote:
> > > > 
> > > > This is the start of the stable review cycle for the 5.10.213 release.
> > > > There are 73 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Fri Mar 15 04:46:39 PM UTC 2024.
> > > > Anything received after that time might be too late.
> > > 
> > > This one still has the problem with the documentation build and does
> > > not yet include:
> > > 
> > > https://lore.kernel.org/regressions/ZeZAHnzlmZoAhkqW@eldamar.lan/
> > > 
> > > Can you pick it up as well?
> > 
> > I'll pick it up for the next release cycle, thanks!
> 
> Did something went wrong here? I do not see in in the current review
> for 5.10.214-rc2. Can you still pick it for 5.10.214 to get
> documentation build working?

Sorry for the delay, tried to have a vacation :)

Now queued up.

greg k-h

