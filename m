Return-Path: <stable+bounces-126788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31275A71E6B
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 19:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8086189AE69
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 18:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC3253331;
	Wed, 26 Mar 2025 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzWfP5i0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65EC253340;
	Wed, 26 Mar 2025 18:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013652; cv=none; b=nfLK41IWmNGrdozxmNr35X/suwZh+X+ja4CHaKW6w16EbPvT9LPjyYBIuOlHHMaMx/MLMnWupkA+L93lJJcNQqI2FNzZL/z9tJektzrlzGeViVYrX7u5wdCcU140y5VJwZH8NWZi31FEig5TJL9I9QsIHh2lJdC1lDGDaOhLZNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013652; c=relaxed/simple;
	bh=WmQEkXsfznu8w+rBf6ZgS1QtNrnadeHs+aER+P43DfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpEdXNv7vWjUnIweyIEzSOwq65/h5neZXeRSCOdrsiPZpSXaITuHmNOC5QqUkOpPj4wDXGF8RCcIEURVkAfO47CudT0Al+gVOqLJ0rRE5lTp6Sy5InXLSHq/jNzJI3qkx2HaJ+XGvXG0j+L0gpzqPPBATSTWGLBUqrblYxaBrkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzWfP5i0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab78e6edb99so15270466b.2;
        Wed, 26 Mar 2025 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743013649; x=1743618449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwZ/kZVKA3ly+94BX9Iupd7sb0MCbfiMrJTL+cNfKIk=;
        b=TzWfP5i0bGxBcueEf8oRLjHNjbdR+XMkxXB0lJa6wjvCSpW46Fk6wdyq/7DUnf1m0K
         B37yRJlWv7b87wuvnsClNMuk3qiLiwqTnVVSvUWYD9iH3i31y7Gk19KmRtAx7EZOcl8S
         vR2ycLStbGLNdb2CR/Dv5zakpL65cXUkxxgKlLJlBTA+ktBcfJ6ksEiKbEV28bCtJ2rX
         pLl39zF/eC6gJCXaPIQ0ZnNwDV0YV7LHvPv4zUw8yPNbP8DAqHGGmzmEZanHV119ZQOa
         BfsBo7tmEtf40mT6qh8mUthgvas/MmpElgNtFfNBSUnvqDTIQ35Kr3aFOiPr+LkjvFku
         /TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743013649; x=1743618449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwZ/kZVKA3ly+94BX9Iupd7sb0MCbfiMrJTL+cNfKIk=;
        b=YudMKusVtUdxLNKkcIvOGJN1eFIUKeDJDviLqPMHYUHo57O5e7vuDGGS0ofHWKnjCe
         ZbSWOH1eCFFPUgSgHxNaMQOEdjudz3FHGcPmqa+Fu2qeh1SUbIS8jelWlaQorB3HxH9p
         9aXVCCfRKw9aBVGCF2EiYNox3ppgdBqS0QUAPdEnfUS7ob7PFmeu5QxKQ5unT2+6dhcs
         4f1Qa8uG9mjQlbMnz7PRD/1iASN7tH5/pWi0Lp/pbkUeVz55XmL6c+WBVOOLszHbsnrp
         jrbwGgxEgNzUH+WwFZjcngb6NWpyTXLycBOQDlVi1c/4Sk6o3UqDig3aE8Clp5mSRsL9
         Sb6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDO1LXHRuMcHnwdg1wg3ZHBNENlUWhjVSNWh8uYtTNEKSwWnGE9B0GCl/QorZI1Ynf+XC+JLyqdht7J7UTILY=@vger.kernel.org, AJvYcCW99BqDojLkmFnpB7jUD8rC/Wt4K4qHQGY4yPQ1VLhGJMBvbcAyVpGvQ+DhFGvGzbClE/rbiANj@vger.kernel.org, AJvYcCWkO7nyvTnIetnJR35zG1p+oIm0FAFANAMK/2jZcpkg8gC6lBMrVHzAmtzEfFEz2qmTIO1ZmG0vsMQKujUl@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBngO7QoE2ypS8F+7a8feYpKE1i35qI31aNAegs8ncSVpC1ht
	qDJT7lq4fvGu/4alP4gPrv2YjpS18mf0QNqAskVWCkJCorbN22cjvhoWAcFUjPlimZbnhw8hOPy
	6AOpEHzrG0NP+jIoUN2a8+oUwK5I=
X-Gm-Gg: ASbGncthx8P3IyLHU74jfe3cOjn7dhqYAz3TeM2mYI14cTejbUh1q0K3vcOCKi9tucc
	rLDECk4Ji5kdeqxiyjyxgIRTD97YF9UKBokrOWkCfhDIJahESqrXu8PlcHTviRtqj73LTmR0nwl
	yd5EArYoA7gZFVfiz+rCfStkiB7A==
X-Google-Smtp-Source: AGHT+IHEdBI95BIvNnCvD45NxkwA9Jfkjd2N/HbrhhEJ2QD36+kiqZsHBQL6YYQBJvkZKUHnv2ISqLpkZVcqd7Q0+Sc=
X-Received: by 2002:a17:907:94c5:b0:ac2:84db:5916 with SMTP id
 a640c23a62f3a-ac6faf0a6a9mr43494566b.31.1743013648829; Wed, 26 Mar 2025
 11:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326-string-add-wcslen-for-llvm-opt-v2-0-d864ab2cbfe4@kernel.org>
 <20250326-string-add-wcslen-for-llvm-opt-v2-1-d864ab2cbfe4@kernel.org>
In-Reply-To: <20250326-string-add-wcslen-for-llvm-opt-v2-1-d864ab2cbfe4@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 26 Mar 2025 20:26:51 +0200
X-Gm-Features: AQ5f1JpKCzAXQfQrm4wlizX6k3LQpGAsnw7BZMrTEbEqg_iMhTRlQx6b_DF8dWw
Message-ID: <CAHp75VfdNcQKCza0gYMg_hKAbZK_J3uSwZsoTS5-Bbt5_P5HPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] include: Move typedefs in nls.h to their own header
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 7:19=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> In order to allow commonly included headers such as string.h to access
> typedefs such as wchar_t without running into issues with the rest of
> the NLS library, refactor the typedefs out into their own header that
> can be included in a much safer manner.

...

While the below is the original text, we can reduce churn for the
future by doing the following change while at it (no need to recend,
maybe Kees can amend this while applying):

> +/* Unicode has changed over the years.  Unicode code points no longer

/*
 * This is an incorrect comment style. Should be
 * like in this example.
 */

> + * fit into 16 bits; as of Unicode 5 valid code points range from 0
> + * to 0x10ffff (17 planes, where each plane holds 65536 code points).
> + *
> + * The original decision to represent Unicode characters as 16-bit
> + * wchar_t values is now outdated.  But plane 0 still includes the
> + * most commonly used characters, so we will retain it.  The newer
> + * 32-bit unicode_t type can be used when it is necessary to
> + * represent the full Unicode character set.
> + */

In either case it's fine and not a big deal,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

