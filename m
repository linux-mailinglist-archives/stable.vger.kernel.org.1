Return-Path: <stable+bounces-39402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FEF8A494E
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 09:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B238D28217D
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 07:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC0B2C1A0;
	Mon, 15 Apr 2024 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="d+fC/07i"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051E2575F
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167198; cv=none; b=LQdvdGiJGpM9avtcO33vtj+5D9+sEALklvEadB3VE2HFIqjbF2A9XxscI7GMb1o24yrkzBtcI8RY5XG6gGOtCnBb4gBSl1Q7yTTlnJvtY5/uUUbjEDHJgbCh6u46tnsXq2rn9n8I20TkQZLxOfBE7OJHUzngeeBAiXQ2MpgH2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167198; c=relaxed/simple;
	bh=1e7u3kV5t8LwM2pKr/aFtdJMPxDYedtqAYxa8UclZ+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUr0Ir3dFqdEjvthfiUj4S+97W4KXFuoJf69yxk1VE+RMct+xa//NbX4yyE6BlXaEOESxrWbBELamSkGYJdWRM+Y7wVo5VM+Kq8WvZt5w7xB/UFtnJ7qqJ49V84CFfjJOuo+PEkAjs0ZyASXYJ7nkXnJ3ln6QA1VVMXhcXKpHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=d+fC/07i; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a52582ecde4so130454766b.0
        for <stable@vger.kernel.org>; Mon, 15 Apr 2024 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713167195; x=1713771995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+hd/NyG+znuJ0wUqzTHeG03XRCxC4P7dgrjDN13bJMs=;
        b=d+fC/07ijvp4tUT2ha2l79Xw1uVfVVfWaVqVyZb9E8K+Lb/93tSv3jfrHuxN9ykVbB
         pVO9REOTPYydCuiKmq5a6JZqGkwTVC9BkHuwA/R5fo6u38LHNDaGtTWhI2eqS9syk9wp
         4JKqMZxHoiBZEVM0CX4cd0utuerVVRe4Hhg3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713167195; x=1713771995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+hd/NyG+znuJ0wUqzTHeG03XRCxC4P7dgrjDN13bJMs=;
        b=jhTpib7/k1E0ai0ZibT7Yp47YFFWlsr/1HMMlB2CsRWrIVgmVqiKCu5nkJXadiRJCT
         V3Fv8c04RihA1geIJbkxDx2IvBLBlXBcFE4YRmqyQc5IzKvr51Sa6EtLOapSq3lRqMPJ
         nFf28GeWsppB+ZOMvb2McPfdeaaJ7Uqbi9Dmxv6WmSqT0HyXnLs+jh1p0g8KPaEtBkkT
         OxBEFU/GBo0421qJhSYf+lTuXSvlvk65y3rfD6sfND+ihAGSVgb0cDpo2kRvFrPERlJ6
         86Rbr1zrjWuQ6Eos0jcNYYQP4ch2FNosVxi5tjkDv4nPfxl8fsl2BTjLftpVffeVcGyr
         f9AA==
X-Gm-Message-State: AOJu0YwCDpDqKHuOVNymE7ndBcE071OXxn+Ic/iApfUtkETiDZjhTO2i
	HqUgHTSxcoiTYxx5IARSSg0tDPiCG9/hWGsZDYe/E6FjP/Rppr6dTjVOGLv1GOCkcIYZ+Yp9Atz
	O6lwDJYeWgpgdgkc+VVJBwfuCd6GnPNTqVKtDcQ==
X-Google-Smtp-Source: AGHT+IH1sV3/Lh9lsnk6xorjzsimUfkG07CF39wxzp7zosnFjYQ1oyb3rqO8DAp/9chMJsDnb2vBAWH0bCweun+HFpU=
X-Received: by 2002:a17:907:944b:b0:a52:3525:33d5 with SMTP id
 dl11-20020a170907944b00b00a52352533d5mr6923543ejc.11.1713167194792; Mon, 15
 Apr 2024 00:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414003434.2659-1-danny@orbstack.dev>
In-Reply-To: <20240414003434.2659-1-danny@orbstack.dev>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 15 Apr 2024 09:46:23 +0200
Message-ID: <CAJfpegvhym5UUBpsn2CMZ_duv3Ook6JDHF=h5A7Hz4dY1jU9PQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix leaked ENOSYS error on first statx call
To: Danny Lin <danny@orbstack.dev>
Cc: stable@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Apr 2024 at 02:34, Danny Lin <danny@orbstack.dev> wrote:
>
> FUSE attempts to detect server support for statx by trying it once and
> setting no_statx=1 if it fails with ENOSYS, but consider the following
> scenario:
>
> - Userspace (e.g. sh) calls stat() on a file
>   * succeeds
> - Userspace (e.g. lsd) calls statx(BTIME) on the same file
>   - request_mask = STATX_BASIC_STATS | STATX_BTIME
>   - first pass: sync=true due to differing cache_mask
>   - statx fails and returns ENOSYS
>   - set no_statx and retry
>   - retry sets mask = STATX_BASIC_STATS
>   - now mask == cache_mask; sync=false (time_before: still valid)
>   - so we take the "else if (stat)" path
>   - "err" is still ENOSYS from the failed statx call
>
> Fix this by zeroing "err" before retrying the failed call.

Thanks, applied.

Miklos

