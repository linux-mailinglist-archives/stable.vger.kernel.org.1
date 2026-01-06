Return-Path: <stable+bounces-206027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E9CFA7C6
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 20:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E437304DD97
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 19:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B8735A956;
	Tue,  6 Jan 2026 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RW78tpid"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8135A936
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767725005; cv=none; b=IpeR9s8e5RcLPuh8TnURpz05wZMDtAS5+cL6mQ21HPVySyLu3NogsWTeuxPIyr0rYMY1AOCqEZpFdUbOU7LTqln6YYVtVu3+xJRfd0hXxNUkJe5dEcyk6d6fvZtYB9CJO3rJ8ZmuTM8NbIp4t0Qy/kG8mgGrmmeibCskEvmSmQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767725005; c=relaxed/simple;
	bh=fQr7ORRfKEmNqbyisivGTO8gGWbnbF3nBJ+byGRL9eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvw20/MWNrEFuulWnQmfG1I5K6AQZ7k+gXUxIpCcjoR/4pqSFlMchTxRIcK+lexJa7xN6QAwnhsxQoCAJ/xBgq3MGLG+soPkSm8d6jrSJLGNW+A8C/4GzeZGZhxM9WWLb3ho6C/QWhVEJgkmDDrVG+QYB5ZOTy0GqrrvNmSaH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RW78tpid; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-121b14d0089so627185c88.0
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 10:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1767725003; x=1768329803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3uTRfWRC6gEy/YDS+DXKTlHh23twj638nQc22MAVhMI=;
        b=RW78tpidei5Afhmx0OaU3p8FSEl2I2QoPhIlW/GXpzFaOO+1x36sU6HxwIwgVa5bVd
         l3sHGxbC85sLNMS6jfwkqusKQ08MWivsNF3rvVOzTQySWZ1JG3JB3VHEKTr+fcGzt1DP
         I8iXdjxN8H2PsySBtCgPtv8kiDnMqhBdmaFVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767725003; x=1768329803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uTRfWRC6gEy/YDS+DXKTlHh23twj638nQc22MAVhMI=;
        b=Nt2izbVyePxtvzLKHuAofpZPXF79WoojMTFzaZdQ0AGZjjroubvVj6j5+AvrSKCAjm
         Q6KCTro0TyBiKsFxwXSsu3UlenSt3DM6VwI+Xq4zDa96W0jijJdjKKwHoLRb/TFHD+jk
         TP97+Yxt2IxK5HB8Y6/kWgToBtjOI+frYlvW87ryKi4CM0AMw8QY4BCobqjHsvdhY0cN
         ZwzIDfqYrKfDGtOibNOCb/uecMLFun0I7uTs9eTagxSI1z6EzcjMUwVBp1bMwKEAj5pO
         up0ZJ9XhsXQCVmxMxpTtNuXCSBUTBQnvYWtjG2yx/HA9UO90VeS+XK9+nRJENd20O7e6
         /6Ew==
X-Gm-Message-State: AOJu0YxWfyGhUmmCTrRVM7RRuTkrWvhporNHv/Ai89To2O6JT+12Pegu
	Ma3LepE3IhNjlpk6h5dTviXztY4K6I5xGTyfWNbtAuwCLeeLHezWYw8SEA+UE6B1965prmoQovp
	AZks=
X-Gm-Gg: AY/fxX4FRk6l2LmJ5l0/X5ucmdkGeZjbJkCyY5ou6JUe4Kx/lhSmfovpVl/X1mGtRmw
	Ue/vlQ8WOk8MU3u1gou31uCnQOhyNR1sllA9PrrYgs14oxmf+dd4rtAmTeoyxe8lAc7Yg/qwU/1
	uLD8MS6ExbB7lH8+My7qbfBt4C1300CANk4AHDrGh+iMJNbqPCH8DvarT+UwvfjcT78L+IWfe3a
	OACOUbunSUK1XS3U8bA2YOWLMvVfrV5W08zHRi2zk+faYVcaABhw3zqxoywwUyfqHcKvDmEiAGC
	fi7cJXU/2jzIJ806aYQib5WeBAB0K6MovEcrVN9v0LMBmvsQBizS5kVHJIOWyOK8RDqQfwshw5b
	QEEatGEzlaIue0rTyi6EdTKCOJnhOBGTFyMKJPK59Jl8G9oraGsK9t8gIDBamvlTRe3rm7GDMIs
	7yOEW7dKiu3GZcYSYiweHlbapNlVuIrHBujbMpMUNwVklBhUZgbg==
X-Google-Smtp-Source: AGHT+IGptX6oQ+lhJubQrLLlyT9EkSN/uTtaYcbOxD/QGmS7h00AWNUrQc20131XCn0c9dddcTyasA==
X-Received: by 2002:a05:7022:110b:b0:11f:2c69:2d with SMTP id a92af1059eb24-121f18fc8a8mr2293948c88.45.1767725003367;
        Tue, 06 Jan 2026 10:43:23 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d96a:d9b5:ea6e:4870])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-121f24a65b9sm5399384c88.17.2026.01.06.10.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 10:43:22 -0800 (PST)
Date: Tue, 6 Jan 2026 10:43:20 -0800
From: Brian Norris <briannorris@chromium.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 5.15.y 1/3] soc: rockchip: power-domain: Manage resource
 conflicts with firmware
Message-ID: <aV1XyFtvNX1lZGBE@google.com>
References: <2026010515-dragonish-pelican-5b3c@gregkh>
 <20260106181021.3109327-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106181021.3109327-1-sashal@kernel.org>

On Tue, Jan 06, 2026 at 01:10:14PM -0500, Sasha Levin wrote:
> From: Brian Norris <briannorris@chromium.org>
> 
> [ Upstream commit defec178df76e0caadd4e8ef68f3d655a2088198 ]
[snip]

This is a fairly large change, and I don't think it really qualifies for
-stable. It's also incomplete on its own, as we'd need commit
2e691421a2c9 ("PM / devfreq: rk3399_dmc: Block PMU during transitions")
to really do anything.

> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Stable-dep-of: 73cb5f6eafb0 ("pmdomain: imx: Fix reference count leak in imx_gpc_probe()")

Huh? I don't see how commit 73cb5f6eafb0 is dependent on this change at
all.

Is this an errant attempt at automating some cherry-pick conflict? I'd
recommend reconsidering.

Same for the 5.10.y copy of this patch.

> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/soc/rockchip/pm_domains.c | 118 ++++++++++++++++++++++++++++++
>  include/soc/rockchip/pm_domains.h |  25 +++++++
>  2 files changed, 143 insertions(+)
>  create mode 100644 include/soc/rockchip/pm_domains.h

[...]


Brian

