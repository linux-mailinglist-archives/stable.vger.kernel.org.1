Return-Path: <stable+bounces-48239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8988FD3DA
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 19:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE625283A60
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 17:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2F3138493;
	Wed,  5 Jun 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nBhdOLxt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A723D7
	for <stable@vger.kernel.org>; Wed,  5 Jun 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608085; cv=none; b=Tn/vZab8t7dGk+vmk8Nh1o6Mlp5Lq9iO0DLMW+v0+9YQqmrZaiWduw2Qhwrj/x1pIRuzxZ0qGMsQmSPr3OmKNUc9x++OudXIpl9cJ8OQS34txmjqweqXAh6s6+k/3dVFqqgPnp01fak9sngp4d8RUMnx9tOMNzz1u99O4RYESFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608085; c=relaxed/simple;
	bh=Tcwq5dn9T53VXyu2UVdw5TjGv2V1CJsT9RFq6hlk9QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNKtZGOHy4No89z+cWxlp7hdZ1d74e2RBSvB9XnsH/ClLuLw4aV/UX4P0+eL/A3Iwd2OHCv3u4oUmlmxmnOcf0kXZeymRTWFI1RQ9kHxqBBebseHq7Kk+u8DixljTkjI6HvlsczgXGR5hNWdGfnEWLozwLn6avbokcSbUAaQcpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nBhdOLxt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ee5f3123d8so5935ad.1
        for <stable@vger.kernel.org>; Wed, 05 Jun 2024 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717608083; x=1718212883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYCo0S4v9XF6m0fRGRV3IsBGozW86ded8JzpR7EngjU=;
        b=nBhdOLxtqLb/6IDbSQ7cbc5oFvALnCWkUFIjJpsMkQMjQOE7dXBUGCuCe0F70vOJTp
         zhzuMjL9el0GaUd0i1WJEHri3+EanWtrRKxyHidjzQ/6xr2O0L2TViyOyN0qBsugfwTj
         s7BOzVznQsc5gt6LIzggVG1PffrMGNOJQJA7unbUKbvQDovJqfLwcqst9FQsGz+3PSfe
         TLQYIoltUHGQjUYDr/ayFtWklpnSuTK6pSXJNMna13LdoLTI7TJ2Yw72OMKZym5NiaFL
         lh0TjaY3qEEj8VMMdZZwvnfvJTPGh3hKLdiDydhLBno8R8tW+5J4LyVpNlx4xBPGKOOW
         /YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717608083; x=1718212883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kYCo0S4v9XF6m0fRGRV3IsBGozW86ded8JzpR7EngjU=;
        b=FUntavDnKcTSyQ+aW5naTdB1WZWGn+5H8Qd3uSIe137pc0mGQVPCkXs36NI/ite1VP
         1X4jXvARIJGIuB6KbMRbzz7lni4wfXOc45kOLwTBugNnoP0/IlFNMOMk/htTOJK5xP6Q
         rUQgkeJ/UiYW+lFLhR1+ptN/L7QDejRg9aVQwZGubKCRWmV2nYnduq5IBxAJmN+IUM0k
         Mh6YlvxtQd3ekWoBcxyBbEDPBtdMGEoDlRK/C6rFlJVDwDWIEEzetb768XTQ11hgzSDH
         R5CpHxCJsFOdvteJ/ldWH5C+bb0X11UGwmxXsrTAffsk0E6Yd/3bkQhS0DB4UGc5tNBj
         ad3A==
X-Forwarded-Encrypted: i=1; AJvYcCUis5Rfx6FZUMjb49k9EBaL0G848SCS5q9M261WbFfXUKukqIv+EQjzgs/fPod89dDmMqNcenu4EQpe80LkE9Jjqp73iGjk
X-Gm-Message-State: AOJu0YwRr2VClfyvHW5ywIAsPOwJMDaVoU8O6bauvnuFIFRQKljHHZ2I
	soQwqh8IbOozFxkn5/8c2nG4bcFcdA9+la+qGAfRxIEu7i3ZocSsbSOdpgj2zlEIAXtKvGqTr5+
	sD7uoafRlN9WN85p5NBijGZUfG+D2bMpCcgue
X-Google-Smtp-Source: AGHT+IE2SZkPszq0YruXeZgdwMZcRiyinGSYCRMCQ+02rAZyYrQw99myRkawq4RdPGWs6JBjFpE5FIBN0Whl5kn7mus=
X-Received: by 2002:a17:902:ee8a:b0:1f6:5bba:8ea3 with SMTP id
 d9443c01a7336-1f6a7b01893mr3570835ad.25.1717608083107; Wed, 05 Jun 2024
 10:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605160848.4116061-1-kan.liang@linux.intel.com>
In-Reply-To: <20240605160848.4116061-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Jun 2024 10:21:10 -0700
Message-ID: <CAP-5=fV+-ytA2st17Ar-jQ5xYqrWtxnF2TcADKrC5WoPyKz4wQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix the hard-coded metrics calculation on the hybrid
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org, 
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Khalil, Amiri" <amiri.khalil@intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 9:10=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The hard-coded metrics is wrongly calculated on the hybrid machine.
>
> $ perf stat -e cycles,instructions -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>         18,205,487      cpu_atom/cycles/
>          9,733,603      cpu_core/cycles/
>          9,423,111      cpu_atom/instructions/     #  0.52  insn per cycl=
e
>          4,268,965      cpu_core/instructions/     #  0.23  insn per cycl=
e
>
> The insn per cycle for cpu_core should be 4,268,965 / 9,733,603 =3D 0.44.
>
> When finding the metric events, the find_stat() doesn't take the PMU
> type into account. The cpu_atom/cycles/ is wrongly used to calculate
> the IPC of the cpu_core.
>
> Fixes: 0a57b910807a ("perf stat: Use counts rather than saved_value")
> Reported-by: "Khalil, Amiri" <amiri.khalil@intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Cc: stable@vger.kernel.org
> ---
>  tools/perf/util/stat-shadow.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index 3466aa952442..4d0edc061f1a 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -176,6 +176,10 @@ static double find_stat(const struct evsel *evsel, i=
nt aggr_idx, enum stat_type
>                 if (type !=3D evsel__stat_type(cur))
>                         continue;
>
> +               /* Ignore if not the PMU we're looking for. */
> +               if (evsel->pmu !=3D cur->pmu)
> +                       continue;
> +
>                 aggr =3D &cur->stats->aggr[aggr_idx];
>                 if (type =3D=3D STAT_NSECS)
>                         return aggr->counts.val;
> --
> 2.35.1
>

