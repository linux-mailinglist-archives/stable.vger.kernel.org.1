Return-Path: <stable+bounces-192798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAF2C43792
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 04:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B123B290C
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 03:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B1913A86C;
	Sun,  9 Nov 2025 03:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmIuom7H"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20429A1
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762657272; cv=none; b=XoZ0hpixEHhJkypIaw43zNiwNrvIfYVqeqJiqZRzaQXS8LrB61CJIUnQqnrmmNZKidGlqVflydEzvhKqXciUVbRtV2EYJg4r3t5SCdJakFqP6RWPi5HkLc1CFca6GceHvQwc5VALJUqefBW9H4Q5gF5v50FmWnDT2MTZ0WcvT1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762657272; c=relaxed/simple;
	bh=qESZOs7qVRRXh6bJdptBB7hTiAoMVKJFzBaPoCkk3EY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N1fVA7VOdgqkmok+pFUIR2Uc8PSJ1zV9J2uWtjtDpnDPZB5mJn4cwJzg48NWM/KfUYVAn/aU++JO8kKMivmln8bb1g5RSGQibRbZGB9oB4ncRu0vCUxe5ASZhxyhFDe3gX1pb1bZ6fZy/eu2v7lDEanxw1RrnUaD5gpH8j1J/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmIuom7H; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-787da30c50fso5715587b3.3
        for <stable@vger.kernel.org>; Sat, 08 Nov 2025 19:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762657270; x=1763262070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6DNnuqiLsyZO9SJ1ruoojCJDemUC0rmD+JV8URPIgI=;
        b=kmIuom7HWv5Bw3LKWVZzRD70GEbWouljPMMw3bkvJX2DiBvWEjpum1E3ODjEAe026c
         ToSXkTv4VBoDYU6JzptKBIn0iM6ngsgZZFOvnLXH9FaqA6Jwgu6qvE4ikHRQxzZPV5Nw
         CeUp9Y/es4e1VsWIMZtvfSc7YRsjFzEZXH8Lxuu++tX/9g6nFUeEsXav0x1Ox87DfvK5
         C60uDeX+PgzJjVsUbcTw+gCW+or976Yv5tToowvIHmvKETm9VyiOHhgIFaDcgfRJ44qD
         MuRK8X1vr31eErv4HL6zoZi4R3iIEdVfbIATpMdTLEptNnExCIWqpiMy7XC9O22Sc/m+
         5aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762657270; x=1763262070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e6DNnuqiLsyZO9SJ1ruoojCJDemUC0rmD+JV8URPIgI=;
        b=RLBeu7LRaUrxCjm04TdokXLV84z8KpEHZsZ3XDhlOmW3ExzhGij2eRq42wBCPGjOuf
         1MXzemyAryk6u965MVknLywlbGPaxhjP/9eEfKMx2hKZaG+JUmmo2qhOAzfko8GNKAR3
         w3iy0juVUMdwUCzcksQAkzuvjPNUCTY1zvOsgFvzk4OhUbK91rR5IcRQTSiQSgFkabcR
         fS5783sxRTSCg5VjedTR8ItQAte5g3aiOKBlrHE9NrToPJHKoNkKdSbqLH8rRahddYhl
         vxwTTsdGal2duNgu8946Uhffg4D+/sw/R3ChewOz0BIVAsIRCzk0q0aSGDBwOTTTbcsB
         ypCA==
X-Forwarded-Encrypted: i=1; AJvYcCWnfVUZCccvwaJo7rmlWFMeDx3n18VPDIJOZ1bJIa0nMcCsl+N76qTRlNfiC2HQIbWiZPwiK1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/VfPl41uk0zZ7ukpLbo65MbU5dtBhexYAlgjGsIPCcOoarTty
	hMnw7r1aBpJo5QuzK+duHZ2Oi12TANWgPqQtVFbJWKcCtPHWXKx6Qbj6xaC/PjBVCquTLMUjwH9
	oQ5GLjOCvB3hr4XPbElsXZ5UUnQbN6bw=
X-Gm-Gg: ASbGncumwIXXvW1Rd9XOhmjUZAB0pSBwNoWSh+XVIgS8JS0A0UUcXdWaE4MK8rw2UUL
	nlvB86C0Ip1PMYjcUEnC7aboA6+kcBW1kxbBofMXphbsUOnKGW9U3ybb2MMIiaknMAf7hQm6Fqp
	jIlBUKetTEjB+7i7W/R8WACE0Tt8rz4MFXoqrnzeDD7n+QCdB5/DQziamQWCzbC9qBVyHRLFGxN
	99lL3XrxuxUk86eHL30+K8ngJ/D/doEHOnqAlAVnrlPj86AeYE9ExQTVsbCiD3fZjORidIK
X-Google-Smtp-Source: AGHT+IFl0PygBGVQDcDoux4KUpDZWbMWPvO9pvbbbb8+4rH/xr6b/zEQCBbAmTqX2PhbkuQ7hJB0oosFqP46oGnaGwE=
X-Received: by 2002:a05:690c:658a:b0:785:aedf:4ac6 with SMTP id
 00721157ae682-787d5355527mr68221527b3.6.1762657270013; Sat, 08 Nov 2025
 19:01:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107100310.61478-1-a.safin@rosa.ru> <20251107114127.4e130fb2@pumpkin>
In-Reply-To: <20251107114127.4e130fb2@pumpkin>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Sun, 9 Nov 2025 11:00:34 +0800
X-Gm-Features: AWmQ_bl4pAwU4DcdzQl2rZraMoW7kKSb0oYzeEjLEM0Qy75Y6egynRfDTOFL-tw
Message-ID: <CALOAHbB1cJ3EAmOOQ6oYM4ZJZn-eA7pP07=sDeG3naOM2G9Aew@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: hashtab: fix 32-bit overflow in memory usage calculation
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexei Safin <a.safin@rosa.ru>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-patches@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:41=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri,  7 Nov 2025 13:03:05 +0300
> Alexei Safin <a.safin@rosa.ru> wrote:
>
> > The intermediate product value_size * num_possible_cpus() is evaluated
> > in 32-bit arithmetic and only then promoted to 64 bits. On systems with
> > large value_size and many possible CPUs this can overflow and lead to
> > an underestimated memory usage.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> That code is insane.
> The size being calculated looks like a kernel memory size.
> You really don't want to be allocating single structures that exceed 4GB.

I failed to get your point.
The calculation `value_size * num_possible_cpus() * num_entries` can
overflow. While the creation of a hashmap limits `value_size *
num_entries` to U32_MAX, this new formula can easily exceed that
limit. For example, on my test server with just 64 CPUs, the following
operation will trigger an overflow:

          map_fd =3D bpf_map_create(BPF_MAP_TYPE_PERCPU_HASH, "count_map", =
4, 4,
                                                     1 << 27, &map_opts)

--=20
Regards
Yafang

