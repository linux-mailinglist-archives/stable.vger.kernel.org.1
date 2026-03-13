Return-Path: <stable+bounces-225375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEfcBG5YtGlbmAAAu9opvQ
	(envelope-from <stable+bounces-225375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 19:33:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12051288C72
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 19:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FA38301E483
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC53F3DDDD8;
	Fri, 13 Mar 2026 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqWlMMsH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F733DDDB7
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426792; cv=none; b=VEEAv9geaxC6JgSVwW4swWp447mohU+GIMi1+mZOx+XoE7dcUf9IAmpxH1THpCv2b7rMiZbAFR/RDpfRKBCU/FDClP4UpAgAyuxxGoH1ZFwhcknVkUcDWOWpeE8RfZr4ICtDA3YcO8DPwUIbzwUHsDIM40vW6RkkSBy4uMqoEh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426792; c=relaxed/simple;
	bh=5PJ3XjzXks0djshMWOA0orzo+ZK+NY1YSBqNSdvZbhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QH7OThKTnSqLnSoNBmnwX2ijX2/SqHWLQ11srC2Pp8744aXTKxwqHgm1NAjnN6VhGJ1bzVnZ7j0W7tp7jrTlajziyv2oxWWQP708CmWOt88561+rOEhMvAr8xFQpKe/9Sc/T26ORzi76dEywwNWqRVgBm/tz9DPC0QIHVog7eT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqWlMMsH; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899e85736e2so33087356d6.1
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 11:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773426790; x=1774031590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gFmig18Rs8HEf+yS8y2A1zLNsyNkgAYrZGwUpliaGQM=;
        b=PqWlMMsHlAzTSx1thDVQyhBKCOKXme/fMBNWyY3/p0sLKLf2+r9WkzNj7ozYZ6mWB3
         ClJkAarv9yxPXiGQu3+i1T13c35ad6wnxwKNNUdrqnVqU33DWjkJy85O90jl3akGjJPf
         RA6cQxgq14yOwIGOA2U/AhMc2ZPzrxdIkLvWLf7/cyLKvKRpFOCJxzwhRJ+Y4M2/iOrd
         s27ObcMtCxJ9js+/tQ/agTyiCYzRDwp7OHREtFoRWFO2+8HYl5cw11f3Y7z7WnlFm9RF
         jXiFYHjy3NPBXuYgIO9++hneTbCxDssmWT9+xrS0dP8lDMcA8ItsxdA2MaWufcPZ/fGd
         fImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426790; x=1774031590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFmig18Rs8HEf+yS8y2A1zLNsyNkgAYrZGwUpliaGQM=;
        b=RV/7p+97/wSaMAKkA7/E9XZHMeN8/huurb1IKsGVYLO5c0XBKooN4NbinkLrYBAPyz
         YgL67en3kj4wpBreXBrVGbYkBeA/axzozJSrtGP0cLT65FM6oh8c0bxllpbdZawFaYAZ
         dFJDw3C47e1Ce+Ru+bXdZWcAmDgNVJ8JbmZYfgNCcU8uUv2ZVZzBP+dKHV+831c5RPeq
         apRSHrDFooSPEfriWyZ63bw5PWz6AVH6auLc+EAtP9BaVjUL2yQ+wguYnZvla9H2KLhk
         g7fuRRoQKdiU7H+dUtHpkcJmYP6U0Erudh2wJtw3ZCGzK2hh8YGbO4bK6M/UBrxRdeGi
         LT2A==
X-Forwarded-Encrypted: i=1; AJvYcCXb3eJZoKozFq0mbTwYauTWc+HvXD4tvDwD9AGY9C03iKxWFdEnkSvqgI/FrC0d2owv3H4usXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfF1mel+8IdJq/iC5/P1tLbxPHEsMeCprWYTr4E38pgx3YV79E
	H/Wv6Do78RyDs0Nq/Pxu7QgI0RHg2CoPPGtkVI0de+c66xvQ1Ecc0q5i
X-Gm-Gg: ATEYQzzVTTAX/Ogk9s+r+gkE5NH2DuiJ/7wGChATpL/dBB7ieCLu8LBOGGpcD39oM7L
	nWQ9YV8AEUnk90MQ9WjCI785sAPrVVP2j2XA3iZ/Zb5T45z0TnEiMczJaASdevd/WqrLCJS9CdS
	0uIYT1dZJ/QLCRmlQObFdxFnLeNwnY8bOaSZJ3J8xJJHKZ3mYVvQCmEdQgOPqdVpmfsY0j91Wav
	1lgYInZtG4AhBBhhmh+a62ycFiA0AVQI5ekIBOWzF0nRIgq/fD6VTtTJki7fgGFqCtKu5PL9cJZ
	/ZCPmS7Fg6oXOt3VP57/t9NUxac6q7c1alYexlMwc3QEdsITjBFIY//z0uPCDxFtHp0MKh0Ld8Y
	Bk0ourTQySZW2/zCcjbAtwwDRT8/4UlgW+xsI2brnGfHj/QlSMjCbSheD4ChL1KJoklKZD2U7IO
	fmpiwMvzqz8HATBLucVod9GPTACjpbdSo1FnMww1wqdAi3rb18HQ==
X-Received: by 2002:ad4:5de8:0:b0:89a:929:3d2d with SMTP id 6a1803df08f44-89a81f1dc99mr61275286d6.16.1773426790417;
        Fri, 13 Mar 2026 11:33:10 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65cfd520sm62894266d6.36.2026.03.13.11.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 11:33:09 -0700 (PDT)
Message-ID: <b4c383ce-5362-451b-bb9c-e62a66cdb863@gmail.com>
Date: Fri, 13 Mar 2026 11:33:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 00/13] 6.19.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260312200321.671986598@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260312200321.671986598@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225375-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 12051288C72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 13:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.8 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Mar 2026 20:03:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.8-rc1.gz
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

