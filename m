Return-Path: <stable+bounces-46574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1018D09CB
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 20:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F2C1F22944
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE9B15F403;
	Mon, 27 May 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vpqs5F3R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69C1DDC9;
	Mon, 27 May 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716833679; cv=none; b=d1S8jWV4imsbsxYa0OSK/n9hF64Et5yMIQRb1tU3t21GWTOISj5xZpFT4cisdzI+f2wpUrdrLkfuqtMtsT5w6YSUEU4ufVuvelUCQoslF4cdvD7MI4JBMXxFylmfmv+xrGPQE9KQCfPJEHz9dEl1MNH8lUZh2qMwai1fb2CDIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716833679; c=relaxed/simple;
	bh=hVr28pGJ4hsBrlJfUQDMbhDwUl512kWSkB4J26U1kuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TorC9xkr8cfNAZ60k5gxOsG9kEmaD4rFOgXAk97TF9SZiiQi9jntm4WcnZnu4F0bkEgmHRwUKGx5QYRz0KtQP1N7ba9gXAncmngRuzyc/a3Si9cxW6sDK7BLBYfIHVYrit7ejdkf9qsJI2rZ+D/O9WfTcLjM1t2vW9D2ttSdrhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vpqs5F3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE8BC2BBFC;
	Mon, 27 May 2024 18:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716833678;
	bh=hVr28pGJ4hsBrlJfUQDMbhDwUl512kWSkB4J26U1kuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vpqs5F3RAXKRlnRDWM4zYkqo444yYZeyNkXAU7/CqQgQzsx6Sj4s2WxBFMgWTtk+L
	 k2yYMRiJHJfyqi5L4DGWvq0Wlw6no772rgT7fuRaLL9LawTl9Ntvnu6teVeKgYMKxG
	 emtC7sddTH3FtcE2+IorMgtm6LfAHxFStCH34upY=
Date: Mon, 27 May 2024 20:14:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ilkka =?iso-8859-1?Q?Naulap=E4=E4?= <digirigawa@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During
 Shutdown/Reboot
Message-ID: <2024052710-marsupial-debug-febd@gregkh>
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
 <5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
 <20240524132008.6b6f69f6@gandalf.local.home>
 <CAE4VaRF80OhnaiqeP9STfLa5pORB31YSorgoJ92fQ8tsRovxqQ@mail.gmail.com>
 <CAE4VaRGaNJSdo474joOtKEkxkfmyJ-zsrr8asb7ojP2JexFt-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE4VaRGaNJSdo474joOtKEkxkfmyJ-zsrr8asb7ojP2JexFt-A@mail.gmail.com>

On Mon, May 27, 2024 at 07:40:21PM +0300, Ilkka Naulapää wrote:
> Hi Steven,
> 
> I took some time and bisected the 6.8.9 - 6.8.10 and git gave the
> panic inducing commit:
> 
> 414fb08628143 (tracefs: Reset permissions on remount if permissions are options)
> 
> I reverted that commit to 6.9.2 and now it only serves the trace but
> the panic is gone. But I can live with it.

Steven, should we revert that?

Or is there some other change that we should take to resolve this?

thanks,

greg k-h

