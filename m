Return-Path: <stable+bounces-70312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4592960471
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 10:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54A181F239E4
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 08:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4A9197A7C;
	Tue, 27 Aug 2024 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFq5B3/3"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE5514B07E
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747569; cv=none; b=J9u7cIMGZaAV3VK3XKwjw/tdgXdgMbOdxtBy3w/urXP55JPHZvRc5Ls+TrTE79EqumA2/IsEZSMjj7Xgs2VEb94jEBNrbuRpmaX8EDSanKj+7IWUbUpVNCK9ObT/BnwvKps3rgzUUtqY61z4mQAYvxFLUkjqkHD+2eRZrBGGMuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747569; c=relaxed/simple;
	bh=w3e2l/LkFkI1FKRdLYSz+PC3KjWBIaRK2n5Zp2WvPWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k0I+SFRUDMK5K1FyHWVvwbiKfph+5NwjJ3N69PqCAsuF2UTRN7uV5knuKvkV95qGjKSr9wUeYlRCNaezoRgEac+WAdrQx2CvwmdCxh8oThkb9GR8rVoXnV8esshJ79T/f1uXLmv4+DYBPbhWGF7BUW8hGlzF6WF0Gt85gU9Qkjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eFq5B3/3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724747565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y6KVgv1IL2HPmMPmJO9/W7wft0+lwNpol6UUqmyiHZI=;
	b=eFq5B3/3w601jsidDiFcAvN+RxeCy4d2didJpenWVhpsAuqLbxiJGLYagThWkaZqc1dj8R
	KIVnizxjRcO9lOmkBAiAKZMTkKag/ug6UGCwiYewy4ZeDFYa4xmvvJWYJ2M1DyeUqfHtWg
	Ys0pl1+KN515yem8WDozf5CfAN058Mo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-pV1oQzdTMCiUVZwMBXNQNw-1; Tue, 27 Aug 2024 04:32:44 -0400
X-MC-Unique: pV1oQzdTMCiUVZwMBXNQNw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5334c7d759dso4553304e87.3
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 01:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724747563; x=1725352363;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6KVgv1IL2HPmMPmJO9/W7wft0+lwNpol6UUqmyiHZI=;
        b=W0DwFXNExDnU4X9rPfffEN7VG0kGxaSgKBzQHS5yuMB+Bamk2d0tiKH+3VFdee2frk
         cpSMMd96DsAV2HLOtUaBpOiZuE3/rf7hHbfBUEdhX5QQ6StoIjEDRrNakwuaV9SvdYDD
         uuNZhnC/FQRRyDAqPJDPpvgguAC+JtkPT/nPN5RV+RyaAyfvWOcMvTtH8hYXtWTEC46s
         gqbqPF1Hp2SF+aO56W9W/fqMWG0VMS7KUlET3n2hEOLbXFDpjgvNTZzSdU1mixK6trzL
         GETSA5r3KT98teu/Sy6K+4zJ3s0u9CoCTWvwZ5X/sMrJ6igw63XD/mHhq29AKwml6Wo+
         BeQg==
X-Gm-Message-State: AOJu0Yy+UByTNXUZoOZSLi+mE0W7nPiLYWT2HuloXqMJZU28QRIEx/zL
	LcPvmjEDQuMOjzYGPuR1qnZpAyLjaJZMs6WYmbkCjG0phVG1SOkGInQt+m5D+5rKiNN+TuAh+D9
	1pMqDNjtDbcLGe8uuM6OjXQcTQmu+iZTPhVccglvVDFRAfVGmqVJxlg==
X-Received: by 2002:a05:6512:1395:b0:52f:cbce:b9b7 with SMTP id 2adb3069b0e04-5343870c302mr8057095e87.0.1724747562930;
        Tue, 27 Aug 2024 01:32:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKg67blLe1ufYFNA3yQVBWOA7L339P3C4Z2XLP23b4E0lZT1vUhPQUB9g2nPFuV3RXc6LU8Q==
X-Received: by 2002:a05:6512:1395:b0:52f:cbce:b9b7 with SMTP id 2adb3069b0e04-5343870c302mr8057068e87.0.1724747562285;
        Tue, 27 Aug 2024 01:32:42 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e582de25sm79641566b.122.2024.08.27.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:32:41 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: stable@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] x86/hyperv: fix kexec crash due to VP assist page
 corruption
In-Reply-To: <11001.124082704082000271@us-mta-164.us.mimecast.lan>
References: <20240826105029.3173782-1-anirudh@anirudhrb.com>
 <87zfozxxyb.fsf@redhat.com>
 <11001.124082704082000271@us-mta-164.us.mimecast.lan>
Date: Tue, 27 Aug 2024 10:32:41 +0200
Message-ID: <87wmk2xt5i.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anirudh Rayabharam <anirudh@anirudhrb.com> writes:

> On Mon, Aug 26, 2024 at 02:36:44PM +0200, Vitaly Kuznetsov wrote:
>> Anirudh Rayabharam <anirudh@anirudhrb.com> writes:
>> 
>> > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>> >
>> > 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go
>> > online/offline") introduces a new cpuhp state for hyperv initialization.
>> >
>> > cpuhp_setup_state() returns the state number if state is CPUHP_AP_ONLINE_DYN
>> > or CPUHP_BP_PREPARE_DYN and 0 for all other states. For the hyperv case,
>> > since a new cpuhp state was introduced it would return 0. However,
>> > in hv_machine_shutdown(), the cpuhp_remove_state() call is conditioned upon
>> > "hyperv_init_cpuhp > 0". This will never be true and so hv_cpu_die() won't be
>> > called on all CPUs. This means the VP assist page won't be reset. When the
>> > kexec kernel tries to setup the VP assist page again, the hypervisor corrupts
>> > the memory region of the old VP assist page causing a panic in case the kexec
>> > kernel is using that memory elsewhere. This was originally fixed in dfe94d4086e4
>> > ("x86/hyperv: Fix kexec panic/hang issues").
>> >
>> > Set hyperv_init_cpuhp to CPUHP_AP_HYPERV_ONLINE upon successful setup so that
>> > the hyperv cpuhp state is removed correctly on kexec and the necessary cleanup
>> > takes place.
>> >
>> > Cc: stable@vger.kernel.org
>> > Fixes: 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline")
>> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>> > ---
>> >  arch/x86/hyperv/hv_init.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> > index 17a71e92a343..81d1981a75d1 100644
>> > --- a/arch/x86/hyperv/hv_init.c
>> > +++ b/arch/x86/hyperv/hv_init.c
>> > @@ -607,7 +607,7 @@ void __init hyperv_init(void)
>> >  
>> >  	register_syscore_ops(&hv_syscore_ops);
>> >  
>> > -	hyperv_init_cpuhp = cpuhp;
>> > +	hyperv_init_cpuhp = CPUHP_AP_HYPERV_ONLINE;
>> 
>> Do we really need 'hyperv_init_cpuhp' at all? I.e. post-change (which
>> LGTM btw), I can only see one usage in hv_machine_shutdown():
>> 
>>    if (kexec_in_progress && hyperv_init_cpuhp > 0)
>>            cpuhp_remove_state(hyperv_init_cpuhp);
>> 
>> and I'm wondering if the 'hyperv_init_cpuhp' check is really
>> needed. This only case where this check would fail is if we're crashing
>> in between ms_hyperv_init_platform() and hyperv_init() afaiu. Does it
>
> Or if we fail to setup the cpuhp state for some reason but don't
> actually crash and then later do a kexec?

I see this can happen for CPUHP_AP_ONLINE_DYN/CPUHP_BP_PREPARE_DYN
because we run out of free slots (40/20), but here we have our own
dedicated CPUHP_AP_HYPERV_ONLINE and other failure paths seem to be
exotic...

>
> I guess I was just trying to be extra safe and make sure we have
> actually setup the cpuhp state before calling cpuhp_remove_state()
> for it. However, looking elsewhere in the kernel code I don't
> see anybody doing this for custom states...
>
>> hurt if we try cpuhp_remove_state() anyway?
>
> cpuhp_invoke_callback() would trigger a WARNING if we try to remove a
> cpuhp state that was never setup.
>
> 184         if (cpuhp_step_empty(bringup, step)) {
> 185                 WARN_ON_ONCE(1);
> 186                 return 0;
> 187         }
>

Personally, I'd say that getting an extra WARN for such a corner case
(failing to setup cpuhp state or crashing in between
ms_hyperv_init_platform() and hyperv_init()) is OK. 

Alternatively, we can convert hyperv_init_cpuhp to a boolean to make it
a bit more staitforward but as it's uncomon to do it for other states,
it's likely an overkill.

-- 
Vitaly


