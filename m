Return-Path: <stable+bounces-180771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5CBB8DADD
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CDF163D6F
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293C223DD6;
	Sun, 21 Sep 2025 12:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btVCBoK/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0E192B66
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457590; cv=none; b=IZR5+sytXqNpN3sLPZrOFdWgrAS7O5oU+/mGnGTbJM5CxzWoZbO5xMWTcPlb/qZKJaLeriBhDlRA95ZBZmtXXAMoAIpSfkmqWL7HnQ6z+quxQQL76SWNjMkdZ7hfqbL35UvdOMU8aj0O3lTDmo03PpsX7Dtv5hQv063SGYaVnfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457590; c=relaxed/simple;
	bh=MKb8mYDnOBDJhArKWHrsOz/cYE8ir+8pEm8gSmOnUQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6PlDTNYl3e1cOuezNM1RXJNMSuk7V22/OhbVyNoRMyHShUChZaKOMhJzeOCnjmLFbj6O30B7XvU99oKDWIlLfwm4yVKvjooqEYdv4EAubyJBNmYMPktkR6Ge++EQLQ5RkxnPgFhulblyRse4rlesqw2QfZTH7jpXj8kIqUXxKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btVCBoK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B67C4CEE7;
	Sun, 21 Sep 2025 12:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457590;
	bh=MKb8mYDnOBDJhArKWHrsOz/cYE8ir+8pEm8gSmOnUQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btVCBoK/GkWIUuqaUBjdFZ9MdOSjXUPL2OEO5I8PEdkUwpiEDrHdRCdKSgQRTw2mN
	 B1D3MYSJ22rVTzGOGxjv6uNB1ftPSi/NYTcSzdlfPzGvrsO3f2PpUIf6fou+jOe4Mi
	 lOCVgKplBy5loDN05j3WWa96+B3evzeCObboP9xM=
Date: Sun, 21 Sep 2025 14:26:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: cuitao@kylinos.cn, chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: Re: WTF: patch "[PATCH] LoongArch: Replace sprintf() with
 sysfs_emit()" was seriously submitted to be applied to the 6.16-stable tree?
Message-ID: <2025092104-stubbly-nimble-b45f@gregkh>
References: <2025092101-lushly-steering-6b45@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025092101-lushly-steering-6b45@gregkh>

On Sun, Sep 21, 2025 at 02:24:01PM +0200, gregkh@linuxfoundation.org wrote:
> The patch below was submitted to be applied to the 6.16-stable tree.
> 
> I fail to see how this patch meets the stable kernel rules as found at
> Documentation/process/stable-kernel-rules.rst.
> 
> I could be totally wrong, and if so, please respond to 
> <stable@vger.kernel.org> and let me know why this patch should be
> applied.  Otherwise, it is now dropped from my patch queues, never to be
> seen again.
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From d6d69f0edde63b553345d4efaceb7daed89fe04c Mon Sep 17 00:00:00 2001
> From: Tao Cui <cuitao@kylinos.cn>
> Date: Thu, 18 Sep 2025 19:44:04 +0800
> Subject: [PATCH] LoongArch: Replace sprintf() with sysfs_emit()
> 
> As Documentation/filesystems/sysfs.rst suggested, show() should only use
> sysfs_emit() or sysfs_emit_at() when formatting the value to be returned
> to user space.
> 
> No functional change intended.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> 
> diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
> index be309a71f204..23bd5ae2212c 100644
> --- a/arch/loongarch/kernel/env.c
> +++ b/arch/loongarch/kernel/env.c
> @@ -86,7 +86,7 @@ late_initcall(fdt_cpu_clk_init);
>  static ssize_t boardinfo_show(struct kobject *kobj,
>  			      struct kobj_attribute *attr, char *buf)
>  {
> -	return sprintf(buf,
> +	return sysfs_emit(buf,
>  		"BIOS Information\n"
>  		"Vendor\t\t\t: %s\n"
>  		"Version\t\t\t: %s\n"

Also, this should NOT be a sysfs file.  sysfs files are "one value per
file", this should be multiple different sysfs file.  Please fix that
up.

thanks,

greg k-h

