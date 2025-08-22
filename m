Return-Path: <stable+bounces-172363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B0AB31648
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 13:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5B81BC88C7
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E182F6185;
	Fri, 22 Aug 2025 11:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="uczrKuiH"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4293A2F530A
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862147; cv=none; b=c4zeGYSwc8B+VL+Isz3ut5innaqKA9ZNnDf7mUe+kvYE87AYpsDy9zBYpHsVFHKmZutbqhACGh6aTBnlOrm/uWsmCGBu8LD68isVFkxX3FkJV4UEFVTDI9L02049TReUqgnEOL6cfhKlBx9NDDnwNTw3hHM686I1xO28IhLpPzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862147; c=relaxed/simple;
	bh=74WLWB2wpFFNY5jfwXbte9fVpaHxcpj8qGdUfhbQV/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsFLm2SvAZY9CYrxiGWjkbNk1SINzL3xQHQgmNKOW/LnXCFSlCAZ4lMfnBPSnv5izg3NQOXfvdZsnX07iibY9gG5D0s8/PORxDtnBe4sBQ8qsEQABaRBZ955hb49Z95u1Kx4xwZ8U6L8SBiHq80NAofUKlDj6HtTVpF56ToYcgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=uczrKuiH; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e67d4179f8so9727035ab.1
        for <stable@vger.kernel.org>; Fri, 22 Aug 2025 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1755862145; x=1756466945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAj4MTsX9crtFaSUyO+PrnGMFjFfbBShLF1OedjML3o=;
        b=uczrKuiHTenWAgl7w12WD+sdSpNE8/Xed/gFkQ59lKvIG4wQfMKQLP1kmItdOjgYBi
         nAh1rm6cbOstc2S+qK5s4ZOLbhVD6hCV2DAbOQKrK0TYZ5A+DgGjQKFvDWMDsjgPM0vq
         rbzQod5I6k/ri9jqmIfvIMr8UrQmbklJcIV7IRdJOQ0KkNP5lZWYQy4rxnvKmy/TgTNe
         NizcN1r4rki7biKn0seg+KOQOaTt6f5Mn6Oh7/x9pnMDQq1++fGSClSqnQTCI0lkntHj
         TQusPC0rZpkNyZgwDvv77wNWH3gd36JyBnnm8I1NlaUMTjeeuXE4LEzpxkk4whaLs2NN
         YtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755862145; x=1756466945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAj4MTsX9crtFaSUyO+PrnGMFjFfbBShLF1OedjML3o=;
        b=sZrOo7fXgPwx1653FuTfdCpmRUHt59NBD0LO/SHJc6jzTQzMVZlgksOXzhoIXulAYg
         4+PsW9fnQhq9/9nwUM7XJdVd6eexurVRI5Q43qOcY46ufiMn582j4P/xQoua4zslp66T
         d0ueKt5WKG6YO+P9jCHGVnxtr3VfGQEgiK8A6miDifKA8m4HcQ5dICqUDN7+H40y2jXk
         p9uZMoFDbq+m6kHjErk8PWM2KVNXnDqoolK3AOAPeMIcxhXlZeOR/WFj7I0LREdpCECg
         uksgeGSv4gljmh7aq3CI0EnUdLnSKxfAFzjqVvO4AhvEHn2WYAMaAuXThwUwQELqhezK
         yfog==
X-Forwarded-Encrypted: i=1; AJvYcCULMp3xBdolxPL4xkrL1DYUS9pwbcejgWtR4bv8ULv1N2CjV4iVAqgq1W5llERe/z1QHoixUiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgNBXxe6VoNNyDG4VR+iMBZf+AAp775rj9qfAf2lWRHtfu1Jx
	+1HFcT2kEEdYhJCS6xrnH8h7KxPfk5JF2Y2MJLU+MN4X6nLhF+TAkHzq1UWx4vJvK1m2tfRjFZJ
	KFct/dfKmUNMK33HOY8TnLUkLazgWE5strd1qbepy13FjoySQykkh
X-Gm-Gg: ASbGncs5/cJ1HtyRbfWjAC5NkairwAElUo5IdwG5OBFAVwqgo0zCGhWIf4/SYPQ446M
	cv/nZ9CI6MaK4s8reOYPYkQplvc9324iYOb4IY12i9taNEq6XGjxKX7BOx8GLy23acO2AFreE7U
	9t6FRZNYD2cocH28Dco8lgIwFX6gs7vYqkV/yaF1rz0CbTqGvTPuDDiz1/onif7cPtRNMmbgNfX
	OHK2HdU
X-Google-Smtp-Source: AGHT+IFotCEaG3Imylyjy2m0DQxnH2th5L/KRoKnw2C+LytW2vVJKqgXGAwa/u5DAm0MxjMWmuNiRe1PyZgcFc/tw+c=
X-Received: by 2002:a05:6e02:2284:b0:3e9:e4ca:8f0a with SMTP id
 e9e14a558f8ab-3e9e4ca9b34mr9579755ab.25.1755862145223; Fri, 22 Aug 2025
 04:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805104418.196023-4-rkrcmar@ventanamicro.com>
In-Reply-To: <20250805104418.196023-4-rkrcmar@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 22 Aug 2025 16:58:52 +0530
X-Gm-Features: Ac12FXzA7OqPPvuSEUi3YmGf4O7XQNOfsrf-wXEXFi1rcASEvUu6djRNFKE82bo
Message-ID: <CAAhSdy1OcQBgV6T5z0K5mMv9pr23_oVVEJpimdzDjgAN3BhYeg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: KVM: fix stack overrun when loading vlenb
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 4:24=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar=
@ventanamicro.com> wrote:
>
> The userspace load can put up to 2048 bits into an xlen bit stack
> buffer.  We want only xlen bits, so check the size beforehand.
>
> Fixes: 2fa290372dfe ("RISC-V: KVM: add 'vlenb' Vector CSR")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>

Queued this as a fix for Linux-6.17

Thanks,
Anup

> ---
>  arch/riscv/kvm/vcpu_vector.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index a5f88cb717f3..05f3cc2d8e31 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -182,6 +182,8 @@ int kvm_riscv_vcpu_set_reg_vector(struct kvm_vcpu *vc=
pu,
>                 struct kvm_cpu_context *cntx =3D &vcpu->arch.guest_contex=
t;
>                 unsigned long reg_val;
>
> +               if (reg_size !=3D sizeof(reg_val))
> +                       return -EINVAL;
>                 if (copy_from_user(&reg_val, uaddr, reg_size))
>                         return -EFAULT;
>                 if (reg_val !=3D cntx->vector.vlenb)
> --
> 2.50.0
>

