Return-Path: <stable+bounces-108678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20239A11AF7
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 08:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4971A161BE5
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 07:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4E935961;
	Wed, 15 Jan 2025 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sWyfodaG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E61DB12F;
	Wed, 15 Jan 2025 07:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736926399; cv=none; b=eoX8tJ3uKaRQ9GX9OfiFAHb9z8qM77PdKXeSt+5Ur7Up1czp898YDTmwjsEaiiCCfRqJ6185b/Ntb+jP7EtqM8vJyOhRjMmUAII4iKTK9yPpxHTBUxOybjFZadKrm8z7pX+Fim+2bL1NzlK1N4MdQp1+akaELeFK7JeZSfJdEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736926399; c=relaxed/simple;
	bh=ZAwtos54J8uSMv55c6FZVHw3ZJWUh0Nc2zUmJp/MJqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUFNHCaqa8GR9SP9iEcgt38WRJxku2mjTqmJ14cYXJFnk1U4VR3U6CBw5YP9UVWGzQ8gGAHsZE/oRn6XzTudRh4tZUnnFlezgfqqZ1I9PDS14axW8ZSPlvcH/WYoyS31wdnfJaDJO4mdr3GXOT+TzQ542wASZXesCAx/4l8+kpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sWyfodaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC611C4CEDF;
	Wed, 15 Jan 2025 07:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736926397;
	bh=ZAwtos54J8uSMv55c6FZVHw3ZJWUh0Nc2zUmJp/MJqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWyfodaGy+hmmuSWXaCiri5QYS9JMX1tJiSPsl0SsnMRi9PJNNHUYImFAMaJSDi64
	 E0F+rAaUOM3y8ICVVea33cYklqUJ+aKslMjUIVQKGajH3IecVODnN2Uw4Qsdxu79z9
	 GSZMFF2EzviRMdduD2MPY87GuYXProZm3uE/IiKc=
Date: Wed, 15 Jan 2025 08:33:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Forest <forestix@nom.one>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] usb: xhci port capability storage change broke
 fastboot android bootloader utility
Message-ID: <2025011547-ditch-dust-bda4@gregkh>
References: <hk8umj9lv4l4qguftdq1luqtdrpa1gks5l@sonic.net>
 <2c35ff52-78aa-4fa1-a61c-f53d1af4284d@linux.intel.com>
 <0l5mnj5hcmh2ev7818b3m0m7pokk73jfur@sonic.net>
 <3bd0e058-1aeb-4fc9-8b76-f0475eebbfe4@linux.intel.com>
 <4kb3ojp4t59rm79ui8kj3t8irsp6shlinq@sonic.net>
 <8a5bef2e-7cf9-4f5c-8281-c8043a090feb@linux.intel.com>
 <h74eojd2r7t9f9jh3ebt07dlrhh6etqv4q@sonic.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h74eojd2r7t9f9jh3ebt07dlrhh6etqv4q@sonic.net>

On Tue, Jan 14, 2025 at 05:38:54PM -0800, Forest wrote:
> On Mon, 13 Jan 2025 17:05:09 +0200, Mathias Nyman wrote:
> 
> >I'd recommend a patch that permanently adds USB_QUIRK_NO_LPM for this device.
> >Let me know if you want to submit it yourself, otherwise I can do it.
> 
> Thank you.
> 
> I have prepared a patch against 6.13-rc7. This regression also affects the
> stable branch, but I don't know the patch policy for stable. To which lists
> should I send the patch?

Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

(hint, get it into Linus's tree first before worrying about stable
backports.)

thanks,

greg k-h

