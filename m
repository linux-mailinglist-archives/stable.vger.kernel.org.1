Return-Path: <stable+bounces-233729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLL0HpKV1WkK7wcAu9opvQ
	(envelope-from <stable+bounces-233729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 01:38:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 568CA3B57EA
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 01:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE0FD3014FD4
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 23:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D99B38D007;
	Tue,  7 Apr 2026 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVgzxzqV"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC0382368
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775605133; cv=none; b=W4cECHlEqcRb2DSD5U2q/QLxJV3TzXpNGyABB8xieZcta9TcNVlPYVKCo2TfOY4cl2ovltycQ1DqfRrB0ihnfHs+XyunmOj7BZivi3XJizzwRTnjLC07/bL/sI/IcNToNUYdSNfIykzErObZT7s56EZPJb4QqRtVlOyCXiVcsjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775605133; c=relaxed/simple;
	bh=VgEc5273x8QvuvLUX8FENRwhckLC1YXDUM2CDsmXjoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFIYK9gzgvwIBDb2jfVDyzGGzVhXKo6BRzgrjkQOJfJkIxTqgHD7SmiY/RM80fOSoOO0TXb/n7L2gY87L/dkElE+El2z/rdEh0sYeF/bzbwcoks2PTy+/uO669SAfvUD/AHieLcP5IOLjDBLH4cD+cUDxyLw/NTuVmgaswFpU4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVgzxzqV; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2cfd69b564dso4477424eec.0
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775605131; x=1776209931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PCw7bcv7pWdT59X1uTR4fyFL/tKoJVAsdE0NMbI5EW0=;
        b=HVgzxzqVyt9GqCFhlYCCdag7CH0hzrdYQZ5/9mxgVm8I6ynQUoSmKixTufdimVt7CA
         IqTAIWkZqxTj9i93IrLKY3daTdHU2krAjkOZNgNIzVcUtmAOaf5WB4kLoEyavZuVXhOB
         Su6DvGcWtWbhEl3GUnC+TirlahNQXvyPyxwv2osaGrRLjAHdTyhxYQFZOf7MbGAvLdIZ
         DGhAf/gy7bshIIPO/9XKhlC/rJi/j66tfRQJp8ufWT+XR0MHnUGJpxzMwxJImKMCn2MI
         4D9JMtvL+uNHjRLT42hwPklsDsAC6YpHPGpkWH85IFKK7CKUK+bHGGnf+eTJUTL6Jrow
         1cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775605131; x=1776209931;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCw7bcv7pWdT59X1uTR4fyFL/tKoJVAsdE0NMbI5EW0=;
        b=oIpiispoWZX7bYpIUeSQfiV1X69PfIctM4UeoXCDUoCRYmeQLOrZE+OwcuLoRpwZg5
         JabRmLQq4cvMRtN3G9ZHK5noF+E0B6gnw2f5icrzUGCYxdPRaadF/qnA6+50PvFooQeZ
         5kcaEOcC4yx0SA+f2fmOocjreFc0zXqF37wxdiAOC2OCyRIPjEhuxTpvcP23Dgpi7OhU
         q9cb3hOEIAQBrcOSKu2zrWMaGgDXDGT/krxHpGQItOIjglZXK+HXBO/aYbU94u3k4VuI
         tsxv1ljl4TNvdFIM0+4g0sTX07yRDqSw7dF3cHaJt0I/wnjoOLjoTWgyctur1Q6nAbCN
         6w8A==
X-Forwarded-Encrypted: i=1; AJvYcCVFJv3MqqowXrYexdIZ2h/xRhaGgzyKlC8C9L/p4T8dBF5LYSUffGQTb82jbFgpE3rLBedzcCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9WyTqAyBQYwxdONDWeH4+7DVC8nnUydS1QLZpdsiqHut8mith
	YaR2yR9YSCjXOxtaxSC7r1bSYhngvsoNLA3ChV+syaa6KZUOC4dx36Vw
X-Gm-Gg: AeBDievAGtZRtDrYf6DS0U/yKXrc+rydaWUeuJWovRmNie7VFZnAsZRtyMVRn0r1/jd
	m75ji04otsUvLzBggDsvyN+HSWa7piNMmjNe6DecieQSRCozuunYB7kZdVs3LUMKF8DN8url44S
	SC6nLQlxiXoSagbpcLx+sdbrgxpJxOCGR/mUjKNxXkCvfpxlgJvUI+KJO4gttaQn+50fyOkXUIN
	bVgRZ/MfKZSLMrui1+HU5DBuk2GgKJRPNMpV2NZj8y2l+kq7WhEdKp6fN3lEZ2XAYmoRXZrx5U8
	rmr5vTwHhzg3d/ftp1tpjG4rmz+IZyOPypE0PBUqei4Q9/JlgB1kN1pidugITe5DSLnIkHF3kKH
	Mj+n4n9Sr+vasmIw4HQiK4RAsN7XdDRfiMfr/8CRf5i3f6Wqvoqfpq11jx3Csd9tDBieRmJ6yzj
	05cfjMsZ0cI8YyYxm+pgnwlbOIKLn2PGIENb1uv/II13ZH8ib+SxkqR1caoi9FXwiE2lNoxNyZ
X-Received: by 2002:a05:7301:5793:b0:2c8:409:a9bb with SMTP id 5a478bee46e88-2cbf6a8e0cemr10092502eec.0.1775605131080;
        Tue, 07 Apr 2026 16:38:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ce39d13decsm11370343eec.8.2026.04.07.16.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 16:38:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <445db932-ad0e-4a84-9c91-5ffe858a9b55@roeck-us.net>
Date: Tue, 7 Apr 2026 16:38:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hwmon: (powerz) Fix use-after-free and signal
 handling on USB disconnect
To: "Pradhan, Sanman" <sanman.pradhan@hpe.com>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Cc: "linux@weissschuh.net" <linux@weissschuh.net>,
 "cosmo.chou@quantatw.com" <cosmo.chou@quantatw.com>,
 "mail@carsten-spiess.de" <mail@carsten-spiess.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sanman Pradhan <psanman@juniper.net>
References: <20260407173624.247803-1-sanman.pradhan@hpe.com>
 <20260407173624.247803-4-sanman.pradhan@hpe.com>
 <20260407212210.280128-1-sanman.pradhan@hpe.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260407212210.280128-1-sanman.pradhan@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-233729-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 568CA3B57EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 14:22, Pradhan, Sanman wrote:
> From: Sanman Pradhan <psanman@juniper.net>
> 
> Good observation in the AI feedback, this would be a pre-existing issue
> in the driver, as this patch does not change the struct layout or DMA
> buffer usage.
> 
> I would prefer to keep this patch focused on the disconnect lifetime and
> signal-handling fixes. Addressing potential cacheline sharing for the DMA
> buffer likely requires a more deliberate change to the struct layout or
> allocation strategy, so it would be better handled in a separate follow-up.
> 
> Happy to take a look at that separately if needed.
> 

Makes sense.

Thanks,
Guenter


