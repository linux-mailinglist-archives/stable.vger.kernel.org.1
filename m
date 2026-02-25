Return-Path: <stable+bounces-219679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIKMOks5n2m5ZQQAu9opvQ
	(envelope-from <stable+bounces-219679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:02:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E28B19BF5F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 19:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DDE1311FD2D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 18:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930412D7DE1;
	Wed, 25 Feb 2026 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hwgq1YYd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDA2BEC3F
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042420; cv=none; b=vGDG17gp2AYPFIOIYNddXoUcD3sQ9QRlBEBE1DcIqMmYclFgxP5gxEz4ooY9diVjoGeOH2OQ3TbXaHF3meBZvxnDXvlgyr2O+fK7E87D6wv6hzZaFmYgjcnk0zJuc5LGEMtocqTndjvn3lMhmH/CkgyNoo73AcR/14/MvwEDPcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042420; c=relaxed/simple;
	bh=VFjCPQKjBUlbOeDPZ38h8xTmdlaHE8oTtOtI/o89Gwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQzLP5RVU/jaaAOmojFoUsU4ENBhAOcpSJnBEV9pwc7Yx/1VhJDkE/CQI3dIRJ2dnTNc8SnyuPPe2PRzga0/GlQW2M7J4gJC5NKi1Sbl0scxR02u4mY/JYawV7S3ko6WHkfCAikqyMyWAi9yuxSobyFXh37kfdLLQErQiMRPnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hwgq1YYd; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-896f5af3d8aso98888936d6.1
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 10:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772042418; x=1772647218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEXbWlLuprK54ee8WDE/Pj9WkXvpxvQMOi9F11bVzpU=;
        b=Hwgq1YYd+HgxevMHibWLsaKFs6IFf1emg7nbJ0e7ONdE8XONVzCYZ71OqQn+RtTCPq
         dhUvThMaOv+8vElrtWERmi9uPAiqdnzj3jFu7unOYucuHk3v/GsH6glYP2+zyTtTog+c
         uvVoCj/dnIDs8HDvo2bkqgz/7lt8+UaK4ePKdV0lwHZuRt8vtkkgihslr6dssevvGmq3
         09P8VVa8YKIWQKFiqWNzvJdsm9MzmLThjxc2HXd1xBab+TsUhWkYFF660vm3MZhJBTfJ
         8S1cv5B8v44RYTEENdrxUDfL6JNsZVvqlEVoTXCl/6psMf1lb7It7AsslE5xGLQnOMyJ
         uNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772042418; x=1772647218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UEXbWlLuprK54ee8WDE/Pj9WkXvpxvQMOi9F11bVzpU=;
        b=hsVKZLbTTaewFMwO8NrKEvdDfEDyFWcq7RyXKoev0l8aZZfH6yCG0XhlZsFUt2PXYZ
         iWU6OXEL1qrICWOSDkAsfLKBL6UR0RSWD24PBjN6advQBsIrgBSqT7Vc3MT+m42X+iZn
         WyAOBxRxK+yAAi9VactI5YZTjrIxGugvD/hY6lkLnxi5oQs31Rr/rzGR4ulXQZvEf8Gg
         0C3yNz57rYq1K6isR38QJwNZyW1jP2/umaWrO24feYlrr2SBWxkjcJ2xoTshQQxLFE4u
         VEInD4VrOT7JmdtdNWPETnkwqrL6h2iLYZIQRQOp1YqNV/jl4+MiE1gZVyb8LWWl7Sbj
         XLrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3XeASEnUMFa7Y+jIHqpLDfo71vZWAG6Y6OFRga8TnyICWmdufoQHvOPODv/GtQmsja/4XQhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/taK0sAD3Sx6mkeWLoBTuCQzVTBOmeZS27xg3MyQcSekiLzQQ
	CD3HmhSs8zXC51xv7YjG7/R7NuPospSH8n+m+Us4t4yuDBIwbzqrFvZhWm0nX7di
X-Gm-Gg: ATEYQzy14uXecv4NvSyIsC1m8y3c6wWlzSR7iS3aBU2kTVlz3vgkoW5vMjgFrneE6Oc
	8FuT0dMb1V6zlgbCFNoGp+SZPMuEbWjkeQ/0+B0pK4ay6NXWQadqcV2H3YVZ1EEdX24ln0DJo+k
	5Jh2ic/iDqPK5ws4C0v6L0ZrQF0zE4JTCC8j1ufCZ24KhMcyD7KRUi23cxwS83wEAh122JWB2zT
	Asfn5UWQWOm9+NzHxAwCcz17LwyQu82eOeJ+lEHm9qFBbmXPKphXJ2Q9Gn6JYmcbVvh36lwi8dQ
	KZRhLqbSKbN+YnxL9OmHQS4IRCnFXx3ypyF7WGuyhNxR5G3afy68YzG/UvqseIgZTNpU84u2cGD
	PFTaUasxHBqLsrBtIPQS3yCB9K+/yFMtBp+ZobzK+TstISh2l9XKGfyvrqDdJl2sjygTs+OuvbY
	PBkYdeM2xXTNXiHyfSWhBwluBVOI6yb1TxW9QL00MtA26z/0Dw/Q==
X-Received: by 2002:ad4:4ea7:0:b0:894:2f04:eb14 with SMTP id 6a1803df08f44-89979d5a142mr254800456d6.45.1772042417990;
        Wed, 25 Feb 2026 10:00:17 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0eba54sm1468212285a.30.2026.02.25.10.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 10:00:16 -0800 (PST)
Message-ID: <043a9c41-e891-45ca-ba07-1bf215a2288e@gmail.com>
Date: Wed, 25 Feb 2026 10:00:13 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260225155341.094945851@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260225155341.094945851@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219679-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 5E28B19BF5F
X-Rspamd-Action: no action

On 2/25/26 07:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.4 release.
> There are 781 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 27 Feb 2026 15:52:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.4-rc2.gz
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

