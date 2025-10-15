Return-Path: <stable+bounces-185741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C66ABDBFD0
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 03:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE09F4E56E6
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 01:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6AB2F7AAE;
	Wed, 15 Oct 2025 01:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RqrlZUQe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6A92EFD95
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760491995; cv=none; b=rGAKNErHwI/Lsb5Q/FOCrehhjrMXuCSk7c75o733gvbxRmuOq0JOWjd/KAaBSybBjg1crk6zzoODztau5frtBuEnfcmeIU/qSZuWoFsWFd6rShYry1O+VsSUlBSuhJmS3D2jSwc/tz9m0lmhtwZI89gfvHE8GtPJIizDn6TTi/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760491995; c=relaxed/simple;
	bh=6badzYk/nvV1acB3qT5JfVBXT+d6ShZ1CA6n3TANN74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXCzmfOI6/tI80fyFGuSHflm7lGccoyH5LiS8RxbHmpoCa8WydqywlZbPCeGq6Hvysr334mvx9VpQOtUjxeHr5RrY9cBYto8BdAxnHPh5seTrqH0WMhrqSKB1S+MYKoFxW3b2wgoHsDLKWQgK9Hhgm6VgQqZZZUGin0Qe4tCnbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RqrlZUQe; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781997d195aso4310767b3a.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 18:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760491993; x=1761096793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpWqEUjcuMYUOuKFrDJhZOLovSxcHFHGML/0fDzV26A=;
        b=RqrlZUQehIfOhLtXDcrF4zHpE464kqdimoU8IDP4E0qhj2tBPPFRJLz63CPLQu1Kw8
         Vqr/11r62TZEwFvPc3AKoQUTiLlFEMYRjqbUUEfUgOQOIYEAHBGhOfcZ0tZkp2lzEeES
         ykLWornCkt7hBdEBSM1Kjv8DkemDhQJuOej0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760491993; x=1761096793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpWqEUjcuMYUOuKFrDJhZOLovSxcHFHGML/0fDzV26A=;
        b=Uv+YFCeTJ0k7lBbkXN4ohB2bBN90Sdr8ZfCZeeiGbJk9jA0pbpkXz8UVPWcNgpcd2C
         2XEkFPQljK1Au7Refjktm06cR8qrJ/gM78GHrv3J7LR3RMtvEmUUj1sP12oJFHgsxpC3
         hzJwmeyABBjJEgDctmCw47ib4aXu5bqKkzYT4T/FSstg9m7uNoYvggFMXoyqYdZKBo8O
         /w9XHuJVIujKbGTXa4xMRRgx8EEmJwv/EnMNvz955yljdqN54G96sMEn+k1uI2yFgYZj
         FF2T9eTwCpaB2kJpD7FqOytI5+DTWGXhafrcgs20PU8Fwlmqn6VCoKajPcBc1ZGMkKG8
         HzRg==
X-Forwarded-Encrypted: i=1; AJvYcCUdnMTRVYr3gtq6pq/8Jjod2871ZhqrPIwtRf/Jh5CAamAR6kySrVGSnS0DVz20Y1XMjfv897A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5bFb2td3x6zql2no+N5LG7bX2ZiESZqXDyCw9JFJoL5j95Iri
	tb+WV/qnXdJQQrZ6r2TZURa0zK4QtXxdI3JFFBd8FtomSeGZk2vFRI0WHpmPo5/ZSw==
X-Gm-Gg: ASbGncsw1LT1Nf5OnQwGEUT8koZKI1hoAfEGbJYvrw5RZNh3ACBwiUwTiO3fvctXPpD
	Aw/8hJYDy+Qp/SlZIHTuq4GGAUqrIEf3dfn0xZfmdSkE+ZkT6H3MZtkKw/d2LTxtFnWQOoY9C4P
	aR3YMmgYanfnz5qsSzQb8zlSPUwbr1sdqd6+d1kzhRq5Q9lYOp8lM6qS9pHVjzP1huljx/ZIFLg
	T+iSiOWCAJ/Oq8qMg2dBiMKhFgw1Sp7v0J56q9SnoWf80INXlsjkBg10B6NbNcI0pIfKSIj3Qf9
	Nij+HXZ/SkKZOzvuSXqOpsnP07p4HKvjX4PTIj4ppxtjENSDqCBYkFMJs23ENpnDJnp8IDVQ26F
	RTr9XAekUJvtK0YcXKrCiP38XNR7KDcxMQ1y3DYlKPvzviA43lfmnxyLaanfBrbM3
X-Google-Smtp-Source: AGHT+IG40gAg1zdLGZmMjI5naqJD7ijTD6o4+KRe8hXPev+79JqTTzIKatX374QnWR6oHoZ6OkEh7Q==
X-Received: by 2002:a17:902:f693:b0:267:bd66:14f3 with SMTP id d9443c01a7336-29027402ed5mr309800405ad.51.1760491993114;
        Tue, 14 Oct 2025 18:33:13 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29084e1709fsm13104905ad.2.2025.10.14.18.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:33:12 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:33:08 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Sasha Levin <sashal@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <yapeufdqxobl7yn2ylmtktyon55nofcpwujnwjjrwol37pxw4t@wv3akoz5w6f2>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com>
 <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>

On (25/10/14 16:11), Christian Loehle wrote:
> (Also I can't send this email without at least recommending teo instead of menu
> for your platform / use-cases, if you deemed it unfit I'd love to know what
> didn't work for you!)

I can't tell for sure, I see a number of bugs evaluating teo vs menu,
one of which mentions the following:

    on Tigerlake/Alderlake hardware [..] TEO leads to higher power
    consumption (130mw more power usage in video conferencing) when
    compared to menu.

