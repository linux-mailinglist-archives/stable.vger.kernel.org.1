Return-Path: <stable+bounces-159257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01265AF5EF1
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 18:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D674A4D0F
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 16:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345B272600;
	Wed,  2 Jul 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="q8SC4hf1"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F52F50B4
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474752; cv=none; b=tthus7T+kqQeeVuC/FsmgyG0biB+fMT11x3rx2qUPgIgUtz8V5ee/dWnp2taDn+ROlPvl2FZEwmwnfjGzHfUhzCQQLk/PUOOBDEuObIqAri/UTgXmCdWul0ttK2l7EGIHocFD+yS9LvagjN5YCni9yfwv9RmFmCncE7nNKaXrKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474752; c=relaxed/simple;
	bh=1kRYbnn+64e5fvrcUEY44l2pLTvO+W+1euniJXqJ388=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfUKY6ZCXXeBITSjZz5U1uGB37mW+PM+Lv7MMfPuSdQyBd8gCrQR3LoH4q4AuPsMqAxVsYvUQgALvj6HlG8U/F64OfIYdWgYgzCu6UhO8sTTpNRwHQZVbHw1SvOZgWyThJqA54RmxClcBaNJ+0COUnZNvcgusWgIdVM6MOqYaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=q8SC4hf1; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E7D0D3F5D1
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751474740;
	bh=03JYsi6N1cb3oGmDBZSCpQc2VmKr0D5Wn0ycaeTgsEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=q8SC4hf1XOMRDiXHEJZr57gAtwsmp1EqowmRcTp76fJF36twgg/8qsAUCffkSCcxj
	 HR8GI9rJJrR4rjmY7fE3wk46U8KOgqA/SdEjDW9j0COvsLvqjFo+rEJay++2Qvub6M
	 en72ulIlRc8LeIFO6qrX+GaZbXMBbm+UWrIeElBJORDGaJhF6wmeL6frG6YWg3s3ea
	 4D68CcytOZL5TdSjUuFRSYeSDT4LCwTnWbk6/YkbMrim73kb4d+/Khh2MjBkgF3Sa3
	 gsKAYOjn+AePBtV4iGhq5KW4IR+sx0Rd2HqOBo/vj5HdliCo1Y+Nm8NUTzTKf+W8Bp
	 Ds8IFxszEXM9A==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso5368641a91.1
        for <stable@vger.kernel.org>; Wed, 02 Jul 2025 09:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751474739; x=1752079539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03JYsi6N1cb3oGmDBZSCpQc2VmKr0D5Wn0ycaeTgsEE=;
        b=LsrfaGU9gfkDo/YVH4NroFf/D4uNtp/Jhrotn9O/zYdTRPw99WbqxOvmJ8qkPtoqy1
         iIRIE8q8pmMAPUr0QhEyS1FpG3palfdP5iQH8i5Ri1pbfg3QFT7gHzCMN9udRADlrr59
         C0luav+ebCzWAq1ynzrUaF0TyqgFFHPFqfgRKIJpUPeOYkzpvDMGzVUpWph844dYnmkP
         szG1NhZORsT8CeTe7zvCkfC3pKSxc0EVEKVmPH108n0dgk4wM4asq3q+e5gymV4juP55
         c64JYxghrUaBYpf8sAeuZ26tcVgOK1Q0d41OIHTwZ4OTrhRcXPgUrv7BHV9lforoEJyz
         v5lw==
X-Forwarded-Encrypted: i=1; AJvYcCXnr07uaUcfB68wB6lemmzZ5JYbw4G+Xjon2eo2zN2lqcnNPF6JOlVxmO7SQvsnPrfIGVItbto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDS/OgcSewyBZiP/rmFuajCVtctbKDskjemAT3uRcNU9EKkmVa
	WBcxjFZgrqWfXQyIeML9bBRQHq5qv2S8Ou0BTHok8eGwtp4dDcfghqtZjgbK8aOrvWccawFYVgN
	tfNAkepgFYn3pq9YRFwcSenV3FN3LWLR/Me2cYqyMpcf5YLiKOkpw1HRa4vcCZ3drJFBDvkRmbD
	bOc0Pj/PwJ0CX7ucFs0i27CEBQWtO0NicOGddP5eIJpy493SXX
X-Gm-Gg: ASbGncuhE506oP6Bre98sGsgZZjx9ZYkpVKIWA9Ss9am3y5mKuA9qcysnenVuncMn0m
	X/Xp21PUycLMB3riyaNVmNtD7Py8ibYiuJ/t5sVf6zuv/ShVjY1RYThY8AKEGCUbVj+uLhgQ9Gi
	M=
X-Received: by 2002:a17:90b:1ccf:b0:312:25dd:1c99 with SMTP id 98e67ed59e1d1-31a9d68c415mr24965a91.19.1751474739294;
        Wed, 02 Jul 2025 09:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUbiVnsCDOhE0Y6KvzUyFT+4UeGUQjHsPXTvcCNTFf9JU+yQRYphgb7sEjWquSS5yd2ifrnsCNngJaGe5SJcw=
X-Received: by 2002:a17:90b:1ccf:b0:312:25dd:1c99 with SMTP id
 98e67ed59e1d1-31a9d68c415mr24919a91.19.1751474738923; Wed, 02 Jul 2025
 09:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701171154.52435-1-ioanna-maria.alifieraki@canonical.com>
 <7d2214f3-3b54-4b74-a18b-aca1fdf4fdb4@linux.intel.com> <96d68cb2-9240-4179-bca0-8ad2d70ab281@linux.intel.com>
In-Reply-To: <96d68cb2-9240-4179-bca0-8ad2d70ab281@linux.intel.com>
From: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Date: Wed, 2 Jul 2025 19:45:12 +0300
X-Gm-Features: Ac12FXwfZGasDwsrUNpiRYFf5EsK6aBBSON-b9jeB0VIdRAW47jpQEz-5jaf9R4
Message-ID: <CAOLeGd3a63_za6cYs3HyzFn1A=j7gaEcWurT9yuXknMspa80fA@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Performance Regression in IOMMU/VT-d Since
 Kernel 6.10
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, jroedel@suse.de, robin.murphy@arm.com, 
	will@kernel.org, joro@8bytes.org, dwmw2@infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 12:00=E2=80=AFPM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
>
> On 7/2/2025 1:14 PM, Baolu Lu wrote:
> > On 7/2/25 01:11, Ioanna Alifieraki wrote:
> >> #regzbot introduced: 129dab6e1286
> >>
> >> Hello everyone,
> >>
> >> We've identified a performance regression that starts with linux
> >> kernel 6.10 and persists through 6.16(tested at commit e540341508ce).
> >> Bisection pointed to commit:
> >> 129dab6e1286 ("iommu/vt-d: Use cache_tag_flush_range_np() in
> >> iotlb_sync_map").
> >>
> >> The issue occurs when running fio against two NVMe devices located
> >> under the same PCIe bridge (dual-port NVMe configuration). Performance
> >> drops compared to configurations where the devices are on different
> >> bridges.
> >>
> >> Observed Performance:
> >> - Before the commit: ~6150 MiB/s, regardless of NVMe device placement.
> >> - After the commit:
> >>    -- Same PCIe bridge: ~4985 MiB/s
> >>    -- Different PCIe bridges: ~6150 MiB/s
> >>
> >>
> >> Currently we can only reproduce the issue on a Z3 metal instance on
> >> gcp. I suspect the issue can be reproducible if you have a dual port
> >> nvme on any machine.
> >> At [1] there's a more detailed description of the issue and details
> >> on the reproducer.
> >
> > This test was running on bare metal hardware instead of any
> > virtualization guest, right? If that's the case,
> > cache_tag_flush_range_np() is almost a no-op.
> >
> > Can you please show me the capability register of the IOMMU by:
> >
> > #cat /sys/bus/pci/devices/[pci_dev_name]/iommu/intel-iommu/cap
>
> Also, can you please try whether the below changes make any difference?
> I've also attached a patch file to this email so you can apply the
> change more easily.
Thanks for the patch Baolu, I've tested and I can confirm we get ~6150MiB/s
for nvme pairs both under the same and different bridge.
The output of
cat /sys/bus/pci/devices/[pci_dev_name]/iommu/intel-iommu/cap
19ed008c40780c66
for all nvmes.
I got confirmation there's no virtualization happening on this instance
at all.
FWIW, I had run perf when initially investigating the issue and it was
showing quite some time spent in cache_tag_flush_range_np().

Thanks again!
Jo
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 7aa3932251b2..f60201ee4be0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1796,6 +1796,18 @@ static int domain_setup_first_level(struct
> intel_iommu *iommu,
>                                           (pgd_t *)pgd, flags, old);
>   }
>
> +static bool domain_need_iotlb_sync_map(struct dmar_domain *domain,
> +                                      struct intel_iommu *iommu)
> +{
> +       if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
> +               return true;
> +
> +       if (rwbf_quirk || cap_rwbf(iommu->cap))
> +               return true;
> +
> +       return false;
> +}
> +
>   static int dmar_domain_attach_device(struct dmar_domain *domain,
>                                      struct device *dev)
>   {
> @@ -1833,6 +1845,8 @@ static int dmar_domain_attach_device(struct
> dmar_domain *domain,
>         if (ret)
>                 goto out_block_translation;
>
> +       domain->iotlb_sync_map |=3D domain_need_iotlb_sync_map(domain, io=
mmu);
> +
>         return 0;
>
>   out_block_translation:
> @@ -3945,7 +3959,10 @@ static bool risky_device(struct pci_dev *pdev)
>   static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
>                                       unsigned long iova, size_t size)
>   {
> -       cache_tag_flush_range_np(to_dmar_domain(domain), iova, iova + siz=
e - 1);
> +       struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
> +
> +       if (dmar_domain->iotlb_sync_map)
> +               cache_tag_flush_range_np(dmar_domain, iova, iova + size -=
 1);
>
>         return 0;
>   }
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 3ddbcc603de2..7ab2c34a5ecc 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -614,6 +614,9 @@ struct dmar_domain {
>         u8 has_mappings:1;              /* Has mappings configured throug=
h
>                                          * iommu_map() interface.
>                                          */
> +       u8 iotlb_sync_map:1;            /* Need to flush IOTLB cache or w=
rite
> +                                        * buffer when creating mappings.
> +                                        */
>
>         spinlock_t lock;                /* Protect device tracking lists =
*/
>         struct list_head devices;       /* all devices' list */
> --
> 2.43.0
>
> Thanks,
> baolu

