Return-Path: <stable+bounces-45551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32FB8CBACC
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 07:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204851C21767
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 05:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623877711F;
	Wed, 22 May 2024 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H8IMATtF"
X-Original-To: stable@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A5770E4;
	Wed, 22 May 2024 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357081; cv=none; b=lDKEBSILgo082emY3sv6RQbbKjLbemC74UvRHcT4gR9vLccRQdaihZ59NpXGBglft0cpcfdHV5CIA7sbKNnhybXZd6EQDGTTYAOQucBkjB5H0PVgDZuLH4pniTrQWqCyEMf4w3IuQGJzFGlPnRRhkQC0XccL5uC0fnCubxLYfGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357081; c=relaxed/simple;
	bh=q3LKXTOAPPpEaX6Z7nsmaIyX1oJPVgoqGgt2jsBN6RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tPprLlozX0Hqd6NT9oPCJcR+Ra9Qvb9e47I+eDHNlwW1HYvONMpBGz0crgw5iMiUnyvjPAQ7MFFgzGXynfqvIK8XXBE74DkysPazUotTiC/jj86jPUsCybIc52AS+KHC7RmQlU9wTuyzHqu5bTKmJhk+T3cBLzRmb/5gQnfIXA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H8IMATtF; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44M5ov2O010614;
	Wed, 22 May 2024 00:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716357057;
	bh=4lVePLbrEsFn/8sQjPEYFQ437vE+7Qaeji2WwGrhtO8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=H8IMATtFNrYn//AC+bjpT17raD93Mwm7DRdUvMo4KWyGoYMizbKWGLUPLMD1RuiIL
	 hW42eFP43gtqLKByy8n7+OLRlx2wt1jhnw+GL2WT5ERCPP6VzztupIzBO2WXRyWenQ
	 VQPmhseSV7bFgK7vPMjfDIclsN/I4M9M1taJDP3w=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44M5ovUU028465
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 00:50:57 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 00:50:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 00:50:57 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44M5ordp031937;
	Wed, 22 May 2024 00:50:54 -0500
Message-ID: <6ca4c013-6f6f-436e-afb6-24ba45735dce@ti.com>
Date: Wed, 22 May 2024 11:20:52 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ti: icssg_prueth: Fix NULL pointer dereference
 in prueth_probe()
Content-Language: en-US
To: Romain Gantois <romain.gantois@bootlin.com>,
        Roger Quadros
	<rogerq@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20240521-icssg-prueth-fix-v1-1-b4b17b1433e9@bootlin.com>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240521-icssg-prueth-fix-v1-1-b4b17b1433e9@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 21/05/24 6:14 pm, Romain Gantois wrote:
> In the prueth_probe() function, if one of the calls to emac_phy_connect()
> fails due to of_phy_connect() returning NULL, then the subsequent call to
> phy_attached_info() will dereference a NULL pointer.
> 
> Check the return code of emac_phy_connect and fail cleanly if there is an
> error.
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>


-- 
Thanks and Regards,
Danish

