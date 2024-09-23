Return-Path: <stable+bounces-76913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E8297EE74
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 17:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B46B1F2263F
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E2A199923;
	Mon, 23 Sep 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S8XXLT/U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA21E52C
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106464; cv=none; b=SfUQwshvcOlJ4ytL6KvX/Hrv4sW+GsUY6j0YfxBCPm49wbO5FJeZNbpkjT//W4Le+x0ex8gw53QvxVGAYFdsOLqGiBGFfmTDKHGcYDsTNWY3XYi6HtZCXBrgJdIp1mgedryu1iwJ0YfibSSO3kv+Fq1av66ersf+1TUNxWyvWyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106464; c=relaxed/simple;
	bh=6tBsekOVEbL/u8BkiyRDO7LBWxHubMJp54aDy0+CCIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEbPVYHBaUf/gpTE9ZF2VHOftjCq0VuT7EmNnEevSZJiV2k7T/oyF8I8dtqMIc/P0cgEgxqEDwKe3r5zmExMCGNyHtoKHee+nREZzaWuyIs3PY17MECdzwm83nM0tWgGbibyC7NqmcUrDtdu3T5Q6N88DUXnWty+l9/6qtvdzM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S8XXLT/U; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20570b42f24so48865615ad.1
        for <stable@vger.kernel.org>; Mon, 23 Sep 2024 08:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727106463; x=1727711263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQvRJDTU5M/Q7YFtH2baTOj185sy5Qo5fxlt2UwlPLs=;
        b=S8XXLT/UDhfNEiKrS46JgCZVy5zEy4YniOJ+lmNOsla5rm/ZVFQqaePzBkZvrb+zRu
         3EpPhD1wiEwnPwnEzN0vD5QyTSPsq8TDYq3am4E5FmcFIDDEp3N53lBSPn5U6x/Usrn8
         /aB7VhcwPaI1NDPOQZkjqj/LEq/aB07pd0mf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106463; x=1727711263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQvRJDTU5M/Q7YFtH2baTOj185sy5Qo5fxlt2UwlPLs=;
        b=GtmabyLRhatZjQP9Kt1ZscaQ8CJ+tTd9D1eh1qOuxjgIWsRdW80RVJai0J0enAj4HV
         4MeY0MDlI6XVOTr3YH8eSG3LRRm1JqoqjSQikZLogA+ycdQXxq4GzOf/6DxwU8jxcr7I
         nRr7HqArqRezHCNPhR93KeIBzXIqm43i38QRQiCmaFetkMFFhsi45VMMn9ew1BU5FBLN
         eZGnbmohQ6yjCwHSryHmmM5xAQqod3das4aiw/q+v6c3QCQkt48eaMxUajhV3kypcKRZ
         7/s2cnuLFRT+z2W8KlSnx1UfUgesvflJ1wmESTvG1MtXyE8nb64JCRaTx4mui7m61ZQW
         XmQg==
X-Forwarded-Encrypted: i=1; AJvYcCVqRjx3xedwyBuGSRS59/nD1+QpqoS5Rvx6WGLQSjCsGHsKAT2Bn11R0+PNg7rQ6ZIKxo4fzok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvk7z2p6Ke6sq+3h22l0tCMYxCwRT4oHEWLOXwIMF2g+ybvr9B
	ef6zAxCcaeVo3kWdc+r2FGVs05gzPRxlz/XgR7MEBos08aIp9Xk2q42M1sakDA==
X-Google-Smtp-Source: AGHT+IGUc2twRnaEQXb08Noipu97AHfEkG7UmGX3BFwRhuwwWRnJvapkHauas0XeVKCV6OmcnBRp7w==
X-Received: by 2002:a17:902:f650:b0:205:3bdb:553b with SMTP id d9443c01a7336-208d833d0d0mr198432615ad.16.1727106462945;
        Mon, 23 Sep 2024 08:47:42 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:fd63:e1cf:ea96:b4b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d1554sm134149685ad.144.2024.09.23.08.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 08:47:42 -0700 (PDT)
Date: Tue, 24 Sep 2024 00:47:38 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zram: don't free statically defined names
Message-ID: <20240923154738.GE38742@google.com>
References: <20240923080211.820185-1-andrej.skvortzov@gmail.com>
 <20240923153449.GC38742@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923153449.GC38742@google.com>

** Re-sending properly, somehow I managed to badly mess up
   the headers the first time, sorry ***


On (24/09/24 00:34), Sergey Senozhatsky wrote:
> On (24/09/23 11:02), Andrey Skvortsov wrote:
> >     for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
> > -           kfree(zram->comp_algs[prio]);
> > +           /* Do not free statically defined compression algorithms */
>
> We probably don't really need this comment.
>
> > +           if (zram->comp_algs[prio] != default_compressor)
> > +                   kfree(zram->comp_algs[prio]);
> >             zram->comp_algs[prio] = NULL;
> >     }
>
> OK, so... I wonder how do you get a `default_compressor` on a
> non-ZRAM_PRIMARY_COMP prio.  May I ask what's your reproducer?
>
> I didn't expect `default_compressor` on ZRAM_SECONDARY_COMP
> and below.  As far as I can tell, we only do this:
>
>       comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
>
> in zram_reset_device() and zram_add().  So, how does it end up in
> ZRAM_SECONDARY_COMP...

Ugh, I know what's happening.  You don't have CONFIG_ZRAM_MULTI_COMP
so that ZRAM_PRIMARY_COMP and ZRAM_SECONDARY_COMP are the same thing.
Yeah, that all makes sense now, I haven't thought about it.

Can you please send v2 (with the feedback resolved).

