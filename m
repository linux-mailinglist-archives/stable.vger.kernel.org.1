Return-Path: <stable+bounces-69419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD4F955EEA
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 22:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065971F2130B
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 20:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0021B14EC44;
	Sun, 18 Aug 2024 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="a46S0UYp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F831547F2
	for <stable@vger.kernel.org>; Sun, 18 Aug 2024 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724013006; cv=none; b=U6qi00bSdVA+9q/Ikip+uDUssPppRKhARu5wAJC6Bb3cak1zWi8AUlmP0if0dkVYcMuB8r66bnmJz+VFuvBXA5MrABk/9PQct2CR3WjBT9VCf3W7IRKwI80RZsTfNcBaBwC4SlQRLgYh1iZqg8AUWwnMqtwktUWPkYS9+6AxfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724013006; c=relaxed/simple;
	bh=kIUPODz3cbQ5gt+8r9evwbR04C/aEv/J2gHXEvX3crA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=LTyn+H2G4ckX9j+oMZ4LxMzQxleDIG5dJ4xaijEfEZLQsmtNX+VcSIOFr5cUdih5ZlJFF1ZFQEgZsm4wz86zuNIjJ31X6hPIUk8XZIYnKXeJFi7ndHXvgBbzTysypWYnydnZGXzKjKFW97w6OpZVhjbwlWzaeUifA7eWIDr6OC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=a46S0UYp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso30527825e9.0
        for <stable@vger.kernel.org>; Sun, 18 Aug 2024 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1724013003; x=1724617803; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKuSjcunVmOP4VZx33TMXhdaxHVXIr/vpkFcjKrBzpY=;
        b=a46S0UYpmonx/q9TaFzkBHbQXj1ecnM8WhiAhDs72Dv3Oy87Iz36/rFHqjpnZ3OKTQ
         H14R6091zId0K0JLYDcXTvuHZ+Q62sdJAG0s1dGEcy17AQ2rUOxG+b1F1idWH+PcTJNq
         ySk8O3+C7kewo+IXaJm/I7sO8JHH6fCRhYiPgQNYOIXsKPlqAz6Rk6AlcBHeQD5ZjUmb
         xtNfuqU2USDkws4npkahh0R/Eq8y8YS+3nx9Tq7h17gqCli9Frzvvl6efmWsmm7Srmk2
         ctCa/lpe3lh2SDZGAUlebZx0LbLONYle6zwMMdLAM5K6HR/oyIgjQQUVaPNtAVzTC6rd
         wYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724013003; x=1724617803;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BKuSjcunVmOP4VZx33TMXhdaxHVXIr/vpkFcjKrBzpY=;
        b=fBYhwenMOC93DMSmnU2z8aKt0N3XYxYr9q60r8ePb6HM6iMgo4T5c2llmfq/LS4Dk4
         APFrqf70wENxCCmg50sV4huNzUIfcQN7/Nui0WwFkqRxYyiBt3h/FDM8sX3e9X7RIelZ
         cO8wRL6xqKUttWYv9CtNLeaU3wCl5Lu/muiQ2NXfpq8JQf9p842N7liJK/wNpAaFAoug
         v1wCZxEQ5ree+H6a4GBqg4aZh0+Hhar8GDoXEEyZopCZBi4pWinxsp5LfnMAeNKKo4dE
         ogvdCtVz+71xJBAXqCWGh7N0s4E6+iiTKhzReE/apSSzLR+Q4QE5HBN/h7hqBLpgSIVy
         lEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2IToAYGUTaZ23j2OILiixuTu5MIT8oXX4f+V/GMiHVxaLsx8tgwR8D4DkH8OxLzn31RT+R5zJVPVMZQxsD5r0ZrTe3jRn
X-Gm-Message-State: AOJu0Ywar/bBv2tLSNfCHeYC9ZSFjVD+g/pSazHZcrMhSGrBQVimW6Ln
	hyw0HMeQzqi3l3LAFVrEh4aUGyFCAo7PDdV4IZspBs1XSxOi617/BpH2lmPs6kE=
X-Google-Smtp-Source: AGHT+IGdjsfegB8yke+aoiRcnbr1T/5MJGCjCQl1jxLBjE8tUqmY1ED2da6ecMdVTHRwtGSIHNZ+CA==
X-Received: by 2002:a05:600c:1e15:b0:426:5b21:9801 with SMTP id 5b1f17b1804b1-42aa826510fmr31755565e9.27.1724013003127;
        Sun, 18 Aug 2024 13:30:03 -0700 (PDT)
Received: from localhost (ip-185-104-138-79.ptr.icomera.net. [185.104.138.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded72524sm142052615e9.34.2024.08.18.13.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 13:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Aug 2024 22:30:00 +0200
Message-Id: <D3JBLQVFQ7KB.6CGONK66O4XE@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Heikki Krogerus"
 <heikki.krogerus@linux.intel.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>, "Caleb Connolly"
 <caleb.connolly@linaro.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: typec: fsa4480: Relax CHIP_ID check
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240818-fsa4480-chipid-fix-v1-1-17c239435cf7@fairphone.com>
In-Reply-To: <20240818-fsa4480-chipid-fix-v1-1-17c239435cf7@fairphone.com>

On Sun Aug 18, 2024 at 10:21 PM CEST, Luca Weiss wrote:
> Some FSA4480-compatible chips like the OCP96011 used on Fairphone 5
> return 0x00 from the CHIP_ID register. Handle that gracefully and only
> fail probe when the I2C read has failed.
>
> With this the dev_dbg will print 0 but otherwise continue working.
>
>   [    0.251581] fsa4480 1-0042: Found FSA4480 v0.0 (Vendor ID =3D 0)

Short appendix: just checked the OCP96011 datasheet and it does mention
register 00H being "Device ID" and "Reset Value" being 0x00 so that's
expected behavior on this specific chip.

Regards
Luca

>
> Cc: stable@vger.kernel.org
> Fixes: e885f5f1f2b4 ("usb: typec: fsa4480: Check if the chip is really th=
ere")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/usb/typec/mux/fsa4480.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4=
480.c
> index cd235339834b..f71dba8bf07c 100644
> --- a/drivers/usb/typec/mux/fsa4480.c
> +++ b/drivers/usb/typec/mux/fsa4480.c
> @@ -274,7 +274,7 @@ static int fsa4480_probe(struct i2c_client *client)
>  		return dev_err_probe(dev, PTR_ERR(fsa->regmap), "failed to initialize =
regmap\n");
> =20
>  	ret =3D regmap_read(fsa->regmap, FSA4480_DEVICE_ID, &val);
> -	if (ret || !val)
> +	if (ret)
>  		return dev_err_probe(dev, -ENODEV, "FSA4480 not found\n");
> =20
>  	dev_dbg(dev, "Found FSA4480 v%lu.%lu (Vendor ID =3D %lu)\n",
>
> ---
> base-commit: ccdbf91fdf5a71881ef32b41797382c4edd6f670
> change-id: 20240818-fsa4480-chipid-fix-2c7cf5810135
>
> Best regards,


