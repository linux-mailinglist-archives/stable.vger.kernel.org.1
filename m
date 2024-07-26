Return-Path: <stable+bounces-61832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4632993CF10
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 09:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016302833C2
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 07:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC53D176AAD;
	Fri, 26 Jul 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tBBVx19b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EBB17622D;
	Fri, 26 Jul 2024 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721980193; cv=none; b=iRssK2GY56FK+kOWeoivtbi3pLN6GkpCeWNvW26XW2NFpdFDql4Iqkv6kk2bucIe+8ba+AxxGg78gGLy2o1Pu5RUISlGww6qKJC/Hh3kRe2JrQWskQI5A1N6sfU7pc6Uwyea3oubTQqqQJnvrvrRTjSEptrjpul5q4vyZYKjb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721980193; c=relaxed/simple;
	bh=O9rUFTpLz4JvgDvdUNS3foCZevOXg2iHG6k08D0hF/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+1RNN35IFt+G1rP0xxsQat2Wsk4BlsGDcx2Qn74iNLCF+PvTYisS5scddlCCcSeKmySSCsyEvjQPdqaXalQFuYrRk16nAQChSO+5dagz37C2b1bw5OjLlUd/UiCIwxBUzNhAtEEFWbGjLB5roPwYhZ/3UK7/Vd6ldG5R06CjMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tBBVx19b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C631C32782;
	Fri, 26 Jul 2024 07:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721980193;
	bh=O9rUFTpLz4JvgDvdUNS3foCZevOXg2iHG6k08D0hF/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tBBVx19bbejTkzjaavMrBA21rdcP2REQ/Rxtr0zq8XAK/fdWSQlrN3rXmKEG8MwCQ
	 rjYBWqN1fbtwH3b1W0RRQ+zllGDDv9hjzUh+J+Kbmc3yMpnAmdqJ3B2O/4yiSxG0Qj
	 OVVJkgJHvD3tY5UQh+4vgT8qBBGRGD1FlFiRQbmU=
Date: Fri, 26 Jul 2024 09:49:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jari Ruusu <jariruusu@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 00/59] 5.10.223-rc1 review
Message-ID: <2024072633-easel-erasure-18fa@gregkh>
References: <veJcp8NcM5qwkB_p0qsjQCFvZR5U4SqezKKMnUgM-khGFC4sCcvkodk-beWQ2a4qd3IxUYaLdGp9_GBwf3FLvkoU8f1MXjSk3gCsQOKnXZw=@protonmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <veJcp8NcM5qwkB_p0qsjQCFvZR5U4SqezKKMnUgM-khGFC4sCcvkodk-beWQ2a4qd3IxUYaLdGp9_GBwf3FLvkoU8f1MXjSk3gCsQOKnXZw=@protonmail.com>

On Fri, Jul 26, 2024 at 07:25:21AM +0000, Jari Ruusu wrote:
> Some older systems still compile kernels with old gcc version.
> 
> $ grep -B3 "^GNU C" linux-5.10.223-rc1/Documentation/Changes 
> ====================== ===============  ========================================
>         Program        Minimal version       Command to check the version
> ====================== ===============  ========================================
> GNU C                  4.9              gcc --version
> 
> These warnings and errors show up when compiling with gcc 4.9.2
> 
>   UPD     include/config/kernel.release
>   UPD     include/generated/uapi/linux/version.h
>   UPD     include/generated/utsrelease.h
>   CC      scripts/mod/empty.o
> In file included from ././include/linux/compiler_types.h:65:0,
>                  from <command-line>:0:
> ./include/linux/compiler_attributes.h:29:29: warning: "__GCC4_has_attribute___uninitialized__" is not defined [-Wundef]
>  # define __has_attribute(x) __GCC4_has_attribute_##x
>                              ^
> ./include/linux/compiler_attributes.h:278:5: note: in expansion of macro '__has_attribute'
>  #if __has_attribute(__uninitialized__)
>      ^
> [SNIP]
>   AR      arch/x86/events/built-in.a
>   CC      arch/x86/kvm/../../../virt/kvm/kvm_main.o
> In file included from ././include/linux/compiler_types.h:65:0,
>                  from <command-line>:0:
> ./include/linux/compiler_attributes.h:29:29: error: "__GCC4_has_attribute___uninitialized__" is not defined [-Werror=undef]
>  # define __has_attribute(x) __GCC4_has_attribute_##x
>                              ^
> ./include/linux/compiler_attributes.h:278:5: note: in expansion of macro '__has_attribute'
>  #if __has_attribute(__uninitialized__)
>      ^
> cc1: all warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:286: arch/x86/kvm/../../../virt/kvm/kvm_main.o] Error 1
> make[1]: *** [scripts/Makefile.build:503: arch/x86/kvm] Error 2
> make: *** [Makefile:1832: arch/x86] Error 2
> 
> Following patch fixes this. Upstream won't need this because
> newer kernels are not compilable with gcc 4.9
> 
> --- ./include/linux/compiler_attributes.h.OLD
> +++ ./include/linux/compiler_attributes.h
> @@ -37,6 +37,7 @@
>  # define __GCC4_has_attribute___nonstring__           0
>  # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
>  # define __GCC4_has_attribute___no_sanitize_undefined__ (__GNUC_MINOR__ >= 9)
> +# define __GCC4_has_attribute___uninitialized__       0
>  # define __GCC4_has_attribute___fallthrough__         0
>  # define __GCC4_has_attribute___warning__             1
>  #endif
> 
> Fixes: upstream fd7eea27a3ae "Compiler Attributes: Add __uninitialized macro"
> Signed-off-by: Jari Ruusu <jariruusu@protonmail.com>

Please submit this in a format in which we can apply it, thanks!

greg k-h

