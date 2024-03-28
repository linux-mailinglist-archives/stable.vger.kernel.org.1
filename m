Return-Path: <stable+bounces-33076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D693788FE25
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 12:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1412D1C269A0
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 11:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9967E775;
	Thu, 28 Mar 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GMusgAIl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715DD7D3E7;
	Thu, 28 Mar 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625648; cv=none; b=CbxhrCfqsL4iA3J5UhZIUfulFqYot15AcDH7DKgPn3jE1CWU7QSXOUc6PVz39liSRs3tX5mOLwQqp/zXmbiTjCVntxC2x7aEoY4WYlKGWJWW4xoctxkS6HrmyMiWE7KTbwpbBOh8YTZOPbeTJ6Jb53Xp/1F8A8YBFmlOL1jG98w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625648; c=relaxed/simple;
	bh=Siq6kaxaVBIR62A+RO4MpSDHLY/IlSEjSEoHPEC7/m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiOHmWNKGsUQY6hNtXH4DVLEpijPIdnQxOhI7nJnE2UjVy7AsIqV1f7wPR2NppNYXDxL9mdVZsWPtsgGOW9dAeTK+NYsltZeofK9UVuAs+3CItAwa7u/ayAgR3FzFujSlP/f+qpCQa3q2yECbVd1q7HmaRQGfS6j2u8DHUCl+5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GMusgAIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CA8C43390;
	Thu, 28 Mar 2024 11:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711625648;
	bh=Siq6kaxaVBIR62A+RO4MpSDHLY/IlSEjSEoHPEC7/m8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMusgAIlmZmf9qJSVVmQNyMikMiSnVOWZUU2w8lqJJisdMh7Lz0F4IhRLLow1wLHL
	 nh6Ttc34G+2ZzoAMNbiD9kMElcsHBytelLVB6En8RMjrOAaj47CKRmdP6T2jtgELQX
	 7vu4zIuCxw83yXf9xmCjQ+c+F/9FbI+ateG3d47U=
Date: Thu, 28 Mar 2024 12:34:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: Luca Stefani <luca.stefani.ge1@gmail.com>,
	Sasha Levin <sashal@kernel.org>, Jiawei Wang <me@jwang.link>,
	Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] Revert "ASoC: amd: yc: add new YC platform variant
 (0x63) support"
Message-ID: <2024032853-drainage-deflator-5bae@gregkh>
References: <20240312023326.224504-1-me@jwang.link>
 <bc0c1a15-ba31-44ba-85be-273147472240@gmail.com>
 <2024032722-transpose-unable-65d0@gregkh>
 <465c52a1-2f61-4585-9622-80b8a30c715a@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <465c52a1-2f61-4585-9622-80b8a30c715a@amd.com>

On Thu, Mar 28, 2024 at 04:10:38PM +0530, Mukunda,Vijendar wrote:
> On 27/03/24 23:39, Greg KH wrote:
> > On Wed, Mar 27, 2024 at 06:56:18PM +0100, Luca Stefani wrote:
> >> Hello everyone,
> >>
> >> Can those changes be pulled in stable? They're currently breaking mic input
> >> on my 21K9CTO1WW, ThinkPad P16s Gen 2, and probably more devices in the
> >> wild.
> >
> > <formletter>
> >
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> >
> > </formletter>
> These patches already got merged in V6.9-rc1 release.
> Need to be cherry-picked for stable release.
> 

What changes exactly?  I do not see any git ids here.

confused,

greg k-h

