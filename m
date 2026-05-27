Return-Path: <stable+bounces-254474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2By3OvhoFmqLmAcAu9opvQ
	(envelope-from <stable+bounces-254474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 05:46:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1E55DF08C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 05:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0B7A3033D24
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 03:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71396246762;
	Wed, 27 May 2026 03:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ayj1HHei"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0AB54739
	for <stable@vger.kernel.org>; Wed, 27 May 2026 03:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853544; cv=none; b=dsROzaOgaJd5qR9o86bsdAKtNATYOQaHGsmh7kZSNH/QeiYyQjaPJZRO9rVqDKvoB0ZTTM54wczQDfFC+3cI7Wf+hlm6DGffc3nHR7W8XedEpLsuhnGh78GxfgqXUMrHUgPTDDJSGo6ryuAdUc0SWLkl2Etu1Arj2DwD+rn8OnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853544; c=relaxed/simple;
	bh=RB6k6fJeesvAOl3RIkf0eAcn1RQtk89RN7lhQyACCTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+1e985BZUvsmWzU8NmJ5ph/8Sy9OcjQgWXXElf7QNhd1T0rXHwYx0Qxr/9HEzoRZTlHWvhVwAD53aY6viQFyC3v73NBsQdjO5AAd/2b1pQFmOjIqBrby15qs/WM+gkAl1XASVVTMZ45zmAa9lFMHMjbS5LPCbJtJuSDLJYcoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ayj1HHei; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b9ec9443c2so63382025ad.1
        for <stable@vger.kernel.org>; Tue, 26 May 2026 20:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779853541; x=1780458341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIzXofIA1kQTMtH8bue4R/Y/pLpr9GrF0sr5GiXdihw=;
        b=ayj1HHeiFDESNa0nU4rAU236dEYHpGQ9unLqwSyokZNmPI2sOv/iMP9QAuyRfFEfCY
         KI2RKZmWfb9qsHManq3LX4O+V49ZVg5x4QLvjFoDuar+BX/EI2w++ekpe8Zmhol9yGk2
         pf5sBulDKqvqp8CENBNeaeHk97Q3Hht0JrJmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779853541; x=1780458341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIzXofIA1kQTMtH8bue4R/Y/pLpr9GrF0sr5GiXdihw=;
        b=hKIzoGWjMeayJHWImwPq+akKoj3So2RNvvDzlhzzTL3CAYsjm4/LFNjvS4na4j2HNc
         q5L+mjKk8uMGDlLlQliVIzxcmyyVwdLie0iyeSkJ+7N1anHy+FCezkv9K5UxBP45iR2n
         v+704xuQAeRqWVgj+M3wde4L1h3fNoDhOOvt1cHYB+b0vp2hAp/HoUgR05aJvwpcSThJ
         PTq28wskaCjynhPVlOLlc7JunkQSJQDj8L0UybGG2zwcIgjh9t8Z8hdSZKG8oDS4S14i
         9mKkpRNy2e/M7Oi/UE+ivsV/oncM/a4oWlENru3+KseVhYsWiqTYWb/NrWSJoXJHKrU3
         wr+A==
X-Forwarded-Encrypted: i=1; AFNElJ9pmd7y7c7GNTIfYRM4Nzd1PJXYW3RBVr/JYECBN5Tg6mlCDZ64LvW82KqvNxnFIv9n3hL62V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywBC38pXe2H6XW573FMnbm8VWZ0vObf7j99yDRurkR0oCJrrTA
	yv4dLnm4expn1Kjn5ox09wUOrLy+y80aqH5DJYBDSm4sfWrpkryMW/jo2DvNRcjM0g==
X-Gm-Gg: Acq92OFk0ryBD9OqBt+g5ZGWwsjiyhB7aXBnELGqBBU6MweWHBBjerFOlcS0b6VrScG
	qUAQAl3HbDFNj8wSSD8qaEgkU9V+vI098NyNpL+pS4QsRnPIdTWYt1jd2AAs87oT99BxbnoP0qN
	eEHgV8+ypOylNUS9YCKdHqeiFDgEilYPhfZHqSJEU+o+xJbdJJUaNS7FKJ+nlAb+XZMpYg4Xo5R
	A6PPuRjmhze2xPQZC1m8dXOK1W30LkDRdDn9wPRE5uSLjeqOYCZ1/Y9Lr9uHnWITuBxbKKL4xPw
	XPft0zDdZ42kwfn6AgTeDqjb9OtTXcJ/W9hHUEpho+BPuoF/8ygomPCYw1Yw8KkrFE588LVD4b0
	saDLnBANA0Et1cFoV6F0GJ8krlLdIf3vj/rMPzj4xhE3N0v0WKuLBP2es7ux/fW283Ax41rB3IY
	+l8CHEI91aPF5Pppl2VP18kDbN63UkYss9dX3ufm5RJNM9VTZiBGKW1UR2o+WS5VBBdmNa/cOjB
	A==
X-Received: by 2002:a17:902:d482:b0:2b2:ec33:cf15 with SMTP id d9443c01a7336-2bea20c02e2mr237439135ad.7.1779853541545;
        Tue, 26 May 2026 20:45:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:b55c:5b57:6435:9af4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2ccbsm141659055ad.48.2026.05.26.20.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 20:45:40 -0700 (PDT)
Date: Wed, 27 May 2026 12:45:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Cunlong Li <shenxiaogll@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Subject: Re: [PATCH] zram: fix use-after-free in zram_bvec_write_partial()
Message-ID: <ahZov_99kMxaTH2P@google.com>
References: <20260527-zram-v1-1-ce1acb2bfaf9@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-zram-v1-1-ce1acb2bfaf9@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254474-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lst.de:email,chromium.org:dkim]
X-Rspamd-Queue-Id: 4E1E55DF08C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On (26/05/27 11:26), Cunlong Li wrote:
> zram_read_page() picks the sync or async backing device read path
> based on whether the parent bio is NULL.  zram_bvec_write_partial()
> passes its parent bio down, so for ZRAM_WB slots the read is
> dispatched asynchronously and zram_read_page() returns 0 while the
> bio is still in flight.  The caller then runs memcpy_from_bvec(),
> zram_write_page() and __free_page() on the buffer, leaving the
> async read to write into a freed page.
> 
> zram_bvec_read_partial() was switched to NULL in commit 4e3c87b9421d
> ("zram: fix synchronous reads") for the same reason; the
> write_partial counterpart was missed.
> 
> Fixes: 4e3c87b9421d ("zram: fix synchronous reads")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
> ---
>  drivers/block/zram/zram_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index aebc710f0d6a..b23a8bbb687c 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2333,7 +2333,7 @@ static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
>  	if (!page)
>  		return -ENOMEM;
>  
> -	ret = zram_read_page(zram, page, index, bio);
> +	ret = zram_read_page(zram, page, index, NULL);

Sounds like zram_bvec_write_partial() doesn't need bio parameter then?

