Return-Path: <stable+bounces-223751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Gb/F6OSr2kragIAu9opvQ
	(envelope-from <stable+bounces-223751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:40:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E24C4244EA4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 407A83029A97
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 03:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183333BA259;
	Tue, 10 Mar 2026 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDGh/p7r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144D3B961F
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 03:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773114013; cv=pass; b=QQfX+MlZYiceYi4cGs45tTvEhkeZlw9fEmNoB/iWP5RBXDF+iRtckh1hZzvOlGOoJ72A/YxOrDp80KrflN8mCdUeXCdrtCdpKB3zmLPPDVcjMIJtidRcCkBDm+TJz2PDvo/XqGzwgYqrBL39Lvy0DXvZu6KjJGqoYKx2brQ/rnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773114013; c=relaxed/simple;
	bh=nrF7vlGYzrNGs/7YHhPH/NnJVLHS4kdieXhq3F5zpFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOfx6kRVZDTFreMKyOi0k7IgdzxIHSITWo0xk+7JEWlsqh8hr36/xr1ZfZCq95U5UoBj3QmGJjHkbhYJoSaIIRXLWAsbZk2QhmfL0frT6xn105JCrPmzY/r60GH4JN59V1gfLTDRUssFLOYKxd7tm99LXD7ls1FjzhUKshJVIoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDGh/p7r; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c2af7d09533so7915183a12.1
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 20:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773114012; cv=none;
        d=google.com; s=arc-20240605;
        b=A8yLg5YUher8lXYlhjaOqQRz3+05BOUGWtmPM6ZJE8HrT/qRlj1WkeN/LbMmwm0d0s
         j019GLU2nNniVqSXyXQAQWkgKRsdwwYTNmRSFIstPRHk2utRWmk1PmvmYUHt7VhvS6vE
         WWYmYKdXOPpuRShUIMCc2gG89du5rsnzGHpBOOPQxnZUDj0jrAsqvooU66be84CGX1YI
         0T/qzR37gbpmMmBGcmkeStxXFDeZKYCU2YlQEffAqMAqAgVFfet0Ew7c2IiSBOXo4ckv
         6jU/N5I2wr4jjbWq3YI2R3gtF1yzraDuX7F5Y38EBEQl3WG6qq6jYiHEA9LYyNJFEs02
         u9Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1PR62EF1lAki6+/h7SawFbTNGruJi0XAMWivo94NRLc=;
        fh=pZj2HLmy1sc3g18/LAgqDufoTh9yNMoX95hnOXkee84=;
        b=kMk3yh0IFcu8ky4V+SRVrdS45IviirOUeMQbVdjUGTaasE8K86Vn+F4myP1wHHA42g
         ycOt9P8xLk7ok6XEt1EtyKwbkrSUGBukZSnL0i83nv0udifhdsUPoZ00b9aTL/CSpebu
         UG3VoR2Uw466ChdX9KP0swqZrw4pkWj/Bo4U4qc0KNdXsLj4gdR2jxFiT8qESSWRhQjw
         6qL2ztVEpZ9a/UziAX9SonAokjsvvqfygC5oMRaFM/LiY5yPoDpO785JLe/IZZqaFXrq
         S7fBYgK272DM1bu2Wa8XFFaSH6xO95shZc4YJez/LOVrv4cyYMz8GNNu4s6XvELLEFXo
         e2mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773114012; x=1773718812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PR62EF1lAki6+/h7SawFbTNGruJi0XAMWivo94NRLc=;
        b=LDGh/p7r4q4O4SNLhBjYnjbsAWHkfrcHUi/YqyWGyBQCMy8rpaRzIiI8nRaATiFmgz
         WXDg+LaLkXdxnNhVsYRPoomPfBjn9QcTAj0ZW5hBUdzM+ntlWClVGhP+Ai9TI//i4Qds
         uYmAjTuU9IOGx/qaBC3UJ93WjrpKdL464r+HcmOVwaIXypg1fMC/GdVhu2QWEp+EZnCK
         hNm3w6YGZxM8Vy2NmvRUnvtf0HwgJIM9+9Ymn8boWZiQsiUcItdrRpwGMaNdk01Wh3vS
         HcAfLdNtoHGrci7cbcR3NIWZSgpykecmktQp2Frk2R5n4f2C5LosFp2MJQuGjjSFDPL7
         aKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773114012; x=1773718812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PR62EF1lAki6+/h7SawFbTNGruJi0XAMWivo94NRLc=;
        b=iTe3iQack8qj6xIFJx88prtexduH8iImTE7faxMpVqi1sraKwLkAcGVHThr02Lny2+
         Y6Y0MVT4Y16X2l3/iR1AL1QJieqsa13asWIjim/en2A+YhB0yYzFYVwkv5820UUDJdfh
         Yz9jSc6RP1A+3guzkG/y67/MORBiLsYzWJwGrc5Y3mxjWMAKdegXzF46as/U+TdVzW/u
         JrWIWBL8Ac4oNgPTcs4aBhCpHPdROaMMswCe4e2+SLoXRQdE850PeOA0xKu84xPkxd3m
         z+JQabUSfrlUTwxxePD/cgBoimw/LttloSD45MG6dkVVjwpiOAkfuhhg7kyaPBPJRc37
         BWxA==
X-Forwarded-Encrypted: i=1; AJvYcCWCpemVl/+DS2lJ2qgd4Lj7tWQi5vCwF31aZ+WHINrt4gbKX+OTclnX4cV+W4kOK+EaLRYBtxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfi/puzRm0hiqD5L0ZTdthc5pEvXret1ATMgknP1bPjxjTSTqE
	yiyX4M+Abw++q1LbwpscW3LxN9jXzMIZS8ykVvKepgHBE+VnSRZSi1IBNnFizAax8pJBagbT6uz
	F11fJjdiaOhYp0X6tP7Y6lK/OUOZ3D4I=
X-Gm-Gg: ATEYQzwtODlMUOF8gqrbw4VHSF6GafJBVE0IjrFWkA5q+8KNechfsiXpUnlAM/d1xUu
	cCy5qzqCcSuBzHLCdsSY+DpBv1Fa4TzlVO3N3Zt0LRcn6ZIa4llOCrnOkrt4+PTJ1WJz4pNf8ZW
	4CvLWxvLs4+FMzWr/6S+BtRait/XJ6nEQ1QS7orYxstt6dTiUIbaapc5Z8qo1CnN7/qaAAlVS7i
	g608uvl90rcwlXNEmu8P8wqXr/Tn5Rk85Yv4+lZn4ulz9xFqa5jp2t6giGm2qHO13TKyeYrZKkH
	WYn3T14=
X-Received: by 2002:a05:6a21:9ccb:b0:395:291b:f555 with SMTP id
 adf61e73a8af0-398590ebdaamr11794026637.69.1773114012045; Mon, 09 Mar 2026
 20:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa5NmA25QsFDMhof@hyeyoo> <20260309072219.22653-1-harry.yoo@oracle.com>
In-Reply-To: <20260309072219.22653-1-harry.yoo@oracle.com>
From: Zw Tang <shicenci@gmail.com>
Date: Tue, 10 Mar 2026 11:40:00 +0800
X-Gm-Features: AaiRm51P9s3DC7FjytFC4I2paYZUeQw-qAwJyjCHl-40jBVff_9Gjy4xmE9iqAQ
Message-ID: <CAPHJ_VLzRECge4=L5RRqZyf-Sou8APi=Sc=d0brBAMdj3UC_Cw@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: fix an incorrect check in obj_exts_alloc_size()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: adilger.kernel@dilger.ca, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, hao.li@linux.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@kernel.org, 
	cl@gentwo.org, rientjes@google.com, roman.gushchin@linux.dev, 
	viro@zeniv.linux.org.uk, surenb@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E24C4244EA4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223751-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shicenci@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Harry,

Thanks for the patch.

I tested it on my environment with the original syzkaller reproducer,
and the warning no longer reproduces after applying the patch.

Kernel version tested: v7.0-rc2

Tested-by: Zw Tang shicenci@gmail.com

Best regards,
Zw Tang

Harry Yoo <harry.yoo@oracle.com> =E4=BA=8E2026=E5=B9=B43=E6=9C=889=E6=97=A5=
=E5=91=A8=E4=B8=80 15:22=E5=86=99=E9=81=93=EF=BC=9A
>
> obj_exts_alloc_size() prevents recursive allocation of slabobj_ext
> array from the same cache, to avoid creating slabs that are never freed.
>
> There is one mistake that returns the original size when memory
> allocation profiling is disabled. The assumption was that
> memcg-triggered slabobj_ext allocation is always served from
> KMALLOC_CGROUP type. But this is wrong [1]: when the caller specifies
> both __GFP_RECLAIMABLE and __GFP_ACCOUNT with SLUB_TINY enabled, the
> allocation is served from normal kmalloc. This is because kmalloc_type()
> prioritizes __GFP_RECLAIMABLE over __GFP_ACCOUNT, and SLUB_TINY aliases
> KMALLOC_RECLAIM with KMALLOC_NORMAL.
>
> As a result, the recursion guard is bypassed and the problematic slabs
> can be created. Fix this by removing the mem_alloc_profiling_enabled()
> check entirely. The remaining is_kmalloc_normal() check is still
> sufficient to detect whether the cache is of KMALLOC_NORMAL type and
> avoid bumping the size if it's not.
>
> Without SLUB_TINY, no functional change intended.
> With SLUB_TINY, allocations with __GFP_ACCOUNT|__GFP_RECLAIMABLE
> now allocate a larger array if the sizes equal.
>
> Reported-by: Zw Tang <shicenci@gmail.com>
> Fixes: 280ea9c3154b ("mm/slab: avoid allocating slabobj_ext array from it=
s own slab")
> Closes: https://lore.kernel.org/linux-mm/CAPHJ_VKuMKSke8b11AZQw1PTSFN4n2C=
0gFxC6xGOG0ZLHgPmnA@mail.gmail.com [1]
> Cc: stable@vger.kernel.org
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>
> Zw Tang, could you please confirm that the warning disappears
> on your test environment, with this patch applied?
>
>  mm/slub.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 20cb4f3b636d..6371838d2352 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2119,13 +2119,6 @@ static inline size_t obj_exts_alloc_size(struct km=
em_cache *s,
>         size_t sz =3D sizeof(struct slabobj_ext) * slab->objects;
>         struct kmem_cache *obj_exts_cache;
>
> -       /*
> -        * slabobj_ext array for KMALLOC_CGROUP allocations
> -        * are served from KMALLOC_NORMAL caches.
> -        */
> -       if (!mem_alloc_profiling_enabled())
> -               return sz;
> -
>         if (sz > KMALLOC_MAX_CACHE_SIZE)
>                 return sz;
>
>
> base-commit: 6432f15c818cb30eec7c4ca378ecdebd9796f741
> --
> 2.43.0
>

