Return-Path: <stable+bounces-121535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0CCA57896
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 06:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BABF3B0836
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 05:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71341187876;
	Sat,  8 Mar 2025 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nwY+Kmhh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136825569
	for <stable@vger.kernel.org>; Sat,  8 Mar 2025 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741412468; cv=none; b=pgEKogOJ4DEYufPTfr1RHOJ8T4Qcu4YH1151XUB/NB1WerWaapsMhBbkc4jvTMtNruBbbM7Y+zYChUZvDhIAZoJKey4wehk5UZWnkPZkl1RcR5CgLCijOqDDgw4JyRJFRAChAss3E52hjHBqdSRdu0lxWdp2gU4DAmyFdp3HhRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741412468; c=relaxed/simple;
	bh=zdInW9/Q0g3TtRuFFjxtdjGT1ntLsubGIabA7azNnF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpEbow1X1QD3kIQbPKnVHlCdX+wS/7xQYcuouQEcGQGW/jdEJMI3GMHeZm6zVln/AMYtc0EQX61pNBERI8PtqzyqZJq5c9Q1kHfkCzV1DAC9B25QNHBdgKfTyv6AeW8PutJQSDARTtLKbn1MOXJxh+latLKg+feftu3M9LBzS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nwY+Kmhh; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so1906255a12.3
        for <stable@vger.kernel.org>; Fri, 07 Mar 2025 21:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741412465; x=1742017265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdInW9/Q0g3TtRuFFjxtdjGT1ntLsubGIabA7azNnF8=;
        b=nwY+KmhhQf+38vFFQEm9kV9LFhWK8Jy3sEka9D99j9X7OvCMtu3G5LFTvQ7+1KjQzH
         /Nbdemw+dU4XMWcclDVOPmrXf9W3wC0af920HfvKjeCFOF7R8ber/KysZfDKdoXN2CkI
         ShH7yGxKrerRBXZxUXmUdBLpxgGhYA6zZcHB7G1oTK9eba6XtPkrujf48o/Kejw0h07G
         xCWoo6IRpMw4KQ7LU6N0XHSekiK5dCcHN6PF6vuSH0C6+KrroEFt9OLekj03mXEHU6EK
         cyGO8KXT5mRp4zx+g3yXu0ln5lBwhr9peFDZq0JmeV516c5UTuoG6WuEMDzL7YqJuGMt
         Xueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741412465; x=1742017265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdInW9/Q0g3TtRuFFjxtdjGT1ntLsubGIabA7azNnF8=;
        b=ITjwtuRJQIrOWMRxKTazT+15yWw3JCWcM7SeU2dVvYz8TSw1oyv6Pfq1O4M8IJiVw2
         WpjQ0+Oz+Wqs06cnWBcFFKkurGIh3SDXeXJSQdLLzgB/uit4U9ObZYCCzZrv/vkti9Ie
         Q0BSmlIJ9uA1r0q/XQDvPV/UGUGdhZeyMvi1+y5u6+0U9Q0ALu48Rkpw321fMXT5mKu9
         TOGYPa5QTC04C9uV8C7vwky4LMWPewi4HvZLRMuPeyirjGxo0qiblE2Fhcyu9xFWHhda
         gX0mnpZ+LNRxh/b/RzALhwx+dvu772bI8wkKhPBrximw9pRhHIeUBJx2HCa7I95mv6Ww
         OB+g==
X-Forwarded-Encrypted: i=1; AJvYcCXIAoTbbLlFKjSzrQ+zHFspjh4Y37mfTy4/g9DOTKdNAhp8Q7mIsjs2xbZ3BbjRD8WTDR0Fp5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTC47O1uINvEyDEfX/jiYhl1YWMbsuHuU0Muh6rfm3xpYa5PjF
	deA8hooO2u0tUYaqA1JOmixMvnFzj0TLm4AGvCtcsugltqfsU3olB095mmtdESiTj6djTenyKKV
	1iy9CC3pcsHlFgMw2W8mmowHzIE+i/WWt6znE
X-Gm-Gg: ASbGncu/rL7LY0VMEEbQUOeDE4bqEHfKXa4RPYjm2BUb4tB+lQEsM/DEhS8svEVyX6o
	pQHAOSg4IHDNMlcdwYHY9G1Har0bKY5jQWO09Ro0tGKck3a2raWy4Es0Jjo/njT7oV/3nB9G97C
	N+EdJXjABNu6/VueNjgU27ZAbV05EWVDdsp10C
X-Google-Smtp-Source: AGHT+IHo2PDDI9I6qlRDO6UBHqyRzd05L8tQZ+VxcalVUvx7hfwObQ0npt6/o1jp9kL48JbYgSiDJElWv/K6VQ8EdhA=
X-Received: by 2002:a05:6402:2791:b0:5e4:d11e:7c4c with SMTP id
 4fb4d7f45d1cf-5e5e24bb58cmr7202371a12.28.1741412464668; Fri, 07 Mar 2025
 21:41:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308011028.719002-1-aik@amd.com>
In-Reply-To: <20250308011028.719002-1-aik@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 7 Mar 2025 21:40:52 -0800
X-Gm-Features: AQ5f1JqHUPD1cUQbwC0XGvEQjFvxgeTUlhoO_RT4hTgIRg1b6omcoJrhiqinDuY
Message-ID: <CAAH4kHaK3Z-_aYizZM0Kvmsjvs_RT88tKG5aefm2_9GTUsU4bg@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccp: Fix uAPI definitions of PSP errors
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-crypto@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 5:10=E2=80=AFPM Alexey Kardashevskiy <aik@amd.com> w=
rote:
>
> Additions to the error enum after explicit 0x27 setting for
> SEV_RET_INVALID_KEY leads to incorrect value assignments.
>
> Use explicit values to match the manufacturer specifications more
> clearly.
>
> Fixes: 3a45dc2b419e ("crypto: ccp: Define the SEV-SNP commands")
> CC: stable@vger.kernel.org
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>
> Reposting as requested in
> https://lore.kernel.org/r/Z7f2S3MigLEY80P2@gondor.apana.org.au
>
> I wrote it in the first place but since then it travelled a lot,
> feel free to correct the chain of SOBs and RB :)

It's all good. Thanks for seeing this through to the end.


--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

