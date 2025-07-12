Return-Path: <stable+bounces-161699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 336D4B0299F
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 08:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BBD1C41A73
	for <lists+stable@lfdr.de>; Sat, 12 Jul 2025 06:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1001D1FFC45;
	Sat, 12 Jul 2025 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="QQiOka2w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gioUaKzN"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC7117A2EB;
	Sat, 12 Jul 2025 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752303047; cv=none; b=GN428pc5I6ayFdvmapL4oDmr7+BO4Z43j7IxdvcMbktEWd6QYPhKYiZQaJsIGCV2QYG7d/w/c8GAkJprbt5SvwdCjiryzOmXcEvFZYSn4Fnjcd5xWGAdZhVOsWTNtIh3O7Px398HwWDpHwkLWxEMbpOUwu/WaCJ+kfE+SznqSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752303047; c=relaxed/simple;
	bh=oqM33BdI0qihm5MQIXIlXb1ETc9qR3+aQpQMnz+OKv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+YQV3NRKrAvs7RX3c/PG0Dseld4qhaQNYkbFTYWEgLZUzt04deOCqwualvLQsjGEtCyC3teO5TciW2gA314ZwvlNSCEJcvitk//NIhYDGZbAtxz8XqJXwZjmaL949rQV3wzbahhDFP6rfN81uMNFk8qsaBV8E3lCcBed1F3KYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=QQiOka2w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gioUaKzN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C434D140018E;
	Sat, 12 Jul 2025 02:50:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 12 Jul 2025 02:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752303043; x=1752389443; bh=IbJ9PAEXsz
	Tssof72C89QyfU5KZkMKg5AMOUIHPkphI=; b=QQiOka2wpVmmfhY0PFT9YY/ZEh
	NQ1uCALeWaC3uS5np3O3eQaivRXbYkFHQxL0kCzR0moLVFWCNXWjf88MaQrHaL8v
	UeO51Irv7rio8yDirIr05qEAJ+msPQKdI6JKisMvHZXNt+Wx/7CNQLd95Zie/UND
	KxhJSQkWhMmLCUaceiLjuQ3sdnvPHCawLvEFbL6+LEm754vPiYB2jsOaB9AT5moM
	JpJio8W8RT8fMEqFPYqU48P5dnodOd1uK+UhysibsXEyhMHYGY1ZGWFSOEOrHB+a
	kyAlDWeenZ9Vei068VbpMSODGnbuSdhXSdbpbedCg/ciQE6RVNwgz3onP3gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752303043; x=1752389443; bh=IbJ9PAEXszTssof72C89QyfU5KZkMKg5AMO
	UIHPkphI=; b=gioUaKzNWXTvBx5svF8Hvntp9hBeVd8zr7CvB2a4bqeKhHYRS25
	oOFt9mhiDtpApEqDZLAz56OckEu58NTrqkLOrhDuoMLhyVtDRp7on1NcCVv4bxO/
	lFB1mjPApdw+A//aa2ZmWvXQ1CGNycN8L3oCrxkCAMvxVaY1GWDoQkunWoXaYv93
	NrzIsamios0k32osmYHnqQDakqBixGRfAQgvX8HHyFn6jQ668cAw8eBrme7Z6ipA
	yuAGn9ijlWqI3x7VDBRFrk3G5rhE0ovWH2iTwrk5DTlgUtTKTKswiA/Ti/wgEzNg
	l7U51BnegM+wO+vGUGpbGgrbqfjSg7IAxuw==
X-ME-Sender: <xms:wwVyaBIaStZOmlzywcbpeQMGF3Z6wyGOwGpUlylOMxdS7mCWpT0EIA>
    <xme:wwVyaOrhcjg9uExQDWpWbvTnnh27SdcwZHXIi7P1BtU2PDK7Tod3VzA0S3gv1nuBp
    uSASf0HNnWsKQ>
X-ME-Received: <xmr:wwVyaHVFQJLWKYz50dXc0YrnzOsVMC8H3P9wXWTT-O5USVA78k-AaZJOHpWGOUBd_4OVIm0V5uxzBVS5n8x1TCmXFQOuEqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegheehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homhdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehhrghukhgvsehhrghukhgvqdhmrdguvgdprhgtphhtthhopehsrghshhgrlheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhopehvihhr
    ohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepphgruhhlmhgtkh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:wwVyaJ1jYI4QYQGUszDtdf7er-3sXTd1T-mq8EZhTnc2fJSQ321BTA>
    <xmx:wwVyaI0TbtAk4uHWYtN593hDbWtmL-sTlbmlMJmRDoxUPv9XY6YZpg>
    <xmx:wwVyaIkgCjvn1zqoJo5cXM-8O884QKkEDqIFEBkr3b8fEFXYdrzyWA>
    <xmx:wwVyaJOH8WorBQKFz93pqMyj36D2X2jGWh-nsdry7ga2DXkb5Ew9WA>
    <xmx:wwVyaLhYIi3hwq-emuTBPwX18p5LIFc1qjiDcLRFfVV6x1eR0zW0rQ5T>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Jul 2025 02:50:42 -0400 (EDT)
Date: Sat, 12 Jul 2025 08:50:40 +0200
From: Greg KH <greg@kroah.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: sashal@kernel.org, linux-kernel@vger.kernel.org, frederic@kernel.org,
	david@redhat.com, viro@zeniv.linux.org.uk, paulmck@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] kernel/fork: Increase minimum number of allowed
 threads
Message-ID: <2025071228-ounce-myself-1550@gregkh>
References: <20250711230829.214773-1-hauke@hauke-m.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711230829.214773-1-hauke@hauke-m.de>

On Sat, Jul 12, 2025 at 01:08:29AM +0200, Hauke Mehrtens wrote:
> A modern Linux system creates much more than 20 threads at bootup.
> When I booted up OpenWrt in qemu the system sometimes failed to boot up
> when it wanted to create the 419th thread. The VM had 128MB RAM and the
> calculation in set_max_threads() calculated that max_threads should be
> set to 419. When the system booted up it tried to notify the user space
> about every device it created because CONFIG_UEVENT_HELPER was set and
> used. I counted 1299 calls to call_usermodehelper_setup(), all of
> them try to create a new thread and call the userspace hotplug script in
> it.
> 
> This fixes bootup of Linux on systems with low memory.
> 
> I saw the problem with qemu 10.0.2 using these commands:
> qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 7966c9a1c163..388299525f3c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -115,7 +115,7 @@
>  /*
>   * Minimum number of threads to boot the kernel
>   */
> -#define MIN_THREADS 20
> +#define MIN_THREADS 600
>  
>  /*
>   * Maximum number of threads
> -- 
> 2.50.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

