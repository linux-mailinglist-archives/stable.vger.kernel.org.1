Return-Path: <stable+bounces-76553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4C097AC34
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 09:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC2A1C23B44
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 07:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B71C1531C2;
	Tue, 17 Sep 2024 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hbYwzUjj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135D10F4
	for <stable@vger.kernel.org>; Tue, 17 Sep 2024 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558366; cv=none; b=MBUlqjf7wxGXMMQsm3VyGLYOzGvosRXwrqDLvV6lzoFc61+rqRBDscl9IgUBF9QsSRJlVNQL4AgIWC6pj7IMzGIyahvpKo0JG4Vpd4mTKKTJ1nOtt5b7Ee+k727arZ4HDmH+6CpP4Cu5XSrkDzchjZihWGDakLFEv7LXj3b/15w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558366; c=relaxed/simple;
	bh=1giazlVL4veqhLIwMAeReV/7gEu/+fQLmWnxBMQTLKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqT6b5PFuN9Krz2vvocn3EFpTxOZ3BsSpUG/Sn3WQc/td1AWhPr8SoU0lnanE4LXMcGLmfbrM8WEf8++WGjKn3pX0Y6DeeOZpSFDGXlo4cdjnyYF6CFjNvRtZZD7UpdwlZLrmCYJMLvaAoUwAZHWImTBkpFJY5/kUbNsfkkl3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hbYwzUjj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726558363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AlZOc2K+ISHHEauB0/GOs0ndNpHKjcVI8t+alRznKmc=;
	b=hbYwzUjjWEPBVfAEQmwtcsd+nyuaVdX3bFhVT/4gEHBB2/kBX1aE+76/0yOSlC5H2q/pLQ
	jyHGdiMfK3WpTzZw/de903lIDQT7OyL5hkE0QtlwQyseXmZIH1uAnERTPmhNkPJ4SRFuHL
	cuYLfCEhxYA1l4pXlZXl+6ZkDOMYG6Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-ZTzfZglKO527QyKNL-Q8wg-1; Tue, 17 Sep 2024 03:32:41 -0400
X-MC-Unique: ZTzfZglKO527QyKNL-Q8wg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374b9a8512dso3017475f8f.2
        for <stable@vger.kernel.org>; Tue, 17 Sep 2024 00:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726558360; x=1727163160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlZOc2K+ISHHEauB0/GOs0ndNpHKjcVI8t+alRznKmc=;
        b=NNElHCes4EloTXeU49ZeAduMlLry8IROouZw9C718gBNwR7FxRekj9nlAr6dG1F0WD
         /W10aqOMs0hgKzskcyhu6dedLM58ZoMkpkcQOQeoOX/RrOXlKVQGprzD1cGR4JRuzwip
         wbiS8Ngbb5J6rstzUUcyO+uIPuF3lnyC6wnJWGiCN/s8KVrbMFNEg+zarR6DtwIb60Gk
         j2SA69mwNuWF93NfHueB2rwjjFioHX8E/00OUT7EtezFsa3sqjs8CUMebBUd3SSZPDX7
         H5VgjFDpVOAMDTByX0DByUL48tcU/On1oJcf0eNXEI7ylv/7/+YtgaHpgTm2/s7D+kH0
         afrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7wdPb6aPlh2VzchESRKaYHU+Y0Nm1kFPKFYcCVVOOk0q+/EWz7KIJavseOoBDEKEoCxSKZJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xffvQrJ8FBttXVDWj+qH/XJW6FK/DT/shE45p47ZWAykm/wd
	3SjXK+PCucJ+SPCco+7ZodUJYAwYS+KdLLOleXSmBElmNbMzzSLs8WyCva1ripLTEq33V5VMKE2
	YP7J6gvEmFlypq9Gzhg3Twlp66J4SEa2+PX4wut9Is/TWbRWK3BhJQQ==
X-Received: by 2002:a5d:6743:0:b0:371:6fba:d555 with SMTP id ffacd0b85a97d-378c2cf40bamr9450360f8f.18.1726558360454;
        Tue, 17 Sep 2024 00:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaAbMrGgGXriWb7e3gKHYim9vObh3Aaz+SmelHnYDdYV4b+eQYgEyl+BBZEUFQQOR1QjfGbw==
X-Received: by 2002:a5d:6743:0:b0:371:6fba:d555 with SMTP id ffacd0b85a97d-378c2cf40bamr9450335f8f.18.1726558359840;
        Tue, 17 Sep 2024 00:32:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f996dsm8777118f8f.65.2024.09.17.00.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 00:32:39 -0700 (PDT)
Message-ID: <4427beee-f428-4c45-830d-d0cc58293bce@redhat.com>
Date: Tue, 17 Sep 2024 09:32:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panic: Fix uninitialized spinlock acquisition with
 CONFIG_DRM_PANIC=n
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20240916230103.611490-1-lyude@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240916230103.611490-1-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/09/2024 01:00, Lyude Paul wrote:
> It turns out that if you happen to have a kernel config where
> CONFIG_DRM_PANIC is disabled and spinlock debugging is enabled, along with
> KMS being enabled - we'll end up trying to acquire an uninitialized
> spin_lock with drm_panic_lock() when we try to do a commit:

The raw spinlock should be initialized in drm_dev_init() [1] regardless 
of DRM_PANIC being enabled or not.

 From the call trace, it looks like you are calling 
drm_client_register() before calling drm_dev_register(), and that's 
probably the root cause.

I didn't find a doc saying drm_dev_register() should be done before 
drm_client_register(), but all drivers are doing it this way.

Can you try to do that in rvkms, and see if it fixes this error ?

Best regards,

-- 

Jocelyn

[1] 
https://elixir.bootlin.com/linux/v6.11/source/drivers/gpu/drm/drm_drv.c#L642

> 
>    rvkms rvkms.0: [drm:drm_atomic_commit] committing 0000000068d2ade1
>    INFO: trying to register non-static key.
>    The code is fine but needs lockdep annotation, or maybe
>    you didn't initialize this object before use?
>    turning off the locking correctness validator.
>    CPU: 4 PID: 1347 Comm: modprobe Not tainted 6.10.0-rc1Lyude-Test+ #272
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240524-3.fc40 05/24/2024
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x77/0xa0
>     assign_lock_key+0x114/0x120
>     register_lock_class+0xa8/0x2c0
>     __lock_acquire+0x7d/0x2bd0
>     ? __vmap_pages_range_noflush+0x3a8/0x550
>     ? drm_atomic_helper_swap_state+0x2ad/0x3a0
>     lock_acquire+0xec/0x290
>     ? drm_atomic_helper_swap_state+0x2ad/0x3a0
>     ? lock_release+0xee/0x310
>     _raw_spin_lock_irqsave+0x4e/0x70
>     ? drm_atomic_helper_swap_state+0x2ad/0x3a0
>     drm_atomic_helper_swap_state+0x2ad/0x3a0
>     drm_atomic_helper_commit+0xb1/0x270
>     drm_atomic_commit+0xaf/0xe0
>     ? __pfx___drm_printfn_info+0x10/0x10
>     drm_client_modeset_commit_atomic+0x1a1/0x250
>     drm_client_modeset_commit_locked+0x4b/0x180
>     drm_client_modeset_commit+0x27/0x50
>     __drm_fb_helper_restore_fbdev_mode_unlocked+0x76/0x90
>     drm_fb_helper_set_par+0x38/0x40
>     fbcon_init+0x3c4/0x690
>     visual_init+0xc0/0x120
>     do_bind_con_driver+0x409/0x4c0
>     do_take_over_console+0x233/0x280
>     do_fb_registered+0x11f/0x210
>     fbcon_fb_registered+0x2c/0x60
>     register_framebuffer+0x248/0x2a0
>     __drm_fb_helper_initial_config_and_unlock+0x58a/0x720
>     drm_fbdev_generic_client_hotplug+0x6e/0xb0
>     drm_client_register+0x76/0xc0
>     _RNvXs_CsHeezP08sTT_5rvkmsNtB4_5RvkmsNtNtCs1cdwasc6FUb_6kernel8platform6Driver5probe+0xed2/0x1060 [rvkms]
>     ? _RNvMs_NtCs1cdwasc6FUb_6kernel8platformINtB4_7AdapterNtCsHeezP08sTT_5rvkms5RvkmsE14probe_callbackBQ_+0x2b/0x70 [rvkms]
>     ? acpi_dev_pm_attach+0x25/0x110
>     ? platform_probe+0x6a/0xa0
>     ? really_probe+0x10b/0x400
>     ? __driver_probe_device+0x7c/0x140
>     ? driver_probe_device+0x22/0x1b0
>     ? __device_attach_driver+0x13a/0x1c0
>     ? __pfx___device_attach_driver+0x10/0x10
>     ? bus_for_each_drv+0x114/0x170
>     ? __device_attach+0xd6/0x1b0
>     ? bus_probe_device+0x9e/0x120
>     ? device_add+0x288/0x4b0
>     ? platform_device_add+0x75/0x230
>     ? platform_device_register_full+0x141/0x180
>     ? rust_helper_platform_device_register_simple+0x85/0xb0
>     ? _RNvMs2_NtCs1cdwasc6FUb_6kernel8platformNtB5_6Device13create_simple+0x1d/0x60
>     ? _RNvXs0_CsHeezP08sTT_5rvkmsNtB5_5RvkmsNtCs1cdwasc6FUb_6kernel6Module4init+0x11e/0x160 [rvkms]
>     ? 0xffffffffc083f000
>     ? init_module+0x20/0x1000 [rvkms]
>     ? kernfs_xattr_get+0x3e/0x80
>     ? do_one_initcall+0x148/0x3f0
>     ? __lock_acquire+0x5ef/0x2bd0
>     ? __lock_acquire+0x5ef/0x2bd0
>     ? __lock_acquire+0x5ef/0x2bd0
>     ? put_cpu_partial+0x51/0x1d0
>     ? lock_acquire+0xec/0x290
>     ? put_cpu_partial+0x51/0x1d0
>     ? lock_release+0xee/0x310
>     ? put_cpu_partial+0x51/0x1d0
>     ? fs_reclaim_acquire+0x69/0xf0
>     ? lock_acquire+0xec/0x290
>     ? fs_reclaim_acquire+0x69/0xf0
>     ? kfree+0x22f/0x340
>     ? lock_release+0xee/0x310
>     ? kmalloc_trace_noprof+0x48/0x340
>     ? do_init_module+0x22/0x240
>     ? kmalloc_trace_noprof+0x155/0x340
>     ? do_init_module+0x60/0x240
>     ? __se_sys_finit_module+0x2e0/0x3f0
>     ? do_syscall_64+0xa4/0x180
>     ? syscall_exit_to_user_mode+0x108/0x140
>     ? do_syscall_64+0xb0/0x180
>     ? vma_end_read+0xd0/0xe0
>     ? do_user_addr_fault+0x309/0x640
>     ? clear_bhb_loop+0x45/0xa0
>     ? clear_bhb_loop+0x45/0xa0
>     ? clear_bhb_loop+0x45/0xa0
>     ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     </TASK>
> 
> Fix this by stubbing these macros out when this config option isn't
> enabled, along with fixing the unused variable warning that introduces.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Fixes: e2a1cda3e0c7 ("drm/panic: Add drm panic locking")
> Cc: <stable@vger.kernel.org> # v6.10+
> 
> ---
> 
> V2:
> * Use static inline instead of macros so we don't need
>    __maybe_unused
> 
> ---
>   drivers/gpu/drm/drm_atomic_helper.c |  2 +-
>   include/drm/drm_panic.h             | 14 ++++++++++++++
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 43cdf39019a44..5186d2114a503 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3015,7 +3015,7 @@ int drm_atomic_helper_swap_state(struct drm_atomic_state *state,
>   				  bool stall)
>   {
>   	int i, ret;
> -	unsigned long flags;
> +	unsigned long flags = 0;
>   	struct drm_connector *connector;
>   	struct drm_connector_state *old_conn_state, *new_conn_state;
>   	struct drm_crtc *crtc;
> diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
> index 54085d5d05c34..f4e1fa9ae607a 100644
> --- a/include/drm/drm_panic.h
> +++ b/include/drm/drm_panic.h
> @@ -64,6 +64,8 @@ struct drm_scanout_buffer {
>   
>   };
>   
> +#ifdef CONFIG_DRM_PANIC
> +
>   /**
>    * drm_panic_trylock - try to enter the panic printing critical section
>    * @dev: struct drm_device
> @@ -149,4 +151,16 @@ struct drm_scanout_buffer {
>   #define drm_panic_unlock(dev, flags) \
>   	raw_spin_unlock_irqrestore(&(dev)->mode_config.panic_lock, flags)
>   
> +#else
> +
> +static inline bool drm_panic_trylock(struct drm_device *dev, unsigned long flags)
> +{
> +	return true;
> +}
> +
> +static inline void drm_panic_lock(struct drm_device *dev, unsigned long flags) {}
> +static inline void drm_panic_unlock(struct drm_device *dev, unsigned long flags) {}
> +
> +#endif
> +
>   #endif /* __DRM_PANIC_H__ */
> 
> base-commit: bf05aeac230e390a5aee4bd3dc978b0c4d7e745f


