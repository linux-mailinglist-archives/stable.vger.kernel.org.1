Return-Path: <stable+bounces-89365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6213D9B6DAC
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 21:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DBEC1F2286E
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4FA1D2B23;
	Wed, 30 Oct 2024 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fdZmUvSP"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BBD1CBE92
	for <stable@vger.kernel.org>; Wed, 30 Oct 2024 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320201; cv=none; b=XL2eHT+ZY6TLgDCz8kDPvV5NPLRKxL0IgrRRmw16tRab4DwDLq0bf7geYbHxyBpFMe4WCugGWSh34yC2DjRUKUDWHVmkjHAjrdFe5mr46WYjc198wr13vGcQGIDLSXjewXHbE8lx+Qso+RQEbTRYnghj2siYECRQJhRL9NYmgY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320201; c=relaxed/simple;
	bh=93HJGLTgbfmU4Ga9/Eio2u/X1zDi+LD6+P1+EKWglDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVlNyRgm6aMEWYIKwV8ehQOO7tGS2IKjAgJqm587hqOYjgrtlOi4XvnP9Mc2tYrqIo5LixGwuYrkrmlMCCrB2fC/L7GFedFmc5Jw99VroD9i8KhXT5iIVDBKBCxeceKRMoxzat8e2eH5qHPzaptx39+nyqy7hSLq7tAIGkBsSao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fdZmUvSP; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ebab72da05so191088eaf.0
        for <stable@vger.kernel.org>; Wed, 30 Oct 2024 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730320199; x=1730924999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lzhs9CzJzUa2fis2NM7rXKutrZFN5RDZNbo/uplB2y8=;
        b=fdZmUvSPT5HuNzNk5se5v6iraHEKVKiCWsVKHxu/MJrSTb3r9JKLqaT4HjsNMjgUIU
         TRuFdSXG9YkmsfM3xzlKbGdcTmYuUNx9C6a4m+1wa6VH9BFlz2e6HauyMOOsDNjrWQS6
         n+0GmDosiEhzE1si3DS0HMQ1IKJzslj5x+jTTL4Bakmio47124OwZ18U3YOFFuuO2nnB
         fzrJ6O5jzmIZdH7ObwDJqS2Lp3EiDBbxmErf1LluHAwqSNAVUP9ax5yAcG+w3OlP9FvD
         bYGneKgvKrXS6qIUq7IFDHT6AryhKKO5Hgfj+O2peudP3cMgx3WFTm9dT8Hx3/ESh+9I
         4SiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320199; x=1730924999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzhs9CzJzUa2fis2NM7rXKutrZFN5RDZNbo/uplB2y8=;
        b=fhwXTyFa4hFLCepcT9ehCm8FLfiFDDjLY+8UiHVqVTSQ0UCeDlKZuPPhfIuesfQy+9
         8VQv4esbdltWhK1XVARpgvGj28P40ApXZ8EUB+QpTphRVxMiTVEcHsLRxxFB98wUzeGf
         wJuXb+CIF4PT0sInnhqCeGk5sCFmcs80UkzLLbxIOhYv9wHG0p61CDm5huq4aLDoHsp0
         I+g51TG+9FdpsRmHog3i9/Yn+XzJNv7DQdIZZizlvyvi/2Q+Pb+qArjXqyyqrzIIwgIT
         IZNsC1eI+GUUxkDr6lX8agEzLlhy/rxcaJDQBAlbK3NPRLSoxxdEsBJ40aC7XXb4qdqC
         UuSA==
X-Forwarded-Encrypted: i=1; AJvYcCUmYfSxIu/eXZFCZ+uWXKM0KeyPtpcWXJDoln6KPG3jXnEBOM9FGnd66da9BnUdaEFndHu7mBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsD3dPYJLh5pDCZuzDfJY1Kat232os0S8f/WL9hEGTi5PydiCk
	3lI4y5Pki1Ti8fa4bmuGN5C14ydUvo2Vj7uZR2NTgZsJpkTXl8/Bksp8Flri9LI=
X-Google-Smtp-Source: AGHT+IGugtSsfrdS550hxkLjV1CPYL/1QAuDGyIppcHvzkOuG66PHU45rII5RLCam+kiCWtUmskhpg==
X-Received: by 2002:a05:6358:94a2:b0:1bc:573a:401a with SMTP id e5c5f4694b2df-1c3f9d13410mr888713055d.5.1730320198770;
        Wed, 30 Oct 2024 13:29:58 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc670dsm199176d6.36.2024.10.30.13.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:29:57 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:30:03 -0400
From: Gregory Price <gourry@gourry.net>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Jiri Slaby <jirislaby@kernel.org>,
	Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] efistub/tpm: Use ACPI reclaim memory for event log to
 avoid corruption
Message-ID: <ZyKXS1iq3MT-0dQI@PC2K9PVX.TheFacebook.com>
References: <20240912155159.1951792-2-ardb+git@google.com>
 <ec7db629-61b0-49aa-a67d-df663f004cd0@kernel.org>
 <29b39388-5848-4de0-9fcf-71427d10c3e8@kernel.org>
 <58da4824-523c-4368-9da1-05984693c811@kernel.org>
 <899f209b-d4ec-4903-a3e6-88b570805499@gmail.com>
 <b7501b2c-d85f-40aa-9be5-f9e5c9608ae4@kernel.org>
 <e42149a6-7c1f-48d1-be94-1c1082b450e0@gmail.com>
 <ZyJ6QHc9FetDckqo@PC2K9PVX.TheFacebook.com>
 <CAMj1kXERg=g_G37uax7U6Pf_Umx_Tt9vABJoFHjXYAVaJ8AwPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXERg=g_G37uax7U6Pf_Umx_Tt9vABJoFHjXYAVaJ8AwPw@mail.gmail.com>

On Wed, Oct 30, 2024 at 08:43:01PM +0100, Ard Biesheuvel wrote:
> On Wed, 30 Oct 2024 at 19:26, Gregory Price <gourry@gourry.net> wrote:
> >
> > On Wed, Oct 30, 2024 at 05:13:14PM +0000, Usama Arif wrote:
> > >
> > >
> > > On 30/10/2024 05:25, Jiri Slaby wrote:
> > > > On 25. 10. 24, 15:27, Usama Arif wrote:
> > > >> Could you share the e820 map, reserve setup_data and TPMEventLog address with and without the patch?
> > > >> All of these should be just be in the dmesg.
> > > > efi: EFI v2.6 by American Megatrends
> >
> > Tossing in another observation - the AMI EFI we've been working with has been
> >
> > EFI v2.8 by American Megatrends
> > or
> > EFI v2.9 by American Megatrends
> >
> > We have not seen this particular behavior (cold boot corruption issues) on top
> > of these version.  Might be worth investigating this issue.
> >
> > you may also want to investigate this patch set:
> >
> > https://lore.kernel.org/all/20240913231954.20081-1-gourry@gourry.net/
> >
> > which I believe would have caught your "eat all memory" sign extention issue.
> >
> > This is queued up for v6.13 i think - but possibly 1/4 deserves a stable mark.
> >
> 
> To me, it does not seem obvious at all that the TPM code is the
> culprit here. The firmware produces a corrupted memory attributes
> table now that the EFI stub uses ACPI reclaim memory for the TPM event
> log, but to me, it smells like a firmware issue, not an issue in the
> EFI stub. (Pool allocations can trigger page allocations, affecting
> the layout of the EFI memory map).
> 
> So let's keep an open mind here, and not stare ourselves blind on the
> TPM event log code.

Agreed, just working backward a bit - this definitely feels like something
is wrong in the state of Denm... firmware.

~Gregory

