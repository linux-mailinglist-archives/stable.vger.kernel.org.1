Return-Path: <stable+bounces-210066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF28D33374
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 16:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97BB7300A2A5
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231C4337B84;
	Fri, 16 Jan 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzhOhPu3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWmDJhWi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEA6284890
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577370; cv=none; b=AokmfZeChfa+m6pCEafEFO+o6ZSdty2H/8ty/t7O9l/nOdUPVOkWSroyxfewO7PoExuQjq8kFhEmScWk3+Nmjec5zGOuBc/jX1P5HYs/H+gujbfXEMZagPi9ngrASX5OQbQPqc8BACQ4ubKoFfX+2bnM8AIYHMsb+WU6cZTQtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577370; c=relaxed/simple;
	bh=sSSS54Xj0ShsXOZuK37+sEwwv3XAEF1W6I/qaNYc2oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y94RVeNYueczmJlN0mGkLfaikM+56wchO8aMxJHcL49RgcobnGofGo3v55EvcrsV+xRxSd5FFLSUOMoxGZLWQhWPcNjTggnx1k4kb5Z+HiMl2tc6y2JeZEFvV37UBzyYSV5HvUL5UOPrDsSl1kbwcAvB6YTWBZ72K4qdoAoBWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzhOhPu3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWmDJhWi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768577368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HcYNjtrM1tx5MNCL5NpuqMAZtAxO/Nx7W07L/efi2Ek=;
	b=HzhOhPu3FBwcWPCzKBL8MkJXEsYcAqUNMTcpuoiHT/HPMq/4SmdaFxOcn0B7N3BG+9+6Xs
	xwvM+jg0wGp8C6MW6TPn8eddk8J1u2GXyTZciSBYh79VwKnNKVcRJ0l3l6tpwNML6xzU+E
	cD4oMzPgRKbRr0GzjGcp2mSLWYdHJeQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-WZuZIWFEOWikw1c6gGGGSw-1; Fri, 16 Jan 2026 10:29:26 -0500
X-MC-Unique: WZuZIWFEOWikw1c6gGGGSw-1
X-Mimecast-MFC-AGG-ID: WZuZIWFEOWikw1c6gGGGSw_1768577366
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a344b86f7so56507586d6.0
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 07:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768577366; x=1769182166; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcYNjtrM1tx5MNCL5NpuqMAZtAxO/Nx7W07L/efi2Ek=;
        b=QWmDJhWizZeQX7ThvA+HEBcNpD1udgrGnfEz/3IN/acHKmkPs1b2+ISDWgTqiDaPU5
         zqCahOiL0M/eq6XLqxRXcVqKjkjPQcjk3IGhJppZHbQe/T9zzdPCvP4mPf/kLBwPdVPJ
         z+Qom/dk5p78WgiYyyuFupRmpSopFcoolW5HayQ2amZ2X1KMNpt9bMO1BUN/DTFXVmDi
         zX8W+01EnDd4L3uQ3asFML+5/U6jxueoWhLT4QugsZ2kNzEKrK9Al0fxQ5fV2L3bwAwK
         OiwxWS8kwlVMhd1+9BmMVZ+EpWVIynBKLDC1963Kewt0ZT+vVvsbQhzQMKNd0LpUw72Y
         R31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768577366; x=1769182166;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HcYNjtrM1tx5MNCL5NpuqMAZtAxO/Nx7W07L/efi2Ek=;
        b=KjwdKV2w0vcpY2mBlQJQbZFq7wvJ3jOxYZeJgX3PePbJvPay56siMLdHmLt/xcS95j
         o3/e/g8KwrkBgcn7bzz4L/33Gpo6JW8aPuu58XMWdgjx/wYiq/H3TWq0OMUyID6bQhZt
         HYLfglF0bDT4QdogCjdFyXdsTlXRu7GF8Yhk4nW4zDM18IvB6JLiY8Qan33Nrui1cn4/
         s2TBW8CqrmPdCk4nRkMVG2yyaSnnKfDJauKWy1GmLkN9e2ECrdayjh2UqsuteADqWCcF
         owcvaAz/je7XU3DWbLCwaWvbs4cIFSftA0mHycWwghHwSnmxP+dU9VDNhBurcotbAnt6
         k0+A==
X-Forwarded-Encrypted: i=1; AJvYcCVrZhRIv0sMwEVZCG0XtU92e1uZFFGZ1soBRe5JhawuoT2YPdtex2E5OKg43raKb4iebFi5bGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPzY+R7+BkZJdaWf5g2p/VypmfV/puMTNicL+m7i9BfmGhtwbN
	PXsW6W8MhXAi+x+xrR3DAoqHUEaL/gTNXR3k2ZoUwbRS0x9jMYcvmXQhuPKuBF1bg+zGnnm8SgQ
	wvCUmVvS1Hh+w7bvLYS9BFUkWDi9d25ZLrfQ7m9zUgQAdm3cOnGhCcjD6Lg==
X-Gm-Gg: AY/fxX505jcfnUxyyX59DAeuw8KlelF89hdnaFK9+GnuDn3Z45Rs+/VFa7NVt318mLG
	QDYNMbS8sBoIExnMCWZCRBlFrYBW2UmC3GAVf+japfzSy6BuCu7uzvCAsKFKsocoe6Ns/VRP52b
	HbYEK4VhzqXMB7YRRCyarDwMLUlGDUbFeXtoN5C40bWkitRN5yzlsgk5yki7vDRWSOz54uU84pZ
	KoVUJq7p2f0McSS+pxVvzGtS7Ms3l4YeLmMVk3CIlU+7lvC2J+tD0Gz0+zi6gz1GXFbUyGpnXcy
	QY8wd5OJQ8IOSvfEkaZbDmZ7WB4mMy64BfnV6g3WQ6ltp/uZrOnUeE4wwi1Dz6TANeU9dTzMTSW
	4H9fzIp+svHmQuPYYXA8vhWV9DO+W7aHYwcGgPaYwUKhP
X-Received: by 2002:a05:6214:2305:b0:88a:589b:5dad with SMTP id 6a1803df08f44-8942dd07f96mr46350776d6.27.1768577365739;
        Fri, 16 Jan 2026 07:29:25 -0800 (PST)
X-Received: by 2002:a05:6214:2305:b0:88a:589b:5dad with SMTP id 6a1803df08f44-8942dd07f96mr46350456d6.27.1768577365381;
        Fri, 16 Jan 2026 07:29:25 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6cd63esm24958956d6.49.2026.01.16.07.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 07:29:24 -0800 (PST)
Date: Fri, 16 Jan 2026 10:29:23 -0500
From: Brian Masney <bmasney@redhat.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/7] clk: st: clkgen-pll: Fix a memory leak in
 clkgen_odf_register()
Message-ID: <aWpZUz46SQLGf8WX@redhat.com>
References: <20260116113847.1827694-1-lihaoxiang@isrc.iscas.ac.cn>
 <20260116113847.1827694-2-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116113847.1827694-2-lihaoxiang@isrc.iscas.ac.cn>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Fri, Jan 16, 2026 at 07:38:41PM +0800, Haoxiang Li wrote:
> If clk_register_composite() fails, call kfree() to release
> div and gate.
> 
> Fixes: b9b8e614b580 ("clk: st: Support for PLLs inside ClockGenA(s)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

Reviewed-by: Brian Masney <bmasney@redhat.com>

Note for next time: I sent out a Reviewed-by tag on this patch on the
previous version. Please include those tags on the future versions.
The only time it's appropriate to not include the tag is if you make
changes to the patch beyond a trivial change.

Also you may want to consider using b4 for your workflow since it really
simplifies your workflow. There's some documentation available at:

https://b4.docs.kernel.org/en/latest/

Basically, here's a quick workflow of what I do:

    # Start with a clean branch (say today's linux-next)
    # Create a new b4-managed branch
    b4 prep -n my-branch-name
    # Apply your patches
    b4 prep --edit-cover
    b4 prep --auto-to-cc
    b4 prep --check
    b4 send --dry-run
    # Send out your patch series for real
    b4 send

Later if you need to send out a new version, just use the same b4
managed branch. It'll track the patch version number for you (the
PATCH v2 in the subject).

You can use 'b4 trailers'
(https://b4.docs.kernel.org/en/latest/contributor/trailers.html) to pick
up tags from the list.

There's also a b4 web submission endpoint you can use instead of sending
it through a SMTP server:

https://b4.docs.kernel.org/en/latest/contributor/send.html

Brian


