Return-Path: <stable+bounces-248927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOJCGpaUB2pU9AIAu9opvQ
	(envelope-from <stable+bounces-248927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:48:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D190D5586DF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E48EC301C6D9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 21:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5246B3EE1F2;
	Fri, 15 May 2026 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkEXh7M5"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256A405C21
	for <stable@vger.kernel.org>; Fri, 15 May 2026 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881463; cv=none; b=UyGWakGWYgEzvlMPmqHTVZK9p8EHq3+oDL4ufYt/dHG6QdO/bxqO6xcb/HTOyWJKhnAOrXfMJLjwapBnMnqjlVD63LCo5tOBIDlRKDGjl1eY/lVduCx6P2bLxY9lniSZTJMG6dtn8jtcE5pB2fOjn9PiM8nbFiiLwGYqY1uzMXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881463; c=relaxed/simple;
	bh=An5D9p+EUiNzuq65UFLmP+yFhJds1Oq2E/WMsv+uYmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1dtANY9njzHfebtv/DqA+ZdE8mPEN5UwIkeHmUQpNoGwSxtsecC7j6/08JjtuWbMjQfnegTcproE8kb0w90RVHFF6+TySwGSWqoH6rH4tlHqO1LwoSwdBSq0jU2py1QFvaoP9MSgvRDipLnnPmp+/QmxvCcABGpIHJI5is8BzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkEXh7M5; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65e170f1ca5so703246d50.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778881461; x=1779486261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI2tbQ3gv/rOPLpkzmuHjc3hm2p0ykSJGbw2DjymBGE=;
        b=QkEXh7M50fKvXpfKRL/LAQmfuV0uT1VEPiQb67BSIYxo937UfJz9IEYNbh431bH/vm
         FgXViwWR0zJYh7i4A+aMe40vKt3NR2jf2k/BrF+oeF9DeDvS8Lu16wfJ6jCkEfIpEg/F
         ZrjSXmOxkdnVmmJJ9ShooWeqCsN4Bp2xOM6a3fcwKEaeguH0z4HrblHwAmgdF85hr53P
         62SAeYVQEsocX3NCilxE2TejiUOVTk6MemoroaVigdDwNbragbdLZg9oJfH7W5FDheNP
         P6GAgozzyhf+mWzj0PEvCjI9jAXIZYhSakxaT37uPHrejLrOro5CHFYyR/5w4RiXBKGN
         XTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778881461; x=1779486261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kI2tbQ3gv/rOPLpkzmuHjc3hm2p0ykSJGbw2DjymBGE=;
        b=lP6NsTbU4oAJ8nlSjKGm0kaov0XsUnLKvnLpPo9k6iDbVPbTEpraDT4s3yk+FCH5W5
         boMHZQe8644Ksz6vnDyrtbFimNWWczo5nr49Rt//7j3PEtzxFerpJ3UMeZWoGy9gaRcX
         iNlGglNA+crtsPRJjfVrsf4/u3hhvZDKPIpZA+v7ybda40CIB0yafQ600+ojv/rwFYi/
         sNXvW0JdxnacGg0t1W9FEMpWNAnGCzyWTdwheorHkfDLG/IvpLUpiGSlksRtA7qEYaGf
         CljW8+npI3stMK/+Vfbz1/VX5NC8tbzBCXmLspxiFf92Rde7zqkMP4m/kUJB1y6k9Gwj
         Enxw==
X-Forwarded-Encrypted: i=1; AFNElJ8x9kxsLLnyVOro1axTfb2dcdxdUQetLeFqEq7ZFWITmA2zYN8in+lvzIU5fEr9LuIG56EFP7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTiIUoanoHOVfVIg4qTbFsWfkLYwO9KDAzeW6v5zTxd8nuT22F
	/xPlApJFkM4IijfsA8onKqo2SOJdjexAM1mO7Q+7clyPOJpaoTojeVY+
X-Gm-Gg: Acq92OF9nSZfXnwn4iDzShKj0cJqYRPGh2pWFEMvyBQyVh9UAgUIlDZU8Lo+wYIIRkD
	+iXt7thoFCzTLjgeal2f4RpIYiSnJ22imJAISKdeg+g57qMchRMdvLIdk3ZTzZDmFVAWKfdgTaL
	DZ66vghuT5mXXEoMyInBPSsa6npWKxRwRHGaXeL2GNTvGZzm8fgzqmQXaFPrZocQpljkup2VKQA
	xpZNtyPw5eRdyxhtgUw1X067esnZovmbVc59PJI2djD65wcvlMqo/+OtyJaHi1hYw3SHBocQ94+
	Janbg8xxP5Ao/lz8uncpJGPY0ydSe2TzPgZQc3dGm8zzbapiCf9h9RkVd9z3WdAaFgsES9cqjZv
	f6LHYmeOIEyVJbjQP9UV3jRjr85DU1j8kLjCLm2n/XVQEeoBPJ9ffmJr52mekMeYf7aMgVHD510
	uzQvjAabvPUIr7GoeuO5Pm6J9kW2WLbnuO4fsAemnR1b1pkdXLQd7mp9uNb7IKpgU=
X-Received: by 2002:a05:690c:c513:b0:7b3:9f53:9374 with SMTP id 00721157ae682-7c959e88e51mr72446817b3.3.1778881460615;
        Fri, 15 May 2026 14:44:20 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c92e2e978fsm22034177b3.24.2026.05.15.14.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 14:44:20 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	joshua.hahnjy@gmail.com,
	mawupeng1@huawei.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: restore subpool used_hpages on alloc_hugetlb_folio error
Date: Fri, 15 May 2026 14:44:18 -0700
Message-ID: <20260515214418.3259977-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515202902.461539-1-devnexen@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D190D5586DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,linux.dev,suse.de,kernel.org,gmail.com,huawei.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-248927-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 15 May 2026 21:29:02 +0100 David Carlier <devnexen@gmail.com> wrote:

> Commit a833a693a490 added a !gbl_chg guard around the
> hugepage_subpool_put_pages() call in alloc_hugetlb_folio()'s
> out_subpool_put path so a failed allocation wouldn't drive
> h->resv_huge_pages negative.  But hugepage_subpool_get_pages()
> increments spool->used_hpages whenever max_hpages != -1, regardless
> of whether the request was satisfied from subpool reserves or needs
> global pages.  When gbl_chg > 0 and a later step fails (cgroup
> charge, dequeue, buddy alloc), used_hpages is never put back.
> 
> Each such failure leaks one count; eventually used_hpages reaches
> max_hpages and the subpool refuses every further allocation even
> though no pages are held.
> 
> Commit 1d3f9bb4c8af fixed the same defect in hugetlb_reserve_pages();
> apply the equivalent restore here, guarded by spool and max_hpages.

Hello David,

Thank you for the patch!

I noticed that this patch is quite similar to Zhao Li's patch [1] which
seems to address the same problem. Have you taken a look at his approach?
From what I can tell, the code change is also quite similar (except comments
and additional guards in the else if branch).

Just wanted to bring it to your attention in case you haven't seen it yet.

Have a great day!
Joshua

[1] https://lore.kernel.org/linux-mm/20260428114126.92091-2-enderaoelyther@gmail.com/


> Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Wupeng Ma <mawupeng1@huawei.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/hugetlb.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index cfb7cb2e9806..9614330889de 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3010,9 +3010,22 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  	 * put page to subpool iff the quota of subpool's rsv_hpages is used
>  	 * during hugepage_subpool_get_pages.
>  	 */
> -	if (map_chg && !gbl_chg) {
> -		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
> -		hugetlb_acct_memory(h, -gbl_reserve);
> +	if (map_chg) {
> +		/*
> +		 * Put used_hpages back for the global portion of the request that
> +		 * was never actually consumed; restore the subpool-reservation
> +		 * portion via hugepage_subpool_put_pages() so rsv_hpages is rebuilt.
> +		 */
> +		if (!gbl_chg) {
> +			gbl_reserve = hugepage_subpool_put_pages(spool, 1);
> +			hugetlb_acct_memory(h, -gbl_reserve);
> +		} else if (spool && spool->max_hpages != -1) {
> +			unsigned long flags;
> +
> +			spin_lock_irqsave(&spool->lock, flags);
> +			spool->used_hpages -= 1;
> +			unlock_or_release_subpool(spool, flags);
> +		}
>  	}
>  
>  
> -- 
> 2.53.0

