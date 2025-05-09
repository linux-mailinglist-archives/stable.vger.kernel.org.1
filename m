Return-Path: <stable+bounces-142965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C469CAB08E4
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 05:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE413ABC61
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 03:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630BD22D78F;
	Fri,  9 May 2025 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbp3Y5e0"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3734964E;
	Fri,  9 May 2025 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746761483; cv=none; b=PkiUM/GBjhCu2hw31zYgb6KFfCJQIgaFrUlUXTHXYg2slQKQCS22lfujNdSfmLL5hIAkcP7xoZWZyzC10hQfFqaKZiStktREkHdCJvLMwqq0zBpBi9GO4goMWecjuS8cLO5RE/LNcThLI9ECwyYOqN0Gqbze7IVCazB+k3Fo6oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746761483; c=relaxed/simple;
	bh=+Yt6T0u3fYfQL7cdc7BFMhOrNEKA8KJXzQY/Qxnx5gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBYg4PSaRXAURqE7dOdqaxS4SuefhqMSN4pT3LfBTsw2d65FB0aXt6qZCFbKXBU5+mY0tuf40CeofWJM5XEyW995Z4E9wjplPHI21RQjLI66vgljlvWqgP7WG6Z+Xq6BXWigZKsG8H+dQygQ/v+yIPl9aeSXusfsZJvz/+71y1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbp3Y5e0; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4ddac386a29so605587137.3;
        Thu, 08 May 2025 20:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746761480; x=1747366280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4A2ix+KLqr1uAddQxC8meUMDCd4s6wELmtjquDmWLdA=;
        b=Hbp3Y5e0nNVwKZRE2bWOf/nvF16Oqv6lsWvXkR20NeEYThlkm0kVKIDzPMOOkNYjOD
         dXeKqUS/pN4PrxzDklt748QWkJuq7qCrU/FRmHfqff7MJ7YRcUjkC763BWnd6qZljIuQ
         8LoQmjOY3iY/WdqSv4RZbc/xp1jijCvud0RFYa/jTmP6FZdN0CWxDnspQ9REb82zl/HH
         zJMTDr/bVYgwUSDOVkbepbhek7e5U7la2qHfehDeoVt0vN300J4QDeEWbL8Fyrgye+zG
         0pmm4ebBcLh0Uwwr7CF30Xof3Fvelst96kuzFvyJvm5DhCL4ps0wAM5A6PLdLRD0ETVP
         OX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746761480; x=1747366280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4A2ix+KLqr1uAddQxC8meUMDCd4s6wELmtjquDmWLdA=;
        b=ApLTyUdSZf+AnhF8cphmikc+XBe12TwPKgGwJeEwJPEtteBAn0uBsJznn6MhFsFZQr
         JHVP8WcaYEGMMcMPj9NUgL7FmHFcaR3sXv9ItEb7dTKyREY/G4kp+zAR2/WeT8uNgm2F
         KfFaADG32shB68bYlUCoYZcn8xsNDKDfgubszNFvp5oIM+QTwks8iiNun4tzUh7k5fzU
         xz3KniG0lIsfem6+HywZlJ3jlCfisRQ3K82+4IG9/VFM9rHcLAzc44JrDWhquKlpapjF
         dPy7uksDWvdCS/hds+oaQLnZvxE2N2G2nRanODNgkuREUiSii02cCnW2l54WdYQ8x3/J
         ticw==
X-Forwarded-Encrypted: i=1; AJvYcCWS8Fw3B+iz4LW/AUadfgl5oW3izjj/mObBB/1il+X0utKEjwCertAnW4MQMXT/jXTfsI0iGHvt@vger.kernel.org, AJvYcCX3qcac7BGGECl9sPHwSb+3AxTOokhFOg2mqVTA+F2/b03t1hlYLnm5yo5EQtGrlFwy0jhUcXGWXWpX5l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzojKidh1dG7fIe3oWUCnHNQSStLbsGpGdCohuBpBmgOXR44tUd
	4ugeoRN716ZzUdgElAZcycBqFozQFY9HjW9cY26+3gM6ePlap8dTMbKR1XEu+kwtgw23ffnG59R
	gEllci7FQA+qdC2K3zRC+xvVTx2k=
X-Gm-Gg: ASbGncssZP+m6iwKK5fDCoYWthK5NgMXEagPmc/RdNFUnhY3NzDGsMlggzAqSeGcr2c
	Nxch+Jet8qCNoy09RcqGQs0lGEBuo0S7ZjmCcVPd0AMvVSZDCBsH1v9J/U+h9SsbM4ipGNJh37x
	13gKH4SfdyEQki0dcAiGt0Zg==
X-Google-Smtp-Source: AGHT+IGc5+Cslf0S1acbclvSNhn/uwwmcTG8ZUvvlGJo/X0wH/M3Gq+zbif2xm4TrTenOWf1MumTFqC9O986MUqRF8I=
X-Received: by 2002:a05:6102:8097:b0:4c1:774b:3f7a with SMTP id
 ada2fe7eead31-4deed3d4b5bmr1410263137.16.1746761480413; Thu, 08 May 2025
 20:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509020238.3378396-1-xiaqinxin@huawei.com> <20250509020238.3378396-2-xiaqinxin@huawei.com>
In-Reply-To: <20250509020238.3378396-2-xiaqinxin@huawei.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 9 May 2025 15:31:09 +1200
X-Gm-Features: AX0GCFuxI4KztwbrtFwtCfTebZzuXx55Bo7QyZab2Vhdl2Eshu9OBelft6iLsz8
Message-ID: <CAGsJ_4zrCiugrAPw-aExgSMZXYBBUqLyyWbcpKH8RdhKnHxj9g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dma-mapping: benchmark: Add padding to ensure uABI
 remained consistent
To: Qinxin Xia <xiaqinxin@huawei.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: yangyicong@huawei.com, hch@lst.de, iommu@lists.linux.dev, 
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 2:02=E2=80=AFPM Qinxin Xia <xiaqinxin@huawei.com> wr=
ote:
>
> The padding field in the structure was previously reserved to
> maintain a stable interface for potential new fields, ensuring
> compatibility with user-space shared data structures.
> However,it was accidentally removed by tiantao in a prior commit,
> which may lead to incompatibility between user space and the kernel.
>
> This patch reinstates the padding to restore the original structure
> layout and preserve compatibility.
>
> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header fil=
e for map_benchmark definition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

+Marek, +Robin

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/map_benchmark.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.=
h
> index 62674c83bde4..2ac2fe52f248 100644
> --- a/include/linux/map_benchmark.h
> +++ b/include/linux/map_benchmark.h
> @@ -27,5 +27,6 @@ struct map_benchmark {
>         __u32 dma_dir; /* DMA data direction */
>         __u32 dma_trans_ns; /* time for DMA transmission in ns */
>         __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a ti=
me */
> +       __u8 expansion[76];     /* For future use */
>  };
>  #endif /* _KERNEL_DMA_BENCHMARK_H */
> --
> 2.33.0
>

Thanks
Barry

