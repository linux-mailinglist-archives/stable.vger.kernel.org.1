Return-Path: <stable+bounces-61861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819B493D10D
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 12:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC4EAB21902
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 10:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631B17838D;
	Fri, 26 Jul 2024 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g72wm0mv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3122B9C4;
	Fri, 26 Jul 2024 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721989391; cv=none; b=CpJ67CRBc/7xbJnx3wEqRBeHSO/TfW6bxXqtP3KWYvnpzNhRhhVOX0SP7Ay6bW5T5D+Myhpfmd6VyX+21u1mW5MPzLmmI+eFB+nMLopvZH0AYEbxRC8/AUFZVh5Rq6qAfNt/ig/gYHT0NEnZZWB8DBLVs+SNEO3pj2TiuAyGHjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721989391; c=relaxed/simple;
	bh=kDbnJM5usfOL8WK3gKBTN7Odhzpvp6wRPgN3PjFOrvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUR/Y2mpXWRTISwAcHyIvtKKz7H3eakLT6Hu390M3mk4q4jFiJk5jwX3FIUpejqaJDsr7lH4rDNmoJVg9sM3cbeG1xQjSZXpY9QqXzh0lO51cwDOvLhY6sgj1CHPm9LXXqGmWAtbnFMYYOE6a+ktt7Tz8nqfTQzVKYy3pOTNI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g72wm0mv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6671CC4AF09;
	Fri, 26 Jul 2024 10:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721989390;
	bh=kDbnJM5usfOL8WK3gKBTN7Odhzpvp6wRPgN3PjFOrvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g72wm0mvx2CeHrbncrY8SRUqVz8nQr35oZ/nEN8tMlvF7FslUrlPh2Olk4WmU2dK1
	 BDlcXpagG4Lp3SSfiRfXphcp45JAqd+CMMn8PeoLmUOPfW+05+xMEXp4PNEblG95t7
	 hpN25C26yEkfnRu/cjmJ8zRZPgf/0u/AyN2fC5Kw=
Date: Fri, 26 Jul 2024 12:23:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jari Ruusu <jariruusu@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 00/59] 5.10.223-rc1 review
Message-ID: <2024072627-pasture-denim-0390@gregkh>
References: <veJcp8NcM5qwkB_p0qsjQCFvZR5U4SqezKKMnUgM-khGFC4sCcvkodk-beWQ2a4qd3IxUYaLdGp9_GBwf3FLvkoU8f1MXjSk3gCsQOKnXZw=@protonmail.com>
 <2024072633-easel-erasure-18fa@gregkh>
 <vp205FIjWV7QqFTJ2-8mUjk6Y8nw6_9naNa31Puw1AvHK8EinlyR9vPiJdEtUgk0Aqz9xuMd62uJLq0F1ANI5OGyjiYOs3vxd0aFXtnGnJ4=@protonmail.com>
 <2024072635-dose-ferment-53c8@gregkh>
 <93RnVgeI76u-tf0ZRdROl_JVVqqx-rtQnV4mOqGR_Rb5OmiWCMXC6MSYfnkTPp_615nKq8H-5nfzNt4I9MXPjUPzXBLp625jtGUJSGPsGBo=@protonmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93RnVgeI76u-tf0ZRdROl_JVVqqx-rtQnV4mOqGR_Rb5OmiWCMXC6MSYfnkTPp_615nKq8H-5nfzNt4I9MXPjUPzXBLp625jtGUJSGPsGBo=@protonmail.com>

On Fri, Jul 26, 2024 at 09:53:18AM +0000, Jari Ruusu wrote:
> On Friday, July 26th, 2024 at 11:52, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > Also the "Fixes:" tag is not in the correct format, please fix that up
> > at the very least.
> 
> Some older systems still compile kernels with old gcc version.
> These warnings and errors show up when compiling with gcc 4.9.2
> 
>  error: "__GCC4_has_attribute___uninitialized__" is not defined [-Werror=undef]
> 
> Following patch fixes this. Upstream won't need this because  
> newer kernels are not compilable with gcc 4.9.
> 
> Subject: gcc-4.9 warning/error fix for 5.10.223-rc1
> Fixes: fd7eea27a3ae ("Compiler Attributes: Add __uninitialized macro")
> Signed-off-by: Jari Ruusu <jariruusu@protonmail.com>
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
> --
> Jari Ruusu  4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD  ACDF F073 3C80 8132 F189
> 

Better, thanks!  I'll touch this up by hand and apply it to the relevant
branches (not just this one needs it), for the next round of stable
releases.

greg k-h

