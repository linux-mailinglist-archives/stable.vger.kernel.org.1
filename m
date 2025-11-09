Return-Path: <stable+bounces-192838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE14C43D1F
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 13:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFEE24E3671
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74B22E7F1D;
	Sun,  9 Nov 2025 12:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0xKG8HL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA56B2E7BCB
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762690295; cv=none; b=DuLlcA+P4rSNGt0XcXZDGEZd0Gnjo1n/RPAzGduashf6J1Z6kdrDGuhbAfbppRi+Gzfvv+LBHX7HsXhzylyjOdgTFJg1g5fKXHuSs05y9ztPoKFuRsegNSqs/dJXSKpA9O4jOkVSKsRLUrWEEcmo2PNNdUMSk10pDkNOJmu1kfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762690295; c=relaxed/simple;
	bh=9TrRIYB2XOoX17zzX0ixZst/V96BVzam/k//08+kh8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvv9UHCvPkna/btFUuXXSyP3CU5gNyxv8ZjwPhS5ZpT6xAdJOuT52tYovVteQtyDdKAA7EzyS5YyGKvGKexiKr2/yOxHBcnarp7Do+ZQKMiMeAhXrQu58oE8fMXgDLnHObg/phPFIofpzQ/CHtjvzb16uU8y+0RPyUnnxGJ4EAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0xKG8HL; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63f9beb27b9so1799425d50.1
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 04:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762690293; x=1763295093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaB3iUzdscR6aViyJqwLMcsd0JlvtsbUTPKpewl2qBw=;
        b=i0xKG8HLwJxJQcEyL2ltkvCVpmxagHX06H1+TkaAdLNrdGkDsu5HgIlgaq9FWa6WvO
         778wxQiCre3f4LjyO+5X+h7e2oGY+3U+6VawUd0/AJ9OjFMAmtWQZ4MbfLbB9iUegERz
         DW9CvOugr9jrIMCGEW8xhiR+2sOF00U5VYaYEQLys/WO4lN/iE0SN9VQ5+sus/cjGbk0
         efenTlxYu3lJb/pdai0TMlsKRlh3OwzDOqWSaE0ODACKK5NqMooUynYg6YqmrPSXOh/A
         ZHTpSW/Z+fdsKOxPssK92QFeflKqVutZMvWqMR/hmE3Ubq3hoxXgIiZ6eJEK5uvRuKFZ
         F8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762690293; x=1763295093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SaB3iUzdscR6aViyJqwLMcsd0JlvtsbUTPKpewl2qBw=;
        b=P0DXWqEH//QXtTsVcPUAWm4QYGpmJu3LYr2G6tiug/837aDoPjai8+5OMIxlRzVqzD
         TonCs0zw8YrVA94ulRjk5prtHznuHaDXNVbVQSo3/jkaE2CmVCIoGiYAFgYkfIC836dS
         h0w4GiO4cNVTEWH2N4/ODZ0h+KjceC0Bo1dTahXtzRJinn42uDVKBtdZsBCr/cz8SHdW
         DOPNAsCiGL10TbMslsAjgEXLwEbvroMpcR9QA7RzGp6LUx+/rMCz1tj4FQnmXK20+qck
         c9vKb9zUA7sICv4cyLumTCt9fypFH3K2DnGUJlizus7XFKcIptjLkrVm5hOiKlLTZ/PZ
         wDRg==
X-Forwarded-Encrypted: i=1; AJvYcCVadrBThmZAIkAOf+fo/Ba+QYHkv4eT29lfBauTKQ8KRzG/rfYxSXOoMKNqiILJgPUTXdwDgfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QkrE//MbkHKfhmjbVKyHl9WP1dX3h8bKsczuVmfnWx+jTmpx
	mBFH7zjsN/Rao9eC33l7FEqkDBeCkJ/X3UZ59JrAVvOOsvKWuVveMHkFenuIMNPVyFxNuhermuN
	q3eLNZen7vaiqNNG9Yzhlwshwyo8DajU=
X-Gm-Gg: ASbGncvoO0CACUe124YTqjANwHSsq1S32+7A6TOU5LVjWUjLD+YU7BC6sQRB2kHtPH6
	1nBIqSCcAzlKcY7cb7ofgWCrcTtWQWJCiH04QxKE0sC7+H7FmCx9saww32Z7tZM7bGggEv2qmkS
	+AXo9HiXAo8at28SA/WAzZ7wszDCyjkbh3XQHS1S1E7Frd7YRqpE5LfebLprvrC2zDwm+z9g7Xv
	OXo5R8JDISr048Y9Sai8BXpKW4tSgyQ7hV3nl5sY/cH6rLn4dTLzn/rslak/jj9J2YAYBRt
X-Google-Smtp-Source: AGHT+IEKhjeme65HFe4rbHvn0fhtz0mbKIXocvNQ95paIv/R07SYgK3/Ab1CQi+EtohDNRjUSI8bQbzPh8xSQmFFyn8=
X-Received: by 2002:a53:acc8:0:20b0:63f:aef7:d009 with SMTP id
 956f58d0204a3-640d4543d3emr3526712d50.5.1762690292759; Sun, 09 Nov 2025
 04:11:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107100310.61478-1-a.safin@rosa.ru> <20251107114127.4e130fb2@pumpkin>
 <CALOAHbB1cJ3EAmOOQ6oYM4ZJZn-eA7pP07=sDeG3naOM2G9Aew@mail.gmail.com>
 <CALOAHbCz+9T349GCmyMkork=Nc_08OnXCoVCz+WO0kdXgx3MDA@mail.gmail.com> <8a4aae40-46d3-403a-a1cf-117343c584f6@rosa.ru>
In-Reply-To: <8a4aae40-46d3-403a-a1cf-117343c584f6@rosa.ru>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 9 Nov 2025 20:10:56 +0800
X-Gm-Features: AWmQ_blpVmNsJtsggeQbfkqHI6DRzOvkhrN0Qih5Gjdy_fjh5mvfLp1OZCiTq2g
Message-ID: <CALOAHbBdcq6bKCeroGFmUNfo6Os+KOXGzeqVZjM=S0Q9hpxYew@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: hashtab: fix 32-bit overflow in memory usage calculation
To: =?UTF-8?B?0JDQu9C10LrRgdC10Lkg0KHQsNGE0LjQvQ==?= <a.safin@rosa.ru>
Cc: David Laight <david.laight.linux@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-patches@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 7:00=E2=80=AFPM =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=
=D0=B9 =D0=A1=D0=B0=D1=84=D0=B8=D0=BD <a.safin@rosa.ru> wrote:
>
> Thanks for the follow-up.
>
> Just to clarify: the overflow happens before the multiplication by
> num_entries. In C, the * operator is left-associative, so the expression =
is
> evaluated as (value_size * num_possible_cpus()) * num_entries. Since
> value_size was u32 and num_possible_cpus() returns int, the first product=
 is
> performed in 32-bit arithmetic due to usual integer promotions. If that
> intermediate product overflows, the result is already incorrect before it=
 is
> promoted when multiplied by u64 num_entries.
>
> A concrete example within allowed limits:
> value_size =3D 1,048,576 (1 MiB), num_possible_cpus() =3D 4096
> =3D> 1,048,576 * 4096 =3D 2^32 =3D> wraps to 0 in 32 bits, even with
> num_entries =3D 1.

Thank you for the clarification.

Based on my understanding, the maximum value_size for a percpu hashmap
appears to be constrained by PCPU_MIN_UNIT_SIZE (32768), as referenced
in htab_map_alloc_check():

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/ker=
nel/bpf/hashtab.c#n457

This would require num_possible_cpus() to reach 131072 to potentially
cause an overflow.  However, the maximum number of CPUs supported on
x86_64 is typically 8192 in standard kernel configurations. I'm
uncertain if any architectures actually support systems at this scale.


>
> This isn=E2=80=99t about a single >4GiB allocation - it=E2=80=99s about a=
ggregated memory
> usage (percpu), which can legitimately exceed 4GiB in total.
>
> v2 promotes value_size to u64 at declaration, which avoids the 32-bit
> intermediate overflow cleanly.


--
Regards
Yafang

