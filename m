Return-Path: <stable+bounces-69776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF954959412
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 07:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6952E1F22F69
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 05:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10922167DB7;
	Wed, 21 Aug 2024 05:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zFSfCOEY"
X-Original-To: stable@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBC51547CB;
	Wed, 21 Aug 2024 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724218243; cv=none; b=O/jYbaHDkQCJNZobhuwklqy1lTBoLQtibxLyzssi6C9dZx7hfTzqcCFZoYzXL0/rBGiiab75CHdSYZt8wW3PvNI0ozAaUDj7JZkD84l1XGTlvz/9tqE+T6pMePllpIH5CFHiobcZZYSLvmhG1hnVxV/y8Hz6BpdafzhG2pG939A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724218243; c=relaxed/simple;
	bh=US6uukCr23cJcb5Qk05xvJuPGTtMv0kcae9DXge8M+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uYCj/QZQLMUZl+l6sl0K6TQFJTMC0CjqJhrvPYFeLeaKHsX0O46NthaPbt8Oe8Gb7P5lwGGfYOEVzyYZUXKaJKNOjPReQ2Kz7TErrT01HYbckyHn5thSIO2fHhTqqUXSWo2ZoDUCSD0sa77dRmH3h9mNwNfj8+nOe07rTaNeua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zFSfCOEY; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47L5UXGZ082374;
	Wed, 21 Aug 2024 00:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724218233;
	bh=AhzCsHq+PmvPFNsYNTZwHR5yfApUNLRO+eJzp8TqvhY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=zFSfCOEYumAEGNL7iVsJsj376FfpgNNed6sN/9GWTP5y/yjmJ9BOMwI+cToHRiMpz
	 A99gtnkSbnVTsiwn/hZy0ZNLihpQ3raiPqRqUFqM+cWX1ZqkoG+ZfUAYxbQBEd5AaG
	 C1Hg1EuENNyyM7WBymy4uSXclu3dS3lEUIEfGC/g=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47L5UWfV004758
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 00:30:33 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 00:30:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 00:30:32 -0500
Received: from [172.24.216.148] (ltpw0bk3z4.dhcp.ti.com [172.24.216.148])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47L5UQSV044371;
	Wed, 21 Aug 2024 00:30:28 -0500
Message-ID: <cf1783e3-e378-482d-8cc2-e03dedca1271@ti.com>
Date: Wed, 21 Aug 2024 11:00:26 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: k3-r5: Fix error handling when power-up
 failed
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-remoteproc@vger.kernel.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Apurva Nandan
	<a-nandan@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
References: <9f481156-f220-4adf-b3d9-670871351e26@siemens.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <9f481156-f220-4adf-b3d9-670871351e26@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 19-08-2024 20:54, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> By simply bailing out, the driver was violating its rule and internal


Using device lifecycle managed functions to register the rproc 
(devm_rproc_add()), bailing out with an error code will work.

> assumptions that either both or no rproc should be initialized. E.g.,
> this could cause the first core to be available but not the second one,
> leading to crashes on its shutdown later on while trying to dereference
> that second instance.
>
> Fixes: 61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up before powering up core1")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   drivers/remoteproc/ti_k3_r5_remoteproc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 39a47540c590..eb09d2e9b32a 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -1332,7 +1332,7 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>   			dev_err(dev,
>   				"Timed out waiting for %s core to power up!\n",
>   				rproc->name);
> -			return ret;
> +			goto err_powerup;
>   		}
>   	}
>   
> @@ -1348,6 +1348,7 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
>   		}
>   	}
>   
> +err_powerup:
>   	rproc_del(rproc);


Please use devm_rproc_add() to avoid having to do rproc_del() manually 
here.

>   err_add:
>   	k3_r5_reserved_mem_exit(kproc);

