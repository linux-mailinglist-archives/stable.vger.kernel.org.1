Return-Path: <stable+bounces-119550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D716A44A42
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 19:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C585219C71F7
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 18:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B2120B814;
	Tue, 25 Feb 2025 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="GNbCf/o3";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="ByhPtz+6"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D519F2036EB
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507849; cv=none; b=STi4l3mQ+Qm0Dz99/moH+LIhbACH4ud7MV2T9lMrl4czekXA50+G+zIScTLXchE7vR4k/dQjSjaDQK3owL21LHUMA/v4nVxbnrGe28OTi9XTtDIT+sElmlugyq8xhD3yB8m9nyf4/lsfRbri0HWGjjFQQPtP8JtcU5Q8uBuKRCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507849; c=relaxed/simple;
	bh=SBkC6K1saiGACNoan7QB2EPwo5J7cMg6MkvBnK5tNHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOY51xjiyjlr3XeCMyARusd5sjvtz0VvocNUskDHXvONMdljg2Z7JcJ8KgbGqtXcO0uSfNr/et98djFU+V/SRxpX2cJbZZgcVcJSjVj+jFMwx2TrUXcoPV8N21FZURX6FYRvriDWXpq/0lbFSrODPBWHmLPR7Et/YfyBxCX0ZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=GNbCf/o3; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=ByhPtz+6; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=xkCeOl6nj9IK5tQwcy8oiuh52jYXAnIOceDA8IVe+lQ=;
 b=GNbCf/o3kO4exRHdGWDWiY3J0McRGr0JhvLtWvKZSi4gvTxctTYvYJCMrZN8wnFMs8w+0oVAqH0YfOrErVm8FUZ4FSZsGrVKTDIVBPOdfSgpn4NTX27FeXDKHSEkiLKQepjv6ZSqjyq59K74d1ND3tDVtKrWisFydo2+PFMpu6qbDHeT+RJAsVewpWVvkqWVSVc1xDQQyP1qHuEaWgVS0nPr+9jYA25c/xslJQ8HB6X8r5B/DatCUNg9ySwXvC2XqnaQ7fvpjzHkPxo18tUi8w7HiV0mis8Z2FI3LndPM2NvyI8yRX673H01XrACrPX3xo4f55gZypUc6SkVtoXQqg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id CA531280168
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 18:23:58 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0a587dbc4so537647585a.2
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 10:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740507837; x=1741112637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xkCeOl6nj9IK5tQwcy8oiuh52jYXAnIOceDA8IVe+lQ=;
        b=ByhPtz+6sYVf8zlqsbegd7OBAPxJEaI+Sa4hVVjMqZWjlEPCOObPpn9Pa69c4bRcrO
         qnxHWgfM4/9grqrl94sWuniKGSW+hVUKxXGYJUdsDmJcte6tmDRepOUNTrNAnVODX9qL
         /hMioBcHCNQqSiLUKy1c4CUutUK3KpkhW4MvjaaWBss8mBXnpAKvbFMQa8dsPtgnEcPA
         qRFZzaLh3oWGpbVU5yDIqevqCIv4oEdse63nWnu2w0e5Pj0WAdUUMuD+xEwjE8NflsvP
         p4t1dKlREyexIyk3GJ8GA8/NpgM4n1pIjOvy5iVRgfOsNOP6ck/rCqHgKhfyiZHTR/bn
         FrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740507837; x=1741112637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkCeOl6nj9IK5tQwcy8oiuh52jYXAnIOceDA8IVe+lQ=;
        b=FY6r7CtpTXjFaKhKz1Y55R4HqHLuOOK9HLXlHPaJiAIlomTBYaJcx4yA5BpOBtcPgY
         BnVjLkD+Oey5pou2IkmwHpffgzDo1kE9BjTQA5Hzk7bbKu23lcPQ4fiN9Afo51RYkbkn
         Spp9sHlqbjIOck0fwrKIK8XVPqH9l0dAKf3s81O8n3yZ+25JQNLcUHi9A76YGs3NhlXu
         LS2jDwheFoqALWtH4IZwxMpZwygsaM19m+MAWd6PMIZewDsXlvnPNRC+rIq7wzf+b2d7
         FmnaoebBxWHHViX2a+pz63IR+RLLrgg6FhlaJnMQIWOHpyPGwu5nQ0/DxfF3WObkVo+i
         uwmw==
X-Forwarded-Encrypted: i=1; AJvYcCV1XTBN2a/gZLgevNfVEy1eOtTI3ewdtT9v6zor7GAz5hRH/al3/EGuhh6/b8h+Z2qLwQ5Wq+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1aOBxKywqlcq9ZD1gBF1Dj9SZHwhdAgz1Oo2/eWmwUupp1sRW
	GZInsxLs3QzUqufyGOXCyShPcRSnr6eDA1lZ35FgrRBqtBLXSdTkTybDGopR8VYkmDFB+HCA1bk
	t7rRUJzNCk8rtSDiuo76YQ7X5xnXbd7CSvRoviMMrOsvMWppZth/kkxQBUuVi13MvSiWiy+ub3z
	o=
X-Gm-Gg: ASbGncuyRsDlnu9b2Q/VEjGqSA0zgMXx5KXIxByndrQF5Mqt7iNHW6SPRr1Nqy7ez6j
	bKZeruZNfhEiDi3+w9tuutXdQv7jIOvd6ClptuPHtXNFjLCCtsAUHseN1Szv2gMVo89Pw3H0XaL
	5t+SZ7RczLtdc+p6PmPzF6nqzbtKCNp0M3rmejgBHJ66Y6po1VFuvVg8qHLYXWTtsXbu2YmozyB
	9GAIfb3BNXjNfbPXGfxvTkMK6UOgU3Iu9Gz9slTLDO3I7XeQsV85GBXSDkhK5IdE8eacA/hYtcp
	GMpGgeeiq/RTfXGpN7GeqW/O0BMkCH0w7bn4JEdIX8IWMMpNrFsV6/9KUE9ltxxuT1sp4YvWhyd
	QUEaWtwhfNPDGRi1LOPNjvkoqlk68l0beyBUl
X-Received: by 2002:a05:620a:294f:b0:7b6:d8da:9095 with SMTP id af79cd13be357-7c247f20022mr65059685a.13.1740507837365;
        Tue, 25 Feb 2025 10:23:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH55M+1Ifas+XqNzr8X3+KkOff8XpRApkTQhxLbzscTrrKWkaE4uVGMnrWH4qExo9dqce3f1g==
X-Received: by 2002:a05:620a:294f:b0:7b6:d8da:9095 with SMTP id af79cd13be357-7c247f20022mr65054885a.13.1740507837013;
        Tue, 25 Feb 2025 10:23:57 -0800 (PST)
Received: from ghostleviathan.computer.sladewatkins.net (syn-076-037-141-128.res.spectrum.com. [76.37.141.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b06dd6esm12101966d6.19.2025.02.25.10.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 10:23:56 -0800 (PST)
Message-ID: <09882df3-a186-404f-adce-cdde1a6e887a@sladewatkins.net>
Date: Tue, 25 Feb 2025 13:23:55 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/153] 6.12.17-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250225064751.133174920@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20250225064751.133174920@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1740507839-FbHMTUKCqqqS
X-MDID-O:
 us5;ut7;1740507839;FbHMTUKCqqqS;<slade@sladewatkins.com>;3898a0dee3d557fa468e7fbfdd1a7683
X-PPE-TRUSTED: V=1;DIR=OUT;


On 2/25/2025 1:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.17 release.
> There are 153 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 27 Feb 2025 06:47:31 +0000.
> Anything received after that time might be too late.

Hey Greg,
No regressions or any sort of issues to speak of. Builds fine on my 
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
-slade


