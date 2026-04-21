Return-Path: <stable+bounces-240209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD+tE0as52kM/AEAu9opvQ
	(envelope-from <stable+bounces-240209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:56:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D24F43DA6A
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1886330200CA
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848033803E9;
	Tue, 21 Apr 2026 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WbBol1rd"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE237BE7E
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790541; cv=none; b=q7XNzLa++l25ELm1fxrPB9cuYiOF83365LGlcmxG6jbOXfklkmf18sRo/Czx3q5os8u/n0EU94ri8F1mZmsVpCBqZ4ME/qKqpAOie61sCKZEMaWQE+2LZ30LreDjAMWCfLycxJTx/vtCj101jlJK6vX55t0RmhPs+N+kpvflNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790541; c=relaxed/simple;
	bh=sz/zUddagZdBpM+1x065rCU+wY3xqxGaX8mRfw4d/tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7tFG2eY2aU+dc/If96S9CG8+/IvMUeLSGZsthUbAfBATl2yzJlfBPyUkazNLQsbvTECF4P6OYwYvqX3ecl0so6WWboU7ZnOb6O+P6FVdVLCU0WK9uchLEPVXD59o2h6OTEeYo8TD4Xq4pntv9jMN9xR+4EBW67J3U+jClWCfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WbBol1rd; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-479e4835e08so990327b6e.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 09:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776790539; x=1777395339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ourW28idMA52G3od4NF/tAMZiEMb5C+2cC4gr13Zqic=;
        b=WbBol1rdkewuze8JR+iDzq3okUmZr1ghZgwwsCvF00aM5TUA4ikMKIMmtCp8fFlYXG
         mb03yrGPPs7pVXy36IVcE5IZwBpvz75vo+qjHASMLNRVw/3di8u+bKYcm20wISrFObXK
         /VSpgUXl+RKAtX22HRvzvl7ohdZZKItkYUBtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790539; x=1777395339;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ourW28idMA52G3od4NF/tAMZiEMb5C+2cC4gr13Zqic=;
        b=L+zOUW2sJRszgzesGjT1IK1RJbo25SWT0c0aIo6srlEz6evF44tGNEyj0LGbiacNDG
         3VNTszuhSPq6s5mvCGUPnPFl6Dv+8yq7b+d3aU+Ls5EMCragER0zSk6aGmm3N0xkwtR/
         YPTi+kdxw145wde+I9GM7tLVi3e3q5tfm/R1YNxtsnY/qR7EUUZFLMPDX7HezDxlXtIP
         q9DH4hJcHgYu3BHnQnaoqwRN1eulwHA+jodxlZAbiw3qGl6u93atHNzn0FvPtGNL3aOR
         b/PsmFs5QyWnYJ68iAZTQUtL2HYdkVgRkAqfQtDlF8B9ZmUetEl2D7O10QtPY/S/0bj9
         qhTw==
X-Forwarded-Encrypted: i=1; AFNElJ8qBXPnSqVX0hUG4eobLtffKKYBRLw+FBXCkPgazRjxhrgqNvR2fVkSg4seffVqHNvzwIuMrhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+JVid7zTp6X3xBSAq1f9uywrSP7BwYYLUEStHrh9CkOi7ChC
	fJ5A0GAz0Pe77aLZVriSt8kPKq6UeY69Cs5wqW431mloNpAHuPKtc3otPWOU6wTczr0=
X-Gm-Gg: AeBDietuXM31lemze6YORVoAlZN6kpc2NR2i4LxDbI4X6u6GBA1N3BaYyxQ8XaZsOfE
	gEMlpANnd7jWhPGVtBZcWOHSDbDYwWbFLBrlPC7NpQsvzeStkdoek1AClwAFd3jtxtSpH4QuzIL
	Sr4hMPkxVFYPr2OumLQFXlmaNdr7SkRz/GCCvxJdkbWQS63gcnn+Vv4MMlYT1088sPzz1M4n1V6
	mas6hns0fCd0ZlHGxXYIq8daeTTGbEnyiU9h8NoCamgnjTkCwBNi5reJeYDHYdr9XR88tK9faae
	kvYmfhGC+Lxw/a7+9AmNjY8BCS0JZUg0r6pU73lPeczZSc5aBkSBug9Y6IYC3UVpVSPyy1DvOSS
	mSk8FM9nWKy+UVHoZj0HAiMkCj1jQyooWNU0UbPrQJdL2Uw7k1kIYvtN+QCtZozEZBLQep3aX9N
	iie5OdEYd4P7TtX9XkNn2jeOh+HlwTKb0l9Sttm0SEpg==
X-Received: by 2002:a05:6820:2904:b0:694:8ad6:245f with SMTP id 006d021491bc7-6948ad62cb8mr4441906eaf.43.1776790538681;
        Tue, 21 Apr 2026 09:55:38 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464eeee56sm9084401eaf.8.2026.04.21.09.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 09:55:38 -0700 (PDT)
Message-ID: <b09106f4-53fe-4e63-85be-cc048de844fb@linuxfoundation.org>
Date: Tue, 21 Apr 2026 10:55:36 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/198] 6.18.24-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-240209-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 0D24F43DA6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 09:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.24 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2026 15:38:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.24-rc1.gz
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

