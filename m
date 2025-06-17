Return-Path: <stable+bounces-152866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48682ADCEAD
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE624177508
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE961156C40;
	Tue, 17 Jun 2025 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RJ6iyeTD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD311885AB
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169115; cv=none; b=Wg1yS8y9h54NHXLz/JevetXt6Ckiidy8K9gbpFxeNad+TjiGP3/0V1YIGstrBpLQnbM01Ud/7FpUwYeOudSe36YU1uNF5DMPCBDSLXjobGbL4HHfEWtWXHCaFoAclbxcFEk/NwcQuCgLdkZttxmjBtBxK76ZwrnixduIX27m7FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169115; c=relaxed/simple;
	bh=PoXsMVMd4LH4FWaXCgOKsTLtrYq+kS0nfoFKY1fHWxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PLgd9XMKvGmygmGZzxIYHkteO7iqiNM0AK9tzYQrZ/JKWt/s6MA7UAEu6oSMAnkvcmBOawQtRNZ4df6FrAsN3s2/LwMLfGysuR3E6hxq1RjvF1F0MKV58qE+ZNly7+m5fUksG2j7z6mY9D10fKIal9YoOHlKffTSfSMs3plAYe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RJ6iyeTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79BCC4CEE3;
	Tue, 17 Jun 2025 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750169115;
	bh=PoXsMVMd4LH4FWaXCgOKsTLtrYq+kS0nfoFKY1fHWxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJ6iyeTD67JBDLuNG8L13rTmKKgbeVj3iT1mrH6BjxBPbYsSDBLGT3nA4ba4pAx+V
	 ExWcWRucZNmnLMIbWIh6ifQI5CRPHTtscbjxQYz9XmYZktxtJ99/13pq3+WUJGgbxT
	 EkZS2mTVQHUwK7qcunv8Ykxsmf6yC/sqw8S2X2GI=
Date: Tue, 17 Jun 2025 16:05:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: Laura Nao <laura.nao@collabora.com>, stable@vger.kernel.org,
	Uday M Bhat <uday.m.bhat@intel.com>
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED
 unresolved symbol filp_close
Message-ID: <2025061742-underhand-defeat-eb33@gregkh>
References: <34d5cd2e-1a9e-4898-8528-9e8c2e32b2a4@manjaro.org>
 <20250320112806.332385-1-laura.nao@collabora.com>
 <0e228177-991c-4637-9f06-267f5d4c0382@manjaro.org>
 <2025040121-strongbox-sculptor-15a1@gregkh>
 <722c3acd-6735-4882-a4b1-ed5c75fd4339@manjaro.org>
 <2025060532-cadmium-shaking-833e@gregkh>
 <1faa145a-65eb-4650-a5a1-6e9f9989b73f@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1faa145a-65eb-4650-a5a1-6e9f9989b73f@manjaro.org>

On Sun, Jun 08, 2025 at 08:27:35AM +0200, Philip Müller wrote:
> On 6/5/25 10:46, Greg KH wrote:
> > I have no context here, sorry...
> 
> So basically, starting with GCC 15.1 the kernel series doesn't compile again
> and errors out with: FAILED unresolved symbol filp_close. I tested now
> v5.10.237 as well, which failed similar to v5.10.238.
> 
> There are some Debian reports out there:
> 
> https://linux.debian.bugs.dist.narkive.com/2JKeaFga/bug-1104662-failed-unresolved-symbol-filp-close-linux-kernel-5-10-237
> https://www.mail-archive.com/debian-kernel@lists.debian.org/msg142397.html
> 
> And I also found this one:
> 
> https://lists-ec2.96boards.org/archives/list/linux-stable-mirror@lists.linaro.org/thread/7XFQI52N3KGUGFLPWCSJZW6DDFZCOXP4/
> 
> For GCC 14.1 I had to add the gnu 11 patch, which was discussed already.
> Also 5.4 and 5.15 still compile with the newer toolchain ...
> 
> -- 
> Best, Philip

> Commit b3bee1e7c3f2b1b77182302c7b2131c804175870 x86/boot: Compile boot code with -std=gnu11 too
> fixed a build failure when compiling with GCC 15. The same change is required for linux-5.10.236.
> 
> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
> Modified-by: Philip Mueller <philm@manjaro.org>
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b3bee1e7c3f2b1b77182302c7b2131c804175870
> 
> 
> diff -rup linux-5.10.236.orig/arch/x86/Makefile linux-5.10.236/arch/x86/Makefile
> --- linux-5.10.236.orig/arch/x86/Makefile	2025-04-10 13:37:44.000000000 +0100
> +++ linux-5.10.236/arch/x86/Makefile	2025-04-26 19:37:38.294386968 +0100
> @@ -31,7 +31,7 @@ endif
>  CODE16GCC_CFLAGS := -m32 -Wa,$(srctree)/arch/x86/boot/code16gcc.h
>  M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
>  
> -REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
> +REALMODE_CFLAGS	:= -std=gnu11 $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
>  		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
>  		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
>  		   -mno-mmx -mno-sse $(call cc-option,-fcf-protection=none)

Can you resend this in a format we can apply it in?

Also for the newer kernels, this was only backported to 6.6.y, so
anything older than that should need this, right?

thanks,

greg k-h

