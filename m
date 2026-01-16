Return-Path: <stable+bounces-209978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F1D2994B
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 02:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9283630B785E
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 01:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8481132B994;
	Fri, 16 Jan 2026 01:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3O+Lmbf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPhHSctN"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473E0329E75
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 01:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526552; cv=none; b=FEIIgjfpFnd2NPMLkxHg7HybU0VzzU7mFM8dfUNIo8ZLC0P/5dLT0flffxUHtyn4sxftxr2SZ2fEs1XJ3ZmpCBa/VAG2Hz+5vNMVU49IJghahPyLpuRgb5j2ZnFlYN2VFSFxT4+GfnrOuG8UBRKtcetgzAR6Txen79iGSpTy4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526552; c=relaxed/simple;
	bh=JmS6hXMultdM7kSpg6pUvdv6eOkt62ucLYun6fJOFVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7SMcr9WagTSxU5X3Ylws8ukKMCF4Hs3nZOSQ835HUHSxENlK/UkqWB7wlwrYuEomwJ+TLkDGfoFHuCNIFEhd/NeC2MBR8Dl9d+3aabrVpBq7mtddMiiVrf8f/k/6e/YWELy7Z8+0EPVQkzr1x+wZVzM/rVjfe7oFBXzO339NA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3O+Lmbf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QPhHSctN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768526534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I/7QQfPExfoLaF42b72uhslOlKfH5M9xECrEdJSFRnQ=;
	b=D3O+Lmbfn5BMLtCvDvnvAuInalzKgcpCxFBk+hYLzm6TVn3iqF4wgNa1kEizFsQHXdhGrq
	CuFyRrqrgJlXfy5Qh1WiLkrWhyW5QnuA6nE4bK056KvVuYAy0RD3DBrGRspmB3LSxT2521
	Jh7rhy7Oq4kNimISBi25zwaFwTsosV0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-qLScrXtqPyiFMPo8zQcVeg-1; Thu, 15 Jan 2026 20:22:13 -0500
X-MC-Unique: qLScrXtqPyiFMPo8zQcVeg-1
X-Mimecast-MFC-AGG-ID: qLScrXtqPyiFMPo8zQcVeg_1768526533
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-502a341e108so5481541cf.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 17:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768526533; x=1769131333; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/7QQfPExfoLaF42b72uhslOlKfH5M9xECrEdJSFRnQ=;
        b=QPhHSctNPh0zq6+b6NTKFI7bwJZcLf0srIPUKlG/RoeZas0fUbeDgk5dbWLGm43WF5
         TDobeTjglupgpUr79wWK8j3Qr5jyAR8WmvOAcqOjHHdPCjVeAI85D/iXy0cRFzanpqwW
         sIFKdvs+HaY0kcW61gfnA/BOHer1tWam6Bj5c/BuYqHDAyljXSMvGNSG3WQ6N68luADX
         99Rd/jyBJjljMRyWh+oEK554iF2wt/ZVgai8xTAZI5/KHd+VPRuC/XN9Q0t//BqNB5jg
         /mOJVvmwOdOiuT3TZhjFjYnZBNoVA0EsIdYW7MVEDfc7Qp+S2O88QWCBMYsxFrjv0tcs
         IVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526533; x=1769131333;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/7QQfPExfoLaF42b72uhslOlKfH5M9xECrEdJSFRnQ=;
        b=Rr3SiCvTQtMBPhE8TqOK7adP6ooZPAW+ooRccifAqhOhiUaFWlyuUCAzB4DenZvKes
         EgGfK8+7wywauK8GRMhiI75JYD2s8knuG/0lbnLIJVD4uG+vp5CL5GbUsZuaTloFW4Nr
         q/ChctFsf+dYI2EMvZa/WcpsW6S2+ABD5M58sUJ7AsA0AVF3FZRDMjdyjLLr149IPwjW
         DMQVFlD9wFOhEHm6/m/ikrKSajnKxMRzN6NB4nRQVhs8EqtwafoyzcrihQSrIwWL/xHy
         Hu2aVqllaXieWnw2m+pAQwQdv/XTn4ykuaEJUbeelcKTJ6NqHKAB+z8fUnvbDsnSMANH
         ki4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUV84UHKhTrrIT8xXOtjRScntsQKOIDhyvSlvARJt29sp4D7aMqOaTbeAVz4DPWwOLndbagf4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KbOdJRwDvN6cRkEiD8ImzGdUDPS4xFRCLk31z5cvXz3bHfXK
	ZMvNCG0bufgpNxaxe5ZSkxgOX7nArCsR2JQ+uCD2noKuGw75Zi2GQFhbtI+v6sul39asjFlYML/
	NzrPr+jUlJ2v/tydILc92ENHdVDh528pY+p8UKgJ0J7vs5OIGaz7pAqIbMA==
X-Gm-Gg: AY/fxX4MtCfxzH973ZCHz5Uu5rfB9jVlvH+bIAjZeCZLPmFkyqMDJHci8cdlChP0J5x
	eGHaYr3eZzguLflxj5TtKLI98cHxUOTF5WW3MUuXPxqg+YZ3YIPuDM6oRTnx2dgrQHz+gzw1V9w
	53BxZqrx7JHS+RiSo3RQqKg4UxqS5Yhqq7xoDElKZ0FJbX9PG0tl52ldrckOIbBZKyppP1vLBCT
	yhOnLiSXgF8vK3clt1lYSJZ7xPiyXd1VG6gc+yvJ7AQY3mZWnyz5mvXOd/VpAoGUBV1dKlBgsTj
	VV1hUmIZBnWvamuV3c6INbJS8k70acDBylxfbiZ0n1472aNmcHhOQGNGk+RE1fQkSFyQSMGAbpN
	/tpJ8cGlFpBoWFabvzsEPSiHVQRbn9/O+i5AlGP9sBOHB
X-Received: by 2002:a05:622a:95:b0:501:466b:5141 with SMTP id d75a77b69052e-502a164b881mr20881661cf.18.1768526532861;
        Thu, 15 Jan 2026 17:22:12 -0800 (PST)
X-Received: by 2002:a05:622a:95:b0:501:466b:5141 with SMTP id d75a77b69052e-502a164b881mr20881511cf.18.1768526532495;
        Thu, 15 Jan 2026 17:22:12 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1d9f2a1sm9622621cf.10.2026.01.15.17.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:22:11 -0800 (PST)
Date: Thu, 15 Jan 2026 20:22:09 -0500
From: Brian Masney <bmasney@redhat.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mturquette@baylibre.com,
	sboyd@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	mperttunen@nvidia.com, tomeu@tomeuvizoso.net,
	linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clk: tegra: tegra124-emc: Fix potential memory leak in
 tegra124_clk_register_emc()
Message-ID: <aWmSwcza6Qv2aQBO@redhat.com>
References: <20260115050542.647890-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115050542.647890-1-lihaoxiang@isrc.iscas.ac.cn>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Jan 15, 2026 at 01:05:42PM +0800, Haoxiang Li wrote:
> If clk_register() fails, call kfree to release "tegra".
> 
> Fixes: 2db04f16b589 ("clk: tegra: Add EMC clock driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

Reviewed-by: Brian Masney <bmasney@redhat.com>


