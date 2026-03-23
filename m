Return-Path: <stable+bounces-230016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKjVFsO5wWm/UwQAu9opvQ
	(envelope-from <stable+bounces-230016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:08:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B12022FE145
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37D0F3044158
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF96B36921B;
	Mon, 23 Mar 2026 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PiX77Har"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB83C381AFD
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303550; cv=none; b=HrCbApqVCYxiMbWqpcZWkVGyhzVRmNk2C8c1iLdcUpD9pe8UWKCWfpF+YLDWPmCk4SX/veeT7qxnvSv5h5nExZCBZYV+l0JEPvNlNgexfW1trZG5DgqIMsfseE8+nGyFIUWVG36L7eaEucwbLkWogBdGFUhfaHHJccILMRdtOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303550; c=relaxed/simple;
	bh=2g1nbK/812MZGIcGbvdGPhanwdYA1ypMF1HB4iF1iv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSJrvD3JJ1aAyDhsB3Vt69V9URRznnQFwkXNCRpXYdNRP09Iy8CvFBFeggoSVijKGjFLQr8AwCSBG9Zwzj1GHtvFz9h/lYCnalOXz9GmqsSbwMco1Xe4JGKsKuzw1Sw21vISdXyFyS/xRqnPy+Ah6IreBU6/CvzyounxuW6YZ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PiX77Har; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d77b179b52so474955a34.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 15:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774303547; x=1774908347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPi+fEBZe4b+olvD44XhIaSitJou679Kw/0wt1RgPRg=;
        b=PiX77HarptTUVj+tKDoZVwkEe1yY41KXrZy/5dAFUrxBVhG52fkFfHtnU3k4BZAjyC
         i4FX/qExtv8s5S+M4vF1FffnGvorUFgjnG1Rr+OFU04jDJeMpbrJptaVFfrIH7Gf0WkN
         0dmgUh91d1aQEFiYkbrE41iUY9WHFMclA8mts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303547; x=1774908347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPi+fEBZe4b+olvD44XhIaSitJou679Kw/0wt1RgPRg=;
        b=V1YM5jGTVFIhAzE3pNnm4V8dC63OfvtPfjEaGWguUx9EPmvXMn+YTwAXbWILDnncvm
         pmnX4njke/p17kZtERtJsZRulfOxALdqjQ+2QTGHlFJvo4cAv+tb+Up/JJ6Cbrvhp69q
         kLrIOCTcjCrJaE4BvTwW8euqgw5hro7CWbn06x8852jdjrDGy9hvwbYFWXJCYDwGF+pZ
         hiFZzUN46rbXEoxAPyAIf9sG3UDp8jhS7xIGC368zafgEQKxtNpZtOUMqE7jbuJ4dfHv
         nG3BJ6HjoseRmFulpWRjoMAimgxwG+mNPdfF+jWhKNyl4M7Bm3eZnbcInpflm2dt+ajX
         cm2A==
X-Forwarded-Encrypted: i=1; AJvYcCUYQNDej9EK1gBUCtYctznP8VOZJlczc/g3FrejbQDD7iId9sx6z9JNc84FGcWYjFn48dANQ6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL/xP+0u2PVb34LcziQBdXnMoOEOrDjzbt7jlHTkGbOSBYaJV8
	QdKmV66Ym4DJxNZUn+NFF0Q12GIJKVGwjaJM09IT9jXG1rfMIIm0dD+0+n/YPGzY7lUhBYrdd3b
	nFUkGq9M=
X-Gm-Gg: ATEYQzz/C0sh8qiHrw45mUDRHwFdbx+/iZ8CS0aQTIPHhxWa6yBn1T9jXi3izJo9sa1
	yY+Kl9IERaU+z6sZWU/l9N7r1L6mCtumHb8CIJJuX0GvjdwrFN56RuCwhfKU56OF2xJ7dZ+GITD
	RLYmV2PhFSwXKtSRPjIlTRteoZzmY8QHxMqNLdb48cGzRHF0TERd5mh5deigkzca+3Ua0ToxL36
	qdOTMtHqThxqAPlDthrIpR2+6rVBvbxlfjkOaSWN0xqT0kgUffKd5RnWTgDiSDrBwnJmXkbCEvH
	z7CE9e9c8yB21fVyjvWj/q5IjZCafrZ5uBt+1I5xT/qSy8GpnjVOgP2UxcTPnMlhdNJWEE5X0y9
	df/79bS9PTH7k/+K4Jxwl8V/1T8BvQP+sh9c+RwHhw9Y+ybrBUPgk/a8W/1OzlQBJjXGUgfzCK7
	ZNd+prLgEKEA64YSp6JdIwMV6qlaiPK3Oa9HMQ0WsVXXJ9YA==
X-Received: by 2002:a05:6830:3505:b0:7d7:f031:37bf with SMTP id 46e09a7af769-7d7f03141dfmr5725121a34.19.1774303546826;
        Mon, 23 Mar 2026 15:05:46 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadce2e4sm10400300a34.17.2026.03.23.15.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 15:05:45 -0700 (PDT)
Message-ID: <fb9bec9c-3c25-47fa-a215-b485148dc7e5@linuxfoundation.org>
Date: Mon, 23 Mar 2026 16:05:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/220] 6.19.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-230016-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: B12022FE145
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 07:42, Greg Kroah-Hartman wrote:
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
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

