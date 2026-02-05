Return-Path: <stable+bounces-214549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLYEAXb2hGmB7AMAu9opvQ
	(envelope-from <stable+bounces-214549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 20:58:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3AAF6F44
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 20:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E8C7301A719
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 19:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2D32A3D4;
	Thu,  5 Feb 2026 19:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhwk3gWe"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E132A3DE
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 19:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770321521; cv=none; b=e8PeSyIgjiS20zd4fdVZPBb7JrKceeyAi/gFwWjd7iLOEJZufvJyXJYfQzh8l0ZGOSYApbJXzKgFuyxrdgjd9CHTEte1L7OqZNRkKcmdnNZAghoOWEWzbFn8ukvv4RpOH6FkEACPEgkeXSPvrioY1oZvijEjN0YpUzdRBhBfRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770321521; c=relaxed/simple;
	bh=wjOJpS1Be0lrIXHOKRw7AA2oLGRcmSqsJg9FgPtL5Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I09KzVjaXXZkFiiOuxocF4s/a1UzLmUp4zYSViom+nc64Glm2hRntE2QsRVuBNCe7h5PY/9RvMS+U+P4y6wEWoytYmp+XwnWgnYah9ydUyzFO2ivX7n8NerkB9NT+n5+tniJ6+zwh3Qmq4m7WuHEia4k4lqhAY59rGzLCQY15OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nhwk3gWe; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b71515d8adso1232337eec.1
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 11:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770321520; x=1770926320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ij/zLdrWcWHh7R5tlgMoxwCAW7LC/FBBeDjIZZrZTEQ=;
        b=Nhwk3gWeZKShuR9/8o7tbKVoWoOD3MubpbfTuc3qur04pMWQdXLSqnqON4VQ27qZei
         uG9s41bScTP8agqCQjv/NsgEDjNleqaidRb52sH6cla+iPGGH5xHecGW+UCi0+1A1RDC
         8j/wQBv0/ZSt4aEZWejp8zVALeaFHN2snG6aQFNMtLGHAl2PIHoO49UhSMs9jlkzHmP1
         qbttoV/tC+NJdXcgdNgsX0SUrN9tv2EC+8iaj91Cnzc7qRT4JI3gXtNO7FMHroxLkzX6
         kg7Ffr+OlYQ2hDbgGgXSWlGYCaugomI7RXyZ+K844M/8HyKNQgw6AWmYK76/Tc08sjI6
         rMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770321520; x=1770926320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ij/zLdrWcWHh7R5tlgMoxwCAW7LC/FBBeDjIZZrZTEQ=;
        b=kgrykbSfjyZEIWULVtGSorU48fsz02IIeilaz8RJYy4azvU4jCsGdHQEN8KZhrkeNO
         8+iEjuA9rZGa827+qjDzKKYi/r/XXEM+vT/zeS3eRCiGQRXkc8g3bjDJHKP2y/LaPIeT
         6Tzl1+xjZjPW75WwvBG4X7Ta4/IjeHTHgL6/2/extaC2FpwDaR3EAIuV4jJk+0k4QLHx
         zm8HomF19a2l5q0IRttOVCY5SD8X14cQAIh5KP09/6hihRq6Bo5b69SexAal0jTWb+xF
         c6rx6VgFtdscB4moiuwgBql6SDwUkVld8pm31evwgUr0zzicBZsTzb9+VDCwq+zm0LvT
         4JnA==
X-Forwarded-Encrypted: i=1; AJvYcCUHvBUMPPbd3HXq3Cgat+je/eA8Hvft2Pw0GM54W0YBht4lmLkwwIK4O3fX1KB6KrDH8Dj8XXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEO153m3sPSvF5xQ30PWrt9hfkOPxvLAEjm7B5WmXrFYyN7bPo
	z/FhAoSOEbcgJfZdWcwY573WJHVqxB/Ga4SN5NYBJpKDUNVKO3y1+bkP
X-Gm-Gg: AZuq6aLqF1BZFPCqfpdo9lVHZG7dXL7xcxNs4graypbwhedKHzLvB6tsRTUZ6dKVnmh
	ys8jYUIzThhju7/1Af3Hx/hEsdMSEq7jyYS3W5aVnQeHPujxXmEi5wjBLqg8tPn7AykkcR4g8iG
	ENd1THr2FRi4qASB1+hIS16RRxR65LqrcuWPfqQNvbhAMY+5H8R3jfqZpi9r0ZrpxEUTnkQyess
	J9eY6XTscpifPhuTNo/DktrtYNjmNyjPtqEZI4r6zkXBZwbKo9Ivs0uD2WzF42lMi9eJiDFG0C3
	viz3OBqGGn2HS5wY8OYsM+FYf0qpV0ntGEA5awhCLzYLVkyGm2gbz7r5oiIsU0dg56KGLjNAooA
	pXHoiEMehypifQEwsUV6NhqduHVDAzbEO1FTS1axwxjkfuh2Z1gdcEHfNJpSuLXR8x6DXauEFci
	+cWvpmesU27QLWnnX8KL7iKKNqE6Eb3yWj5OOcxg==
X-Received: by 2002:a05:7301:198e:b0:2ac:1e68:2342 with SMTP id 5a478bee46e88-2b856a4247emr95411eec.39.1770321519939;
        Thu, 05 Feb 2026 11:58:39 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855af6452sm287924eec.9.2026.02.05.11.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 11:58:39 -0800 (PST)
Message-ID: <90ef9551-f188-4645-9cf5-efa49d6c3005@gmail.com>
Date: Thu, 5 Feb 2026 11:58:37 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/160] 5.10.249-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260205143430.733102763@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260205143430.733102763@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214549-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 4D3AAF6F44
X-Rspamd-Action: no action

On 2/5/26 06:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.249 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 07 Feb 2026 14:34:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.249-rc2.gz
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

