Return-Path: <stable+bounces-91697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0619BF422
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 18:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50B11F22FAA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1032E20650C;
	Wed,  6 Nov 2024 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gx7fClTN"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0960206516
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913246; cv=none; b=s3qTXszhSLC56OAqzE5YWOqMQxBeshYVrBOAqUyWEFNioy2FHTIDnQTsXWd99ynF32Yv8H1DJUHckQbb9YZK6jh8JNF5+wbiP8dELKOmGSgX8IrsWMmSZ5HJ9wVm+RQMClAM6jxyQO9T76VD2rY9Dqs6FD6DDMjCW1+P2Ucy7HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913246; c=relaxed/simple;
	bh=aK7r7dutHmUp3194uXOxIIb5tARbY5t8h+WywjwPTns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecTdYjwy9IdeBcETAb4V5fXiPRUp1Lqk7Lelgd44iKMJ0EzYbeTdLAAVdBvVvm6cRfx3cmLoPM9dsV9IFUN43X5e3ymQ1e+a8+tk2apfL46yCUv7jDqVdSGxR/pYPPAUu7hC6X+VAYGUl2A1SQqGi/FkBJQXQEYpu9xFlhsShJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gx7fClTN; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460b295b9eeso257611cf.1
        for <stable@vger.kernel.org>; Wed, 06 Nov 2024 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730913244; x=1731518044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Mg876GLM4S+VfNU3/C6G9rzUdGmWJGrvGfyeMQ1B+M=;
        b=Gx7fClTNSyefIkcOseC6xJ4m2tcAEbOsm0I0LBzzIkYQGzW5+y1scwodpdfiFbykob
         /snKRxUJeA5EyXiP11+Q+uYn8tDec4qP1+wLOEbnMdMXdjw2HAvsOW0RvYRTa80Xn/rB
         VcdXuL2zIHKNNBknlZAfWAkaO+5j5xBduuLhX4F1P6U5tPtD2O/O/ACRTPRVJggyPTcs
         fGoioUuJSWvNrIR3aNWNK88H3g/T4EDdjAHrDha3SloD4ceyP2sMwd38+IUXCwTabKSM
         RTYMS8pccFw/HLJc/4o1QGUxZynmydR0xNkPm4HYKk7+DdH8uPnNaMsUHWjlGZqL0sY+
         yrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730913244; x=1731518044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Mg876GLM4S+VfNU3/C6G9rzUdGmWJGrvGfyeMQ1B+M=;
        b=f3DsJ062Ve+TnmjXUnSwTeK5xOu3bVeDuG2bRIw4OUPPq1SL+Ay0/KNt2ZYROl33z7
         XQi1oGErnPxn2yvzbPcmvggXpZNls8vhHqerbpGBst2YmCC2VthVrT2QzO2Te78PnB12
         Ol6dJmF3l0BEhqLBNDwdYU2I9M3B7lPS0v/dg4RXEahgPwA27s5JeFP6VAVT9goLW8Z6
         IW+ntV0vi3v9BFukDJTUd6L2L6WRbNmW2JagVt60ab3MSX4IAOGB26Kuko6y9PVqAJ3X
         8RGnnUbQu9SX3reIED9ju6aeUhIHOOwt0Fu4ZK5liRb2tpSj6ZRHfMhXdtSwiPUYC0+3
         ZJwA==
X-Gm-Message-State: AOJu0Yxy4rx/BPIvecLhE+RiCjkahkN7svbF+02JLUUsuxIrvutGlCoc
	Dhhzmd7i93ebzOR2Y0EELcRShMl0l4a1Q/nz4GkAfPlSdMTG0reGhJKdIE91n5H0Jteb7bKQz84
	3A6bMzH5K5Pn7cDfnpuwnaotNuFsOkfYhomkA
X-Gm-Gg: ASbGnctWbJqRezyJH64aPUCMK9y0WdZLjBzwAPlX9Kn8+WXvz/uD5fYQU+jXljAVr9Y
	RxOUdDTf8LxKUUj1y+lT0oBGpfcW8hNuHsEHaa2V+jEdksQC7c4frb2OmOscS
X-Google-Smtp-Source: AGHT+IGy0sdQNV/EAEjRjD86jhDr7KV5gSObO7CkSYrAYq1yKsfypX0x7mhC3XjBooRcwV0c66RUT+cfvJPaXjXnraI=
X-Received: by 2002:a05:622a:2a0a:b0:461:259a:d540 with SMTP id
 d75a77b69052e-462fa58dd7dmr565591cf.7.1730913243552; Wed, 06 Nov 2024
 09:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120319.234238499@linuxfoundation.org> <20241106120319.274293314@linuxfoundation.org>
In-Reply-To: <20241106120319.274293314@linuxfoundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 6 Nov 2024 09:13:52 -0800
Message-ID: <CAJuCfpEmcmJb4JBGjsV=BYmSW98q7sHxT3vtsGQ-F=1RwdajnQ@mail.gmail.com>
Subject: Re: [PATCH 6.11 001/245] lib: alloc_tag_module_unload must wait for
 pending kfree_rcu calls
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Florian Westphal <fw@strlen.de>, Ben Greear <greearb@candelatech.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 4:24=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.11-stable review patch.  If anyone has any objections, please let me kn=
ow.

Hi Greg,
This patch is the second one in the series I just resent here:
https://lore.kernel.org/all/20241106170927.130996-1-surenb@google.com/.
It will fail to build when CONFIG_MEM_ALLOC_PROFILING=3Dy without the
first patch in that series, so please pick them up together.
Thanks,
Suren.

>
> ------------------
>
> From: Florian Westphal <fw@strlen.de>
>
> [ Upstream commit dc783ba4b9df3fb3e76e968b2cbeb9960069263c ]
>
> Ben Greear reports following splat:
>  ------------[ cut here ]------------
>  net/netfilter/nf_nat_core.c:1114 module nf_nat func:nf_nat_register_fn h=
as 256 allocated at module unload
>  WARNING: CPU: 1 PID: 10421 at lib/alloc_tag.c:168 alloc_tag_module_unloa=
d+0x22b/0x3f0
>  Modules linked in: nf_nat(-) btrfs ufs qnx4 hfsplus hfs minix vfat msdos=
 fat
> ...
>  Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/202=
0
>  RIP: 0010:alloc_tag_module_unload+0x22b/0x3f0
>   codetag_unload_module+0x19b/0x2a0
>   ? codetag_load_module+0x80/0x80
>
> nf_nat module exit calls kfree_rcu on those addresses, but the free
> operation is likely still pending by the time alloc_tag checks for leaks.
>
> Wait for outstanding kfree_rcu operations to complete before checking
> resolves this warning.
>
> Reproducer:
> unshare -n iptables-nft -t nat -A PREROUTING -p tcp
> grep nf_nat /proc/allocinfo # will list 4 allocations
> rmmod nft_chain_nat
> rmmod nf_nat                # will WARN.
>
> [akpm@linux-foundation.org: add comment]
> Link: https://lkml.kernel.org/r/20241007205236.11847-1-fw@strlen.de
> Fixes: a473573964e5 ("lib: code tagging module support")
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Reported-by: Ben Greear <greearb@candelatech.com>
> Closes: https://lore.kernel.org/netdev/bdaaef9d-4364-4171-b82b-bcfc12e207=
eb@candelatech.com/
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  lib/codetag.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/lib/codetag.c b/lib/codetag.c
> index afa8a2d4f3173..d1fbbb7c2ec3d 100644
> --- a/lib/codetag.c
> +++ b/lib/codetag.c
> @@ -228,6 +228,9 @@ bool codetag_unload_module(struct module *mod)
>         if (!mod)
>                 return true;
>
> +       /* await any module's kfree_rcu() operations to complete */
> +       kvfree_rcu_barrier();
> +
>         mutex_lock(&codetag_lock);
>         list_for_each_entry(cttype, &codetag_types, link) {
>                 struct codetag_module *found =3D NULL;
> --
> 2.43.0
>
>
>

