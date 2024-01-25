Return-Path: <stable+bounces-15812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A718083C53B
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 15:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FD61C24831
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 14:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A19A6E2CE;
	Thu, 25 Jan 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="zsNaadqF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE086DD1D
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194197; cv=none; b=htMPUWUtNjwCqRo/Rk0m6dBRCrOyDPxobaGJzzQnxJAuCr50Qsu3F+m6Z97Q9jD2s2CfY8LrpwGB8VBOLBWmdWM+t3OCuSySkqdliBwVtbmtJxsg5T3QubjU+C3wrXySxx1+3Feln3q6HCxSG+InZxkcFu0sUXJ6nLeiVg6HDw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194197; c=relaxed/simple;
	bh=5utcNi5EbwXGXKE6XBUr2p3B+QtNTPUv/WMImZ3KMxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krBXgIqxoj67nRXx0sFvPIcHxr6j9AAM2eYXloB9l+n9lXDGy+TjloAKODOsRIc4zRd+P88ZD9Tx+vqDTr18ZcmrE0YZ92ncbd3LowazjyfuCshfC6ROyKIqfHFW60KU5sgv5iikArsfDJoIvSe4Vua57YWPd5flDMiOLpt9sn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=zsNaadqF; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a4516ec5dso24307761cf.3
        for <stable@vger.kernel.org>; Thu, 25 Jan 2024 06:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706194194; x=1706798994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1Jufmt29FN+BCLayi+KSCZM2a2FaZk0tkZi2gIXjUg=;
        b=zsNaadqF097doUCGMvDwAc4kbpCdddtucOLm97wr3wzsZwI8cAkIvcg8T2SSbpxiq7
         3jLnmw1BPUM5ha4zIIrBS5HxnO3F3nA5e1Fl41G0N4ScqMb3iDzwsPdcx5c+hZOl4RHZ
         FIGijc2nzjaOwGWjiSWvOYwuvQEjEn4E13OIl+7tg4TjdFOkYMceUiFMa8mj9LfvSZFc
         XHbBRhHoasA8eeCR0Z4V1XiH3/Ejp23zaFyeOtOd9pDZNyw1cKNeP7IPnEn9Cr1ONy8k
         eqdL5Suo/zJ+41NKIGILR9jkZWOLeQogGQaXb6H0dKwJfotrJbE8fTHjAxBkbZm79fzJ
         xdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194194; x=1706798994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1Jufmt29FN+BCLayi+KSCZM2a2FaZk0tkZi2gIXjUg=;
        b=AB6jZFq73f+L+Yyxpe9IBeK4wNeSuRo2ejRFGlppjyGEiI9cLole3s8zKjoqHxsiJT
         zy24FsKO6Bu0Ct5I7ijf/tQf+tldV9RJmGFoVkTDESQ7adPu9aEdXIT4U918fFiYmqQ5
         ooZ/5PzF4MQgMry2QZU9Dtz8Owvp7bLmyhw1XThpAT6PPoHO0tX8M4uXMqpw/Xff83qG
         mArXpIgtRDcp9kgyl381pcoWy++rPfXc2HBEJ9de2LMGjTnDqILhd1pt+Xt3xW+/T0/W
         z7JxjMg7q1QaAOX0j8MaeRdyB9c2oEsY6RScD6UDw5Mh2bHbE/MFB5Zah6vImpbypZZB
         DXqQ==
X-Gm-Message-State: AOJu0Yxw+r/R4nlxMnRQT16rDeF12bPZi23tNAOBim6/TmODujSSLIl9
	+r+Yk6hNV6gT7OmelV1yzgDLEG7ipgCvIAeeofHfcaBJSvKEXn/fdy0uTSvd+Dw=
X-Google-Smtp-Source: AGHT+IFMyIXKi0ksURve7d4Kvfnuupv44sbMBvOfwALrt+vAce7BUIIrP25e6L2zwFgSedr4IQ6wGA==
X-Received: by 2002:a05:622a:10d:b0:42a:3195:e8be with SMTP id u13-20020a05622a010d00b0042a3195e8bemr1205799qtw.51.1706194194446;
        Thu, 25 Jan 2024 06:49:54 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id en11-20020a05622a540b00b003f6ac526568sm5420997qtb.39.2024.01.25.06.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:49:54 -0800 (PST)
Date: Thu, 25 Jan 2024 09:49:52 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: fix missing folio cleanup in writeback race
 path
Message-ID: <20240125144952.GE1567330@cmpxchg.org>
References: <20240125085127.1327013-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125085127.1327013-1-yosryahmed@google.com>

On Thu, Jan 25, 2024 at 08:51:27AM +0000, Yosry Ahmed wrote:
> In zswap_writeback_entry(), after we get a folio from
> __read_swap_cache_async(), we grab the tree lock again to check that the
> swap entry was not invalidated and recycled. If it was, we delete the
> folio we just added to the swap cache and exit.
> 
> However, __read_swap_cache_async() returns the folio locked when it is
> newly allocated, which is always true for this path, and the folio is
> ref'd. Make sure to unlock and put the folio before returning.
> 
> This was discovered by code inspection, probably because this path
> handles a race condition that should not happen often, and the bug would
> not crash the system, it will only strand the folio indefinitely.
> 
> Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Ouch, good catch.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

