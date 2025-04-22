Return-Path: <stable+bounces-135149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFF8A971C6
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB1C1B6008C
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2909290BA4;
	Tue, 22 Apr 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5nKte8V"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984C92900A9
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337549; cv=none; b=li4/E/cKW+KPImTqLAYcHW+kL/lFAt8pLZJ8FdPGTjqaQaSwWCCuf7EF/GhzdwgmBoE6w5ubsRCTA3FXulZr1ieTzQ1hr+8sLTGsDKOl+x4gNzPiR3oS55BZYbJV/O7UQ4w8aehV503ig7yXMuIMTHVMEcudOfpPKOKS9YmbSOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337549; c=relaxed/simple;
	bh=qkowSlmFi9H2kxctEtYsMkr5MfuYfGMd64+KneBZJlg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KvZDTT6CZncJtW6+ZMKW4YyKcM8DRprUPOUEQgpI1fEDJRuQcz/8MdQjVcT1YdYZVrVtDKI7fioYFiztWKi6r6OOMZU7YRJVNICYqzWUyVVTsAn/z0n3KMsvV/vVdbrrmXFPCx7uNJnaUKrCbcw7dIb+ipC/mLZJmPSl/q6Scuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d5nKte8V; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso3870869f8f.0
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 08:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745337546; x=1745942346; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hAheUb7/AxYlrzvi7p9cQwyJGov/uzXYHxHoxFstwc=;
        b=d5nKte8Vz/NPA1HRW7uG3skweH3ryp0wuTYN0wvcOC9R8dkUoFAHIDio3fDAzQa3Ru
         eMpNjMVwdTMC5aWByt3DEZ79vTe1fkeq99ngAVOnekwHhsY3r/Dao4teQj1BCC/LM962
         Dr3LYhMgIBCxyUkQfSMhOVsxDd8Zi/boAOb6qDWAQa4ZNh1oG0uVTHn79MdKrqtfQX1V
         fA/Vn99U5xK6PBoCwghXKKuLWYw7+b/gOoU4QGDP7KZ/YmDu7Gk1GDDapFoXlniw2ekh
         jOGmlgR3oS8lCHD26CrSMlC846sjFNLtwMXnHei1vQoN4VKxgPqbclSt7sJrsj7+cfxy
         zcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337546; x=1745942346;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1hAheUb7/AxYlrzvi7p9cQwyJGov/uzXYHxHoxFstwc=;
        b=Ik/sxSuUeewNRBnfKVxK3axciH+hUQf0nG6Kus4UF1Z4W5lsEMgIunuC8U9J5Soo7+
         7M4WdXVUwCLxeIvBFTYxnmT1TaOJf3AmLsJoI9bi4Z1dRN73/7np/MFxglD819nbrrfV
         qt/ICk7d2gA+ssayl8IxMBB3brPPFVPiLciINbZWPYRAAWjBTbOyrazyo9tpVSwnXqdE
         4/fPOYN/90An+lz3DZLOhTFooo7ilntwL8ntcBNqlh5QN2hbnoxS9v/3qvwRKyQDNvD7
         FSSUI1NJ5WVoV5YMs2rSGg6hm8N/5SiNUvUabWCIX507oTejeF06IIFlFBgiHRaRi139
         0jxw==
X-Forwarded-Encrypted: i=1; AJvYcCVINr4MsajecMm26GeUIfPtirmX+Vevw1g7xgJ/rWOBJ32Fjcwn5frw9i9K5uiMbN9kmZnHCVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgabcg9mT6QKULGPp44cxwbc1mTONwowJjnx+uofo51j8bp/2c
	sdmix+ibI6fjXPqaVxSwdv+xjlTQk2tRztBB+mUMbx7JWL2BJ/8sh8RbysBMdCQ=
X-Gm-Gg: ASbGnctfB2NWvelC9q8y4eLBKKpcJaLDDNxvwQqU0bhBueRv6KD92NUPhCIwpUzFyai
	oy//xaUgFrlR46/EasTjq2a5H+lyu3kVcuqJ+Tes/RX70kF31dJW9eLg0loEeuLscqCCcEIZ04n
	jbxx2qEm2arRoAUXyFBfL96AYKF2pvMUHudbU3pUkDKCw1KD1dZP4kUv75Sfv3xPp8Y2f5JpuQt
	j0v0tJhmMlzVVh28VlHMogq4RPgilxF74KRnVMsM9ZAMFNib/FeVGe/zY0o6HiizGGtMbuHtyYd
	LEVT8HpKk8b5DmR0Fs+g9g73LdBmnt6S/92hUgBrEIhRKg==
X-Google-Smtp-Source: AGHT+IFeH0S2vE5n+XA/l4vfJhnhOuJ0R4qy6RCQGw7qpnpnlen7t2GaUFL3M60QTyETclUPXi4vdg==
X-Received: by 2002:a5d:6d87:0:b0:39c:1257:c96e with SMTP id ffacd0b85a97d-39efbb02224mr11882093f8f.58.1745337545702;
        Tue, 22 Apr 2025 08:59:05 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:6c39:59e6:b76d:825])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5d74a1sm176570345e9.37.2025.04.22.08.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 08:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Apr 2025 16:59:04 +0100
Message-Id: <D9DAIUZXIWH3.1L7CV6GEX4C9M@linaro.org>
Cc: "Fugang Duan" <fugang.duan@cixtech.com>, "alexander.deucher@amd.com"
 <alexander.deucher@amd.com>, "frank.min@amd.com" <frank.min@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "david.belanger@amd.com"
 <david.belanger@amd.com>, "christian.koenig@amd.com"
 <christian.koenig@amd.com>, "Peter Chen" <peter.chen@cixtech.com>,
 "cix-kernel-upstream" <cix-kernel-upstream@cixtech.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: =?utf-8?q?Re:_=E5=9B=9E=E5=A4=8D:_[REGRESSION]_amdgpu:_async_system_error?= =?utf-8?q?_exception_from_hdp=5Fv5=5F0=5Fflush=5Fhdp()?=
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Alex Deucher" <alexdeucher@gmail.com>
X-Mailer: aerc 0.20.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com> <D980Y4WDV662.L4S7QAU72GN2@linaro.org> <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com> <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com> <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com> <D9CT4HS7F067.J0GJHAGHI9G9@linaro.org> <CADnq5_ML25QA7xD+bLqNprO3zzTxJYLkiVw-KmeP-N6TqNHRYA@mail.gmail.com>
In-Reply-To: <CADnq5_ML25QA7xD+bLqNprO3zzTxJYLkiVw-KmeP-N6TqNHRYA@mail.gmail.com>

On Tue Apr 22, 2025 at 2:00 PM BST, Alex Deucher wrote:
> On Mon, Apr 21, 2025 at 10:21=E2=80=AFPM Alexey Klimov <alexey.klimov@lin=
aro.org> wrote:
>>
>> On Thu Apr 17, 2025 at 2:08 PM BST, Alex Deucher wrote:
>> > On Wed, Apr 16, 2025 at 8:43=E2=80=AFPM Fugang Duan <fugang.duan@cixte=
ch.com> wrote:
>> >>
>> >> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher <alexdeucher@gmail.com> =E5=
=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5 22:49
>> >> >=E6=94=B6=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.org=
>
>> >> >On Wed, Apr 16, 2025 at 9:48=E2=80=AFAM Alexey Klimov <alexey.klimov=
@linaro.org> wrote:
>> >> >>
>> >> >> On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
>> >> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro=
.org> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816
>> >> >=E6=97=A5 2:28
>> >> >> >>#regzbot introduced: v6.12..v6.13
>> >> >> >>The only change related to hdp_v5_0_flush_hdp() was
>> >> >> >>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing =
HDP
>> >> >> >>
>> >> >> >>Reverting that commit ^^ did help and resolved that problem. Bef=
ore

[..]

>> > OK.  that patch won't change anything then.  Can you try this patch in=
stead?
>>
>> Config I am using is basically defconfig wrt memory parameters, yeah, i =
use 4k.
>>
>> So I tested that patch, thank you, and some other different configuratio=
ns --
>> nothing helped. Exactly the same behaviour with the same backtrace.
>
> Did you test the first (4k check) or the second (don't remap on ARM) patc=
h?

The second one. I think you mentioned that first one won't help for 4k page=
s.


>> So it seems that it is firmware problem after all?
>
> There is no GPU firmware involved in this operation.  It's just a
> posted write.  E.g., we write to a register to flush the HDP write
> queue and then read the register back to make sure the write posted.
> If the second patch didn't help, then perhaps there is some issue with
> MMIO access on your platform?

I didn't mean GPU firmware at all. I only had uefi/EL3 firmwares in mind.

Completely out of the blue, based on nothing, do you think that
adding delay/some mem barrier between write and read might help?
I wonder if host data path code should be executed during common desktop
usage as a common user then why it doesn't break later. But yeah, I also
think this is this motherboard problem. Thank you.

Thanks,
Alexey


