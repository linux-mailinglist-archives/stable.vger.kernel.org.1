Return-Path: <stable+bounces-141752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA70AABA28
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 09:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76475A18C0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3305222CBE9;
	Tue,  6 May 2025 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xltf+vph"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332612D47A7
	for <stable@vger.kernel.org>; Tue,  6 May 2025 04:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746505566; cv=none; b=qhFZGSweOwcVFpN607oOK1ZnqzuGpvx4khBZKCcF5+jdEiCl4c3mvellftjMjuyLFkOX43muwVFrKj9ww0imfzqD2ElyusZBdEtxU0HIgTeyGMIEtwzrDg53P4wwNUeG3/PIqftn95/oR49L5/fQAqkJY4cMbI0B/M7rErAeX2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746505566; c=relaxed/simple;
	bh=TccdsHTZ4zEQ0BZo6VZ3JHzZ41BfCgq+4cveb1ajcCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDuWNgazpnhRoDmFnaX533jww0JmlgxWkh3CCTfeEhNfjIydfbMAW8RLP9XY7dKQltUvlA7sGhauOAIXTbyjxBInGwMv8snvSUkHLtCJFH+BQ6up8Gp0FFbAf6Prs3aqf0dAdi821m2RuczE6VfK9h/N3PADTmfORAjUas80vR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xltf+vph; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7403f3ece96so6852494b3a.0
        for <stable@vger.kernel.org>; Mon, 05 May 2025 21:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746505563; x=1747110363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lpTvVcHQ5NB5y7+VuyI90vpjgAMkQ7kpY0hgN5edgAQ=;
        b=Xltf+vphv0gOIcjcd2mLmcQ86u9Fc6vsEsGtar/Jc9kKCI4JIr6YO5G1OK9Jy9DIaO
         8Lp1IxaK4vvs4k7YroILo/29FZlkubBF4mVoXHRcXBhPCQ4JYptsNtbSEjx1LOsg54Dm
         cK64NPPm3ZGRuTAKR+fGCYKl/31xl/TqMvDIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746505563; x=1747110363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpTvVcHQ5NB5y7+VuyI90vpjgAMkQ7kpY0hgN5edgAQ=;
        b=VgtCW5nA+/qplB8Qs2ZnTUWHLFBMo+PsweRPkmrtoCOKuO/wgprKoTGPR6/xk1dxu0
         bUMC8s+n7dtu/zILUeyRIApV/87aGC1VgSO3fXmpIj+ncrmm42/QLY+8iBFUZPHsASai
         kwlh2MymUEiz4LqVhmsogB0chSp6/zJVVEVaOn51pQ2D1lvKznkOcc2oo3AaABqmTnxE
         lvMa/7rv4WskI7ZDWBgpD3A12XGZ2PE3mO9m8toCURJbqLUr91sweWvVfm4JDVU4MMqE
         GtvXCEQTbGRSJUvejXJAS0hzlz0jBtZjAi+f0UV9TdKl6VhjwlD0EnpnlSJi5yLVNEmZ
         WFfg==
X-Forwarded-Encrypted: i=1; AJvYcCUGOLah8E9+aA1C2XF6xxLe813G2NtGONOaqSDFDRYxxKGULVxzBhK3G1Z5UBqwDJSWcmNtcUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOst4wmeqdLsq5QaSAtILVqLYTODt9QFhQjOZZD4KAa8qT0BU8
	sKwUgkQqm+2esinTv3fpU5FbKIMd5AmUT1Ot/PBy1hBkABPmska1IBuYXUrq+w==
X-Gm-Gg: ASbGnctaZ8MZpSq8qZPWDgBqh0VEcqmfOmJFBptfQmOGNETtcumVkZ9QvtHhajBMFpt
	rhuv/8FzJ89xEZqu+Dve+xZc8FvErDjgTUosiUFPN9eno3AflT/LZN83YO36GoGabzo1De0Nvbj
	9uGHJ9G6mVlcjmDM3NXq23lhvDU2JuhqOhvnELHKoYNaFVVy1hGRjV40jFlW9tDgztpuKE+dfJS
	mseyenxif0u3KiFRVho1vHAulyp5SglqJOKhySY35kNDO4ELrj/1WvV8P6y2M9VgzIWsArP1Sya
	iMjWhwBMYhg+xAs68QAiOT+FqvCoYquAujqJHJlz3/7dO7WSqmHKlg==
X-Google-Smtp-Source: AGHT+IH2lUDpOcji/4HaHFx3QdH6baMYj7NqZym6Fql1fkgTO/Dhci0Df2ouxUuviW5c8PoLDQ9qGQ==
X-Received: by 2002:a05:6a00:8d82:b0:736:34a2:8a18 with SMTP id d2e1a72fcca58-74091acd3f4mr2575582b3a.24.1746505563516;
        Mon, 05 May 2025 21:26:03 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:761:97e0:917d:ad1e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020de2sm8063478b3a.103.2025.05.05.21.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 21:26:03 -0700 (PDT)
Date: Tue, 6 May 2025 13:25:58 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Vitaly Wool <vitaly.wool@konsulko.se>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Igor Belousov <igor.b@beldev.am>, stable@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zsmalloc: don't underflow size calculation in
 zs_obj_write()
Message-ID: <rp5x24bqoaiopfnbjee2f3n7nrg4vh6mt2j4ewutjj42n6dmn7@exl7zdf7pvwx>
References: <20250504110650.2783619-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250504110650.2783619-1-senozhatsky@chromium.org>

On (25/05/04 20:00), Sergey Senozhatsky wrote:
> Do not mix class->size and object size during offsets/sizes
> calculation in zs_obj_write().  Size classes can merge into
> clusters, based on objects-per-zspage and pages-per-zspage
> characteristics, so some size classes can store objects
> smaller than class->size.  This becomes problematic when
> object size is much smaller than class->size - we can determine
> that object spans two physical pages, because we use a larger
> class->size for this, while the actual object is much smaller
> and fits one physical page, so there is nothing to write to
> the second page and memcpy() size calculation underflows.
> 
> We always know the exact size in bytes of the object
> that we are about to write (store), so use it instead of
> class->size.

I think it's

Fixes: 44f76413496e ("zsmalloc: introduce new object mapping API")

