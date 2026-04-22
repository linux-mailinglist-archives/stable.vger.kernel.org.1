Return-Path: <stable+bounces-240269-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB02AlZH6GnjIAIAu9opvQ
	(envelope-from <stable+bounces-240269-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 05:58:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E4A441EB1
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 05:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 880F930297B3
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 03:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B634739A058;
	Wed, 22 Apr 2026 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TcnKmgUE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B9D19D08F
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776830287; cv=pass; b=kNWbMGPPY0KGn0AEUnIo3LBm9mWOFcD53K58dXrr5XXN21VYnocihI2zZ7+I631Fu2UZvopBmHB5lSePeYPwC8JBEk85Kg9uNlZ6qfL+UbwlWu+i9bZN4sjBvRcSe9YacKwHPFq5cd2VbSnVjDyuJwm+94tsyEBbF7iZ6PIO5nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776830287; c=relaxed/simple;
	bh=5GJsF08pQ4paFemCsTpWN6URgMlZJlEsZk5kOl6oVVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhtZZQ9J6KDSysQ/fCzrMolJ3n/OkJUqgVnyJjOpd6qJ7lL9xIEmMwf38T39uNHEU+FkFjTwVWuRR1Taz4Thxr0ToFUnmuxf02ud8PpHMQkZMl6TuRe4VSoJF3v5EDDCMQjMezqgen8E5RxrR8dxCiB9eBMuhSDj0ImNXKEH/6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TcnKmgUE; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso341325ad.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 20:58:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776830286; cv=none;
        d=google.com; s=arc-20240605;
        b=by0KRFvw2T92jA4oN9ssXnqrV1qGSRCgHkajjUe+RsNVq3HRyeltuuXtsTty9cC7Au
         bG2rJC0w/fvBkqRe0wY35Lst9c4YusmpCzpqHcV0Xl1mr4UKXnt3h3oOoLKN4o1YojD9
         +FVtLb6lNpjx4R0mhuXM5oMCM6RWSkkQ7F4a98uhqRfm6SSWJ6LWVrjpFZzMXinSUjmZ
         GYXyuwCPywvRyWi1Ngf5ixyOsQCYVbGh6+01999AnCzbTOWaWIlvpjd4sJcK/ArSj+QA
         PJX4VgYPAWlSyMILbrxYjjA5oKF1PW1VoGt+Lh4fnmAiNErlGrf8AOLK6gLEhbUZk6SA
         4gfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3vcY4nYueHrKZZVkH9OI6RsVYJ+Oz/SvjOA/ZYvuSpk=;
        fh=Gg1K0NtG2kBQh2MvMtDjg6sGRrq2XQ+OAa+UrdoGCgA=;
        b=P0YKVZwvin9NRiW0aKi7ZOdeSurFmNi7yR/8T26254WjvEZUuACoYfR77PjcOI8Kyu
         RCBqfpFZN1xZm0hxgnTcxDVvlTqvntFu48fah+GYBIz3c9uhk9ODJK7qxyFojdSEgrQw
         Ix2jeGyEHTrm6L4NdV5ovGZR2fCr0HUwN9Kl8iGp4PWj+U02DL4huTmAoqUta670cmie
         m1WYHaTCZkrmg3zYn8ICzposRs5TOjIDV7XL1L3pEL1PmJEixhFePcQd3NKgkR83ecx4
         Ii71l1VU7UlsElDX9lKo6aJtl4dFgwYzptrkRA2GutkQgMtjnaRInChEF0iEUZZUPoNH
         udXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776830286; x=1777435086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vcY4nYueHrKZZVkH9OI6RsVYJ+Oz/SvjOA/ZYvuSpk=;
        b=TcnKmgUE804Im54iq5k+0rNI8BlfgWgdjX4MrkX6gPlwGAt6z6l+ADTdXxHSliEtPI
         pVFQMUqCJLAJfq5ON4qDJuZNAWgkfxPRd21PFzGHqq9e19S0lt624PDs+icg1gK9EmzX
         xTypPGQWBYndUWyjH5z/QTlszo14tpVhSs9dFAI+TnrqVkgIdRjCnoXoMT7zhtqMHvjl
         Fofz/6WIG30Jdm+zbpoDNw3lQmvvO7XIik15AYaPCdvxdhg3G5Y57RZjARokXi+277ek
         Te5ghPU2YnPNItkwfgj8uv4xX4aygSXvOKVfVBFgV/K/Ig9xdbN5YE1KBx7T9JDtcLEW
         iaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776830286; x=1777435086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3vcY4nYueHrKZZVkH9OI6RsVYJ+Oz/SvjOA/ZYvuSpk=;
        b=XK+JcG8YH2IjXvMpDhaDUiBzX8QP8qFaBRxrpUKtmkQSIz0dieg5l4mtbX3t4NpsUn
         EEnwkkqa15ubSgRZvC3mKXaF3/TYbH4OHgCX7xaZjQ1uSv/wF/ELgjxPbwGvqgt6hZ72
         9wWXYEQH61u/l2FP/Spo01D/WpX/A/w8JHuEuz56vbEo5SvK6lxAQU0ggmrK2RTZnTYH
         adCoWuUlAGJJT91W6jpTeHD9nq2vxEDFrfl+NvwF9q8kovhf97rlhq+EUEP0/3VoycBT
         r7Y3E53OT600jxgyeDYqzkjCYy9653cPCOIA/61FbTodeHyCHXecE+N0UKCdWjx3tqQ1
         KIwA==
X-Forwarded-Encrypted: i=1; AFNElJ8mFDZbsehNUeZIK10J1TM/ItFO3teEvp6pW3XilsQNYZ5mrZdXjajer0d+HMvm/a+X9sVzEwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7X8vwmurrgvRWHjBLLZrcJ8ZKIRkmhZEKdKv6yGpxatl7muof
	oqCNaIxdstYq7a3ixI+QvX4dPI/MT3DNaNfXqbMfd367c48AlZmOu4F1rKuiQs4q2QhzSFBAcPS
	3Gv/89diJwXSViPcuvQar1Hn+xuY4nFOOQyse3wqLSzUWM3DeVpKuODB5
X-Gm-Gg: AeBDiet5x9W6KXiYA5mQgWTc1p799pWbYeSgPp4U9quUr48c1h6WJ5pt3EOVi2HP8L9
	jAxLO570lDBxJGO+EXts+qn2UO1hj0VHrrcmwVW0Nczy5FHzscFTUM9B4d4h1txaIeEMAvbhw9r
	TAQj/IpFrysT2G/JTNohnh5aFKfMkRFrTjxf5G2VI6kGsm1clUwhkDWveiuAwhrwP1MP3cu/jml
	fzg6mCIF6tQ7jP86xyuVKKhjiVi07SqKSY3BabeAA8EcuDoyM3D13xut4P3ZMhg617kaW9eDEP1
	j+B7nMabjn9F8peoxIOsjwf61bnfIg==
X-Received: by 2002:a17:903:3c25:b0:2b0:7a9b:82f3 with SMTP id
 d9443c01a7336-2b602f29b8cmr11673045ad.8.1776830285187; Tue, 21 Apr 2026
 20:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420163222.23517-1-k@mgml.me>
In-Reply-To: <20260420163222.23517-1-k@mgml.me>
From: Ian Rogers <irogers@google.com>
Date: Tue, 21 Apr 2026 20:57:54 -0700
X-Gm-Features: AQROBzBstMSbYsgzkCg7_5Jl2E-TdlnEQEqq7tZplAslGn5jZ5R7E3duoojwy2c
Message-ID: <CAP-5=fVQS=otsfMEtZNHixairsG3=-mr=+fepBpjSs8JbbnHyw@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Revert "perf unwind-libdw: Fix invalid reference counts"
To: Kenta Akagi <k@mgml.me>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	linux-stable <stable@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[irogers@google.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-240269-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 73E4A441EB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 9:34=E2=80=AFAM Kenta Akagi <k@mgml.me> wrote:
>
> This reverts commit eddddf4ed7f69697cb54e714e773f764c8d3b67e.
>
> Upstream commit f815fc0c66e7 ("perf unwind-libdw: Fix invalid reference c=
ounts"),
> was backported to v6.6.128 as eddddf4ed7f6.
>
> However, this commit depends on map_symbol__exit, which was introduced
> in v6.7 as commit 56e144fe9826 ("perf mem_info: Add and use
> map_symbol__exit and addr_map_symbol__exit") and is absent in v6.6.y.
> This results in a build failure.
>
> This is a revert of a backport, so there is no upstream commit.

I confirm map_symbol__exit is missing in 6.6.y:
https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/t=
ools/perf/util/map_symbol.h?h=3Dlinux-6.6.y
but present later:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/co=
mmit/tools/perf/util/map_symbol.h?h=3Dperf-tools-next&id=3D56e144fe98260a0f=
8a17326993ceb576ef859ed5

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Signed-off-by: Kenta Akagi <k@mgml.me>
> ---
>  tools/perf/util/unwind-libdw.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index bd027fdf6af1..6013335a8dae 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -133,8 +133,8 @@ static int entry(u64 ip, struct unwind_info *ui)
>         }
>
>         e->ip     =3D ip;
> -       e->ms.maps =3D maps__get(al.maps);
> -       e->ms.map =3D map__get(al.map);
> +       e->ms.maps =3D al.maps;
> +       e->ms.map =3D al.map;
>         e->ms.sym =3D al.sym;
>
>         pr_debug("unwind: %s:ip =3D 0x%" PRIx64 " (0x%" PRIx64 ")\n",
> @@ -319,9 +319,6 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *a=
rg,
>         if (err)
>                 pr_debug("unwind: failed with '%s'\n", dwfl_errmsg(-1));
>
> -       for (i =3D 0; i < ui->idx; i++)
> -               map_symbol__exit(&ui->entries[i].ms);
> -
>         dwfl_end(ui->dwfl);
>         free(ui);
>         return 0;
> --
> 2.50.1
>

