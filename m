Return-Path: <stable+bounces-108634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40BFA10EC3
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 19:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AA13AA08F
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11621FBCA0;
	Tue, 14 Jan 2025 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="czibEJnn"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDFD2063FF
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877475; cv=none; b=IVgP5cGHqAPcWSiHK2Vcxqc1rbz9QPSc6y03+0hmNdonD5vNXDo4vnrwlfIVdQ87X6qVyYKhEAN4k1cs3XxCJiiFD7s3Xr0FoYNc06GaGuy2jAorWSy+IvdVOWQQuIfRBZARKPd65X3Zilip+6xjEGA7hUFnAXZEv7maVe5zFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877475; c=relaxed/simple;
	bh=TxMRwYzCnwl6uQRq6op+ElWOVvdYd8d7nOPZlZWcNiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDzuB7ij/XTsOElwgUeh6tYYf9mve0rBwax0AQzHN/WFuZ3F2+JUS8K4NJDE/r8L632KSc4U3UDXEbsu3yPNd7IOnrxTnz2FbTH7U6QPDPHk/4lCs8tiB078+ZB75Ejid2Z1jSBnPjbyTKTtgHfDtjKGjniVgyxP7CHSF/DaJzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=czibEJnn; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ce6b289e43so22360895ab.3
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 09:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736877472; x=1737482272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y7YZstDiXjyB1zPsdbBPJIDIgikogr6PNjNg2k0F+Dc=;
        b=czibEJnnlPjSEmQf3W1mQ0be8cVy88K6ROUwxTx7LgIsvr58aSpOyQf+Hv3NZHbbjA
         YpsavFDpjDD229EFN6Er6t4vVAzWxhwgmZzYBBGkAXvBFSvxxEL5kqSp2PMHp5btgopn
         6ISBj5bHsfdwrYQTqE80N/WRIrwRHLN5LyEhyT7bfC7erHOMVy6IfJNkgiDivCbeBAd2
         /bYw9D9PTo3DuY+OtGiVsLcxMVN8OcHsSrB7zRQHhtZJ6vFOFRrwv5REiux7yV1foZ05
         ouObLz05BIqBzrSMWrJSpeUrkFLfzxypZqZQ2og9V16QObTrEdFElQ9Ovplm/ffOLYUw
         4Zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736877472; x=1737482272;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7YZstDiXjyB1zPsdbBPJIDIgikogr6PNjNg2k0F+Dc=;
        b=kDwnr1Xl+o6dWnhC+5pCD4zlNvNaVv5lMXIer6Zbj0VsbXH6KN7gbPThVGhwEhdEcb
         Kn4+61ezCzikxx9U/30XFwcCCBqT0kpU/LpeM79+lhvi/+95m1pLTK6ffWFb2EzVrt7C
         QQELyeVZAwkHV/L7sYZNMlN0MK7QPPbHEUA15g4S7c75x3ZpAnKC+I3q36WgpLi5l3/U
         zUb8DyagqB1oR3rLPuudJ4rn9m3An8LUuHOddu0T7gD+mV4e8ysFpnqv5D5eYe/s2MJ3
         wWVX3hIO4QIa7K7+JFaJnAF6MYojZ4zniIasDckBuupLxZOpmDgS4RnNAWpKrX3jhA4u
         XWiA==
X-Forwarded-Encrypted: i=1; AJvYcCU3KrEgdlXw5IsuARTCsWZhZnjP5BvA1eyUVk4rc5dBO3b4J3q/OMt2NXYITq1h1W/ywEChFn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMvPthcSeINsPuHEDaKA/LOZ0DzS1O1EVZEAsVDTBxfBHSh/o
	hpwPsPYwME4z2LBd7ylJdxfw+SwYKqB3cGXwmrmXumizdve20WKR2gbSm3kNQdQ=
X-Gm-Gg: ASbGncum4kzNrtOGtyieBrXqXDePgCKtT8TgALtr7BVc98sY7r/WGAVS3PRGCSPtrpE
	1g3tUymNWitLhdXwDuCCDfJA/gANRtsC3/osb45nKeVik7ARFNAYgvVVqQ8Pi+32U2WsVmoNLAI
	X3IKrVzpiG8VS+jqWjiRL1JnJuLiyTIKPywRbGf63pWl31evN+yXdDrxXQut/GW+1w9v9drIOA5
	0d2+y+duuPtteHfacu9dN1+GI5o92BbpXat+hPW+C0ilrUmo1ap
X-Google-Smtp-Source: AGHT+IGM2drpw9X/rMTH6z+8c5xpupNIqajcv4pvVlwSoOOaEK5ifp+uXOoIV7PQX3wBEh9KYkSR2g==
X-Received: by 2002:a05:6e02:1d94:b0:3ce:7ab4:1afc with SMTP id e9e14a558f8ab-3ce7ab4225dmr38914715ab.7.1736877471927;
        Tue, 14 Jan 2025 09:57:51 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b7459desm3632119173.125.2025.01.14.09.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 09:57:51 -0800 (PST)
Message-ID: <d6208848-ecb5-44df-9d68-8845cd25d1b6@kernel.dk>
Date: Tue, 14 Jan 2025 10:57:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/rsrc: require cloned buffers to share accounting
 contexts
To: Jann Horn <jannh@google.com>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250114-uring-check-accounting-v1-1-42e4145aa743@google.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250114-uring-check-accounting-v1-1-42e4145aa743@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/25 10:49 AM, Jann Horn wrote:
> When IORING_REGISTER_CLONE_BUFFERS is used to clone buffers from uring
> instance A to uring instance B, where A and B use different MMs for
> accounting, the accounting can go wrong:
> If uring instance A is closed before uring instance B, the pinned memory
> counters for uring instance B will be decremented, even though the pinned
> memory was originally accounted through uring instance A; so the MM of
> uring instance B can end up with negative locked memory.
> 
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/r/CAG48ez1zez4bdhmeGLEFxtbFADY4Czn3CV0u9d_TMcbvRA01bg@mail.gmail.com
> Fixes: 7cc2a6eadcd7 ("io_uring: add IORING_REGISTER_COPY_BUFFERS method")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> To be clear, I think this is a very minor issue, feel free to take your
> time landing it.
> 
> I put a stable marker on this, but I'm ambivalent about whether this
> issue even warrants landing a fix in stable - feel free to remove the
> Cc stable marker if you think it's unnecessary.

I'll just queue it up for 6.14. Let's just get it towards stable, if
nothing else it provides consistent behavior across kernels. IMHO that's
enough reason to move it to stable.

-- 
Jens Axboe

