Return-Path: <stable+bounces-93377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 464319CD8EE
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3CC1F21127
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39251898ED;
	Fri, 15 Nov 2024 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mh9NoQhJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919F2153800
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 06:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653716; cv=none; b=fso8dWJ+k8+lV/+e0GrAhEmNTzaMUheKZ8Zrz0VTDLRwNBZcYgASia9bJwmWlLea6EhmIRGU6jnPAPrnq+8jA23aTIMjr3ycX4nm89M/hFGaU61oxHvxdd6MdiUQOwdfuGKzhrq3krrtxJR1xgxk0F5KmKOh9mgzd4+4Vkx5f0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653716; c=relaxed/simple;
	bh=1CGr0TE3Wg5HzshzjEwit7oZPSSbwmr0PtGQ0w5NFAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STNOcYkCvgW48jxxMWTeG/tDWOLozuCY+qCcrCg2wortosCRwJyQK9wQOPdCBUS68nTXN162xO8SUXcRZsXAndu+9F79RcnjA/jF+7hTYg+QU28WOPdUq/CPl3lBAF0K7TougeK1kZNR4w+vr7OEp3hUUbheAoVyfBELA61gtzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mh9NoQhJ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa20c733e92so52198666b.0
        for <stable@vger.kernel.org>; Thu, 14 Nov 2024 22:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731653713; x=1732258513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFl3zgdU+gV4a744BMJnAQAV9SIlx8LGcZai2Rux4bA=;
        b=Mh9NoQhJcmhyt0J4IuAtob+xRHvep+n7118pcpiD4fogvsNjZPBVoHwlVcIrQfMJdV
         J0p/EkIDYB6MtnfkncJUNuxMyaWLsZfkDiLvdPeZAxqIRoazoCgBnlEsk1lFYwHMTdOY
         h5zSC8sI8O4EIzNi0Lur0WG23j0M7rby2ePsSqCzZl7B4artcas2DAa3Vb04s4Hz5jT+
         zshUdvhey/0cukfXI4S3TtllKsXHMSLffr1M/XUqFL50xnUwvFDs0moLzS734xJcmq+p
         UalVE1e3wKdoSnjhNLtWAiocQsa+41NmgI07PJ9nbbD8qyBYQp7W1U0fNuYkT/gIp5P1
         krxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731653713; x=1732258513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFl3zgdU+gV4a744BMJnAQAV9SIlx8LGcZai2Rux4bA=;
        b=Nsx9FLsa/2ZT9a3Lv8mGZBxdAf5doUXosIOOeenpPIOqUuVmukZxdU4eLqVY72ABgh
         ZJee/TGiKqMYAtnsvXFAQjo0xEafcXOk1l2hFWKskgTk4rGL1qZ4ONBZF+l09t2Cn8LC
         b3D4hqVNXuUIT4O8GjWHPIamsZOBX8O2DEhDV3Cda7xC6ICF78cu+JoilEK2XxTBYDXY
         e/byj7snUF9OmjygE/qXc9tn+UENkhARGfYbaF+kF5UhXsYRlHqnApNqGNWQIXZ7syEb
         rClwRTgRg/L0EZW9xmlFaX9a5PTsmM+gpuQ7MHoFMefDnlxDOYfKGsUXm7gc6nBHe/2X
         uLzA==
X-Forwarded-Encrypted: i=1; AJvYcCW1YC2jcHF3uukREjV9bMVLun8n/ZhrmIw85HIYXuSud+JdpwGF0qm534yL83rZUV6PaKZOEZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymxH3c6uKWcRLgkB+FTJrhweT5JoCCTympcwEonW3Q21AQZXNY
	8T1L5OScWA+lC+2IdSaT16ToKNlDyVwFu71vCzIUJgbVO8x87ZdnLWoVQijQMaU=
X-Google-Smtp-Source: AGHT+IHlujWuxxaiUuPJQSafn7dTcFby74LcLirC+yJyEdIFFzXahlURXC2FA5JkrzC9ma3wuNrbIQ==
X-Received: by 2002:a17:906:d54b:b0:a9a:4f78:b8 with SMTP id a640c23a62f3a-aa4833ec1b5mr97225266b.2.1731653712857;
        Thu, 14 Nov 2024 22:55:12 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c1df6bsm1282524a12.83.2024.11.14.22.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 22:55:12 -0800 (PST)
Message-ID: <a01c8667-1de5-4f3e-b15d-cd765238a538@suse.com>
Date: Fri, 15 Nov 2024 07:55:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 25/63] kasan: Disable Software Tag-Based KASAN with
 GCC
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Andrey Konovalov <andreyknvl@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>,
 syzbot+908886656a02769af987@syzkaller.appspotmail.com,
 Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20241115063725.892410236@linuxfoundation.org>
 <20241115063726.828422420@linuxfoundation.org>
Content-Language: en-US
From: Jiri Slaby <jslaby@suse.com>
In-Reply-To: <20241115063726.828422420@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 11. 24, 7:37, Greg Kroah-Hartman wrote:
> 6.11-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Will Deacon <will@kernel.org>
> 
> [ Upstream commit 7aed6a2c51ffc97a126e0ea0c270fab7af97ae18 ]

But we have:
   894b00a3350c kasan: Fix Software Tag-Based KASAN with GCC
in 6.11.7.

This 7aed6a2c51f was reverted right after that 894b00a3350c by:
   237ab03e301d Revert "kasan: Disable Software Tag-Based KASAN with GCC"

IMO, drop and blacklist this patch.

> Syzbot reports a KASAN failure early during boot on arm64 when building
> with GCC 12.2.0 and using the Software Tag-Based KASAN mode:
> 
>    | BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kernel/setup.c:133 [inline]
>    | BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/kernel/setup.c:356
>    | Write of size 4 at addr 03ff800086867e00 by task swapper/0
>    | Pointer tag: [03], memory tag: [fe]
> 
> Initial triage indicates that the report is a false positive and a
> thorough investigation of the crash by Mark Rutland revealed the root
> cause to be a bug in GCC:
> 
>    > When GCC is passed `-fsanitize=hwaddress` or
>    > `-fsanitize=kernel-hwaddress` it ignores
>    > `__attribute__((no_sanitize_address))`, and instruments functions
>    > we require are not instrumented.
>    >
>    > [...]
>    >
>    > All versions [of GCC] I tried were broken, from 11.3.0 to 14.2.0
>    > inclusive.
>    >
>    > I think we have to disable KASAN_SW_TAGS with GCC until this is
>    > fixed
> 
> Disable Software Tag-Based KASAN when building with GCC by making
> CC_HAS_KASAN_SW_TAGS depend on !CC_IS_GCC.
> 
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
> Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218854
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Link: https://lore.kernel.org/r/20241014161100.18034-1-will@kernel.org
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   lib/Kconfig.kasan | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 98016e137b7f0..233ab20969242 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -22,8 +22,11 @@ config ARCH_DISABLE_KASAN_INLINE
>   config CC_HAS_KASAN_GENERIC
>   	def_bool $(cc-option, -fsanitize=kernel-address)
>   
> +# GCC appears to ignore no_sanitize_address when -fsanitize=kernel-hwaddress
> +# is passed. See https://bugzilla.kernel.org/show_bug.cgi?id=218854 (and
> +# the linked LKML thread) for more details.
>   config CC_HAS_KASAN_SW_TAGS
> -	def_bool $(cc-option, -fsanitize=kernel-hwaddress)
> +	def_bool !CC_IS_GCC && $(cc-option, -fsanitize=kernel-hwaddress)
>   
>   # This option is only required for software KASAN modes.
>   # Old GCC versions do not have proper support for no_sanitize_address.
> @@ -98,7 +101,7 @@ config KASAN_SW_TAGS
>   	help
>   	  Enables Software Tag-Based KASAN.
>   
> -	  Requires GCC 11+ or Clang.
> +	  Requires Clang.
>   
>   	  Supported only on arm64 CPUs and relies on Top Byte Ignore.
>   


-- 
js
suse labs

