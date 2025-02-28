Return-Path: <stable+bounces-119921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AEAA494E2
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 10:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5D11710F6
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455E62580DB;
	Fri, 28 Feb 2025 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgTcZtaW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4781E257435
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734792; cv=none; b=hv8Yut2fRnEi18Ay7RWtJouR4i+XDyjxi7WlwoxXw4hR7uYC3eXGGwILtlTEKoCwAtZPGgUp/JwdXgGpobgxF3aHJZ5zhva7pHiazJQBVp2/fOftRPrNx5fFJtIM5uXGR1PWsPcxhqcScpnNJru35uQL6dCY0UiIeJ0F55gcysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734792; c=relaxed/simple;
	bh=qyXnd1QeVCFR0UPHxNUE8dIZREv7JdUyyVgv52l4qOU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YElyVNAVjao2MMsXwQCNG0aImMQFOYtH5rFBZr0YqPqkM0WNXuBfOFqiuOw6d788STeOHFJzQCPC0q/qrWrSioJOppdbVpASdKL1XNeqanVSplMf8EXlz7bwZs/FH/gO6P4lYHDm4+baTM4H5T2GmiRytiGOXBWsmBIj4OMfSp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TgTcZtaW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740734789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qyXnd1QeVCFR0UPHxNUE8dIZREv7JdUyyVgv52l4qOU=;
	b=TgTcZtaWdp9RftO5pJ27kihsKOyq9sH0KF6DIG54CkbH113bZcmhllN9v9Zkwk04eg/6S6
	zBfzcxX9/zMx87WnbGPm9O8wBQsHOWCJAykdOfsja1vEnS5xraZCmC6mrhg7X6fo6aXLqg
	+81+dcp4ggf1nPh8FEM7uC78gKuJWj8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-vzhr7jn-ONiNRtOqRZMprw-1; Fri, 28 Feb 2025 04:26:27 -0500
X-MC-Unique: vzhr7jn-ONiNRtOqRZMprw-1
X-Mimecast-MFC-AGG-ID: vzhr7jn-ONiNRtOqRZMprw_1740734786
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43943bd1409so13717465e9.3
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 01:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740734786; x=1741339586;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qyXnd1QeVCFR0UPHxNUE8dIZREv7JdUyyVgv52l4qOU=;
        b=lgcbo7ZwdlgYY6xmCXZWDerV6ytJqLhkednHp/vW/ZngNAKs4+7F1GMMI9TXitBPWg
         srHBTWBDFjEDoHNCELZQ6GyoIMhkWmZVhBzEWcRbUVO57dCi8lEgWKudbnvq4CZKs8F1
         /w4iJGFT+V/EhIXXna88lTjnN6EjTj2uM6xTAY9jX5mQVC2wFabpMPQioiGnwyXiAXtz
         HKhQOtdIgPPAHcMOFyVOdQcrTouom2V1NSALGXBhxCUQQ539An+nlFb76eGmvdqyTwOi
         4pl4AmO28HGq7JKyIJ+J0osUNaprXA1GTKugkXNxK+fsU84ch3W+jtFFPBwKh15pyVyl
         hmIA==
X-Forwarded-Encrypted: i=1; AJvYcCXnG5bIQ+jXMUfsI8eiLh0s6pA82hbkR9HCm7wllwd2gi3+DtowdKsRdKwNocG7MBltVBzPj20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3h2zTLQY0gVxj+KActGfebHBbAr8m6E/X34abmQg6lRa1GM1
	2C0HXvplZBPU0QtCCKpcNn+DSYXl3jQuCA2AM+H73CPgxw6eazsn+wTdXvW63pgpZ2iZXvyDkmm
	Z0G2AzIT+yPgaxEJzQdjhAfXF3M/N39IJSBl+HAR3Ai/ack28c2VVqQ==
X-Gm-Gg: ASbGncv/VUU+Wy4w+cxOB9iW/k8AWq6eA/eOBT2QV6n0ng57lhRpOy+QpXaNE59OQX3
	fqsQyth/2zdRdIMPSxTmHW6doK9AHvkU8b26Uhttg20fPDPow/4DGZVsXKNLkFzBwovZbh/4tGP
	RV6Kb2GD8FQStQOqaMw1emliQxBjtBsxnbWh6QgOzORNCLYs+mkWvcRp6MbJpW4k4J4mSUEMHJs
	6nl5zQazh/YK84B42nCtSj0a96yQ8jwcXUjXeYVh4QuCuPTEIqtry3FY/xqexZ9CCICN+mcFYQF
	l6Frtfr95gDXevZJ9wklP9LxADaRnW51A1VOye2OJMH2FTizhczkQR4CBz4B6N/9LQ==
X-Received: by 2002:a05:600c:1c85:b0:439:89d1:30ec with SMTP id 5b1f17b1804b1-43ba6747587mr20161855e9.29.1740734785962;
        Fri, 28 Feb 2025 01:26:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrk8HCJDFMTsz7xCP+NNdsyxhZ1X9lB/qPY5M9JGAe9E6mxJhigejXtxTR6plCVUKRLft8mw==
X-Received: by 2002:a05:600c:1c85:b0:439:89d1:30ec with SMTP id 5b1f17b1804b1-43ba6747587mr20161455e9.29.1740734785589;
        Fri, 28 Feb 2025 01:26:25 -0800 (PST)
Received: from ?IPv6:2001:16b8:3d09:ac00:a782:635e:5e55:166d? ([2001:16b8:3d09:ac00:a782:635e:5e55:166d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27b27bsm49277385e9.31.2025.02.28.01.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:26:25 -0800 (PST)
Message-ID: <a7720a091ea02a6bbaa88c7311d7a642f9c7fdff.camel@redhat.com>
Subject: Re: [PATCH net-next v4 1/4] stmmac: loongson: Pass correct arg to
 PCI function
From: Philipp Stanner <pstanner@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Philipp Stanner <phasta@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>,  Huacai Chen
 <chenhuacai@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Yinggang Gu
 <guyinggang@loongson.cn>,  Feiyang Chen <chenfeiyang@loongson.cn>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Qing Zhang <zhangqing@loongson.cn>,
 netdev@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,  Henry Chen
 <chenx97@aosc.io>
Date: Fri, 28 Feb 2025 10:26:24 +0100
In-Reply-To: <20250227183545.0848dd61@kernel.org>
References: <20250226085208.97891-1-phasta@kernel.org>
	 <20250226085208.97891-2-phasta@kernel.org>
	 <20250227183545.0848dd61@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-27 at 18:35 -0800, Jakub Kicinski wrote:
> On Wed, 26 Feb 2025 09:52:05 +0100 Philipp Stanner wrote:
> > pcim_iomap_regions() should receive the driver's name as its third
> > parameter, not the PCI device's name.
> >=20
> > Define the driver name with a macro and use it at the appropriate
> > places, including pcim_iomap_regions().
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# v5.14+
> > Fixes: 30bba69d7db4 ("stmmac: pci: Add dwmac support for Loongson")
>=20
> Since you sent this as a fix (which.. yea.. I guess.. why not..)
> I'll apply it to the fixes tree. But then the other patches have=20
> to wait and be reposted next Thu. The fixes are merged with net-next
> every Thu, but since this series was tagged as net-next I missed
> it in today's cross merge :(
>=20

Oh OK, I see =E2=80=93 I'm not very familiar with the net subsystem process=
. So
far I always had it like this: fire everything into Linus's master and
Greg & Sasha then pick those with Fixes tags into the stable trees
automatically :)

Anyways, I interpret your message so that this series is done and I
don't have to do anything about it anymore. Correct me if I'm wrong.


Thanks
P.


