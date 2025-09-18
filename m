Return-Path: <stable+bounces-180499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD162B83E01
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 11:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CA52A1661
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 09:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13EF2165EA;
	Thu, 18 Sep 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="npeh8vK1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zLUdVVXl"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007DD2C027E;
	Thu, 18 Sep 2025 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188723; cv=none; b=H+vqzDLDYd3j8OmcmDlHO50plvKGPROre/29VQf52CEVyRermCiZFpBTxKjGQG1AEzUPcVZTNQ2wMIjmzXrpwrKMq9bYSX7dWP40UnklNwDjVwdMs+Zz/2MDikb/TCjXvZFuwtBcpM0x+tzGN3Z5Wf7vKcWBEwgzxJydpeDfN/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188723; c=relaxed/simple;
	bh=PBnddVjaJgRJXKxTMXiLhavbFvUsOKFeCdRu7iwTrAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsQQbp3S29XAw+V8TAu3MjFt9XnDR14bxlR70/1nR9E70Ek0dLMjfQw0DegfOrEYoxpVf0PqylL/TtNQlIT7PIfGjN8Bu44CbaD9n4yfsxA37l11WR+TptezW7weypkeyL7ElEQlLq6lcQpZ1ZFTpt9N51aW+u/Ru/4LnCTeYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=npeh8vK1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zLUdVVXl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Sep 2025 11:45:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758188719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oatovYDAScMrOSI4YJqu+8QfMHSB+UupX7Jb81hVJMw=;
	b=npeh8vK1axW173XNV/57Ddlty9173ssL9rJnbepqPLIAY2b9ddBGZbJszCR8v5+yAnAza2
	kVk2bM75nmKVo+3NA6tQv8ZvtE8aLMkGl6L37YfcJ4aLLXSWYaPfUywm1UUrwKq6jSgRsC
	ND/kiW40tkFP/FhbRVJASUPXYDtBgTB+jH99ujoX71c9WCMoCpdvgkxQfiu3Ve9aiLiiEu
	jPVsW56Awgt5dGnJDSwfxWGZqSDZ4AKOZBKWhQhJwRTzaSZptY7adDuhvB5TS4HsN9nTDR
	K5WBKS1u+7EmwMtkZeBvQP+IdO3REyj6slgscSYyJS5p0fpCRbpyDvj27kdU4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758188719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oatovYDAScMrOSI4YJqu+8QfMHSB+UupX7Jb81hVJMw=;
	b=zLUdVVXlpmvHz2/eYvNhI+3rMkRnInxUcPnt0gY/crKm5AlquvcirC7UxKQOZg0/ZbK+3k
	7EF71dKWJQe9lTCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/smp: Add check for kcalloc() in
 parse_thread_groups()
Message-ID: <20250918114130-3148bc05-4e21-44d6-b19f-dde33834a32e@linutronix.de>
References: <20250918093415.3441741-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918093415.3441741-1-lgs201920130244@gmail.com>

On Thu, Sep 18, 2025 at 05:34:15PM +0800, Guangshuo Li wrote:
> As kcalloc() may fail, check its return value to avoid a NULL pointer
> dereference when passing it to of_property_read_u32_array().
> 
> Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  arch/powerpc/kernel/smp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index dac45694a9c9..34de27d75b1b 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -822,9 +822,9 @@ static int parse_thread_groups(struct device_node *dn,
>  
>  	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
>  	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
> -	if (!thread_group_array) {
> -	ret = -ENOMEM;
> -	goto out_free;
> +	if (!thread_group_array) {	/* check kcalloc() to avoid NULL deref */
> +		ret = -ENOMEM;
> +		goto out_free;

Thanks for the patch!

This diff looks wrong, did you forget to squash two commits?
The comment is unnecessary.
It is enough to just 'return -ENOMEM'.
The return value documentation needs an update, too.

>  	}
>  	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
>  					 thread_group_array, count);
> -- 
> 2.43.0
> 

