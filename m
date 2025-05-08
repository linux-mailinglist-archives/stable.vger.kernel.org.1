Return-Path: <stable+bounces-142831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC049AAF7CE
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 12:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC981C204D9
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 10:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB59212B3E;
	Thu,  8 May 2025 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqADccl+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E61D8E10
	for <stable@vger.kernel.org>; Thu,  8 May 2025 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700265; cv=none; b=bdLoVSy6eVjCb7iF9/vdGcyWLY+DRNI3TIShvEiu16KXOjqI1aiFck7RViE2M2JOaTKTTEluKDgxRz8mN5/bZoFuCLjorM2gcsCt5K1KfJp4+K4It4sO3K9inBfTMjqUfsNfneIzLspkmkH2ok89U0gksre4HOnxCKTeMkx1vhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700265; c=relaxed/simple;
	bh=A8YkZE941Qo2bcb2V5y4qh1al/nROQMu27FsUkwRXXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPomJorWSf6dgDi4CLaB8a97bTMTMdDh5Sy4BwvuYnRjGCvKmmLZSk65HV5mI7PWP+aF0xZls2PQyAxU7CaK7pm43lxtuMRCdlzVUM9G+e6y2jRV00lerzDtmR0oST+tSmUUckd6n8IM2s5SqtTsH6LE4+GUjM1PQMyD52f4a6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqADccl+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746700261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KppfSxPYDF6f+QjVb7FQQnMkQOL1arXunk8/zYRcSfE=;
	b=fqADccl+9yKL/l4/lBr3UbYb9zkjHzVXjQ3U5Sk0A0C0SYIdZCGNWTyPLaOA2WtxgdEHAj
	mW5nT+chITkLe6/w9NOS9TLO7l6vqOCw9p9wtfZihRZnXtgI8xtjn/0YGTbVakXJ1L0met
	vcq4GJhpBCPle9mJrkfkODwoZ3q+yy4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-OsJKEImxPYCS6IQnHpNluQ-1; Thu, 08 May 2025 06:31:00 -0400
X-MC-Unique: OsJKEImxPYCS6IQnHpNluQ-1
X-Mimecast-MFC-AGG-ID: OsJKEImxPYCS6IQnHpNluQ_1746700259
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442ccf0eb4eso6110595e9.1
        for <stable@vger.kernel.org>; Thu, 08 May 2025 03:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746700259; x=1747305059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KppfSxPYDF6f+QjVb7FQQnMkQOL1arXunk8/zYRcSfE=;
        b=SxabHgGRMpNLFwmilDAXft0De7sAIPT5m1bH7ekldBrMhicr7PA42SHxTIKymbIjAq
         rbkimFlc/GNoISTL8YPLUgsAngLN4LwsgXBX5kHYpqgbEI85wV9t1DKyY3HQNsY451Vo
         25+w93izRZHtI8rSuSpJUTlSB+nzrlnNAqkwfmyzZJK52SSFQYGdROX9IkBh9yoEZjtp
         k84pX1bf6Uq/LQT2CktaeI6HdQp+o7gMkdUd9c1di13MAEtkPDOybmjQPVmKzF4e4yo3
         Sj3o45pJsQjWM8gFPP53/uGWdvnt0EZmt0W8PUExqpDQoEDyrrLUV9HSVBHG8PslA/hs
         DvIg==
X-Gm-Message-State: AOJu0YzNzi78csQALta/ts19ka0CmpnS6EPzYiXmw2kEgi/EARNgIJ3g
	UamHfNXg7vegpCHGKzb9RXGywxlrsT5HCPsr/YtlSztVQML1XT9KuY021xHTbgCHqpoVq1yzi6L
	Pq7ya0Kbcv+xwKP37+1wInPwgCgmC2Didg8fh55oAa0x1Z5IDBo3RMw==
X-Gm-Gg: ASbGncu56bZnNlMYp2t+iyIsWDrEPEPi1DGnKFq9FyR6yVXPmfX0JWv/1RZCWU1Cowz
	ifnZU9bMqoWhf0Xej4ynxkXc6BGMZSm2eSWuDtGRwew83egplbFOsyz019D1koUbkOj9ExJuOJP
	cgikPo7bjixBzN1aFP0na55kAnkOVow12SSVgCPvjs0J82GLwV9L03H5nAi/Lv2F/Ntq44BY9HY
	rFEK67JVoWNRLk+NHDcpEyDuw27El6Y69xqQkJ/bIUwyObYaQ3Ax6o3TIrPm1o+J6Al8mDF1icO
	jyDJfA33T+tJfsKB
X-Received: by 2002:a05:600c:c1d7:20b0:43c:fd72:f039 with SMTP id 5b1f17b1804b1-441d455c28emr31167015e9.11.1746700259163;
        Thu, 08 May 2025 03:30:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdfcxunDocP0pDjfnkPBi4M69qa1avvBAI2s5ulgVlUCPUhVgsQbaizTm4UBvb6rLfNgp1Ww==
X-Received: by 2002:a05:600c:c1d7:20b0:43c:fd72:f039 with SMTP id 5b1f17b1804b1-441d455c28emr31166825e9.11.1746700258778;
        Thu, 08 May 2025 03:30:58 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:244b:910::f39? ([2a0d:3344:244b:910::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0ba657db7sm2068319f8f.51.2025.05.08.03.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 03:30:58 -0700 (PDT)
Message-ID: <c993748c-18ba-4dad-9130-01ac35322491@redhat.com>
Date: Thu, 8 May 2025 12:30:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/2] net: dsa: microchip: let phylink manage PHY
 EEE configuration on KSZ switches
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: stable@vger.kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com
References: <20250504081434.424489-1-o.rempel@pengutronix.de>
 <20250504081434.424489-2-o.rempel@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250504081434.424489-2-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/4/25 10:14 AM, Oleksij Rempel wrote:
> Phylink expects MAC drivers to provide LPI callbacks to properly manage
> Energy Efficient Ethernet (EEE) configuration. On KSZ switches with
> integrated PHYs, LPI is internally handled by hardware, while ports
> without integrated PHYs have no documented MAC-level LPI support.
> 
> Provide dummy mac_disable_tx_lpi() and mac_enable_tx_lpi() callbacks to
> satisfy phylink requirements. Also, set default EEE capabilities during
> phylink initialization where applicable.
> 
> Since phylink can now gracefully handle optional EEE configuration,
> remove the need for the MICREL_NO_EEE PHY flag.
> 
> This change addresses issues caused by incomplete EEE refactoring
> introduced in commit fe0d4fd9285e ("net: phy: Keep track of EEE
> configuration"). It is not easily possible to fix all older kernels, but
> this patch ensures proper behavior on latest kernels and can be
> considered for backporting to stable kernels starting from v6.14.
> 
> Fixes: fe0d4fd9285e ("net: phy: Keep track of EEE configuration")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: stable@vger.kernel.org # v6.14+

It would be great if either a phy maintainer could have a look here.

Thanks,

Paolo


