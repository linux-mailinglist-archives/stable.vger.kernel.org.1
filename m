Return-Path: <stable+bounces-76603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A4497B434
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 20:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9564F1C221A9
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 18:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0271898E5;
	Tue, 17 Sep 2024 18:56:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00215ECD7;
	Tue, 17 Sep 2024 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726599360; cv=none; b=FFtv15JThAdtAcGo/DjC1t3Dhlkj+Y34zqrH/+Yu/ENIIgsgTwFeKANzacsVVc861WsQ2Aq6CwCa2StQZ5yd8/J5gclL/hczHPnRwDYJF23c/zPDcaEry30m9KtCkaswlF9uGDpoWd0kQ/Ue20Ulr14moBmvlg3JWg2Vxm7sYY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726599360; c=relaxed/simple;
	bh=6D8fJosTTxd2L3lfaDtxSU9L6o0MY6+KjLaJSKRE57g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YEAZhhpNO2njf3zMzfitbwk9rTqG5OO/DX2b7puFNKd/47Ko1ARcxr+jmMsGGXmw3lx307HQ5TaAx4Ma6ah7JdfijWWMofv4DQGXj/Ds9IE81wjMQNCpAkI9ps8L+X+f1JxWRwNbI5y9yoeneuKc6org5D0r0Hu+1fHi1RNuMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.108] (178.176.74.43) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 17 Sep
 2024 21:55:36 +0300
Message-ID: <96bcc902-630f-83c2-0e4b-27ed552fbe09@omp.ru>
Date: Tue, 17 Sep 2024 21:55:23 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [lvc-patches] [PATCH 6.1] platform/x86: android-platform: deref
 after free in x86_android_tablet_init() fix
Content-Language: en-US
To: Aleksandr Burakov <a.burakov@rosalinux.ru>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <stable@vger.kernel.org>, Hans de Goede
	<hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>
CC: <lvc-project@linuxtesting.org>, <lvc-patches@linuxtesting.org>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240917120458.7300-1-a.burakov@rosalinux.ru>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20240917120458.7300-1-a.burakov@rosalinux.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/17/2024 18:42:41
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187805 [Sep 17 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_cat_drugs}
X-KSE-AntiSpam-Info: {Tracking_bl_eng_cat, c6}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.43 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.43
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/17/2024 18:45:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/17/2024 4:41:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/17/24 15:04, Aleksandr Burakov wrote:

> No upstream commit exists for this commit.
> 
> Pointer '&pdevs[i]' is dereferenced at x86_android_tablet_init()

   s/at/in.

> after the referenced memory was deallocated by calling function
> 'x86_android_tablet_cleanup()'.

   No quotes around a function name the 1st time, and here they are
the 2nd time. Please be consistent...

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 5eba0141206e ("platform/x86: x86-android-tablets: Add support for instantiating platform-devs")
> Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
> ---
>  drivers/platform/x86/x86-android-tablets.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platform/x86/x86-android-tablets.c
> index 9178076d9d7d..9838c5332201 100644
> --- a/drivers/platform/x86/x86-android-tablets.c
> +++ b/drivers/platform/x86/x86-android-tablets.c
> @@ -1853,8 +1853,9 @@ static __init int x86_android_tablet_init(void)
>  	for (i = 0; i < pdev_count; i++) {
>  		pdevs[i] = platform_device_register_full(&dev_info->pdev_info[i]);
>  		if (IS_ERR(pdevs[i])) {
> +			int ret = PTR_ERR(pdevs[i]);

   Need an empty line after the declartion, BTW...

>  			x86_android_tablet_cleanup();
> -			return PTR_ERR(pdevs[i]);
> +			return ret;
>  		}
>  	}

MBR, Sergey

