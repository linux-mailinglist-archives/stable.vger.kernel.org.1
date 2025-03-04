Return-Path: <stable+bounces-120353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFD5A4EB03
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 19:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540428A6E13
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A2F2836A5;
	Tue,  4 Mar 2025 16:59:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailsrv.ikr.uni-stuttgart.de (mailsrv.ikr.uni-stuttgart.de [129.69.170.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8688284B22
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.170.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107581; cv=none; b=RrcUKuWT+dS7Tk2U7CU9M0mGOoS9LnZBloXTwVKAf2vBjTYyLvo+Gumfkq1nXMzDqrUfH2VLuDG2BDAe8V5Co1SfSDjCVMUoX63tab56HtlXsoPoMI8Il/WeVGSoM6dqtx+ND3DKv51g1/C66wSe/bxpQedm6Z8nO3iGWJ+8yQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107581; c=relaxed/simple;
	bh=jKZemWZ3/xr5QzpT4f9HB0M6zs55t9Vl6iG5VCo0riQ=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=owCfkYndklLJ+M8Djv/U0n/9DMZ5Nen0/BFbfzHVNFsmz/aWU7Ean5guecJ1CEgvy5pXuqCxzXgGUT9xDk6ILy3PHxbhfV99k+OJuCjGcyusqS+tMWaLGrHJSatFdocaQwlpxZq+N6YVMS/GSisgb50mASQPL32zYQYjqFiZZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikr.uni-stuttgart.de; spf=pass smtp.mailfrom=ikr.uni-stuttgart.de; arc=none smtp.client-ip=129.69.170.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikr.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikr.uni-stuttgart.de
Received: from netsrv1.ikr.uni-stuttgart.de (netsrv1 [10.21.12.12])
	by mailsrv.ikr.uni-stuttgart.de (Postfix) with ESMTP id D9B971B396CE;
	Tue,  4 Mar 2025 17:59:34 +0100 (CET)
Received: from ikr.uni-stuttgart.de (pc021 [10.21.21.21])
	by netsrv1.ikr.uni-stuttgart.de (Postfix) with SMTP id C7DA81B396CD;
	Tue,  4 Mar 2025 17:59:32 +0100 (CET)
Received: by ikr.uni-stuttgart.de (sSMTP sendmail emulation); Tue, 04 Mar 2025 17:59:32 +0100
From: Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Organization: University of Stuttgart (Germany), IKR
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Regression for PXE boot from patch "Remove the 'bugger off' message" in stable 6.6.18
Date: Tue, 4 Mar 2025 17:59:32 +0100
User-Agent: KMail/1.9.10
Cc: stable@vger.kernel.org,
 regressions@lists.linux.dev,
 ardb@kernel.org
References: <202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de> <2025030459-singer-compactor-9c91@gregkh>
In-Reply-To: <2025030459-singer-compactor-9c91@gregkh>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202503041759.32756.ulrich.gemkow@ikr.uni-stuttgart.de>

Hallo,

On Tuesday 04 March 2025, Greg KH wrote:
> On Tue, Mar 04, 2025 at 03:49:35PM +0100, Ulrich Gemkow wrote:
> > Hello,
> > 
> > starting with stable kernel 6.6.18 we have problems with PXE booting.
> > A bisect shows that the following patch is guilty:
> > 
> >   From 768171d7ebbce005210e1cf8456f043304805c15 Mon Sep 17 00:00:00 2001
> >   From: Ard Biesheuvel <ardb@kernel.org>
> >   Date: Tue, 12 Sep 2023 09:00:55 +0000
> >   Subject: x86/boot: Remove the 'bugger off' message
> > 
> >   Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >   Signed-off-by: Ingo Molnar <mingo@kernel.org>
> >   Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> >   Link: https://lore.kernel.org/r/20230912090051.4014114-21-ardb@google.com
> > 
> > With this patch applied PXE starts, requests the kernel and the initrd.
> > Without showing anything on the console, the boot process stops.
> > It seems, that the kernel crashes very early.
> > 
> > With stable kernel 6.6.17 PXE boot works without problems.
> > 
> > Reverting this single patch (which is part of a larger set of
> > patches) solved the problem for us, PXE boot is working again.
> > 
> > We use the packages syslinux-efi and syslinux-common from Debian 12.
> > The used boot files are /efi64/syslinux.efi and /ldlinux.e64.
> > 
> > Our config-File (for 6.6.80) is attached.
> > 
> > Regarding the patch description, we really do not boot with a floppy :-)
> > 
> > Any help would be greatly appreciated, I have a bit of a bad feeling
> > about simply reverting a patch at such a deep level in the kernel.
> 
> Does newer kernels than 6.7.y work properly?  What about the latest
> 6.12.y release?
> 
> thanks,
> 
> greg k-h
> 

Thanks for looking into this!

The latest 6.12.y kernel has the same problem, it also needs reverting
the mentioned patch. I did not test Kernels in between but I am happy
to do so, when this gives a hint.

Thanks again and best regards

Ulrich

-- 
|-----------------------------------------------------------------------
| Ulrich Gemkow
| University of Stuttgart
| Institute of Communication Networks and Computer Engineering (IKR)
|-----------------------------------------------------------------------

