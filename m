Return-Path: <stable+bounces-52345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0873490A370
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 07:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D97D282081
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 05:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBF71F61C;
	Mon, 17 Jun 2024 05:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="MEV/ZCry";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9Fs5S/U"
X-Original-To: stable@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF17344E
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718603422; cv=none; b=Hj+7yJDzfzvD6LrdnkQJHW8S5+wgXZjXrkoqmPrC79gadbFV69vbYKPs9m3OyhjOOoRBMSYRH7KdqfcB77dSXL7zAON6NWHZN7fwrAynvZSZcC86cBEL0VCVGFFi81wc98z3eeUWlSzKeNCUbztERexf62f/FEVOSTZLZI15Pt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718603422; c=relaxed/simple;
	bh=yYz0v+Afx8pMqzyLDRfia7erL0/kYivN0kFlUrnHQpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWr34M+Yq6JaJG+6t2BXHD0wcREZP+HzpXHti/byrZsz8yvGE6G1fFQx3jU0YrLo7DWs22O1dqvq+BgXMUxI5BPiqHo0ExCgNBMjkszrkvgVF/fqneUkvRO0Hu4XWIfhr+s0Jyg1YBJzk2g661nRcXMFGNgJfcSGyjGoH0AkaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=MEV/ZCry; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9Fs5S/U; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 888B71380232;
	Mon, 17 Jun 2024 01:50:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 Jun 2024 01:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718603419; x=1718689819; bh=SLOLSFLkNC
	RjJ/B3+gV6rDaMWXGsAMOG+B8IykBT5SM=; b=MEV/ZCrySOoV/DZ32+S1xBgY2y
	4iLy1RkoQK9B2Prf6rkhcOQwEdgMLEYbh2qpDrt4YoQxwqf0G3AM9XSDliY/spV/
	IFQ5L4FsETlnNGpRVvPnuJ11YyruPHKwnWuaEu1I8BShKwOfcfl6MrupInm4CLwT
	j5WvGk3Azf/7c8hpZwcO8VC/o+SyyaiIUAO+Sxxw7ubKwZDXng41bUOEqczdPiU0
	nE26FPRnLIH5ohJDxSVE6GNwJoS6rC6HQtXufuUOXwRTqvYmnqZ3g4xxr3QeW1ul
	CZJw0HFlGuKM/PlXL51VqHXGQWILKtX+EM6WUnXGehwYNiYRBTEU/iKbLg9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718603419; x=1718689819; bh=SLOLSFLkNCRjJ/B3+gV6rDaMWXGs
	AMOG+B8IykBT5SM=; b=g9Fs5S/Up0JFVAer7xVl0iywnM4jf0GUkGCWByfBpq9C
	IsiUJcrC0JuVjR5R7RoCOlWpaCZwbCjkZDuOt66o5KjI3VOs7mGw/hsSs/FyxVgZ
	G2/VrYsXxLrDPm0NXuCJI43vtiuY0Nh/6k7oeIoaymdCC+ONTKv0DeewWxmfH/kn
	MdrL+0NfiThSdRfItLHlKBOm6NrAJmrhYQzwq7YsSXmWfP24bLoBw/uHanw1NVPB
	tehSCHFPDnRnYsl8MN6uryTsGk83G1HJ5Cq7cOBIwaWN1QQbJThG3TG9stDsXY/N
	kU31rt5yrJsp//O4sGt+IURcZSusAtKV5Cc3r09Erw==
X-ME-Sender: <xms:m85vZvE1BAj4t__w_JZtLmbXXMCgZ7Lkb2PDBnOOk65lVdAejcK0hA>
    <xme:m85vZsWZYzJuVT5lK5UKSNWHyWQZiXHohZtvBQ2xy9-Glb1llKQEOnGUMNo7mHoOs
    4F80KaJkQWpNw>
X-ME-Received: <xmr:m85vZhLPi38C1BoM83MIdtAWqrlWZiX23ax3wsuf3xROfsWsBAeUKkQiovLpody7bB1nifQYmKPokBeyGpFJGwyxwMvd-Kb7E_wEmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduie
    ffvddufeefleevtddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:m85vZtHCDLDQ_ExWUWt9TzRB2jhT9xrhrYSV6R9Ge7CCkptTMibRYQ>
    <xmx:m85vZlV9Zn_vq0JyFiNHWb2gKaORIZUcd6r7Fb53FhG6aqU941xpYQ>
    <xmx:m85vZoNXgBRi2LVHlyZialFJgIZghhbAcfRauv1EJRC4lp-22FRjkw>
    <xmx:m85vZk2GpsJZYi_sQaH7WkAfpRBOxjbdY99JvSxcJtOLnRWaR5MVQA>
    <xmx:m85vZnL5Ho7JSTlKH5-6s8m8WbYvhG2SbWy-wqeX6vw1TcgVzbY8SJxn>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 01:50:18 -0400 (EDT)
Date: Mon, 17 Jun 2024 07:50:16 +0200
From: Greg KH <greg@kroah.com>
To: "guojinhui.liam" <guojinhui.liam@bytedance.com>
Cc: guojinhui.liam@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v7] driver core: platform: set numa_node before
 platform_device_add()
Message-ID: <2024061740-negation-curvature-ef30@gregkh>
References: <20240617030123.4632-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617030123.4632-1-guojinhui.liam@bytedance.com>

On Mon, Jun 17, 2024 at 11:01:23AM +0800, guojinhui.liam wrote:
> From: Jinhui Guo <guojinhui.liam@bytedance.com>
> 
> Setting the devices' numa_node needs to be done in
> platform_device_register_full(), because that's where the
> platform device object is allocated.

Why in the world is a platform device on a numa node?  Are you sure you
are using platform devices properly if this is an issue?

And what platform devices / drivers care about this?

> Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>

The robot reported this problem?

> Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/

That's a problem with an older version of this patch, not this one.

> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
> V6 -> V7
>   1. Fix bug directly by adding numa_node to struct
>      platform_device_info (suggested by Rafael J. Wysocki).
>   2. Remove reviewer name.
> 
> V5 -> V6:
>   1. Update subject to correct function name platform_device_add().
>   2. Provide a more clear and accurate description of the changes
>      made in commit (suggested by Rafael J. Wysocki).
>   3. Add reviewer name.
> 
> V4 -> V5:
>   Add Cc: stable line and changes from the previous submited patches.
> 
> V3 -> V4:
>   Refactor code to be an ACPI function call (suggested by Greg Kroah-Hartman).
> 
> V2 -> V3:
>   Fix Signed-off name.
> 
> V1 -> V2:
>   Fix compile error without enabling CONFIG_ACPI.
> ---
> 
>  drivers/acpi/acpi_platform.c    |  5 ++---
>  drivers/base/platform.c         |  4 ++++
>  include/linux/platform_device.h | 26 ++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 3 deletions(-)

Any reason why you didn't cc the relevent maintainers here?

> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 7a41c72c1959..78e11b79f1af 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -132,10 +132,36 @@ struct platform_device_info {
>  		u64 dma_mask;
>  
>  		const struct property_entry *properties;
> +
> +#ifdef CONFIG_NUMA
> +		int numa_node;	/* NUMA node this platform device is close to plus 1 */
> +#endif

Ick, no, why?  Again, platform devices should NOT care about this.  If
they do, they should not be a platform device.

>  };
>  extern struct platform_device *platform_device_register_full(
>  		const struct platform_device_info *pdevinfo);
>  
> +#ifdef CONFIG_NUMA
> +static inline int platform_devinfo_get_node(const struct platform_device_info *pdevinfo)
> +{
> +	return pdevinfo ? pdevinfo->numa_node - 1 : NUMA_NO_NODE;
> +}
> +
> +static inline void platform_devinfo_set_node(struct platform_device_info *pdevinfo,
> +					     int node)
> +{
> +	pdevinfo->numa_node = node + 1;

Why +1?

thanks,

greg k-h

