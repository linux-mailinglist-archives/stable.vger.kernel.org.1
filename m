Return-Path: <stable+bounces-107952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75008A051D0
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 04:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5963A2422
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 03:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC54B17C20F;
	Wed,  8 Jan 2025 03:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H8B3LEAV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4532E40E
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736308739; cv=none; b=b/6rqfjnfoS0LgR8FAQjNUWwqR6xrod8AuUGc+LOD5RIPCzkEwPrCBkfUtm6FdR03t4Lhq2MwrLej7p/BBvS+ttgYwXr5LRQJXaAdLJ4vcuv7L9/tBIgLzzn3WThraVK3eFHoAs6zaakkDo0wzMMOg7Abl1KeXqRhsqRNsSCDRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736308739; c=relaxed/simple;
	bh=Wqsm2OX2pUiC8B3MPlIcLexKxiaNigUMw7QhyjuPCIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kchk50Df2yEEXtoxXeOJlEMcLlnMNwD8SKbscQv9m6Tx/N9W8cSVs3QqP9EAZDnAgA254k5FTPjWdSHchsuv4ZhXiH1XKIXmHq03UCCEjkTsA+KLgm4diIJbwXs2OzrI55xqAuhjRUBxZagX1JX4yem0xHwfSN3wO3ANCi8Hjn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H8B3LEAV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2156e078563so209317975ad.2
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 19:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736308736; x=1736913536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/5SJfDYo1krnMaVXgKeA8KZwOLGlt8uzSPVvBfgdcUw=;
        b=H8B3LEAV9dlDgGdvczg5tfzxy+R7oQ2LOc/gKgATtu9/60iLOrSkCMzzAzEu8Ma/RM
         rbpqc1Y3sAPdNt1a8bGqepwagyo8Yj6P0GwCrPmOCDGgpTT8DKRnd6yGZlaaObDVdk70
         WijNYIO3r5TxL4mwIHQUlnarofHBMnaC/jO2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736308736; x=1736913536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5SJfDYo1krnMaVXgKeA8KZwOLGlt8uzSPVvBfgdcUw=;
        b=TU3YRqc0zYprf3yuHpRUn0BRmRSlB61zYSwx+cSeyHV1dGXnlZsrSQj+p6tBq8YM1I
         9PVwpdczyHh6qxSPQ1cMaieaCpHEaSFqFYwtdgluGmlg7pIL83GhmnyJqekoIXhMpMlR
         mXzSjSBgjh/KlF3KlR8ix42uBuUkGOx3HWWDEZPDQApF/UamaM7jfMb7bj1PmAfbCsoM
         E9Fp1JuLzDqoD5yoZnW6r/Tqr0GaKMSNUSxSBxpG+ajj+tk0r5bpYCPKm++9ucLJx3sj
         sOis15u5v5sLlnCIaqNEsK3/OLbU9Mn+KfUWRPGc17HNR9W2Ywm1WxzTsw/XBLGOKUEy
         pjWw==
X-Gm-Message-State: AOJu0YxSMr/bYUj4xa8cWDAvpAkpD5HLPm4rFyv0FGrXTkaRhpQQGFSq
	9OpaccihzPY4VyZciJtPUiZEM3XSbF18LjH/ffIWKYvnSa0YtCOHH6bj1hOeMxODVnnRH3QwCVA
	=
X-Gm-Gg: ASbGncvHG8aU3ZX0VCfM7pSBRpd7sKMllBmquS/ELizJ5ttyeO09yjuUyyf1KOjWDxp
	chl0KBW6Dlii3cfZQYAvTxF8b5fZHZpO3fn8SUCewzaU2nIpD93GlSE2ViCTtPIrHJ+n9Yy3bj0
	DOT+M2bzWdk4+gIQV+JrCOgyKn1gYS7XRgqZPAzRLhwmcj/CinUOlsHGntEttrp65D+WC4xzLmh
	8KQsFFob+CIRba+GG1OwhtTqw3ioGuT9P5rgADYqEOIafaZtTSGgGomA/sl
X-Google-Smtp-Source: AGHT+IHk9xNeOcJGphe0sHJuFkp76vnbwL90DLnRx4ZAZ8BLyvlFgQKpq5hj9YdtEyneH32ttDxjaA==
X-Received: by 2002:a05:6a00:9294:b0:725:cfa3:bc76 with SMTP id d2e1a72fcca58-72d21f115b4mr2151749b3a.4.1736308736575;
        Tue, 07 Jan 2025 19:58:56 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:57ef:1197:3074:36c2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8faf93sm34135735b3a.153.2025.01.07.19.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:58:56 -0800 (PST)
Date: Wed, 8 Jan 2025 12:58:51 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Kairui Song <kasong@tencent.com>, Desheng Wu <deshengwu@tencent.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.12 110/160] zram: fix uninitialized ZRAM not releasing
 backing device
Message-ID: <wpzuuv6x4bhfldzk2x56yceyymom7jektmwdz5eizugfx3r6od@w7qllyd6vkvf>
References: <20241223155408.598780301@linuxfoundation.org>
 <20241223155412.926326153@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223155412.926326153@linuxfoundation.org>

On (24/12/23 16:58), Greg Kroah-Hartman wrote:
> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Kairui Song <kasong@tencent.com>
> 
> commit 74363ec674cb172d8856de25776c8f3103f05e2f upstream.
> 
> Setting backing device is done before ZRAM initialization.  If we set the
> backing device, then remove the ZRAM module without initializing the
> device, the backing device reference will be leaked and the device will be
> hold forever.
> 
> Fix this by always reset the ZRAM fully on rmmod or reset store.
> 
> Link: https://lkml.kernel.org/r/20241209165717.94215-3-ryncsn@gmail.com
> Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reported-by: Desheng Wu <deshengwu@tencent.com>
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Can we please drop this patch?

