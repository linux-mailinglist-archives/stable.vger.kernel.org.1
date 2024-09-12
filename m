Return-Path: <stable+bounces-75947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8251297615C
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 08:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379951F21C53
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 06:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE00188910;
	Thu, 12 Sep 2024 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzqWCkJv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7118952C;
	Thu, 12 Sep 2024 06:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726122004; cv=none; b=K8XiiZUflJQWfSzmrrYLB5l0+SpnVkADcDKZbnmfaApV4lbZ5gpf+/Art6BZBCSPjDXjhFLmsYuH8Bs9MNE6VmDUkmXhooy4TNlug/Z2YgAGLgei3jA4ITnKAUXik/wH5nQK8bIphzLsPGbWaknSCooRua5PCeXzxNYP8gVMozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726122004; c=relaxed/simple;
	bh=Eh//eC2ZQUF3nfb6eUzz3dVJDDGdTBrFXZ1nCAZv5ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bArOuLDnw6g2/L2vTC9VetvZ6H/lsW0PBbp6C94/3boynxjiZB9PcO9dAcSPOu12zsCMdm4X6LU/BcbPoPkJFh9FyaBJzcByjVJOPTYnARbikKzv0sjoNbMddoaoIfkfsmV1R0hnQR7ESJHTj0a5r9NaFQODPhsFDPAOgOIW4hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzqWCkJv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374b9761eecso492499f8f.2;
        Wed, 11 Sep 2024 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726122001; x=1726726801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrFGMy8rj0h87/GhVASiPltt/Rs0Uh3ENOxRwjDF3p4=;
        b=dzqWCkJvyov0H1d0Yq6N/SmiWwCv20G+1vAFKgDl8Eoc/3VQyTHoePd4G68cc27ru8
         dEJTibskPNU8608v1MeFAeHjWfQoFHGM8lAYbqyKE6EvJrIRhIg7KZWoqmzIhHKpcCJd
         Swfap7bkxHMijjNf/ha9rW2h6npM43QALGLpHW4hQ7CQO4ntBl/3HBj2JzOFNDuVfMJ7
         LwwJ0NPMU8mj+m7y8IwjOKsLZYA+9GjqTCjrYTeUhJsHhu9I8ac1jR7px1jWY/V1vhUQ
         TV0IfOYtoKbZT6wqXAiizxQFguIPuHP34NDPQR/HlNpGY7vfPtbdKhqb9B+wiYyXFYWd
         xF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726122001; x=1726726801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrFGMy8rj0h87/GhVASiPltt/Rs0Uh3ENOxRwjDF3p4=;
        b=eIfH4F84xvVSRT2FIK6x7/WYDY32O1/htDMsj/bk0RI6jlPQ0rz2ULv24Qlo34/pgK
         7//wWAg7LRW/t7vOOFPmpZ5/V/iudrmoGt41UkBPkipJOS5LvC9sJlVKeV5OLp7NDAQl
         p6Ol1+D4xB2+DN4uqUgy0xVKFPYVRfJkOR03GBGX2L7VKg9XnBp4/l/nuEeagPl7Frpm
         yUkmvukJZooRRSnnF3f6JyR7Lj5JfpXhRk9asfd+JeB/cMBde7iiqNVSnnXHK2CgyBfw
         dXWI2Uc7BOpztHXcHnUCh5AcmYveUk56mOkuxrK0eKOtzvDVNFAG4PuNjSp9egcbzDM3
         kEtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKXAnspPlMfnVdLB15D0NZvh8XI/A08TBq0ecUdDSq4ljnBoOgY62cMEHVQgquFJS6PdVgfQbFlrvozGY=@vger.kernel.org, AJvYcCWMzy44hxiVbxw4WlIiw2qqy52OS5tFtA/aKfAhwSenOw2OFedkL4Kr0vhoPVp6gSBtiW6mcEguFQlm@vger.kernel.org, AJvYcCWu7SfxUfRPrsa/vQVP2KmiPe8AgePAhXjMqmUkrC6IasT7V4pv3nm2lVdiFU24UsQwiuR4kbve@vger.kernel.org
X-Gm-Message-State: AOJu0YyTeuGmFZs0K9Bnn6NHsz57lFTC4S2SvTADL0t3Pm/p/8yFiDAc
	kD170Yr7szsZngLmmKs/Rftnz5Wd4IP86sgGyfoS1EqCt5p0ECc+sPd7mJEEZj1W3MGHUzpzn6h
	YpsXJqCvBE84TEe/P2LgiN75uxXI=
X-Google-Smtp-Source: AGHT+IFoNGTWT3h99GoY81Qz+ckGxTsP5b3QngDN17LEFaL8m39H2H60Mty6V0Vopz/yEwWpGaNSgzfGudlm4Qbkn98=
X-Received: by 2002:adf:a356:0:b0:377:284d:9946 with SMTP id
 ffacd0b85a97d-378c2d031ebmr803696f8f.30.1726122001036; Wed, 11 Sep 2024
 23:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911051716.6572-2-ki.chiang65@gmail.com> <20240911095233.3e4d734d@foxbook>
In-Reply-To: <20240911095233.3e4d734d@foxbook>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Thu, 12 Sep 2024 14:19:51 +0800
Message-ID: <CAHN5xi1ZiOrZBUUAKmyJ5qtUUx5wLc3vyavQwA7k_Q47dN-WNg@mail.gmail.com>
Subject: Re: [PATCH 2/3] xhci: Fix control transfer error on Etron xHCI host
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mathias.nyman@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the review.

Micha=C5=82 Pecio <michal.pecio@gmail.com> =E6=96=BC 2024=E5=B9=B49=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:52=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> > This happens when the xHCI driver enqueue a control TD (which cross
> > over the Link TRB between two ring segments, as shown) in the endpoint
> > zero's transfer ring. Seems the Etron xHCI host can not perform this
> > TD correctly, causing the USB transfer error occurred, maybe the upper
> > driver retry that control-IN request can solve problem, but not all
> > drivers do this.
> >
> > |     |
> > -------
> > | TRB | Setup Stage
> > -------
> > | TRB | Link
> > -------
> > -------
> > | TRB | Data Stage
> > -------
> > | TRB | Status Stage
> > -------
> > |     |
>
> I wonder about a few things.
>
> 1. What are the exact symptoms, besides Ethernet driver errors?
> Any errors from xhci_hcd? What if dynamic debug is enabled?

The xhci driver receives a transfer event TRB (completion code is
"USB Transaction Error") when the issue is triggered.

>
> 2. How did you determine that this is the exact cause?

The issue is triggered every time when a Link TRB follows a Setup
Stage TRB.

>
> 3. Does it happen every time when a Link follows Setup, or only
> randomly and it takes lots of control transfers to trigger it?

Yes, it happens every time.

>
> 4. How is it even possible? As far as I see, Linux simply queues
> three TRBs for a control URB. There are 255 slots in a segemnt,
> so exactly 85 URBs should fit, and then back to the first slot.

The xhci driver also queues no data control transfers.

>
> Regards,
> Michal

Thanks,
Kuangyi Chiang

