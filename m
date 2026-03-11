Return-Path: <stable+bounces-224761-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC9EJ3vXsWnVFgAAu9opvQ
	(envelope-from <stable+bounces-224761-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:58:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D9526A38A
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB7153193903
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 20:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAAE362152;
	Wed, 11 Mar 2026 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GlddNKKi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01535A380
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773262607; cv=none; b=BtnceIIKmyDzZZkFQCR3RrnYnci/ixqAtWKpw1P3kUROvHQ07sKu9Tdc6R0DvIilksPURtn2tn8+FmgUgPwOEYt1JPk70cTJCkmWduUrxKphcQhRwGwB3gPUQw/f2KhoQ29u4nOVLEalwN77ojCePFrcL4BkhuxcAGWCL6hIRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773262607; c=relaxed/simple;
	bh=VmuFJsywnZ2FvwgxzQpHowTo/1hBL/VAqvQAEhTpf8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RidO8y3+erG4qCox3J/sqdT0HpdMyZ3zWypM29NvzFpVbj67+gxM7UpoQEEDrI7kWxlCjN26nSAsvPKMlrf6kFW31H9izTzo7yqhn4QjvNRXH0CPYAYfI9iLvXyctW3bb8CAI8qYyq0rYMf9NTyIxHR71FwMOYCvjoFN3JNTrI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GlddNKKi; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d74d6bcc00so286655a34.2
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773262605; x=1773867405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6zraRIPOTU1vMM8Wp9rZ0NqOWIy40gGpO1AhV7AqD0=;
        b=GlddNKKieYzVMTswcGLKsWkN0DKuS4+DfsPlzPV/30Vv5a6zK5WvIfvvSYsetKaUUq
         oAiLtxY8H6IlU0suIx8g/3BhvZtOupNX9GPwBJNl03CaSTAWLiGojLH1K8Ii2Bh0gJcL
         oo4juJsSypRZF7fkUTs/7jF/oOnenpDcWrxH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773262605; x=1773867405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r6zraRIPOTU1vMM8Wp9rZ0NqOWIy40gGpO1AhV7AqD0=;
        b=TQf/AIKdw1AnSlGq+AwYZijDd6p0funXC4twCl3oHRty6A5QEYmS9pXU412GDufgP6
         U1AwDZ0i6qghEEDqilEJ/apFXphlbm5g9D+x7tFpodRWyg+drwzDFhAqbOdUvqXHiUzc
         m/2Cdy2HhP4THGbc1OB/csn8Mz1wbMXqaPMq8xDszlWS8+Y4dNmzavwj6RL1PObsLU3a
         73pPIykIGAB0VcQ/9xHo+4kqQtvGwmlyO02xp0Jyqat6l+Jgvis0sWRsW935Mc5SXwCK
         zbtfqsCN3sW0UE/gKqeokyDEYUWqvIJnITLYg6U3a65mELNmKfr2xCXaQWNxPScquKGu
         KbEw==
X-Forwarded-Encrypted: i=1; AJvYcCUv/yYLbDtJOcCR7q7djA34Odsl6D4uxsxe0zvmzImlXx2EfvTpraePKGX4IC2O4BuuBm7G3zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YjdavqbScOz9Y/50pgFOWZz38zZ2VOA9BN6aJQot2vLbR+W2
	M8b0eujBDJNEE9H38x/IcIYFPSSZ1a5UV0iLakNx6SMasrFdaltGfHm/khWDdrqk2PE=
X-Gm-Gg: ATEYQzxT/kn0arx8HVXzWfFaW4dq01VcOV25biQ8TFP2PruUEdhWDm3/J/tIQvd7siO
	ebEPtwYrv+JLTZsq0AJJD4wnp86EBUwP5W6n3Z49vU5jUkco3iX9z/1nIyerfu12yR334vagW/b
	Lj3PRA4QlyiSaFznU6IQUGxoQphCcUgl3NM1Wv+vesO4osUlZj/EzvAvYjI8MN9oYa6n0gwCznV
	xKHslI8xT5sroqUPnnrjl6uQgQ+Clm3XLX9mPuD6Tya76+RgZh3+cOjj09+oOApyg9X+wZXMWxJ
	WWMWxQxnLvwHDKrphWpZaBZOuLSPY+HYXl37JVJHQGU6zGjY8JDoAxPg6fpkHlslTzStVWAZ8E+
	AYGPEU6f9DPznff2Gqe6qdh1ywt7u+cPusDZcIhbsWa4EBrN60cT8SQfdszc2PQEg1IbHPfQqhG
	BgajHfKqEO0JD3pCCw+0661sSvB2nOv3Hjxhc=
X-Received: by 2002:a05:6830:2682:b0:7bc:6cc3:a624 with SMTP id 46e09a7af769-7d76a7a5df9mr2517914a34.32.1773262605586;
        Wed, 11 Mar 2026 13:56:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aee1ad9sm2663993a34.29.2026.03.11.13.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 13:56:45 -0700 (PDT)
Message-ID: <e4df551d-0667-40b1-9d47-48b1979773b2@linuxfoundation.org>
Date: Wed, 11 Mar 2026 14:56:43 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/314] 6.18.17-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1773141554.git.sashal@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-224761-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 00D9526A38A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 05:19, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.18.17 release.
> There are 314 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 12 11:19:16 AM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/rawdiff/?id=linux-6.18.y&id2=v6.18.16
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

