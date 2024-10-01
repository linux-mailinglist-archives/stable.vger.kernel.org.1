Return-Path: <stable+bounces-78488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0929098BD51
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA3A1C22C8C
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33216AA7;
	Tue,  1 Oct 2024 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEoZUoqL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB136C
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788767; cv=none; b=kC3mo2cTBUcYChyQm6A3gycr+oW0ybbh+7QPW3sSLKnv8tB+AedfIEoKYyq7mAW7L/bBAwQOr5sdpIDZDc0i7lbVzi3j0VZxlo5M7wjaQ2Rh8Uy4MimBmIc3hckWwLNqCPLc2ZI4zYj835HjAT7QVqXYIVbXDeG/Ma9uOkdPHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788767; c=relaxed/simple;
	bh=5tQwkO754jCS9nFxBIWHEHiWzhFtL3We8IkkZmmGESU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvSv39qgTOAJ6CYqhUEtSLs1GzXZSdWJFZopFoSJDeh9uNuEvhjl7dKKPohQSg3s+GJBeNq2tof7TlRS+kb0ITZAiXtV8HfMGVCrZgh1zCS8tFuEtM3vq3MlR15v2ZNTJbw3uaEFCk/AxpI191bW16viN0IEArLoKyAXT9d6QVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEoZUoqL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e0a47fda44so818299a91.1
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727788766; x=1728393566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXiXIWwgmR0UfmkFz9FwQzFMESqlLTZEekI6B5j9d5s=;
        b=WEoZUoqLWWKZJMACs2oZYbmIQ1SG9fki53do0zJmWt673fx2zyVCPyHK29kJWy8vLl
         OhVkGNqQGewfT014X5twxzRJbxPFmezKnrUjvNOAtv5SmGSzuWQBGD+GdvooRhhSC7on
         s6plWmzCbZ+f3EtYvyCD0SmDT4fygFyEdr0H0V9lJHSOtS/XrnGmwbAuOMbhe2/pKiCD
         kAw0qyb3scRPwsyyC/QcMmuaK0gEfh/6xieKyRHrI9Z5ddEhGdL/Epz8MGTPeGfygiAQ
         cBHU4f6D72G1JnNdm0MWPdYtF2IuiYHgbQ681uYgZ7X9AuXO7W1PlEHVtn0SFyvG8WEq
         sPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727788766; x=1728393566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXiXIWwgmR0UfmkFz9FwQzFMESqlLTZEekI6B5j9d5s=;
        b=jbGqpCcp9NnBQ+3K6KvgRrnqfz+u0LgtDBWTrbSMv/gjoSuDLXXCH5ag8sOPS63JIi
         u19VLv5+OGz/PyOgTq1EjmIxrIbwRGi300oVRi9toj2+rFFFaXGiev4sb32xYmoAF/FT
         U3QjZOZomH+8XAD95a0vZPX1+Q2Gj9cOtYpAg3qHbRIwoanVQosP4RgwfVGzor1lyteG
         bzHiwWYvY6SbobO8Ks3iLmagCEMeOiTq9nyS2HGbHatMCOhFiftcbh3vxTZFP9forNlE
         TJuqeUPRGeFpryJv3lYJnHZxpIpk1fgj2pQRH8sfIl2B3Znftoq0DnPLUSr7p39moNO/
         X3QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX+XOaOPRWIWJoaDiaG5Hi0DehKZGjjH9Ng+Ey4N4464Z73tMWkl3wQrVE+LXKkhwFTtAzpRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzebA0gyWzmVPcssx0ik5oYo2BkACc3vh3D6YWfkODBsmwxfIsi
	GbfMApmp9cptQKAEDFZmOEXOqk8UcgalCeRxjRQNw9E3S4eftixpmkywnwJJuf429LyqfXJ4kAL
	coZ3QUMZ4+DXyjIv6TUmxWz37o4k=
X-Google-Smtp-Source: AGHT+IEmWCaMTr25cM8kV4jqwmHIiN2Dhczo4uoIMhMQguhRTriR+KjemXPpW3xTGHMkWnbULIeT2pUlUvZBsJAumXs=
X-Received: by 2002:a17:90b:128b:b0:2db:60b:697e with SMTP id
 98e67ed59e1d1-2e0e70f2160mr6270753a91.8.1727788765715; Tue, 01 Oct 2024
 06:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024081247-until-audacious-6383@gregkh> <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
 <2024081558-filtrate-stuffed-db5b@gregkh> <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
 <2024082439-extending-dramatize-09ca@gregkh> <CADnq5_OeJ7LD0DvXjXmr-dV2ciEhfiEEEZsZn3w1MKnOvL=KUA@mail.gmail.com>
 <2024090447-boozy-judiciary-849b@gregkh> <CADnq5_MZ8s=jcCt_-=D2huPA=X3f5PWNjMhr88xoiKc_JFwQtw@mail.gmail.com>
 <2024100112-flounder-paralysis-eb25@gregkh>
In-Reply-To: <2024100112-flounder-paralysis-eb25@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Oct 2024 09:19:13 -0400
Message-ID: <CADnq5_OKw-N6sXuX7hvfE7Agb5HStBjGxwjS-2x3AbghWyqMEg@mail.gmail.com>
Subject: Re: AMD drm patch workflow is broken for stable trees
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:04=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Mon, Sep 30, 2024 at 10:10:25AM -0400, Alex Deucher wrote:
> > Resending now that rc1 is out.  These should be ignored for stable.
> >
> > 8151a6c13111 drm/amd/display: Skip Recompute DSC Params if no Stream on=
 Link
> > fbfb5f034225 drm/amdgpu: fix contiguous handling for IB parsing v2
> > ec0d7abbb0d4 drm/amd/display: Fix Potential Null Dereference
> > 332315885d3c drm/amd/display: Remove ASSERT if significance is zero in
> > math_ceil2
> > 295d91cbc700 drm/amd/display: Check for NULL pointer
> > 6472de66c0aa drm/amd/amdgpu: Fix uninitialized variable warnings
> > 93381e6b6180 drm/amdgpu: fix a possible null pointer dereference
> > 7a38efeee6b5 drm/radeon: fix null pointer dereference in radeon_add_com=
mon_modes
>
> Thanks, that helped a lot.
>
> However the following two commits did not apply, is that because they
> are already in the tree or do they need someone to properly backport them=
?
>
> c2ed7002c061 ("drm/amd/display: Use SDR white level to calculate matrix c=
oefficients")
> b74571a83fd3 ("drm/amd/display: Use full update for swizzle mode change")

Looks like they will need backports.

Alex

>
> thanks,
>
> greg k-h

