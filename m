Return-Path: <stable+bounces-235692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDpHMy0H2mnbxwgAu9opvQ
	(envelope-from <stable+bounces-235692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:32:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3844D3DEF93
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 302403022072
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 08:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ED32EBBB7;
	Sat, 11 Apr 2026 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3ZEKvKj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B9929D294
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775896342; cv=none; b=mbTZKrxwzBgvUQgbupBLQJ6nVWle/ZtiTGf4Ae/L1fX5BgCXtEiUCNS1qC6uOUGg1YMTdrEcLkUqjTWj5Xij/zL1oyc8UImoa83S2S2Zvip2WhAWGqXV0Da4hPjUKAw1iNGhEq1juNyA9J3N0ELKKJ/m6tA+A+QQ+zf1qtGwHEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775896342; c=relaxed/simple;
	bh=KPAmTaGpP3NlCIm6P8EYNwXFUqxILSkgHc3BlbK8kpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRxjCx4ukXI9jRTdzfHrK1BRmWWs95qXVvuSZYVb8SEPk2turfgJsPEuZCyVgKSt6jorUviAgI7U3QPieYVj75IafJhW4k5xQ76Xd1izfJNneU9ipp8mhG/BGllfGJtdFHKcMueNlhKNXZLyPqiJZoFef5m7BvW89HYSR2TeT5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3ZEKvKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92604C2BC9E
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 08:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775896341;
	bh=KPAmTaGpP3NlCIm6P8EYNwXFUqxILSkgHc3BlbK8kpc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W3ZEKvKjOcSjcph9WxBYLFs0b6tl5IcaJCAa+rlE0iOubh0ubk73LVQa0/IlchZVn
	 OsHgmLa5f+GNvAGrq4WUScxCV2pXrl7AuP2Zw5lEBKtC0ennZ0Mfq6Uvuo8Z20xiWe
	 gda9IPl141M3nSgcXnj2c+ERjlpHtAGqrY3vifLBlaDpW4YdyBDI/yc3AhDVaE6rfi
	 KEVx6xVjmyu5cTLkuRfCFhOKOnM9uX4sca6FUnkOtUzLh6X+bm93bQZIw02ntbZ6Py
	 Qk0W0po2I6I7zLB0P4W4Gr2k/IjF7d1X9iYOP4tFNkxUV23gHGoXe97xOXx/EkpX50
	 aGBvp5UO92P3Q==
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899a5db525cso21729276d6.3
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 01:32:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCViBtQYcigJbbIfKWtcEyAHl0J2yxS0Ms7n8SWbxWnCQ1lsN2ycq1SDOeBqsGXU6GrZLGeCBAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeLF7lg/H074/ARQEjF3wyvt4XeuMp6hX8Kc+esw/3Ov+YO9w6
	HA16kZs9Svy4//t0g4HEQ5pCWIjxptcw2/rUrbJEPn7mBYNCdbJhga5viI39jMl/+Cbzghve0T1
	dt9BXjg10AVQ9SsQtq/hAMKWzjo2EWlY=
X-Received: by 2002:ad4:5e8b:0:b0:89a:1536:251f with SMTP id
 6a1803df08f44-8ac861ca80cmr103079466d6.28.1775896340889; Sat, 11 Apr 2026
 01:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411062152.2092967-1-lgs201920130244@gmail.com>
In-Reply-To: <20260411062152.2092967-1-lgs201920130244@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Sat, 11 Apr 2026 16:32:09 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wLSLy_vZjGYiJpTEOBXtyTTTVdTr-wW+sKKb5b0S0Bhw@mail.gmail.com>
X-Gm-Features: AQROBzC1PacD7-eFcsH6x1hYNmbe4D2RNPxu2mWZ2SuIc-3EVI9AR0mRlqLqAJo
Message-ID: <CAGsJ_4wLSLy_vZjGYiJpTEOBXtyTTTVdTr-wW+sKKb5b0S0Bhw@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: Fix refcount leak in thpsize_create() error path
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235692-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baohua@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3844D3DEF93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 2:22=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> After kobject_init_and_add(), the lifetime of the embedded struct
> kobject is expected to be managed through the kobject core reference
> counting.
>
> In thpsize_create(), if kobject_init_and_add() fails, thpsize is freed
> directly with kfree() rather than releasing the kobject reference with
> kobject_put(). This may leave the reference count of the embedded struct
> kobject unbalanced, resulting in a refcount leak and potentially leading
> to a use-after-free.
>
> Fix this by using kobject_put(&thpsize->kobj) in the failure path and
> letting thpsize_release() handle the final cleanup.
>
> Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

I=E2=80=99m fine with the patch, but could you send a v2 to drop
the err label, which is no longer used? Alternatively,
could you rename err_put to err?

@@ -825,9 +825,8 @@ static struct thpsize *thpsize_create(int order,
struct kobject *parent)
        }

        return thpsize;
-err_put:
-       kobject_put(&thpsize->kobj);
 err:
+       kobject_put(&thpsize->kobj);
        return ERR_PTR(ret);
 }


> ---
>  mm/huge_memory.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 40cf59301c21..ae6ed483cd53 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -726,11 +726,8 @@ static struct thpsize *thpsize_create(int order, str=
uct kobject *parent)
>
>         ret =3D kobject_init_and_add(&thpsize->kobj, &thpsize_ktype, pare=
nt,
>                                    "hugepages-%lukB", size);
> -       if (ret) {
> -               kfree(thpsize);
> -               goto err;
> -       }
> -
> +       if (ret)
> +               goto err_put;
>
>         ret =3D sysfs_add_group(&thpsize->kobj, &any_ctrl_attr_grp);
>         if (ret)
> --
> 2.43.0
>

