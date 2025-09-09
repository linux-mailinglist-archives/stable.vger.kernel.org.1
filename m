Return-Path: <stable+bounces-179025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF37AB4A0DC
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 06:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D511BC1D7C
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 04:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E452EF652;
	Tue,  9 Sep 2025 04:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xf2hMHBl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201C2459C9
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 04:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393114; cv=none; b=fFvd7kGWP2RG7GlGXu5al7t6cDUaPZnCaGHs0fYAbJBGti2IjdRI3Zbo7YP3wRqRVy4cBx/0DCY4bl+0vqmC8IMcl76TZiZUuKOxrZtArE3b4WVUPVmZGSuy7CT1tcXZCCIXnD4YcxV6TibffwkxP7HzKVfDWLWPSVZoC7EauuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393114; c=relaxed/simple;
	bh=h2zLb98Re6+TqRKu8El0vTIE3NVBQlmVT7tAxCoi1P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acdmvzzT36DzUpTGkOOKwHG2haJa3OX/TPHUh8GjaTotSXZ2h8EnAWXwDYDY2hLaGFbB/8WDREyifsaKbLImwgE1a+fG/wlttdnF89jzhTb7XQ8aNbbCM4DKtAraoVLmuUrSlyML2vSfTBiBdQoiE6RKrAKLCfNSKJ5I4iJapZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xf2hMHBl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7722bcb989aso3891383b3a.1
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 21:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757393112; x=1757997912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw9FRVGeGdiCd/bJmRIQ4WxU0vZY58/+OsQY+gXf61A=;
        b=Xf2hMHBl+UXL8Lp3bTw79IOd9pGlCaUUfYkJFA3vr/qq3N5kaKV9YNd4RoikmNY0xx
         h7WJmVSu4g7UWkRy/EVdL3FtOwr6y56r9QQ+7a7cPOIIa2CEMsNTuZ45ZKRlN0F4OQaG
         e3ZukZasF7Crsx1jKp2oxpk0DOJ1SC0J0snt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757393112; x=1757997912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw9FRVGeGdiCd/bJmRIQ4WxU0vZY58/+OsQY+gXf61A=;
        b=xHY+QV8cxpyBZuNSNu8sP8Zz38feUmxFWNxVo29sqomKBaYaPj/Bqt5cU/Nygf50AC
         BCsWQvZ7RvAN3JbDHMU7qb37KMrGALk2eHn3A3tuEctmJwLO1bHRNaKkwkCu0U3psY4f
         ssFDTPVKsHQdzhyVWyhKVBsWaEpK89VVd2HA3gFL0Pvoayv5+lyHmefg6/gzJnXy3ufY
         XqtIPpiJQ+bd3ruO8hGnEenbKWphTV19BOxr2U13LR8iHaSUq17mUhjMP8Ryn+0qM7Yc
         rWiEDO/Gf8xsHUGTJUi7tJQDrl6PH494Mx17piKVHWs136a1MWzanhb5eUpzJEfYWdFC
         ydxw==
X-Forwarded-Encrypted: i=1; AJvYcCVWNrTqyO3Aw1rjJdxqUv3cMEeDDII2pySjyzI+Ct+WuLruABUDxGZI3vHobBbj380DjTnl228=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB4+KwqYgErxUZc6oFwGFbmpreOm9TQrf7Gqlz6ZBjNEu0w++x
	AuKjF6UonoiUUPHpfh8QBG6fK7dFTriWpVN1olI7f3vwV/abqvgE2BcYeKReSD5lLA==
X-Gm-Gg: ASbGnct3XF1Q3acwQ0fAtL6APJd1A7p6+OfbVL0jEyn3kyFIgrfkTI7ZFUcv7Uvrk2j
	kqKD03Q8WV3kf72oBIgUOSnG80P1xPT+NFzD+I/NsfxwLIIr8XAKw+pvgvWNFNNEMd6LRIroNTY
	UwG+CCaEETEbVwFfqmoxJydjsWd7/Bp+F6IYV3bGTYgC1Z3ERYKNVxrrcRtIY1QhmH+3aIcgJ/B
	ht+A7VvMvtrueWeyi0nW+eTbCyRFcHOGBzupOB8yCc0DkGuP7OjLR5Dai6U8ZjTTfgnTcLZGXS4
	lMKE7gEXii+MGdt3zSib6H6hpCLj/Pn2fwtEtTMElEKIb/J3IbjSR61cGJfqipbTVsSTUNgaf6R
	fojymmC+fgiV9J+FWWbcCVdJqBKEv45rn4AoU
X-Google-Smtp-Source: AGHT+IGCqtZZ46cDNSS0o0PTPi1cbO52ZNRmi+3GMrDkXr5MYMYXI/v2R/W4TFVfMyFz8piB9a3T8Q==
X-Received: by 2002:a05:6a20:2588:b0:243:a2fa:e526 with SMTP id adf61e73a8af0-25340b1a86bmr17101612637.25.1757393112270;
        Mon, 08 Sep 2025 21:45:12 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:337f:225a:40ef:5a60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd0e1cfbbsm27816286a12.23.2025.09.08.21.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 21:45:11 -0700 (PDT)
Date: Tue, 9 Sep 2025 13:45:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Changhui Zhong <czhong@redhat.com>, Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix slot write race condition
Message-ID: <hpzh3r5ie2lc6abtaefhmijoxwem3f3myjixjzup2npcgd4hfh@vmqtdxtoeu6c>
References: <20250908193040.935144f444ab0e14c2cdde60@linux-foundation.org>
 <20250909043110.627435-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909043110.627435-1-senozhatsky@chromium.org>

On (25/09/09 13:30), Sergey Senozhatsky wrote:
> @@ -1848,11 +1851,6 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  	unsigned long element;
>  	bool same_filled;
>  
> -	/* First, free memory allocated to this slot (if any) */
> -	zram_slot_lock(zram, index);
> -	zram_free_page(zram, index);
> -	zram_slot_unlock(zram, index);
> -
>  	mem = kmap_local_page(page);
>  	same_filled = page_same_filled(mem, &element);
>  	kunmap_local(mem);
> @@ -1890,10 +1888,11 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
>  		return -ENOMEM;
>  	}
>  
> +	zram_slot_lock(zram, index);
> +	zram_free_page(zram, index);
>  	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
>  	zcomp_stream_put(zstrm);
>  
> -	zram_slot_lock(zram, index);
>  	zram_set_handle(zram, index, handle);
>  	zram_set_obj_size(zram, index, comp_len);
>  	zram_slot_unlock(zram, index);

Let me send v2 shortly.  I don't think I like overlapping of
slot-lock and stream-lock scopes.

