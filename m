Return-Path: <stable+bounces-230217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YORxFxbnwmnnnAQAu9opvQ
	(envelope-from <stable+bounces-230217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:33:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0439231B90E
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1275E310765F
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 19:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCF52DEA98;
	Tue, 24 Mar 2026 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJHWcSPS"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753C2DB7BD
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380099; cv=none; b=B389j7oLoZyjQFJnyUjvw2C4tzDQPQpDPcaMhF+8bcP32d8QNvp4dMSFHM5SYywWySjWh9JRKFTAsQf6ZOWHPpbCiTALDGSrKzOXKkP8AqvD+qs4EjaUKTallZcX/KzHDee/r13eKyoytT4eDAZQSfNFKqLUxu4S3S3L6FqOlkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380099; c=relaxed/simple;
	bh=1ggRSxfqVjf+Nkyd6/5CnLXPxn5r8Z7UtuC7H2J1Yi8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aSvrhVyATyc2rTnKCas6NKd4hCRFwr0AFhWhrXTNUyFhX5XUZUQX6voyMpoHK4P4SLL/7mrEqzUI86y5ZuxlkkWEzTPluPXLSx9VJNt2FCqZqlxnE7IxhFW6ytZHmK2QViPV65xtJc/CaNZmWatnxNtH+pZ/QGa5M+aOaZmF9n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJHWcSPS; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cfc3ca1922so20290685a.1
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 12:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774380097; x=1774984897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x7OYuNJrumOUG8swZz30U31phe5D0Nn9dOcsToznFEA=;
        b=qJHWcSPSmcGjTLgY+9UsPwMxPrBRFXDu2LGwyReILcS3MwostW8cj5FSRlgr463QLN
         L5rbLL4x7OAd4hn/zUZVWd/RwqPPexSscFd/37gqwa/io4G3ttYU/7f/n6o8Oi8PHbaE
         zCZCtrMOPJbjZUmjFDTAGEB9AA6TRy/N99P/rvAK0P6T/E4mbJq2oXRKGIqEudIJJc60
         oesoUP5DjanQZB9a2olVvkRhXWKU6GCF+J3/W/j5/SV874UdGem4HComq8fq6KepsL3n
         ZcKa6cYhrJl11LXW8GalrkhRUv5E8+l7hQr+3p3gXzyKXNX5ihIkhfNoi0vo7c96edoR
         5iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774380097; x=1774984897;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7OYuNJrumOUG8swZz30U31phe5D0Nn9dOcsToznFEA=;
        b=Hprtkxmd+6rKB9zJtpfzib1FplK2kJJHLM7y7QH6r2S+UuJZvabJR1wJmEwlTLElzK
         VoGrPqKjrDlt96xTJxEkoE4UNuzz0+VwbyK4yYVGeFQfzIVEAqWTgp0h26+CsjkYkaY/
         2kW7vMoV2arJ5vIEAGHranBa31W8yIoD+GQABmxjmPjj05bECVoPa+s1rQv4l3dLVJXt
         43D1RcgDmJQ+gjtOvj5KuDiSHm42z0fetXmTuY5ncZVxf6fm0ao9mLXPMS+0e4zGP9So
         1atnO9VOhBh9OYGbxdzVegrp3doQkuEaBsoP49qmH7ChZTRtHk3KBGN2hJNMq1rS91nK
         qZNA==
X-Forwarded-Encrypted: i=1; AJvYcCU4FVXuRtj3saF2SUce1jJRO2q+3Y2HhAglGVhxlMWic0HovoFrOsi6K7drmXkziYvFAmJ/+U4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3s8lsDzCxcSE9nDyZrpzDPJUtxErLrUdDCH3WPdfTIG/eN46E
	O5qQ5Z97JNiC98laUxHjlysQDrPdl6/j+kuebdMdMGHVTQfJ4Fa4UyoI
X-Gm-Gg: ATEYQzzTaxa0b/zNXG8fP4Mt6QQFt1464S5KDIE/hd8YzVzu/4Btwl2p++YEtizkwpY
	gTPhe8J0AoJO9V5UuFh9ELu6IbV4zZSEfuGpoUuLmH0J+gL2QjOOlku+wm8yeJ7CnwAdPJmSVB1
	XtM7s8MYJW7kryGTDgQ3qaCcPRkr3XymCPW9zf+UIB0JKdRN+WJdK7IOss+SOTqwuyLYwDNx9ps
	2DUc67L1gvU47wvH9XkeHhP4X+IOHpXzTdg6yf+Ph1TOvVoGBi6Wcqvrn7EWHwLdC8aUuo8HgvE
	ljJL25FrBSCgc29wBCIc137i7TkDsXaAJ273PE6ydLLI+DceDrz8Q1gopigQw7OitLCxBEaWR39
	kRAauHThamH040flFqUXV+pn5A4Fw1zh0vb6Y2EBQVsKzyfaAHSKLSK/HI1PubnIb4iluZOM/vZ
	ppSZUbDZ1rkbP28U/5YVVscJREWbIj8wrz4vyK0yqescayXhK/+acrjl7fRyV3
X-Received: by 2002:a05:6214:21e5:b0:899:fa7f:7144 with SMTP id 6a1803df08f44-89cb4ee1e3cmr63152656d6.26.1774380096647;
        Tue, 24 Mar 2026 12:21:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c8536ba60sm123576176d6.44.2026.03.24.12.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 12:21:35 -0700 (PDT)
Message-ID: <cb569289-15af-4bd4-a654-7b04a3690559@gmail.com>
Date: Tue, 24 Mar 2026 12:21:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.19 000/220] 6.19.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260323134504.575022936@linuxfoundation.org>
Content-Language: en-US, fr-FR
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230217-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 0439231B90E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 06:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.10 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

