Return-Path: <stable+bounces-196826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B350C82C57
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 00:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C921134B54E
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 23:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6682F5321;
	Mon, 24 Nov 2025 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9rY2ZdR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312ED2F60A6
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764025717; cv=none; b=etdOhoyMMCYek8CEpGE3oN/Qr7+SSZg9/oOgH5h4uAyS88YkyjnmHKipqNV4t+xwiYMLQVol0Gd+OywRVA3CW3DqCaz/3v9r60yBLQ3NVvMKICZtw1VcvksS02wMqz6YecxxaEXzIVW+c1cspDxzBgERMaE5n8FHFSohTw3B2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764025717; c=relaxed/simple;
	bh=bka4Ok+xY/vHf8rj5t8CVxoP4nJIrCSCQdt2nklsCog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QI12LTIihIIC0U/QTE6KKdQGNGmCF/6VDrUQ4qgt8AVB6009ULB55EUy4uzSozs0s6jwSmwiArg3nLLFKWpcVGc8xvhOmrlrDr/S0Hjlcdltv6JLKX3iT2OyoQIpP/dkzTACFVGbS8diQGm0lRco4rzhPK9Kx0Q4AxQH7TKabDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9rY2ZdR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so6749381a12.3
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 15:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764025713; x=1764630513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/WHGJKwl1pNV1oMFP/7W/iGcAIvgG1g+5RGn0OeZ18=;
        b=V9rY2ZdRK9hFVuwdJumT8v+zjl7956+NytNmXPFRIlcgK7CBy/eTo+WLH809rh82K2
         +OGtXfj4gSAwoKEIE4nlgGYaODYK/oA3LT1StDnYHLJ4v6WzlpbJfe0Pmh28w3XbPX8v
         b3XhApjkDct4GQX9/5MhG+WlvDji3AO/Uo0xbkkpC0hWeJKUjQkgNbD8K57OkIwi+9be
         wtJbwuyW6yr63NdGVGb7B9B0njBXyp6G5vPEpvq6P5kQ1S81nEWhWnsb8x/bGPyRlBD6
         dgd3WtJ0hbCtCavWjLOMAwd6WWXPA+ixp956R9dJpYiaXNyciif82LL7HE/8wZUKfuw+
         f6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764025713; x=1764630513;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/WHGJKwl1pNV1oMFP/7W/iGcAIvgG1g+5RGn0OeZ18=;
        b=DO3x9aLpAKlc1Zp1oHxK8oH3Lc0tHHWmNbaadk54Iw3T60vBUQQ2tRaXMmT5+wnvTu
         IJbGzc+jfZg9EVznliIgmRbHKsYwyWlLMbvGiXMjm/EccLMDD+EpQD0VH7Rf4BcL+Yy5
         J+0VPJ37+20bUBb1O0DHso310sEowGi44XthyDixERwFH52I/7/aQ4eqngZNJV6okkUs
         a/3T7KxtQ6k8HilvfJxKvgrgpuhd0ATCgJlkjbDlFzg8hsmkTammH5hRCmJ+fwAggy/4
         f6GjCQkP7NsP8ki42kbDYBsYQcg5DMN+mKyQ3fE3HpeyrGU+kyA85Vop5a2qoEHnyhm0
         yqwA==
X-Forwarded-Encrypted: i=1; AJvYcCW9+Gi6/QL12sGomeLk1sMkHVF4sAEXzZuySn6unmD5U41mYdfsvaAv/Rz89v+qiLHLzm0bNP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZk8uEmhsOWR/g3Kal00jMXQga6A6H84HVcqGmny0hbhrgPruO
	BX2vtIEdV7gJN6rZ3IAxjp8xPEgSUOHNtJiRM1+rVP0c9OcptPIWi8lc
X-Gm-Gg: ASbGncu+ot7Fp2Y6aFRBkwRnsqsta7P+91iSEnv8iCGm6Vq9Ik7CWBfwitUaSz7bWox
	znZU+FupULcWYL3ccgBTR7/T1BF/T+uUF0Kt0IzQEaA2N/gCwF2GYKdpgF7evPJIAK5mSO0PBrD
	oNNor/7Ve0dlGFkLxedNQzGhCpo3YgK1K8jEyZ2m8dS3e7Agr25JD6b3g0cmbOhYJre2Z98odLk
	FxZQ8kuk4kOgxsUIMkND/5gql143bzOumq/dG7Urx6MT6X8zVgBw7ERCoUWygqx9phnXkXNbbRb
	r7WLug2bbvOl6seRabnI0OvAk2nlzpmvT39GDYOzbFocKKbCikMuYihuvc/n/n5iiTp6zkChVpl
	FikhVdWDrhHbojkNvuPilk91fcvMVX4qmVNQv9lsUz0dKyIYnBUQabU58MsWdG58H1vfTMEfotm
	m2MaqDK92b8TsZeEyk
X-Google-Smtp-Source: AGHT+IGGQZRvEPE+V692/ByODBIStowiEq4wuN3gXmgZ+FT8xM6RPK+LS1vzrQ+0Ru/xT8SeNfVF0w==
X-Received: by 2002:a05:6402:51c7:b0:643:c8b:8d30 with SMTP id 4fb4d7f45d1cf-645546a3a94mr12871488a12.30.1764025712967;
        Mon, 24 Nov 2025 15:08:32 -0800 (PST)
Received: from localhost ([94.19.228.143])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-645363c56a4sm13295513a12.15.2025.11.24.15.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:08:32 -0800 (PST)
Date: Tue, 25 Nov 2025 02:08:31 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"piotr.oniszczuk@gmail.com" <piotr.oniszczuk@gmail.com>,
	"rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH rtw-next] wifi: rtw88: sdio: use indirect IO for device
 registers before power-on
Message-ID: <aSTlb1TEwNaFbdFf@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"piotr.oniszczuk@gmail.com" <piotr.oniszczuk@gmail.com>,
	"rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20250724004815.7043-1-pkshih@realtek.com>
 <aSHrhbt29k6GJB8e@skv.local>
 <4562797ed9514344b562f7a8e58e6988@realtek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4562797ed9514344b562f7a8e58e6988@realtek.com>

On 25-11-24 08:16, Ping-Ke Shih wrote:
> Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> > Hi,
> > 
> > This patch was recently backported to stable kernels (v6.12.58) and it broke
> > wlan on PinePhone, that uses 8723cs SDIO chip. The same problem
> > appears of course on latest 6.18-rc6. Reverting this change resolves
> > the problem.
> > 
> > ```
> > $ sudo dmesg | grep -i rtw88
> > [   24.940551] rtw88_8723cs mmc1:0001:1: WOW Firmware version 11.0.0, H2C version 0
> > [   24.953085] rtw88_8723cs mmc1:0001:1: Firmware version 11.0.0, H2C version 0
> > [   24.955892] rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
I see it fails with timeout on the first operation to read chip version.

> > [   24.973135] rtw88_8723cs mmc1:0001:1: sdio write8 failed (0x1c): -110
> > [   24.980673] rtw88_8723cs mmc1:0001:1: sdio read32 failed (0xf0): -110
> > ...
> > [   25.446691] rtw88_8723cs mmc1:0001:1: sdio read8 failed (0x100): -110
> > [   25.453569] rtw88_8723cs mmc1:0001:1: mac power on failed
> > [   25.459077] rtw88_8723cs mmc1:0001:1: failed to power on mac
> > [   25.464841] rtw88_8723cs mmc1:0001:1: failed to setup chip efuse info
> > [   25.464856] rtw88_8723cs mmc1:0001:1: failed to setup chip information
> > [   25.478341] rtw88_8723cs mmc1:0001:1: probe with driver rtw88_8723cs failed with error -114
> > ```
> > 
> 
> Check original link of this patch [1] that 8822cs read incorrect from 0xf0
> resulting in "rtw88_8822cs mmc1:0001:1: unsupported rf path (1)".
Sorry, I haven't meant, that this patch should be reverted. I see,
that it solves real problem. I've meant, that patch caused this
regression was identified and it was confirmed by reverting it.

> I wonder if we can add additional checking rule of chip ID, like:

I've tried suggested change and wlan is recognized again.

> 
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -144,8 +144,10 @@ static u32 rtw_sdio_to_io_address(struct rtw_dev *rtwdev, u32 addr,
> 
>  static bool rtw_sdio_use_direct_io(struct rtw_dev *rtwdev, u32 addr)
>  {
> +       bool might_indirect_under_power_off = rtwdev->chip->id != RTW_CHIP_TYPE_8703B;
> +
>         if (!test_bit(RTW_FLAG_POWERON, rtwdev->flags) &&
> -           !rtw_sdio_is_bus_addr(addr))
> +           !rtw_sdio_is_bus_addr(addr) && might_indirect_under_power_off)
>                 return false;
> 
>         return !rtw_sdio_is_sdio30_supported(rtwdev) ||
> 
> [1] https://lore.kernel.org/linux-wireless/699C22B4-A3E3-4206-97D0-22AB3348EBF6@gmail.com/T/#t
> 

-- 
Best regards,
Andrey Skvortsov

