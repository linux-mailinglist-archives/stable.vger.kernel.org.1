Return-Path: <stable+bounces-105428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5286D9F962A
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9420016AE20
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB871219A69;
	Fri, 20 Dec 2024 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WdrcnkyX"
X-Original-To: stable@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC5F29405;
	Fri, 20 Dec 2024 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711450; cv=none; b=t5WKT0Zgz+VGUEvMdOeL0KSI9n9N+ytPeZJUggVIaSYlwf9by185WQ0TKeg8uv4AANIxrQBUrc8c6NcZZMtndnjbrDyL2MEheRh2Su5ZXxtrIR8/IXBLQHFi7IkMUXaTpcIMTYv+9DruWgpaTuFA6mobtnNEZh42vmU1r8AuYkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711450; c=relaxed/simple;
	bh=azLLe2xwEn0w8mRT14qtqnntr6V54zf2BAoWZmVQ4wo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaqXyrosSW6Ri4i918x6FGSpsF98RvzRG61qkjm82AEfnNp1l3hhUQLoc+Vp0TN6+iXrMX6xd3xPc1DO4yGjwl6ypNoXFxUOUuGvhb/MZ3nOhWAmKL1hZeEDvuTHDLDoiEuoElNp5lR3gPj7l0JKq37Ykpmb7EAjE9702K4wm2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WdrcnkyX; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BKGH7n0088336;
	Fri, 20 Dec 2024 10:17:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734711427;
	bh=XgGAjTZNwBn/Z85i6WDZT8AJq3hE2+N5shzkenhzSio=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=WdrcnkyXuFzZWTAEEqwHRefcFOFE8sqXYOvjF1tjaWRC3ohzyAJE5oiZFHZQPyB8F
	 WlkgYnZUSDTh+V20jydUZePPXCLSh1gx/LEixIco1kA7x3szg9S8PZ5OroKF7t4CFu
	 5Eg82C83/YwGz8znlZkFlva/DuWIsIIdXaDwAa5Y=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BKGH7Hp074138
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Dec 2024 10:17:07 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 10:17:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 10:17:06 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BKGH5eQ049440;
	Fri, 20 Dec 2024 10:17:06 -0600
Date: Fri, 20 Dec 2024 21:47:05 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <stable@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <rogerq@kernel.org>,
        <horms@kernel.org>, <dan.carpenter@linaro.org>, <c-vankar@ti.com>,
        <jpanis@baylibre.com>, <npitre@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <srk@ti.com>
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: default to round-robin
 for host port receive
Message-ID: <6whu7jzxigyqmnk5424ltu3tpdnlgetpqv6nvfbaxvlw2nseq4@y2vi3c56o3dd>
References: <20241220075618.228202-1-s-vadapalli@ti.com>
 <eb573f51-4363-4cd7-ab1b-0d7304820d85@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eb573f51-4363-4cd7-ab1b-0d7304820d85@intel.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Fri, Dec 20, 2024 at 11:41:26AM +0100, Przemek Kitszel wrote:
> On 12/20/24 08:56, Siddharth Vadapalli wrote:
> > The Host Port (i.e. CPU facing port) of CPSW receives traffic from Linux
> > via TX DMA Channels which are Hardware Queues consisting of traffic
> > categorized according to their priority. The Host Port is configured to
> > dequeue traffic from these Hardware Queues on the basis of priority i.e.
> > as long as traffic exists on a Hardware Queue of a higher priority, the
> > traffic on Hardware Queues of lower priority isn't dequeued. An alternate
> > operation is also supported wherein traffic can be dequeued by the Host
> > Port in a Round-Robin manner.
> > 
> > Until [0], the am65-cpsw driver enabled a single TX DMA Channel, due to
> > which, unless modified by user via "ethtool", all traffic from Linux is
> > transmitted on DMA Channel 0. Therefore, configuring the Host Port for
> > priority based dequeuing or Round-Robin operation is identical since
> > there is a single DMA Channel.
> > 
> > Since [0], all 8 TX DMA Channels are enabled by default. Additionally,
> > the default "tc mapping" doesn't take into account the possibility of
> > different traffic profiles which various users might have. This results
> > in traffic starvation at the Host Port due to the priority based dequeuing
> > which has been enabled by default since the inception of the driver. The
> > traffic starvation triggers NETDEV WATCHDOG timeout for all TX DMA Channels
> > that haven't been serviced due to the presence of traffic on the higher
> > priority TX DMA Channels.
> 
> I get it right that the starving is caused by HW/DMA (not SW)

Yes. The CPSW Host Port in Hardware can be configured to dequeue packets
queued onto the DMA Channels by Linux in either a Priority-based manner
or Round-Robin manner. Linux is submitting the packets onto the TX DMA
Channels to be received by CPSW, with CPSW's Host Port dequeuing them
in one of the two modes (fixed priority or round-robin) that has been
programmed.

> 
> > 
> > Fix this by defaulting to Round-Robin dequeuing at the Host Port, which
> > shall ensure that traffic is dequeued from all TX DMA Channels irrespective
> > of the traffic profile. This will address the NETDEV WATCHDOG timeouts.
> > At the same time, users can still switch from Round-Robin to Priority
> > based dequeuing at the Host Port with the help of the "p0-rx-ptype-rrobin"
> 
> why the flag has rx in the name?

The "rx" corresponds to "receive" w.r.t. the Host Port (P0). As indicated
in the $subject of this patch, we are defaulting to "Round-Robin" (rrobin)
mode of operation of Host Port dequeuing i.e. packets received by the Host
Port from Linux are to be dequeued in a Round-Robin manner from each of the
TX DMA Channels (TX from Linux's perspective). As for the naming convention
being followed, it is based on the Techincal Reference Manual.

[...]

Regards,
Siddharth.

