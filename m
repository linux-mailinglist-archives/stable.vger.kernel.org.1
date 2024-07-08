Return-Path: <stable+bounces-58200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C392A048
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 12:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC501F216F0
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC206F312;
	Mon,  8 Jul 2024 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JPlBJaO/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731D51DA303
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720434946; cv=none; b=gjU6o+czGMHLxOQx2rU6w6rGxX0c/+Xd5EuOCdJq9+fhlJE77pdFudjg+EBQBDUW8UrNS8KEP1OabcKjIV66YGEvekOwS8hq6ntGX0vFfeUYBouLiTGQdDk723+uEcrTXmpCzrTNNfXFjgjqWDZZ7X3IEkEmQDgP2WRBgPUX3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720434946; c=relaxed/simple;
	bh=epg80GSQiet5VHetoAk0Gr7FJ1+fbs6OMiBZZWtTVh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lg5+mQ4Esu9D4TmvIiPZwdpNkPU7CIRV6zcps8XMrmW6brGTKzLdrb001JBLfw1OGot2F+ul6fRG/+1SMOV0e0BC/uKrL5Qu2OIqSON/URJbiB+g5zayNTAIA6mk3lB/Yz3zJB6LrUvFDnqDRc83CUADTlJSKy37PmLfgt7ukyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JPlBJaO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8462EC116B1;
	Mon,  8 Jul 2024 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720434945;
	bh=epg80GSQiet5VHetoAk0Gr7FJ1+fbs6OMiBZZWtTVh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPlBJaO/wziDHmgzukFzZsgAQElTzO0OM+OApZuELtn1fsnXxQIKTkZK3er7u74CO
	 HE9PZQUAx4/NIoR47ySacDt81WHH/Q6jn43XfvMf5hc5z1t1tb8x7EaD+67a493T8x
	 +v1BQGiwoVS7P5VAi7x9EHQnCWAxtVwDIGlqs1KU=
Date: Mon, 8 Jul 2024 12:35:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: chenhuacai@kernel.org, chenhuacai@loongson.cn, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] cpu: Fix broken cmdline "nosmp" and "maxcpus=0"
Message-ID: <2024070834-subtly-tamper-fc1f@gregkh>
References: <2024070154-legged-throwaway-bd6a@gregkh>
 <87sewmwmkf.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sewmwmkf.ffs@tglx>

On Sat, Jul 06, 2024 at 05:46:08PM +0200, Thomas Gleixner wrote:
> 
> From: Huacai Chen <chenhuacai@kernel.org>
> 
> commit 6ef8eb5125722c241fd60d7b0c872d5c2e5dd4ca upstream.
> 
> After the rework of "Parallel CPU bringup", the cmdline "nosmp" and
> "maxcpus=0" parameters are not working anymore. These parameters set
> setup_max_cpus to zero and that's handed to bringup_nonboot_cpus().
> 
> The code there does a decrement before checking for zero, which brings it
> into the negative space and brings up all CPUs.
> 
> Add a zero check at the beginning of the function to prevent this.
> 
> [ tglx: Massaged change log ]
> 
> Fixes: 18415f33e2ac4ab382 ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")
> Fixes: 06c6796e0304234da6 ("cpu/hotplug: Fix off by one in cpuhp_bringup_mask()")
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20240618081336.3996825-1-chenhuacai@loongson.cn
> ---
>  kernel/cpu.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/kernel/cpu.c

Now queued up, thanks.

greg k-h

