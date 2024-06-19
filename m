Return-Path: <stable+bounces-53815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ADC90E884
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AE52842EA
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000112FF86;
	Wed, 19 Jun 2024 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=ipfire.org header.i=@ipfire.org header.b="DP3fNo+G";
	dkim=pass (2048-bit key) header.d=ipfire.org header.i=@ipfire.org header.b="RiQ8nDfa"
X-Original-To: stable@vger.kernel.org
Received: from mail01.ipfire.org (mail01.ipfire.org [81.3.27.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1AC75817;
	Wed, 19 Jun 2024 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.3.27.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793769; cv=none; b=Y2Ool3gYf/JhvXhCsfJYKp/KwmRkxxB4oFxWrtUAivpTLkYdzBkyru+ao9iD6NWsM++KJASG0nyDVfMuRxKxTn+bMbWpzOfLUUx6hJwf0fgOASSZOzs3xxI1QAFDfrKMQ502norRPkB3YJqTdWJ7qWis4rTrPeUrNiJI0iiYLGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793769; c=relaxed/simple;
	bh=J/65iiosTME8dNkEUjQ89Vqzbes6R/5PkYEuCzYybxQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pMugFbZ9Y/HVvCpZVqWE9zkCGKIdbbtAarUkXiTiJ03lJEqjmlihFjaLnDlIKGfH89OlP9LxdQZH+vBxQJyTpAbiXxqcFSjIrj6kZXp3XapsX/4Xl0+HLiTon+EsX7q8cHnI7fdjPcbC8lepWmmmQGpp1cPWOgJReQ1UoFzFSBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ipfire.org; spf=pass smtp.mailfrom=ipfire.org; dkim=permerror (0-bit key) header.d=ipfire.org header.i=@ipfire.org header.b=DP3fNo+G; dkim=pass (2048-bit key) header.d=ipfire.org header.i=@ipfire.org header.b=RiQ8nDfa; arc=none smtp.client-ip=81.3.27.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ipfire.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ipfire.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail01.ipfire.org (Postfix) with ESMTPSA id 4W40S23p53ztw;
	Wed, 19 Jun 2024 10:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=ipfire.org;
	s=202003ed25519; t=1718793443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXPo+OXLBLMhKj8X4+K9sJEdvulgzvjJsQxfZNJuU/Q=;
	b=DP3fNo+G7pIPM/ybAO/InsVgkLur/dcK8o6FG0a0h2sVCgOW7skc9r+S4nPj5m7EZM0MRi
	11+Xci13/XYwdwBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipfire.org; s=202003rsa;
	t=1718793443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXPo+OXLBLMhKj8X4+K9sJEdvulgzvjJsQxfZNJuU/Q=;
	b=RiQ8nDfau4axzVH2/U4n3rUJbQNFT1JEiJlFiI33V+k3k8CdoTL9B2r5S5UBIDJOde+bXz
	ghgFU/cIAFfzvHBvEIl9q8Qwcz5QnM1NEFuQmd04NfSMHqkBjc1734cWxFhAsCQjD8eCbB
	mo1m4CEK1TfDJL1MlBSgekUCet+oLFftbeNyTgJ3tznBxmhY51u5P34p+wLBq9xdREfFeO
	qZSIbviFTzO4YHNeOh9lwgb1zvfQvqigG3YrVGDGgKh/3uznp8bRiO/ZDJfUvEeeuROo+C
	0Rt6qr6wS5YpAwBqKO5HEnGfVaRu/dySRLHy4poo76FQXSmpwMVSSjGmVGFgiw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Jun 2024 12:37:15 +0200
From: Arne Fitzenreiter <arne_f@ipfire.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yongqin Liu <yongqin.liu@linaro.org>,
 =?UTF-8?Q?Antje_Miederh=C3=B6fer?= <a.miederhoefer@gmx.de>
Subject: Re: [PATCH] net: usb: ax88179_178a: improve reset check
In-Reply-To: <20240617102839.654316-1-jtornosm@redhat.com>
References: <20240617102839.654316-1-jtornosm@redhat.com>
Message-ID: <597e6e88160ea0bbc67a0728a366597f@ipfire.org>
X-Sender: arne_f@ipfire.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hello Jose Ignacio,

this patch fix my issues.

Best regards
Arne


Am 2024-06-17 12:28, schrieb Jose Ignacio Tornos Martinez:
> After ecf848eb934b ("net: usb: ax88179_178a: fix link status when link 
> is
> set to down/up") to not reset from usbnet_open after the reset from
> usbnet_probe at initialization stage to speed up this, some issues have
> been reported.
> 
> It seems to happen that if the initialization is slower, and some time
> passes between the probe operation and the open operation, the second 
> reset
> from open is necessary too to have the device working. The reason is 
> that
> if there is no activity with the phy, this is "disconnected".
> 
> In order to improve this, the solution is to detect when the phy is
> "disconnected", and we can use the phy status register for this. So we 
> will
> only reset the device from reset operation in this situation, that is, 
> only
> if necessary.
> 
> The same bahavior is happening when the device is stopped (link set to
> down) and later is restarted (link set to up), so if the phy keeps 
> working
> we only need to enable the mac again, but if enough time passes between 
> the
> device stop and restart, reset is necessary, and we can detect the
> situation checking the phy status register too.
> 
> cc: stable@vger.kernel.org # 6.6+
> Fixes: ecf848eb934b ("net: usb: ax88179_178a: fix link status when link 
> is set to down/up")
> Reported-by: Yongqin Liu <yongqin.liu@linaro.org>
> Reported-by: Antje Miederhöfer <a.miederhoefer@gmx.de>
> Reported-by: Arne Fitzenreiter <arne_f@ipfire.org>
> Tested-by: Yongqin Liu <yongqin.liu@linaro.org>
> Tested-by: Antje Miederhöfer <a.miederhoefer@gmx.de>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
>  drivers/net/usb/ax88179_178a.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c 
> b/drivers/net/usb/ax88179_178a.c
> index 51c295e1e823..c2fb736f78b2 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -174,7 +174,6 @@ struct ax88179_data {
>  	u32 wol_supported;
>  	u32 wolopts;
>  	u8 disconnecting;
> -	u8 initialized;
>  };
> 
>  struct ax88179_int_data {
> @@ -1678,12 +1677,21 @@ static int ax88179_reset(struct usbnet *dev)
> 
>  static int ax88179_net_reset(struct usbnet *dev)
>  {
> -	struct ax88179_data *ax179_data = dev->driver_priv;
> +	u16 tmp16;
> 
> -	if (ax179_data->initialized)
> +	ax88179_read_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID, GMII_PHY_PHYSR,
> +			 2, &tmp16);
> +	if (tmp16) {
> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
> +				 2, 2, &tmp16);
> +		if (!(tmp16 & AX_MEDIUM_RECEIVE_EN)) {
> +			tmp16 |= AX_MEDIUM_RECEIVE_EN;
> +			ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MODE,
> +					  2, 2, &tmp16);
> +		}
> +	} else {
>  		ax88179_reset(dev);
> -	else
> -		ax179_data->initialized = 1;
> +	}
> 
>  	return 0;
>  }

