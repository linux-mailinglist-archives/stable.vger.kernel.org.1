Return-Path: <stable+bounces-134992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0218FA95C0B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B387177CA2
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9C21A2C11;
	Tue, 22 Apr 2025 02:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n4UglR55"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371713AD1C
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 02:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288465; cv=none; b=q5zWqzrEJtjIVHOTjAhLHGtq7skKwyGnUx21dRiLIKkrKQxg8XYzqgWN3ipe9wcpQgX+h2L9NmWkZtpboWRBSO7dvlPtx85ryiqNcniVelRBTOspsbO+rMGUttICFe2q2NQZ0tsml7w7gJ+GlDOt21tVxIoF8N/MjO3cRTjfNJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288465; c=relaxed/simple;
	bh=bgwnfmVptUSFrL7rioZr4aGnZG797ufpkJhrEQbVNhw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=B/zc2Zf3dCxvqWCuHcwhk6og3pcQrkE1SMDCDaf8abeVxUi8HDtgd1zRgKfjrVEPa2yw4x/HsP1CbbSV+MwWkRNfI0GzgdD1c7LxE4N4plKgfTQgGnLcgIjEfJXKRHcBvNtE3CRKAzZ04wqo2JigZmzLtSKiSeoFtD+4aQKKszk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n4UglR55; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so2736685f8f.0
        for <stable@vger.kernel.org>; Mon, 21 Apr 2025 19:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745288461; x=1745893261; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4af7Xc1+5cnfHb5k0WJTCxDvRo5jrtAyH2B4OstKv4o=;
        b=n4UglR55rwGhOZakKFOJ6jDzWIm60OtMWFn4/zSNrCdVofjzDDKvD4ug2KDW9xaP3K
         IzKw9tFqlpopkI64j/36eJP0yPXAer9okNlJGs5LFe8gxXsTzXnd23kHEJ2TW/tPxN1T
         TKe75Z5fDW5MErCgTMytGogeUemig2Yrefg7umR3goDKuPZduqOWr+WwPr4tZ7LBOWsM
         lTpsosvWbkftNddbrQ8tDmo9cD6MUp0Xm0ugFVIcBVl4on7KtdeiIlhvNsx0VHNV6QIs
         xHhgLjWARk37Wd4cVOj/apLoGtl43o4GFCfV4Jx7y8qYesTPnUgZ9x63VU2k0QD/AWBj
         TyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745288461; x=1745893261;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4af7Xc1+5cnfHb5k0WJTCxDvRo5jrtAyH2B4OstKv4o=;
        b=UyyXKku3EMz7kSAsc5s9vMEEiGXUJ6iaEH+h61GCXb352UIc1s2DWjJGmWe6sabd6c
         qrL4uFOhO58dQGJRgVCp5ueYG+NBbMvNfDGkZlmA08tAp9g3R5ajWhk8uu72PUOtorSR
         iE8NnIjeus1rmXF7sw/IVnyVaXM3dX/6xVxYbi0Ir9zqfBB6MfwhYJ/gfvbjOwTj+bU/
         HqBY/kbxInkIrvs6ISHIQNCjEHqwHAwlgmRQnlSswCGO/LB0BxO3Gp880FzcGsVjPiuF
         I+0B0tP3Z7VzrRLDhYTneVBYQBPkWj9HG1FuYi9LNgkryRglezHFS8vxV/esqUkZhpha
         JsnA==
X-Forwarded-Encrypted: i=1; AJvYcCXU1e26kDS3fQaLbJWBKy4Mo++2F7XxsM25I+A/NYqtDrscyXk8YRBwytBmbRqiUdAEyCf1yTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy84O7IfatUMDnWPyXvV9y8YC/1bxzsvVecAQFpUMErov5IlWRh
	dV4qFatM3wYWuNTt53h6T8phrOWm8gnpiXcdFHSHA9MVJ9y5iuCQvOYtlNdSRww=
X-Gm-Gg: ASbGncsEbrnZlQGGHss5LSNUeD3yGUqFyapA+luQXRDSQux/DGE2IED+1mPeuLyJhPW
	9A3U3RpItJDKoB9kb3YY8sXc4KwGTZDFf7vwqLRwFqMQojReU7nWnFLm0Gda92NVS6eUdN2GwqH
	2XDHNq9zYwim3NT78TJa0wCXLe3U5v8JBEEwRUJNYxZqNi7BezL1t4YkvMsvdovRyPtJzLZAc9e
	iFsYu1rkktxuKBGdsUY/n9ZEhzQxlnxCd1fmprU3DOORuHBevYE62+PRG8ORy5l4vFuBob9fo3u
	6HaGJIHgoDQCgJOSvhXejcF3e2CEctbes+bzk7W9
X-Google-Smtp-Source: AGHT+IFgeV/8j5th33piQmdTquaU2Z4bEmnQQNcAV7T3TABQNERWr1QfIiL6vJSAQOiHKjbGoM4Bwg==
X-Received: by 2002:a5d:47cf:0:b0:390:f0ff:2bf8 with SMTP id ffacd0b85a97d-39efba2ab65mr12333940f8f.10.1745288461621;
        Mon, 21 Apr 2025 19:21:01 -0700 (PDT)
Received: from localhost ([2.216.7.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4a4e9esm13748087f8f.96.2025.04.21.19.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 19:21:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Apr 2025 03:20:59 +0100
Message-Id: <D9CT4HS7F067.J0GJHAGHI9G9@linaro.org>
To: "Alex Deucher" <alexdeucher@gmail.com>, "Fugang Duan"
 <fugang.duan@cixtech.com>
Cc: "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "frank.min@amd.com" <frank.min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "david.belanger@amd.com"
 <david.belanger@amd.com>, "christian.koenig@amd.com"
 <christian.koenig@amd.com>, "Peter Chen" <peter.chen@cixtech.com>,
 "cix-kernel-upstream" <cix-kernel-upstream@cixtech.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: =?utf-8?q?Re:_=E5=9B=9E=E5=A4=8D:_[REGRESSION]_amdgpu:_async_system_error?= =?utf-8?q?_exception_from_hdp=5Fv5=5F0=5Fflush=5Fhdp()?=
From: "Alexey Klimov" <alexey.klimov@linaro.org>
X-Mailer: aerc 0.20.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com> <D980Y4WDV662.L4S7QAU72GN2@linaro.org> <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com> <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com> <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
In-Reply-To: <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>

On Thu Apr 17, 2025 at 2:08 PM BST, Alex Deucher wrote:
> On Wed, Apr 16, 2025 at 8:43=E2=80=AFPM Fugang Duan <fugang.duan@cixtech.=
com> wrote:
>>
>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher <alexdeucher@gmail.com> =E5=8F=
=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5 22:49
>> >=E6=94=B6=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.org>
>> >On Wed, Apr 16, 2025 at 9:48=E2=80=AFAM Alexey Klimov <alexey.klimov@li=
naro.org> wrote:
>> >>
>> >> On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
>> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.or=
g> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816
>> >=E6=97=A5 2:28
>> >> >>#regzbot introduced: v6.12..v6.13
>> >>
>> >> [..]
>> >>
>> >> >>The only change related to hdp_v5_0_flush_hdp() was
>> >> >>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP
>> >> >>
>> >> >>Reverting that commit ^^ did help and resolved that problem. Before
>> >> >>sending revert as-is I was interested to know if there supposed to
>> >> >>be a proper fix for this or maybe someone is interested to debug th=
is or
>> >have any suggestions.
>> >> >>
>> >> > Can you revert the change and try again
>> >> > https://gitlab.com/linux-kernel/linux/-/commit/cf424020e040be35df05=
b
>> >> > 682b546b255e74a420f
>> >>
>> >> Please read my email in the first place.
>> >> Let me quote just in case:
>> >>
>> >> >The only change related to hdp_v5_0_flush_hdp() was
>> >> >cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP
>> >>
>> >> >Reverting that commit ^^ did help and resolved that problem.
>> >
>> >We can't really revert the change as that will lead to coherency proble=
ms.  What
>> >is the page size on your system?  Does the attached patch fix it?
>> >
>> >Alex
>> >
>> 4K page size.  We can try the fix if we got the environment.
>
> OK.  that patch won't change anything then.  Can you try this patch inste=
ad?

Config I am using is basically defconfig wrt memory parameters, yeah, i use=
 4k.

So I tested that patch, thank you, and some other different configurations =
--
nothing helped. Exactly the same behaviour with the same backtrace.

So it seems that it is firmware problem after all?

Thanks,
Alexey

