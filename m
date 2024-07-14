Return-Path: <stable+bounces-59245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADBF9309FB
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 14:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6C51F21752
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268878248D;
	Sun, 14 Jul 2024 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvmgEKcP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BC71750;
	Sun, 14 Jul 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720961488; cv=none; b=Dj/yHeHUyRzxr/9v0mry+Dh1V9pHzSt1WNkg3vJWcl1KIEKySIgMDSsUJXUwxM5Jzr5+/eEO9wFXjV6lngWr0wvUhbsq5EpEPff/1oxqV3fAQPycLbO96Jsqutle09pzT+UE+5kO/zuUPFPl7GdkmQRtYXuhbD4UeBahzpgVCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720961488; c=relaxed/simple;
	bh=CYg3xNi/ngCDZR29qbDgHwk4RE913gseoNxquV5QE4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ky6ebA0RcMYdAI+gEpLPQy1wpp3zEetKDeF5SUHqB5vtTG9IHX4+q7y9x504gJqi/H+QzVktk8MbveaXlv4oaD7ZoK01+8lvfr9UlIEFzWJ1v/KoDdsdcEU9dI9oABguHraDlhMY1Xstg5A4FdYF5henULk6IxPB7kkX4kXglSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvmgEKcP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a79a7d1a0dbso215898566b.2;
        Sun, 14 Jul 2024 05:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720961486; x=1721566286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzYpwILPItQvBM9cJl6LLDEF67V7lhOke54GQOremiY=;
        b=bvmgEKcPZ0l5V+vSAEfmT+h9co9Uep9mubAtX9cuJaQiBSmcjijAXlUnfklfeG+3x1
         3olpTmMxoAjx4H4bcveZmGPu9zK4k1jFMIWjBo/jXe2MULNP5cuzeJ3ZOeNLZq8jB85q
         eHGNahGxnFiUPCbuSFy9RWCVW8J/XKjozqGrFHX5KlNd7AEElsfojqk0T+q9ElLtHwSN
         EizHdstsnrZgtl8+j+wyBSbkpx5B/EbBUK7nWJE6neRwdD/wEIYp7Ach4KeaFtS5/IPo
         xAyPF9bV/tY28RM8h5HocDJIuX1BLFi7jIhBgUTLVuvdCD/twjAfmc8d6K4c666CiXJ8
         hGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720961486; x=1721566286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzYpwILPItQvBM9cJl6LLDEF67V7lhOke54GQOremiY=;
        b=B9bnDstEk+GXBXCTuHMKFeKvaPPtreS4kvgAzmvNdpBUZEsLo6wYgt9Zzd649ywrkt
         VHYZoFq9h9Fv+pxPedZlUG6mNNcOH4CCsmEELBFUutwHG4kVJAW8b/9pSkIz0qppJfFe
         vMymSPSMdE8DutR+FDldmZu91eQTo+8bGHY2IqFb/cBWEp1WB2m8ZIimBCcJhr6nwfPG
         tVseBorK2v2kMq9LfKnymgc2kFMkDkeJJyNyz2R8nXg7hwimaDieQsW0ksBuCMM78+bJ
         LpgXL3IptedU3wn6L39HiFqRAkiO7DdeSpaUJ1l0NJAedNwVDiIvuG4MDLU8RPkpv2gN
         YQag==
X-Forwarded-Encrypted: i=1; AJvYcCXOc+m8CJI/kh/csu2KKUSrTtEM64hYhARHnad+nd6wF5Lfl+hrbE845NUULSVQX0ijzz0Gl0HZZYkM1wzVE+M1RT/9s/AhhjpGktdS9YP2AD9Og62kqN1Xv0/cSIMwx/nF0vUh119TlZq9d1hQHZN137G0XodTyi2KAULLwGsm
X-Gm-Message-State: AOJu0YzGnZCgHJwvZl9RkAMWd5IZmUG0nj4skipPPWqCGBs6tP3cKGJE
	4gXZ4k/lZGZjzfDfMuQeh2fv++t+pfE9rjysuoS//P6Q9kYEHpLHj0Wm/6WcI2EpVggabQ99KzO
	9KSEY2oUMgDgjZkC9FbDW0jm+IrE=
X-Google-Smtp-Source: AGHT+IFVpepkl9B848UxXyHw2Uxtelx9tIXCYTafa/iSvHcI3yyJX6AAcAeH+03cYXrsW2z1jgaN93A/xdh2qgBVly8=
X-Received: by 2002:a17:907:bb89:b0:a77:c95e:9b1c with SMTP id
 a640c23a62f3a-a780b6b18a7mr1063931966b.27.1720961485470; Sun, 14 Jul 2024
 05:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+3zgmvct7BWib9A7O1ykUf=0nZpdbdpXBdPWOCqfPuyCT3fug@mail.gmail.com>
 <2024071447-saddled-backrest-bf16@gregkh>
In-Reply-To: <2024071447-saddled-backrest-bf16@gregkh>
From: Tim Lewis <elatllat@gmail.com>
Date: Sun, 14 Jul 2024 08:51:14 -0400
Message-ID: <CA+3zgmtP0o4onLaeUhoYoJ2f9J_hSo3NM77jpSQ9N-rTWgG80g@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 2:30=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> On Sat, Jul 13, 2024 at 01:52:52PM -0400, Tim Lewis wrote:
> >     usb: xhci: prevent potential failure in handle_tx_event() for Trans=
fer events without TRB
>
> Ick, is this also a problem with the latest 6.6 and/or the latest 6.9 and=
/or Linus's tree?

The problem did not occur on 6.9.9
I'll test 6.6.y next.

