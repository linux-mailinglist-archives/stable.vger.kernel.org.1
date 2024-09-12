Return-Path: <stable+bounces-76019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB1976FEB
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 20:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D86F1F25496
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC2E1BD4F8;
	Thu, 12 Sep 2024 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Aq/LBPqP"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1662C1B375F
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164226; cv=none; b=s7e+nJy8eAGw6dbIYMo9BWZ5BvlC8Nyqh6iDAU1pWES8yyKIVVFen6REQgcsyY5PfPOtRAnY2LX0/hQgb3xg924EYGH+qW2za9daxjjsgKQMBnXrYcr2k+Vmpl3rbPLXXXbTvEQ9vWQRn8Y/Jto4bK4RLbm9D2OQkgDDRhwa+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164226; c=relaxed/simple;
	bh=K9bHNXidNq1NONjRV3KqfvBuioQWkPY4XuRvNYCCu+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDfjMWKKSsP9+OFi3hvO9vFdGJF/KF+L+ZTcW/V04UmWVxVQIvRFMbG2fORkKm/sWzhBLH0Vm/dv2eW0xRgMgSFKGMHtRnbLsMYOU+Dvaw+MdoTtjMpTwQ4/A67HXZCCbb3/eR8geGarVjB3HmZ51xANWGmK/4MzKJlJyV7AI1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Aq/LBPqP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f74e468baeso1748091fa.2
        for <stable@vger.kernel.org>; Thu, 12 Sep 2024 11:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726164223; x=1726769023; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv9p3quoHSsHUIbL7kx+Hg9JdnYpsM4+W5Q4SWHht7k=;
        b=Aq/LBPqPqwSwTtXmXH4ycohnbySVMjyOC0V3KrneLHH0XDN7l5u3u2UFnnA3xMHl6H
         EXMV+Y3JrPccogepbohYDDYc2oAiuhCw2LqdpFvXek2HErffqNENBEpvPhhic1FabG9K
         mcav3JMtyzdNhk5rg52cHBKzpTwK89qRxn1+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726164223; x=1726769023;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mv9p3quoHSsHUIbL7kx+Hg9JdnYpsM4+W5Q4SWHht7k=;
        b=ka1V5YuhzMYEA6IxnVE/UDhe7ZjbNgLRmyiAKJbf+0vcaYCNPF/lszii4WlwK4h25j
         Z33bShczViq3f1eavblQWTusd4KAK2a7NWc+IseK5G4MFhZuGwCe4coJ45/nokSttysf
         p0r9vtxFfU0fowvGR+xNZMlQcuhD+hjwgW6mAMiLqnW9AD3rJmvNZ71zdcP0lq+jj1VU
         oeRIgleT9B6orC2mSp/ww8d92wqejO1yFck5Iu4OnVbUaU0zuuPQpcfQ89LkJ45vXoBy
         OYUMIx3AC/9XLK5Zp3sw9yAZaalO1GQ2HubpZUzLEwxTChdeUel6hR74V0K9+sTC6o5J
         UTBg==
X-Forwarded-Encrypted: i=1; AJvYcCXEr3HU4rlevJUFXc6c26UiM0bFy9cpmGvozw5v9aRyHkXvTodz5XkZdpPssA9yic0upH7ydss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbpWB5fpUMylIBAJCYe40p0lwslT88nJWwvVHk7WVypx4F590i
	zJfhtR9sRcsY6dpigz5T/W8i2n6HiGTaAICAO9yJk63BdJKOl7R5bgtjPYp/Aas=
X-Google-Smtp-Source: AGHT+IGutxN0EFHWMjO/BNwOFXuVUe1ZaE+f32VgpdmDZHWKMPFXtSdvr1s4Lp4H00pwKJtMkdD0bQ==
X-Received: by 2002:a2e:1312:0:b0:2f5:1ec5:f4fb with SMTP id 38308e7fff4ca-2f79190619amr922161fa.13.1726164222726;
        Thu, 12 Sep 2024 11:03:42 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76efbsm6823344a12.67.2024.09.12.11.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 11:03:42 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:03:40 +0200
From: Joe Damato <jdamato@fastly.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
	davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] fbnic: Set napi irq value after calling
 netif_napi_add
Message-ID: <ZuMs_BXeLYX0_RiZ@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Brett Creeley <brett.creeley@amd.com>, alexanderduyck@fb.com,
	kuba@kernel.org, kernel-team@meta.com, davem@davemloft.net,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240912174922.10550-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912174922.10550-1-brett.creeley@amd.com>

On Thu, Sep 12, 2024 at 10:49:22AM -0700, Brett Creeley wrote:
> The driver calls netif_napi_set_irq() and then calls netif_napi_add(),
> which calls netif_napi_add_weight(). At the end of
> netif_napi_add_weight() is a call to netif_napi_set_irq(napi, -1), which
> clears the previously set napi->irq value. Fix this by calling
> netif_napi_set_irq() after calling netif_napi_add().
> 
> This was found when reviewing another patch and I have no way to test
> this, but the fix seemed relatively straight forward.
> 
> Cc: stable@vger.kernel.org
> Fixes: bc6107771bb4 ("eth: fbnic: Allocate a netdevice and napi vectors with queues")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>

I agree with your analysis, but I'm not sure if this needs to be
backported to other kernels because:
  - It is not a device that is easily available (currently),
  - The bug is relatively minor

I'm not a maintainer so I'll let those folks decide if this should
be a net-next thing to reduce load on the stable folks.

In any case:

Reviewed-by: Joe Damato <jdamato@fastly.com>

