Return-Path: <stable+bounces-192421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A542FC31F8F
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 17:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC653B280C
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215902D9EC4;
	Tue,  4 Nov 2025 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPiZiyt1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573762DF12B
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762272272; cv=none; b=lZeYQLCA927SQ9thWFxxJ8UsajJaECO2vBAyL79POatv89me/ZizB4o5MJk3dnyigxEX/GYOHlGnr2URfbdBeODqTE5Nhwi91jCMUP0XxnXZ4nSKMQKik3lrprSreQguMFtevQiIx9xaQbtiJYjduaCiC9rMhIsDhqiRV4Ug1GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762272272; c=relaxed/simple;
	bh=cQsbTTP0VoK4R1L4J+A3IZgU787+pdz4knMRsMv1nqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpgJ3VhzlIuSIHVmYG9Huc9b/G8x24amGAa9ZQHkl5MwvNUOr7wSpwzX626UVZAsv9i8fNtMUMYS3FRXls8pwjQYPnqE9wK5zsqaGUYPgEeAsFyDXA6N+Q57IquswjV3OBKAGDVKjty+kowbvtuRnd0xCIAr1zQDraE7vV/r1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPiZiyt1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d67abd215so235795ad.0
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762272270; x=1762877070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/PHhKT2Znwu9HseVZHKFx2b7TcR0iwcE4g9dNET83U=;
        b=hPiZiyt1s9tRZjOYlp4tqKdlrosKDIsM5kDLnM7JIq9JnttynUVT8wiqqEJDUhIN3E
         vdA/oqGhZe4EvyeSfMUKA56SjuNKYxnvTPn+whcDFaEEVsIt6qjXV3ZKiQ3n/2Vlm0Hi
         8I6o4GfXG+fR8tKlTfqPxEORut0kKXHOEtvgsWo/v1Dc6VoiNEjj63RLUr6SOlSbWzXa
         KMpwAFYXrXLskQBjhKEIkPYyewV5vMyY5E1KCxj3Ei6wtewPwu+otab92YyDMz7FNJsi
         XfwjuT1o1CzN7P7l3daY8E6flFDyMZCAjwRvikIi3rcwU0EGCysDTm7kn4v5oplcuro9
         LrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762272270; x=1762877070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/PHhKT2Znwu9HseVZHKFx2b7TcR0iwcE4g9dNET83U=;
        b=RYT5wrIQpgCuIdBzY0sNLebT7XAA/uiRFmoPQrE8CCAy7isSJnuhlORl5hMMi6SoFT
         oR+zUSVObBtkyyd2Nk4tlbUBO63exU3l2lXR5wBVlYZCjBofZO26wTHWj7VQee0rVl/x
         nGh6+bYChGURQaBz8XLR8P0CSgvJB5+aSh846K3apTSznhSfsXIkLGIz2iYw5rJtqNOr
         aoh2L7Ib0j+q320Wi2xDkH92L38lzA8sQRJe7in4FI1saqbofNEcDdIpUd1hb85rUmRG
         Ck+Rs3nmUGAWMfqaHqa6YHfhq4Bgdnqt/xWq/ykznQXENsG58GhUvQGq2vMy9Jf1MeU5
         eT/w==
X-Gm-Message-State: AOJu0YyL899nkvlin53hM3351eZ4oGmVpAJWK1NDuNPEHQjeF7Ga/pPv
	hFZyMClzEHPa2vrciIZoIrD85ehyQkwjK04jwF/Pk5nm+XjoOTtVfPd3I+KpdRsLM+++8oCjunA
	Xo4UtorwExEpp4dAFPeUafLnAsNKsgMB91hw+Tc/I
X-Gm-Gg: ASbGncsxZXrKQZkiQOrE/f+AAguGDm+nd2hK0HXfX3/7u9RWHEErbAUy5m1ysQ8xUrh
	HT/GW7lCztFPn3NFz24D3vCNJPj6mCnuIItu80GRj5bg5n+Bfcx9W9BZKPvNkaqAdcSev4vI9Y+
	6YHQYtR2s+Uorq/QVaxF/Oz6Wu+u8mt0uE81cvuwrUOgKD8W9W/cLnceODJ3GJHqraeXouzViz3
	kB2spBEgEGb6WTC9UviGhaCGclsukd3w1dF3KkfiumfTuPAGzINB4V1JS6QCrF+PTs9l6nyZpm5
	fL/r1ritqzgcC+qZ959/immn5Q==
X-Google-Smtp-Source: AGHT+IGjXe6tai+L3bmj9S0kG8kMQn4+Mnswy5DvtApEzkYyuOlzI93nG7iDt8pZcCkMsglV8Abhd8Un3qRdwGulsuU=
X-Received: by 2002:a17:902:e747:b0:294:faad:8cb4 with SMTP id
 d9443c01a7336-295fd8dc897mr4890515ad.8.1762272270004; Tue, 04 Nov 2025
 08:04:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104092740.108928-3-jingxian.li@shopee.com>
In-Reply-To: <20251104092740.108928-3-jingxian.li@shopee.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Nov 2025 08:04:17 -0800
X-Gm-Features: AWmQ_bmkiyFkm8Ccoecp58xI6r2HcrYx5G7YNLVKN7p6ZhL_b0r46BqKLgo_c3U
Message-ID: <CAP-5=fWvawhzhXx72L4iEPpNqeNW+oHQOTkAOy53z0r8UXnMSA@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Revert "perf dso: Add missed dso__put to dso__load_kcore"
To: "jingxian.li" <jingxian.li@shopee.com>
Cc: stable@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	sashal@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 1:38=E2=80=AFAM jingxian.li <jingxian.li@shopee.com>=
 wrote:
>
> This reverts commit e5de9ea7796e79f3cd082624f788cc3442bff2a8.
>
> The patch introduced `map__zput(new_node->map)` in the kcore load
> path, causing a segmentation fault when running `perf c2c report`.
>
> The issue arises because `maps__merge_in` directly modifies and
> inserts the caller's `new_map`, causing it to be freed prematurely
> while still referenced by kmaps.
>
> Later branchs (6.12, 6.15, 6.16) are not affected because they use
> a different merge approach with a lazily sorted array, which avoids
> modifying the original `new_map`.
>
> Fixes: e5de9ea7796e ("perf dso: Add missed dso__put to dso__load_kcore")
>
> Signed-off-by: jingxian.li <jingxian.li@shopee.com>

Thanks for triaging this and the backport fix!

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/symbol.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 4f0bbebcb6d6..ea24f21aafc3 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1366,7 +1366,6 @@ static int dso__load_kcore(struct dso *dso, struct =
map *map,
>                                 goto out_err;
>                         }
>                 }
> -               map__zput(new_node->map);
>                 free(new_node);
>         }
>
> --
> 2.43.0
>
>

