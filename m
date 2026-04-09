Return-Path: <stable+bounces-235470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IL6wJQbm12n8UQgAu9opvQ
	(envelope-from <stable+bounces-235470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:46:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21403CE440
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABCA33006D5E
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 17:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06613E1D03;
	Thu,  9 Apr 2026 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YEWuRMOg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA93E1CE7
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756784; cv=none; b=tdWnvi9Trh/TqIalr/ESbN/Y95b0PQ8ZNhTcwHkMlC1GIX0uf2sWE5QD7qHf/wDycV/9t9bSpPV5rIqE7A7/wtVmdYaRs6Jo7doweI+nlcsQABJKW/zSbRRKeRhuzXnlpWPDZI2HETZBDpXLfeZSdJtkYa4DpFAHNci8y7tWk3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756784; c=relaxed/simple;
	bh=ykDTE0C2A9shNqLv6aqpIPBrSXZlZj2NGIAu3LG7WVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9GkRFFg+F6gXnDiLgLZuG8q1Ozzaip9TibxA3iAKKkQfxKhjERf0AxNnj+b4aEZgJSBIvHX5V06yFIYHVg8d6TOTBbGha13LzphZBH6Gf/zpXAIvyjCncwIVuf9pcdgJaC9bebqcNzSYn1loeV4xA5e7HeMELQAMIA4JHtsfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YEWuRMOg; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d7fdb922a5so986798a34.3
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775756781; x=1776361581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cc50pyFR4NFZS0UGIn6o3GQpYOGikhyAqxZHWSIJIZs=;
        b=YEWuRMOg/344wCVjorO2bxt14IR1hulZduAtVw4O1YW9TFYSKZTRKw8OAgsUKmw5EQ
         S+ShbO4w2nIaUUovWGSfkrYhLUSTBQfRVWzTbg1hM80nEe6bHdC9gYUzjs+M/yNMrjx7
         b49/xoZBYmgnIZ/ZVIQgly9HdPjr8jDxRuEYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775756781; x=1776361581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cc50pyFR4NFZS0UGIn6o3GQpYOGikhyAqxZHWSIJIZs=;
        b=lNdsmSsLur47yBux2VgYUul/kofQpJrXmQ6mllxoGiCLu0ictPeyAtuzhkHhh+9t4d
         hfUlugeZv/Ouk0Z7SVtGj7ujpNf3TbjQeVajYwX9CxWKdNk/UudRkJPuqT9KsAfiEujB
         uZwrXVm0s4M2Fe03wRTCd0WrBAFFBmo9TPzi40njatCjyAs+cFaimtEFY7e9tdP2C/3k
         usVQty9sE+h/jDUVGfZCs6rfPj07G+ngETZvwwyX4vSuOMhM8dzvXZT+sp8AVSPvxb4T
         I1jKCbAk+w0ij683mxrm3LUgZnjC27/6KNH83HADG1LR4+UOekyqGX6mimvpUP5zP70m
         iyVg==
X-Forwarded-Encrypted: i=1; AJvYcCXDdxKdtcKat57BkER8ciok9aw5ZMXuDI7voLETrHKDmCtWB3Q7JuYmdr1bNYcFa8q7sbNnbT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX3iyqgiMnURVsiiz6LzUO5r3cI8IlY5XRAEpEtfW75xdlmWyr
	9hghUX/owb0brVNJ7g++tk3Abu5otX1lfBUG7i1bEfuqaPVvc4tuSgXu5BjoQUD20X0=
X-Gm-Gg: AeBDieuhOvoQwQAapAZ8palO3uyLdeCqvofOtCoT3oS2Ns0funM9XWQZJdt58JWNocV
	6vzPXT/6blR6uWY5DCaPavrSkEz3+7/8BdSYMtnRZAey7EM4uF23CjIyrOUXuZLEWJEeVsZYAS/
	R1A6tXDYHMVRLfEcM2tBNAWdvTE4Qr8NPOjiG67KfNorf5JhbUWW9dd8oxFiLkZUN2vD4UWKQqt
	gu75dpUbJjwQCDLnnXdzEolgmzm29BcX2bpGe17KGunGrXhkSr1R0o8HnjzoTHRijnb1eCWdcu5
	SpRnBUCTgUKje3lcECJpAof8WeyrADsPQFDJj3+1LnNJVDH/ELaNdn0GIQvRA2BQi8g6UhY5IEa
	uhmGrqseUOpGAWSGZpA1rdFXgVyrtTAyeVx132UG2MgrZdiGIRzyAVCLz/Y8q286tn+QR0eG1ye
	0nraiWQCXFhxkfLZRReIIyPDa6qxeOJ3660wc=
X-Received: by 2002:a05:6830:67e3:b0:7d9:7201:1acf with SMTP id 46e09a7af769-7dc27c7b32dmr136157a34.5.1775756781318;
        Thu, 09 Apr 2026 10:46:21 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc2696c463sm249464a34.23.2026.04.09.10.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 10:46:20 -0700 (PDT)
Message-ID: <d290ec02-6bc7-4328-8a21-a03155025345@linuxfoundation.org>
Date: Thu, 9 Apr 2026 11:46:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/311] 6.19.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-235470-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A21403CE440
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 12:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.12 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
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

