Return-Path: <stable+bounces-166692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4097DB1C3F7
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 12:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884BA3A612F
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 10:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C8728AAF8;
	Wed,  6 Aug 2025 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JodVtdKs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1228A72A
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474355; cv=none; b=ECnc9Fs6vsUcbVQfV9c9VX9bifCDXhbxnbIbOVXJjk4pfwHzvVU/0ZwkwyfjqFZJvvykRpm6OmMWdllB77TIcbNQ5Cpq/+dkr7nAsmut+2H1+T5U2s3PRyfFjDmoKK8UkoJnX4uJeUNmqBl6can7dWY7mYM9zEfIWG0K8sRiXQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474355; c=relaxed/simple;
	bh=IKb5uL5a/Yv1fqtDIHgQ8CxYzBv3w+4eE2yq1mQQMCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cgeo6z8OhKJmaE3pXbIvFyxbx3BIsr+KzmCUfCdySkwmFcVcjlp5cRvXWspHqHFkSsvYd3JwxI8e6RVnOwxFuAchUDXTuL8IJqeP9La2FNVCc37wxLuXsO1i9gHNv+pDKE++yVlXvMMJIMtwOiGogMWNMmnJ397RDVQw0u/wQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JodVtdKs; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3226307787so4114413a12.1
        for <stable@vger.kernel.org>; Wed, 06 Aug 2025 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754474351; x=1755079151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVGDM3I4SAq4IdauxFBCdAq636kZPPhTHlfXhatdxwg=;
        b=JodVtdKsakt68yizrYENPkHCaH3/eKoTv0iLPGBcmALd3xSznwfqITVwSooAL5tYTk
         w7Wgssl02hmfqArrUqCZUqAoGvQ0Ijdd9HPn0VQjBdFEcL117a6gSr2aH+l0KtpVmKuF
         0Yu3x1xPmp5v8jpqY+nWy6XLZxaEiGJsYtgh5kQQLSnryYTZXbZGB5+o6Zo6KcYonx3B
         vGagya54iV1VXzwtGf4z1CQ8aBXOqpLuHHYGRxqjlhC3Y7jVxPyf6iAV3QoHlccBCEEm
         3ZTQnoQl+s8dVJECoS5vmqVFxfPKDf8kJRDrIb8VWukXjFT5tBJzitnHC3AeF/dDNl2r
         q75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754474351; x=1755079151;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVGDM3I4SAq4IdauxFBCdAq636kZPPhTHlfXhatdxwg=;
        b=OIBK9dJpy/QyOS/7i5thWTrGOnMpT2XnqCGeQzA7qF/q9rgSDKbWfrQSVHtxOFWrVI
         Uq2mQbOJtP+0lLKlsc3sDjmI2argUf73YUHRHneEYDASoUM2KitCZRsQFyUii/rJYT1s
         TdX5yZzV+YD+vNroqHvZcWu+gfstzEk2MoA3shhKDwkHMN8vHcSma7TVXpI3OqQkZJsl
         NtiEhaqCXfQhan1udqYIfSanks1d+MAZuCPsI3sdGS01yfzQIHuBdGr7+eykPHSY+ESQ
         olrqjvf73lGwcbvU5W0eANvKc7r7/iNSDRpodYDjM6xOWsAQORujFW5a31JMyoGSYEPU
         81xA==
X-Forwarded-Encrypted: i=1; AJvYcCXigt7mc63mppk8Z+nysDMyWq5gcJcxP1sbFCyJshPFiIRoRHxaphJqoECLqRGB75GypxJe/yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY4zyz5ijZGICChR17GN4L0CKFOMVcm5Kp9ETOdvJ8+RfT1CXW
	0MAgpM3WTcQ7WhxWm11UvWWBhM/h4EXucbpwpZt7O02TY0/17p5NkmYFrFY4X39i9jQ=
X-Gm-Gg: ASbGncvzwVJ+1ESBbwECQfcisgD+HkMTxEy04cZ28LY5zD+DoFV/BYWDOU5RmjnWGBf
	Mc1rvNPL0Y0yJJ8o5FtIqEzsvaIqGV6coEHSxWjx0dWywq1YFQ8OxqlZaMWvQc3yxmSteTNiFk8
	KxkTo11gq5v0RtbYRPAnonJkbNytD98MKzckf5htxOaF3l8sH7c0QEK9GQsjQHpi63P+E6kO/Hy
	z/CA/a2XcffxhkwzKODCwGKk3jtak50upn70WHtSE36Xn7cd5ZAFWoSbDgR6U8yy9cRHRtKXn81
	K9RRdTkIcmKPCydmPDPpe7b69tsucWp0eI7U4+4YiRHdJ3bw/Ev4PZXlvvwhd9+N68UHO3Ml29D
	3SP6PkmW6Ouonw64qzOt1214tV+gHdf263jw=
X-Google-Smtp-Source: AGHT+IFDQkiy8dEal9JGcheFb4DCeMC/D2uxTEcourcA4xojZOo5yHWKjW3OBM8sYPB5X5rv1iZYAg==
X-Received: by 2002:a17:903:2302:b0:240:25f3:211b with SMTP id d9443c01a7336-242a0beacd1mr26147005ad.51.1754474351119;
        Wed, 06 Aug 2025 02:59:11 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.244.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c03sm154551605ad.97.2025.08.06.02.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 02:59:10 -0700 (PDT)
Message-ID: <953d2f4c-d82f-4e8f-a905-b7dfbf690ef7@ventanamicro.com>
Date: Wed, 6 Aug 2025 06:59:06 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: KVM: fix stack overrun when loading vlenb
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 kvm-riscv@lists.infradead.org
Cc: kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 stable@vger.kernel.org
References: <20250805104418.196023-4-rkrcmar@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250805104418.196023-4-rkrcmar@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/5/25 7:44 AM, Radim Krčmář wrote:
> The userspace load can put up to 2048 bits into an xlen bit stack
> buffer.  We want only xlen bits, so check the size beforehand.
> 
> Fixes: 2fa290372dfe ("RISC-V: KVM: add 'vlenb' Vector CSR")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   arch/riscv/kvm/vcpu_vector.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index a5f88cb717f3..05f3cc2d8e31 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -182,6 +182,8 @@ int kvm_riscv_vcpu_set_reg_vector(struct kvm_vcpu *vcpu,
>   		struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
>   		unsigned long reg_val;
>   
> +		if (reg_size != sizeof(reg_val))
> +			return -EINVAL;
>   		if (copy_from_user(&reg_val, uaddr, reg_size))
>   			return -EFAULT;
>   		if (reg_val != cntx->vector.vlenb)


