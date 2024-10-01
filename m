Return-Path: <stable+bounces-78454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED17398BA26
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF292830B4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF67C1BE847;
	Tue,  1 Oct 2024 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ffu86CxH"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80D01BE244
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780173; cv=none; b=cx9QSCvE7KrLxw7rgIQHPI8GUzlb7RxRnuL+T1MjJ9NC9LNCAc4SCZhvHq4VIE+BDXYZBjmKIV1DIF4Zt3MT6/DVRaPFTqK5+2mCS8xCgtkxZ//hSL4fa2+i9JqVMSz12N+k4N5W//9yZNYIup42Tlnj22UhDT+xMkSM1hYyvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780173; c=relaxed/simple;
	bh=q2BxZIKRLar+nRWtHGf6NfCN0u2SBQhbVYOQCkCT6Ws=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OqHY+zscwkKXVDVjtg8I5tytzMBidboY9+zTVWv9ECKZ7pBL/CIOjCL4z9PH53obGu8QX/Uaz11wWV59mepgOt9bgEcN4HrVn+V1fJlXWZwZc/LQ+Ov+cbSzzRB+vl9FLOc1xyGzkkHZLmn+t9pm/gQ5Kj346A9jxUvmarXdkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ffu86CxH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C10EA3F5E1
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727780167;
	bh=cffy+Z3VyDZ30QrCrVDSHqUYHPJ52fzEBS/6c6EOh0c=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Ffu86CxH6qZuXLLJ4RrmQVnSgRBBwPsbFc7aSQLqWKzzXuPSEUpK8N5U97dmrhivX
	 lQTzn5EQxCtqcBAAT9A3OOZo1ak+i6qqKw7vKdlOk+1ZUE4kAZCFdGUWAxXvj07PAY
	 UZRbkHAyGLq9JXLRXl9rx0b4iQ60+1P2e7Tv16PVgLIjEZm7xWMO81C8V+7vcBqj8J
	 xtywIYf1bpOQf9EAU7ZcOzCQhpklvVXWe2E2EvtsbeoVd6njZgwiche2/TtFmCoM8d
	 gmxaHOJbFDFZg0crh6nJdd64GfcJ91o1iJ4h0G3BGH36Wf2c8lDggZJhWsPUZV3xVw
	 0rilKgzLbMUUQ==
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2871adf05aeso5287229fac.1
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 03:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727780166; x=1728384966;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cffy+Z3VyDZ30QrCrVDSHqUYHPJ52fzEBS/6c6EOh0c=;
        b=q8/yWLA9tsKbMPH4Xk5Ml8Dat8i8QZkAEmEhanyqG/8dy65p7z2hoXI2qqyzcNBTNP
         hIe4olq7YCS0xP16mJXGYiaJx8NVNsIr0BuXz+s8JnyJjT3k3TFBdEDGD4djP6gfwxj4
         VldfiVmbjJ5YxKnybHy/h+76dhBbfkLROZAy4C1CiPwU+Cs847tTpZHb7fKqASI1ttiq
         nYPJItb7taJrTx5UPNbo3kUBlUxOn96u369/HIQh4v2OtshTL2ilEX26HSS6AueIyZ0S
         SVKyUfdNnMFYFMrLmbxIsQcPLSCl4qDZfXjXzpGx/T/Q87HFntWiUZ/i7fs3xsoETGBR
         RxGg==
X-Forwarded-Encrypted: i=1; AJvYcCV2qTzCHLkXPlkZs1lw8m/DrMT4CkVjH1BvradbjbJ28mmVX0i8pN8lfNf9xFVcmVG7qlyCnKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99F+A76ZJszqGtRc7kt14tW9ORyG72ujAtLWgOZU9rck+5IAG
	9QGDkKqGkaQoRn14SsVEJACliAApcdmKinrHsiqmVCnGBxrYRVlp4ss+vQgeLBHT+Kn//W/wHAV
	Lf9gF08VSaUv/aDqhOsqHnAVKmqLRdpo25fU1kVzr27o7r0E03bBpeL04VvWXlxyDdxtt5xfnM9
	bTLG2dyaoITU3lZiVMIrxwYN5wmJWx8Bj8fCK4OTnoVFsS
X-Received: by 2002:a05:6871:546:b0:277:cb9f:8246 with SMTP id 586e51a60fabf-28710bb0f11mr9907404fac.38.1727780166554;
        Tue, 01 Oct 2024 03:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmdyej5fn4nmNuFbnZtzhPVlcamHO9/HtMZQ8zYXDL3DuuDTSynQ1mCkP4fB+TXeRzA2qPuc7jYD2cnz+Pels=
X-Received: by 2002:a05:6871:546:b0:277:cb9f:8246 with SMTP id
 586e51a60fabf-28710bb0f11mr9907391fac.38.1727780166205; Tue, 01 Oct 2024
 03:56:06 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Oct 2024 03:56:05 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
References: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 1 Oct 2024 03:56:05 -0700
Message-ID: <CAJM55Z-3fPh-qyb_dpaBH12ocV3yheR8Rentg2oz9jCVLAuJBA@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv: efi: Set NX compat flag in PE/COFF header
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Heinrich Schuchardt wrote:
> The IMAGE_DLLCHARACTERISTICS_NX_COMPAT informs the firmware that the
> EFI binary does not rely on pages that are both executable and
> writable.
>
> The flag is used by some distro versions of GRUB to decide if the EFI
> binary may be executed.
>
> As the Linux kernel neither has RWX sections nor needs RWX pages for
> relocation we should set the flag.
>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Makes sense to me. This was applied a year ago on arm64:

  3c66bb1918c2 ("arm64: efi: Set NX compat flag in PE/COFF header")

..and before that on x86

  24b72bb12e84 ("efi: x86: Set the NX-compatibility flag in the PE header")

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  arch/riscv/kernel/efi-header.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
> index 515b2dfbca75..c5f17c2710b5 100644
> --- a/arch/riscv/kernel/efi-header.S
> +++ b/arch/riscv/kernel/efi-header.S
> @@ -64,7 +64,7 @@ extra_header_fields:
>  	.long	efi_header_end - _start			// SizeOfHeaders
>  	.long	0					// CheckSum
>  	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION		// Subsystem
> -	.short	0					// DllCharacteristics
> +	.short	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	// DllCharacteristics
>  	.quad	0					// SizeOfStackReserve
>  	.quad	0					// SizeOfStackCommit
>  	.quad	0					// SizeOfHeapReserve
> --
> 2.45.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

