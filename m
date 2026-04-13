Return-Path: <stable+bounces-237619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLqiAn4w3Wn1aQkAu9opvQ
	(envelope-from <stable+bounces-237619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:05:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F75D3F1CD1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E007730668A8
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9900A3BD25D;
	Mon, 13 Apr 2026 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juJ4tAlf"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641543C141F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103193; cv=none; b=Z/DY+CSGfBPRBPpu5vBGh+xWPtUAT2cchXs3nt6aW7UYw79OWSrmdK8BIy3gPH5ZnFOLUCIjjyFEDp4E9IeMxqudKTi+KnjsVJ88awEktZ1zlOKxoywZQEPxDCChIi6RL4DOvfOUfICNrOOixeEAQJx1pA9mZjCfiX/diF7ve50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103193; c=relaxed/simple;
	bh=MXxEALZQeY7mo4WpT9kSEYRb4GlrZ06qXuiMKIFJ/BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXwB678hNo1GZpMQX7znO020HKFmhD6L+Y1YiHHyEFryPBVceWJk5zBZeju5HvvmVrkIWhW9gzBhPYsOImggtyIJC0Oc0zbvL87tBu+9eOhy8TSWyFrz3e+EO+Vvmp1ReZwnKPMzNIbHxOqhdP/JxAlL5D1fOKaWIsrPXnzgBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juJ4tAlf; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb40149037so442432885a.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776103189; x=1776707989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPxBHy0D/fDvlZiHd8ibuhOLZoXAtAn1c1jSfW5Qwjk=;
        b=juJ4tAlf7C8Mf0RgoI5dMycvaUBNEG+tpkC3OOstsQT1EAnXqx1M1TTAzzwugeI2oX
         ge6YWMCJPKAeNi479DNobS/zbCeA0Laoy6n8seiK1ohQxCJ4cQFH4E5bhS0TJPGE7s3r
         4bWlxn7KkEUO76IMeUz6tzMJnpPPOgpVowUvlmC2Hq6lWczHDqlUwcqYoDbogLro1OdA
         tNq+ExLFIlucML2ykUZu51fy4317E66t/r9seWqtrnTesDcxSSSFQM5KReHusbQRfqCe
         GwJ8Qg08RftXPSjLYlztYhQofAIWXEiuu25Qv6bo4lMt/e8jihqvsGTg+C9yOu/Q/CzT
         hspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776103189; x=1776707989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPxBHy0D/fDvlZiHd8ibuhOLZoXAtAn1c1jSfW5Qwjk=;
        b=ovYwrHhEbaoNuzxZIZCv/oUBh/8V+PC+jYSfBJtfDZP++VK/F2rYq52angAndnP9JP
         TQUhFlxcIhIoVMbDaeWiFAGnGC5z8A37KzsQKFamoYsoWiMnuBDZcVIJ5WyrzGQKh20v
         /0ADnEwO6sE5OQ5PXUHraMzkH6coeI9gMxQI1ac2MhkrZzQuSE9JP2xU+9gxKhwdUpjO
         6AOPYgOnqSYbZ1+QTVuVR4zHws4DRoOk+528RJ9IBRMsOfzEdLTl3KXW+y44j1qaC90Y
         yMBzaZF/iG7okCA1IplgTqpMWkoGowmVaNDQ7lMf/gX72LOwi4VepkFB/mfowteBj/KZ
         4VXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MJeWX5skbMUaqK6LHhjA7BJ2SfVvlPKnmwy4d1GhNmu3/a3DXDRbwox3U2uEvDUVkkmJofbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gY2DMbEym7/mmm0qLaft6H7E1VWgyZ1piy4p6Bh1OT4TxBoY
	3G/qKodmvGbIm0uI3ErcrnRch3wiEXoH342dB73+G6O9Z7Hx20NeD5jK
X-Gm-Gg: AeBDietPB271HJjmMhxZ030295/HhWwWxkjGFLYD17hWB1Z0rVBEI46Lpb0MqWSXcZV
	ukOL/oTviHP2uMF/6wvftNOBdX56nr7+kRYdjoPAPsYJLXxEORi0O3dPJR500jmVQtEsBEKC2gE
	K2bcoEY+wPQk6qvi9Dq+CeAaHXpMal6EUuN/AX1RtZUIb2vxIrYAk0yak34to5ndmd962frtBxE
	xP2/mJKSULtA+cCoAXb+29udonQi2qIMfYzppYnWWU4GqyyyYHb756VDbS0SaECdL0X4uYA36qm
	SLOneuI6wvC4VjdT5aJbfGt4EzzUvxi4pjjEuahOtQ1r0PvHM5AGgi17iIin9UlwOnw+uuk5hto
	TbtQTBcHfbtAGBa8bngciRPlk4RT64hDnuRNJl2CxepRPZ1Cp9XeEodhd+sBrBZYGh7eCbuP2aO
	bHT5eKFMoV6j6ouyFE55cmpIw2BFJLf05i8rK9bnVSMfsZCpjVyA==
X-Received: by 2002:a05:620a:19a7:b0:8cd:92c5:b3e7 with SMTP id af79cd13be357-8ddcd8f4124mr1894202885a.18.1776103189122;
        Mon, 13 Apr 2026 10:59:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb934d8e9sm929818485a.35.2026.04.13.10.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 10:59:48 -0700 (PDT)
Message-ID: <72e59812-5a7c-4041-b33b-f8089b7d3db0@gmail.com>
Date: Mon, 13 Apr 2026 10:59:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/491] 5.10.253-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260413155819.042779211@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237619-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F75D3F1CD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 08:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.253 release.
> There are 491 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.253-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

