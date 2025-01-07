Return-Path: <stable+bounces-107832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A67A03E80
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 13:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1FE161206
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5A71E9B3A;
	Tue,  7 Jan 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evjvBk6Y"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE4C1E1C02
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 12:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251455; cv=none; b=BaXXfcIt4IKRyY0sgT4xndubFQlIxqa0LmEOe0ss/agAoAW7I8VLS9A+cwUTIDGQR3oGUsdkjAMhbKg8jYZSlv0wwGOMpmyTFFgS1nBXXBuJHe/482ZADChUWmPg6ChN9Jth3Q1QL1MAdCRclCg0d1ior4+tjZIfqZAgFfoKux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251455; c=relaxed/simple;
	bh=FJ2nluP0U1DNjzdsDupwT81e9JypfHhfzlKI5y49qRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9MmXHM72P7cwC4L7OqfQMgPuixTL6YUjXw+EEsUDingChBRudP+Y2ZrDIA59oJihAJMPdyLdpN4WU4pBR1Mj1C9i3SP1VCrSPvC3sM+uhMpjYrzO0qyf47FqB1BXjy4pNmTwVxCK7HTpIH/DtxG8dcj3koJtYp++HZPedaJ+Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evjvBk6Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736251449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dzBLLOp8eNpGsd6cUumXxsmOdst/gq9nNd6WoidZRM=;
	b=evjvBk6YXNFamXVrHmsUD+Af494Sqbhib6I/9+rQtzNlnR0nDEqjaU67fuNqz4MPPPG41r
	N9btq18cRKLyNzL1v97kWKLcyAgEi7gvTVUVNXdynrfiak+LTdu0c0tXTmI5rGWn96/LCF
	X0V8RG5ptFQYb1i7hbUzMC+r1yalkqM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-1YccymaTPlS2mC___ihyYw-1; Tue, 07 Jan 2025 07:04:08 -0500
X-MC-Unique: 1YccymaTPlS2mC___ihyYw-1
X-Mimecast-MFC-AGG-ID: 1YccymaTPlS2mC___ihyYw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3862be3bfc9so8644462f8f.3
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 04:04:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736251447; x=1736856247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dzBLLOp8eNpGsd6cUumXxsmOdst/gq9nNd6WoidZRM=;
        b=rBmyNWN+C3DOQKzG8w2YD2vqgujqNcsQJA86LjUSYD+KjtpMaAgs3euD1dqtfZexzP
         80ll2lENlJINw/TmjgZusX8nNUMVMmAzF18RZxkd0BvhDKrnNQxm8720any63fzW/8zu
         DVurpOKekCyiDgySydJ07UucCwvoLXa9QLUyujIgfBqb78u6CBoIFudKP+Banx1obGyb
         hXWx9qHrHtoQHmSKXHHTgLmYO4X3c7xLc8y9aWH6gf+ZBlPJcBv9Mj3xbqFNirzD9nfc
         TEnGSoujCsFcA3LJRW2ys8BX/krD/qJhk9JnW8SJ7IRCgQqjHAp0YQ4VZlSDbbI2Y3W4
         jOAg==
X-Forwarded-Encrypted: i=1; AJvYcCUhZunP1Qh2a4tyLdSM2tgmBbO0aDaEzN3Gy448forg8cJ/vMIIplhZF4j0vi8sjF2lr/58VWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwb2B7YRKJ05tkFEqR73trPLyS4caQ7zQnmwbSHzyWd41ysPAZ
	NQu2oqbMf2LMN5T6Fw+YDnHesllBdqXGi1fUAUMcqf7zEePjcRMxAP8tLmhEyGlGpXiXvcymCgB
	Ikc4cKhRrtwo0puki/xYoxuR1UgWQFVuMhApdMjZ4jbx9rv9tcBdRKA==
X-Gm-Gg: ASbGncsqGlBnS8JZeDqOsHI20YdKvCjE7fazdBmgDyc7IH7pQKnoasTZVXYv9EBldIB
	KFz2qdb2tZCjqjgkK5ctiHr22+QJwAwOFqC6v+o4rpmU/HQF/8kZsU4+GN/FMAg2mcs9XAoEjLR
	Re48d5KZ4kbn5fQfm5tV2K6k89xH/hCPac5lCO9UzCS3nNMHk1XxNajS+VXC6YHC+DzAGnKAyOL
	Z6mVkP8+QuBU3AYtpj0pRicjg8QJ8A9XgSlfGLCorbBVX8Zxfgjy+mG4VQLdu/bUPYsMHDOTdsH
	GbK6nH8z
X-Received: by 2002:a5d:5f56:0:b0:386:1cd3:8a00 with SMTP id ffacd0b85a97d-38a223f5b41mr59871349f8f.40.1736251445745;
        Tue, 07 Jan 2025 04:04:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWfb9Vm3Vt9Qk+wKzvMGFSZQzXSCS52o6qWqfR8nKRXCO5SfQ0ddtzkhw83y3pCZhrNPA7iw==
X-Received: by 2002:a5d:5f56:0:b0:386:1cd3:8a00 with SMTP id ffacd0b85a97d-38a223f5b41mr59871192f8f.40.1736251443868;
        Tue, 07 Jan 2025 04:04:03 -0800 (PST)
Received: from [192.168.88.253] (146-241-2-244.dyn.eolo.it. [146.241.2.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e278sm50877687f8f.75.2025.01.07.04.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:04:03 -0800 (PST)
Message-ID: <c6547053-7de2-42a2-b8f7-6837e9ab85ca@redhat.com>
Date: Tue, 7 Jan 2025 13:04:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ptp: limit number of virtual clocks per physical
 clock
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Yangbo Lu <yangbo.lu@nxp.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, cheung wall <zzqq0103.hey@gmail.com>,
 stable@vger.kernel.org
References: <20250103-ptp-max_vclocks-v1-1-2406b8eade97@weissschuh.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250103-ptp-max_vclocks-v1-1-2406b8eade97@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/3/25 2:40 PM, Thomas Weißschuh wrote:
> The sysfs interface can be used to trigger arbitrarily large memory
> allocations. This can induce pressure on the VM layer to satisfy the
> request only to fail anyways.
> 
> Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> Closes: https://lore.kernel.org/lkml/20250103091906.GD1977892@ZenIV/
> Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> The limit is completely made up, let me know if there is something
> better.

I'm also unsure if such constant value is reasonable for all the
use-cases. Any additional feedback more than welcome.

In any case, I guess it would make sense to update
Documentation/ABI/testing/sysfs-ptp accordingly.

Thanks,

Paolo


