Return-Path: <stable+bounces-211182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFWIBv5icWkHGgAAu9opvQ
	(envelope-from <stable+bounces-211182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 00:36:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EEA5F93E
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 00:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C1258C5326
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 23:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DA13815DB;
	Wed, 21 Jan 2026 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NNR87fvF"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7834A78C
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769038571; cv=none; b=rB6NjDBIdHaql9W4yQrCxXwD7n9wIdVgr7n3+RzLsK4TzrJ3yI9wdSmPWtg1uHS5owKx/JmRrKOtwa0fgGp87UMQdZiLSrmw4hfv4BbCrf5v1PbVnwbuQevFCuqiPdpi+CM94aN9dM2sTAqpFZdtMsmC6reQJOGre5NTvmZGr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769038571; c=relaxed/simple;
	bh=qL7aCUx6kvvRHjayMVw7naN77YFLWG1dpl5yFQz8HEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwVChsdM3MEcxyvyzmLoDpVGz2R9IiBpL10g2ffemz0orTEUrliZYfPr3+h4U0r8u71IhywX3FaT18kwBTo0q/byziJtG+8R3i9ge8GLwQtRk7pKEsx+tryOmkqR5Si+EJFfEzfgkrm2uqyzk7S/gq1nnbwtCsEE6PIgqgzztuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NNR87fvF; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4042f55de3aso238844fac.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 15:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1769038564; x=1769643364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7TbFCm9LfVISK6AhTxIU1adeTlDFPbZ2gHj3oRwHAw=;
        b=NNR87fvFUi3eKk0JNxBkGvfApmkKo5Rq7lJ2FLfz8Pn7x9eHKfYQXhC0nFnNn3S933
         mDVksWrbFtcCMmnVEKEFUOl5TnUk3iuIsFcxl9+JwQPJ88rWoxUWAgrHSHb/Ee4Cz58t
         gDvWxHEdpvY1I4CPX++DafJauRw7eN8tDiT64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769038564; x=1769643364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7TbFCm9LfVISK6AhTxIU1adeTlDFPbZ2gHj3oRwHAw=;
        b=VhqL6iJ6ga4yxkTFJtQl2YauxHbN6EoCtb5iqO8GNZ/4Rc2lXJ/h4+gb0sAx+C8fWX
         olIHDdOsXBwxSJfS9QEV40UoPcXGA2w7wZ8UZch7vbpw7sudj39EDQ346zOB06gnjSA6
         i8wTojYT2Llmj5zayuAj7qo8SOKjIdyQBqJDul3+7wnMs3DeW4l0guPLgb69U0GBmh2s
         SaVLogzrSi/MA/DbClO2x5v6q4jdheCXhB5QpTSb9xJR1sCO0rWNS84qmWnRR7kZ8m69
         c/tZP+DVUPR1n7MQn2NUMMdAC+uTIpbrV3iu6bleU2bB1TcRGOqKewhk/jCa2nXGMm22
         5vXw==
X-Forwarded-Encrypted: i=1; AJvYcCWOpmTA388xSzAwzVJc1VP73hOsDXrOGpB9/hliGJfLanh6MpOVdg6UvRmIteYEwDzSuA9VHLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmjYJMdZb0luuXS7PirvrffxGOcSbkDtz8TQcdnGxek+UI43aE
	r7tsu2ozMrdJp9+M+1UZquCMc4rsFY/O7dnrS1vWPjcQkjHCT4Kdc32SlI3KXpxXlHM=
X-Gm-Gg: AZuq6aKULi/VrkOOLL33mHgYxJk2EefX782OWCNeKT8QfFHF4vZUGGatw0GIarTKt+t
	hZk89SgzEtUJo57GER4XEu0FDeQuAajV1eHRhpylS3u+1LovNkWbss5YctrGThP/epJsI552a56
	n1l/fIvSJ5D4lJ144R+2VmzaZ9YvKgp7Kj0WagtbscAHdq55VY91o+DTRGdDEXeA8LL8T58KBl6
	EOU2ofTlnv9+fhY05nw7NHLnxxzzIulTQuCtZiQHNqIB7YTPclhQIFeLlZsRny72kVxlG4aJimW
	bmTIFh69H6J2hH0eO349N0//oscZss1QgIhNY5+ZnyBWPemnRS1h1RxMuakpuDTHRyW6V97WFkH
	He02Cuq19/SP3GrfHNNGOeYTt/KuNJ7tePDxbnJhMYwOTCFE+X5TfRHtC4blWpoTRxHzHE//nc2
	Vn+IA1ojqLbyt2nSheryn1STY=
X-Received: by 2002:a05:6870:828a:b0:3ec:5138:5cdd with SMTP id 586e51a60fabf-40882a7d813mr708471fac.2.1769038559117;
        Wed, 21 Jan 2026 15:35:59 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bda443asm12287034fac.22.2026.01.21.15.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 15:35:58 -0800 (PST)
Message-ID: <ff3a84bc-7982-4059-ade3-61c5a72ba674@linuxfoundation.org>
Date: Wed, 21 Jan 2026 16:35:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/198] 6.18.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211182-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[21];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 83EEA5F93E
X-Rspamd-Action: no action

On 1/21/26 11:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.7 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Jan 2026 18:13:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

