Return-Path: <stable+bounces-223146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N0pNJmuqGmfwQAAu9opvQ
	(envelope-from <stable+bounces-223146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:13:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA262085BF
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 23:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E2B31EF6A3
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 22:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1D43D1CAE;
	Wed,  4 Mar 2026 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laMvp36f"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288619ADB0
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661913; cv=none; b=MtEClPIryIKkPnTwKy6dgSsmGcWwZGNmE0QWpAaiAlzPDiaeXPhju3odzP+j+qfvaqeAJ6eptQ35a983l+2XnYUiRnZgTMSO8LNKEYrJaGA2QS7+ZOszTRKm+NPUYhi9fQq7dI1Hhl/zPfZtXqfk5UgXUszoxpfm8XNAeL9iTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661913; c=relaxed/simple;
	bh=VYhrWTE4e+8Rk+PQgt/i0bSrU7RRLhVkbRlbYbdphn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=keRT53XzI+gM+ieUiN/BafBterVHxYH2blCZFbhxggBMp4ri5xbehVjk/e6eklw38/fevuSWl/3ttMLYEpM4qf5I5ltopd1UQUHH1iug1zTivcXOD6A4F+xenPQRf5Ey/RcvMSfcEW24h9Tb5gvixDoQJm3Ajyb62kaBfCJ6x6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laMvp36f; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829759ca646so579558b3a.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 14:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772661909; x=1773266709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DnNS/tGaGpFQwBjHzq319MKLMKV3i/bV/reb9OTZndE=;
        b=laMvp36f+GDt599xkUcvrFWC/sLQOUACqmyeoo5zQJlcqfu7YG68sSX3Y1FUPIGJj2
         dr+Ie+Y9u2nCjTenjIMSJmXnoKSk0wH9DC6G0Ab62LJVRw8nB/A6r/ykiZ57SZ8aIG/1
         5xnFPbUINo6M05lwq6t1KGTcjyfUMJhTDy5jfcPe6k4Ame1Ll+hG7t0OrqOKBdywWcPn
         wIT+Z3pSE6l8MjVnthYsIyRF91ph5ypSwwg0RSgSAhNKIVSecShPowbOOG4gccCpq1zA
         MQmMc3IC3mpHndcS4k8ususK6LgMxNxLmrellS0QOerv6injHRgZjlgBnYHms/qr84nr
         4sLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772661909; x=1773266709;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnNS/tGaGpFQwBjHzq319MKLMKV3i/bV/reb9OTZndE=;
        b=wi275CuYRGkv0c3JxDfkucOkCUTp1ti1eJ+Ez5l5jCGtC2F907K3VDCKOEgH69ascd
         hzEZ1pH5kCyczByeyLlHVTBY5ZHRYOVQOH3n7MmTRdn4S3Ag1epUwb9yWhTNNOzWfptR
         31LfnH3hndocJW3+J+Cqdgfd15ralU1znNb9Jyq5exipOcBla2JooKg91RtbY9XzXLxG
         xQ9EW6Pftqoa8TTVULGAt6SdVYvTEp/czhWzY+rYV+acVKqrZJNUxa+1r73gTAw7vnEb
         PdQuhNcLrq4YagsgkMqgYlPCFnuUVufWAWqU+UrJEj5QBg0tEVxOR0e7XznGjrIN+l/W
         eCMg==
X-Forwarded-Encrypted: i=1; AJvYcCU5eXEHh0IqaSBvJM5B3ExDl9lkMzswBwfRBo5ldqHKTV4z47CoQw2aFPuniyZESv7Mgx6VKaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFT+pAmOWK8WP8Pf4XqKfoydNPqL0/O877lhQNu+uPFjtdQ8xy
	hCwqyx+oekUOQaGvC8DKv6FE54X590ZxaprrjjhY7D+ejhsM6CKgbP9r
X-Gm-Gg: ATEYQzxZc0da/NSR+o7XAB3EBTq10yuAci1nZXF01ynjnUyKxV2oQ+B1aoa05d3hm9t
	jr97xGZKKvEP89BXGMMSiFEsk0Zq2TeL927Dt2XyQ1tqH4FWMAaxPoHQcmzd4GAvBr+s9zfWf3P
	DuYWuiZpeV2OegqFIRQ0AocD7J64ewDrKocplVYz+Kk9IRZTvXs7iOH6qGFv293cVL557mcFktV
	J7fR8gcC2ZXA3bx9EfrcAjsLn3yBgcjusni1tVLyU32876gYbi7WJBLkBvRbR5NlULW69zfpWe9
	AzQH+Zj4HQhrTsrifvmdOjcu8gKwpu0xQC+G824jjAsrEx0JEt0vVrDF5N7Y1NNfTNqbRDLDovb
	WlA+ArFStZ8s3fzRHsaNiNgkn2jstnVzr4cZDhAoZFH/3fEOxPa/ytCOXoEmK82OFpR4fNu7nGs
	RjvIKQ+YkJgI2I13epA7pljydN/FG+h2TKCei3XU9B2Yatt1qLigXi+bcGoscGc0gDT7WgPFYMo
	ipbMWAGmtA=
X-Received: by 2002:a05:6a21:9a01:b0:395:151c:4ed5 with SMTP id adf61e73a8af0-3982e19c6fbmr2875990637.37.1772661908898;
        Wed, 04 Mar 2026 14:05:08 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5ef997sm16817797a12.2.2026.03.04.14.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 14:05:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e7191c1c-ecd4-40f8-9e47-9357bd82984f@roeck-us.net>
Date: Wed, 4 Mar 2026 14:05:07 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (pmbus/q54sj108a2) fix stack overflow in
 debugfs read
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, andriy.shevchenko@intel.com,
 Sanman Pradhan <psanman@juniper.net>
References: <SA1PR05MB8708FB8CDA1A57DE77D158A7BA7CA@SA1PR05MB8708.namprd05.prod.outlook.com>
 <20260304070607.1942-1-psanman@juniper.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260304070607.1942-1-psanman@juniper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1BA262085BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223146-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,roeck-us.net:mid,juniper.net:email]
X-Rspamd-Action: no action

On 3/3/26 23:06, Sanman Pradhan wrote:
> The q54sj108a2_debugfs_read function suffers from a stack buffer overflow
> due to incorrect arguments passed to bin2hex(). The function currently
> passes 'data' as the destination and 'data_char' as the source.
> 
> Because bin2hex() converts each input byte into two hex characters, a
> 32-byte block read results in 64 bytes of output. Since 'data' is only
> 34 bytes (I2C_SMBUS_BLOCK_MAX + 2), this writes 30 bytes past the end
> of the buffer onto the stack.
> 
> Additionally, the arguments were swapped: it was reading from the
> zero-initialized 'data_char' and writing to 'data', resulting in
> all-zero output regardless of the actual I2C read.
> 
> Fix this by:
> 1. Expanding 'data_char' to 66 bytes to safely hold the hex output.
> 2. Correcting the bin2hex() argument order and using the actual read count.
> 3. Using a pointer to select the correct output buffer for the final
>     simple_read_from_buffer call.
> 
> Fixes: d014538aa385 ("hwmon: (pmbus) Driver for Delta power supplies Q54SJ108A2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanman Pradhan <psanman@juniper.net>
> ---
> 
> v2:
> - Fixed email formatting/line-wrapping issues
> 
Unfortunately:

WARNING: From:/Signed-off-by: email address mismatch: 'From: Sanman Pradhan <sanman.p211993@gmail.com>' != 'Signed-off-by: Sanman Pradhan <psanman@juniper.net>'

Guenter

> ---
>   drivers/hwmon/pmbus/q54sj108a2.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/q54sj108a2.c b/drivers/hwmon/pmbus/q54sj108a2.c
> index fc030ca34480..d5d60a9af8c5 100644
> --- a/drivers/hwmon/pmbus/q54sj108a2.c
> +++ b/drivers/hwmon/pmbus/q54sj108a2.c
> @@ -79,7 +79,8 @@ static ssize_t q54sj108a2_debugfs_read(struct file *file, char __user *buf,
>   	int idx = *idxp;
>   	struct q54sj108a2_data *psu = to_psu(idxp, idx);
>   	char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
> -	char data_char[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
> +	char data_char[I2C_SMBUS_BLOCK_MAX * 2 + 2] = { 0 };
> +	char *out = data;
>   	char *res;
>   
>   	switch (idx) {
> @@ -150,27 +151,27 @@ static ssize_t q54sj108a2_debugfs_read(struct file *file, char __user *buf,
>   		if (rc < 0)
>   			return rc;
>   
> -		res = bin2hex(data, data_char, 32);
> -		rc = res - data;
> -
> +		res = bin2hex(data_char, data, rc);
> +		rc = res - data_char;
> +		out = data_char;
>   		break;
>   	case Q54SJ108A2_DEBUGFS_FLASH_KEY:
>   		rc = i2c_smbus_read_block_data(psu->client, PMBUS_FLASH_KEY_WRITE, data);
>   		if (rc < 0)
>   			return rc;
>   
> -		res = bin2hex(data, data_char, 4);
> -		rc = res - data;
> -
> +		res = bin2hex(data_char, data, rc);
> +		rc = res - data_char;
> +		out = data_char;
>   		break;
>   	default:
>   		return -EINVAL;
>   	}
>   
> -	data[rc] = '\n';
> +	out[rc] = '\n';
>   	rc += 2;
>   
> -	return simple_read_from_buffer(buf, count, ppos, data, rc);
> +	return simple_read_from_buffer(buf, count, ppos, out, rc);
>   }
>   
>   static ssize_t q54sj108a2_debugfs_write(struct file *file, const char __user *buf,


