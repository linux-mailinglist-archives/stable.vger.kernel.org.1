Return-Path: <stable+bounces-165734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64555B181DC
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 14:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDD73B2271
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 12:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBC824887E;
	Fri,  1 Aug 2025 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4fceExI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392BA248871;
	Fri,  1 Aug 2025 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051676; cv=none; b=eVApgXf9D7oG+nwh/cv04Mk0yL19B2Jjfxygn1+58YkUHXQWNr/8CvI4qGwCmhu8EHisbEBiyVjmM7DJZ3UjvY4CujiOee7YpjSkliBdvORoICLAP5dVXhCsM9u4Ys7JIm98335TPdSHA3M+tXIjUMbqAt6C23jlJzLbtNja01M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051676; c=relaxed/simple;
	bh=x1HBdkIt//cfiGJ1A7He9eBaYQy80mB4yhfQry3Svic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdkfqTHCBQgZqyB28HeDvjS30oLuMipbVOnUWdbnTT5W1SMAowDECCNBlThwYyeFh38w17HOcM0BvgwjuIwAXjpKBhU7sy2zSr8euV6R855QLnbkt0YTuwUKq/nzDkm+UAhzwFCf/Pf5mzUa+6WVhEj1EI0DQchIDYxP57ceLMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4fceExI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD176C4CEE7;
	Fri,  1 Aug 2025 12:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754051676;
	bh=x1HBdkIt//cfiGJ1A7He9eBaYQy80mB4yhfQry3Svic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4fceExIP/Z68hGLqSPSHcHi4qyBaVr8TuDGaJEENPl1ZKbtJ+dq8ra5fc4iftNsl
	 I1HpDS7cQcB7I3r0UfyQx1YnidzqCZJCzZ8sDIkL9N1WeA6x2G3F3QwHVzurexwyGV
	 dziBMdI7kmktR+Amisf+fC0ayd7iEpJoGekXcMTIJUIYQOe6gpvFOuCfKUamudnqb2
	 NDxdRqzJ0u2XtxrfEwYH/amRqnOvWdjcygZ2ADmi54EP8jK3DumbWHDokHsyHSVYSs
	 pkus0Ji+Cc/hTJ4AJ/peiStyNrwcXmwgakNqXJMy2SvmLbVpk/i1ECzj6c7BogrDtU
	 q7UbW/xj8BHcg==
Date: Fri, 1 Aug 2025 08:34:33 -0400
From: Sasha Levin <sashal@kernel.org>
To: Christoph Freundl <Christoph.Freundl@ifm.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, Greg KH <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, peter.chen@kernel.org,
	stable@vger.kernel.org, hui.pu@gehealthcare.com
Subject: Re: [GIT PULL] USB chipidea patches for linux-5.15.y and linux-6.1.y
Message-ID: <aIy0WQOoOCCzZK-X@lappy>
References: <20240902092711.jwuf4kxbbmqsn7xk@hippo>
 <2024090235-baggage-iciness-b469@gregkh>
 <20240903021135.5lzfybyv7rzty33d@hippo>
 <36406dea-f876-b3e-5ad7-69fdae97366a@ifm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <36406dea-f876-b3e-5ad7-69fdae97366a@ifm.com>

On Fri, Aug 01, 2025 at 02:06:28PM +0200, Christoph Freundl wrote:
>On Tue, 3 Sep 2024, Xu Yang wrote:
>> On Mon, Sep 02, 2024 at 02:14:04PM +0200, Greg KH wrote:
>> > On Mon, Sep 02, 2024 at 05:27:11PM +0800, Xu Yang wrote:
>> > > Hi Greg,
>> > >
>> > > The below two patches are needed on linux-5.15.y and linux-6.1.y, please
>> > > help to add them to the stable tree.
>> > >
>> > > b7a62611fab7 usb: chipidea: add USB PHY event
>> > > 87ed257acb09 usb: phy: mxs: disconnect line when USB charger is attached
>> > >
>> > > They are available in the Git repository at:
>> > >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git branch usb-testing
>> >
>> > We don't do 'git pull' for stable patches, please read the file:
>> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>> > for how to do this properly.
>> >
>> > Just send them through email please.
>>
>> Okay. I'll follow the rules.
>
>I want to bump this topic as this is still an issue, not only on the
>mentioned branches but also on linux-5.10.y. For the affected devices (a
>custom i.MX6 board in our case) you have to either revert commits
>e70b17282a5c3c and cc2d5cdb19e3 or apply above commits in order to make
>the USB interface work properly.

Ugh, sorry for this.

I'll go do it now.

-- 
Thanks,
Sasha

