Return-Path: <stable+bounces-71423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F466962D23
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 18:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87341F2313F
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 16:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153E21A3BB8;
	Wed, 28 Aug 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+dVnNrZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D91A3BAA
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860886; cv=none; b=TRlfLEy6Bd14mfJ/FHB75aAnWRZgI31b4N+096HA8ZYyapfHcSDwDIWV9B5B3KQXQAzL5DcpR56atqw372DKBVOXJnopyfnpGznv0h61GuFAxReorCVItTXXqXIQX7OuLuTdxMNU+4NkrKdYA69ESxtkvGY8T4DuUKkvzVE/ArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860886; c=relaxed/simple;
	bh=Q+zCH6CIpKnoyZHsS1Qhan3rN103TRwackyY3inVywY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM52PDumEVpATii6/nrReXx5rxmn1uOUo0g7HjaagW0aEJyY1XuGauReF19mBdGJIC+e8irUvyehh8zBQo+UObO7GbcyZHKr7ZXrrjf9WUew12HKpbC3DHsIYfQCHIix/nKbmfdoPCEe1MiM2mQ+zvNtnMQbLIaec8tx97mqP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j+dVnNrZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-715c160e231so2064263b3a.0
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724860884; x=1725465684; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z2ixJv0d9xC41XICxpB9ZznJbdJErFOiF3hT67NfCAQ=;
        b=j+dVnNrZ4jO9AzfILbypGhAmXmM5ZeGp6kJChgkyUY30akaW1WCLJRFCrIxY7yNZFs
         hgt9jlHjJ0o/oHsr/BsYpAXE2jxUgy5wumdTkXd2a2bIX/9ZK4ZfrrbJ7fY3Jaz8OYp+
         o2sMaxe0GTe0doeXkmrRwXayam2oIVy7fibgx28dtcYoGxJ48qHlW6fOK0b5edqeVhTl
         H8Q4oJnwqjwzMGJQaD0Q53VNGIgMSctAGcBQnV9Z4+rKerq1xXtPdjpEmBgMRJNx5ZgN
         YCQ0NEJxp+X4yD31UwUOkf/ihtCONMtt0VfKRQcJaH6+6ZV4IZyWZM7jRgjHCERlitgw
         ilYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724860884; x=1725465684;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2ixJv0d9xC41XICxpB9ZznJbdJErFOiF3hT67NfCAQ=;
        b=p/z6BX8bzt42x6xdAlIObqsjO5GxuhAJZw55/nxjVAw6x10+1ipkvvhHqQukyrbIGd
         Mcjx7WcEstrL3xukvU5+KVvLZZZTwkdLGtZrb2kL++dy+rUUfoKPPgfFsIWT9VOXI8c0
         u9Irvj4P9VhczcFT2MCZYDr6bq2m0DleuOCmAX8UKDznPR5vPYqm4U7oUr3DfF10H5Wq
         F/iyX9U/FiMP1XSeQBsFudzNFU4X+WOdWNqoufgvpownlbguJTRB/RFKczKrbesNEhH/
         R5emnIPLu7t0WU9cc58KSXiZ+M70fuZN55EdzuH8VNHryPNcBlDkca9HiimUUtvjGJAm
         C+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCaQ+nDdFk/AmoL6u+hBNdyic/Cs3/qAlD0owQe0d2FbhRq9ECnLjh4L/33gQ3M+T3mECbrN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzJR8T3JLNVg0XSarUZFXBoK//rCxYMnl3cjM8UOCANyhMlnNG
	GZ/MZB5E/H+QzW561gFxAnyRTe24Dtt5G6kHteqhUPfL5eweitxwt5B7f9reTCs=
X-Google-Smtp-Source: AGHT+IHJ3msqr/VqGca7DrFwvz1jOV4TUziJQEThexb5NUxR6mcAjoC61yfXp9mIpRZ1r/hNeScd6g==
X-Received: by 2002:a05:6a21:3946:b0:1c4:2151:7276 with SMTP id adf61e73a8af0-1cc89d199a1mr21630772637.10.1724860884351;
        Wed, 28 Aug 2024 09:01:24 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:91ab:e1eb:e39a:3c0d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434309669sm10277355b3a.167.2024.08.28.09.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:01:23 -0700 (PDT)
Date: Wed, 28 Aug 2024 10:01:19 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Beleswar Prasad Padhi <b-padhi@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Apurva Nandan <a-nandan@ti.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] remoteproc: k3-r5: Fix error handling when power-up
 failed
Message-ID: <Zs9Jz7skEJ7IYwZu@p14s>
References: <9f481156-f220-4adf-b3d9-670871351e26@siemens.com>
 <cf1783e3-e378-482d-8cc2-e03dedca1271@ti.com>
 <3c8844db-0712-4727-a54c-0a156b3f9e9c@siemens.com>
 <716d189d-1f62-4fc0-9bb5-6c78967c5cba@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <716d189d-1f62-4fc0-9bb5-6c78967c5cba@ti.com>

On Thu, Aug 22, 2024 at 10:52:40AM +0530, Beleswar Prasad Padhi wrote:
> 
> On 21-08-2024 23:40, Jan Kiszka wrote:
> > On 21.08.24 07:30, Beleswar Prasad Padhi wrote:
> > > On 19-08-2024 20:54, Jan Kiszka wrote:
> > > > From: Jan Kiszka <jan.kiszka@siemens.com>
> > > > 
> > > > By simply bailing out, the driver was violating its rule and internal
> > > 
> > > Using device lifecycle managed functions to register the rproc
> > > (devm_rproc_add()), bailing out with an error code will work.
> > > 
> > > > assumptions that either both or no rproc should be initialized. E.g.,
> > > > this could cause the first core to be available but not the second one,
> > > > leading to crashes on its shutdown later on while trying to dereference
> > > > that second instance.
> > > > 
> > > > Fixes: 61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up
> > > > before powering up core1")
> > > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > > ---
> > > >    drivers/remoteproc/ti_k3_r5_remoteproc.c | 3 ++-
> > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > > > b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > > > index 39a47540c590..eb09d2e9b32a 100644
> > > > --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > > > +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> > > > @@ -1332,7 +1332,7 @@ static int k3_r5_cluster_rproc_init(struct
> > > > platform_device *pdev)
> > > >                dev_err(dev,
> > > >                    "Timed out waiting for %s core to power up!\n",
> > > >                    rproc->name);
> > > > -            return ret;
> > > > +            goto err_powerup;
> > > >            }
> > > >        }
> > > >    @@ -1348,6 +1348,7 @@ static int k3_r5_cluster_rproc_init(struct
> > > > platform_device *pdev)
> > > >            }
> > > >        }
> > > >    +err_powerup:
> > > >        rproc_del(rproc);
> > > 
> > > Please use devm_rproc_add() to avoid having to do rproc_del() manually
> > > here.
> > This is just be the tip of the iceberg. The whole code needs to be
> > reworked accordingly so that we can drop these goto, not just this one.
> 
> 
> You are correct. Unfortunately, the organic growth of this driver has
> resulted in a need to refactor. I plan on doing this and post the
> refactoring soon. This should be part of the overall refactoring as
> suggested by Mathieu[2]. But for the immediate problem, your fix does patch
> things up.. hence:
> 
> Acked-by: Beleswar Padhi <b-padhi@ti.com>
>

I have applied this patch.

Thanks,
Mathieu

> [2]: https://lore.kernel.org/all/Zr4w8Vj0mVo5sBsJ@p14s/
> 
> > Just look at k3_r5_reserved_mem_init. Your change in [1] was also too
> > early in this regard, breaking current error handling additionally.
> 
> 
> 
> Curious, Could you point out how does the change in [1] breaks current error
> handling?
> 
> > 
> > I'll stop my whac-a-mole. Someone needs to sit down and do that for the
> > complete code consistently. And test the error cases.
> > 
> > Jan
> > 
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=f3f11cfe890733373ddbb1ce8991ccd4ee5e79e1
> > 
> > > >    err_add:
> > > >        k3_r5_reserved_mem_exit(kproc);

