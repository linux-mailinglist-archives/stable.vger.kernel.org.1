Return-Path: <stable+bounces-197991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC24C994B5
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 23:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4F9B4E2666
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 22:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B01281369;
	Mon,  1 Dec 2025 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="cY0L3Upx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB242765C4
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626770; cv=none; b=SWi82YqBnkiAoOMcDg4ejy4AoTRdQIoH7bSN87sGLLtcZQWqL3VwjxA8DnV28gwFdVi2rSt4OQGTTV/YfmQcLLAIY1uNQaRQjONsekTZ6FQAwoJRmvzgN+y2Y1CwtU3UfKr1E6RibVKHJSdPJFym0XH7Uai2nZIP40eEVMvBEjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626770; c=relaxed/simple;
	bh=PhlOhLyfjRLagW4BXKVTnsDRNJQb6Rj2gXsVklMw9R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChPIFlpjnSREgWfLQmfLWq6ADjcVxqX4xNvhnXHzgxd8vO96Wi1jDiJG9wXLTheTG56NLLAF/NCZdO8y4Ewf3PccAVQhPC/ZbUXdOPqSv+BVH7qSJEn6pwaFRFm4I3YdyGYqXwkU0c2b4LS77rod2s/w+Bt3hbKH+tetPyVQf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=cY0L3Upx; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8b3016c311bso593885085a.1
        for <stable@vger.kernel.org>; Mon, 01 Dec 2025 14:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1764626766; x=1765231566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq+3DtRJU8JZNsuocRWKSJHQAwFBLxgASdFB4JZhVQ0=;
        b=cY0L3Upxa0+0f9YzW3arz2AXJTY/GKsx6kA+UZGFJqhYCQ/HGr3WVHcrDVa8lLLr0d
         8ixl68M5Fhh7ofCXM2lQECxgozT5nJETHHzSoH1C7Za+nnvr5YYKhH7p1aQ0AlYvu71c
         nl0g1c8xgtkVTeRICDIY8DYLxnyqfQoFE/yUCMwmjjSAbp4jKCPP3APfsT/EqUR1Vz6D
         D9L1ZKC2WNgltD2mftwjRJOOE6dyR4DZiq4rGRJCKOs95EXYe4BKul0yCwOVZGbmcHex
         OIEvWfsyjKVZuw0ZoDB5Cn7keeYTo754FE4b3/RGQ2uJ1fL5vi7ehq1xSLGZxy4+pnPy
         lxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764626766; x=1765231566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tq+3DtRJU8JZNsuocRWKSJHQAwFBLxgASdFB4JZhVQ0=;
        b=SajkQOIzyoDFd0GCPKu2zD1zF9zEW2pPwEC0pbUD//bTobfXgA7UGiwXDNQgdTQVTB
         3a2tdAHfKcNtH6fH0rhQkUvJfJjGRLcaDoEvE5sgW4RNgA++3wG6t1HNynoYYvumQidC
         +vAX6B0znsrGCTxByHgyC3DImI94hjJRq9J+PqePvsXihNHV8adek+bRvm7b78UViYNx
         JE+BEzFuRFLdJt+vtNtKgSFrtrJ0OHFd4q0IPtcneK5VQ6Z4gxuR24zgnZX0/WBl7XkC
         f2jXiOT2Q1Eeddyy9IWpAYwUojmX1jZ5b+z6yerD+1QPGYuQYZ+WGfys26gWESDLZffH
         Cnqw==
X-Gm-Message-State: AOJu0Yxc5hCYXFGZrKcvK0hKI7Nkkq7hMmlTb8PTzeFzwasYDjVgjoyu
	inlhLNudrqKuZYlwkQD66puRo/mLfS+KDoRaf08M86a8gXHwZmDSp3QPVpgyS1vvMidqBZ1X9Bl
	f7+4c6hQsnRl5SoGI/rT506CiFz25FJbk4z43W+zOXszSfSQZLq/sO4Mhue5FafA2DX3zNEY=
X-Gm-Gg: ASbGncvM7MV12wM2yYLF10Pwdo3jqxOVR8rwKRYSvXERKLhuM974VYFjJWLn9h/xM4y
	BU1cQ0LIpAqmQCnl8cy4eTDxRk1PoD/DST52QYGqpYxPcyF2DuNHEOA2iJYY8GRadjzHM2kuvXd
	zdIkUGJ5NvE2MVgPZ+funtxY8UsJAsQDlnioK3Pg+h+FNj2u29rWUx35PUW+nS0AsDacLbgi9BN
	EkoGB7F1YXBRcHgT1rmukJob/aJi8sNuAq7c4obUNoHVYmvIx1T62AhifDebTuox3TLOURnegKx
	gsjPHQ0XYIzvSeQ3L5gsSUfc/Pa8Faj3SxUKOezJ8duMVqH6bGnMcWiZuBSEuoNpSBZoEKAFKHp
	GTpt/aW9h5qqgEWbgZYfJ4BCGmGJwA2/FXSb9kdGYByHjGgKQsZ9PsTUmcU+goFtRcDRuVBTgoo
	VUTb7asQ15tgTxNW4pUrNQbD6EifBpRA==
X-Google-Smtp-Source: AGHT+IH73AqnKniaCHTQwgGUaYfB3pi27DJFpyvJ7J2eAiS3iZy3BhYYAdbLduoOOICwt61XH1VPLw==
X-Received: by 2002:a05:620a:3194:b0:8b2:ef2d:f74b with SMTP id af79cd13be357-8b33d22acb9mr5049545485a.29.1764626766477;
        Mon, 01 Dec 2025 14:06:06 -0800 (PST)
Received: from sladewatkins.com ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b529994c8fsm949986385a.6.2025.12.01.14.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 14:06:05 -0800 (PST)
Date: Mon, 1 Dec 2025 17:06:02 -0500
From: Slade Watkins <sr@sladewatkins.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 5.4 000/187] 5.4.302-rc1 review
Message-ID: <aS4RSgGIv-136I51@sladewatkins.com>
References: <20251201112241.242614045@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201112241.242614045@linuxfoundation.org>
X-SW-RGPM-AntispamServ: glowwhale.rogueportmedia.com
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.1-sladew)

On Mon, Dec 01, 2025 at 12:21:48PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.302 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Dec 2025 11:22:11 +0000.
> Anything received after that time might be too late.

5.4.302-rc1 built and run on x86_64 test system. No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade


