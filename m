Return-Path: <stable+bounces-33063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EFE88FC5F
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 11:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C491C28047
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 10:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBB64D9F5;
	Thu, 28 Mar 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBGVToql"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EBF54FA0
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620228; cv=none; b=BAGRu0Oe8vSJHuSkpMOuW8aEF+hsEN5SOq8NcKWTLvyKpIHSknZGj0dWe6K2P9VIXYdIofZ5NohDz4DvfCtG8cOsduSSymVMWPfGWdqFBKczdfZvbYvNzEx5faqPAzEUKMz4F+MrPsHLvHFmhb3WMZcsnNUr4eExGhjk2/dqmd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620228; c=relaxed/simple;
	bh=Ia3GEHBo6AF/0gisTV9YFHPYhs6rKCz7QXOv4EaNzmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdlz3BDewTI0r3yENGB5+uDsZ257gcxdIX4h3csebIQyFgVig/Xvpn7acBEiIb8FTXmpozTqZaIUDREkL513O02s2Nxuu9tkAgh0HR8YiXEj7IzxH65/qQiJjwLOwGc8XuQQ1r1wqlseaJFLJmHhqkoVyYdQ940AWTCI21KuikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBGVToql; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711620225;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mZzDV7IXEaQ8AROUK4rXhX3UCwumbu8VYcLRPE7dego=;
	b=NBGVToql2Lexq7tM+M/kkjKr8sx1I7tr4yxjBLpMEWQtqVrxmNEEtZPZsRxHJp5Op9LZP+
	bP/TvkgS3UHQWXveU5EVnZWCqYpAthC11p0qEXcWaoc2uAQTAkKBCAiA95htFufZrS8+4Q
	fqwld8hpu09QyNvOPa3XmSZp9PMulwE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-K-iiiuHTP5CYe9TC8eIwMA-1; Thu, 28 Mar 2024 06:03:44 -0400
X-MC-Unique: K-iiiuHTP5CYe9TC8eIwMA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6962767b1e7so9993986d6.1
        for <stable@vger.kernel.org>; Thu, 28 Mar 2024 03:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711620223; x=1712225023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZzDV7IXEaQ8AROUK4rXhX3UCwumbu8VYcLRPE7dego=;
        b=ubdZ8cwGlhNiV4m19rrW1P/1BANijj/YwYr5YGGv/S52GixDEZ4tgCtKhMbotenw55
         Mog6Y/uKc3+jl0PwbOZuFhTHfkyj/g70kvyAp0U3R0F6kMnYE6wAvGZyn4bG15VaeJUU
         vVfsVNy0Tvvychd+OhdA5vmyAtTwMVC/o1qnQ2Ya8rVq4QOvaZYkFRpHPzXwpA2Xc+GU
         UJJoxAAMeD8X6MyfbIBPeVqCP7TDRGElDgw9v1wo/vJKLF+b448iKYKtgKTvf0eeAHDw
         O7aLTDojwAj39t8Vh/NttjxlHgyxrs3rOx1PC7PQBsD8v1SpwdpnZlOVsJgQjyyEKZjs
         wg8A==
X-Forwarded-Encrypted: i=1; AJvYcCVg38sYAZ8OXaWf31EiuU3tG0rIN/UPIz5K7QW3njM1W5sDqbYefl+CEbqryl21Q+jbw2stA6QeC1ASQzOgnaflqQ1JFC7z
X-Gm-Message-State: AOJu0Yz1eTM8EJ6X6QBOQzhc7OBXhoahN/N09BaZ3GU7VTynPzvofxQz
	4lbIC2es06GWxzqZibx4xcZZ2chVOPXHLRVQrYg3HcCUeC3GKU4xWu/8D4yj0kVsOotoRuFgu34
	m6eQUPN8M0MudB+USLRidYjX/SrTS7g5yoZBMLpP5oCA0kqAC9uBdFxua1T+h4w==
X-Received: by 2002:a05:6214:5587:b0:696:b169:9372 with SMTP id mi7-20020a056214558700b00696b1699372mr2320006qvb.24.1711620223507;
        Thu, 28 Mar 2024 03:03:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9De/EWnd6G3jNoM9lPNKj3UNm1iGFACi4RlsYU5GWqD7JJc2ygC4rst/7oUyR+j9XUdhZbA==
X-Received: by 2002:a05:6214:5587:b0:696:b169:9372 with SMTP id mi7-20020a056214558700b00696b1699372mr2319992qvb.24.1711620223245;
        Thu, 28 Mar 2024 03:03:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id u10-20020ad45aaa000000b00696a47179a1sm505887qvg.14.2024.03.28.03.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 03:03:42 -0700 (PDT)
Message-ID: <bff69f62-692b-481e-bbad-020148894f7b@redhat.com>
Date: Thu, 28 Mar 2024 11:03:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 6.6.y 0/4] vfio: Interrupt eventfd hardening for 6.6.y
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, stable@vger.kernel.org
Cc: sashal@kernel.org
References: <20240327225444.909882-1-alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240327225444.909882-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,
On 3/27/24 23:54, Alex Williamson wrote:
> These backports only require reverting to the older eventfd_signal()
> API with two parameters, prior to commit 3652117f8548
> ("eventfd: simplify eventfd_signal()").  Thanks,
for the series
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric
>
> Alex
>
> Alex Williamson (4):
>   vfio: Introduce interface to flush virqfd inject workqueue
>   vfio/pci: Create persistent INTx handler
>   vfio/platform: Create persistent IRQ handlers
>   vfio/fsl-mc: Block calling interrupt handler without trigger
>
>  drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c    |   7 +-
>  drivers/vfio/pci/vfio_pci_intrs.c         | 145 ++++++++++++----------
>  drivers/vfio/platform/vfio_platform_irq.c | 100 ++++++++++-----
>  drivers/vfio/virqfd.c                     |  21 ++++
>  include/linux/vfio.h                      |   2 +
>  5 files changed, 173 insertions(+), 102 deletions(-)
>


