Return-Path: <stable+bounces-107946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4679A051BC
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 04:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A8B3A7743
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 03:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F5E2E40E;
	Wed,  8 Jan 2025 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="etSoLFzL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC361802AB
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736308452; cv=none; b=CUcC24O9pVzuHPGYlYdIZcQrUUsX7bIH+4e5wcwYXxOLsDkhUwNsJZzosQ6n52Oyp+n7mlY2DgNEzUiunCebcqQbb0fg3zSxi8GqtaPdJDLuyrGfZFGu+wBMj2v4CIG9daUUV4KePWeXT6dJEKmD8/uJkrOybH5BVn17xq3zHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736308452; c=relaxed/simple;
	bh=lOSGVE9yjk0wCEz8NOZ9xXDWuZNKDtrNmeVKat4/IsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPFMtbMt1tMpN4Oqb/d2y04p9LvJ8cM/9sCkmL+IavpLJscMObK4IeZKKAcN25jenQ6Csm1PtFvXrdZTZohzB6hoYhbdzBqc9VWq5Kjc6pycbXbcwZa+orNzGEA8xMrX+QdJ0xUUZrktms0LCDGYOttfNoiiFNLwqBjqRTdcfsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=etSoLFzL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so19384356a91.2
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 19:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736308450; x=1736913250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2O5SWin3/sFpJoue/uTd+xbifSjS0T2qml8CwBbWqK0=;
        b=etSoLFzLTN3M1W44060gUfg6Gi7FBbrnrAbdJvFe6MYrsZ3X8W7LhStzXMns3f0hA3
         VdLsz0QuJ1GAHOfz6vnV+UJTwVa1GspLmD3iFzcawOsRjsGpmTaZcy05Nz7QZhzfE/FN
         TeWLSo53bZRvRRNARKwIV7bZzIhHurcAJyV/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736308450; x=1736913250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2O5SWin3/sFpJoue/uTd+xbifSjS0T2qml8CwBbWqK0=;
        b=u0XV9SaBJSCGtRgJ8RV7fS0nK+XFjtR7oJlR64oLhaFBGzvsnqXcoJGl5nnrLSO8h2
         hNosdNeplOTgVg7RzHoZJITrC6cwXyO75CvmobeuUy5zl5yJ24kXJLOsbdAm4CjYDN43
         Iuq7Z7pb9DCEtujQt9+FC3nZOGU286FI/GXjnBIL1OrrFY/AjfesQdaayKqb2mCGYrrZ
         cehGBC0QZpaI+JT5YiHojymBB/es/xfjJCbUlWYZUP4CYZbKCij2T01Gt0NUMFsR7L5d
         C21rafWtYPP6AGUTCmCs2o66H79Yz3lNn8U4ogth1ye8pLjkSjPoWBb3bTn8EifNjWoo
         BXbw==
X-Gm-Message-State: AOJu0YwQDArk4Bjzffk+zkSK8dJpAPZYcsiw9DZhL6pFhFRMDvEosnVD
	8skrhJ+89NobL4cIHzsM0Uy2EmIdKpkwypHr6wVTgQ+2d0m6iU0mmhUiTnH6DMp0ZG38idNm3sY
	=
X-Gm-Gg: ASbGnctmSVbu7Lxn/8BsMzW1CyOzByYubMy8NKfM+GpkgHU5RLUVnVcvgD+ApVVnOzz
	jhyUGzyenSykYtaF4BddD+qEnVJUR34MPZj4FROr8SiNARPSBqIaBKGSg3y2/QuOd70/2QmSgTk
	BTFCJtM9xkt8fyRWwx9COvd+xWkb5SwE56h7K1ZuzEeFasxuC7BYWVCZRi+bWvs1F528UGLEa3M
	bPxEZh/hkCUP21XyEe48O6D/azTNzfBOy6f7ge6P4UPDoWPSRrLBk2GjcZZ
X-Google-Smtp-Source: AGHT+IGR9RMGVfvKzrXA23qhdUrf15++8XYlmKfVl2E/o3+ke5XoUfDua9ueeLTK2ok7oQatmri8bA==
X-Received: by 2002:a17:90b:4c8d:b0:2ee:db8a:29d0 with SMTP id 98e67ed59e1d1-2f5490bab2cmr1869590a91.26.1736308450484;
        Tue, 07 Jan 2025 19:54:10 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:57ef:1197:3074:36c2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2656aasm399145a91.8.2025.01.07.19.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:54:09 -0800 (PST)
Date: Wed, 8 Jan 2025 12:54:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Kenneth Van Alstyne <kvanals@kvanals.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	senozhatsky@chromium.org, minchan@kernel.org, ngupta@vflare.org
Subject: Re: zram: Regression in at least linux-6.1.y tree
Message-ID: <7rferqxnhaa4rgpgmwm3ulhssdvnxhzz7fyjo3u2fmw3jyqgjw@oimhw7h6idf2>
References: <010001944286f97d-fe02c461-e7af-4644-9155-a96995709804-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010001944286f97d-fe02c461-e7af-4644-9155-a96995709804-000000@email.amazonses.com>

On (25/01/07 20:48), Kenneth Van Alstyne wrote:
> Kernel 6.1.122 introduced a regression via commit
> ac3b5366b9b7c9d97b606532ceab43d2329a22f3 (backport of upstream
> commit 74363ec674cb172d8856de25776c8f3103f05e2f)

We better drop that patch from stable, I didn't want it to be
in stable because the patch didn't fix any real issues that
affected any users.

> in drivers/block/zram/zram_drv.c where attempting to set the size
> of /dev/zram0 after loading the zram kernel module results in a
> kernel NULL pointer dereference.

[..]

> Steps to reproduce:
> 
> 	modprobe zram
> 	zramctl /dev/zram0 --algorithm zstd --size 83886080k

Not sure if "regression" is the right word, that zramctl is deemed
to fail, it's just on older kernels error-out path is now oops-y.
Regardless of that, we better drop that patch.

