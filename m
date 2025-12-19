Return-Path: <stable+bounces-203040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBC5CCE0B3
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 01:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28AEF3027FF9
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 00:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAFE1E1DF0;
	Fri, 19 Dec 2025 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="t7dApnxT";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="t7dApnxT"
X-Original-To: stable@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE319D8A8;
	Fri, 19 Dec 2025 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103579; cv=none; b=KXXV1PYyiND/DzQlMnuQDHn5cmYVT9fPfUvVYvoUXQzZAcRF16I4C5z9ete/toaq1i5k0HMqdAca+EHpr8MJ33+0A9hTqAgXKPjA/IUjIgy1z6PDB0bC+eRgkHz3HEui+c4A6yX9iRelDOiZwg8IlG+Av18GNbjtnvS40tI6fc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103579; c=relaxed/simple;
	bh=XAQ7svx4hTOcVQcGURJInUD5vKOC9mDvwPKsZ5HIq6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPZMNQXzoCVnQOLv6a8qTYvYGtMD6kxjtgGDTphdLx+C7K6c/dQXa+NZV82+Y/HQLzorA3F3/FoJ9m3LPl7UZ8Bvnbbxw3XogeemClUa8Lmz0bxaa4B+JW4RCqPSD3+sITzgKrBZidv4KV2RRPm637xyiCSvBplMtNUdM9VlL00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=t7dApnxT; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=t7dApnxT; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766103576; bh=XAQ7svx4hTOcVQcGURJInUD5vKOC9mDvwPKsZ5HIq6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t7dApnxTg7NLt/BPiochUyUOYa3dnnbw/smZGcA5nZtZYosYLzmWB/HZbf7G9tSgW
	 DUc6YL5SrXHVgAjNWIGtUslrgXt2Tj2G5X227W6yCc9pWaC18SiROqd1Q7rxZNZYyB
	 U0MglFJVwR/iDyBCIwpkTvU+iiqTnrDGit7a0Hqx7vSvSfbynDUquNBHGsfPROYtle
	 M1varuhyeES70YeCgA0jA4JXY6O+I3JQIR6pLh/uWjgUj52/46FQhLJ7qPp6OpzQ5p
	 uEd75lQgbJQLyKvvBxf5uauhp1P2yx/1T7dTkoHHTOZxpx0hGqJVVW9UzwT/H0Skh1
	 7BKyCNyyymXrg==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 5070D3E7A9A;
	Fri, 19 Dec 2025 00:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766103576; bh=XAQ7svx4hTOcVQcGURJInUD5vKOC9mDvwPKsZ5HIq6I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t7dApnxTg7NLt/BPiochUyUOYa3dnnbw/smZGcA5nZtZYosYLzmWB/HZbf7G9tSgW
	 DUc6YL5SrXHVgAjNWIGtUslrgXt2Tj2G5X227W6yCc9pWaC18SiROqd1Q7rxZNZYyB
	 U0MglFJVwR/iDyBCIwpkTvU+iiqTnrDGit7a0Hqx7vSvSfbynDUquNBHGsfPROYtle
	 M1varuhyeES70YeCgA0jA4JXY6O+I3JQIR6pLh/uWjgUj52/46FQhLJ7qPp6OpzQ5p
	 uEd75lQgbJQLyKvvBxf5uauhp1P2yx/1T7dTkoHHTOZxpx0hGqJVVW9UzwT/H0Skh1
	 7BKyCNyyymXrg==
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id B24453E769B;
	Fri, 19 Dec 2025 00:19:35 +0000 (UTC)
Message-ID: <dd966564-9a45-44c0-b082-aac5db3460fd@mleia.com>
Date: Fri, 19 Dec 2025 02:19:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] usb: ohci-nxp: fix device leak on probe failure
To: Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Alan Stern <stern@rowland.harvard.edu>, Ma Ke <make24@iscas.ac.cn>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251218153519.19453-1-johan@kernel.org>
 <20251218153519.19453-4-johan@kernel.org>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20251218153519.19453-4-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251219_001936_346105_B7A6B419 
X-CRM114-Status: GOOD (  14.21  )

On 12/18/25 17:35, Johan Hovold wrote:
> Make sure to drop the reference taken when looking up the PHY I2C device
> during probe on probe failure (e.g. probe deferral) and on driver
> unbind.
> 
> Fixes: 73108aa90cbf ("USB: ohci-nxp: Use isp1301 driver")
> Cc: stable@vger.kernel.org	# 3.5
> Reported-by: Ma Ke <make24@iscas.ac.cn>
> Link: https://lore.kernel.org/lkml/20251117013428.21840-1-make24@iscas.ac.cn/
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/usb/host/ohci-nxp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/ohci-nxp.c b/drivers/usb/host/ohci-nxp.c
> index 24d5a1dc5056..509ca7d8d513 100644
> --- a/drivers/usb/host/ohci-nxp.c
> +++ b/drivers/usb/host/ohci-nxp.c
> @@ -223,6 +223,7 @@ static int ohci_hcd_nxp_probe(struct platform_device *pdev)
>   fail_resource:
>   	usb_put_hcd(hcd);
>   fail_disable:
> +	put_device(&isp1301_i2c_client->dev);
>   	isp1301_i2c_client = NULL;
>   	return ret;
>   }
> @@ -234,6 +235,7 @@ static void ohci_hcd_nxp_remove(struct platform_device *pdev)
>   	usb_remove_hcd(hcd);
>   	ohci_nxp_stop_hc();
>   	usb_put_hcd(hcd);
> +	put_device(&isp1301_i2c_client->dev);
>   	isp1301_i2c_client = NULL;
>   }
>   

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

-- 
Best wishes,
Vladimir

