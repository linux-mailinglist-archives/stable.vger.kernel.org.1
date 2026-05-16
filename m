Return-Path: <stable+bounces-249006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECA3OfWLCGohuwMAu9opvQ
	(envelope-from <stable+bounces-249006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:23:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA8355C517
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23C083011C4A
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 15:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408F93E3D86;
	Sat, 16 May 2026 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMf0n3xf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842533E2ADF
	for <stable@vger.kernel.org>; Sat, 16 May 2026 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945000; cv=none; b=LBarvqytLBo/iOhvPrYtV03z2DPiwc6vGOHOhaBJFP6DwJqeSR9p5CD/iyqzGT6LsHEzC/e0URf5VkkhfXkHdN2kFoQZTCdJDIqFwi4ucG8QyUszsvBNWq6h6n8a54UseDG5OuRmx7W93fAwY/Nulu65uqVDSf6CKJZcEfupNgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945000; c=relaxed/simple;
	bh=6BFJ7gLNaRS9ktkzCQvQKWgq9XlntK/DE37quGD8Ifk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TslZJdYHpHNcABfEtVSJjlvZcaFnonyF+3subkqS65fG7XOZmMOd+PhmxdA84rsX2q6AP+3YlxKPDbW8lCYIDRh2wKRfHBNzQKxxiWsA0h//MevQoycEQKadqwGFuXFqoDoXdz9fx1oNtfhGft4u5I/q/JbBYOVcaO2pxNOVTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMf0n3xf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2baca4df358so4784135ad.2
        for <stable@vger.kernel.org>; Sat, 16 May 2026 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778944997; x=1779549797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=45gdeTVXp8vVFaeA4pBMgjJh10jZNhmWEpnGdFpVpHo=;
        b=FMf0n3xft+PqHqJNDCEmWEQb5o/YjhaFNJWV5/WMUMFuJQX8qB8NSskIs5263Oo7vn
         aD3mHV8684XbkkX3Cm6IzbbBU/FJOwz2uFgUo2SxikOT0d9ofs2/W/sn6tlBve6n8c/y
         PsPA05rXzkVb6uCyOuakaljcQR35+EgLZ8pFuMYM6JWyCzzkfZh3qv3TFqa8kCD2/jQS
         h/5/NfN1b0wDgbUJt7WXUdJWm4NFCi/vvoQeVJitrlDe2o7A94oeDGbg+WFTOKPfv4v3
         PbfuuI4S5AsJ3Mg9hr31WcPlMGEMiFpQmkPWy631fF5NtINrZYxrmoW5T4EuAXtBLEd3
         5Q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778944997; x=1779549797;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45gdeTVXp8vVFaeA4pBMgjJh10jZNhmWEpnGdFpVpHo=;
        b=Uaw3FBaCNRlFOKDRryXhl7gVj54hIuZcWBfX8YD3P289SKQeYNkyNeoTALLkJZiVwr
         fBKY/6v3c3/vqw9c4T1TNaxM6TjRdANLSC1j44CfAz8zHm03N/JkdJ++44+TrVVtcKWd
         medp4mtq4pcQ+gH5Jkz2MNbtgZZx/oVNjrxZSCRc0H4imra459dI2DftqxLU6oMZQYWr
         9VL+Mjw91GOlioZpmygEqvTzldGBq7tNUMAc4VYgzYPoGkmpKXnFkXzSXfTBQSYr5lPl
         IiGHq0jjfvtWLUC/2Cuz4irhSWMN4TqfcRGI+C6tEgQhBxe9XUW2OOpl6QAb3nwYGjkK
         WEew==
X-Forwarded-Encrypted: i=1; AFNElJ9+UWo3vVLiUxGSVAzRZq4nMNtTS3mC14k2d73fYmQZ+VCDNP6H5Yr75aN4P7VdITOfqfGxfPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIeznz33cIgmERSNUsrRR/+KUMSjLgU7Nt8LJgrjBjoHOjnRhE
	p7zgfCx0NtIZNXq/ThO5gAdfCoN7ZlU1/s8YR0UaHDbg0m+3bQbdKREX
X-Gm-Gg: Acq92OGzHLQLLSBTRqfn7RLpPz2LASprVzDyLvdMkCKdNw7v21wk9NNxmuZI7GfT9P4
	7CryY4kfPLhSkVmhSOxfcHK4+PKALJPV90uJxqtn7VMbMWT1Rm5eDejsF4oxXUzYie9UJOjJryb
	b7xX/SdgZkw+fsJL3+4Saf8P9OU2oUdk/xkkPAIEzEazrzvpLgAtNix8Fk6cNnpgaX5mTICcxeb
	YoTt8XZWO8LXvGetmgKPKuhPRmXJ5Tprj1+CKDPPqqA9/uh5EU9MdJe8ZkrbmaJBb6W8/kuWUBf
	cLTBQTVxCYrkNaCoorkwM4FVHNVOwtOizS1joZf2QyfVjAVPt9gcYlNKfBqEiT+xK5Azp1ZCxUo
	frfWeCK7nu2xgwNqhnE0YWpsVZfhwmbENunftKBDog87EVODlZSrTURm8z1RN+o2/eW4VjHhQ+b
	qkPvhAPa4sT8RVX4jxLVehbx3zINyJjaPuzWktrFmKzLN1g46UQX1FJ19fAqzb8OEcbJwgOLqL
X-Received: by 2002:a17:902:b405:b0:2b2:4d78:eec2 with SMTP id d9443c01a7336-2bd7e92ca04mr67331295ad.18.1778944996887;
        Sat, 16 May 2026 08:23:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb1231c7sm8737986a12.31.2026.05.16.08.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 08:23:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2a3c5a65-e2b7-4159-9d3c-eb6a8a600b37@roeck-us.net>
Date: Sat, 16 May 2026 08:23:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] hwmon: (pmbus/adm1266) buffer-bound and timestamp
 fixes
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5AA8355C517
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-249006-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[roeck-us.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:mid]
X-Rspamd-Action: no action

On 5/15/26 15:11, Abdurrahman Hussain wrote:
> This series fixes five pre-existing bugs in adm1266.c that were
> surfaced by automated review of an in-flight feature series for the
> same driver [1].  None of them are introduced by that feature work --
> they are all reachable on the existing driver as it sits in mainline.
> Sending them standalone first, with Fixes: tags and Cc: stable, so
> the feature respin (v5) can rebase on top.
> 
> Patch 1 fixes a CLOCK_MONOTONIC vs CLOCK_REALTIME confusion in
> adm1266_set_rtc(): the chip's SET_RTC register is documented to hold
> wall-clock seconds, but the driver currently seeds it from
> ktime_get_seconds(), giving blackbox records timestamps that reset
> to small values on every host reboot.
> 
> Patches 2 and 3 fix two ways the blackbox-info path can be driven
> out of bounds by a misbehaving slave: a 5-byte stack buffer that
> i2c_smbus_read_block_data() will memcpy() up to 32 bytes into, and
> a record_count loop bound taken directly from the device with no
> upper clamp against the 32-record dev_mem allocation.
> 
> Patches 4 and 5 fix the two ways adm1266_pmbus_block_xfer() can
> write past the end of a buffer: an off-by-one on the helper's own
> read_buf (sized for the length+payload but missing the PEC byte the
> i2c_msg length already accounts for), and a caller-side bug where
> adm1266_nvmem_read_blackbox() advances its destination pointer in
> 64-byte strides while the helper is willing to write up to 255
> bytes per call.
> 
> [1] https://lore.kernel.org/r/20260512-adm1266-v3-0-a81a479b0bb0@nexthop.ai
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
> Abdurrahman Hussain (5):
>        hwmon: (pmbus/adm1266) seed timestamp from the real-time clock
>        hwmon: (pmbus/adm1266) widen blackbox-info buffer to I2C_SMBUS_BLOCK_MAX
>        hwmon: (pmbus/adm1266) reject implausible blackbox record_count
>        hwmon: (pmbus/adm1266) include PEC byte in pmbus_block_xfer read buffer
>        hwmon: (pmbus/adm1266) bounce blackbox records through a protocol-sized buffer
> 
>   drivers/hwmon/pmbus/adm1266.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> ---
> base-commit: 1f63dd8ca0dc05a8272bb8155f643c691d29bb11
> change-id: 20260514-adm1266-fixes-853003a0fad4
> 
> Best regards,
> --
> Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 

Sashiko identified several issues with the driver as part of the review.
Most if not all of them seem valid, but were not introduced with this
series. I'll apply the series as is. Any fixes can come later.

Thanks,
Guenter


