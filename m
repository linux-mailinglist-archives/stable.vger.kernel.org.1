Return-Path: <stable+bounces-105569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5E99FAB91
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 09:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C75D165DDF
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 08:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C00118BBAE;
	Mon, 23 Dec 2024 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5VGqEwF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2D23D7;
	Mon, 23 Dec 2024 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734942953; cv=none; b=mJK//J86PLar/yRYPSqURoumgZQszCThVaBkIPXptZLzcpxs3uRQAbEZBymvIRb7Ra62nlXFMJgzHeNB9Zt9C7Zf5TNZFH2+gP4lX11ECReIjAndgguFrTS4PtHG8bh+GOGnV5/qr90Gv+KuIDWC3YRUcChPgsO0uCQ2Bn7W218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734942953; c=relaxed/simple;
	bh=LnndBdN4uvgxvx5Ff9Beu1hEiGU1BNiKAh4RlsgXdoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVjc60BjuO6DSB4S0vRoKTOnZzjnzjrvsvHOkGqepEiJsomnaHqMfEKAk40UsoZDI1devQwgytYCouM/nJFj2y+AFu1cMzoabsfU98DFowiw4ObrSCyLjA6dl2Guds5wiTh/mpbvHNsQYH/JzRyt6BRGUDJb4K3brPNIxUzm8vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5VGqEwF; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dd01781b56so45519236d6.0;
        Mon, 23 Dec 2024 00:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734942950; x=1735547750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnndBdN4uvgxvx5Ff9Beu1hEiGU1BNiKAh4RlsgXdoM=;
        b=X5VGqEwFdQS438R1i6CzHnP4c36jKhvD4khJTru81N10/g9wYlN5JxSTELUbF4HbB2
         ETTBYX/8+X7CsUjR/woynCzRkaiJCD/9ATj7nFzBflPTUzr7aUjfB7WgO4n6E4yk3mgH
         0PwhutyRDzPxO8eAGj+6WwJV26oxmtnuIAzQcFP0sXp5rL2dqwrXDuUgalUOlo0IWeNJ
         Jsnq9jqyTYLi9ZMcbTIwdqgR++ue5qDaxAPRfM+t+TJM2TdYtuVLRMlhrx0o7UTonCBB
         87SZYVstXMgdQjSGrI1h5t1Tv+oDO8oFyJTYQQZllmrnCHeWg4mLaT1nOJAtVC5ON5xn
         HCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734942950; x=1735547750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnndBdN4uvgxvx5Ff9Beu1hEiGU1BNiKAh4RlsgXdoM=;
        b=REFhClOsb2CzWDh6hnhL+WgNpSeXSojyZBrWnzFL+iAjNWel5qcP0zCSSqm8scIySH
         HvFblkqnzbnE+PeUvNHExLdOf1CuRfY00KQrOR7kNsGuYpieTh0SgZuLtVdLgc8sKxP3
         NhHRr0IePo3+RPXYim19t4zkdjggGTqXSxcA0HkXqEpeEufztHj7fUkRqfZS6L7GOXRx
         J0Oh01z9jGYLPckATfLxGsiEZGgIPmixehXKdf2QpQ5vG7xg8IvzMvVZkAUcngLByNF/
         Q0U40xPPUyCd9TRO7oTNBMPKzPRnsyYA93CZd2wsCuYhNsslxDw/2qEszBNgpVLfJ2RA
         8wxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRmusqY5RShb0230UrlBE/9a2B+5NuB+IAl9QfEH2FD+KhrRSoKewUok4+Z1jzoUoZkSuZdZRPXKevfaA=@vger.kernel.org, AJvYcCWuQ2UI1QJzhtjnPxUB/UEa2rhKie/ZfVzbBnqAYc3tUGxI/ffhp+JgOb10k64I4iZhPfSAfQDq@vger.kernel.org
X-Gm-Message-State: AOJu0YwPEB8xq6pkEFWUXAg6RiHjI7qzN3OQf1yAvUYbHEJA816K4J9X
	KaJArwOEK3xxCsyNphbuXrAIHXXftw+ZA8BVd8CaMljdoIZCrXlqguWBvK9IJsGq+7f5LzJGQgU
	1KY+No/HduKOQhKQeW1pkF0F0XcM=
X-Gm-Gg: ASbGncsILqkB+YHy9P10aqfHeY+4jQzITw2jafm8xLl9VJP7xgEzkd3G9IXZHYlEoMY
	V0tCOXcsTlq/z0Q+twey3n9sSaUtqfhndrg==
X-Google-Smtp-Source: AGHT+IHSyTY7gYiZNIPIxZZrnpngESpfXVdC1jA23brt6NzNU0hyMGEn8niBKtYDNcvf+LVEyR9SI1KTCXQbkQZ/s5I=
X-Received: by 2002:a05:6214:5018:b0:6d4:85f:ccb7 with SMTP id
 6a1803df08f44-6dd2320407bmr172388386d6.0.1734942950507; Mon, 23 Dec 2024
 00:35:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219212437.2714151-1-yosryahmed@google.com>
In-Reply-To: <20241219212437.2714151-1-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 23 Dec 2024 15:35:40 +0700
Message-ID: <CAKEwX=MCZf83aBqJ5Gk6ex6=FUo0R2H9Uu4KhC3MDzcpBMUeFQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix race between [de]compression and CPU hotunplug
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 4:24=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of the
> current CPU at the beginning of the operation is retrieved and used
> throughout. However, since neither preemption nor migration are
> disabled, it is possible that the operation continues on a different
> CPU.
>
> If the original CPU is hotunplugged while the acomp_ctx is still in use,
> we run into a UAF bug as the resources attached to the acomp_ctx are
> freed during hotunplug in zswap_cpu_comp_dead().
>
> The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to
> use crypto_acomp API for hardware acceleration") when the switch to the
> crypto_acomp API was made. Prior to that, the per-CPU crypto_comp was
> retrieved using get_cpu_ptr() which disables preemption and makes sure
> the CPU cannot go away from under us. Preemption cannot be disabled with
> the crypto_acomp API as a sleepable context is needed.
>
> Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
> per-acomp_ctx") increased the UAF surface area by making the per-CPU
> buffers dynamic, adding yet another resource that can be freed from
> under zswap compression/decompression by CPU hotunplug.
>
> There are a few ways to fix this:
> (a) Add a refcount for acomp_ctx.
> (b) Disable migration while using the per-CPU acomp_ctx.
> (c) Disable CPU hotunplug while using the per-CPU acomp_ctx by holding
> the CPUs read lock.

Thanks for the detailed explanation regarding the issue and its
historical context :) That was a fun read.

>
> Implement (c) since it's simpler than (a), and (b) involves using
> migrate_disable() which is apparently undesired (see huge comment in
> include/linux/preempt.h).
>
> Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware=
 acceleration")
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org=
/
> Reported-by: Sam Sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv=
4OcuruL4tPg6OaQ@mail.gmail.com/
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Fix looks good to me.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

