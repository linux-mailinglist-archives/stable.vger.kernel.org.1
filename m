Return-Path: <stable+bounces-76877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BA197E620
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 08:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D4328118A
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 06:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B9182BD;
	Mon, 23 Sep 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cwiD89Pb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0479E1;
	Mon, 23 Sep 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727073914; cv=none; b=h7KV84ITKmw78KqHsb45Qul4lZaxtOHt/e4/UCAhsiHhhJrZqg1V7Ly2nLJ1qPt4o12ZDHlMT+1pIlKOlQRUk8wm+CInnZvwwXUqKg7nRXZg8XtPNpbE7PQEQ+A5R4KUR0fB+N7sgwapJX9X3xUc/S09zWDQoLwD65eGsDb6z58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727073914; c=relaxed/simple;
	bh=C8xxTFY5vBhvSGx1onfQ86a5vc9rr46CcQqRUnx/07I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXTZnU7B0XD4+tg1UoQlw+wVrAnqeRRRtUAplVFeYkgsHeaAncYcVOCZZEiGvim2Z36xzMdec355Qm/UGD7qIptQXJWzN1dpqFcHd6dj5HgPj5vk3CMNUTysuVNrfn7vhou5EXoVlCBU/vu4Y5++YbKaPIp9X+hE/5+OR2CYojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cwiD89Pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898ADC4CEC4;
	Mon, 23 Sep 2024 06:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727073913;
	bh=C8xxTFY5vBhvSGx1onfQ86a5vc9rr46CcQqRUnx/07I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cwiD89PbtGFjfZumScTsE1bUIEuYYgZytGQyEFIexdgBd3wYyKTg44plUDKzVZRyr
	 0UyVr6h5iIIW1n/muqWlfLF0E1CYyG0tgWvs6erYiNI7ylOegWBAqbxAgBnHjZUiM8
	 ZR3OaOuz6m73uNQzXKuoHh5lnJbpsQX/uIDS4X+I=
Date: Mon, 23 Sep 2024 08:45:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Fabian =?iso-8859-1?Q?St=E4ber?= <fabian@fstab.de>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	linux-usb@vger.kernel.org
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
Message-ID: <2024092318-pregnancy-handwoven-3458@gregkh>
References: <CAPX310gmJeYhE2C6-==rKSDh6wAmoR8R5-pjEOgYD3AP+Si+0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPX310gmJeYhE2C6-==rKSDh6wAmoR8R5-pjEOgYD3AP+Si+0w@mail.gmail.com>

On Mon, Sep 23, 2024 at 08:34:23AM +0200, Fabian Stäber wrote:
> Hi,

Adding the linux-usb list.

> I got a Dell WD19TBS Thunderbolt Dock, and it has been working with
> Linux for years without issues. However, updating to
> linux-lts-6.6.29-1 or newer breaks the USB ports on my Dock. Using the
> latest non-LTS kernel doesn't help, it also breaks the USB ports.
> 
> Downgrading the kernel to linux-lts-6.6.28-1 works. This is the last
> working version.
> 
> I opened a thread on the Arch Linux forum
> https://bbs.archlinux.org/viewtopic.php?id=299604 with some dmesg
> output. However, it sounds like this is a regression in the Linux
> kernel, so I'm posting this here as well.
> 
> Let me know if you need any more info.

Is there any way you can use 'git bisect' to test inbetween kernel
versions/commits to find the offending change?

Does the non-lts arch kernel work properly?

thanks,

greg k-h

