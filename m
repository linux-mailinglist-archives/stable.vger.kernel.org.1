Return-Path: <stable+bounces-184041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98CBBCEDDA
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 03:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E193E5F88
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 01:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E335878F58;
	Sat, 11 Oct 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h1LGY1TZ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE4029A2;
	Sat, 11 Oct 2025 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760146095; cv=none; b=EZl1bj58Ya5kyWtSZnA9a1p/E+AKTGhnuP7b9LR1wozu21nb8PrhhprsO7MPpk0XDs0rkiqwfN+twhRSyWcDmkkvWG6xGkZriulcpzj9+X0FJgsG/uHS8IeR199++bJm2JveiK95Dzwaj2FKS2oNR8ONtlNCBi+zRKdGVr7s9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760146095; c=relaxed/simple;
	bh=mZB371iOrNllUdVBlwLB2bvbvogMGlT09u3RneTRJ8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msXiiAc2y19DkjOh96YH4Rq4htrKd0PyzdDuxxjpCJHyKhNnOc722GscMG94LgLNuRgowh20/u47xAHacurpeK3N/LyhMgF6Tg95ub1sSTRcbW6TNW+mHRSl4nXUZwh1slcrYh4dxbcHPTrdJ1qM9FKmvdP73dv8sEdw5uUBk3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h1LGY1TZ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Vs
	lW6LEB4jSTSGTxxBBQp+V97w6auB1laU/pOaHFyro=; b=h1LGY1TZAT6OWzTf7l
	Gi853fciBfgS45I1EFYA+gTor2ZRfwzngEV/Hcv9ORyKWzWMWCNZZ+7SE96k50S6
	MSP2xfJ6MZAWNrSEKZ5ksHyoiELz4VWP3K2JaVxJRL/RszkII6LnIDtetUcpceeN
	DbRhrhuwW69fWcLKSpYdmnEVM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXL6h9sulovqVTDQ--.26275S2;
	Sat, 11 Oct 2025 09:27:26 +0800 (CST)
From: yicongsrfy@163.com
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	oneukum@suse.com,
	stable@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH net v2] r8152: add error handling in rtl8152_driver_init
Date: Sat, 11 Oct 2025 09:27:25 +0800
Message-Id: <20251011012725.502121-1-yicongsrfy@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f6cfb923-83ff-473d-a263-8d45933d8cd2@lunn.ch>
References: <f6cfb923-83ff-473d-a263-8d45933d8cd2@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXL6h9sulovqVTDQ--.26275S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrGQDUUUUU
X-CM-SenderInfo: p1lf00xjvuw5i6rwjhhfrp/xtbBFAPj22jprKaFVwAAs2

On Fri, 10 Oct 2025 15:54:27 +0200, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +
> > +	ret = usb_register(&rtl8152_driver);
> > +	if (ret) {
> > +		usb_deregister_device_driver(&rtl8152_cfgselector_driver);
> > +		return ret;
> > +	}
> > +
> > +	return ret;
>
> Now look at this code and think about it.

Sorry, these two 'return ret' are indeed redundant.
I will submit a new patch version to fix this.


