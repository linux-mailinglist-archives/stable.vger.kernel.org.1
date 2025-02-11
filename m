Return-Path: <stable+bounces-114936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5A8A310A3
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 17:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9C7188C0AB
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F95A253B5A;
	Tue, 11 Feb 2025 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="Drzx0dHm"
X-Original-To: stable@vger.kernel.org
Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DFD1EC006;
	Tue, 11 Feb 2025 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739289865; cv=pass; b=IiqDhs8Ddtsk2K2m0baNpghD5KOpxx/KjvkYF9QITmW2BEqpeN25MXrfzjSar6FR86tPslskLW8DfYkihMnK4z4pSqy/Z7t0pYVvvvfXV4LXGrTLi/AYCAcIWYplLXogQY1Ph/aLP4ftNK7us1poNPNJ+XiPIHuY063hiqEuZ80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739289865; c=relaxed/simple;
	bh=45NgEGR9xVWRGZYDQUczRCjAkPb1nJoRAiQu3v41Pgs=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=KfQxPWyJQmLBrc9meg6iGq9W0pfSHEgfxBaKY+WKbGb3Co1zmVV72BvDG+ZpQGgBCfGAYuaDdqMPbIz5qW5zxkI1D0DbFmoMyReayiTG7rGdvoR3/GEfyNuar1f1le3htOATxEjcT5gvaKHSRQ1YPXvHWIOO4UUFQCCx9APprwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=Drzx0dHm; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 7446E2C22D3;
	Tue, 11 Feb 2025 15:58:42 +0000 (UTC)
Received: from uk-fast-smtpout1.hostinger.io (trex-2.trex.outbound.svc.cluster.local [100.97.28.83])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 40A062C3EAC;
	Tue, 11 Feb 2025 15:58:41 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1739289522; a=rsa-sha256;
	cv=none;
	b=iEsWLmfuOVyQY8gZ86qjVDUWVsoWQXaCYToGCxV6SQc8bc2eW1xE2XyHXyqELTGmTiv1t6
	RgSYuTWuX1aqFoCxEf7zucErUNTEwZj9Tss6z2HgXvdLcNC+iop6OASkZ8LImPJgjtk8Q6
	b2Y64+BeMp7L9Ftc1dmvriNp0KHA1aRlK7mg8vQAs3foY41Uovj5xCj/q6Sv0P76pdASkn
	FpLR34iEyQJVFz99w2xeAMNdq3BH5ZMYipkifa4F6cDefrN2J1wBuyBrwVBWRX+bK2Oi0Y
	4js3UnaIS9CCcjqJTwlqu2WGPBe8HPYwj73OseClTgjnMa+QItDdy5YTv2DD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1739289522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dmNS9CAOB7kYkRhMFY6pna4SlgHCcaggJmkRXUL8i1o=;
	b=E2EO8/P4q5Ue8hjMtxmqK/b5jyhJzoKpJoYoobL4QyqE3g3qIb8NDxQop+z4TPlXGV4TUx
	czFLVLu1hoqcSRAS+BKXZxRGU8srFah7EEfmicrObklSm8P4BvcJ7sSPpd9PbRWG35MUbi
	pmfRXpm35CAa/luJa6Ci196MNkfnYc1IA7c/sRpBYIxAzSbnqneqA3fWtjuyiVgntMwxiV
	TEN7i8LhK7/UZAWcs1REkKPz6ucZ42tWlrHLaTxIWjyfl9J1fOG0DycgRsr0QYyHpBC4O0
	LTugkMKlXqOIzs4aPJwX6eY7g54xoXXrZrR4XtKGyLgxhpBOOULc+5xaTVMsnQ==
ARC-Authentication-Results: i=1;
	rspamd-68c88d6cff-gjpcx;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=chester.a.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Hook-Unite: 76d5b96a6e666518_1739289522197_3869686461
X-MC-Loop-Signature: 1739289522197:3951695925
X-MC-Ingress-Time: 1739289522197
Received: from uk-fast-smtpout1.hostinger.io (uk-fast-smtpout1.hostinger.io
 [31.220.23.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.28.83 (trex/7.0.2);
	Tue, 11 Feb 2025 15:58:42 +0000
Message-ID: <4a7f0b18-af29-4a49-863c-5a079d11c11c@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1739289519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmNS9CAOB7kYkRhMFY6pna4SlgHCcaggJmkRXUL8i1o=;
	b=Drzx0dHmMiSw1d/wwpkx62bKcUGlVPc0vctiF8Hkyjx/+DWtE5Ba7UcUe1TXCLJIP2ZJ/4
	4txruVyxSvwLlrVoTFiK8m0QnP45QIAiDRM0Ezbgwaugw/pzsn5Tf31nX+07lVSOz4PjEB
	OJV+qH8EiQbRo3B9pMhEy+P0q0Q52YK1yVhtZqdnKWFfJVNVJV+IefEqZ7HhRgfxgrguAD
	CZAiNkN7+UXXnA/xpEeSG31nkWWCfjYHKU0uvkge4YKW8ULzpOpUOAsMiAbvZykF6OS2Kd
	gBywdEcr7ttVL/kauGYs+rr9CVv8hDHoYFH1bbDqkKYtrU8jWvd4qLGa7NDFTQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: option: drop MeiG Smart defines
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250211145547.32517-1-johan@kernel.org>
Content-Language: en-US
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
In-Reply-To: <20250211145547.32517-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Feb 2025 15:58:37 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=FuFX/Hrq c=1 sm=1 tr=0 ts=67ab73af a=xK2r8zoKF9vSrBIo2YuqYg==:117 a=xK2r8zoKF9vSrBIo2YuqYg==:17 a=IkcTkHD0fZMA:10 a=GvHEsTVZAAAA:8 a=VwQbUJbxAAAA:8 a=wvxYl3FCeEmcF220GPsA:9 a=QEXdDO2ut3YA:10 a=aajZ2D0djhd3YR65f-bR:22
X-CM-Envelope: MS4xfOcm6ZRhG5bD1p2vu4vvBI9ghtHy1aUXBhRItoYE0FVCkfgPwrDyVwTqaFMvmHwlOBYc+DvBsaNPQ16/Vaeg1ZUzNTCWOq4tekq8LtecCRRkrv+O4Q/x 1PZZU8jV/Wx3HbMthR7PtRQp4BM4Zgji3ztOcjVCNjOeBJhYU72LHylV+0QoPK3e7wa7hoBvsXq3WuJ/LCJohUegbzsleqRHMqUoS4oKU4WhnSKSJMNUC9Vd tb5Mv6QIO6Pee/bimwWLn9k6cJZpJL9dXr/INy2QfvkYUlBmZLc11cSVqWbIwDjpcQn0wk9KG0krCt3CPTlypA==
X-AuthUser: chester.a.unal@arinc9.com

Looks good to me. Thanks Johan.

Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>

Chester A.

On 11/02/2025 14:55, Johan Hovold wrote:
> Several MeiG Smart modems apparently use the same product id, making the
> defines even less useful.
> 
> Drop them in favour of using comments consistently to make the id table
> slightly less unwieldy.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>   drivers/usb/serial/option.c | 28 ++++++++--------------------
>   1 file changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 887a1c687b52..ba8c0a4047de 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -619,18 +619,6 @@ static void option_instat_callback(struct urb *urb);
>   /* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
>   #define LUAT_PRODUCT_AIR720U			0x4e00
>   
> -/* MeiG Smart Technology products */
> -#define MEIGSMART_VENDOR_ID			0x2dee
> -/*
> - * MeiG Smart SLM828, SRM815, and SRM825L use the same product ID. SLM828 is
> - * based on Qualcomm SDX12. SRM815 and SRM825L are based on Qualcomm 315.
> - */
> -#define MEIGSMART_PRODUCT_SRM825L		0x4d22
> -/* MeiG Smart SLM320 based on UNISOC UIS8910 */
> -#define MEIGSMART_PRODUCT_SLM320		0x4d41
> -/* MeiG Smart SLM770A based on ASR1803 */
> -#define MEIGSMART_PRODUCT_SLM770A		0x4d57
> -
>   /* Device flags */
>   
>   /* Highest interface number which can be used with NCTRL() and RSVD() */
> @@ -2350,6 +2338,14 @@ static const struct usb_device_id option_ids[] = {
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a05, 0xff) },			/* Fibocom FM650-CN (NCM mode) */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a06, 0xff) },			/* Fibocom FM650-CN (RNDIS mode) */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0a07, 0xff) },			/* Fibocom FM650-CN (MBIM mode) */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d41, 0xff, 0, 0) },		/* MeiG Smart SLM320 */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d57, 0xff, 0, 0) },		/* MeiG Smart SLM770A */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0, 0) },		/* MeiG Smart SRM815 */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0x10, 0x02) },	/* MeiG Smart SLM828 */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0x10, 0x03) },	/* MeiG Smart SLM828 */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0xff, 0x30) },	/* MeiG Smart SRM815 and SRM825L */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0xff, 0x40) },	/* MeiG Smart SRM825L */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d22, 0xff, 0xff, 0x60) },	/* MeiG Smart SRM825L */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
> @@ -2406,14 +2402,6 @@ static const struct usb_device_id option_ids[] = {
>   	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
>   	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
>   	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
> -	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM320, 0xff, 0, 0) },
> -	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SLM770A, 0xff, 0, 0) },
> -	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0, 0) },	/* MeiG Smart SRM815 */
> -	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0x10, 0x02) },	/* MeiG Smart SLM828 */
> -	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0x10, 0x03) },	/* MeiG Smart SLM828 */
> -	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x30) },	/* MeiG Smart SRM815 and SRM825L */
> -	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x40) },	/* MeiG Smart SRM825L */
> -	{ USB_DEVICE_AND_INTERFACE_INFO(MEIGSMART_VENDOR_ID, MEIGSMART_PRODUCT_SRM825L, 0xff, 0xff, 0x60) },	/* MeiG Smart SRM825L */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0530, 0xff),			/* TCL IK512 MBIM */
>   	  .driver_info = NCTRL(1) },
>   	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0640, 0xff),			/* TCL IK512 ECM */


