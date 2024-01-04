Return-Path: <stable+bounces-9727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99438824965
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 21:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED2B1F229DB
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 20:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674742C686;
	Thu,  4 Jan 2024 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X83+jIj2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2602C1B8
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 20:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d4d4542526so6548095ad.0
        for <stable@vger.kernel.org>; Thu, 04 Jan 2024 12:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704398843; x=1705003643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YLSMLw3CY5enyJrlnZCSgZcMGXvfBG/L9/rEmHMxBQ=;
        b=X83+jIj22WYb2IdG6GS6spXt/o0/Q0876Smbve9wClQ8+Nzr3hWS3R+BXj+SwrlyUW
         bDHPHp5jI7tjSKDRFhqH83JQAUFUuxfGzZP5ZAIx6reEQAQEb7YFfKHgN9I2c8nddKWL
         i+smRnRMcVwYrFX+quETS7XxyfNOGUVbetcLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704398843; x=1705003643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YLSMLw3CY5enyJrlnZCSgZcMGXvfBG/L9/rEmHMxBQ=;
        b=W+Uo/PcLSrSgvHqScA3A4NnzFg6YYBQmIL7YOOKAL9lf5opQPn8a6sl2ZvFQrij8zj
         vNR6W1zollLoXsBZ98HekhmLYNWsGaeWF9SuIIfayo8BbxLHXci6Qgulwjnv05APMFd2
         ydaf9aMsIydRkieYOMqQvy/alyc7wLYboK52tyKGTy7c9AWqu6GSuVVHRY7ekkkgt0bT
         0zaYEegYhtZzQ3S89x4hiOHsYxqjAfgjyhxGNs9ywalvm9jiIQk2wQ9pQnZ6uT1JrZ7P
         Kyc6WfbtRJsm+N1/dOpNBJDo+9zs1iTkrukSmyK7D9HdmnwKOht7zPO9dYemw+1JEbDW
         WKnw==
X-Gm-Message-State: AOJu0YwQG+FhCr1o8eLT5zv6ymZhgk0FHFCs6J+MEjaMN8GlVhKvW91/
	DrlsYJgy8Sbjr47Tq4M3/Qm4LUruB24C
X-Google-Smtp-Source: AGHT+IEGR0y20O8samcL5RxY53LiLUqPfQRV6dAhF6tas/ZaJGLQkurEVTsgTyDT9+apOLYHGQMAlw==
X-Received: by 2002:a17:902:a50a:b0:1d4:477c:4753 with SMTP id s10-20020a170902a50a00b001d4477c4753mr988293plq.42.1704398843036;
        Thu, 04 Jan 2024 12:07:23 -0800 (PST)
Received: from C02YVCJELVCG.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902ed4300b001d4ac461a6fsm13979plb.86.2024.01.04.12.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 12:07:22 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Thu, 4 Jan 2024 15:07:18 -0500
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 055/156] bnxt_en: do not map packet buffers twice
Message-ID: <ZZcP9qZ0G0sS_IPK@C02YVCJELVCG.dhcp.broadcom.net>
References: <20231230115812.333117904@linuxfoundation.org>
 <20231230115814.135415743@linuxfoundation.org>
 <ZZQqGtYqN3X9EuWo@C02YVCJELVCG.dhcp.broadcom.net>
 <2024010348-headroom-plating-1e2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024010348-headroom-plating-1e2a@gregkh>

On Wed, Jan 03, 2024 at 11:04:11AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 02, 2024 at 10:22:02AM -0500, Andy Gospodarek wrote:
> > On Sat, Dec 30, 2023 at 11:58:29AM +0000, Greg Kroah-Hartman wrote:
> > > 6.6-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > 
> > No objections from me.
> > 
> > For reference I do have an implementation of this functionality to v6.1
> > if/when it should be added.   It is different as the bnxt_en driver did
> > not use the page pool to manage DMA mapping until v6.6.
> > 
> > The minimally disruptive patch to prevent this memory leak is below:
> > 
> > >From dc82f8b57e2692ec987628b53e6446ab9f4fa615 Mon Sep 17 00:00:00 2001
> > From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> > Date: Thu, 7 Dec 2023 16:23:21 -0500
> > Subject: [PATCH] bnxt_en: unmap frag buffers before returning page to pool
> > 
> > If pages are not unmapped before calling page_pool_recycle_direct they
> > will not be freed back to the pool.  This will lead to a memory leak and
> > messages like the following in dmesg:
> > 
> > [ 8229.436920] page_pool_release_retry() stalled pool shutdown 340 inflight 5437 sec
> > 
> > Fixes: a7559bc8c17c ("bnxt: support transmit and free of aggregation buffers")
> > Signed-off-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> 
> I do not understand, what is this patch for?
> 
> Why not submit it for normal inclusion first?

Greg,

I wondered if my description was good enough -- it was not.  :)

The sole purpose for sending my last email was to let you know that this
problem also occurs on v6.1 but in a different manner.

In the process of fixing this problem on the tip of tree I noted it was also an
issue on older kernels, so that was why I brought it up.  

This is a bit confusing as the Fixes: tag was correctly set to changes that
were made for v6.6 as it was the first kernel where this type of leak was
noted.

Hopefully that resolves the confusion.

-andy



