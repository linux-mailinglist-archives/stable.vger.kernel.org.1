Return-Path: <stable+bounces-217611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EJBMwH6mGm6OgMAu9opvQ
	(envelope-from <stable+bounces-217611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 01:19:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F51316B8B3
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 01:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 176343015488
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 00:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9842C280CC9;
	Sat, 21 Feb 2026 00:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bcTQSc34"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1763827934B
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771633148; cv=none; b=Z6pvA1s9zx3WYOWT54sjUHLLIP1Em1qpNJO5TfwLolUslRBw+J7UPMoMZvtWG7/di67WMlTIynIrH7idx9YHyQ8uHg1TClCAiY6AVZR91tAJZ/LtABRmwPxrlFf1pnh6pBtBagXDWVFwcH3qM/XJ5B/+LjhofpWlbanjsNv1vfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771633148; c=relaxed/simple;
	bh=lDMgTBjr6jA7ry6Xm5A7oyBFF0gSzW20pw31ngDNXA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0rb97UxMDGZhEobt4HtvA/TEEnIN375wbPpkL/dpetwqy9zqPna6g2x43kCPd7c+HXQCBAyivScxyes8/mMDsnhtOqcKMrvXeF3sE9sHvvMfUdwxOl7PjWR92h2ZG/UDchynRFOPzYrv8B1CdEVq5iVfuuJzYctozMgAYis5pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bcTQSc34; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4c3484268so1834121a34.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 16:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1771633146; x=1772237946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEkkf0xp3RHWH1cDZYXUxoDJ7Fv9qjiBqyJI7rOFU/M=;
        b=bcTQSc34cToTEpGu7CTBysRyFXi8EHfkV80AIqtmz1CirCGQtWnLCOSAUARoqJwWHH
         CihJNmBTQejr2UKtf3dAtwsvPeamshE4Y1G82wP7IeoAM6Ef3YjiqZ5XlYu6L3guS/xn
         kz5g8yfEXL8j2qVuoeJUO3UJpdemk7KINx5s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771633146; x=1772237946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEkkf0xp3RHWH1cDZYXUxoDJ7Fv9qjiBqyJI7rOFU/M=;
        b=o/1a4DV0vx/QWyOB7OcF3Y9P3rzzeZi10TPNseqa7hvPGUXpu2ZaL/Jur6EoPS2Mt3
         yLlSifhXo0zdUVL9tu5PPHcnDKhPnIHRI4JD2esq5hNqyU45Fh89VQ8sPHcnOzu6IXoX
         Pdr8bpOd192G7IZHSm42TtYn6itBNDiVni5qM2iDc86nEb4DsIVBzl2NP1wzKHa4pCQG
         RdAxP4GeIZ+V8x0X1T2nOc/mmEHCucvVrr2/+BZ9Bw9HB0HM3SVHWSwP7wI/4wKSZ91V
         5JgS1NyeQDHVh9hEk65QtxCGA9HzSSEIMvnn8Frb7ZreFCkn4yiBL/68Y9grKic4kj66
         ebMg==
X-Gm-Message-State: AOJu0YymzPnL5D2xmbUw6Yx77e7i2tfNLiE9/ugPqKi9K0cMlOmZp2lV
	pTxDkjU53ewSH3FI4IfElpxxun1anHDf4IZ6tNEYxSnCH3yobPQFWdT5CTbhuTei4as=
X-Gm-Gg: AZuq6aJuurWU63JbjOt5QlkjPY+6B+gLagv7wo/IcGHjrbicg8+p7pjKomtYMHqnjis
	rzLMG/UdUhJVV7C+EXRkGLPNnxK1xJjPVS6p7rMs1GnyI3CWbJS/5KR+wuVwF6FUmRPXYiAdo3P
	6v6HzG2Pg272TOjjiISTTsHyXElw8BS1J2subNiOaYRD+jnbLYZX1ZUEVZYn+I6Q307uFOxgOte
	g2oWIArBtRujLAZEfklxyfJaKbhfD2/zQMHVvsLD/DQKwE5ZJf9y8nDoEToRDExIRDsAFb43KoG
	ZKiTyKjgVj+tcynzOZbrdm1vwntz6e257M26/GjBbIRqtKBa6WykBcBbXD/p0lMN3RMnECnuZ3V
	+Zn/FxZ69rsUjpG2AnM0A3eoPvEDxcP/ww94CyUiaq2aSPTw3ZcrZk6nii0Gb/b0s6f4KmSpySa
	kuu90RwJump3loc8oRcPpVjps5bga3VlRG8gc=
X-Received: by 2002:a05:6830:6c07:b0:7cf:e4a1:8b6b with SMTP id 46e09a7af769-7d52bdf6e7fmr966627a34.4.1771633145775;
        Fri, 20 Feb 2026 16:19:05 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52d0386d2sm1050954a34.15.2026.02.20.16.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 16:19:05 -0800 (PST)
Message-ID: <a45eaddb-9e17-4e82-8a78-a1d1f6e3d735@linuxfoundation.org>
Date: Fri, 20 Feb 2026 17:19:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 00/14] Address pkey self test failures.
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Greg KH <gregkh@linuxfoundation.org>, "shuah@kernel.org" <shuah@kernel.org>
Cc: stable@vger.kernel.org, kevin.brodsky@arm.com,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 linux-kselftest@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
 <2026021904-unclothed-flavored-cdf7@gregkh>
 <e1cb6b3f-ab40-46a8-a338-70e4a18f687b@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <e1cb6b3f-ab40-46a8-a338-70e4a18f687b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-217611-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F51316B8B3
X-Rspamd-Action: no action

On 2/20/26 16:08, Harshit Mogalapalli wrote:
> Hi Greg and Shuah,
> 
> On 19/02/26 16:57, Greg KH wrote:
>>> All are clean cherry-picks. After patching the selftests the test is
>>> correctly skipped. These additional backports cleansup the code and
>>> avoids the need for conflict resolution and might help future backports.
>> Shouldn't you be always running the latest selftests on older kernels?
>> We don't always keep selftests up to date at all, as you can see here,
>> but newer selftests should ALWAYS work with older kernels.
>>
> 
> Thanks for sharing your insights on this.
> 
> Couple of problems around this, would really appreciate your guidance on this.
> 
> 1. Not all new selftests written might be correctly skipping if the feature is not supported in older kernels.

They should be skipping if a feature/configuration isn't supported.
The right approach is to fix the test to skip.

thanks,
-- Shuah


