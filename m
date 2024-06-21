Return-Path: <stable+bounces-54838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB5F912C6C
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 19:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5841C20F62
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EEA1607A1;
	Fri, 21 Jun 2024 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujsUDzi/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C929D15D1
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990835; cv=none; b=WgCbCduK2W5yLvbHljZ8FopiZdoO811bnWDB5Amq1TQePcd+oUe/hr6q05p3A1hIpHmHfkE+yxGPhaMy6mGp2FDuzxnkbPKu09NKFDjCUxItOIbzKx12dWOGFW8h2PAWHu4LhJ4aOsfkEzqpxAFZdUblmpGz3guWbApuPmu42xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990835; c=relaxed/simple;
	bh=wiGpqyGq0pz+671ybpoV6GcrH0nBUI9hmsIPKIpFk80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6qeLeiPGvIR4pykKxATyGsw/4tKHlWTEJGtZIMEsqaWCfbs6Z7Ixq0Oq53VeJM60Uawj5uhqPvM3HRc5Qw8pNrTEHiLCYjF+rWRidNd7O0GdNd3Ipga8c31lxDG2LLF2lbdWpXr48oT6IawSH8k9mvtJ91TT7ARTY7coHJShKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujsUDzi/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso22712a12.0
        for <stable@vger.kernel.org>; Fri, 21 Jun 2024 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718990832; x=1719595632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZEECrhQjBIpDFBsE7AD3QeFYzB3SERdZGpooJJm1Aw=;
        b=ujsUDzi/HwvcPF9/soVwA1ZwTO9rrjQovweXrA1bI6bylpMtysyAJjbHaaoOjdA8XB
         kaLrbhq5iESUHzUkouXVZdHweK1fTH4ITk8bldzbCIL26TfqJK4Mh/Q3ROzYe0xRdp4S
         7MfbSo5nns01rrxxGzBPD6RnfNcmNPoof6tSHqCU73rLFBzGuUGqVQ0hoNa/vq4xUTyi
         7V1dembfL3fa/hZcMEI4CRI8S71Ap9+P4boZaxKXtEgYS6OrfSvPn6Or5hLwrVOQv0hY
         3tlZK36UjP4lubBKEaeUNf2nGD2V5RVyjm96fQgsh0rUHL3E8ceH0g9RxeJlMbc6aLAW
         Rzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718990832; x=1719595632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZEECrhQjBIpDFBsE7AD3QeFYzB3SERdZGpooJJm1Aw=;
        b=BjvDIALSyN7TAx8c8Ddqdu+UIhvdCWZzH872C0o7PKiOZPx0eJnNWKHztxd+FUeLya
         El4auVSxssp+CjrMgjIHbG7iLoGkmta3PhFXivFNiU6VSPmbQgikuOci/MRNiaDSwiMN
         /EpBmcQkQHOiofiwFlpiLWsAau39yuWcd41Y8/mikC1XG9fVaPDqx/pJJAZwx35Cmn1g
         cEq1CRWY5dOgzGoMCjQK+lrS2y58GRWfClBmohJv3yR3n9dQfVfCUQpKl0tmQ8ppTDXQ
         zzfs3ElrX1f5dcyjBJ64K0YR8aN4RyXQqRc/B3jPrZ0uCAISuAS+6d+O+oCJsIneOlo5
         QeNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVluCmqVPZ+77A7GlTf3RSdBLxGX8IIYusAGsoRZIye+GoewII1s0gWadkNQqJeyS/UjD1EzayngmNY8p86AHT1juJnGrVM
X-Gm-Message-State: AOJu0YwM0nvqwFhjf91zuSe93oxKI2XwXHTxL1af50lhpnGSni6paPuo
	hkQ/aRFttO8hkmUbK7gCjqG2ug9VSeNvtHsIOs0Q4dqwiGySvRbtQFSKAR1rCMWw7pfiry5jlZX
	IefUiHAg9duMLD7PIo8RuH4RpKzjyiVdmBf/P
X-Google-Smtp-Source: AGHT+IF6tEiRT/9KGWlVNCP+9uwkKC3MsFDZH8IrIH6duITWkOQqgznDYKPEamEZ2wZ//k6/c8eXxVE1ENPTGHesQ7Q=
X-Received: by 2002:a05:6402:35c1:b0:57c:fb0f:1355 with SMTP id
 4fb4d7f45d1cf-57d3f1db8b5mr34243a12.0.1718990831973; Fri, 21 Jun 2024
 10:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621144017.30993-1-jack@suse.cz> <20240621144246.11148-1-jack@suse.cz>
In-Reply-To: <20240621144246.11148-1-jack@suse.cz>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Fri, 21 Jun 2024 10:26:34 -0700
Message-ID: <CAAa6QmRdzoMuf3PyLcYP1X_uQAWj9_1mB0oD5dYpPT4hJqFHBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "mm/writeback: fix possible divide-by-zero in
 wb_dirty_limits(), again"
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 7:42=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> This reverts commit 9319b647902cbd5cc884ac08a8a6d54ce111fc78.
>
> The commit is broken in several ways. Firstly, the removed (u64) cast
> from the multiplication will introduce a multiplication overflow on
> 32-bit archs if wb_thresh * bg_thresh >=3D 1<<32 (which is actually commo=
n
> - the default settings with 4GB of RAM will trigger this). Secondly, the
>   div64_u64() is unnecessarily expensive on 32-bit archs. We have
> div64_ul() in case we want to be safe & cheap. Thirdly, if dirty
> thresholds are larger than 1<<32 pages, then dirty balancing is
> going to blow up in many other spectacular ways anyway so trying to fix
> one possible overflow is just moot.
>
> CC: stable@vger.kernel.org
> Fixes: 9319b647902c ("mm/writeback: fix possible divide-by-zero in wb_dir=
ty_limits(), again")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  mm/page-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 12c9297ed4a7..2573e2d504af 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1660,7 +1660,7 @@ static inline void wb_dirty_limits(struct dirty_thr=
ottle_control *dtc)
>          */
>         dtc->wb_thresh =3D __wb_calc_thresh(dtc, dtc->thresh);
>         dtc->wb_bg_thresh =3D dtc->thresh ?
> -               div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) :=
 0;
> +               div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh=
) : 0;
>
>         /*
>          * In order to avoid the stacked BDI deadlock we need
> --
> 2.35.3
>
>

Thanks Jan,

Reviewed-By: Zach O'Keefe <zokeefe@google.com>

