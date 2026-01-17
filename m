Return-Path: <stable+bounces-210179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3333ED38FF8
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 18:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64DFF300E3C2
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F69258ED5;
	Sat, 17 Jan 2026 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh5cMTWc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21141DB356
	for <stable@vger.kernel.org>; Sat, 17 Jan 2026 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768669730; cv=none; b=DS7gG5gs7CkVbdbmZo6zw06egKGeE0Zpl5ZuWMFnAm1Mb/v+DRlGpZRcHo6aXngAbM5NufOyK+/MTFKEvXLoctjHvzBFhc+dKHG964QyNaL2ZTOQa8fwfxJOI4J/VcUKdIoEhuoQPoEJDLvFxw0pnL66eFyfTbHFhO3ZVnLm5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768669730; c=relaxed/simple;
	bh=aEphG+uJA/ZTSP7N9fDLUX1nKXTIImKyAsN5fw6sI/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UA0PNK8f9tfOemXujoXSVMbxMbdjbwJSCK148xLoLuLuBHa6UPi801H5sd5V/J1Npt2OYdNnP9qqRc6RgGXmPhA8D28qUHh0cPQ2LjPY4hu8j5oXgpeh/zm4z4AfhH805/lWzsk2V0CsauEV9UihL089xmniKIsONmZKK/WEeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jh5cMTWc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432d2c96215so2495201f8f.3
        for <stable@vger.kernel.org>; Sat, 17 Jan 2026 09:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768669727; x=1769274527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEphG+uJA/ZTSP7N9fDLUX1nKXTIImKyAsN5fw6sI/U=;
        b=Jh5cMTWcf/PuohHXUzClWNXU8xyKtRF4C7svwOvUH6+YLhwSeibubG/X1MBh7fTaLb
         +P7jfKr3d+ipzRav41vilQh3vYRl/Ezm54zWUulE+9eG+11a1V6vw5RguGg8nMue8Y+j
         KIH0d4aoXUDAHT3wNMdGqC48rGd4HinoKhbNcP5Pnd9sBJbRpOBZ7rc85W8nb6WBHGqx
         FEceW0izaPfeaghJujrGb3O7ZCnBWJUIQvgvrEdgznP6zadhn9S1FLAu4tWojxHoNnNy
         qodX0ln/g2EDQVW6E4zZ2ULfA56Bvl3PyUm2oqmAzPMs4ujFuW9gsCst1z/LpjbG2BT7
         q7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768669727; x=1769274527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aEphG+uJA/ZTSP7N9fDLUX1nKXTIImKyAsN5fw6sI/U=;
        b=v2UcOLyVeiZjAK00x/hb3VLOw8SjsgZNfZk6jF6++m64YH9q4g1xPbHrU0in+NznQ2
         P3bKb3gwYxbTopa+mYsIgTjY61ltxvsArBbGKXUcwFJT+qELfy48tuY6Wh5Q8oT0WNXk
         p5VGFdzViY9jJSxTUptbg2tOPM3wH6t4EKS3dZ0gCPz2oUbfkwHgqEfQMkMtSpA6NfXQ
         Xb7b3qD+n3uNs14miV5+Qzr/Nf+jO943/yQr1hJ4IGL6hw7VbZ/Xc62UzQGlNykZ0EIm
         +e6dX9jLCCnfp6EcbCTlN9fTNEoh9bmcP0KdihLHgI4gRvUyxPWj+d5m6549t1QCWGAB
         tpUg==
X-Forwarded-Encrypted: i=1; AJvYcCXci1x5NLl8FR1k8AH2BvEPs/o9qIQgUimRdw7rbwE36AFR9zgIsk4qDtJ/jq8vMCP6KDpi4os=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAWJKlFzOtivHCJy/NEyer0GdM2Zbxo/N+1idlQuCdnJqM3fa
	vVVTGMXSbXmxGLBTreBXw/rQIVBLAVi+cycx6O/3ZdmSUCx2UVHeJd+bJzie+6AKjKMe5Ef0qMY
	OYIBla2wtCkeg8H/i8eP+bLIgMX6Y/hU=
X-Gm-Gg: AY/fxX6VDnGLS2r/T3kEeF1W9IyfKO7ORn71W7uU7nVyPgRAGjBbHijexI+HLawCUO6
	fPCL3MHXa6aVyZo7wHWlwuOvB6HfGRA6OcnQEY4tJtYfrGvsKxRV8hwcAreyslDmBzC8G1A3qsk
	7b74fsow1z2NqqampVgDVARAPgmNJF0VQc+tuRtfkCiOa8NgyKz3j2/TF4qaWVpsgGqopQmphTt
	H26VNf0Z42IT8K80q08NzBYm0iR86H4Efjwv2410Ix4trg6ZelzLyspztYVulafXo+z4PnpE1TG
	zIvi9mZcsP2kMKIZriXkSypQZexZyA==
X-Received: by 2002:a05:6000:2910:b0:42f:b3b9:874d with SMTP id
 ffacd0b85a97d-43569bc4a81mr7718897f8f.37.1768669727114; Sat, 17 Jan 2026
 09:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANP3RGeuRW53vukDy7WDO3FiVgu34-xVJYkfpm08oLO3odYFrA@mail.gmail.com>
 <20260113191516.31015-1-ryabinin.a.a@gmail.com> <CA+fCnZe0RQOv8gppvs7PoH2r4QazWs+PJTpw+S-Krj6cx22qbA@mail.gmail.com>
 <10812bb1-58c3-45c9-bae4-428ce2d8effd@gmail.com> <CA+fCnZeDaNG+hXq1kP2uEX1V4ZY=PNg_M8Ljfwoi9i+4qGSm6A@mail.gmail.com>
In-Reply-To: <CA+fCnZeDaNG+hXq1kP2uEX1V4ZY=PNg_M8Ljfwoi9i+4qGSm6A@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 17 Jan 2026 18:08:36 +0100
X-Gm-Features: AZwV_QhGpsGfhcwUuOSjH1-DI0GRyW2mW52xb_iVw_QKkxgQTpbCVoSbyZvTIyw
Message-ID: <CA+fCnZcFcpbME+a34L49pk2Z-WLbT_L25bSzZFixUiNFevJXzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/kasan: Fix KASAN poisoning in vrealloc()
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Maciej Wieczor-Retman <m.wieczorretman@pm.me>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev@googlegroups.com, Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, joonki.min@samsung-slsi.corp-partner.google.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 2:16=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Fri, Jan 16, 2026 at 2:26=E2=80=AFPM Andrey Ryabinin <ryabinin.a.a@gma=
il.com> wrote:
> >
> > So something like bellow I guess.
>
> Yeah, looks good.
>
> > I think this would actually have the opposite effect and make the code =
harder to follow.
> > Introducing an extra wrapper adds another layer of indirection and more=
 boilerplate, which
> > makes the control flow less obvious and the code harder to navigate and=
 grep.
> >
> > And what's the benefit here? I don't clearly see it.
>
> One functional benefit is when HW_TAGS mode enabled in .config but
> disabled via command-line, we avoid a function call into KASAN
> runtime.

Ah, and I just realized than kasan_vrealloc should go into common.c -
we also need it for HW_TAGS.


>
> From the readability perspective, what we had before the recent
> clean-up was an assortment of kasan_enabled/kasan_arch_ready checks in
> lower-level KASAN functions, which made it hard to figure out what
> actually happens when KASAN is not enabled. And these high-level
> checks make it more clear. At least in my opinion.

