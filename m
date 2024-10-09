Return-Path: <stable+bounces-83156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386A8996104
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 09:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BD11C20B08
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 07:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1848917C22A;
	Wed,  9 Oct 2024 07:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y68iUmg4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0B11CA9;
	Wed,  9 Oct 2024 07:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459525; cv=none; b=Kdj1Xbm9dMM7RpQrlnXpS1ozHYYOgDk52xX+UBr+Z9SYCJv0Qi5jKM8HasCKrv3wNwcX0FNmuTdtDlKGzgXnIMO09fpUzH0pRVW+2PiWzSrQgc3weqQbGnN4JBeQ9vhf2Dloe79Yu4MbzsnbCWedRjCuruGV1e+5dDt2HCVOS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459525; c=relaxed/simple;
	bh=2RyF8nwj/cvj+E/yNHIotQjQzUIGEOP30JiIx6mgg60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sl5FKsBAOEBCUxZbKLtGwDjPaj5jt7nhtezp/+6ZEBpC+iOCq739bHqS7ptWaJ5JTxtrXfwsZfplkIRzsWQEhjFeNJpsAQv+zHX0suT9vG7psL/A+iiHvJ2aV5ZQA1eUPcXUfr7lyKdSRyvssNodZeaOhb48DbRazW6eqxTARA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y68iUmg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522C2C4CED1;
	Wed,  9 Oct 2024 07:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728459525;
	bh=2RyF8nwj/cvj+E/yNHIotQjQzUIGEOP30JiIx6mgg60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y68iUmg4iTAoNbzCOIRIx2DkZgcWD53ucRl+6P7R7YQIBRiWytzrL7ms8GP+wsOV2
	 Umvowb3hgIeSM4AEKMEdw8V8VxkV5RClShLG8ApzvPueaDCFN/5rAY0sc9jsxgNOaz
	 jUyeJJDCLn1rnAY9A5RYHW+XhhNdOleQs9Dc3hjvphYV0zgE2+50Y6LX+sEKGhcjOa
	 jVHI0vWLNIpGJlUrXC3Ada421ZdRDvx9IZYFXWXZGpUFUdAbr66T6Qli4nMXlg7ZiV
	 QnuSwuUtqhp/nqJBnTYg0n8qy/XcyR+CLg2bNHYyJMnJEG1HT7urY56LZD/5An+u4d
	 p04k+y94Sht1Q==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5399041167cso10356312e87.0;
        Wed, 09 Oct 2024 00:38:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUq3ZWR/NP5XTLInZKTxv6ySFc2cMn7nw4mav6vjDw3JJiRL9iGeGIRX+Z+tgUwA3msF/6dAZYf@vger.kernel.org, AJvYcCVvig8rzqUxa2ojf/t6hA3joBIXer2EhlN9E5dS5dQ7ghQ4TgbrTKMSNJTqDXGWJrLb4ddYfakB83eRMo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLT/Ds3P6OrtQylvxAXocwxnl7L9+Sc0hnoduvOmckZ81s1ngd
	imMWIKd1JP+lqw5J/MXBNuyJ/Bkv9R55tItFebvzjZEh27nMZMVda+G86SwyKRDkefmNXQ6W+WF
	EsZPLO5F7Rc600IwxJRquY+gWUME=
X-Google-Smtp-Source: AGHT+IFxOX0737Ws11iCI0Sk/iqlwtLiRNezGiQM/0njq7wd5LtZKlh9lMt9mdRUL9ZhtXZxXaQ5G6n6C3s2PZdsI6o=
X-Received: by 2002:a05:6512:224b:b0:539:8fbd:5218 with SMTP id
 2adb3069b0e04-539c4968223mr1196233e87.56.1728459523690; Wed, 09 Oct 2024
 00:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 9 Oct 2024 09:38:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFs=z6AYJm=2La5C28snjz5DSq24tApBDReQEbk1eAOhQ@mail.gmail.com>
Message-ID: <CAMj1kXFs=z6AYJm=2La5C28snjz5DSq24tApBDReQEbk1eAOhQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] riscv: efi: Set NX compat flag in PE/COFF header
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 29 Sept 2024 at 16:02, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
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

Acked-by: Ard Biesheuvel <ardb@kernel.org>


> ---
>  arch/riscv/kernel/efi-header.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
> index 515b2dfbca75..c5f17c2710b5 100644
> --- a/arch/riscv/kernel/efi-header.S
> +++ b/arch/riscv/kernel/efi-header.S
> @@ -64,7 +64,7 @@ extra_header_fields:
>         .long   efi_header_end - _start                 // SizeOfHeaders
>         .long   0                                       // CheckSum
>         .short  IMAGE_SUBSYSTEM_EFI_APPLICATION         // Subsystem
> -       .short  0                                       // DllCharacteristics
> +       .short  IMAGE_DLL_CHARACTERISTICS_NX_COMPAT     // DllCharacteristics
>         .quad   0                                       // SizeOfStackReserve
>         .quad   0                                       // SizeOfStackCommit
>         .quad   0                                       // SizeOfHeapReserve
> --
> 2.45.2
>

