Return-Path: <stable+bounces-98726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2B09E4DFE
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 08:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87883167FD5
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 07:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82461ADFEB;
	Thu,  5 Dec 2024 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NsO9kCsX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CC2F56
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382587; cv=none; b=caoJ3lTgSu7Jn0SRp4bPKYeBslABGfoCq/3E7HTYKnCTKjfR5rjo9UUiCQKuF069U7zIF6h1+AV0YVZc1M6nHtamx7Acwcz1p6nwkOZK54nfvPajYXpCXjdAShRYDe5ZaeDQvfpJROCbJ6479W0oIblSdOutgb+KeOdsXdH8ssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382587; c=relaxed/simple;
	bh=grkbsRH6D4ZYbAuOb1wmAAyXnV7iDlG0b6TewkJIGas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhV98XCcILYdsoOfmMx5+sK/aW9Udb/95fdN/mDEOMkE8QCRiKKi7gw7isB8G5LjMHJbw0/+BfJQnmy78Hnt+c5NKtlbrQzfAIbEMfNbhWB6ibOjB8ZIjLYrLU5wIj0yd4PnwYmVpKZH/dOA8W5aZ4Gt4hEhlcckMfZHRJG0a8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NsO9kCsX; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fcc00285a9so653136a12.2
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 23:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733382584; x=1733987384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SHVMmQ/KzbcoO5ieQjC56n0uvyFf9M/Mj/sBzX0iX8s=;
        b=NsO9kCsXqWNmeiqUXxTVF1KOXwcQtipmoak50kQZQMmK89e+Y3q7VfDOcOrUJb215S
         30qmslclFKHLfVF0YXJ4r3429pPKL7d8uSaAXoJ5Yjw5p5liTy3VW8hQ/pxYlqYb9S4T
         TfFaNRfkjmVRSfy/6sMdyAVzbFWBAyvcM7Ucw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733382584; x=1733987384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHVMmQ/KzbcoO5ieQjC56n0uvyFf9M/Mj/sBzX0iX8s=;
        b=Bp+/IMJRrYGISGTWhPAgLJsmNyaq8TOd+v9GGEkcUdnz6QrQf+5vg7y3TWwhWtOCmi
         0fMmzjndG3S253MOaXtSsbBRY7IZ2XVOHZ2x5UjWMJ7f0vQSi/G3zgBQv+Hl9X65TlmG
         3fA1NZyJRvITEAeoNUtihZQKjGLks9WM6ohCEiMEx4WA9Qzj1bEMfF3QOOWtbNlQD09h
         lJjKHtfdq1qsnNXv+cEt1qjsxZJWmxClxOn36fpb9Pz4/kfgtRfSRI6KxAeCTJ4lkBpv
         0sVLgWvayTUTl3it6fEVNB5dnFHub0tof3dwu6dZ+IN7ClKOBMbqEeYTju8jkiP/Sd9H
         owxg==
X-Forwarded-Encrypted: i=1; AJvYcCVd336sr5Ktz1McwoWFj8LeMNqufH+mqfuaQ1ghimKGJQ8veQTlfQs1PtBQXclwQExJOh0E1DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnygkaEPamD21Px2zt7tVRN24lIvi0eEPYTf2ud/Xw3rOA0+o
	axQY9S649edgkZiqqKQ30J3GfO4s1zGM28akV1V+UVydRUYFHHNB0ucy/2FbWvWRfcMuOtolCls
	=
X-Gm-Gg: ASbGncsWsJ8a+sLEfA33M4MfAPqsRCvn4hLBl6E/E3M/YEBwdOD37LZmgd28kUJ0PlC
	VWSOy0l3Wx86TZwYpZ3XM70RGcIxRGTpgrh/OZM87UCGHGgHKeCYd+x8wBpSQpwo3sD/RUCc7vF
	pfHYIdwFwtiJRMNrJCU8nIoiPWUhU4UTImVm31kZsfmZ06y0VVWR9LmELyaFGgS50RKDvUuSEes
	58TzIDY8LaCqVG50t51VHBifmzPh3tCZ314+fZ6jZcW3S78CULa
X-Google-Smtp-Source: AGHT+IG6kRB6dDFmeXz1ne2Hv+akOd+C09aPhvGPo0ufEzIuAUB/OWr1JBmHkYw/DqGSl8lg7DDPHQ==
X-Received: by 2002:a05:6a21:7e89:b0:1e1:6db4:8a29 with SMTP id adf61e73a8af0-1e16db48a6cmr8797451637.41.1733382584222;
        Wed, 04 Dec 2024 23:09:44 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:84f:5a2a:8b5d:f44f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156e1e20sm652384a12.32.2024.12.04.23.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:09:43 -0800 (PST)
Date: Thu, 5 Dec 2024 16:09:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Desheng Wu <deshengwu@tencent.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] zram: fix uninitialized ZRAM not releasing backing
 device
Message-ID: <20241205070939.GF16709@google.com>
References: <20241204180224.31069-1-ryncsn@gmail.com>
 <20241204180224.31069-3-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204180224.31069-3-ryncsn@gmail.com>

On (24/12/05 02:02), Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Setting backing device is done before ZRAM initialization.
> If we set the backing device, then remove the ZRAM module without
> initializing the device, the backing device reference will be leaked
> and the device will be hold forever.
> 
> Fix this by always check and release the backing device when resetting
> or removing ZRAM.
> 
> Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
> Reported-by: Desheng Wu <deshengwu@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/block/zram/zram_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index dd48df5b97c8..dfe9a994e437 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -2335,6 +2335,9 @@ static void zram_reset_device(struct zram *zram)
>  	zram->limit_pages = 0;
>  
>  	if (!init_done(zram)) {
> +		/* Backing device could be set before ZRAM initialization. */
> +		reset_bdev(zram);
> +
>  		up_write(&zram->init_lock);
>  		return;
>  	}
> -- 

So here I think we better remove that if entirely and always reset
the device.  Something like this (untested):

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0ca6d55c9917..8773b12afc9d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1438,12 +1438,16 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 	size_t num_pages = disksize >> PAGE_SHIFT;
 	size_t index;
 
+	if (!zram->table)
+		return;
+
 	/* Free all pages that are still in this zram device */
 	for (index = 0; index < num_pages; index++)
 		zram_free_page(zram, index);
 
 	zs_destroy_pool(zram->mem_pool);
 	vfree(zram->table);
+	zram->table = NULL;
 }
 
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
@@ -2327,12 +2331,6 @@ static void zram_reset_device(struct zram *zram)
 	down_write(&zram->init_lock);
 
 	zram->limit_pages = 0;
-
-	if (!init_done(zram)) {
-		up_write(&zram->init_lock);
-		return;
-	}
-
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
 

