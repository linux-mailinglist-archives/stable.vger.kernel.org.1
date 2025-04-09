Return-Path: <stable+bounces-131940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB68A8246C
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 14:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5557C8C3C06
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D1F25E471;
	Wed,  9 Apr 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YMtC1S08"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D771D54E9
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744200673; cv=none; b=CEoqEl2HDyGCMfzjOqvcuiXBypaUviP0J95Y8iioa63A8HMJbkKPuGFS0n8J0jci3+jwVAoxc6vV6HUXfE4GNLG3e8A4srU6TKYP77nxqzCKFDZJIaIBfbMJz+Va4Q7ITa8rchjPtlZprs4/5JCNtM9mGjTXyclVZN1pqO1d4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744200673; c=relaxed/simple;
	bh=FjmBBQuTbqcSqV4VON5V19OosV8aeGF3vbwcOaR6PEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gu2xBHFaFxAn3iSLeqhAnREQ6CT73Wt34CrjEkvsbpYfGZ196+yv6d8GeWroXu69g2qn1c2D0dMSYBrNVxG5mJG0IatbHE1HbANQXOQHpLhsrTMcImcn++0kw10NHU/jOByrgfnYW1W4sa7In4Pcq4aGJRxgAIOcC9u700jPg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YMtC1S08; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72c14235af3so3956671a34.3
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 05:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744200669; x=1744805469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4PtXMGs7EWmz8YpnhCnXD5krrhFi7/XXZNLQxormo78=;
        b=YMtC1S08yIe2L84xw6e7Yo8bzoUSmvFP+dAZk/fDbwYmIdoLMX/fjcRTk+yK/d+x+c
         NruSO6zYjblaKvuaIHrnMVgrkNpq+Bd/3e8VS6mVuZBRGH586P4UDSTCCo6guHaxm0sC
         VfVovpLMVJNhGH329YF/2qE05VkU+xk6ggqwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744200669; x=1744805469;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PtXMGs7EWmz8YpnhCnXD5krrhFi7/XXZNLQxormo78=;
        b=GmNp42iaRijPV3m4+cb9eUsG9CR9I9E6HcCuwnhrCGz+gJoyTX3l7iRXqWEST70LYQ
         pnPrHNLJeE3CrRKlnawPDxaukvrU+5X3myZpfxGsfcLE/VL4N/4bSjyvFasxr4UTDozH
         T0o7s8ANEq1UquzmRJEe2QmTu3m/c8F2M4lmzfHHhiUguu+uQmh6URA2VpIxK7UyH1Em
         pmkt2TFkU8DhA5ENwWpqzZH7a3qS0Dq+b18z0CIvQOzMe1WzwiAhMCXFfGdmTeI/bNRK
         7RQ3gviSEdN0xhMEv5aarPF9G54Tu23BPQC1hEgq+rQ+z0/p+rADkVGG+Qg/2tey0FP4
         PqdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn0WDcys5mbERK9Ic7cK+l1O3gcigxcONez8YYeUz8n3vE5V77vMXosafwBy54FhDxYKrLHrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDRK+20tZKNRn7Qqv9zTaFY0bLLW6oP8RaT2jckao7XeKJbto
	W+unqXd1RP/GmhUOTCwpNbitfHdFlMGdK35m1Z0GE4pehdjUUrHzccHJhMPmdw==
X-Gm-Gg: ASbGncvpKXqvIvO6pjsrAQJNmDru8/S03TzzX9x+ePAmaVjyq7mH/ud9zBwc4RlN23G
	Olw6MCE4fQuZnO0MUG/ntS6D6zuHHMz/BHJtgri/gfhCXinILfOSACSqio9U+KK0HY11TbefnMh
	pO3fmQ3xcAaMzoc6UEvmppI5ddl6+mp8izAoq6PryYJojTX4vL5O2BGfyg2avMBgil3o/RqISdC
	4+vNj2aBT2MwvN6h6eOeRJ3lH+QrOYXABn2MCrF5C4HaaFkbVAEL6UdPGaIMfvjNhrkB/tinykE
	QY96KSJec9XJJqHlGWwBK3om6UGX0XgchtJ8tF4JocSeZLW9QglHnaVcA5pL9FoS8PiaNINZzqE
	saEU=
X-Google-Smtp-Source: AGHT+IFZAPvCBJgh9XVazfblCmGFa6YHh0C56/60XRWXvVZNJuVRhmhgazTESo+2pXIgjIbzPz1kxw==
X-Received: by 2002:a05:6830:6086:b0:72b:9506:8db6 with SMTP id 46e09a7af769-72e71aa22admr1193256a34.6.1744200669147;
        Wed, 09 Apr 2025 05:11:09 -0700 (PDT)
Received: from [10.176.68.145] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73e67465sm135366a34.57.2025.04.09.05.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 05:11:07 -0700 (PDT)
Message-ID: <d791185d-6a23-4c6f-8a93-d5464409939a@broadcom.com>
Date: Wed, 9 Apr 2025 14:11:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brcm80211: fmac: Add error check for brcmf_usb_dlneeded()
To: Wentao Liang <vulab@iscas.ac.cn>, kvalo@kernel.org
Cc: christophe.jaillet@wanadoo.fr, megi@xff.cz, saikrishnag@marvell.com,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250406081930.2909-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20250406081930.2909-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/6/2025 10:19 AM, Wentao Liang wrote:
> The function brcmf_usb_dlneeded() calls the function brcmf_usb_dl_cmd()
> but dose not check its return value. The 'id.chiprev' is uninitialized if
> the function brcmf_usb_dl_cmd() fails, and may propagate to
> 'devinfo->bus_pub.chiprev'.
> 
> Add error handling for brcmf_usb_dl_cmd() to return the function if the
> 'id.chiprev' is uninitialized.

Thanks for the patch, but NAK. Let me explain why below...

> Fixes: 71bb244ba2fd ("brcm80211: fmac: add USB support for bcm43235/6/8 chipsets")
> Cc: stable@vger.kernel.org # v3.4+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> index 2821c27f317e..50dddac8a2ab 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
> @@ -790,6 +790,7 @@ brcmf_usb_dlneeded(struct brcmf_usbdev_info *devinfo)
>   {
>   	struct bootrom_id_le id;
>   	u32 chipid, chiprev;
> +	int err;
>   
>   	brcmf_dbg(USB, "Enter\n");
>   
> @@ -798,7 +799,11 @@ brcmf_usb_dlneeded(struct brcmf_usbdev_info *devinfo)
>   
>   	/* Check if firmware downloaded already by querying runtime ID */
>   	id.chip = cpu_to_le32(0xDEAD);
> -	brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
> +	err = brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
> +	if (err) {
> +		brcmf_err("DL_GETID Failed\n");
> +		return false;

The boolean return value does not indicate pass or fail. It answers the 
question implied by the function name brcmf_usb_dlneeded(), ie. is the 
USB device running firmware (false) or do we need to download firmware 
(true). So returning false here is not going to help us.

The id.chip is initialized to 0xDEAD so upon a failure that value is 
being passed to brcmf_usb_prepare_fw_request() which will consequently 
return NULL, because we do not support a 0xDEAD chip. So there is no 
need to bail out here. Just print the failure message is enough although 
I would suggest to include the err value:

-	brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
+	err = brcmf_usb_dl_cmd(devinfo, DL_GETVER, &id, sizeof(id));
+	if (err)
+		brcmf_err("DL_GETVER failed: err=%d\n", err);

Regards,
Arend


