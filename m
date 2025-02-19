Return-Path: <stable+bounces-118244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E64CA3BC4A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 12:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A7A1891E8A
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E121DE8A9;
	Wed, 19 Feb 2025 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="EId4WNAO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A41C1DE891
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962753; cv=none; b=a1ZOoEyyOwTPvYRB7iisMJpzoUQR7ZiNhSHAJWrS8HrdyMypY6xRn27ABPH/dXKGb1XoGsYc0+UBybKnVjV2HjLOGL+ALUxKCiabvox8Akxsuuu/BqYElBjw5PlqTxwxHZixtXY5nDwr05+gCNZmrPWYkD4dcsfxj6L7L4QzGyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962753; c=relaxed/simple;
	bh=StEZrLs9kkzMPaj+AlZ/oMjrecLrpcK3kuXoQ+//Wx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOvB8IrclkJLv1pBiPYdbhVLkgHBKTV5qyOAJ3rRpEN5ddXRVchN/7hEHjllT+8ba91eXpImZLmzGRKaJPE0ZEuhHE6xWNbfd8ESAGAKu8iLSCf4vl6fBWO/cQ6AIPCGVvk/xcCbQ4EVHD86xApwg1HArufyIVi0EMQigqsmTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=EId4WNAO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5461cb12e39so3244641e87.2
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 02:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1739962748; x=1740567548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TvUqBXo7pX3OGufaHCVvGrqItUXzyJoYQX0buW7FGwM=;
        b=EId4WNAOTQleyzARRXV0ErPkw0XTCD/SvSSncKkao0/8nTAtwTtm4Cegtlla+OwZn3
         WCZHm9D9Nxr67Fa6mTXHw4esFa36Oc+5FgiTR2LjZjU5oFQ6tmYERYayGLpmcOOvj3tn
         xAqvJ2rUtD5USAAJigsUQNlZJpfMrTIR2qmMKSTpy357FW+HzL0t5Czr3SuS+oLb/YT7
         09vSunYqDoLH3wf+uaHDLVQdiN0qo4Vo7RxOkC1Z+xHZdOZLjzYqjXM07e0ges/2COKl
         +s+DiezW/XuZM7P7N0KUGFQoJWYVn99jfjeG9hHrrx46D/qMYVlANI0pdYiGvSA2gkej
         m7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739962748; x=1740567548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TvUqBXo7pX3OGufaHCVvGrqItUXzyJoYQX0buW7FGwM=;
        b=ExiU16Hgdd15lXATpB7IjMMXsFr8OjXslDdAX16bdFBroP2k1YCwi9Vo4KBFp4B5J8
         59jONEufFppifk4HLm0DzNgjX35RsiD44YH60a5NLfBYfDRCKPZZGBBbGZK7qt6FOyI5
         RNZRk0sHemhq5NSDdFvm7KqnwG0osY3+SUL70E+qfThThb0YLrf8YwSqONesS5QfHXS/
         nPYZqy0QEaNGmPMo04Rgr5qNDimE9KNZhFHqBMamF8ibykJwrcN4u/ULZqe0+aIPEva4
         AA5GWW405tL2AvgTuk145mfNRMZ4xDEENUCDaz1kKfkv8utkAh9/+FO2wBRjzIwxAo5J
         3gFA==
X-Forwarded-Encrypted: i=1; AJvYcCXOajSYMfxmkZNukgrehPtN830LLrQKmubWrJ6bNRxvc9HRjXQH3yQuY7vOyiGQR59QewVkbYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaLAD7xRujWp/tcDk0bNnzBKzdFlNJ1L+o0YU118uqFRtHls5W
	i6102S4HT60TECZfC69OITZcVEyQwQUcJMBlFG0ofdbWa7d0pcNrE7VsoQdV9+n029p6DGJNJgO
	ouHfkfaDUmnivuqkNAsSzN4yuuHNVyBY7kveqAQ==
X-Gm-Gg: ASbGnctonZViKWXWD1mpRXVoBhk4yo9ZX80zhytBcUYL70L4PTz6quYDhJHBeNlxmk8
	Yw6tUs0tRZcf/XMWEc3XnTPoxmfGdx1NduRi0y+fNEcXdoBoqo5v/Lq+h32snAtHVewTZmvfkp7
	HqY5TxmyI5xKSyqZUgdUr0pw4Gqg==
X-Google-Smtp-Source: AGHT+IFDf2xMI1aCLfZeNkHbqTc1fxdjKU8LMLIa3hxyXKQN16RxmxbrXD8qMf75n+E2fkiXk1K0zktwSDgaBlo61MM=
X-Received: by 2002:a05:6512:158b:b0:545:2cb6:af31 with SMTP id
 2adb3069b0e04-5452fe426cdmr6409842e87.15.1739962747645; Wed, 19 Feb 2025
 02:59:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217024924.57996-1-zhengqi.arch@bytedance.com>
In-Reply-To: <20250217024924.57996-1-zhengqi.arch@bytedance.com>
From: Ezra Buehler <ezra@easyb.ch>
Date: Wed, 19 Feb 2025 11:58:31 +0100
X-Gm-Features: AWEUYZlJLxDsFiFpyrhpbMagLjwKnctzA_YuuA29jDCzt3ZkPaZaHYpVKVWkXxU
Message-ID: <CAM1KZSnM-imYwM5Gf4gw8yXr1+6PXyLvbpKbBu_KJmPR0WS7cA@mail.gmail.com>
Subject: Re: [PATCH v3] arm: pgtable: fix NULL pointer dereference issue
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux@armlinux.org.uk, david@redhat.com, hughd@google.com, 
	ryan.roberts@arm.com, akpm@linux-foundation.org, muchun.song@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Ezra Buehler <ezra.buehler@husqvarnagroup.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:49=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
>
> When update_mmu_cache_range() is called by update_mmu_cache(), the vmf
> parameter is NULL, which will cause a NULL pointer dereference issue in
> adjust_pte():
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
030 when read
> Hardware name: Atmel AT91SAM9
> PC is at update_mmu_cache_range+0x1e0/0x278
> LR is at pte_offset_map_rw_nolock+0x18/0x2c
> Call trace:
>  update_mmu_cache_range from remove_migration_pte+0x29c/0x2ec
>  remove_migration_pte from rmap_walk_file+0xcc/0x130
>  rmap_walk_file from remove_migration_ptes+0x90/0xa4
>  remove_migration_ptes from migrate_pages_batch+0x6d4/0x858
>  migrate_pages_batch from migrate_pages+0x188/0x488
>  migrate_pages from compact_zone+0x56c/0x954
>  compact_zone from compact_node+0x90/0xf0
>  compact_node from kcompactd+0x1d4/0x204
>  kcompactd from kthread+0x120/0x12c
>  kthread from ret_from_fork+0x14/0x38
> Exception stack(0xc0d8bfb0 to 0xc0d8bff8)
>
> To fix it, do not rely on whether 'ptl' is equal to decide whether to hol=
d
> the pte lock, but decide it by whether CONFIG_SPLIT_PTE_PTLOCKS is
> enabled. In addition, if two vmas map to the same PTE page, there is no
> need to hold the pte lock again, otherwise a deadlock will occur. Just ad=
d
> the need_lock parameter to let adjust_pte() know this information.
>
> Reported-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
> Closes: https://lore.kernel.org/lkml/CAM1KZSmZ2T_riHvay+7cKEFxoPgeVpHkVFT=
zVVEQ1BO0cLkHEQ@mail.gmail.com/
> Fixes: fc9c45b71f43 ("arm: adjust_pte() use pte_offset_map_rw_nolock()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Tested-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

I confirm that this fixes our issue on the AT91SAM9G25-based GARDENA
smart Gateway.

However, unfortunately, I do not have a 4-core ARMv5 board at hand to
test the CONFIG_SPLIT_PTE_PTLOCKS case.

Cheers,
Ezra.

