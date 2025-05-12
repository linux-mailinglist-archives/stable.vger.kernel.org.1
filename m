Return-Path: <stable+bounces-143292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD75AB3AF9
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253267AC712
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBDA1EDA06;
	Mon, 12 May 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBHvCD6q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C982F41
	for <stable@vger.kernel.org>; Mon, 12 May 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061195; cv=none; b=g1XlfdkCEJZzRap2fsTa+/Cbf2kKQaIAqbDWkzydvJyAJ9LOhACs3LjXSN6kTrZjH7uD8JXMj4UTjNjdpqtDl2JduAi+zc1UO69+3WiHAGsdzmNAZoAe4bMxhEsrm+tB5J8r/1klzaacbDYNagLYSIFrYaO5+yUjpYGfT4fLIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061195; c=relaxed/simple;
	bh=y/WCT9k+NHEwx87D3TbRYlcmZKAHjaI6LXf2RTnFDl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzGDsW2MHlD1MDzGpB/8g0FkQcPLr20HhD3x8RF1q6fbo7IEdeIsz8Mti5xLAmqxVBEgX1WsCBRMguxw1LDkdruqu8y2FCMZzalFaVgH99cVOb1tucVi3l2QcIE0G3oNXF/i5XBAOcyEj+/Q7Y3EFyv/CCvqZ/l4O0UBm8iOghA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBHvCD6q; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b1ff8a0a13cso766473a12.0
        for <stable@vger.kernel.org>; Mon, 12 May 2025 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747061193; x=1747665993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLqVwA910Oz+N1ZjLYrP/5SUcf9+/wqVkZckGAFbHSU=;
        b=DBHvCD6qKitilw0IIdNGW+UECFFAkWdNKd841tfVCGfllZLxmjyaqRDHd6FAhie3I0
         NVk9zSRcuoQ2Cqy1dvbzUUcfri5BnNmfdbTqhyi6ObGgOPAdcqfCsA99VXZgId25m+PR
         Svkf+gEQLQwdsXa+iPRDwjgARAJivEDjWGWazbqwcRZ1h+R03VIsSxMBoNVdTQX7NDLx
         h96dtD9sr+Ikq5vEtgr5IMGd8g10rmk8JNgeQe1BdsYahQfwDHC0KgTpoWHSjYFjQrEH
         tK7K/P7JPxmyD+YUhjeOEycCJVOgyzfjbdnZ0ihzoe4ByxXh21N6W6RFFp910bLp0xk5
         YTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747061193; x=1747665993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLqVwA910Oz+N1ZjLYrP/5SUcf9+/wqVkZckGAFbHSU=;
        b=kr24Y+E6S57Hp9GPRLX1n3hhYUL0YFJUEIxHB34qHHS/GgWklt8TyZZUeoRX/MGQ4F
         NFQWRLGVwAzRm+8FKyKfLRpu6RgYgPDsINvHL1mhnJCU7g/8EegTIRznjUc2/amE/fqt
         uHCj18RBSTl+VMS7SlM8Pe9VZ35U6b1NlLo2FktJSiuUndUbBdW/wPmUVDoiqGdsxU0T
         x7Q5k9Hi9/dw6OGVviyyRAj/4kiuFVO6gXOcU03maVce5nH9OcFmm19YTHc2Y9VNhBp+
         6SpiKfltQpbIwLDkhaS25iat8rFb2EGGNCST7hpYSp1Nk1rd1k5C0ZspKJEpUdE+nT9T
         iQgw==
X-Forwarded-Encrypted: i=1; AJvYcCV647Z9oxI/DHJup2z/rLnmKt1y9oc61kAW/T5woqQVxwP9a0LfWSwieqyvtXXs+l2KbP2g37g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9mzNbhWla4h5xAWeau5vYdejGM+nP3nNMM0uJolUI32RW4v3A
	rtcP3UtgwtpZguCb2o9z5LMjqS8yQ7kEty7aNPqA0YhR2kZ60uvRajXseQXVaQjcp0U1ofhh5/1
	CYmDnTuvIvSbUo3pPfDPdiieNkVw=
X-Gm-Gg: ASbGncv7siUrNkk9Ht+umdCjE2vmp5WlNf5mp7SJ65ukhPJDyts9DQVj4DbcpyCHPVq
	i0N/mYBtrfxBg2FVUBZrsryBRWBR/1SV1OWM9ttYkzja7imcK3eFZ7V2ju6UqHKxHvjtuZPeytL
	ac6QGvUcyndhrZFvPS6BXV5FcCaQMin3Bp
X-Google-Smtp-Source: AGHT+IENnH5CiJy9w5b5F05MU7kzwPLR9EX+eFQG19NegOYS/HTngrIDNEadQ1CCfn3YeLQ6h+DmTNX0hQmZJfYU7KQ=
X-Received: by 2002:a17:902:d2c7:b0:223:f903:aa86 with SMTP id
 d9443c01a7336-22fc8b106d0mr76317645ad.1.1747061193179; Mon, 12 May 2025
 07:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org> <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org> <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
 <D9CT4HS7F067.J0GJHAGHI9G9@linaro.org> <CADnq5_ML25QA7xD+bLqNprO3zzTxJYLkiVw-KmeP-N6TqNHRYA@mail.gmail.com>
 <D9DAIUZXIWH3.1L7CV6GEX4C9M@linaro.org> <CADnq5_NE2M19JdrULtJH-OXwycDpu0hrFHy42YiJA3nMYoP=+w@mail.gmail.com>
 <D9H0K4EW3XTV.1XO4KO44J1YRE@linaro.org> <CADnq5_PuXu-9MAhr3d7HLGnOqHR7Uo+nJPzrpdJEusvRCE8wbw@mail.gmail.com>
 <CANgGJDqZptyPK2nn5NR+OCcGHX1H=YF1vUGsqoLz-vYZjf5Htg@mail.gmail.com>
In-Reply-To: <CANgGJDqZptyPK2nn5NR+OCcGHX1H=YF1vUGsqoLz-vYZjf5Htg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 May 2025 10:46:21 -0400
X-Gm-Features: AX0GCFssUsUak1AQ1yrAFKDGy4jdp1x4SO9rABfJG55FF56FGyGeO0hrLajcuUk
Message-ID: <CADnq5_O77xrMBKX+j-b-ULQi7GJ6=nqfKhU82E7L1oUANXwcuw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1JFR1JFU1NJT05dIGFtZGdwdTogYXN5bmMgc3lzdGVtIGVycm9yIA==?=
	=?UTF-8?B?ZXhjZXB0aW9uIGZyb20gaGRwX3Y1XzBfZmx1c2hfaGRwKCk=?=
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Fugang Duan <fugang.duan@cixtech.com>, 
	"alexander.deucher@amd.com" <alexander.deucher@amd.com>, "frank.min@amd.com" <frank.min@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "david.belanger@amd.com" <david.belanger@amd.com>, 
	"christian.koenig@amd.com" <christian.koenig@amd.com>, Peter Chen <peter.chen@cixtech.com>, 
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 11, 2025 at 7:25=E2=80=AFPM Alexey Klimov <alexey.klimov@linaro=
.org> wrote:
>
> On Wed, 30 Apr 2025 at 17:55, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > I think I have a better solution.  Please try these patches instead.  T=
hanks!
> >
> > For the RX6600, you only need patch 0003.  The rest of the series
> > fixes up other chips.
>
> Sorry for the delay.
> Finally managed to find some time to test it.
> It seems that patches are merged in the current -rc tree so I just
> re-tested -rc5.
> All works. Thank you.

Thanks.

>
> A bit annoying thing is repeating:
> [drm] Unknown EDID CEA parser results
> and I also didn't observe such messages before on -rc2 or -rc3:
> amdgpu 0000:c3:00.0: amdgpu: [drm] amdgpu: DP AUX transfer fail:4
>
> dmesg is in attachment. But I don't think that these are related to
> hdp_v5_0_flush_hdp() issue.

Correct.  There was a DP AUX fix that also landed that was a bit too
chatty in some cases.  There will be a patch to quiet that down.

Alex

>
> Best regards,
> Alexey

