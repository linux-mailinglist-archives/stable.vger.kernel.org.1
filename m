Return-Path: <stable+bounces-176949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 720C2B3F91F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791B71A832EC
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6CC2E3B10;
	Tue,  2 Sep 2025 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZWhiZIh"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256826D4E8
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803000; cv=none; b=sEOz0XcxDVJ4H+pI5zKun9rxBtqo5z4nhtarRYgNOSF4obF17Bdra6HBevBr3Tz/9//6UbZTg4fvf/6BRxNYAr9+Uwi2v5Nqb6y71lqmutUt50GtAYBnvbSqTgH04PxjArEzXb6G9gKyMq+dFlHOyu+u5ndDlSiGnupJBQvEhZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803000; c=relaxed/simple;
	bh=Mhp8jXVEHGh++RDIq3pIwMyTr4EHDwopzBqSg7ZECE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KRDzXwWOpHsUpt51vB0sOs7Rxy2U5QOPb3iHuW78yEKrry3tWbJMuIKUermftg3ZxZTueKAG6wxOAvx7TNSKgAQ9PstysWb6rhiphyBdNBt24wIrn8iSFKgFeOnGnTONnn+IwHMkkgxXJmiqU+1uVeG5fROQhBQuSVDF4V+iguc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZWhiZIh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756802997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rh9RBkvVSEWGQuJL+dDVXK1RYGYVIG9XjSg6HK0oJXI=;
	b=EZWhiZIhZUhCFKSVaM2ufHHRbusDtNhazWtjYRmmv99vPW8BJ+avXHDyfKHJmywFqhLzfY
	LXuQImaTtN2u+Qzq46Wqo+78psKW6+VvuDVXCAwGk1c1lOiChzsJi5qrpEWwo5glGEmdwq
	8nkY5vwkn2pCvGP6Apb7qibRQ7tg1t8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-zO7nlZJINguNoWwKt9BtHw-1; Tue, 02 Sep 2025 04:49:56 -0400
X-MC-Unique: zO7nlZJINguNoWwKt9BtHw-1
X-Mimecast-MFC-AGG-ID: zO7nlZJINguNoWwKt9BtHw_1756802995
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-71fd51d1052so36339207b3.3
        for <stable@vger.kernel.org>; Tue, 02 Sep 2025 01:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802995; x=1757407795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rh9RBkvVSEWGQuJL+dDVXK1RYGYVIG9XjSg6HK0oJXI=;
        b=W6pN4v3fyVhGPW8XRwiDI5UzyfCfo0XA6XSZPfDXEgucvy0GMrTJ8h/Cu4Gcuyqipw
         fZYadqAqpnsqNgK3vWYps1xaqlN9QlFTTXfRn3epwe5vioucX4FwdQWbHcmCQaJJnuFH
         zaO1rWsDC5SBR2YmfjomO6iAZgN/eCRtc1zdvWweSQyHKjZke2p16JwOzbdtJ8QRszsh
         /Rl47NcP7Z/nwyOUAClkPEk4pUpWLV6PKJtcaTuYPGQADWlLw2b/jFNTJnNgAfArCEPX
         y6gqn4WSN6sCAW62LaWhkxgieVQAym9rdoBQFN8kpUQAR9bQWrP9CZIkaziDhNo7mzCr
         0mPg==
X-Forwarded-Encrypted: i=1; AJvYcCWqQkJl/7BWnQtQQGeGbKYbtCF0v8R3tk7+770qREqD8ArzSmmFaDtm6pfxJsF10pAxOsBQg4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEjkYTi0jNhLpKN5tF5S/tIae7lddWWkVrUDaoWEPZFXYYd3Jg
	6pVDbmiVF10Gm2cedqdwmjUUPae9ER6vVpbvGKGjtb70/FlMqvD4R6WiEdSOC/9IMMxsladhX/E
	gWklOsiZoLmIHk4w721v3rugu6ZAZN6mCUlfgGAYT3FXQu7T9Ub4MVZMRWdHhoJwMsA==
X-Gm-Gg: ASbGncvSNBFJ7TwzY6Fg+RkJJ46o+cwMv5VbYH25dot481TXalFPxvy0EWwADW+ZBRn
	XVFYL1857yURKJsTRpaK+Y7Yu2Kjugbh11BfRimjjgxF604ok0/l+RRXHRNU9yeMt2GdRxNkRCE
	BUA8U0a4LdOXmiNPDpcCPThnyCOxhHDzZOAar4mi4REGndTK37ZqXxhkA8x5BWdHn0ORNTRusou
	FRtMGLSvwn/bERltzaw8LInaUq57EGWzyjGnIzMguS0k/mkXl/1HwKhIGPSSagEAShJRRlafpvS
	Bk5pXVLHh1U6eWWsuqFQIQMwICJhPsCWBhgHPiEf7EJuMsvsLUFu3aq9oo9HBAUQa+Hm9+MZWBk
	sci+Cj1Emq8k=
X-Received: by 2002:a05:690c:3809:b0:721:28ef:a9b0 with SMTP id 00721157ae682-7227635c856mr112866627b3.9.1756802995132;
        Tue, 02 Sep 2025 01:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlypMLI8XIGJHMOhhMRO1ynE8DNTCjD9jv/OySdjluZx5qwOhTyzmXtYsCxg0aNhm/A8apVA==
X-Received: by 2002:a05:690c:3809:b0:721:28ef:a9b0 with SMTP id 00721157ae682-7227635c856mr112866387b3.9.1756802994683;
        Tue, 02 Sep 2025 01:49:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e00:6083:48d1:630a:25ae? ([2a0d:3344:2712:7e00:6083:48d1:630a:25ae])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a850288asm3642597b3.44.2025.09.02.01.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:49:54 -0700 (PDT)
Message-ID: <03991134-4007-422b-b25a-003a85c1edb0@redhat.com>
Date: Tue, 2 Sep 2025 10:49:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] selftests: net: add test for destination in
 broadcast packets
To: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org,
 bacs@librecast.net, brett@librecast.net, kuba@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, stable@vger.kernel.org
References: <20250828114242.6433-1-oscmaes92@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250828114242.6433-1-oscmaes92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/25 1:42 PM, Oscar Maes wrote:
> Add test to check the broadcast ethernet destination field is set
> correctly.
> 
> This test sends a broadcast ping, captures it using tcpdump and
> ensures that all bits of the 6 octet ethernet destination address
> are correctly set by examining the output capture file.
> 
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> Co-authored-by: Brett A C Sheffield <bacs@librecast.net>

I'm sorry for nit-picking, but the sob/tag-chain is wrong, please have a
look at:

https://elixir.bootlin.com/linux/v6.16.4/source/Documentation/process/submitting-patches.rst#L516

Thanks,

Paolo


