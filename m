Return-Path: <stable+bounces-89197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C72D9B4AAD
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 14:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0271C22671
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B179FC12;
	Tue, 29 Oct 2024 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="PlyFs9qd"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF6BE49
	for <stable@vger.kernel.org>; Tue, 29 Oct 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207670; cv=none; b=NMosmLLavZsgGRuLYczonvjQKdCofoi1vJPa0aOa3UsliPoaSj2Zku34x03PblMiDwAfNjhBgHuzVsQyJlZTA1J1q/qra9Eckf4053zQ334pxTIJuOz2iNkli8ndBczNG+5gfCjbH4c+9K3kfabXL3hHLqeGPH1a7ZkdN3aCUE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207670; c=relaxed/simple;
	bh=IIPXxAlohIBQMRgfL/9tiRs4muoLb2OD//ZNGmMakr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8TjU317LX09f53cWQA860u3FddvbOay6wlQ7hhVOPjVtQEiuEVC7c/lRabZRZz0RCAYzBqchL15gqZ2vUPq+lmxKbAp/erNLVVEoPiDRiRzzVnzAYJnr0lQyFdvY80GCnFtnFDTlWRGuB4dQLt3DVaCu2+LrroR0EhtKFOubkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=PlyFs9qd; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5eb9ee4f14cso2352027eaf.1
        for <stable@vger.kernel.org>; Tue, 29 Oct 2024 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730207667; x=1730812467; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XgHWZeva7maOXfA4dcpD4/yUTRZxAZ0VWdzeeo/n/OI=;
        b=PlyFs9qd2uethuGLGYqhzqpQs2a9Ifk5Pek/g/YiEnUpOuFPDKTWLDHrFKkxf+p0CO
         +ohCHOUAeLA1No/NV1t411sNY0haOFW3rp2V1uzg5lg7JMq27533o5dxURIQKODaVTjP
         BZRSBkCkmchTgA+wiMzPQzCSHRLzeAqbSPpmUNQmQsFq8WDKoCobi7Wy3YYT7oEqI339
         pUhwCKBm+mOT95Sqq3uD12r/ld29uo/5M9eGvXrQ/wSdUmG1HqTfnVt9uhxNOYGwQQzc
         7cCIaLj8valnl+hUEO3kUwBQWVD/4gT/276rEMOuMcE3iTBnmzWq3zML2CW+7+geBxcN
         XeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730207667; x=1730812467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgHWZeva7maOXfA4dcpD4/yUTRZxAZ0VWdzeeo/n/OI=;
        b=IvycpIcaBrrkD8H0uy5vzzKOeOVGsPTb4GAudVduz1b4+gobIcogaOLMQU0qJ6p764
         ZL1aRruV6HNe80f7Mpw80ZDFLmGaGuuNT7VzvlOJQ8XoAyUd7zjneHp79IxzElOzCJxD
         G+Ks8E2ytrv5A7CvTkRN8UIBv9sYvpBOv8gItWsmbUviMD6L3yni92eNbGxRw/Q7xmo6
         FtX05lZZAb85w7fMEEPRPec3wRcuGl4CDzCHm+34m/5fF0639MF7LzjKrUDEJpS1MUCM
         mPpt3qXo7neKPfMRmE2zBj0DK0/YG9s96psNDL1ufB5uxNajVXkNMGetRwdPBUqGohDC
         YTEg==
X-Forwarded-Encrypted: i=1; AJvYcCXYoa3S3gYrCJ/tvR9ZVoxu9dPc/ZdzwdNk3TrOrZKqi74aU8ezmB5Yd7kyeTZrF2dskGTfMQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu0JJ/M3xi5lg++I/b9ccLPoKQGX86ltJmCvxRNLZBUrUNQgqd
	Nh0604cUEXJ47KTAo7Je8X7dAo5cpiDjORpmqAHtSHZCfqYo0Li14RsQUwcZ4mw=
X-Google-Smtp-Source: AGHT+IHz+NNrjULPFoAIl+FSuatbeF1xkLR3jMaYOwi1/n+4BRut5A+RUaFtsJaH3CWulwSTLeWrhQ==
X-Received: by 2002:a05:6359:4129:b0:1c3:83d8:3219 with SMTP id e5c5f4694b2df-1c3f9d4989bmr502993955d.4.1730207666666;
        Tue, 29 Oct 2024 06:14:26 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798b764bsm41775366d6.44.2024.10.29.06.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:14:25 -0700 (PDT)
Date: Tue, 29 Oct 2024 09:14:31 -0400
From: Gregory Price <gourry@gourry.net>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Yang Shi <shy828301@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, akpm@linux-foundation.org,
	weixugc@google.com, dave.hansen@linux.intel.com, osalvador@suse.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] vmscan,migrate: fix double-decrement on node stats when
 demoting pages
Message-ID: <ZyDft_sCKm2vBF1j@PC2K9PVX.TheFacebook.com>
References: <20241025141724.17927-1-gourry@gourry.net>
 <CAHbLzkqYoHTQz6ifZHuVkWL449EVt9H1v2ukXhS+ExDC2JZMHA@mail.gmail.com>
 <ZyABO4wOoXs9vC3F@PC2K9PVX.TheFacebook.com>
 <87msinwxut.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msinwxut.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Tue, Oct 29, 2024 at 08:34:34AM +0800, Huang, Ying wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> > On Mon, Oct 28, 2024 at 01:45:48PM -0700, Yang Shi wrote:
> >> On Fri, Oct 25, 2024 at 7:17 AM Gregory Price <gourry@gourry.net> wrote:
> >> >
> >> > This path happens for SUCCESSFUL migrations, not failures. Typically
> >> > callers to migrate_pages are required to handle putback/accounting for
> >> > failures, but this is already handled in the shrink code.
> >> 
> >> AFAIK, MGLRU doesn't dec/inc this counter, so it is not
> >> double-decrement for MGLRU. Maybe "imbalance update" is better?
> >> Anyway, it is just a nit. I'd suggest capturing the MGLRU case in the
> >> commit log too.
> >>
> >
> > Gotcha, so yeah saying it's an imbalance fix is more accurate.
> >
> > So more accurate changelog is:
... 
> 
> I think that it may be better to mention the different behavior of LRU
> and MGLRU.  But that's not a big deal, change it again only if you think
> it's necessary.
>

The behavior isn't really different. It's either way migrate_pages decrements
when it shouldn't going through the shink code - and both LRU and MGLRU go
through the same code.  That LRU does an inc/dec pair is irrelevant - neither
should do the decrement in the migrate path.

~Gregory

