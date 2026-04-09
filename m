Return-Path: <stable+bounces-235472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFSoNbHn12n8UQgAu9opvQ
	(envelope-from <stable+bounces-235472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:53:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C843CE57B
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B28A3009B3B
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 17:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9AA3DA7CC;
	Thu,  9 Apr 2026 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WbKuXkOW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D84B30171C
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 17:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757224; cv=none; b=OVi8SN1mI5zUJKWi9RjlJ4LqfJp3sCP2BxoZfkU8uDNS1229oXfXyvhWakU/1A8kTfFSjhkTl00NkcIAp0+rSwKwL5JYZ5Xaq4sVk26nKeGXzsSa4O2cYP8WiL6XR8+qZFVRwlRv1MFOUKFb3uR/U2ileMGZS2A6IUfW8xHo0JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757224; c=relaxed/simple;
	bh=iRQ3w6+yntSV2TqQM7i0obZA2GM/zmIG8tpGbKGRP7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0JlvoRTC7AdSohPAS8pxt2yudsMsdnd9PIdAsnzyWENEZdhh6Yfyns5YhMQ1c09yJaTY0r0raSlr3Adn/tBoFWEaYsGaGTtUvG1JaeENTbY9+ZoiiVPZfn5emuQ6GB03azyVxwJtAdSD9U0VVG2aLD+iuHtZXr+oyDtLhRGaXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WbKuXkOW; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbec19732eso1115306a34.3
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775757221; x=1776362021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZ68RQRBggP0gvUnPIBwIISF/7PCd73n4JJR2iSytA0=;
        b=WbKuXkOW2DLTvpRMO6tV6bIpyCYNi9XbQh3aPJUc5vKJl1pArXwvP3aMM/MYIfp3UU
         hxSW3Y3WDXxOfweft01LR7Vsa7wArdCkCmR64QA7CK+ZJj2RXZJ0eo8q1cLTW50x80KS
         cSLI740jM7EEmEzmm49XcLQr2+0pN7ueJxnLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775757221; x=1776362021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZ68RQRBggP0gvUnPIBwIISF/7PCd73n4JJR2iSytA0=;
        b=Gt5d2c29EWCtdoQKfm/xR7FTqbV22bmQ7Jno+MHZ0pu7U/O/i0cy2ZHbWh72JDBKSI
         OC03sy5oxtGiesSAPuXNRo3uTtMxZzlqJrcowhMu6p36H+5664CGaOFZRnD8F1j5IPIt
         +T2R2TfbQVA9R5hdUHAc/QdWrX/uzDBNGyboaAsG/glUCt5zCMySvRtXI1DrM6FDqDjn
         M3R88d+p83z0nQ8mY5JGaANgJWHkXeCZINHstk9LqcDjRTQ+x1aIAG10FHH7pqB75mlU
         80xHmWKdl2mxQW1Y5oevkH96Cz3+itXQFeK1GCWkTzDVB8taNChxm0KHbEW+8jLCug5M
         WV0g==
X-Forwarded-Encrypted: i=1; AJvYcCUAXM1YWW/cHzg6yL95RE8i6peItrCaq1GrvXqEsuJQzg+WKfrMOdImDRq7cc6kpd46sNb64cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMYdVvS50qsvEUk8rJAUbwpEkmfvzvewKuViMA+vGTA9aosro
	HDktw6N7BXWkHcffMr4olJ3qifEX1g6wtcnes9G/IbcFrhvX/wri/PSsmcCXMhM9BLo=
X-Gm-Gg: AeBDieuDvQLCu2cTK0nZ7/AF0PXRBUtXcEjcwVwJXCPhj5GT0PukNVsBfWWuDW/Ad5N
	nriQW74nkia1axYTnW/5U+B78ib1h3BMGyhgqjlawmwSCoOdgc0IQOh5DS6MJtoPL6NRtn6A0hC
	HtP57021KE0cSt0rb0sHSJbL25rd5GdWlrvhwFvS5vLc9vjUy/4iHhxmmszSp07ewi06T7HdR2+
	+KTeTac3ytNbHs3JgEOpSIvG+QfjfYc/0+xO1vs3H9ecARyXqyiO7TdfcSqOCWOkofsP7bHsmI+
	6HoWTJtpbcXpsOlpbciydjZ+0CS3MHpweG0SCFdLmHfMUwhGxXKpWwdD0r85f4XCwpFmboyHzLW
	IZJkfXGgPyK5jT3gO9eU3YjBMdv/E99/LlNAY7UesDScvMuS9W7owgjpdXIPH9mrdUIEn7cR/5C
	jYEPJrDOCu686r3e57qKp+IV9CAa+UYasJZO8=
X-Received: by 2002:a05:6820:62a:b0:67c:2857:e0e9 with SMTP id 006d021491bc7-68be84d4703mr11181eaf.44.1775757221523;
        Thu, 09 Apr 2026 10:53:41 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb20c0fsm231439fac.11.2026.04.09.10.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 10:53:41 -0700 (PDT)
Message-ID: <83368604-7b18-4687-95d6-0359d72d2848@linuxfoundation.org>
Date: Thu, 9 Apr 2026 11:53:39 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/242] 6.12.81-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-235472-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58C843CE57B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 12:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.81 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.81-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

