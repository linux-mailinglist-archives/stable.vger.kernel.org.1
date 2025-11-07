Return-Path: <stable+bounces-192715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDA0C3FBFB
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 12:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0812189242B
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FF23016FD;
	Fri,  7 Nov 2025 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV8mEXQw"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D501DE3C0
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515341; cv=none; b=IunlvsdsvTjFZD8h/4KsEmiixZrdW+kueiGnwQ5JCkKGAzbPNXxUlO1M7tJ8/uzoOrsHYHJHgE/JO3SpL2Nr56NdzuTfiIaC3CyVNgrZtic1I5Jnqs54lNBeYFQ/1XHxsEqP57YwzzTEl6OUlUL04cXTjbmfkK5FkwdinCrhOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515341; c=relaxed/simple;
	bh=zNqXV7WRO/eVwUnndTihrxnpBVkbzuZTXPTv4fgK0XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+xCAcb0ILVryOy4YEmls5LDYEwdtPteoqxYJCW2kz0SAUoh2vQYSSv1h8eNCG6lz8VayqnqwzKOouWyaFZAxcz9onuPaqRkSerfOrMrlZzE98D+mMq7kn5C0P054PuU/lZG2Q+7CSJPAWuKCRg4mAU/u9i494Juw4YWRx8m/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV8mEXQw; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-63e19642764so562322d50.1
        for <stable@vger.kernel.org>; Fri, 07 Nov 2025 03:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762515339; x=1763120139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++p55Z22oOKt7e+LqpAwzHw/R5/V6CL0JDal82TPeYM=;
        b=YV8mEXQw3xfK5ilP0bn7MGca4kjbAPHFAxEWpK2RypcRydKmvAbaHdBP09EM6WqxHR
         s+D841T7rmb+c6dBHSaVsJC5rL89aAy6FYV5l+9MHXrg3QEwdZrjP1A/t+rlVirIiOrp
         AD8HRQUsrKWRUug7yx/B5+NrhF7exSa+NtjxxQmpzd5xXqg08QHOoKN1ktlw989csp32
         DaL7UlJakvWrrf6gZrwtxBhpK7NxELgm/V9qdnzzqIvrs0RskXho1aD8a/KfGckDiMQf
         a6EPlKGSf/n5WmKBKUL4f0xSZ9t93TSWoa5Ll0y2wxVDehyyCUWbwS0mi5psJzLiA2R8
         cSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515339; x=1763120139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=++p55Z22oOKt7e+LqpAwzHw/R5/V6CL0JDal82TPeYM=;
        b=s0Ztpee6mWf5gB8HwlY3Ml1NfUaIdFrL30gCjUHKQmfiUGLEqBV5Q4mkIH+NWKwWpO
         7GNpxA1kqTa8DNQlrDAwh5l5GhVaknPmWFbYo6PLUxIPBaekxuc9YcBMBKp6SkwRiSLl
         ESxwqUeSSWCAdECxCP5M2dhLS4RfszyV1PytoH+zHMIk9sb+zxX9/Xki6n/YRpBQ7zh2
         vWFlmPSFQ2jWHOBLVoARxLN9QTTH6vvbmrjZV7yGJNyMe6+o7rvpGqIeTujXRtHytLwn
         V5C3U/yg/IqftUubcFi4X28lMoTBjNmHTzRkrsxM+z4Q/FOIHwa6qaRFC5OO8jT+av7N
         Ezfw==
X-Forwarded-Encrypted: i=1; AJvYcCVrOVK0ItC29etO89prpy3Yik3LGcdTeDMwK8s/ThmS6MAYh6AMsL1PfSckCyyxedl4WCbqjjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpD/K83qD8NkJlI14h7e7qz+9KGsYU/9c/iGBwX1xGxZLR8b8Y
	Sws7oWvKHDeolEBEtQ1vE6wx2eLVygJoOSwxqUnLR6+LF4a0ofoe1RG6aJlOAshRjHx6FhtWxex
	0rE8Xp1k26r2NxjYS4wFOADbrfqWtdKc=
X-Gm-Gg: ASbGncs0QM0jmtev+3kncOvy0ND0rijUf7ZB2TZiZ/ddHemDRHxSocsiUH90XYR1oHF
	3E1iPqa1OOwyxA5KbZYBCXyKIgrxmw6uk/b0/HHtL/xrs7MgQWd5XeuO4YQaUvQznC127w4+oVZ
	tb2onNDfsFqOd84LKm7HILwCQKx/xjCa4TL9CK6mEDitfHIfOAVKSlziLgu7NRYx/TeMyPK2ydA
	AoA+VkeX2rb2uAqmcTExybGqBUmYfXD/9TXeusIEq5RHLgnx1NTSknoAp3EJQ==
X-Google-Smtp-Source: AGHT+IGXYJDMaVrUBMedAXp8lQRn7HgcOZXWi6MRoLsHiQLGzhj7GRFpkd3fc0HO9nlH6lIVhM8c66RWKCBzqaH+Avc=
X-Received: by 2002:a53:c059:0:20b0:63f:b922:ed79 with SMTP id
 956f58d0204a3-640c418d78dmr2148649d50.14.1762515338720; Fri, 07 Nov 2025
 03:35:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107100310.61478-1-a.safin@rosa.ru>
In-Reply-To: <20251107100310.61478-1-a.safin@rosa.ru>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 7 Nov 2025 19:35:02 +0800
X-Gm-Features: AWmQ_bmDQR-XfcumZ--vLoQjq_ZgB7K9GMeBPoe20HqNsFPwE-dH9_mC25f64J0
Message-ID: <CALOAHbDGw_kfz-Vv7BRwY0Rk3SofMQ4rzvvQph2wBT=_9ZK0HQ@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: hashtab: fix 32-bit overflow in memory usage calculation
To: Alexei Safin <a.safin@rosa.ru>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-patches@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 6:03=E2=80=AFPM Alexei Safin <a.safin@rosa.ru> wrote=
:
>
> The intermediate product value_size * num_possible_cpus() is evaluated
> in 32-bit arithmetic and only then promoted to 64 bits. On systems with
> large value_size and many possible CPUs this can overflow and lead to
> an underestimated memory usage.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 304849a27b34 ("bpf: hashtab memory usage")
> Cc: stable@vger.kernel.org
> Suggested-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Alexei Safin <a.safin@rosa.ru>

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> ---
> v2: Promote value_size to u64 at declaration to avoid 32-bit overflow
> in all arithmetic using this variable (suggested by Yafang Shao)
>  kernel/bpf/hashtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 570e2f723144..1f0add26ba3f 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -2252,7 +2252,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *=
map, bpf_callback_t callback_
>  static u64 htab_map_mem_usage(const struct bpf_map *map)
>  {
>         struct bpf_htab *htab =3D container_of(map, struct bpf_htab, map)=
;
> -       u32 value_size =3D round_up(htab->map.value_size, 8);
> +       u64 value_size =3D round_up(htab->map.value_size, 8);
>         bool prealloc =3D htab_is_prealloc(htab);
>         bool percpu =3D htab_is_percpu(htab);
>         bool lru =3D htab_is_lru(htab);
> --
> 2.50.1 (Apple Git-155)
>


--=20
Regards
Yafang

