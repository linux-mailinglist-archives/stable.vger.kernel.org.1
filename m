Return-Path: <stable+bounces-139208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1164AA5223
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 18:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB30D9C2D1D
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 16:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7A4288DA;
	Wed, 30 Apr 2025 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMpr8vDa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D859B14AD2D
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746032123; cv=none; b=VY64uAKnhHTFT9bdCdf0fspV33VSm1yR3JP4D3IxFsmE72BrD4f/tPlZPDu2ou+9Q4nxNHWdg/QsHLw178p6oJUdCVZyNJbVfn3j/f4LVkrm0C/poWYH197o02c6KjcZ6zPY/pJYKjKGZGrygz7Yms8+oUUqg2BGkWf+nhmphZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746032123; c=relaxed/simple;
	bh=CaW42qyFT7QNT9fYjtn2AJxaPIr/1J0EZI4r1JFkyd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLC8siZH2XQDumnuc5VKUdvIx2hAMDGFWCEa6Qe/Fto8Biv0Ok3ZKFvLGh5Vk1ub+9KHI/Tl1iGx0VN4gKYO/LKsQdsocuTgajA7XbXbBuWjzn6tOgd6H8e3NqY9RGdnYVU7qH7s2xjayYNxsI8ebglhO8dpnBmTWkhfYnkOlkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMpr8vDa; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so12786a91.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746032121; x=1746636921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5O/QqyB2JetR1daByi+Enr71fgFSTFioMGnKrLnKbX0=;
        b=hMpr8vDaneFiaaYWAQCbbQ421ap9yuRWk0u31VCXacUw/aoQg/XaO3r3SVzpqSnKG0
         5z/yNNYnFMWzarEPSY7Mr1jfWPUjATskaQ2ryMyPEAJ9K9wG32AFD0rSgVYrsUT4JOMX
         ljW5X4kYDXa4u3sY5qNKiurgG/IS2LnPkBeaKA5X1RzJqSpXMUecNEVTjxiVwdG+Bfa8
         1j5pUddHG8Z83KB7eYNVJ/4LDcz7RxjnQ3V7pvnph5+fAmuq2aeLh1Hx3iQCumF8p0zK
         1REpblB5jgBDwYfvUROS6AQGWYU6BmZZgGmCkYfkRrNnfFQEN6Rw7IddQFetrkYIJivK
         UhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746032121; x=1746636921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5O/QqyB2JetR1daByi+Enr71fgFSTFioMGnKrLnKbX0=;
        b=eH6IepkMTOsJjRlSaiIVe5VG5jUvTLzfIa/biFdYyL80pvsjnh3kcJyKRZEHL+nor4
         6IXQWze/1vrishkmiq5qzfZ6rlUD94/kCnG5ptgTSPdww9Mt5BhTbKi+6NP1TsEPyX6j
         vroiA76quU7CG5vZFWruuvhIvkeRa0RfG5dMCymI6TONA9nym7oKZ6nievyE52OdbJds
         fsUFvVU7gmdcUyivtWc0h6B2HryRmpdHC3HfIXy5Ff0fxU76m0Sfv98UhB0B70p8fpDh
         uUa2f1+wp010Sb9A+nfaqI421Fm3ZrorN7arSd0JnDHMjcupoOQpSnxahjRdr1EXpXqc
         MlIg==
X-Forwarded-Encrypted: i=1; AJvYcCUtiqfuDLw3ZABMX6n6rQIC4OgPttCtgmDWWcE5wWEiheDfNEq0pNgwr6ylmPcnQbp/quYKgzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoi/qyjCtoq2tOAjqqpplVrb7cNe08Yv0zmja+192Wtr50Gada
	mT4J0aiC3o8tn5H8PpaNm/7qXsn6LndjNOBi8Vup6K+Jvva15zjyqOdeCocXh0jcHMENeTSLSWm
	Dkl5vc2hatgkTkCdQFFfJSHjjDYc=
X-Gm-Gg: ASbGncv2VHPmWTWf4GmUSYYv8Ih5IYAO84zwLIEz4dnKuMW59licglrrxMcYDDML6gW
	yAj5M6I2LtwR4R8lHsHJhhLIx94VMsS3HLlgOTxb7OtJQ22XeiXVD+PN2RkEaaLoMNaNCTIzHaN
	SaK7eWHIrw4F2sE9CartMcDw==
X-Google-Smtp-Source: AGHT+IGvK/3VE6wEaPIFpyREgUlqXOVaxfm9+x6hqWPatICLfsELuOqmXlH/S3d9UReubp8RK/7mJRq7f+MAD8MzWpU=
X-Received: by 2002:a17:90b:38c9:b0:305:5f2c:c580 with SMTP id
 98e67ed59e1d1-30a3ba8ceaamr718773a91.2.1746032120837; Wed, 30 Apr 2025
 09:55:20 -0700 (PDT)
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
 <D9H0K4EW3XTV.1XO4KO44J1YRE@linaro.org>
In-Reply-To: <D9H0K4EW3XTV.1XO4KO44J1YRE@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Apr 2025 12:55:09 -0400
X-Gm-Features: ATxdqUFBl8m5CqDaAtyZNCLTB1Lg_n2ZD81Ie_2b8Uqe7cnJfY56XLH9gZuJop4
Message-ID: <CADnq5_PuXu-9MAhr3d7HLGnOqHR7Uo+nJPzrpdJEusvRCE8wbw@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="000000000000545e6a063401c80b"

--000000000000545e6a063401c80b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think I have a better solution.  Please try these patches instead.  Thank=
s!

For the RX6600, you only need patch 0003.  The rest of the series
fixes up other chips.

Thanks,

Alex

On Sat, Apr 26, 2025 at 9:01=E2=80=AFPM Alexey Klimov <alexey.klimov@linaro=
.org> wrote:
>
> On Thu Apr 24, 2025 at 4:44 PM BST, Alex Deucher wrote:
> > On Tue, Apr 22, 2025 at 11:59=E2=80=AFAM Alexey Klimov <alexey.klimov@l=
inaro.org> wrote:
> >>
> >> On Tue Apr 22, 2025 at 2:00 PM BST, Alex Deucher wrote:
> >> > On Mon, Apr 21, 2025 at 10:21=E2=80=AFPM Alexey Klimov <alexey.klimo=
v@linaro.org> wrote:
> >> >>
> >> >> On Thu Apr 17, 2025 at 2:08 PM BST, Alex Deucher wrote:
> >> >> > On Wed, Apr 16, 2025 at 8:43=E2=80=AFPM Fugang Duan <fugang.duan@=
cixtech.com> wrote:
> >> >> >>
> >> >> >> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher <alexdeucher@gmail.com=
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5 =
22:49
> >> >> >> >=E6=94=B6=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linar=
o.org>
> >> >> >> >On Wed, Apr 16, 2025 at 9:48=E2=80=AFAM Alexey Klimov <alexey.k=
limov@linaro.org> wrote:
> >> >> >> >>
> >> >> >> >> On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
> >> >> >> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@l=
inaro.org> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816
> >> >> >> >=E6=97=A5 2:28
> >> >> >> >> >>#regzbot introduced: v6.12..v6.13
> >> >> >> >> >>The only change related to hdp_v5_0_flush_hdp() was
> >> >> >> >> >>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flus=
hing HDP
> >> >> >> >> >>
> >> >> >> >> >>Reverting that commit ^^ did help and resolved that problem=
. Before
> >>
> >> [..]
> >>
> >> >> > OK.  that patch won't change anything then.  Can you try this pat=
ch instead?
> >> >>
> >> >> Config I am using is basically defconfig wrt memory parameters, yea=
h, i use 4k.
> >> >>
> >> >> So I tested that patch, thank you, and some other different configu=
rations --
> >> >> nothing helped. Exactly the same behaviour with the same backtrace.
> >> >
> >> > Did you test the first (4k check) or the second (don't remap on ARM)=
 patch?
> >>
> >> The second one. I think you mentioned that first one won't help for 4k=
 pages.
> >>
> >>
> >> >> So it seems that it is firmware problem after all?
> >> >
> >> > There is no GPU firmware involved in this operation.  It's just a
> >> > posted write.  E.g., we write to a register to flush the HDP write
> >> > queue and then read the register back to make sure the write posted.
> >> > If the second patch didn't help, then perhaps there is some issue wi=
th
> >> > MMIO access on your platform?
> >>
> >> I didn't mean GPU firmware at all. I only had uefi/EL3 firmwares in mi=
nd.
> >>
> >> Completely out of the blue, based on nothing, do you think that
> >> adding delay/some mem barrier between write and read might help?
> >> I wonder if host data path code should be executed during common deskt=
op
> >> usage as a common user then why it doesn't break later. But yeah, I al=
so
> >> think this is this motherboard problem. Thank you.
> >
> > I think I found the problem.  The previous patch wasn't doing what I
> > expected.  Please try this patch instead.
>
> This one works!
>
> [    4.483750] [drm] amdgpu kernel modesetting enabled.
> [    4.491985] amdgpu: IO link not available for non x86 platforms
> [    4.497189] amdgpu: Virtual CRAT table created for CPU
> [    4.497559] amdgpu: Topology: Add CPU node
> [    4.509623] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 0 <n=
v_common>
> [    4.512905] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 1 <g=
mc_v10_0>
> [    4.513254] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 2 <n=
avi10_ih>
> [    4.513595] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 3 <p=
sp>
> [    4.513932] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 4 <s=
mu>
> [    4.514278] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 5 <d=
m>
> [    4.514625] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 6 <g=
fx_v10_0>
> [    4.514980] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 7 <s=
dma_v5_2>
> [    4.515334] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 8 <v=
cn_v3_0>
> [    4.515699] amdgpu 0000:c3:00.0: amdgpu: detected ip block number 9 <j=
peg_v3_0>
> [    4.516087] amdgpu 0000:c3:00.0: amdgpu: Fetched VBIOS from VFCT
> [    4.516466] amdgpu: ATOM BIOS: 113-V502MECH-0OC
> [    4.749748] amdgpu 0000:c3:00.0: amdgpu: Trusted Memory Zone (TMZ) fea=
ture disabled as experimental (default)
> [    4.777435] amdgpu 0000:c3:00.0: BAR 2 [mem 0x1810000000-0x18101fffff =
64bit pref]: releasing
> [    4.793256] amdgpu 0000:c3:00.0: BAR 0 [mem 0x1800000000-0x180fffffff =
64bit pref]: releasing
> [    4.844639] amdgpu 0000:c3:00.0: BAR 0 [mem 0x1800000000-0x19ffffffff =
64bit pref]: assigned
> [    4.849774] amdgpu 0000:c3:00.0: BAR 2 [mem 0x1a00000000-0x1a001fffff =
64bit pref]: assigned
> [    4.957411] amdgpu 0000:c3:00.0: amdgpu: VRAM: 8176M 0x000000800000000=
0 - 0x00000081FEFFFFFF (8176M used)
> [    4.967618] amdgpu 0000:c3:00.0: amdgpu: GART: 512M 0x0000000000000000=
 - 0x000000001FFFFFFF
> [    4.992963] [drm] amdgpu: 8176M of VRAM memory ready
> [    5.004032] [drm] amdgpu: 7888M of GTT memory ready.
> [    6.224159] amdgpu 0000:c3:00.0: amdgpu: STB initialized to 2048 entri=
es
> [    6.284328] amdgpu 0000:c3:00.0: amdgpu: Found VCN firmware Version EN=
C: 1.33 DEC: 4 VEP: 0 Revision: 3
> [    6.361142] amdgpu 0000:c3:00.0: amdgpu: reserve 0xa00000 from 0x81fd0=
00000 for PSP TMR
> [    6.471231] amdgpu 0000:c3:00.0: amdgpu: RAS: optional ras ta ucode is=
 not available
> [    6.492967] amdgpu 0000:c3:00.0: amdgpu: SECUREDISPLAY: securedisplay =
ta ucode is not available
> [    6.492993] amdgpu 0000:c3:00.0: amdgpu: smu driver if version =3D 0x0=
000000f, smu fw if version =3D 0x00000013, smu fw program =3D 0, version =
=3D 0x003b3100 (59.49.0)
> [    6.513659] amdgpu 0000:c3:00.0: amdgpu: SMU driver if version not mat=
ched
> [    6.513699] amdgpu 0000:c3:00.0: amdgpu: use vbios provided pptable
> [    6.588418] amdgpu 0000:c3:00.0: amdgpu: SMU is initialized successful=
ly!
> [    6.800975] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
> [    6.806709] kfd kfd: amdgpu: Total number of KFD nodes to be created: =
1
> [    6.813516] amdgpu: Virtual CRAT table created for GPU
> [    6.819229] amdgpu: Topology: Add dGPU node [0x73ff:0x1002]
> [    6.824865] kfd kfd: amdgpu: added device 1002:73ff
> [    6.829821] amdgpu 0000:c3:00.0: amdgpu: SE 2, SH per SE 2, CU per SH =
8, active_cu_number 28
> [    6.838355] amdgpu 0000:c3:00.0: amdgpu: ring gfx_0.0.0 uses VM inv en=
g 0 on hub 0
> [    6.846007] amdgpu 0000:c3:00.0: amdgpu: ring gfx_0.1.0 uses VM inv en=
g 1 on hub 0
> [    6.853658] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.0.0 uses VM inv e=
ng 4 on hub 0
> [    6.861398] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.1.0 uses VM inv e=
ng 5 on hub 0
> [    6.869137] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.2.0 uses VM inv e=
ng 6 on hub 0
> [    6.876877] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.3.0 uses VM inv e=
ng 7 on hub 0
> [    6.884615] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.0.1 uses VM inv e=
ng 8 on hub 0
> [    6.892356] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.1.1 uses VM inv e=
ng 9 on hub 0
> [    6.900094] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.2.1 uses VM inv e=
ng 10 on hub 0
> [    6.907921] amdgpu 0000:c3:00.0: amdgpu: ring comp_1.3.1 uses VM inv e=
ng 11 on hub 0
> [    6.915748] amdgpu 0000:c3:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv =
eng 12 on hub 0
> [    6.923663] amdgpu 0000:c3:00.0: amdgpu: ring sdma0 uses VM inv eng 13=
 on hub 0
> [    6.931050] amdgpu 0000:c3:00.0: amdgpu: ring sdma1 uses VM inv eng 14=
 on hub 0
> [    6.938439] amdgpu 0000:c3:00.0: amdgpu: ring vcn_dec_0 uses VM inv en=
g 0 on hub 8
> [    6.946089] amdgpu 0000:c3:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv =
eng 1 on hub 8
> [    6.953916] amdgpu 0000:c3:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv =
eng 4 on hub 8
> [    6.961742] amdgpu 0000:c3:00.0: amdgpu: ring jpeg_dec uses VM inv eng=
 5 on hub 8
> [    6.970485] amdgpu 0000:c3:00.0: amdgpu: Using BACO for runtime pm
> [    6.977167] [drm] Initialized amdgpu 3.63.0 for 0000:c3:00.0 on minor =
0
> [    7.234638] amdgpu 0000:c3:00.0: [drm] fb0: amdgpudrmfb frame buffer d=
evice
> root@orion:~ # uname -a
> Linux orion 6.15.0-rc3test6+ #1 SMP Sun Apr 27 01:12:10 BST 2025 aarch64 =
GNU/Linux
>
> Thank you for taking a look into this.
>
> Best regards,
> Alexey
>

--000000000000545e6a063401c80b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0005-drm-amdgpu-hdp7-use-memcfg-register-to-post-the-writ.patch"
Content-Disposition: attachment; 
	filename="0005-drm-amdgpu-hdp7-use-memcfg-register-to-post-the-writ.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ma46d6od0>
X-Attachment-Id: f_ma46d6od0

RnJvbSA5YzhjODBiYTk3MDgxNmU2NTNlOWYxMDBiMmUzM2RhZmViZjExY2NlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMzAgQXByIDIwMjUgMTI6NTA6MDIgLTA0MDAKU3ViamVjdDogW1BBVENI
IDUvNV0gZHJtL2FtZGdwdS9oZHA3OiB1c2UgbWVtY2ZnIHJlZ2lzdGVyIHRvIHBvc3QgdGhlIHdy
aXRlCiBmb3IgSERQIGZsdXNoCgpSZWFkaW5nIGJhY2sgdGhlIHJlbWFwcGVkIEhEUCBmbHVzaCBy
ZWdpc3RlciBzZWVtcyB0byBjYXVzZQpwcm9ibGVtcyBvbiBzb21lIHBsYXRmb3Jtcy4gQWxsIHdl
IG5lZWQgaXMgYSByZWFkLCBzbyByZWFkIGJhY2sKdGhlIG1lbWNmZyByZWdpc3Rlci4KCkZpeGVz
OiA2ODkyNzUxNDBjYjggKCJkcm0vYW1kZ3B1L2hkcDcuMDogZG8gYSBwb3N0aW5nIHJlYWQgd2hl
biBmbHVzaGluZyBIRFAiKQpSZXBvcnRlZC1ieTogQWxleGV5IEtsaW1vdiA8YWxleGV5LmtsaW1v
dkBsaW5hcm8ub3JnPgpMaW5rOiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9hcmNoaXZl
cy9hbWQtZ2Z4LzIwMjUtQXByaWwvMTIzMTUwLmh0bWwKQ2xvc2VzOiBodHRwczovL2dpdGxhYi5m
cmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy80MTE5CkNsb3NlczogaHR0cHM6Ly9naXRs
YWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMzkwOApTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvaGRwX3Y3XzAuYyB8IDcgKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2hkcF92N18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9oZHBf
djdfMC5jCmluZGV4IDQ5ZjdlYjRmYmQxMTcuLjJjOTIzOWEyMmYzOTggMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2hkcF92N18wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvaGRwX3Y3XzAuYwpAQCAtMzIsNyArMzIsMTIgQEAgc3RhdGljIHZvaWQgaGRw
X3Y3XzBfZmx1c2hfaGRwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogewogCWlmICghcmlu
ZyB8fCAhcmluZy0+ZnVuY3MtPmVtaXRfd3JlZykgewogCQlXUkVHMzIoKGFkZXYtPnJtbWlvX3Jl
bWFwLnJlZ19vZmZzZXQgKyBLRkRfTU1JT19SRU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwpID4+IDIs
IDApOwotCQlSUkVHMzIoKGFkZXYtPnJtbWlvX3JlbWFwLnJlZ19vZmZzZXQgKyBLRkRfTU1JT19S
RU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwpID4+IDIpOworCQkvKiBXZSBqdXN0IG5lZWQgdG8gcmVh
ZCBiYWNrIGEgcmVnaXN0ZXIgdG8gcG9zdCB0aGUgd3JpdGUuCisJCSAqIFJlYWRpbmcgYmFjayB0
aGUgcmVtYXBwZWQgcmVnaXN0ZXIgY2F1c2VzIHByb2JsZW1zIG9uCisJCSAqIHNvbWUgcGxhdGZv
cm1zIHNvIGp1c3QgcmVhZCBiYWNrIHRoZSBtZW1vcnkgc2l6ZSByZWdpc3Rlci4KKwkJICovCisJ
CWlmIChhZGV2LT5uYmlvLmZ1bmNzLT5nZXRfbWVtc2l6ZSkKKwkJCWFkZXYtPm5iaW8uZnVuY3Mt
PmdldF9tZW1zaXplKGFkZXYpOwogCX0gZWxzZSB7CiAJCWFtZGdwdV9yaW5nX2VtaXRfd3JlZyhy
aW5nLCAoYWRldi0+cm1taW9fcmVtYXAucmVnX29mZnNldCArIEtGRF9NTUlPX1JFTUFQX0hEUF9N
RU1fRkxVU0hfQ05UTCkgPj4gMiwgMCk7CiAJfQotLSAKMi40OS4wCgo=
--000000000000545e6a063401c80b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0004-drm-amdgpu-hdp6-use-memcfg-register-to-post-the-writ.patch"
Content-Disposition: attachment; 
	filename="0004-drm-amdgpu-hdp6-use-memcfg-register-to-post-the-writ.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ma46d6oi1>
X-Attachment-Id: f_ma46d6oi1

RnJvbSA2OTdkMzliNzQwZGIwNmIxNjE0MTQwMmZlOWJhMzMyNzI5MGU5OTRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMzAgQXByIDIwMjUgMTI6NDg6NTEgLTA0MDAKU3ViamVjdDogW1BBVENI
IDQvNV0gZHJtL2FtZGdwdS9oZHA2OiB1c2UgbWVtY2ZnIHJlZ2lzdGVyIHRvIHBvc3QgdGhlIHdy
aXRlCiBmb3IgSERQIGZsdXNoCgpSZWFkaW5nIGJhY2sgdGhlIHJlbWFwcGVkIEhEUCBmbHVzaCBy
ZWdpc3RlciBzZWVtcyB0byBjYXVzZQpwcm9ibGVtcyBvbiBzb21lIHBsYXRmb3Jtcy4gQWxsIHdl
IG5lZWQgaXMgYSByZWFkLCBzbyByZWFkIGJhY2sKdGhlIG1lbWNmZyByZWdpc3Rlci4KCkZpeGVz
OiBhYmUxY2JhZWM2Y2YgKCJkcm0vYW1kZ3B1L2hkcDYuMDogZG8gYSBwb3N0aW5nIHJlYWQgd2hl
biBmbHVzaGluZyBIRFAiKQpSZXBvcnRlZC1ieTogQWxleGV5IEtsaW1vdiA8YWxleGV5LmtsaW1v
dkBsaW5hcm8ub3JnPgpMaW5rOiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9hcmNoaXZl
cy9hbWQtZ2Z4LzIwMjUtQXByaWwvMTIzMTUwLmh0bWwKQ2xvc2VzOiBodHRwczovL2dpdGxhYi5m
cmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy80MTE5CkNsb3NlczogaHR0cHM6Ly9naXRs
YWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMzkwOApTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvaGRwX3Y2XzAuYyB8IDcgKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2hkcF92Nl8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9oZHBf
djZfMC5jCmluZGV4IGE4OGQyNWEwNmMyOWIuLjZjY2QzMWM4YmM2OTIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2hkcF92Nl8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvaGRwX3Y2XzAuYwpAQCAtMzUsNyArMzUsMTIgQEAgc3RhdGljIHZvaWQgaGRw
X3Y2XzBfZmx1c2hfaGRwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogewogCWlmICghcmlu
ZyB8fCAhcmluZy0+ZnVuY3MtPmVtaXRfd3JlZykgewogCQlXUkVHMzIoKGFkZXYtPnJtbWlvX3Jl
bWFwLnJlZ19vZmZzZXQgKyBLRkRfTU1JT19SRU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwpID4+IDIs
IDApOwotCQlSUkVHMzIoKGFkZXYtPnJtbWlvX3JlbWFwLnJlZ19vZmZzZXQgKyBLRkRfTU1JT19S
RU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwpID4+IDIpOworCQkvKiBXZSBqdXN0IG5lZWQgdG8gcmVh
ZCBiYWNrIGEgcmVnaXN0ZXIgdG8gcG9zdCB0aGUgd3JpdGUuCisJCSAqIFJlYWRpbmcgYmFjayB0
aGUgcmVtYXBwZWQgcmVnaXN0ZXIgY2F1c2VzIHByb2JsZW1zIG9uCisJCSAqIHNvbWUgcGxhdGZv
cm1zIHNvIGp1c3QgcmVhZCBiYWNrIHRoZSBtZW1vcnkgc2l6ZSByZWdpc3Rlci4KKwkJICovCisJ
CWlmIChhZGV2LT5uYmlvLmZ1bmNzLT5nZXRfbWVtc2l6ZSkKKwkJCWFkZXYtPm5iaW8uZnVuY3Mt
PmdldF9tZW1zaXplKGFkZXYpOwogCX0gZWxzZSB7CiAJCWFtZGdwdV9yaW5nX2VtaXRfd3JlZyhy
aW5nLCAoYWRldi0+cm1taW9fcmVtYXAucmVnX29mZnNldCArIEtGRF9NTUlPX1JFTUFQX0hEUF9N
RU1fRkxVU0hfQ05UTCkgPj4gMiwgMCk7CiAJfQotLSAKMi40OS4wCgo=
--000000000000545e6a063401c80b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-drm-amdgpu-hdp5-use-memcfg-register-to-post-the-writ.patch"
Content-Disposition: attachment; 
	filename="0002-drm-amdgpu-hdp5-use-memcfg-register-to-post-the-writ.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ma46d6oq3>
X-Attachment-Id: f_ma46d6oq3

RnJvbSBiOGQ3ZmEwMDEwYzNkZDQxMmE3MmYxYzg5ZGI4MWFjODllMTA3MjYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMzAgQXByIDIwMjUgMTI6NDY6NTYgLTA0MDAKU3ViamVjdDogW1BBVENI
IDIvNV0gZHJtL2FtZGdwdS9oZHA1OiB1c2UgbWVtY2ZnIHJlZ2lzdGVyIHRvIHBvc3QgdGhlIHdy
aXRlCiBmb3IgSERQIGZsdXNoCgpSZWFkaW5nIGJhY2sgdGhlIHJlbWFwcGVkIEhEUCBmbHVzaCBy
ZWdpc3RlciBzZWVtcyB0byBjYXVzZQpwcm9ibGVtcyBvbiBzb21lIHBsYXRmb3Jtcy4gQWxsIHdl
IG5lZWQgaXMgYSByZWFkLCBzbyByZWFkIGJhY2sKdGhlIG1lbWNmZyByZWdpc3Rlci4KCkZpeGVz
OiBjZjQyNDAyMGUwNDAgKCJkcm0vYW1kZ3B1L2hkcDUuMDogZG8gYSBwb3N0aW5nIHJlYWQgd2hl
biBmbHVzaGluZyBIRFAiKQpSZXBvcnRlZC1ieTogQWxleGV5IEtsaW1vdiA8YWxleGV5LmtsaW1v
dkBsaW5hcm8ub3JnPgpMaW5rOiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9hcmNoaXZl
cy9hbWQtZ2Z4LzIwMjUtQXByaWwvMTIzMTUwLmh0bWwKQ2xvc2VzOiBodHRwczovL2dpdGxhYi5m
cmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy80MTE5CkNsb3NlczogaHR0cHM6Ly9naXRs
YWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMzkwOApTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvaGRwX3Y1XzAuYyB8IDcgKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2hkcF92NV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9oZHBf
djVfMC5jCmluZGV4IDQzMTk1YzA3OTc0ODAuLjA4NmE2NDczMDhkZjAgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2hkcF92NV8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvaGRwX3Y1XzAuYwpAQCAtMzIsNyArMzIsMTIgQEAgc3RhdGljIHZvaWQgaGRw
X3Y1XzBfZmx1c2hfaGRwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogewogCWlmICghcmlu
ZyB8fCAhcmluZy0+ZnVuY3MtPmVtaXRfd3JlZykgewogCQlXUkVHMzIoKGFkZXYtPnJtbWlvX3Jl
bWFwLnJlZ19vZmZzZXQgKyBLRkRfTU1JT19SRU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwpID4+IDIs
IDApOwotCQlSUkVHMzIoKGFkZXYtPnJtbWlvX3JlbWFwLnJlZ19vZmZzZXQgKyBLRkRfTU1JT19S
RU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwpID4+IDIpOworCQkvKiBXZSBqdXN0IG5lZWQgdG8gcmVh
ZCBiYWNrIGEgcmVnaXN0ZXIgdG8gcG9zdCB0aGUgd3JpdGUuCisJCSAqIFJlYWRpbmcgYmFjayB0
aGUgcmVtYXBwZWQgcmVnaXN0ZXIgY2F1c2VzIHByb2JsZW1zIG9uCisJCSAqIHNvbWUgcGxhdGZv
cm1zIHNvIGp1c3QgcmVhZCBiYWNrIHRoZSBtZW1vcnkgc2l6ZSByZWdpc3Rlci4KKwkJICovCisJ
CWlmIChhZGV2LT5uYmlvLmZ1bmNzLT5nZXRfbWVtc2l6ZSkKKwkJCWFkZXYtPm5iaW8uZnVuY3Mt
PmdldF9tZW1zaXplKGFkZXYpOwogCX0gZWxzZSB7CiAJCWFtZGdwdV9yaW5nX2VtaXRfd3JlZyhy
aW5nLCAoYWRldi0+cm1taW9fcmVtYXAucmVnX29mZnNldCArIEtGRF9NTUlPX1JFTUFQX0hEUF9N
RU1fRkxVU0hfQ05UTCkgPj4gMiwgMCk7CiAJfQotLSAKMi40OS4wCgo=
--000000000000545e6a063401c80b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0003-drm-amdgpu-hdp5.2-use-memcfg-register-to-post-the-wr.patch"
Content-Disposition: attachment; 
	filename="0003-drm-amdgpu-hdp5.2-use-memcfg-register-to-post-the-wr.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ma46d6ol2>
X-Attachment-Id: f_ma46d6ol2

RnJvbSAzNTU1N2E2MGMyZTVmZGY5ZGI4ZTFmMDZjYWRjOWNkNDcwZWEyNmEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMzAgQXByIDIwMjUgMTI6NDc6MzcgLTA0MDAKU3ViamVjdDogW1BBVENI
IDMvNV0gZHJtL2FtZGdwdS9oZHA1LjI6IHVzZSBtZW1jZmcgcmVnaXN0ZXIgdG8gcG9zdCB0aGUg
d3JpdGUKIGZvciBIRFAgZmx1c2gKClJlYWRpbmcgYmFjayB0aGUgcmVtYXBwZWQgSERQIGZsdXNo
IHJlZ2lzdGVyIHNlZW1zIHRvIGNhdXNlCnByb2JsZW1zIG9uIHNvbWUgcGxhdGZvcm1zLiBBbGwg
d2UgbmVlZCBpcyBhIHJlYWQsIHNvIHJlYWQgYmFjawp0aGUgbWVtY2ZnIHJlZ2lzdGVyLgoKRml4
ZXM6IGY3NTZkYmFjMWNlMSAoImRybS9hbWRncHUvaGRwNS4yOiBkbyBhIHBvc3RpbmcgcmVhZCB3
aGVuIGZsdXNoaW5nIEhEUCIpClJlcG9ydGVkLWJ5OiBBbGV4ZXkgS2xpbW92IDxhbGV4ZXkua2xp
bW92QGxpbmFyby5vcmc+Ckxpbms6IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hp
dmVzL2FtZC1nZngvMjAyNS1BcHJpbC8xMjMxNTAuaHRtbApDbG9zZXM6IGh0dHBzOi8vZ2l0bGFi
LmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzQxMTkKQ2xvc2VzOiBodHRwczovL2dp
dGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8zOTA4ClNpZ25lZC1vZmYtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9oZHBfdjVfMi5jIHwgMTIgKysrKysrKysrKystCiAxIGZpbGUgY2hh
bmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2hkcF92NV8yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9oZHBfdjVfMi5jCmluZGV4IGZjYjhkZDI4NzZiY2MuLjQwOTQwYjRhYjQwMDcgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2hkcF92NV8yLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvaGRwX3Y1XzIuYwpAQCAtMzMsNyArMzMsMTcgQEAgc3RhdGlj
IHZvaWQgaGRwX3Y1XzJfZmx1c2hfaGRwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCWlm
ICghcmluZyB8fCAhcmluZy0+ZnVuY3MtPmVtaXRfd3JlZykgewogCQlXUkVHMzJfTk9fS0lRKChh
ZGV2LT5ybW1pb19yZW1hcC5yZWdfb2Zmc2V0ICsgS0ZEX01NSU9fUkVNQVBfSERQX01FTV9GTFVT
SF9DTlRMKSA+PiAyLAogCQkJMCk7Ci0JCVJSRUczMl9OT19LSVEoKGFkZXYtPnJtbWlvX3JlbWFw
LnJlZ19vZmZzZXQgKyBLRkRfTU1JT19SRU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwpID4+IDIpOwor
CQlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7CisJCQkvKiB0aGlzIGlzIGZpbmUgYmVjYXVz
ZSBTUl9JT1YgZG9lc24ndCByZW1hcCB0aGUgcmVnaXN0ZXIgKi8KKwkJCVJSRUczMl9OT19LSVEo
KGFkZXYtPnJtbWlvX3JlbWFwLnJlZ19vZmZzZXQgKyBLRkRfTU1JT19SRU1BUF9IRFBfTUVNX0ZM
VVNIX0NOVEwpID4+IDIpOworCQl9IGVsc2UgeworCQkJLyogV2UganVzdCBuZWVkIHRvIHJlYWQg
YmFjayBhIHJlZ2lzdGVyIHRvIHBvc3QgdGhlIHdyaXRlLgorCQkJICogUmVhZGluZyBiYWNrIHRo
ZSByZW1hcHBlZCByZWdpc3RlciBjYXVzZXMgcHJvYmxlbXMgb24KKwkJCSAqIHNvbWUgcGxhdGZv
cm1zIHNvIGp1c3QgcmVhZCBiYWNrIHRoZSBtZW1vcnkgc2l6ZSByZWdpc3Rlci4KKwkJCSAqLwor
CQkJaWYgKGFkZXYtPm5iaW8uZnVuY3MtPmdldF9tZW1zaXplKQorCQkJCWFkZXYtPm5iaW8uZnVu
Y3MtPmdldF9tZW1zaXplKGFkZXYpOworCQl9CiAJfSBlbHNlIHsKIAkJYW1kZ3B1X3JpbmdfZW1p
dF93cmVnKHJpbmcsCiAJCQkoYWRldi0+cm1taW9fcmVtYXAucmVnX29mZnNldCArIEtGRF9NTUlP
X1JFTUFQX0hEUF9NRU1fRkxVU0hfQ05UTCkgPj4gMiwKLS0gCjIuNDkuMAoK
--000000000000545e6a063401c80b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-hdp4-use-memcfg-register-to-post-the-writ.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-hdp4-use-memcfg-register-to-post-the-writ.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ma46d6os4>
X-Attachment-Id: f_ma46d6os4

RnJvbSAyNTgyZDAzYjE4MTI5MTkwNTNmMGI3MzNkYzM3ZjMyMDY1YzhjNWI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMzAgQXByIDIwMjUgMTI6NDU6MDQgLTA0MDAKU3ViamVjdDogW1BBVENI
IDEvNV0gZHJtL2FtZGdwdS9oZHA0OiB1c2UgbWVtY2ZnIHJlZ2lzdGVyIHRvIHBvc3QgdGhlIHdy
aXRlCiBmb3IgSERQIGZsdXNoCgpSZWFkaW5nIGJhY2sgdGhlIHJlbWFwcGVkIEhEUCBmbHVzaCBy
ZWdpc3RlciBzZWVtcyB0byBjYXVzZQpwcm9ibGVtcyBvbiBzb21lIHBsYXRmb3Jtcy4gQWxsIHdl
IG5lZWQgaXMgYSByZWFkLCBzbyByZWFkIGJhY2sKdGhlIG1lbWNmZyByZWdpc3Rlci4KCkZpeGVz
OiBjOWI4ZGNhYmI1MmEgKCJkcm0vYW1kZ3B1L2hkcDQuMDogZG8gYSBwb3N0aW5nIHJlYWQgd2hl
biBmbHVzaGluZyBIRFAiKQpSZXBvcnRlZC1ieTogQWxleGV5IEtsaW1vdiA8YWxleGV5LmtsaW1v
dkBsaW5hcm8ub3JnPgpMaW5rOiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9hcmNoaXZl
cy9hbWQtZ2Z4LzIwMjUtQXByaWwvMTIzMTUwLmh0bWwKQ2xvc2VzOiBodHRwczovL2dpdGxhYi5m
cmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy80MTE5CkNsb3NlczogaHR0cHM6Ly9naXRs
YWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMzkwOApTaWduZWQtb2ZmLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvaGRwX3Y0XzAuYyB8IDcgKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2hkcF92NF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9oZHBf
djRfMC5jCmluZGV4IGYxZGMxM2IzYWIzOGUuLmNiYmVhZGViNTNmNzIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2hkcF92NF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvaGRwX3Y0XzAuYwpAQCAtNDEsNyArNDEsMTIgQEAgc3RhdGljIHZvaWQgaGRw
X3Y0XzBfZmx1c2hfaGRwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogewogCWlmICghcmlu
ZyB8fCAhcmluZy0+ZnVuY3MtPmVtaXRfd3JlZykgewogCQlXUkVHMzIoKGFkZXYtPnJtbWlvX3Jl
bWFwLnJlZ19vZmZzZXQgKyBLRkRfTU1JT19SRU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwpID4+IDIs
IDApOwotCQlSUkVHMzIoKGFkZXYtPnJtbWlvX3JlbWFwLnJlZ19vZmZzZXQgKyBLRkRfTU1JT19S
RU1BUF9IRFBfTUVNX0ZMVVNIX0NOVEwpID4+IDIpOworCQkvKiBXZSBqdXN0IG5lZWQgdG8gcmVh
ZCBiYWNrIGEgcmVnaXN0ZXIgdG8gcG9zdCB0aGUgd3JpdGUuCisJCSAqIFJlYWRpbmcgYmFjayB0
aGUgcmVtYXBwZWQgcmVnaXN0ZXIgY2F1c2VzIHByb2JsZW1zIG9uCisJCSAqIHNvbWUgcGxhdGZv
cm1zIHNvIGp1c3QgcmVhZCBiYWNrIHRoZSBtZW1vcnkgc2l6ZSByZWdpc3Rlci4KKwkJICovCisJ
CWlmIChhZGV2LT5uYmlvLmZ1bmNzLT5nZXRfbWVtc2l6ZSkKKwkJCWFkZXYtPm5iaW8uZnVuY3Mt
PmdldF9tZW1zaXplKGFkZXYpOwogCX0gZWxzZSB7CiAJCWFtZGdwdV9yaW5nX2VtaXRfd3JlZyhy
aW5nLCAoYWRldi0+cm1taW9fcmVtYXAucmVnX29mZnNldCArIEtGRF9NTUlPX1JFTUFQX0hEUF9N
RU1fRkxVU0hfQ05UTCkgPj4gMiwgMCk7CiAJfQotLSAKMi40OS4wCgo=
--000000000000545e6a063401c80b--

