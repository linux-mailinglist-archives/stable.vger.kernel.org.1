Return-Path: <stable+bounces-110423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13007A1BD9B
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 21:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041873ABEA4
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 20:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BB21DC759;
	Fri, 24 Jan 2025 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JphXKevz"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31971D63D9
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737751639; cv=none; b=OfE/7//Wabk9ZArlmUVyidJg83Viyc/HvE6D6iPWfEXs/WbLLWZaTN7Ajy2A9403bxptIlSx2/w3DRx7v4yer7Vn2OVvFrgoR16DNA4Y36bdsPmNAfRT9dQCGlmjbHGFY1bWc1vM/9uS2oIomDyC7T4hmhgXQZPNISiv/Rf65bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737751639; c=relaxed/simple;
	bh=tpL/TsUXCd7sfV5n5avBkyJe0b5ilPtT/vNnXnDgFp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0HHlU/Pq9YTBqW1F7nQwuKM/XZV0gDtpTTefoTD5ged+/PsPFrMyt8ntQpgER2hOeque/XbyQrKnl2dm5NTTcBSGdRgMiQTC0BOO9P9c5Bjk0FUiTSviHznOpf+XfEfyzfsCCdWv+AI2cH2HTcuj4Ve3EeR3NAbOv7yKAo3OQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JphXKevz; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844e55a981dso69034739f.3
        for <stable@vger.kernel.org>; Fri, 24 Jan 2025 12:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737751634; x=1738356434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DaJqWcsK9tZSSa1bedlEwird8dsdxNAvQOMECXsQVDM=;
        b=JphXKevzDnvBkm6EeIp8rLMZxC+mTYbXsbjpDPz5An0hzpGiXLWxcfF9cISQ1a05PT
         nTouR7unYQm7Ew3uu7mml3gytB0fTlqfKfIgEEe0U5MzE1YB+oLhdrZZBWkTctM1OsjH
         Ly+nH9cXJFLdLFu6xsZlCklvsjAhgfIKf48ZDCW81C0Gvyhv7m4dAW9MLFdU5+CsHzqq
         MM4ZNA96t9bqMN2/Blt5ndj3fmuJz3hv3bBitkiG+x/xHq2ewBw804f0Kq3ubo9PygBl
         TEDklNvi7i+Mnk2En1Nfi+Yd0fMl7auFMWjFl9VThfYmEqZ+tDPlDr1nV88ca5BMLtTL
         2rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737751634; x=1738356434;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DaJqWcsK9tZSSa1bedlEwird8dsdxNAvQOMECXsQVDM=;
        b=H9k1avlzNvPTzwYbiDV+P5yorh44LCNayiM4P+BRFmSZYS7n7s5GBDgfTYmDpNhx2e
         DAQWmzooINdVpyZIS3qp7U+4xofVmPe0j2f3nYVKYQVIPblqj7RZzklsrS29p/0EnYnM
         wmQv+ZhWQdvHi9oJh1h7yqVjJOt6pEwFav3oJwCAqu6HBxiLOILyqUxTYorZSN5WwXHl
         83dzq1aV5mZNhyIhJ8jW9Lgzagbk19gViLj48TmZK2w8ZedwuQ4PVehuP8CNvXIgeHzV
         2J2+t4Ei6SH/1fA1VbC64Bxq5tJHEv6vxsCAEqyZzTRa7/sgEMu8HCGuLHt/TlpAugfg
         Rz7g==
X-Forwarded-Encrypted: i=1; AJvYcCXOPUK8OYanjKK8fprbo8Aa2SaOn+SJJoy/eYzBtaveQmjoWMrBbXJp7M7AhbS7Ucsx93TseVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMSyaxDTcDSvmV3A4bW8b5XIysrlUj7a6auHdJLdd8Kmqp4Za4
	d+TNFZOX4wS2dFej3OR9kgajy3R9bI0wUsyolmQyoDz+BSc81ZHxSBKnmbRiR6s=
X-Gm-Gg: ASbGncsALBeXPJVeQ47J2Bu64t4Ko333TJtcHo8MUH5yFCECaDWELmzzIviu7OUvxHG
	PK/C3GmgDZndgs4m1nN8FWk0rRtDmt92JVmbUw67Jssn/qQo2xqinbJWJILH3CMptEj1T7UXUYF
	fd+50d1rIV9AsSHXjBcDlu+RHgHn2WjIrsYUBBVOzev2v5VqvASCExa6dJK9id8CV8TgSbyCWM5
	qLN+7dw0hykBamSiTJ8vghvlWCOf5DHg7FDnOAEYho7wRBsSjS+Of/LoNl1yPg8vI3UKa7DBMB1
	1w==
X-Google-Smtp-Source: AGHT+IGa85kSO/T2HDmDdm/vU4Hoj1ggyeLKawatGyavTHXo/cgFo8f8QAYHdaFPxfLDH5S6Q+Hu0Q==
X-Received: by 2002:a05:6602:6b12:b0:84a:5133:9cd8 with SMTP id ca18e2360f4ac-851b62835afmr2228437839f.10.1737751633707;
        Fri, 24 Jan 2025 12:47:13 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8521df2ce32sm89978739f.18.2025.01.24.12.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 12:47:12 -0800 (PST)
Message-ID: <721da692-bd23-4a73-94df-1170e3d379be@kernel.dk>
Date: Fri, 24 Jan 2025 13:47:12 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable-6.1 1/1] io_uring: fix waiters missing wake ups
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 stable@vger.kernel.org
Cc: Xan Charbonnet <xan@charbonnet.com>,
 Salvatore Bonaccorso <carnil@debian.org>
References: <760086647776a5aebfa77cfff728837d476a4fd8.1737718881.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <760086647776a5aebfa77cfff728837d476a4fd8.1737718881.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/25 11:53 AM, Pavel Begunkov wrote:
> [ upstream commit 3181e22fb79910c7071e84a43af93ac89e8a7106 ]
> 
> There are reports of mariadb hangs, which is caused by a missing
> barrier in the waking code resulting in waiters losing events.
> 
> The problem was introduced in a backport
> 3ab9326f93ec4 ("io_uring: wake up optimisations"),
> and the change restores the barrier present in the original commit
> 3ab9326f93ec4 ("io_uring: wake up optimisations")
> 
> Reported by: Xan Charbonnet <xan@charbonnet.com>
> Fixes: 3ab9326f93ec4 ("io_uring: wake up optimisations")
> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1093243#99
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  io_uring/io_uring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 9b58ba4616d40..e5a8ee944ef59 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -592,8 +592,10 @@ static inline void __io_cq_unlock_post_flush(struct io_ring_ctx *ctx)
>  	io_commit_cqring(ctx);
>  	spin_unlock(&ctx->completion_lock);
>  	io_commit_cqring_flush(ctx);
> -	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
> +	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN)) {
> +		smp_mb();
>  		__io_cqring_wake(ctx);
> +	}
>  }

We could probably just s/__io_cqring_wake/io_cqring_wake here to get
the same effect. Not that it really matters, it's just simpler.

-- 
Jens Axboe


