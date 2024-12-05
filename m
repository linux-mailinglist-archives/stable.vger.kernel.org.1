Return-Path: <stable+bounces-98839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E449E5955
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 16:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5199016489E
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45A9219A6E;
	Thu,  5 Dec 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="LpUB63CH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD32BE49
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733411178; cv=none; b=D8taTEaDe3OAFraAOHtkF5fjPBtFr4hO8ym+xKzsHqadtMDJdGc+/wvlH6iTBDM8cLpBiKaroA+c37ekTlTBZfYTBycRF2IsPvlJCcfailTfmdS8+iW81Q+kPPjyiZCas+ciityMLKIwOlS0TPrwah3jB2o6On3hjTZ8eOzCZZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733411178; c=relaxed/simple;
	bh=Qzir4cDqPRP4uUW2o+bZZjYGkwQV4zqZ/0NH7WgT0Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHbfF/X2GFSHsNWimsW85SQlxPjrx4rhJPeWqkgQJy5IbVrMuJ3M3wSgQORwyI1fYnXHdeaku4H+zZg964vS0x77iKlVT91bcihxOh1RjYtXEfrTmn6yb/yjv8D2qgEbHkgHbRRsbPfmCP5DASRA+s7GP2ROYvmIFS9MmrvY1SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=LpUB63CH; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b65db9b69fso46010385a.2
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 07:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1733411176; x=1734015976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OqFlGhtdoPqBAsBXUfK8GHOXS7I6sc2ExEvs4W8qdcs=;
        b=LpUB63CHePfNhu7LMSRJoypvIjGDXxcCPCa8wejwug23BKfQhRso4hTggL9CKB9+3C
         Cp/IWj//v4RXev7DbZehoKO2U4LKdlsR+jMebhIptDcJ5NJ4pMzqn+PWVdK7JxzYbtln
         dK+kgeEYej5kdEDeFd7GRmRm3dI5/8i+wWGaxWbupewwku9nW/qwYmWHOLuGzVbw1SDu
         5UAt5/80kViLmIs5DRNhc2z6k/A9a+k7ks6gOxcqVFEqs9NOMfYeuZKG/Tyfl1q4zocP
         HTHvkDLCGOCQkLrsWDjpDJhlsQdFktYAU8a96gZbtusa68JBerXtAh6x9hxDGzl4LTGh
         TzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733411176; x=1734015976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqFlGhtdoPqBAsBXUfK8GHOXS7I6sc2ExEvs4W8qdcs=;
        b=Q2LE4ajGHdj93YmwQVMbQpGyH8JDZqCGZ43oj64bSzANW6Y3g0ZpvLpc75IICkUYYN
         wdTsy+S7722AW40dI3vUhvqkdfMEefjJMGKfXtFRY4pFteS35I7AiB30vIzMsk6jRS/A
         +H339AEMFvsUEu4lo2WD6XXapoHm/uM/HacMCDNGXSpajKX9whkmNZF36MqX0WOaUNGq
         zhN+3IM53+PpGucGY9KkKKN8AbPLNmlieIIbI0e+AH0XGWcBjq5FOOz1iBYu8KUdVbCm
         7yFfQpecxIV8tPX8wtTJnKpxc7/DPeMlhdp+WS6drN1wpAwBUZKWBoPAQol1DpUDK6IX
         JzhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE+Npk/ingIwjvP0Dgex2zbyBE6rzEvRkuXXgPczCedD4TFwkhpHebC2oklU86NafWcGafe7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGa/7OMMBV1QaAUvC+faAF1mJ23eVg65qjKHF3MtQuxrDnRssr
	JjvJeUF5Q68CeOV1ceoQjI/rXkESjlj1EHDWDiMAKv8X+PhnF/3kZCAU68QQeA==
X-Gm-Gg: ASbGnctF53f6k0OdfQ0Z6xiaN0hP6ZGYnuWo5ZyMVFrXLFNlmh1WPleNGnYFTJwoLME
	qyD4v9aPSFaQ5vVtgRvGg4Wk5BM0+PmGDge5feENmIBAF6IpqyFlpd3e+KzyaeYdM9PESWb7OLd
	oWSDcvOiyjwU7qdObZJVDz8Dh/VI7lkrxTUWp8zkfeng1sm9cqgP/8VJ7kj4dOqkcce88j1b51L
	Gsy5ZTyMqjWW7aV5gFpGh7MihWwQF6gA42iDqJoRge8s47YFhU=
X-Google-Smtp-Source: AGHT+IELmQdNT+1hsoXFGPSm28f9agdhcrSIwOgp6I2ewJudqY4XKJvMxXYV2ThqzvhMJRi9RwHfOQ==
X-Received: by 2002:ad4:5d43:0:b0:6d8:7fe2:8b1e with SMTP id 6a1803df08f44-6d8b7455674mr157979416d6.48.1733411175790;
        Thu, 05 Dec 2024 07:06:15 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::d4d1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a9e7d6sm67378685a.119.2024.12.05.07.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:06:15 -0800 (PST)
Date: Thu, 5 Dec 2024 10:06:11 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wayne Chang <waynec@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] USB: core: Disable LPM only for non-suspended ports
Message-ID: <a9f767eb-2196-4273-ba1a-19b07ccdafd8@rowland.harvard.edu>
References: <20241205091215.41348-1-kaihengf@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205091215.41348-1-kaihengf@nvidia.com>

On Thu, Dec 05, 2024 at 05:12:15PM +0800, Kai-Heng Feng wrote:
> There's USB error when tegra board is shutting down:
> [  180.919315] usb 2-3: Failed to set U1 timeout to 0x0,error code -113
> [  180.919995] usb 2-3: Failed to set U1 timeout to 0xa,error code -113
> [  180.920512] usb 2-3: Failed to set U2 timeout to 0x4,error code -113
> [  186.157172] tegra-xusb 3610000.usb: xHCI host controller not responding, assume dead
> [  186.157858] tegra-xusb 3610000.usb: HC died; cleaning up
> [  186.317280] tegra-xusb 3610000.usb: Timeout while waiting for evaluate context command
> 
> The issue is caused by disabling LPM on already suspended ports.
> 
> For USB2 LPM, the LPM is already disabled during port suspend. For USB3
> LPM, port won't transit to U1/U2 when it's already suspended in U3,
> hence disabling LPM is only needed for ports that are not suspended.
> 
> Cc: Wayne Chang <waynec@nvidia.com>
> Cc: stable@vger.kernel.org
> Fixes: d920a2ed8620 ("usb: Disable USB3 LPM at shutdown")
> Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
> ---
> v2:
>  Add "Cc: stable@vger.kernel.org"
> 
>  drivers/usb/core/port.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
> index e7da2fca11a4..d50b9e004e76 100644
> --- a/drivers/usb/core/port.c
> +++ b/drivers/usb/core/port.c
> @@ -452,10 +452,11 @@ static int usb_port_runtime_suspend(struct device *dev)
>  static void usb_port_shutdown(struct device *dev)
>  {
>  	struct usb_port *port_dev = to_usb_port(dev);
> +	struct usb_device *udev = port_dev->child;
>  
> -	if (port_dev->child) {
> -		usb_disable_usb2_hardware_lpm(port_dev->child);
> -		usb_unlocked_disable_lpm(port_dev->child);
> +	if (udev && !pm_runtime_suspended(&udev->dev)) {

Instead of testing !pm_runtime_suspended(&udev->dev), it would be better 
to test udev->port_is_suspended.  This field records the actual status 
of the device's upstream port, whereas in some circumstances 
pm_runtime_suspended() will return true when the port is in U0.

Alan Stern

> +		usb_disable_usb2_hardware_lpm(udev);
> +		usb_unlocked_disable_lpm(udev);
>  	}
>  }
>  
> -- 
> 2.47.0

