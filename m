Return-Path: <stable+bounces-69592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3850956C42
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 15:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A201F21F4A
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 13:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79194166F33;
	Mon, 19 Aug 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDTMhOyi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AA3154C19
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074620; cv=none; b=UimMVrqdQm6xbzddfpLg45DKObeNarpkQ6AWzocSTTqNMdyfUfGSzIM91vOGykzoB9JpydHaCAsaa8+eWZ4ECYHRI0ANHEoLrfUFaWkHQfCWl69Qk77r1P7Gtq6pPzLmTNvVN7cxxsDT5CSQufoyWXzXY8Zywitdr8EZWeBrowg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074620; c=relaxed/simple;
	bh=yodeGLcqFa060SAPomqzBZyEqG1ZuAo2UlfNgfHLRqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IR9W9KcrS7e7ZQNYvOokOrt9B8XHfcv97m2EEt9i5poXXeOjvSApyg2ktA9yBqI3rumtQ91QvkVjfZ/9ae/jHO9TgB7ILgTBTo5uttrTWXCm8fCic8TjPyPyzNDLnCu2B+ka5lJ1dBhFzmjzYqdly847gUw0Y6ICUNwu+uigEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NDTMhOyi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724074617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/iJNM2H0Bn+mH5epT+OXY9z51A/PXnyvIAFT4yJMBs=;
	b=NDTMhOyiEy4+rGtkbWl4xUlH+gg7V2NaZue6a3Piy1PeeH8CS3Av3V+bUcWZi0xuatcd04
	5GcdwUe4+Ll5jphtSGDV7Qe7fXgYD1CTxZRhY+9qTx5JHlISO6nKz3x3a2I/37/FmXIncW
	YeEZMI5rZpBvzy7DmyJtrf9jdvyPh/Y=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-72Hr-HFDPIijOYFFHE5xAQ-1; Mon, 19 Aug 2024 09:36:56 -0400
X-MC-Unique: 72Hr-HFDPIijOYFFHE5xAQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3dc298e09bcso3962745b6e.3
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 06:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724074615; x=1724679415;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/iJNM2H0Bn+mH5epT+OXY9z51A/PXnyvIAFT4yJMBs=;
        b=scurSbcu61mFDAqs1YvBa+qYVJV+rbQ16w0INIl0dBzzorRLPJbg7CqTXrHVQLw+NK
         QGh39wIVbhaZgbNx6tWOsY97tqPpYVqcLui6ty8O6lbx2ExjetIPwb7B5Oy62d9SDuoU
         GcPGzER378+O4dMlW1qLZU9sf2gFkUzdoUjqPRdHq1s+7dlg+C6BXIAMZKHGAhWjTWPg
         xfcmZnPdFaqcsR/ILQFF60qGiJnGAf/WqUTxzyB74/QndeqMOyDqggEtrEcI23VaG3k9
         7TM1TJEp2zd3J5ORJmd83U202LNzxI349j+IOpzoX5JkT2wakKXn/lg0fU8GhYNGLhzC
         rNOg==
X-Forwarded-Encrypted: i=1; AJvYcCUQgSRdkizatutMfRz2jF+DHvTX1V7y30BUT+kCmXHH2WjHNw00Ppcel+yMm3e68k6r+JV8u4o+NpbRStXptqltExZkp9DN
X-Gm-Message-State: AOJu0Yy9tNiQSSYyODwrAbgEKjdEBaXROADQpMCd3Qp+HZJvASIARa4B
	tzaM6tFgqSMNw9qBc1zgYs974/Nkw3AYCJY6+FUJ7/yTy3mj5dEwdHzLDC2MnljEL1bzdaB/nBa
	XvzReoeQpSalhtI6+9m4K4oTbdisSdsr5j+Rd7PAffGldneZqSsNMww==
X-Received: by 2002:a05:6808:148a:b0:3da:e219:bf with SMTP id 5614622812f47-3dd3ae320edmr14893354b6e.43.1724074615344;
        Mon, 19 Aug 2024 06:36:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPpaKdjs9uyeLCpbyaYGw5neC/R9XgXicCaeDNO0oBOnU3UKv8pW+3H0tiVsMRwweNVZ2MzA==
X-Received: by 2002:a05:6808:148a:b0:3da:e219:bf with SMTP id 5614622812f47-3dd3ae320edmr14893327b6e.43.1724074614976;
        Mon, 19 Aug 2024 06:36:54 -0700 (PDT)
Received: from localhost ([181.120.144.238])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61a6dcfsm6585022a12.7.2024.08.19.06.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 06:36:54 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, Alex Deucher
 <alexdeucher@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Alex Deucher
 <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, oe-kbuild-all@lists.linux.dev,
 intel-gfx@lists.freedesktop.org, Helge Deller <deller@gmx.de>, Sam
 Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 stable@vger.kernel.org
Subject: Re: [PATCH] video/aperture: match the pci device when calling
 sysfb_disable()
In-Reply-To: <8bbf3f92-3719-4ff4-9587-e076635758d1@suse.de>
References: <20240809150327.2485848-1-alexander.deucher@amd.com>
 <202408101951.tXyqYOzv-lkp@intel.com>
 <1c77f913-4707-4300-b84a-36fcf99942f4@suse.de>
 <CADnq5_NjCFyy+bQY+uyijcZwvwXYkvVLLUQdtzN_ODvHAj193Q@mail.gmail.com>
 <8bbf3f92-3719-4ff4-9587-e076635758d1@suse.de>
Date: Mon, 19 Aug 2024 15:36:51 +0200
Message-ID: <87frr0ljm4.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Alex and Thomas,

> Hi
>
> Am 16.08.24 um 22:57 schrieb Alex Deucher:
>> On Mon, Aug 12, 2024 at 8:10=E2=80=AFAM Thomas Zimmermann <tzimmermann@s=
use.de> wrote:
>>> Hi
>>>
>>> Am 10.08.24 um 13:44 schrieb kernel test robot:
>>>> Hi Alex,
>>>>
>>>> kernel test robot noticed the following build errors:
>>>>
>>>> [auto build test ERROR on drm-misc/drm-misc-next]
>>>> [also build test ERROR on linus/master v6.11-rc2 next-20240809]
>>>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>>>> And when submitting patch, we suggest to use '--base' as documented in
>>>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>>>
>>>> url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Deucher/vi=
deo-aperture-match-the-pci-device-when-calling-sysfb_disable/20240810-021357
>>>> base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
>>>> patch link:    https://lore.kernel.org/r/20240809150327.2485848-1-alex=
ander.deucher%40amd.com
>>>> patch subject: [PATCH] video/aperture: match the pci device when calli=
ng sysfb_disable()
>>>> config: csky-randconfig-001-20240810 (https://download.01.org/0day-ci/=
archive/20240810/202408101951.tXyqYOzv-lkp@intel.com/config)
>>>> compiler: csky-linux-gcc (GCC) 14.1.0
>>>> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/ar=
chive/20240810/202408101951.tXyqYOzv-lkp@intel.com/reproduce)
>>>>
>>>> If you fix the issue in a separate patch/commit (i.e. not just a new v=
ersion of
>>>> the same patch/commit), kindly add following tags
>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202408101951.tXyqYOzv-=
lkp@intel.com/
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>      csky-linux-ld: drivers/video/aperture.o: in function `aperture_re=
move_conflicting_pci_devices':
>>>>>> aperture.c:(.text+0x222): undefined reference to `screen_info_pci_de=
v'
>>> Strange. There's a already placeholder [1] for architectures without
>>> PCI. Otherwise the source file is listed at [2].
>> So I dug into this, and the problem seems to be that
>> CONFIG_SCREEN_INFO is not defined in that config.  I can't figure out
>> how this should work in that case or why this is not a problem in
>> drivers/firmware/sysfb.c.
>>
>> Something like this works:
>> diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
>> index 56a5a0bc2b1af..50e98210c9fe5 100644
>> --- a/drivers/video/aperture.c
>> +++ b/drivers/video/aperture.c
>> @@ -347,7 +347,9 @@ EXPORT_SYMBOL(__aperture_remove_legacy_vga_devices);
>>    */
>>   int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev,
>> const char *name)
>>   {
>> +#if defined(CONFIG_SCREEN_INFO)
>>          struct screen_info *si =3D &screen_info;
>> +#endif
>>          bool primary =3D false;
>>          resource_size_t base, size;
>>          int bar, ret =3D 0;
>> @@ -355,8 +357,10 @@ int
>> aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const
>> char *na
>>          if (pdev =3D=3D vga_default_device())
>>                  primary =3D true;
>>
>> +#if defined(CONFIG_SCREEN_INFO)
>>          if (pdev =3D=3D screen_info_pci_dev(si))
>>                  sysfb_disable();
>> +#endif
>>
>>          for (bar =3D 0; bar < PCI_STD_NUM_BARS; ++bar) {
>>                  if (!(pci_resource_flags(pdev, bar) & IORESOURCE_MEM))
>>
>> But that can't be the right fix...  Any ideas?
>
> Thanks for investigating. I'd say we should pass the device (pdev->dev)=20
> to sysfb_disable() and=C2=A0 do the test there. In sysfb.c, next to=20
> sysfb_disable(), you'll find sysfb_parent_dev(), which gives the Linux=20
> device of the screen_info.
>
> The code then looks something like this:
>
> sysfb_disable(struct device *dev)
> {
>  =C2=A0=C2=A0=C2=A0 if (dev && dev =3D=3D sysfb_parent_dev(screen_info))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return
>
>  =C2=A0 /* else do the current code */
> }
>
> there's an invocation of sysfb_disable() in drivers/of/platform.c where=20
> you can pass NULL.
>

Agreed. That sounds like the best approach.

> Best regards
> Thomas
>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


