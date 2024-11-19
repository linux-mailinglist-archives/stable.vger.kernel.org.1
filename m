Return-Path: <stable+bounces-93925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1629D2025
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 07:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79651F21842
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 06:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7476153835;
	Tue, 19 Nov 2024 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjDdxwUH"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A0A150981
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731996885; cv=none; b=AVcUrO0Qix1uegCJJp/UfHzso+v4mkLFiC/xwa5o0cjVaruGgDx4iqZTkUY/0LIp8ahXcSNiSiu6VJTGiD1s0dnf/mbul1sqF+guGHfHN/pxn/4It0YF53Ppnh+Canm3k3Gdzs/CniIEKChhU7A4WeUIIryk7t4oJq7mmJFdhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731996885; c=relaxed/simple;
	bh=pYF/EorXWsBZx2KqO/WMalvtVAxHF1dX/9lE4S6/Dpw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZOqBPgrupV58FfIlTBR0d8CFwbxIDJZEQjyZAbr2dJTUq89gg1d4iWS++6KK4ZKPPcKBVe2F622AyzawAtIgr4x7aMk5mtRQANkfwSBA3d3Q181ndefaw6arWyizZBI11hvwhwW11oKlo+quriW57ggfArAS5aV0O3L/8P7KFZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjDdxwUH; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e606cba08eso2533663b6e.0
        for <stable@vger.kernel.org>; Mon, 18 Nov 2024 22:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731996883; x=1732601683; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IweilAPPoyORF82ak4+lx/BYFiE3QNVvT8rXeutWxr8=;
        b=VjDdxwUH94XQl+Bq+K6E2eQ5XJo1Iqa4KuL0/kHTnVfQonnSqrV0jylh1tqRmUCs1T
         F7fVOWc8LabezlIYfZ9rU2X4lDwtLu501oFSVwaJdYvhNcQZCYc1Nu6y5CnXD1FqVBon
         VXdz4XYprSVX/fbSjAZLrCTIqrvf1So7u0X4Izgumt2WsV7p0Of1lauHDMz/FhqvgrPM
         sW/DHyXXkwnKJ+fHB29agGw3qr2bXYeISKGXQu/6mAyBYm3srTyK+zjNkr7nRu4iXEx6
         S+mde7jLLt4K7FjZPcxfr85hfR3zWc+lFmYcfCT30bvXnrpyFBJfSbX3f9Ss8FjcPJC1
         vt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731996883; x=1732601683;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IweilAPPoyORF82ak4+lx/BYFiE3QNVvT8rXeutWxr8=;
        b=e2AhQEY7LDSbe5H6DpJS3A91icS+8V92+amU9YDgaP0Uq2cPrXTJxojXQaK9yEj6OB
         zKKCc3PZqb8RFgJpJ8QcWIT/XKM/P+F4T3d+iCO/YkeEp+7j610ITj0rz0+eUGLxifmR
         T/FE83WR+da9Vdo+Xx20GmNsENJolhZYx8/wpZk0Bw6w1rEpB3s1IL0Pn00+TRa2jMM6
         58XqBpJbVCn6y0MnH/cRgGa/k+JeX8M47tYIMwsAcTlAWlT19ItgPZxMLeXeZ95s21bM
         KWRs4B4ZQPWwMuFZ20ku3Eqb13mFl5JMFj7BErEiNfuQuPqGhCK/LSrWIGlGPqAjUZ9Z
         ZNpw==
X-Gm-Message-State: AOJu0YwEPnRg5TbrKsIwfNa0rZGxx9NEymZAoNjqPLt9V6wBcC/6xFRx
	B6ZWBWGYx2oWymbGLGfKNklvT3zom2ulx3ehKRYStNGSns1d/4uxNqrsww2JCQ==
X-Google-Smtp-Source: AGHT+IFo90vGYU3eEuFFCPMHDJf0nhS3kXeAxT3Zj00puqxF0lObHUnLgDxaWYxVecMwl5Fnuys6hQ==
X-Received: by 2002:aca:2b17:0:b0:3e7:c4ca:9dfe with SMTP id 5614622812f47-3e7c4ca9edcmr9843721b6e.31.1731996882903;
        Mon, 18 Nov 2024 22:14:42 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7bcd8413csm3512421b6e.35.2024.11.18.22.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 22:14:41 -0800 (PST)
Date: Mon, 18 Nov 2024 22:14:18 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Sasha Levin <sashal@kernel.org>
cc: stable@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: FAILED: patch "[PATCH] mm: revert "mm: shmem: fix data-race in
 shmem_getattr()"" failed to apply to 5.15-stable tree
In-Reply-To: <c27966fa-007b-97dd-c39c-10412539e9d3@google.com>
Message-ID: <064fe883-6d13-15f4-1991-3f176c7d5c95@google.com>
References:  <c27966fa-007b-97dd-c39c-10412539e9d3@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 18 Nov 2024, Sasha Levin wrote:

> [ Sasha's backport helper bot ]
> 
> Hi,
> 
> The upstream commit SHA1 provided is correct: d1aa0c04294e29883d65eac6c2f72fe95cc7c049
> 
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: Hugh Dickins <hughd@google.com>
> Commit author: Andrew Morton <akpm@linux-foundation.org>
> 
> Commit in newer trees:
> 
> |-----------------|----------------------------------------------|
> | 6.11.y          |  Present (different SHA1: 285505dc512d)      |
> | 6.6.y           |  Present (different SHA1: 552c02da3b0f)      |
> | 6.1.y           |  Not found                                   |
> | 5.15.y          |  Not found                                   |
> |-----------------|----------------------------------------------|
> 
> Note: The patch differs from the upstream commit:
> ---
> --- -	2024-11-18 22:45:37.221809852 -0500
> +++ /tmp/tmp.gWYpEchJE1	2024-11-18 22:45:37.214517918 -0500
> @@ -1,3 +1,12 @@
> +For 5.15 please use this replacement patch:
> +
> +>From 975b740a6d720fdf478e9238b65fa96e9b5d631a Mon Sep 17 00:00:00 2001
> +From: Andrew Morton <akpm@linux-foundation.org>
> +Date: Fri, 15 Nov 2024 16:57:24 -0800
> +Subject: [PATCH] mm: revert "mm: shmem: fix data-race in shmem_getattr()"
> +
> +commit d1aa0c04294e29883d65eac6c2f72fe95cc7c049 upstream.
> +
>  Revert d949d1d14fa2 ("mm: shmem: fix data-race in shmem_getattr()") as
>  suggested by Chuck [1].  It is causing deadlocks when accessing tmpfs over
>  NFS.
> @@ -13,21 +22,25 @@
>  Cc: Yu Zhao <yuzhao@google.com>
>  Cc: <stable@vger.kernel.org>
>  Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> +Signed-off-by: Hugh Dickins <hughd@google.com>
>  ---
>   mm/shmem.c | 2 --
>   1 file changed, 2 deletions(-)
>  
>  diff --git a/mm/shmem.c b/mm/shmem.c
> -index e87f5d6799a7b..568bb290bdce3 100644
> +index cdb169348ba9..663fb117cd87 100644
>  --- a/mm/shmem.c
>  +++ b/mm/shmem.c
> -@@ -1166,9 +1166,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
> - 	stat->attributes_mask |= (STATX_ATTR_APPEND |
> - 			STATX_ATTR_IMMUTABLE |
> - 			STATX_ATTR_NODUMP);
> +@@ -1077,9 +1077,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
> + 		shmem_recalc_inode(inode);
> + 		spin_unlock_irq(&info->lock);
> + 	}
>  -	inode_lock_shared(inode);
> - 	generic_fillattr(idmap, request_mask, inode, stat);
> + 	generic_fillattr(&init_user_ns, inode, stat);
>  -	inode_unlock_shared(inode);
>   
> - 	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
> + 	if (shmem_is_huge(NULL, inode, 0))
>   		stat->blksize = HPAGE_PMD_SIZE;
> +-- 
> +2.47.0.338.g60cca15819-goog
> +
> ---
> 
> Results of testing on various branches:
> 
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-5.15.y       |  Success    |  Failed    |
> 
> Build Errors:
> Build error for stable/linux-5.15.y:

Sorry, I've not received a mail like this before,
and don't know what action to take in response to it.

I notice that this 5.15 one says Build Test Failed: that's a surprise,
it built for me on 5.15.173; but perhaps something has gone into the
queue since then which causes it not to build?

Or perhaps this is just a bot mail to be ignored?

Hugh

