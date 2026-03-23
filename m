Return-Path: <stable+bounces-230017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIA6M2O5wWm/UwQAu9opvQ
	(envelope-from <stable+bounces-230017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:06:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 710AC2FE112
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A16A302693A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2743822A2;
	Mon, 23 Mar 2026 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="epVfJLuh"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD685375F7C
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303580; cv=none; b=r2vU6fTzEq66raAN8phApYoFs3WsEL1dQj71+teXLobQFlfIDsg3WH7WOaV+WSXbLhNNEplpzAhSIl9gTNYG8odf42RwpjQf9OcRe/2ShRuWAewPqpWz1nd0l5tgtj7mRjiM7uclCRZMcFChidKRrXwRGtuOTp7P1o7p3+HCb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303580; c=relaxed/simple;
	bh=5TNBIu+1zNMlQ2EzrYj8YDKPSFd9UJLXVnMoMpiv34Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXxnce8Bvfu/d6X8JYmh+ICh74cUA1+kn/sWRMQJ4rAvw4eGKDqulYKL+PgFwgvGG/KtkKYSdfA62ZySeV1LcLh5hfhQdBJae9gGM+2i3dU+WMZRXE12VBoQX+zCWcdp6AXyJBNjKfgshBUhWb7JxG8Mejm5771Q305elY3Ik9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=epVfJLuh; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-467161c4ba7so2846564b6e.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774303577; x=1774908377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+uT5kvrXZcde1sxcqGB4st5JQXrajTNaDzGATU3tww=;
        b=epVfJLuhmdJvquuzcWyzlHD4XdhS6PUw3y64Yh5+U31abBDTSR7MoSLZGiEo0cGXD5
         YYj5Y2YSF20foW3Foi376rQjWdId9iuAR/MTm10BXRuGhwl3tooRZJ9tsl6B/ILNSh5O
         4BEhk6ZIaO+89Rm/ycTXi/sV31rsFez0IEPrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303577; x=1774908377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+uT5kvrXZcde1sxcqGB4st5JQXrajTNaDzGATU3tww=;
        b=nxXloSp2ygvp2N7tylAU5lWM+Vn1+rSjGkd/w35xmwb4XcwxVZyXob4RPHh4soRiiR
         1iz4dLPYhaMK1W/NG6nquYOD1hSlA5S3nJOS6LXNdD/uR7MFz+l6Hp3TruTZLLc21S2B
         ZNLd53Yt5LqmzxAwlyes57pK4ULzXAjGdkWkcKaN0bQf6AKrEQz1OnmiKMzMmfeLEU3i
         smnpU0fuZu5AShmMJC6wqHi+9NhAKhNzPEsHwNdVvAFnWDSqrDSZG7BAlKid9urhGeJo
         RLiy2jx8HjZRSahJL8Z3BsFyRQZhWLFCRWZowxINu+yOREN9E0LgSe1WgXHfpO2SYKky
         aSBA==
X-Forwarded-Encrypted: i=1; AJvYcCW+0ENxGhMg/kvmkK7a+T6trzTtDa4yzptiMus4S7BbtQuQtOwnubIv4rLI9C7L2OC+y/u+vtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybN8n5QxHnaldKDu058mIvBdtgJgCPPPYt2kXIoEply16bgL16
	zKseIFXjcdYfaypP/LKm4BeD8HB9vH9NSbOKDQtZ85HMF0npwV3SFjm4wdIpedmg08M=
X-Gm-Gg: ATEYQzzMaIdoClaF1vsMNUlEkxEv8rTCwhfeEUlrIDNp6dnC+OuV0hA2I4soOkOMpWl
	H6c0ggoc2v6ntjT0BR3hhKEP83GpPjN2hnU1MShALH91J5zSkIpL5FMPPI2++uCLRKguGmPfQ7U
	3lZGh5MR/jb7+t/HmWgNmja6mWU/MFBO9mxdGWea9vQjxBFRUl8LXZaeUTEH6hnmxvcqOwDlgza
	UzT3ZS4JU0DW4SLlqehgQ4OX3XOoA7vqlWSBVRbf72hfRLC90+sFIfKl3oB9MmHBMrY5hkMYEQv
	UhaW18J/Y5TVHWDZWbd2gv0+udR4n8eRddIC1KHkkA3nLo/44/Ck65Wgd/oNyJJ7iBTaU7rZ640
	jXI1EScPLqFok0IZJWPiX72249NFSxqO8O7Icd6r6OrSxRyHMY7yhPVdEFAJlTsh51JgBxoMWMa
	AJLDGawPRCbMqTjjuk9elkfZQDpFXG2ZjOewU=
X-Received: by 2002:a05:6808:238e:b0:468:4b3:d12d with SMTP id 5614622812f47-46a0cdb2d19mr705075b6e.11.1774303576681;
        Mon, 23 Mar 2026 15:06:16 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c4833257esm5980819fac.4.2026.03.23.15.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 15:06:16 -0700 (PDT)
Message-ID: <e5af7c22-e40d-4344-a6b2-be6d62f38df6@linuxfoundation.org>
Date: Mon, 23 Mar 2026 16:06:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/212] 6.18.20-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-230017-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 710AC2FE112
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 07:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.20 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.20-rc1.gz
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

