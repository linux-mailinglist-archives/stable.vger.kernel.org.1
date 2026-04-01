Return-Path: <stable+bounces-232817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDuQOpZJzWn4bQYAu9opvQ
	(envelope-from <stable+bounces-232817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:36:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD72F37DFC2
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 18:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81CAE300E261
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179833B19A7;
	Wed,  1 Apr 2026 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NW3h36ow"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A996E35F5E1
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060555; cv=none; b=mEC+EYSxr0VFqkkoX+ILUGjWltqUwUgV27e+MqW9Ikzk42Wj/GvvH4P4Lcx+Bw2J3DaPAikF3sA0BVHfeIF6DXJ5mk6jVN3j7rAZ0kVLMPns6ujNqpvn5vJbxU808OW8NCWteO3XLf4e/5C3Ejm8SzwByjR2WecZLnk7xfJEC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060555; c=relaxed/simple;
	bh=nrlXyztA8MWJ+v6CmJ+vWGuQSyVAluyfqvC62dofhu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1OIOgj79/u/Bo3lhjGXNN5OA2RBgv0PnA0KTexyD7BYaAFTmg8/Y4o8kQDRkQc2YaC9kvZv4yUSMI+23yQA6/7VewkcBW9pAwe7+YFhn0rlImZbH840/qHJsjBxx5QGkkw5XJg0cZpNnAEyCpbMjGa/3wcI5NqFnknHUpnLgOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NW3h36ow; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d9e22176a7so3651620a34.1
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 09:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775060552; x=1775665352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iSx3jtFH3mTErNH7oGB+AD0kG4DJzQyPkSYb6TGDY9I=;
        b=NW3h36owhvVvUAA6/uLBXj5Z4OYzMe56oVRLhLFbO1ArosOu2G1uwZyK7fnjRBNRut
         T/I2L4fey/w6eW2SPl857CHfsdP82F7Zhh6WzTLgnUKsm7VqP4qol7ZsujdGeTR0sstT
         8aQofm1wKrEoh4VbS4K4C9Ll6mMJ4Dv/QLrO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060552; x=1775665352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSx3jtFH3mTErNH7oGB+AD0kG4DJzQyPkSYb6TGDY9I=;
        b=csbdY1bMrlw3xRIiYNQ3YOuwGFs9qBiE8eegfKTc8rNkSlj++CxN+6+P38BF9IgMtx
         wit7lfLgoKU42VGQGfPEhcMc/e4Si+o3QgWzJnFINaM1pMZc6Kp5E2An5Mj4mHLEld0D
         tpllN5vUPSPnS5RBBzWA8D5ZdxDCwdLvD1baVAcTFw383HVwyIfOBR7q7Moa8nH0GxS/
         DEH+HPn50J3E5/HV+ZDOpxwabLvoZgevR5C0ghAcFOJ21v8Z94hgHxMoUYZjmlZPVPkE
         Ynzxxu6dN72fWpKBPNkCn2b7kKjzGOsGnNRRMJkTDbFEH0vmeaZhzqCQQaL9Y9DnrOI9
         Fa8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVn5i3HdaMkf+rnP3fMi7qJ89aOpq8RCfEizC8ERnOaZw+/eC7r6RQyGtO9NiR9HChodGifcgk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2hCYP4OpzxHLYvBFSnk65xZaTJHRVuQnGag+c8EANS2G/KppW
	kiUH/5Bmk5nYxobit/lYLGV9YVE/PyGqZWqv/usGzDlwBNoB9tG6goH0KOxcgxcQxx8=
X-Gm-Gg: ATEYQzxxeE++3eoA0vIm+xFvmccp1G6F2kupl2gagn1Kj+OtfO4npVdJCzA031v66VI
	oBN4gdEcwHXB6JOr0F2m8WPet5G+GLpwy0Z0Hljwsj9JprOVi93tnsJTLvCmd+WNx7YI14ZUmmL
	I0aHR2YssPorVFhuq1MCuFpmeEJNMNjE/nZtgrUOD79lbON/pKxrr/fomsDVqSm5+j6Jo7zw0ij
	h2YHJqCmjNkZqtjfvwcpHzpqSgV9o0cjrmFkXoi9/EvUtMam7Idg6YUka7KnYWO7zW+QBoNg4zn
	MXqjHSQDP7QfJlRv7aGBaL/uA/K67uk6iF4H1GQLf5hFJfOCcgptvoLMOoOUr0MU4cpBMLp7yPt
	Ln1UoYzdI3jNeBqY9HucgyM1QFjevH+pD44667WR7qw9eHjpMx9kurmjjufKW9jxnuTI52jMQHg
	MENg4AwUQGjDgLvjVprsueuS0JZ8/R6yT48+g=
X-Received: by 2002:a05:6830:a91:b0:7d7:c92a:1d73 with SMTP id 46e09a7af769-7dba7e3f516mr119012a34.8.1775060552478;
        Wed, 01 Apr 2026 09:22:32 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba7356653sm166818a34.22.2026.04.01.09.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 09:22:31 -0700 (PDT)
Message-ID: <baa2b4ef-2959-41da-aa62-928f00b16ddd@linuxfoundation.org>
Date: Wed, 1 Apr 2026 10:22:30 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/175] 6.6.131-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260331161729.779738837@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-232817-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AD72F37DFC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 10:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.131 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.131-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

