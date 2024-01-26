Return-Path: <stable+bounces-16034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311C983E745
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D5A1C258C5
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45375914A;
	Fri, 26 Jan 2024 23:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ehoWQ5rQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662B20320
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312945; cv=none; b=AgiBdGx9bd/wFwAmQDo2F8rQiX8n/Aq9aQUvd5rDwfZWLhe8ojamHdLpgZ8KdkG8I3bY8CW70s6uPA+A7sGCD+JmMZMYI40ELuu7NhExZS7w7dEWMDSvCN9U7b0fbEeYgvXr9rqjv98JjUw3hogl5MBkPnXlq6LfNfeVwwdBmdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312945; c=relaxed/simple;
	bh=c7nyngLN1fgNnxaC6srPWWXh0rIk5CeTBbDjEAz/zHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go6nO2UtfTF1d9aaY6yu4rn48fsgHXHBopfjJYTImH9MCEW7TxMageUQi7bxOJ+EzmFJZiwp2yGCevchOAZy7utijX7xUHKvLuy6rsAdzTlVPfZSuPzqEpsvmcfg283lt4geCAVR65ZZdf50LNOStIjGigFTLT2jdIvGQ/THNE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ehoWQ5rQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8AFC433F1;
	Fri, 26 Jan 2024 23:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706312945;
	bh=c7nyngLN1fgNnxaC6srPWWXh0rIk5CeTBbDjEAz/zHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehoWQ5rQ3zGh7ghfJ6ykHjVrThwzQiTBtap2TP8x7KmmYtzZdt+g3IjFMUcfiyuMH
	 7AstrjToY+PWwMUSUPnHzARiGLoe6WoNIFTsVrTiE1x2RH6VZgH4lqgvJQQqZNg674
	 hxC31V3AmCGmB5crvlSQiQJK2KeMHLst3Wb+w8B0=
Date: Fri, 26 Jan 2024 15:49:04 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: stable@vger.kernel.org
Subject: Re: serial: sc16is7xx: improve regmap debugfs by using one regmap
 per port
Message-ID: <2024012643-resume-pounce-39e6@gregkh>
References: <20240123122957.9a88fb7839ae745975af6883@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123122957.9a88fb7839ae745975af6883@hugovil.com>

On Tue, Jan 23, 2024 at 12:29:57PM -0500, Hugo Villeneuve wrote:
> Hi,
> I would like the following patch to be applied to the stable
> kernel 6.6:
> 
> 3837a0379533 serial: sc16is7xx: improve regmap debugfs by using one
> regmap per port
> 
> As noted in
> https://lore.kernel.org/all/20231211171353.2901416-1-hugo@hugovil.com/raw :
> ---------------------
> I did not originally add a "Cc: stable" tag for the above mentioned
> commit, as it was intended only to improve debugging using debugfs. But
> since then, I have been able to confirm that it also fixes a long
> standing bug in our system where the Tx interrupt are no longer enabled
> at some point when transmitting large RS-485 paquets that completely
> fill the FIFO and thus require multiple and subsequent writes to the
> FIFO once space in it becomes available. I have been investigating why,
> but so far I haven't found the exact cause, altough I suspect it has
> something to do with regmap caching...
> ---------------------
> 
> It applies cleanly and was tested on this kernel using a
> custom board with a Variscite IMX8MN NANO SOM, a NewHaven LCD, and two
> SC16IS752 on a SPI bus. The four UARTs are using RS-485 mode.

Now queued up, thanks.

greg k-h

