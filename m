Return-Path: <stable+bounces-94511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8EB9D4AE8
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 11:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954E2288028
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 10:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7792F1CCEC3;
	Thu, 21 Nov 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIub6EOx"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9B1CD1EE
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184921; cv=none; b=C8ax4POaBDFFyfDy51lMrCAA+TYxsJeoXwt8X4IebOSGgjlvGaftNrmjGtCvtJIGswo135ZsqqyWhie41Eseap+6SPBcCpvFlM6eL+xPIrcwKlTsXsPTjOvo/c81ZhdBgrE/Lr0qPAifwOrbOO1s8uhX+LO8+tNP3lNS/cXrbow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184921; c=relaxed/simple;
	bh=sKzohGaYqI7jAfKfMkPF4Mb7mwMdcuQHHA0ja+FhXVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZdubbdzUl5DriQU9TBJIUlP5zgwUyH147TF6dqvxBiI5swHJrrqRs9jJe2IO/kKcjwxhyrp0aT26XgsYsExzYJU/QN/YiutAVt1jH/9sX4hSaLxTNEfUEdKNywbWjuVtaUPUGU4gXp8bNVdVC+kVJwmCLaU1F/pDsAO18D5GGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JIub6EOx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732184918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKzohGaYqI7jAfKfMkPF4Mb7mwMdcuQHHA0ja+FhXVI=;
	b=JIub6EOxyD+/Z2dtdwaLdbg5kiVxn0FgnbAU9eX+DUzCzaMnVxdrDGaz0WFmQWc1btPT9a
	FW47q6lilNSLka4QQ1Oy543LoS4RAYw93W7hWobccEE74P3L5dePY72AG179/zQjZcokDq
	od9aqwVk8NR45gpLIUQXHPWlaGTFl90=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358--r7HGpO9OqOqL_ztPoK8mQ-1; Thu, 21 Nov 2024 05:28:34 -0500
X-MC-Unique: -r7HGpO9OqOqL_ztPoK8mQ-1
X-Mimecast-MFC-AGG-ID: -r7HGpO9OqOqL_ztPoK8mQ
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-85707b002aaso416920241.2
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 02:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184913; x=1732789713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKzohGaYqI7jAfKfMkPF4Mb7mwMdcuQHHA0ja+FhXVI=;
        b=Nf4Xc31U5b0BXGZ9yQYe3hT1p/KtKVL+a9WvDGmV+Xfu5Y77hF7CAm414E/6KUVyvp
         U3LZuL2htaW6bRtoFzQ+ExL/jWAXuJ81Fh7LRVKkeQUwUF2xMCf9eXmNkTPUruadacS1
         zS39+i32fhp3kzuvD9g/sov7XCDj8HD1k6mSVC0ylLl3thguXDxoHaW3vUnaS47LT7qh
         ZYHegZDBw7hoPtBJmdy5aW5C3KA22xvApgp6OivO15O8AFDg+yGOaStcUD3UFkse+yY+
         JHHgiODcLyCpJE252ocRH0Sw5Hai3wLO/BcexpTTvSAMreNTYWceU2tAAiu3BySzqIy9
         r6uQ==
X-Gm-Message-State: AOJu0YyKoSYa37XVoueV9nCJb+p2BovE61hP3tauCC7qZ6mug3QsrJ/M
	EbOpEGpMMs1mfDWQhtMUb6uhbqXahk/7uQhHJWrf1S+s2PZzGgYLBmLzxB5uf54J3Y3+9ND1rsP
	Q57TpZxlwCmxpLUXH2pU7Tmz/OSmSd0VSBqottN8uFMUKYc9iMI+yDw==
X-Gm-Gg: ASbGnctlH7txorXIveRHJ9TyElaBNT7rBDI7sWrpLQR6ImB8SsGKTa6dexOdb0teuOY
	cF8CaeXqBVVwpnc+PMRFEpdqysCTEoOjeGviy0//SnlGA79epczQY/+n2v4ntD1R7k0PHB+ZX/2
	ZV0E+SNETyLpaZufLHPMnmPNFti0/AE2U3DIKf4FnUI1R3B9HbdAXli/SsC7XoNH8EPCR3MYnM+
	urfG6xtEVDy5ADxB1m6CVLOY5wceAtGKeGS9/bIJ3UAc9UZD/Pkk9IAgMd8vfJd5sLhct3l5Q==
X-Received: by 2002:a05:6102:3e07:b0:498:ef8d:8368 with SMTP id ada2fe7eead31-4adaf4bb33fmr7794352137.13.1732184913239;
        Thu, 21 Nov 2024 02:28:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvNgLLYktvPtaJaBpniqt/2h5wYTqtk6DE591nq3WhjRfvS6UaO9CP9BTTqW5PKVBbtxtxGg==
X-Received: by 2002:a05:6102:3e07:b0:498:ef8d:8368 with SMTP id ada2fe7eead31-4adaf4bb33fmr7794340137.13.1732184912953;
        Thu, 21 Nov 2024 02:28:32 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4646ab21517sm20273601cf.82.2024.11.21.02.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 02:28:32 -0800 (PST)
Message-ID: <4f621a9d-f527-4148-831b-aad577a6e097@redhat.com>
Date: Thu, 21 Nov 2024 11:28:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI/MSI: Add MSIX option to write to ENTRY_DATA
 before any reads
To: Dullfire <dullfire@yahoo.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mostafa Saleh <smostafa@google.com>,
 Marc Zyngier <maz@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20241117234843.19236-1-dullfire@yahoo.com>
 <20241117234843.19236-2-dullfire@yahoo.com>
 <a292cdfe-e319-4bbd-bcc0-a74c16db9053@redhat.com>
 <07726755-f9e7-4c01-9a3f-1762e90734af@yahoo.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <07726755-f9e7-4c01-9a3f-1762e90734af@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 10:22, Dullfire wrote:
> On 11/21/24 02:55, Paolo Abeni wrote:
>> On 11/18/24 00:48, dullfire@yahoo.com wrote:
>>> From: Jonathan Currier <dullfire@yahoo.com>
>>>
>>> Commit 7d5ec3d36123 ("PCI/MSI: Mask all unused MSI-X entries")
>>> introduces a readl() from ENTRY_VECTOR_CTRL before the writel() to
>>> ENTRY_DATA. This is correct, however some hardware, like the Sun Neptune
>>> chips, the niu module, will cause an error and/or fatal trap if any MSIX
>>> table entry is read before the corresponding ENTRY_DATA field is written
>>> to. This patch adds an optional early writel() in msix_prepare_msi_desc().
>> Why the issue can't be addressed into the relevant device driver? It
>> looks like an H/W bug, a driver specific fix looks IMHO more fitting.
>
> I considered this approach, and thus asked about it in the mailing lists here:
> https://lore.kernel.org/sparclinux/7de14cca-e2fa-49f7-b83e-5f8322cc9e56@yahoo.com/T/

I forgot about such thread, thank you for the reminder. Since the more
hackish code is IRQ specific, if Thomas is fine with that, I'll not oppose.

>> A cross subsystem series, like this one, gives some extra complication
>> to maintainers.

The niu driver is not exactly under very active development, I guess the
whole series could go via the IRQ subsystem, if Thomas agrees.

Cheers,

Paolo


