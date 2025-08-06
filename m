Return-Path: <stable+bounces-166713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF923B1C8DD
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 17:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845F9624A33
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50603293C4D;
	Wed,  6 Aug 2025 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx6I/p8l"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB5D2D7BF;
	Wed,  6 Aug 2025 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494720; cv=none; b=KkFcd/woPvbJ50Yddpc6hWyL4sCVcnvpNLgAtLYi2lda9iIbCeLY/LKJUVzaOcjVWHIAiqtO1dk5EvSQfmFZMNKrOwlwfodYmXzRESBZ/umk18vxncCLyqOU89mxEkKrVkSvdpXrhB9NKe9zI2LMoR06zq2OR6nesaXN9stmIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494720; c=relaxed/simple;
	bh=b5xV378mmIVkPQ2XJHTTVqaUFaKTnwOkMfVxl6qad7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZb7DS5VDzVV71TXfv/Z2fzaXFoJH33zSkmYi9TWphlDUIc5stfN60UTSDg9MDm2Z5XY3qdRBrNB2eSE/KyExK3r6FMSFxoC67UJPVgUFBQdKcwkljE6UHghjbGeAQPIZbOF6KL2eEHprgskqYEeQgOkZhd9ldparbyhNvv9k3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx6I/p8l; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-30799a41109so32533fac.2;
        Wed, 06 Aug 2025 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754494717; x=1755099517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WrOiLUjlHMAD5qB46+Jo2Wz4HXpj9fepKX/diN8D56c=;
        b=Rx6I/p8lO979/ShjJxEkIZHkpvW59bgafJwhozK61vfrSHucKqunnd1YuK+kcbbfES
         dZVYuXHR9C9e0kq7YtKMwV9EvHvYSDwBRpZDmoDgwhV9d9BB+sZCS8D9eZlsXNX5qWvo
         2L6PblpKgaOsa967E34UHkIEnWzAYrzUshHcOMgsippMDD2duOBXF16rw+P0eus6/4Gi
         FnMAXB02HtvTzp+KoW1oSo62+cEE7QDn3qLkNgMSiSrQTdl9EQKLX+Eo4eC9b0Kw4kvc
         E1iOiMBJq6Wk84n3QZzesEaFeFPnJTkPWLjFW34YhVQ1Lu9Fa1Mew38KAAyJ1LFBMBfZ
         PD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754494717; x=1755099517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrOiLUjlHMAD5qB46+Jo2Wz4HXpj9fepKX/diN8D56c=;
        b=uAdA7L/h8VnWQkj2AJlp5pSmri/CaSn7yM127dpQqbL8z2zWsUgFv7/NJLNumfemHr
         Sz3KiZ4GnUiljfeBU9qCiUd0T1GNmF3Oly40Ut9l7tsYSfkqZTk97xQZGmfk/05plitk
         EtiWS87tZ2iH+IP0mD5+PkaVrjx6DQFzGYgmh47EfBTVXFi/lbyfhwuqilvqzIQGbcZ6
         xg5YgYthBFrHVcTLUywUcqb8nqRo6indcMNmbKNifo15Dk87qWGJWAVX6GBNdMYYBaTx
         RQacE7upMBOuUg2JTEnD8mUwtRz/QLHGUMuRAqy3n0RlVUEkLTCT8rYF6nJHKAr0UzI0
         +T6A==
X-Forwarded-Encrypted: i=1; AJvYcCVl+hrSUpejm3uXs/sLy/M3QbROBn+7Dg8ejWTS5kw7Ih/0ZiAbl3GHwi6ic/gnjzzpvyO1Y4gQN48Sjjc=@vger.kernel.org, AJvYcCWRRG1Je+Y4j+DsKlVrhAwIn0gnZt+Ki1QPXzbydOrt2DfxxGpqcMw4X6l/pAlpAg4sUY6kWFds@vger.kernel.org
X-Gm-Message-State: AOJu0YyoWvfQ4Cqa9PlZokq3Fsz6BdicPu97ejSKoDSXCVBVkYK38/2w
	43mlNPeY4PUc0hzRS/nHL5Nioik3l6G92/NjEvPPiuEaYXoSwMrC2S3DthcxKYYDOwexbzoiten
	pksBd23tLCA+n326Wx23pQDwgPNMoXt8=
X-Gm-Gg: ASbGncuo9kvrtNZljK7mqNHCb6EprEBBzn43ZUkwVtO28C3+y+30aDJBGr5QxuwB/zN
	kpObwS2OqHw90oG/kGAxHvU/+UI0IsDtQn58Gqt0BuxMB174wLEbQZXTHMyak6lr+7PMPtzMKYR
	5IhZpKaOFxHdzRkqzuLYNkgEpTGQf8hlS03BCvnUBGW6SA5hqqKw7HV6y3XeOTJ1vbHInkVXnLl
	kegUGbr
X-Google-Smtp-Source: AGHT+IFYz8e/stP8Hupv1QOCESKJJcWXdDupZ7+uMLrWpZ9GYUBBRbHCBkNonI8IRQBTq1coB1FaRIx+CPg0mnqQSF4=
X-Received: by 2002:a05:6870:3929:b0:306:c53a:f904 with SMTP id
 586e51a60fabf-30be2961c85mr2219047fac.9.1754494717379; Wed, 06 Aug 2025
 08:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806153433.9070-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20250806153433.9070-1-suchitkarunakaran@gmail.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Wed, 6 Aug 2025 21:08:23 +0530
X-Gm-Features: Ac12FXwWWIuBvgVBmXN6nTaFuKW8SoROaRzgJ17UnQsFmv7ch28vadLMsyDfm2k
Message-ID: <CAO9wTFi9MHnzEw0p9QhhFOW_sk3mo_1yT3-YkjTYwN+spYUFWg@mail.gmail.com>
Subject: Re: [PATCH v5] x86/cpu/intel: Fix the constant_tsc model check for
 Pentium 4
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, darwi@linutronix.de, 
	sohil.mehta@intel.com, peterz@infradead.org, ravi.bangoria@amd.com
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 21:04, Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> Pentium 4's which are INTEL_P4_PRESCOTT (model 0x03) and later have
> a constant TSC. This was correctly captured until commit fadb6f569b10
> ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks").
>
> In that commit, an error was introduced while selecting the last P4
> model (0x06) as the upper bound. Model 0x06 was transposed to
> INTEL_P4_WILLAMETTE, which is just plain wrong. That was presumably a
> simple typo, probably just copying and pasting the wrong P4 model.
>
> Fix the constant TSC logic to cover all later P4 models. End at
> INTEL_P4_CEDARMILL which accurately corresponds to the last P4 model.
>
> Fixes: fadb6f569b10 ("x86/cpu/intel: Limit the non-architectural constant_tsc model checks")
> Cc: <stable@vger.kernel.org> # v6.15
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
> Changes since v4:
> - Updated the patch based on review suggestions
>
> Changes since v3:
> - Refined changelog
>
> Changes since v2:
> - Improved commit message
>
> Changes since v1:
> - Fixed incorrect logic
>
>  arch/x86/kernel/cpu/intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 076eaa41b8c8..98ae4c37c93e 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -262,7 +262,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
>         if (c->x86_power & (1 << 8)) {
>                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>                 set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
> -       } else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
> +       } else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_CEDARMILL) ||
>                    (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
>                 set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
>         }
> --
> 2.50.1

Hi Sohil,
Could you please review the patch? I hope I haven't made any mistakes
this time, and if there are any, it was completely unintentional and I
apologise in advance.

Thanks,
Suchit

