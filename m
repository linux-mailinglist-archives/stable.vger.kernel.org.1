Return-Path: <stable+bounces-206243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D12C0D011E7
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 06:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B0C930024FF
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 05:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF06731691C;
	Thu,  8 Jan 2026 05:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rXCkeP5H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473243164DB
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767850468; cv=none; b=hmCFLvaeidvyWlfHZhDLK1dtJ48j52PT9eItxGlqHj/M/Rk1N2vEVuJqw+naDxFf5OCM6h3mQ90SImgILwhRYbbg8Ur9m8EyQefNtuiLPpjtBDv018JwvigUqic8zuNzdMvZjxXHEjG1ukxyMtfYRng9+wdiKPwpBGl33XsUz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767850468; c=relaxed/simple;
	bh=kJMnD8b1eioFFVPw8EavZJAUnw2nLUeChULMjLXMsNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYWtfBmaNRAtyXw/jx8q7qN3B3fuN9tHiIc6vhXpLcYuxnuej699eIuKP8CkxYeAQfFQNRI54kfPYsKmgFsTJaCDq2qW5EfJguVJYWWHnfrUzxpO3TewBEPqstLQhvEjHjCqlK2ETP5x/YNE6svD2br01NWxTxS6n8ckUq6OVIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rXCkeP5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234DDC16AAE;
	Thu,  8 Jan 2026 05:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767850467;
	bh=kJMnD8b1eioFFVPw8EavZJAUnw2nLUeChULMjLXMsNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXCkeP5HFP2Di89zPtGHQ5DH1CrdfX26Q+iL+2bHlfKtNqqiWMsYtudlxyagFm3LA
	 XuN0r1x3KvtpiZoQBzd4uD1IVB+Ascdz4jTW+pgD6Bjxc0HRWYGRGWbM7J9kOGE2ij
	 gyttYxKyJLfoYPydA5/N2/1Dw+h0Qd08GnqDdOXg=
Date: Thu, 8 Jan 2026 06:34:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: JP Dehollain <jpdehollain@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Fwd: Request to add mainline merged patch to stable kernels
Message-ID: <2026010813-crewmate-crewless-1946@gregkh>
References: <CAH1aAjJkf0iDxNPwPqXBUN2Bj7+KaRXCFxUOYx9yrrt2DCeE_g@mail.gmail.com>
 <2025122303-widget-treachery-89d6@gregkh>
 <ME6PR01MB1055749AAAC6F2982C0718687AAB5A@ME6PR01MB10557.ausprd01.prod.outlook.com>
 <CAH1aAjJjxq-A2Oc_-7sQm6MzUDmBPcw5yycD1=8ey1gEr7YaxQ@mail.gmail.com>
 <2026010604-craftsman-uniformed-029c@gregkh>
 <CAH1aAj+myyuXniX9JAo5fQzHUyqtrGobhNPizc-Of8=OPgOAjw@mail.gmail.com>
 <2026010748-seventeen-daylight-2568@gregkh>
 <CAH1aAjK=GLKQvi6MaJsv2vANTc-f4FNX4ePUCk8AwLwGO7oPqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1aAjK=GLKQvi6MaJsv2vANTc-f4FNX4ePUCk8AwLwGO7oPqQ@mail.gmail.com>


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Jan 08, 2026 at 11:57:58AM +1100, JP Dehollain wrote:
> Thanks, I can do that, just note that these patches had already been
> previously submitted and merged into mainline:
> 
> 1/2 - [PATCH] misc: rtsx: Add support for RTS5264 Version B and
> optimize init flow - Ricky Wu
> Link: https://lore.kernel.org/all/20250620071325.1887017-1-ricky_wu@realtek.com/
> 
> 2/2 - [PATCH] misc: rtsx_pci: Add separate CD/WP pin polarity reversal
> support - Ricky Wu
> Link: https://lore.kernel.org/all/20250812063521.2427696-1-ricky_wu@realtek.com/
> 
> The request is to also get them merged into all previous stable
> versions.

What exactly is "all"?

And what are the git ids for these commits?

> Apologies if I'm missing some trivial context, I'm just
> learning about the kernel development process and I'm not across this
> process of porting patches across kernel versions.

The process is documented here:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

for basic stable stuff, but when you want a series backported that
doesn't apply cleanly, you need to provide a tested series yourself.

thanks,

greg k-h

