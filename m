Return-Path: <stable+bounces-67455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73917950281
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 12:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6ACF1C20C9C
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3418DF62;
	Tue, 13 Aug 2024 10:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rqiJwKO/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2929A208AD;
	Tue, 13 Aug 2024 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545138; cv=none; b=frK9SrQY5txlpZoQO0brDSNPt6m2XMKYcC7AUetrooz/RJnI/bSAwSB2NfFRaqn0J+92pSL9h6L01HVqxDUIq2oiLLjdOnf0q7gl6GOPaHWiW/0rg3C9kozVO3YikXwgOERl8xuXbY4vge+O3v3x5cUwzFaskbp9vIrGAWZf2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545138; c=relaxed/simple;
	bh=Cbw4bmDrxPKsakV5v51GE0p9nhQRBT0XmB9HnhS7H/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QP9Dsch28GPK9Y19tUP0vvypqne8VeFsYGVqgWijEM9gRyIbZSoqgeVhZobCHScVv8zJaDCZ8MyuQHxkdmfUJWerdqPuUz3VgUDk5Fdg0dF0VvStfs0xn01c8oa9YD+EwiOTPC9LWvrdm4NhAEcns23VBKBN+xfTY2mqYVPZXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rqiJwKO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F14BC4AF09;
	Tue, 13 Aug 2024 10:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723545137;
	bh=Cbw4bmDrxPKsakV5v51GE0p9nhQRBT0XmB9HnhS7H/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqiJwKO/GPFmhg0NYu0fJImqoWwX658Vm37O5r/iZDYei7eto9DW+Sls7QyyU18CR
	 bNLHhqOJ9xiUGCvyjx1t58e8Az8Hed6xo01AzjBfLxFuxT0fJa0KzYYOQl6MwNR7sl
	 km72lVSSGfHfw17ZJR/yJA7JYb5LJa/Hm4FFXCkI=
Date: Tue, 13 Aug 2024 12:32:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jari Ruusu <jariruusu@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 00/59] 5.10.223-rc1 review
Message-ID: <2024081303-quotable-legroom-1850@gregkh>
References: <veJcp8NcM5qwkB_p0qsjQCFvZR5U4SqezKKMnUgM-khGFC4sCcvkodk-beWQ2a4qd3IxUYaLdGp9_GBwf3FLvkoU8f1MXjSk3gCsQOKnXZw=@protonmail.com>
 <2024072633-easel-erasure-18fa@gregkh>
 <vp205FIjWV7QqFTJ2-8mUjk6Y8nw6_9naNa31Puw1AvHK8EinlyR9vPiJdEtUgk0Aqz9xuMd62uJLq0F1ANI5OGyjiYOs3vxd0aFXtnGnJ4=@protonmail.com>
 <2024072635-dose-ferment-53c8@gregkh>
 <93RnVgeI76u-tf0ZRdROl_JVVqqx-rtQnV4mOqGR_Rb5OmiWCMXC6MSYfnkTPp_615nKq8H-5nfzNt4I9MXPjUPzXBLp625jtGUJSGPsGBo=@protonmail.com>
 <2024072627-pasture-denim-0390@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024072627-pasture-denim-0390@gregkh>

On Fri, Jul 26, 2024 at 12:23:02PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 26, 2024 at 09:53:18AM +0000, Jari Ruusu wrote:
> > On Friday, July 26th, 2024 at 11:52, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > Also the "Fixes:" tag is not in the correct format, please fix that up
> > > at the very least.
> > 
> > Some older systems still compile kernels with old gcc version.
> > These warnings and errors show up when compiling with gcc 4.9.2
> > 
> >  error: "__GCC4_has_attribute___uninitialized__" is not defined [-Werror=undef]
> > 
> > Following patch fixes this. Upstream won't need this because  
> > newer kernels are not compilable with gcc 4.9.
> > 
> > Subject: gcc-4.9 warning/error fix for 5.10.223-rc1
> > Fixes: fd7eea27a3ae ("Compiler Attributes: Add __uninitialized macro")
> > Signed-off-by: Jari Ruusu <jariruusu@protonmail.com>
> > 
> > --- ./include/linux/compiler_attributes.h.OLD
> > +++ ./include/linux/compiler_attributes.h
> > @@ -37,6 +37,7 @@
> >  # define __GCC4_has_attribute___nonstring__           0
> >  # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
> >  # define __GCC4_has_attribute___no_sanitize_undefined__ (__GNUC_MINOR__ >= 9)
> > +# define __GCC4_has_attribute___uninitialized__       0
> >  # define __GCC4_has_attribute___fallthrough__         0
> >  # define __GCC4_has_attribute___warning__             1
> >  #endif
> > 
> > --
> > Jari Ruusu  4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD  ACDF F073 3C80 8132 F189
> > 
> 
> Better, thanks!  I'll touch this up by hand and apply it to the relevant
> branches (not just this one needs it), for the next round of stable
> releases.

Now queued up.

greg k-h

