Return-Path: <stable+bounces-210447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D10ED3C045
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 08:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 504DA3E76FD
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE1136166F;
	Tue, 20 Jan 2026 07:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZmMEh80"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26252362127
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893231; cv=pass; b=pZOHIQdgrsnSytCNO1dlfFzcAJHrHyhF10WzCCuMkwmWWxSim1ZvHWU69Y9fc65mCMKw3bN/STusn/Uhlw6zFpM6c88EECqFf8YOzOjtOlTAMwo5lRY0cCKDVLrCHQnPVq7lE9b02+h5yo8YvebDsWlO71wt2dwEGdrbh9UzyrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893231; c=relaxed/simple;
	bh=m/AcdJHOfbL98COErVKQfn92HC1scPShYwrkryDi5Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyiWN8iUSmBSwNLRD/8TznEqEmCWc5GuSdrr8+OOLUCPMZBRVLANESZrjjvT8j0zCCWTYS4HBzsRauDhYm6ePC0fZ7ObJuz9zdUt429YosqgqnGFBgNceqcnm2Iy/wyByOxNqJ27kNdiD8B1JLjgB2NhVTmmCD7j0rrVP6WOoOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZmMEh80; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-502a26e8711so19992161cf.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 23:13:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768893223; cv=none;
        d=google.com; s=arc-20240605;
        b=g9aw9Z68WP3+N9gPZQbJS56GpNPNko3EXqo+AF/7u2uEFxVyUKS5N82JFv0j2Hhm2n
         Iww6/SJAlFymb3m9uHkADSn2SdW4eTGMglbvbFi9HJZWT8lgTNz5s4vFJFIJuqOp4/x2
         8QxMcdXrtnJS0ivhVNlpOiotSLfiSv8FHWS88eJYt1PQ3/ApzwyCXK0RoYVsJ7uR7uNR
         VzCEk55qZhf8ccTxh4G0fALPd1FpGEeMySphmzm0LTtM4gl4Nm6bzO/S40Iay5Foz3hp
         ssnMPI9LyF8/Cqce2WGJ2eAbqWHiC/YxUBXl/R6Fv4Vv7upklmSYdiw2EZYma/aCw4Tx
         2Hjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m/AcdJHOfbL98COErVKQfn92HC1scPShYwrkryDi5Tc=;
        fh=LV+cyTkd4JkDSD37a5blj461ItU1tzYI9ew6kwtnb3Y=;
        b=huzql3nVry1sWG2Per397dpIRzLJedyCDOUalcoF3DxU/yDM8UVHaira1L04OqPQ54
         AKVp2QqrTVRPGyPbhZuhA3KbYhbzYGibOJLD9pNWzjF8KEh1xJ/SIRXZ6WmTgsORSgXr
         PIMU4w1LxL212SrCoQPBLjjM/jHx5Qp4BXlYNE/STdpcyT8pUyQJfeD94G4ISIMk353N
         uyeQF0giIoxzBfJAHf6pI8BMEZvj3R+Iogc7eiy7/TVIeH862nLNEpErs4shkKagX4RM
         9Fv2zMx9IXXDHaJjzUoh3lzrZNuBLb/TZT6YFwQWMmGyXT+0Cshw4m8vzCF0jrIJ6uyW
         RJrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768893223; x=1769498023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/AcdJHOfbL98COErVKQfn92HC1scPShYwrkryDi5Tc=;
        b=aZmMEh80PyWm+3sY6uWVdBMVeBpJHl1T+R0gBnEegP0HWuT8YEzgFTmtkzbkiLtDi5
         ipWj/Lm4HqT/arhF3j8c9ayaVVENhwpjstF4GxIXzR5vA++AL1x4TauwsQDEVVx4ovKa
         EWbrVbP15X259Fc/XPGMnIZUtguXzPRjH4Pt3O51ohjBDmTWqFEFE/uWX96WDM39ed3L
         zipiU+U6NpKt1XSwxmWMhpxRY0pJzdhJ6BXzBfWe++kstKQQTtIMFkPm1/BBhrPxRlj9
         nPxI+ojBo/JyBPREJczupjm1VFdGEhdct9/z7CaWOjVqO5tm8/SqRRh/1rqEUZidpaqi
         +Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768893223; x=1769498023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/AcdJHOfbL98COErVKQfn92HC1scPShYwrkryDi5Tc=;
        b=gM1Sm1/WSz9Rs5yI+eGoAwJJOvmD3yir5Dk9l2ZOJjFqhRhnsjOvq3iJ81sms5fC1H
         tElU9FllGA2q3om11LYMLoe3lfUZMclAl9XPhfwUd1MNbewWlU9cubyocMRYwbvuvBmo
         jblF+5BLRfpyHWIhvsXp3fyZRJybMQ6ciAn/Y3Qv28TwPrh3S2/WI4cmymn61GxNHYLe
         Vq1KE3pQDKVfvIJ8yhDdsPQLAeDN+gIJOnK3nIvhAZt4UY2Fab3hECWRBJDHe7kJnjkX
         c2wgUCkQ0CmXB9zsQcmrgpfLt4gGFl3Oal3hkY1UahRcYy6hs/6GWV3ofFrhoZDIWs+h
         Hr4g==
X-Forwarded-Encrypted: i=1; AJvYcCWC/FTfchdxZOU+pz7vgj+klfrER22DhAgNdXunmWZ2rKgc1R3/Xb9lxm/kW/QHQcV7MjmdwfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+Oo7mSTxJDbNQ0VUE3e38EiI6QbLV1Lerd8uUiR+qPCw/1mA
	G75J/KWQrl2msaMi7YZfXFTsV3NvyX0zYHsM7xFXkMfjloXH8dSkT03MzrOPRRzHH1pbj49146x
	s6S/KEYHoXv4096zSpnMOCA/I3gEZzD4=
X-Gm-Gg: AY/fxX4uGfhYAe5d64uUnNfO0tmtHYNZkTaei2whALbKa+8KaEMwa/eclX3/6Vmt7KQ
	R0sYMXSiY19mF/HdCa2L4gb8z0Mn1s21cU9Jre4WnihXZwaHuXlSkVgrj/yCZjyG6Q/jH7al0nc
	CZ4008kAoOnwbB5u2sih4OCsSnQwwE7YLEz7zcXWf7bXMaIWTeus9ZVat9Y528zmG9TSh2h5NuB
	88TC2KzXWdmMd8IJQo6g5ubfe7cYHBnnrSxbTU9q/3mz9JRc0yoOQzf5VZijDWedr8C1Gf4bCrx
	9VI3/jr24KUCRTUpFP8b0BF1XJ4=
X-Received: by 2002:a05:622a:489:b0:4f1:ba0b:90 with SMTP id
 d75a77b69052e-502d82775d1mr8090231cf.8.1768893223391; Mon, 19 Jan 2026
 23:13:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119-ufs-rst-v1-1-c8e96493948c@gmail.com> <6479d7b8-7712-4181-9c82-0021da94d1a8@rock-chips.com>
In-Reply-To: <6479d7b8-7712-4181-9c82-0021da94d1a8@rock-chips.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 20 Jan 2026 11:13:34 +0400
X-Gm-Features: AZwV_Qg9xEnym6d1IbZ761hDP0MCCZD2sOIi6gJCnx0Dbz6NZzcnmt6Sl_0hXVI
Message-ID: <CABjd4Yx_2NPkY7U6U8XL_89uK20j7S3e4px1Cbp+JbF3FavjyQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Explicitly request UFS reset pin on RK3576
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Quentin Schulz <quentin.schulz@cherry.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 5:39=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
> =E5=9C=A8 2026/01/19 =E6=98=9F=E6=9C=9F=E4=B8=80 17:22, Alexey Charkov =
=E5=86=99=E9=81=93:
> > Rockchip RK3576 UFS controller uses a dedicated pin to reset the connec=
ted
> > UFS device, which can operate either in a hardware controlled mode or a=
s a
> > GPIO pin.
> >
>
> It's the only one 1.2V IO could be used on RK3576 to reset ufs devices,
> except ufs refclk. So it's a dedicated pin for sure if using ufs, that's
> why we put it into rk3576.dtsi.
>
> > Power-on default is GPIO mode, but the boot ROM reconfigures it to a
> > hardware controlled mode if it uses UFS to load the next boot stage.
> >
>
> ROM code could be specific, but the linux/loader driver is compatible=EF=
=BC=8C
> so for the coming SoCs, with more 1.2V IO could be used, it's more
> flexible to use gpio-based instead of hardware controlled(of course,
> move reset pinctrl settings into board dts).

Thanks Shawn, both of the above is very helpful context - I think I'll
mention it in my next version of the U-boot patch series where this
discussion first surfaced.

> > Given that existing bindings (and rk3576.dtsi) expect a GPIO-controlled
> > device reset, request the required pin config explicitly.
> >
> > This doesn't appear to affect Linux, but it does affect U-boot:
> >
>
> IIUC, it's more or less a fix for loader, more precisely U-boot here?
> I'm not entirely certain about the handling here, is it standard
> convention to add a fixes tag in this context?

Device trees are treated somewhat independently of Linux driver code,
even though they follow the same development cycle. I believe that
broader policy is that both bindings and device tree sources should
equally cater to different codebases that use them, so a potential
issue outside the Linux kernel warrants a fix. Perhaps Rob, Krzysztof
and Conor are best positioned to confirm this or not.

In this particular case, the fact that the GPIO descriptor is defined
in rk3576.dtsi, but the respective pin configuration is not, leaves
ambiguity in the hardware description, which different codebases might
resolve differently (and not necessarily correctly for the hardware).
So there is a benefit in backporting the change which explicitly
resolves the ambiguity.

Best regards,
Alexey

