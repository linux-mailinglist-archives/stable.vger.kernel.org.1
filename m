Return-Path: <stable+bounces-121203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE0BA54755
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 11:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C86E618889B0
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2CD1F03D2;
	Thu,  6 Mar 2025 10:07:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailsrv.ikr.uni-stuttgart.de (mailsrv.ikr.uni-stuttgart.de [129.69.170.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A011A08A6
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.170.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255646; cv=none; b=MEHnYgMH8YGzAXMyFibd5m/4BzUciL+3IhKdMhf+B7ATtEC6OJDz3oPc8KChiMfqP3dp0XYTo7lgkFDau+10DXxSEylDNfAisyMR8trr+ldyOjij1RK0oUDkJbLlkGYwzE2KZ1wpIocqlbS5bdNcH0C86P0blDa5PrmVqXYsE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255646; c=relaxed/simple;
	bh=0PJImwDxowScFpAr5sxFHkDazd+GIR7gQTpREkQKAHw=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Message-Id; b=qQJq3ZvN5zG0ZyLmIqr5sqDtFwuFT8vtv+kGYREOJ55VSbGF3QQ6O3qnoFCdYCo3jaEuw6WURL3whn4t5ZMaEWcXFQ/3RKMwCBfaEKzFoobkSNE11Nabh1pHJcGOcJfRwBnxpCnTRLBfudvt+dxLhBbsFfye9ZfjBymG6+AC2QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikr.uni-stuttgart.de; spf=pass smtp.mailfrom=ikr.uni-stuttgart.de; arc=none smtp.client-ip=129.69.170.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ikr.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikr.uni-stuttgart.de
Received: from netsrv1.ikr.uni-stuttgart.de (netsrv1 [10.21.12.12])
	by mailsrv.ikr.uni-stuttgart.de (Postfix) with ESMTP id 1BAE51B39D3E;
	Thu,  6 Mar 2025 11:07:15 +0100 (CET)
Received: from ikr.uni-stuttgart.de (pc021 [10.21.21.21])
	by netsrv1.ikr.uni-stuttgart.de (Postfix) with SMTP id 093B81B39D3C;
	Thu,  6 Mar 2025 11:07:13 +0100 (CET)
Received: by ikr.uni-stuttgart.de (sSMTP sendmail emulation); Thu, 06 Mar 2025 11:07:12 +0100
From: Ulrich Gemkow <ulrich.gemkow@ikr.uni-stuttgart.de>
Organization: University of Stuttgart (Germany), IKR
To: Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Regression for PXE boot from patch "Remove the 'bugger off' message" in stable 6.6.18
Date: Thu, 6 Mar 2025 11:07:12 +0100
User-Agent: KMail/1.9.10
Cc: stable@vger.kernel.org,
 regressions@lists.linux.dev
References: <202503041549.35913.ulrich.gemkow@ikr.uni-stuttgart.de> <CAMj1kXE7bzBV+Gzt4iuAfDpFzW=b0j0ncH9xxCGZkiexvfH3zQ@mail.gmail.com>
In-Reply-To: <CAMj1kXE7bzBV+Gzt4iuAfDpFzW=b0j0ncH9xxCGZkiexvfH3zQ@mail.gmail.com>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QPXyn022XafPQL2"
Message-Id: <202503061107.12978.ulrich.gemkow@ikr.uni-stuttgart.de>

--Boundary-00=_QPXyn022XafPQL2
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 06 March 2025, Ard Biesheuvel wrote:
> On Tue, 4 Mar 2025 at 15:49, Ulrich Gemkow
> <ulrich.gemkow@ikr.uni-stuttgart.de> wrote:
> >
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
> >
> 
> Hello Ulrich,
> 
> Thanks for the report, and apologies for the breakage.
> 
> I will look into this today - hopefully it is something that can be
> resolved swiftly.
> 
> Can you share your syslinux config too, please?
> 

Hello Ard,

Thank you! The config file is attached. Please feel free to
ask for more info.

Best regards

Ulrich

-- 
|-----------------------------------------------------------------------
| Ulrich Gemkow
| University of Stuttgart
| Institute of Communication Networks and Computer Engineering (IKR)
|-----------------------------------------------------------------------

--Boundary-00=_QPXyn022XafPQL2
Content-Type: text/plain;
  charset="iso-8859-15";
  name="Local.cfg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Local.cfg"

DEFAULT lnc

LABEL lnc
  KERNEL image/bzImage-Local
  INITRD lnc-ramdisc-simple.gz
  APPEND rw root=/dev/ram0 ip=::::::on quiet ignore_rlimit_data

--Boundary-00=_QPXyn022XafPQL2--

