Return-Path: <stable+bounces-106753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66605A017DC
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 03:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB77162CA8
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 02:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D87433D9;
	Sun,  5 Jan 2025 02:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7kvbRUJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2FA36B;
	Sun,  5 Jan 2025 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736045514; cv=none; b=WWRPq6eIP+9sMAzpUo1cdKV+54KxHqu9yfBAD4O5bnMnnYj4kTZuHYio7OgiqowG4t3XuKoaZqb2/xEqdUV3MEJC6iR9liLPYhJePfQMhIon9X9G14z21TedXPCwBu2TDuY8NmU9NKM6lVi3AHJsSKOyJxhDiQuo0YiXXOPHzYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736045514; c=relaxed/simple;
	bh=nyMeHaPYpNCyW6Rp8R3yTB/6GcmDyGW53GbzL4CA/BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfejFntrTEP/sbJEPhwkWNeIOGfammWlZd9e2OJRhii33fQJHWMcfTdU/zcORRb+IqwKRqfVo7kvtbf47w8aIZlANYDocqbiJo9csOObtbzscwThP7ZYi4XfZHgaywzVDm0knjVTqDsR0+fUndOe4LYrqK1cROnLz16o3N5Ig7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7kvbRUJ; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2a3bf796cccso5935672fac.1;
        Sat, 04 Jan 2025 18:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736045511; x=1736650311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg1rQ6/pZioByqQHGs1fGmHXEcQ58r83VoOaNc6DbIc=;
        b=b7kvbRUJqUM45971sWEuv0RCNBHglO9ekMMoRZKB6/OS5QlK/y5eRAiP0SgPaUG2U0
         KWTBN8abvtGwLcpOJjGM7zG2MMj1U0SxpboUq32JmuwzBzvqtPJA+iuAMvA5sQ/0FVOS
         LojA9UeZsfVZAvQQdxB2ffwGRYbm7Cb2GoR3qxayenf5U5JLWfXYXCF6Whe2Sk4gnrTZ
         x+7dYpvDd1SzPoAtYDsFlp/RiCJhB0dGsNalvj5uRXjmPHFHFPxvxVbtsw68j4yOthaW
         9LDbBiF7tvj2vChOuXHngEq8Xl7ra/Haf7ZdLNEN9rhbMNiuestr23xvAcf3v9rbyuxa
         xF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736045511; x=1736650311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cg1rQ6/pZioByqQHGs1fGmHXEcQ58r83VoOaNc6DbIc=;
        b=IvQTOOQHwVrsKijhpTjsRqOghCeoTZ+I2y20tms4bdegDJ1HIPPLnjMmUiFZChHJH+
         pZFWct8TmYVKpw6b7TVga7qYEsaUyA6B4CSq5sNwWzdPEGNt2nsv/Yyh8CSVCB1HnIOE
         0iuhLDRFwnNqwjQ0qBBIEmx2R/JWOxv+xSBN79dByTyupQAD9K5Tu8lo2TVuSqs4DPu6
         aAGts9hZrgxvpIFcwMZJqGhEjqBE+06W3FHwj5JcXQ12B7KMb0Wl4zzZ3GY8SMPdzEBo
         CeVdf+Y2GbWDu/2IX9w+vay+si5M6riJR32b9/nPyla+0/YYqP5fAkDOEQwlwN22Rpto
         4xww==
X-Forwarded-Encrypted: i=1; AJvYcCUVhX/0XPQTq0uIFzzTgxh9N+Py+4qyonl1NErvC/0awxbGOnPPFIi9akW7XJ3EJKBGanlNfby6@vger.kernel.org, AJvYcCVplJ0ro/FZWEq+V4NNZAscLOFTmK6btNiYNOwSSzODxDm20Kt+voZWZU+OTWGQOff9ZeLH/EhdDWZz@vger.kernel.org, AJvYcCX3ymRIaOGy426xW9WGTRCTMyEi/yoM1UoIiCuHYRprTJiOpx5WL1zysRw3moXieLx13mRQ8LQ2lAZKEThm@vger.kernel.org, AJvYcCXtR+Mcm1Cv4zQ1ES/ylh5cvYolr+TrMtzc17ca0I3ZGw6YuSdP4a3GUXVEJufzJROot4hqYoqssOP9@vger.kernel.org
X-Gm-Message-State: AOJu0YyXso/yOToUf6dpfVNRoL2ZI5bP7ReVcT2FGeHTy94n47iFzSEh
	K1nzAMxB4B/QcSNHq5OnPNAkQKjV6ov80SVXOmTASIlFhnYwop3lYKVlqDZAlErDLKa82SB4wU2
	ETde6PNc0K7XdcwMyCBz51VGsT2QGPLAn
X-Gm-Gg: ASbGncs37j3TsTmZJidBEiWXN31Varlg42f2pEQB1ym6ChrxI5fAyqew1kGU59iJwp2
	aNtYhaw9xhlX5GhS4ECyD/BNJBHwGoKr9/i0wgPQ=
X-Google-Smtp-Source: AGHT+IHfYnfEqKmuHhFrMYj1wSIh57uRQx+cE6q35RGY/y7/V0nIF2tAfR90LOz/sV3YyvNXpFJoGCobSvrU7k10LIA=
X-Received: by 2002:a05:6870:a496:b0:2a3:c59f:4cba with SMTP id
 586e51a60fabf-2a7fb0cf188mr24894561fac.17.1736045511414; Sat, 04 Jan 2025
 18:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241222105239.2618-1-joswang1221@gmail.com> <20241222105239.2618-2-joswang1221@gmail.com>
 <exu4kkmysquqfygz4gk26kfzediyqmq3wsxvu5ro454mi4fgyp@gr44ymyyxmng>
In-Reply-To: <exu4kkmysquqfygz4gk26kfzediyqmq3wsxvu5ro454mi4fgyp@gr44ymyyxmng>
From: Jos Wang <joswang1221@gmail.com>
Date: Sun, 5 Jan 2025 10:51:43 +0800
Message-ID: <CAMtoTm2X+aQRpSbNPjw+b+TsYfYT3h6yx2ycXYwfQbcinrwyPQ@mail.gmail.com>
Subject: Re: [PATCH v2, 2/2] usb: typec: tcpm: fix the sender response time issue
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	rdbabiera@google.com, Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 22, 2024 at 9:14=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sun, Dec 22, 2024 at 06:52:39PM +0800, joswang wrote:
> > From: Jos Wang <joswang@lenovo.com>
> >
> > According to the USB PD3 CTS specification
> > (https://usb.org/document-library/
> > usb-power-delivery-compliance-test-specification-0/
> > USB_PD3_CTS_Q4_2024_OR.zip), the requirements for
> > tSenderResponse are different in PD2 and PD3 modes, see
> > Table 19 Timing Table & Calculations. For PD2 mode, the
> > tSenderResponse min 24ms and max 30ms; for PD3 mode, the
> > tSenderResponse min 27ms and max 33ms.
> >
> > For the "TEST.PD.PROT.SRC.2 Get_Source_Cap No Request" test
> > item, after receiving the Source_Capabilities Message sent by
> > the UUT, the tester deliberately does not send a Request Message
> > in order to force the SenderResponse timer on the Source UUT to
> > timeout. The Tester checks that a Hard Reset is detected between
> > tSenderResponse min and max=EF=BC=8Cthe delay is between the last bit o=
f
> > the GoodCRC Message EOP has been sent and the first bit of Hard
> > Reset SOP has been received. The current code does not distinguish
> > between PD2 and PD3 modes, and tSenderResponse defaults to 60ms.
> > This will cause this test item and the following tests to fail:
> > TEST.PD.PROT.SRC3.2 SenderResponseTimer Timeout
> > TEST.PD.PROT.SNK.6 SenderResponseTimer Timeout
> >
> > Considering factors such as SOC performance, i2c rate, and the speed
> > of PD chip sending data, "pd2-sender-response-time-ms" and
> > "pd3-sender-response-time-ms" DT time properties are added to allow
> > users to define platform timing. For values that have not been
> > explicitly defined in DT using this property, a default value of 27ms
> > for PD2 tSenderResponse and 30ms for PD3 tSenderResponse is set.
>
> You have several different changes squashed into the same commit:
> - Change the timeout from 60 ms to 27-30 ms (I'd recommend using 27 ms
>   as it fits both 24-30 ms and 27-33 ms ranges,
> - Make timeout depend on the PD version,
> - Make timeouts configurable via DT.
>
> Only the first item is a fix per se and only that change should be
> considered for backporting. Please unsquash your changes into logical
> commits.  Theoretically the second change can be thought about as a part
> of the third change (making timeouts configurable) or of the fist change
> (fix the timeout to follow the standard), but I'd suggest having three
> separate commits.
>
The patch is divided into patch1 (fix the timeout to follow the
standard), patch2 (Make timeout depend on the PD version)
and patch3 (Make timeouts configurable via DT). Do you suggest that
these three patches should be submitted as
V3 version, or patch1 and patch2 should be submitted separately?
Please help to confirm, thank you.

> >
> > Fixes: 2eadc33f40d4 ("typec: tcpm: Add core support for sink side PPS")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > ---
> > v1 -> v2:
> > - modify the commit message
> > - patch 1/2 and patch 2/2 are placed in the same thread
>
> --
> With best wishes
> Dmitry

