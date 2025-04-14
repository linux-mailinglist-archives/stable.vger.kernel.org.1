Return-Path: <stable+bounces-132421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F666A87C1F
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722E27A2E57
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342022641FD;
	Mon, 14 Apr 2025 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JEVW145G"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1912586CD
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744623863; cv=none; b=ZgHFIPPxF4u98HZ1t8tWN6pgcXnbGqJWNBykqkTkWXMY8b3KGjyRxmHFDQ9cKlpRKu6o0Jy3bj+4+epK+OyfD5hfW3sUQ6T6jZVLf7bqh/xLPnBKAsHHxjvpulcRLPIuMWA9GDjndEt0n4xlFFX9Ix3HGtk9OxCRgSyJ1AHZWGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744623863; c=relaxed/simple;
	bh=NXvUhNlB1aPee7uCd9a9odVHLo/yRPdk/MtLRPcDwqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcgs19gyTO+lqxaBhkZKOa2WOKchJOlrh7H3KW5c9cSwcwbt642UNOBDHFQcIntrouQgclX/xeIKbbNFK6PUYELPmv3pHi9i+hwDPSOfkWdvXsqYL2/09vZDGeIn7f3wNNKTWFn03eUso7t4oaUs5c8gvWGKxVb2xB0c4DGCpUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JEVW145G; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2c2bb447e5eso2259368fac.0
        for <stable@vger.kernel.org>; Mon, 14 Apr 2025 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744623859; x=1745228659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CbM+1WmBZ2Io1n+rSXRsp0Md07GTpvrvG0bVbAmVeMs=;
        b=JEVW145GbBL3gPGGQ9yAzATfEoWvjwN4uQ2ZnglMOQR1rFW4RRXrJwNuoAJw/YWMXC
         olPMlrvPJzGQuBe46rqJA1FD6VuA8TDuejUdwRw49YIyWcU5QfW8nN6oojahrPv49yjL
         K8itRpTFr/HyaX7Ny0777ndiSoZnPwsACTtUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744623859; x=1745228659;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbM+1WmBZ2Io1n+rSXRsp0Md07GTpvrvG0bVbAmVeMs=;
        b=DeW5UKfYRlEG1BBZFYlg9VFf2Rf4NzEzbyn3WKXDHa+X2ZBm3syW2bMifa7eqM73cb
         W5pvDkOEarHUpSOFFYlcqTAqzouIp9By9D1+jVDMgN0sQO85gKMQ1h4FBEj1dxRbLjHQ
         cj2gXSwn1j7BeT+caR08yAkxkvQay8dkMmr0hLgI1R0Sxu0tdx0JlX7DUD1sLi3x9k3n
         hEm3gh9mKoyGXZeRo8hPa5YS9cliVV4uDXbGMAk57SwchAVD4KC1mwRPHg6tu28dZg25
         S3U78YRHnxVRBfyGk7GUaTdr5A+p6LBdPC5fLZ1//FXBn3FTdfRBPfFYTpJx4esTHp4d
         D61g==
X-Forwarded-Encrypted: i=1; AJvYcCUtpZ1g4QJbgFx36vjVl07Ij/6r5/rCHr79/lGOEVw3aN7iMIkI4mrriAgLIso3utM+bhOFxkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJ4RS/nTc2uzVrTS1wQdfvjOCZ2VRaUd4B8muZDrfiEyKPavy
	i7J7rSq83jDnXiAIhUj4890fajm31llToWt6368uo0PSAeJVAW07A+BT4hwJcg==
X-Gm-Gg: ASbGncvwEujEG0EoETiggvS8yb0r3LyDjmXY2OJvWrN2e7LTJsD7ETj2BzyDG2QMSzh
	QF8xEzxjoghl2XoaOPwRvOrkIY7TgplLNphEaowDlIwRqlFxGrXzJFIe2Z2Sebmt+itL8ELyh/E
	gEkxmeO/Nh9XsvHekaWAELBM2v/e6acLoQ6hRGKOZPsRWFszAe4XK8NXLKr2BuWsI4hiNsD0bQS
	/ZyA9y1JwP6b54qpdZnShRLGBEZ2jc3QEBaz3b0ixWrP5uhbQOcNubbCczwKM5nZ7H2oKsTZaVs
	jZjwg/tpYsbO8IRzFsf1lHEquZItpkGCRy3A01ki00+HNBD22Sh+iuP2i2Dk2PH5yaU=
X-Google-Smtp-Source: AGHT+IHoa/4/GaqO5TrPYoiHTitCv7q3FYMa5EoLzYEXRejGfSZ58lhxAhVipcuemkWz6IEsfTI5Ig==
X-Received: by 2002:a05:6870:1587:b0:2cb:c780:ac52 with SMTP id 586e51a60fabf-2d0d5d9e35cmr5396992fac.23.1744623858829;
        Mon, 14 Apr 2025 02:44:18 -0700 (PDT)
Received: from [10.176.68.80] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d096cd262asm2314652fac.35.2025.04.14.02.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 02:44:17 -0700 (PDT)
Message-ID: <282afdd9-bb71-40f8-bfa9-bc7e57e1957d@broadcom.com>
Date: Mon, 14 Apr 2025 11:44:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] brcm80211: fmac: Add error handling for
 brcmf_usb_dl_writeimage()
To: Wentao Liang <vulab@iscas.ac.cn>, kvalo@kernel.org
Cc: jacobe.zang@wesion.com, sebastian.reichel@collabora.com,
 christophe.jaillet@wanadoo.fr, erick.archer@outlook.com,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250414072058.2222-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250414072058.2222-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/2025 9:20 AM, Wentao Liang wrote:
> The function brcmf_usb_dl_writeimage() calls the function
> brcmf_usb_dl_cmd() but dose not check its return value. The
> 'state.state' and the 'state.bytes' are uninitialized if the
> function brcmf_usb_dl_cmd() fails. It is dangerous to use
> uninitialized variables in the conditions.
> 
> Add error handling for brcmf_usb_dl_cmd() to jump to error
> handling path if the brcmf_usb_dl_cmd() fails and the
> 'state.state' and the 'state.bytes' are uninitialized.

Agree. Have one request though...

Just below the code you touched the USB bootloader state is checked:

	/* 2) Check we are in the Waiting state */
	if (rdlstate != DL_WAITING) {
-		brcmf_err("Failed to DL_START\n");
+		brcmf_err("Invalid DL state: %u\n", rdlstate);
		err = -EINVAL;
		goto fail;
	}

Can you improve the error message as suggested.

Regards,
Arend

> Fixes: 71bb244ba2fd ("brcm80211: fmac: add USB support for bcm43235/6/8 chipsets")
> Cc: stable@vger.kernel.org # v3.4+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

