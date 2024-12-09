Return-Path: <stable+bounces-100232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCBF9E9C86
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 18:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C17C1889617
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAC11B043D;
	Mon,  9 Dec 2024 17:02:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F781A2398;
	Mon,  9 Dec 2024 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763758; cv=none; b=N6XBRgkbJhjsBELF+iveD6XnX+wmWHGZwIVHRvqdASpLkw2GIEDHsFpUTzYXaoYq289kQaGwNiREhWGVssWc73N6m9ZRttq7nfVz6Pgbnlu9lP+CouvggJEuGtqPweGVNG1X3eKvrR39uqDFK7O1jdDzwEaVzX+bqs3VukmBMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763758; c=relaxed/simple;
	bh=sYugBMKda1KizeeOhEALvkprU5V9LdkuuhohAMZyGAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOGr05Ejk7qneJP62+s5xDYHZE92Rkhi0DplXVIF34q0jIdJwrU2fgprygdwW4GeZwRWwg12KKA4HLwHi3j/UkhuSFXqjBHm162htbGVWs4QinkubBtHKP9/v1Bl5HPtshkC3bNhjyPVB92na+qNeQJhsrZ/bSybYN9ezZrLNC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fc99fc2b16so3378821a12.3;
        Mon, 09 Dec 2024 09:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763756; x=1734368556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwjgJSd3MeIDynkC5ZNRgIZAv9gD1b+gwZswhdshUZY=;
        b=eFnGY3f+1OGyQkmORjQoHgeiLVRm8/ETg2o+QJ2mANMN+CBScGrluzrHBPAr+FcB4w
         IxQdfgz6JIayoO/g0O24d/PAhJsD8JlRZ/xt0PIhF837qNO87YYSEpshuDATZZ0ywQrb
         8qp3HAKuONTbUwcKnzTtgZ4TOn3q/znYsucfyXb9B+JNJTmEP6Ja03HoCS9OiLauys5t
         50t+gMapzXFbZV2RoGSuzoj5w7MbB5IRRPkZq4tz6Su6TAKI/8fuvNMmotWvVJOR/7/n
         yRlKWOfGO7Dv/1kgapQbFgBQU46ILngPQaE5lg6B5yeGPZgFAnFGUbWQAIHxykMQu0TQ
         0YLA==
X-Forwarded-Encrypted: i=1; AJvYcCVtw5+YpKGDTgEHpVnmDBqg36K1dQ1/vCqM9f13YyjNlu3zXFM+TyDE+ZZlVR6wKU4Yn6e07QPP@vger.kernel.org, AJvYcCX3bluEsM0NAIkoxUG9xwLqIMxspq5dEO2wrRNWowuhkT2Sc/tKnRGfe4aOqRWPtaUmheDN9D8A8ZuB273UD5az0w==@vger.kernel.org, AJvYcCXVJBSYRbvF2K/JxI+raCYjEbnNS/3AwxOTjrxHHm8xpeuDpQ+qH08wEdwyhWP/getulnOR1w50GKN9Uso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqhJdKCFZcoeod+h2mTJwE2pBRmh+kHo/G/+AVWc/eV0pQA3Ke
	+s9/rmqeHa5A2GmfQbBdVp1sjwNJXcDzzOpVMr3c6lDgAhHuxfgNs57jyynrfF0P1KDRmfXoCqX
	0cVzdsRtHYci24zOizRqh3erNxQ0=
X-Gm-Gg: ASbGnct3obKBIIkVylsg50PastZ0hpQEwNdwVP8tOP0AYnA19hCoW1DSRz90TOFFB0s
	ewtBLBaL/TjjzdQQ8s98BIuUDeDMO7jCSchmp1pUJZsW9AjjjHJKFKkJEdhkDw65g
X-Google-Smtp-Source: AGHT+IGhJZpYeaGkXPUwtxE30mRZ4B4esZQZCB4z3tOcyFF5PyDW0RyZd6jmEL4fBVDluKrHefsSLmcVEpoJ3SQZefI=
X-Received: by 2002:a05:6a20:d526:b0:1e1:f5a:db33 with SMTP id
 adf61e73a8af0-1e18712d2a0mr19266331637.36.1733763755775; Mon, 09 Dec 2024
 09:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209134226.1939163-1-visitorckw@gmail.com>
In-Reply-To: <20241209134226.1939163-1-visitorckw@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 9 Dec 2024 09:02:24 -0800
Message-ID: <CAM9d7cgL-1rET97eVU2qpz5-V5XqeCX1N92wTwR5y2sp_4sjog@mail.gmail.com>
Subject: Re: [PATCH] perf ftrace: Fix undefined behavior in cmp_profile_data()
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, kan.liang@linux.intel.com, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, chuang@cs.nycu.edu.tw, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Dec 9, 2024 at 5:42=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.com>=
 wrote:
>
> The comparison function cmp_profile_data() violates the C standard's
> requirements for qsort() comparison functions, which mandate symmetry
> and transitivity:
>
> * Symmetry: If x < y, then y > x.
> * Transitivity: If x < y and y < z, then x < z.
>
> When v1 and v2 are equal, the function incorrectly returns 1, breaking
> symmetry and transitivity. This causes undefined behavior, which can
> lead to memory corruption in certain versions of glibc [1].
>
> Fix the issue by returning 0 when v1 and v2 are equal, ensuring
> compliance with the C standard and preventing undefined behavior.
>
> Link: https://www.qualys.com/2024/01/30/qsort.txt [1]
> Fixes: 0f223813edd0 ("perf ftrace: Add 'profile' command")
> Fixes: 74ae366c37b7 ("perf ftrace profile: Add -s/--sort option")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks for the fix.
Namhyung

> ---
>  tools/perf/builtin-ftrace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 272d3c70810e..a56cf8b0a7d4 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -1151,8 +1151,9 @@ static int cmp_profile_data(const void *a, const vo=
id *b)
>
>         if (v1 > v2)
>                 return -1;
> -       else
> +       if (v1 < v2)
>                 return 1;
> +       return 0;
>  }
>
>  static void print_profile_result(struct perf_ftrace *ftrace)
> --
> 2.34.1
>

