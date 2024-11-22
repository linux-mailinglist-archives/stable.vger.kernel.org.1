Return-Path: <stable+bounces-94598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 495B99D5F79
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC961F2216D
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB621DED42;
	Fri, 22 Nov 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/P1owA2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6E1EB39
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732280641; cv=none; b=V88oWm3V9RpcoozRHOIClugqiqDhfoKsLYEwT98oWh3P4wDDoC5g3lipl+1KfHpJjoMhNq/++ZpKlYuaXKpRM/2ILfr/56DGZnzeRANtJardy3NdliBZK26cOLbHfigdEc1OxOST1i0ZbyHnELSnY4AtBgpRubvAbdwRTxS+0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732280641; c=relaxed/simple;
	bh=HkyjLPb734aAZvIolW+OLEzvFcUc7H4APut784A9G7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3/XzzJt1y4pkEjHJrwz9Sp+NG4TP1oTrK9wDGfde2ZaRsUE50PXtriuOpMSbJ7yytpeCCCJZNXULMZaT+CJpi05loi7Xyv5HWjnY9UxTOoVgP9euul0cjHfj1zVvASvdzJBiyvbkMwRuqDwJ3AKoY2welfmjOsQXiLUUoAvIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/P1owA2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732280637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ft4564hHBGkICUTkZjOLlmPFHPv4/CYfCDRSgrLHfNA=;
	b=K/P1owA2WyQkFBA27jWS8Jgg9Ij0UYZ/80iZgEixAT22sheVfNKAZn9d/3CJ/Mv7ejyOMY
	n3qn1sO+EjAtGQv9py0uCvofWoEMuVoNbquOBx+rohHoWc1lQWTSsZl0P98EUDcNrUimzT
	vJ9RukJC53s2/ZNhlC8mKEqJH5Be9B8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-qHLVCp-wPyeTBgUeqGclBg-1; Fri, 22 Nov 2024 08:03:56 -0500
X-MC-Unique: qHLVCp-wPyeTBgUeqGclBg-1
X-Mimecast-MFC-AGG-ID: qHLVCp-wPyeTBgUeqGclBg
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso24593125ab.0
        for <stable@vger.kernel.org>; Fri, 22 Nov 2024 05:03:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732280636; x=1732885436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ft4564hHBGkICUTkZjOLlmPFHPv4/CYfCDRSgrLHfNA=;
        b=qbWiGyLZhqjwXwcTdVm/PjNZiy8sFyNBt8R7RrZc3Nz00KJG0q24f85lCWjnYOqRBd
         OC+e2nXCunouv1hkrdFkxV88AjPIYRQptZfBBOM9Gt1GXHwmAkLCyHWIl651mfUBUC+s
         jp5kFS/f8ZWuFo8iLZN4U6YsYvcNVUTGokU65feC7Liy/2QIdMMWVKIulh56XRCHIofN
         iGAENUwzYcYdnm8YNt/V/Pq1KknMh/AAw1i+kilX+X/bVLCbS/u1EgkaezUXIWeGkRvg
         VHuDdFZo8umk9Y7CD1YyxbWwndOcJSRRSFaNW56r06iP6FES1to710XrIiv8Eovagmpc
         fNKA==
X-Forwarded-Encrypted: i=1; AJvYcCWEC3OHspL0tVYLPvgfsLUnj4q9SnS7DNjf+tmtdwEjReyPwWib96acCRxxpWQ2g4m+3Ondc9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU5Vg1Tta8bVa5F10yAJtScbl2hTkyfERwDz3kIbPGZX7cfoMV
	We/GkVad8DCdzmKdGe/XUld4bVUUEKo8dHmXHvaCxSoCZsFWd6RUiC2aC64ebkJy/CkBjoAwxxy
	yKYghBpa0PcGlM9B/EA98z26MhVAOHrb3lXIYTGIyGC7R1ycN6gUEa1jjEi23jck9JxdZa58KW3
	WyK7kFqFrWY+kBqJtFO7gZEUZYzQpu
X-Gm-Gg: ASbGnctxw66VMx/CoVVvnUBXLsk7hczyBmRhE0I9L0MI4AvYIydw3ixTwqX5RxWqTRO
	9ic7GWc1vGHMF9LctzgZxCnFCzSD6+psp
X-Received: by 2002:a05:6e02:4416:10b0:3a7:a4ec:6cfc with SMTP id e9e14a558f8ab-3a7a4ec6eb1mr6221875ab.8.1732280635683;
        Fri, 22 Nov 2024 05:03:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjBIujeBiiBto12x7Ie0ZkLS7jCkUl1dIw1psG2/yNOJ8YhDHEILctT4OBs1UgwnhG2+2a8NNiGBzHeq0VFf0=
X-Received: by 2002:a05:6e02:4416:10b0:3a7:a4ec:6cfc with SMTP id
 e9e14a558f8ab-3a7a4ec6eb1mr6221485ab.8.1732280635355; Fri, 22 Nov 2024
 05:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112185217.48792-1-nsaenz@amazon.com> <20241112185217.48792-2-nsaenz@amazon.com>
In-Reply-To: <20241112185217.48792-2-nsaenz@amazon.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 22 Nov 2024 21:03:49 +0800
Message-ID: <CALu+AoTnrPPFkRZpYDpYxt1gAoQuo_O7YZeLvTZO4qztxgSXHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/efi: Apply EFI Memory Attributes after kexec
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stanspas@amazon.de, nh-open-source@amazon.com, 
	stable@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, 13 Nov 2024 at 02:53, Nicolas Saenz Julienne <nsaenz@amazon.com> wrote:
>
> Kexec bypasses EFI's switch to virtual mode. In exchange, it has its own
> routine, kexec_enter_virtual_mode(), which replays the mappings made by
> the original kernel. Unfortunately, that function fails to reinstate
> EFI's memory attributes, which would've otherwise been set after
> entering virtual mode. Remediate this by calling
> efi_runtime_update_mappings() within kexec's routine.

In the function __map_region(), there are playing with the flags
similar to the efi_runtime_update_mappings though it looks a little
different.  Is this extra callback really necessary?

Have you seen a real bug happened?

>
> Cc: stable@vger.kernel.org
> Fixes: 18141e89a76c ("x86/efi: Add support for EFI_MEMORY_ATTRIBUTES_TABLE")
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
>
> ---
>
> Notes:
> - Tested with QEMU/OVMF.
>
>  arch/x86/platform/efi/efi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 375ebd78296a..a7ff189421c3 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -765,6 +765,7 @@ static void __init kexec_enter_virtual_mode(void)
>
>         efi_sync_low_kernel_mappings();
>         efi_native_runtime_setup();
> +       efi_runtime_update_mappings();
>  #endif
>  }
>
> --
> 2.40.1
>
>
Thanks
Dave


