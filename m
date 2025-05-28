Return-Path: <stable+bounces-147903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C28DAC5FA0
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 04:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0C1A2312E
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 02:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A841F1501;
	Wed, 28 May 2025 02:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtOvO5v8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD2E1EE032
	for <stable@vger.kernel.org>; Wed, 28 May 2025 02:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399488; cv=none; b=Aluuy6t3VqcDQHmUJVZH+9rdMJkKYBqZtHuWmc5ClO6EVPMGD79ZeddyOlV5Y655N/jIjvxo8zvu/qD0Tdm1zzwgn+k7P8yFu3OlVSAY21WJkynRzU9xj4ehlPaYJvSt8+EU3X2Ldjbx7pu2z33zl9tl2Yd+LL9BypNfSemXTTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399488; c=relaxed/simple;
	bh=/HzPKugMmaCRrhBJ4YFkeZUX/9qBlQMp0yGEzMrprqI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=twAnYQimnraMdS1SeY1kj/R/cUonz0rs2VzAS4D7ld3FszCTc5PAZuhn17WHjkMdyw6/wjwJ2QJ9qG8KoP29ZETl/1bAJBhjrKmbriCEyJBe7bJX9aeuHyJhG0fqhuOnix/NDT68dVC71RPj3G3LC5zkcmkhzPGhum4E7EIvJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TtOvO5v8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2343ea60430so35201065ad.3
        for <stable@vger.kernel.org>; Tue, 27 May 2025 19:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748399483; x=1749004283; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQRgW2zDMDyRpGcNs2f/hIRhslp675QORwh/naIQme4=;
        b=TtOvO5v8XKmaO+o/YTUpcwQPtoqN2dyq2dO9J6x8fsXr8azbIRrfIBP2GiDDrXp9r0
         k/Lhm5ibKeRtHzkboUeRk+el23rSQcBBWWlwrEmvMzsUfGCbRksUpQZUBfVToeyudNnq
         1w5CZoEa+JakijWe/RUOyaKaj0/0jJtkKiSUEXLM3JW7E7rn4zX7X2yJQHDA311CGyxc
         k5Vod8L53TdBYJnHy12roaMiRDoMRpOtGvTGuVBK49mQqS3UMDVJhTcoHcPXUPcSuQaw
         qPmlQSv2o0Z9GywslycIWK/MQlqP4klNwiFmJIi81l/yjWDBn3peZRwgJ9mZ9GKeP3Gz
         LbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748399483; x=1749004283;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQRgW2zDMDyRpGcNs2f/hIRhslp675QORwh/naIQme4=;
        b=XZzxMxghCZUO1CUM9h3qC1Q3zbMeR7c4v1hlAxtE5gkosm3hyfmVUUu5XqJgTJmMmZ
         NzIQmupxCCuRBed++iaN3CYuyBHWNh9bTjfNguGOeAI7KzrYiM2n553ao5v/NKA1hL3F
         x8px5faCq8l2ztCHBajLIw0vqS/cUIEno23SG2b6gzsINkntP8W+s82N61xjvaycsjEo
         ocAvWnOcrmApU+TZ0hBFBRp0/ajmxACx99Zkw/f7DtBI0N0nTQ/mIKO3f6D2Gg15uiHl
         wVaRSnFFBW3Va7y3Jno+5+uykO2JRhzgUmu5dLwj+BkUWwwJ9Ye8gEYoVQYc5Qpqgd6o
         YTOw==
X-Forwarded-Encrypted: i=1; AJvYcCV8wArwBt/TV/tGa4OMuO2NlhfgDIP9tCxSiTAz2+N4F4UbxvBAuSlBzBHRo1EDcvkQcbpHQ/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsOGMfF3JMycrRl5LpWn7CP7KTPgw7a55R7OR28o6Sb2PQucia
	dxyxn+TAgxS2jN5nVNut6SCZWw8lCoV2u+kaFDi0xPUUO3GSfWFIMpp+aidS2FcWng==
X-Gm-Gg: ASbGnctn60YWqMVGWkpo7xRtJWwZUeo+RNUPwG9rPBV8e8o6b1939cXPnAl7cOf6zrE
	TLridUie+7cccVDjmuRwls31vWJNGkG3JGou9lp7zL1oHHysai8dXGQUImajMazmlVFQs8l5hrh
	c1SY35GgsU259r/8OzztnHAqQ3aliAvk9Bxnh117W2TPHyjLwYvM1BD+9jNAqSxuA8yP3IDGflh
	twQNtTMXLNMXVpQ0GyzDDX7AB4jvP+Un0HHKDEslS0U0hVGIB67qXZN3c+01aGI81XtNmVjmaQ9
	t4xBWZqo1EjPv9uu9sN0kux/b0nJDWo+t6aeoS0qPy0uL0HFqGVEpaoVyMl4BjCK+F2RGcTu8Ez
	L1Y/bvEFF2PLKvE42CB10125nNrAq034QdqZPbvJ3asqmVrDT
X-Google-Smtp-Source: AGHT+IE52Y2joor7wjefGN/rIOi1GNEnRj6y0peHvF6A3p0ZaVNxrYsUFOHwWucOb5D5xtlgH28nxQ==
X-Received: by 2002:a17:903:41cc:b0:22e:b215:1b6 with SMTP id d9443c01a7336-23414fc0524mr198873785ad.28.1748399483313;
        Tue, 27 May 2025 19:31:23 -0700 (PDT)
Received: from ynaffit-andsys.c.googlers.com (163.192.16.34.bc.googleusercontent.com. [34.16.192.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d2fe204asm1343745ad.80.2025.05.27.19.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 19:31:22 -0700 (PDT)
From: Tiffany Yang <ynaffit@google.com>
To: "'Carlos Llamas' via kernel-team" <kernel-team@android.com>
Cc: Alice Ryhl <aliceryhl@google.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>,  Todd
 Kjos <tkjos@android.com>,  Martijn Coenen <maco@android.com>,  Joel
 Fernandes <joel@joelfernandes.org>,  Christian Brauner
 <brauner@kernel.org>,  Carlos Llamas <cmllamas@google.com>,  Suren
 Baghdasaryan <surenb@google.com>,  Li Li <dualli@google.com>,
  stable@vger.kernel.org,
  syzbot+4af454407ec393de51d6@syzkaller.appspotmail.com,  "open
 list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] binder: fix yet another UAF in binder_devices
In-Reply-To: <20250524220758.915028-1-cmllamas@google.com> (via kernel-team's
	message of "Sat, 24 May 2025 22:07:58 +0000")
References: <20250524220758.915028-1-cmllamas@google.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Wed, 28 May 2025 02:31:21 +0000
Message-ID: <dbx8o6vdihza.fsf@ynaffit-andsys.c.googlers.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"'Carlos Llamas' via kernel-team" <kernel-team@android.com> writes:

> Commit e77aff5528a18 ("binderfs: fix use-after-free in binder_devices")
> addressed a use-after-free where devices could be released without first
> being removed from the binder_devices list. However, there is a similar
> path in binder_free_proc() that was missed:
>
>   ==================================================================
>   BUG: KASAN: slab-use-after-free in binder_remove_device+0xd4/0x100
>   Write of size 8 at addr ffff0000c773b900 by task umount/467
>   CPU: 12 UID: 0 PID: 467 Comm: umount Not tainted 6.15.0-rc7-00138-g57483a362741 #9 PREEMPT
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    binder_remove_device+0xd4/0x100
>    binderfs_evict_inode+0x230/0x2f0
>    evict+0x25c/0x5dc
>    iput+0x304/0x480
>    dentry_unlink_inode+0x208/0x46c
>    __dentry_kill+0x154/0x530
>    [...]
>
>   Allocated by task 463:
>    __kmalloc_cache_noprof+0x13c/0x324
>    binderfs_binder_device_create.isra.0+0x138/0xa60
>    binder_ctl_ioctl+0x1ac/0x230
>   [...]
>
>   Freed by task 215:
>    kfree+0x184/0x31c
>    binder_proc_dec_tmpref+0x33c/0x4ac
>    binder_deferred_func+0xc10/0x1108
>    process_one_work+0x520/0xba4
>   [...]
>   ==================================================================
>
> Call binder_remove_device() within binder_free_proc() to ensure the
> device is removed from the binder_devices list before being kfreed.
>
> Cc: stable@vger.kernel.org
> Fixes: 12d909cac1e1 ("binderfs: add new binder devices to binder_devices")
> Reported-by: syzbot+4af454407ec393de51d6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4af454407ec393de51d6
> Tested-by: syzbot+4af454407ec393de51d6@syzkaller.appspotmail.com
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 682bbe4ad550..c463ca4a8fff 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5241,6 +5241,7 @@ static void binder_free_proc(struct binder_proc *proc)
>  			__func__, proc->outstanding_txns);
>  	device = container_of(proc->context, struct binder_device, context);
>  	if (refcount_dec_and_test(&device->ref)) {
> +		binder_remove_device(device);
>  		kfree(proc->context->name);
>  		kfree(device);
>  	}

Reviewed-by: Tiffany Yang <ynaffit@google.com>

-- 
Tiffany Y. Yang

