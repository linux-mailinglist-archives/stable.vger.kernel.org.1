Return-Path: <stable+bounces-71409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A2E9626E4
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 14:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE271F23C85
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 12:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D623175D2F;
	Wed, 28 Aug 2024 12:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6uW+EgX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4716BE11
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847829; cv=none; b=hDWRpdjibClwDILfIHd0RhVOzAhmlufMmJYIuGNdiREUiw8+xOsa8W+Ou+rkfTjYdPkamoioyEAEGDlFmRIFZc64hEPuYOaveH2gn/LwpOlOCbuNxLCQWQ3EEB+2qT3smFdAnMMiUs4QLX2BGoD5sJsSerixQl8jrNL01jgIp7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847829; c=relaxed/simple;
	bh=5pNoFkKDtgrMW6h2yL3PA3PIYgDnnl6mXCnZICusJbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uKS9PBNaID11hQu6amebk7PrOtWO5kOW8gPsqWBt5raJSqGutSo5w+xZ1jCvk/2zk1jRpiXqQD7KKYCk3+PUomZXy8S5yv2bCKpU6/whwbpLqFVHrM0a/sYzZ2JO3CV1TjOGQN0uwQ5AdSYKWcGepFE2poY31Cx9qjKpuEUBANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6uW+EgX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724847827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=79VnjjDwdlP3Jdk4mfldqnbgXYpOctR7Yz2Tdi8z5AE=;
	b=d6uW+EgXWtKKsp7KD4Qz2+EcRgkiA8NA3TDhSovqoDZq4z+hsJqJ9KGnDBM3rYZ0eSwJ9S
	KJr+rfiKIkdyfizB+wTRkHILvraILyOFsmHjOwTrI0bhi75AwXlUxDAajdO4/kK8EDTTSh
	eCGvlUS8Kz5TtrhFzatS2bzMLZfEz1E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-fpxckKOVOA-1IJF7TxeI_g-1; Wed, 28 Aug 2024 08:23:42 -0400
X-MC-Unique: fpxckKOVOA-1IJF7TxeI_g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3718d9d9267so3876219f8f.0
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 05:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724847822; x=1725452622;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79VnjjDwdlP3Jdk4mfldqnbgXYpOctR7Yz2Tdi8z5AE=;
        b=AA7qEOIsJjAXpxaNleqyPtVzaClUyVhT6YcHu2/72eUvCScPgr75al1M6flHk7aEV7
         UxxgHSVR6O6yz4NPpH0xW7hDTk8fH/JH0z8JJOPdQsawBaxMytRlIK03lVhPnbtRqFt5
         AbnxV0noEwAM7HAzY6AziXF+bm7Yun3LVPF5hj7MKuzibB+Tlu7jgc/eftZWGymXpn/I
         Xv8O8zQDzmpf8hJCn8jlpSPuQyvuiI04tx4++ewCRgrFtYWdapLRWCzlup9hEK9ekWqQ
         QphuJKWLmCpHseLDmx0IrJRAaAuHuXMl0lHfyIYlvO8Lgphx1xXogYwxndPCYugSXkNR
         WL5g==
X-Forwarded-Encrypted: i=1; AJvYcCX4URBv9V6IyL761bkEAuZMpCJKST4EBO2nuzMsNWhH839qbwg8fhAlVcT/BLrM8i4G4yLFtnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5QPatpzboSg7BIJkZnmoVmNDVkditi9o8+2ZCBdcckoXNfDY
	WMPW9fH9ury9jDqgcFJcSKYsc4aR29LxefhDXVX7Nu6/gh+ee2pobhN8j6wJSJQRbdaodWu1XiK
	rhjpnt1NBm2vm3mkNq0qrfIl6Z9YcnDZGQR+QL9ipxDzAI9+36LR5ew==
X-Received: by 2002:a5d:674f:0:b0:367:980a:6af with SMTP id ffacd0b85a97d-373118e3631mr9554025f8f.59.1724847821628;
        Wed, 28 Aug 2024 05:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQtj/08Ph01mH2iPkwg5wNOM8hnp3rYVg0eugXm0Uqxy9vl1nwQCqK8gISOxxxp2+D9d2VOQ==
X-Received: by 2002:a5d:674f:0:b0:367:980a:6af with SMTP id ffacd0b85a97d-373118e3631mr9554005f8f.59.1724847821069;
        Wed, 28 Aug 2024 05:23:41 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730813cdf2sm15513022f8f.38.2024.08.28.05.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 05:23:40 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Michael Kelley <mikelley@microsoft.com>
Cc: Anirudh Rayabharam <anirudh@anirudhrb.com>, stable@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/hyperv: fix kexec crash due to VP assist page
 corruption
In-Reply-To: <20240828112158.3538342-1-anirudh@anirudhrb.com>
References: <20240828112158.3538342-1-anirudh@anirudhrb.com>
Date: Wed, 28 Aug 2024 14:23:39 +0200
Message-ID: <87le0gygxg.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anirudh Rayabharam <anirudh@anirudhrb.com> writes:

> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>
> commit 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when
> CPUs go online/offline") introduces a new cpuhp state for hyperv
> initialization.
>
> cpuhp_setup_state() returns the state number if state is
> CPUHP_AP_ONLINE_DYN or CPUHP_BP_PREPARE_DYN and 0 for all other states.
> For the hyperv case, since a new cpuhp state was introduced it would
> return 0. However, in hv_machine_shutdown(), the cpuhp_remove_state() call
> is conditioned upon "hyperv_init_cpuhp > 0". This will never be true and
> so hv_cpu_die() won't be called on all CPUs. This means the VP assist page
> won't be reset. When the kexec kernel tries to setup the VP assist page
> again, the hypervisor corrupts the memory region of the old VP assist page
> causing a panic in case the kexec kernel is using that memory elsewhere.
> This was originally fixed in commit dfe94d4086e4 ("x86/hyperv: Fix kexec
> panic/hang issues").
>
> Get rid of hyperv_init_cpuhp entirely since we are no longer using a
> dynamic cpuhp state and use CPUHP_AP_HYPERV_ONLINE directly with
> cpuhp_remove_state().
>
> Cc: stable@vger.kernel.org
> Fixes: 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline")
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>
> v1->v2:
> - Remove hyperv_init_cpuhp entirely and use CPUHP_AP_HYPERV_ONLINE directly
>   with cpuhp_remove_state().

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks!

>
> v1: https://lore.kernel.org/linux-hyperv/87wmk2xt5i.fsf@redhat.com/T/#m54b8ae17e98d65e77a09002e478669d15d9830d0
>
> ---
>  arch/x86/hyperv/hv_init.c       | 5 +----
>  arch/x86/include/asm/mshyperv.h | 1 -
>  arch/x86/kernel/cpu/mshyperv.c  | 4 ++--
>  3 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 17a71e92a343..95eada2994e1 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -35,7 +35,6 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <linux/highmem.h>
>  
> -int hyperv_init_cpuhp;
>  u64 hv_current_partition_id = ~0ull;
>  EXPORT_SYMBOL_GPL(hv_current_partition_id);
>  
> @@ -607,8 +606,6 @@ void __init hyperv_init(void)
>  
>  	register_syscore_ops(&hv_syscore_ops);
>  
> -	hyperv_init_cpuhp = cpuhp;
> -
>  	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
>  		hv_get_partition_id();
>  
> @@ -637,7 +634,7 @@ void __init hyperv_init(void)
>  clean_guest_os_id:
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
>  	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
> -	cpuhp_remove_state(cpuhp);
> +	cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
>  free_ghcb_page:
>  	free_percpu(hv_ghcb_pg);
>  free_vp_assist_page:
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 390c4d13956d..5f0bc6a6d025 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -40,7 +40,6 @@ static inline unsigned char hv_get_nmi_reason(void)
>  }
>  
>  #if IS_ENABLED(CONFIG_HYPERV)
> -extern int hyperv_init_cpuhp;
>  extern bool hyperv_paravisor_present;
>  
>  extern void *hv_hypercall_pg;
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index e0fd57a8ba84..e98db51f25ba 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -199,8 +199,8 @@ static void hv_machine_shutdown(void)
>  	 * Call hv_cpu_die() on all the CPUs, otherwise later the hypervisor
>  	 * corrupts the old VP Assist Pages and can crash the kexec kernel.
>  	 */
> -	if (kexec_in_progress && hyperv_init_cpuhp > 0)
> -		cpuhp_remove_state(hyperv_init_cpuhp);
> +	if (kexec_in_progress)
> +		cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
>  
>  	/* The function calls stop_other_cpus(). */
>  	native_machine_shutdown();

-- 
Vitaly


