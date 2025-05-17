Return-Path: <stable+bounces-144664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDF7ABA82C
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 06:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C961B67E07
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 04:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C1E18DF62;
	Sat, 17 May 2025 04:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVnc7u8j"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1CD1865EE;
	Sat, 17 May 2025 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747456810; cv=none; b=U9dqI6sEUEdVJGe6redlm2IuQaNRwiK3dTb/vZObuWVBp4Oq9ZsjRHbaw05Oc32SmYf7QwgGZbsS3BGdbe3YevlnhCl9eeiQ0UJnBMI/PNMTHDldLvCqbVTocmYbInXsOzX2GKg6GInAwAVc9OrDB3sUFHI/4L9JEny2WGBZ6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747456810; c=relaxed/simple;
	bh=ebe3QJED/rJ/u/3kHQPUsrofn8Zx6DQCElbyHghmxFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lilxsYU0CbHQMBQ9GmUPi9oxo6EkEI7A2wix2YbV4LSja25bl51CAfd1/fMpVE5Pw8LX8N8YbsVuMz6+TpwFX+ZAntQVnVblR7EOPD0TQBBAaiWVcwM+WOrQRUADH5HDv5/ozscPBg987FXW5St/cLaZsgC7O56qfmrrcINR3w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVnc7u8j; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54d6f933152so3995309e87.1;
        Fri, 16 May 2025 21:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747456807; x=1748061607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoKIuVITN42/N/HS1yycmrVP5+KZGVqyhHsLSfQ1BFg=;
        b=YVnc7u8jxd28unU8mkV77rc1i9IydrCIreEIGr/V11cJ9saKmjjFBRqOh8osexNFeT
         t+5pxJWO7GyrXYljk8l/0+70Hy9QL+YaU+0j+/uD2/ZUFp2FjI2WLmnpLZVGVTUHkRVV
         y6iJeUqsHB9f6m4ffxTnRqDGQiFmQuegrVMn3ciYIOtuBCkKsmnPurb1S4ctYRg5/kR1
         Xu8n9wwgPZtKgv8PxwZdY5ti3pcn+cjkUXfzRxV9d5I8PHQ+pVIusl7r/1yMuoq1lZE0
         1WQBCdgdDSeFiziFTyvauAZoGVeQBc4HpYq1kyWFsMawca5ThJz2yJ1xz/jc8UFz7wjs
         KEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747456807; x=1748061607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoKIuVITN42/N/HS1yycmrVP5+KZGVqyhHsLSfQ1BFg=;
        b=dGLAzR3mgmHYw2cKjAOop/31OvwV29UzHa9ElVxJIHQYJ7Ck3DYS2AWPvrJi2xRyOr
         dlJS3grkfJpPjRnr+/HcV/yKNMxciNxh40Ydq3IMvQTP6wOJZfcBEdPCs1v08SG/irFP
         3HtmAYLOIDeFBLatKDPWj3hhu+YfSQQ0eCSJAz6CyXrTfFTdZUdbTnxg/6KkqllTnarV
         dgdekdAf3zn3jBCbe4EVBPDPVUOUvuOWgwVEZFCdqtFI+wmCozpXJREpnWjfG4MsrAdl
         eQZRMuu5yZ5gpL+5s72uwyWzEIM8IJwRgOVwnK/K8XBSCeea0LPYhhaKxyklf8hV2bl7
         ON/A==
X-Forwarded-Encrypted: i=1; AJvYcCVFsbhgBtMDF2+7e8TjpfcljLMDvs0I0IBT7cQYEL7SvofUpbqu3nJF8AxAyknqhnU+BgcrYmwh@vger.kernel.org, AJvYcCW/nAPEYv1qlN5l1qzdl5nMYUzHYZepNUwBz1N0YEnddeYEFfVUJO3o32kpENy7Hdizl6XNXVKkviyilGw=@vger.kernel.org, AJvYcCWG0TaJs5VhVrYBFwLtX8159JxR7wfJh6TeHOfZRgD5FfEflNje0vRzH/vPKXJUCbjxmjO2Mw2/STEy@vger.kernel.org
X-Gm-Message-State: AOJu0YydXz3VucP6+RF/ndbfRMkRa86AY7ji3r06Bgg0AhYh0Nnp755g
	oy3Xn2jh9I/cKap42xMY6QTcwHkc1eQr1qpxlf2AG6lIe7YckAYGJZ02
X-Gm-Gg: ASbGncvYPzFxcPDbqrEIR68Coiug8UZdF+RpcTWnMo6jK+4MHxvbi8QH0q+TGq8y7mo
	tfbGlcaZe3fXsoCfh5WRuLX8hTnf3UCt5JbeBgs2yHL2hRXGin5diMNqfCf1Gkfmob6E6kY5DEC
	GzMHqWVCDTx3VafQyRAYxE+5OLBwJJiDW6B1D5OZMeDckBO1TiLRnR/lD0h9gfznbmXzahgtg7l
	M6Sc2Wl9kHVo0fsmnutximJ6aYYIub+g82H3YxMQX8Iy8QTxatBJICJBrxjkMy61o4hFgSwVtB2
	8HwjcCw2nWD9myT5U7MFRQWroZ6C4mKOvFXSJ+6Ppcreh/8/a6gC1L7wuTsB6Bjp/frJ
X-Google-Smtp-Source: AGHT+IHB9x5ku6+0IEVf8hhhXbFevmvNwmZiwm/6HKtVrDb5d9FUQCNV0VIpf/PLWPPz5iuVLVeMVg==
X-Received: by 2002:a05:6512:650e:b0:549:91e0:143 with SMTP id 2adb3069b0e04-550e971b35fmr1522746e87.5.1747456806450;
        Fri, 16 May 2025 21:40:06 -0700 (PDT)
Received: from foxbook (adqk186.neoplus.adsl.tpnet.pl. [79.185.144.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e6f30355sm719753e87.89.2025.05.16.21.40.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 May 2025 21:40:04 -0700 (PDT)
Date: Sat, 17 May 2025 06:39:59 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Roy Luo <royluo@google.com>, "mathias.nyman@intel.com"
 <mathias.nyman@intel.com>, "quic_ugoswami@quicinc.com"
 <quic_ugoswami@quicinc.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] xhci: Add a quirk for full reset on removal
Message-ID: <20250517063959.28b3537b@foxbook>
In-Reply-To: <20250516233829.ibffgnicnxgchbim@synopsys.com>
References: <20250515185227.1507363-1-royluo@google.com>
	<20250515185227.1507363-2-royluo@google.com>
	<20250515234244.tpqp375x77jh53fl@synopsys.com>
	<20250516083328.228813ec@foxbook>
	<CA+zupgwSVRNyf40JiDi6ugSLHX_rXkyS2=pwc9_VHsSXj4AV5g@mail.gmail.com>
	<20250516233829.ibffgnicnxgchbim@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 May 2025 23:38:33 +0000, Thinh Nguyen wrote:
> > > But on the other hand, xhci_handshake() has long timeouts because
> > > the handshakes themselves can take a surprisingly long time (and
> > > sometimes still succeed), so any reliance on handshake completing
> > > before timeout is frankly a bug in itself. =20
> >=20
> > This patch simply honors the contract between the software and
> > hardware, allowing the handshake to complete. It doesn't assume the
> > handshake will finish on time. If it times out, then it times out
> > and returns a failure.
> >  =20
>=20
> As Micha=C5=82 pointed out, disregarding the xhci handshake timeout is not
> proper. The change 6ccb83d6c497 seems to workaround some different
> watchdog warning timeout instead of resolving the actual issue. The
> watchdog timeout should not be less than the handshake timeout here.

There is certainly one real problem, which has likely existed since
forever: some of those handshakes cause system-wide freezes. I haven't
investigated it thoroughly, but I suspect the main culprit is the one
in xhci_abort_cmd_ring(), which holds the spinlock for a few seconds
if the xHC is particularly slow to complete the abort. This probably
causes xhci_irq() to spin and disrupt other IRQs.

I encounter it sometimes with ASMedia controllers, but I guess anyone
can simulate it by inserting artificial delays near xhci_handshake().

Regards,
Michal

