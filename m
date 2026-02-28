Return-Path: <stable+bounces-221227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APUJEA5po2mACgUAu9opvQ
	(envelope-from <stable+bounces-221227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 23:15:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACB71C96BC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 23:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C89530547E9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA9E3B961E;
	Sat, 28 Feb 2026 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UA3D77Se"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1D394470
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772316842; cv=none; b=b4WAsA7V93zNEQ/KD+ahQnv46y9ROWhcSRMyXzXkHuoItqMyp/nPdrkKLJTV9YTW87UsMAKT65lCygFr1cqFdqTqDL7nXkF4F4Zw4Ox4SB8baepYtdCg5k3LfcZYx3DxKyj6XX+rJlittGsCVxyI5vasiKrcT4aRKK7rXDz114Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772316842; c=relaxed/simple;
	bh=YmaOwhLufLLr2rHqj3svb39rppAI7BngrthP8I4DUSE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=N9tXTsG5v086fAMgnyZv6JDBSUZgZQ4kVoPpuTN+0AUVRNSjOED2JLJkclrNs/eZ4uQ7A3fOshzxsNAYTT7dhx/vGAR0laPaDvyYrHo6XW0hmMcLwPro/MbFLnQl541bAXuUAVpJo1P93+KBlSvmD9dFZOTmQZhIPkQsn/6J9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UA3D77Se; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb4136d865so423781185a.1
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 14:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772316840; x=1772921640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nr1P/0C2nV683CJOfzLd7UkpSzK419t46a/I54eghlk=;
        b=UA3D77SewpfMhg2GEoeTRr4f+OkEd+NNfqj3pYgkfHHn6wltQDhNGy9i0blzPKl64T
         NS7SH92UpKMhxhPvFgRfd8sbdLyzo9L7vLD/SznHs5eYnojw1yKZKo80K+8xNA4nS/0q
         cLbZM9hj0w+qBP8cl9srcfTV+qDE8yJfm6s3uDfq3JZK4cOwuAkPXGwyoapydNICKABE
         ifrHFjcw4YtfOBDu42qeMR2TXcymBzPHDMN0RoYPC87Enba9vo5VD/WZfazbhole8EpE
         9DFiWSDdjc/I+zU4FAW0LFQEUG++VjlPLITkT76E4IFvlrTN6TOlIiYZ98cyWBxu1pTK
         7fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772316840; x=1772921640;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nr1P/0C2nV683CJOfzLd7UkpSzK419t46a/I54eghlk=;
        b=Wjat9Q7GZIYnl7Ph2Jegyi0/0Cjl+QR6mOL7SwYDoa4YzMYo23YpzGrexajuL9CXC6
         X1+k+4UqmG0LINHaox4BqjVbNpr6RiKlNbn8NmzJz+q2s8/3kk8p6RmNRL2RMtjPiGmX
         Mb5RdiHA3PY1RGyBR5Qnhr3ihhdszjxr7vY0tX/BMFOeFepdqK8OyfuIEm0Jvdy8JuiM
         LJRpYxZnnGnoq4xVoc3N+TbY8AyfSlTsoK5J9W/vAU0L0zY9FMxsds2nIiCmAw8F0OzW
         wxwc5IbO7PXvO4/lQq+/0rs/vA4cE5kTqfgypyZKkh040uRF5YmLq7De8Y74Q3ObgzdT
         RfaA==
X-Forwarded-Encrypted: i=1; AJvYcCWasn+QM7VxkDdHyj9JO+73JZypTcfHvWJWtl8Qk99j6KxIvO2EDo9gy5xokvM/Ybuk0LYTD8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGdAzfUQmtHAikH9decKP8Zg7luYhPWNxijAa+KsWWU97i6xvS
	H+Y4Z0YbVJtsP1UPscfj9VqbMPRMLvRjDi9OgH7tlVxPSSSXGbGejVY=
X-Gm-Gg: ATEYQzyNJxzAhILys7lUdhVg3HD6wURLH8TXJK4wDQsG384mYQRKwKy3r0xBT7ZuDlw
	vATzrAPHAc5EGlGIBIMWj1wxPoy8G7ajUCAWlMkEuLeheIBjbNSF2R51rODHoc39ajbwatYXCFV
	dq7jxJnOgcXb1sMX9B22PBe2HBnpe+NXpXKPOuv7ksg8PQQrJ9OTQMlUkj9aXUxfthJkYf+WLbX
	Kquyqzt6BlVNsp3BuJT5BA5uXIYGbEGMKxI8/CUg7Are9qBHwO3hCeRE9bSCYwyatMIRgAmLnca
	5byI+EFTE0/aZOiefBrO78Ptpk0GMv1X80pd1HwbxcFRZ19Xsi/rW88WdUgwPI0VS9mlSBK+3s4
	AW/7Zg4sChOoVvOlN56o1h7rbmPJfTnaxds/sT4jrIaddJ4So8beF05VX8GYaEkG1ij70z1i0cs
	iCYGesDFvIB4VQqNzS96hevuBwUjYrsY7LrIIMnYr58ueUyKUmmHo=
X-Received: by 2002:a05:620a:7118:b0:8cb:4059:a90d with SMTP id af79cd13be357-8cbc8e50bf3mr964752285a.38.1772316839779;
        Sat, 28 Feb 2026 14:13:59 -0800 (PST)
Received: from [120.7.1.23] (135-23-93-252.cpe.pppoe.ca. [135.23.93.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf68a0fbsm778891485a.22.2026.02.28.14.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 14:13:59 -0800 (PST)
Subject: Re: [PATCH 6.19 000/844] 6.19.6-rc1 review
To: Ronald Warsow <rwarsow@gmx.de>, Sasha Levin <sashal@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260228173244.1509663-1-sashal@kernel.org>
 <601576c7-970a-4e9d-af5e-c818740be8e8@gmx.de>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <879487cc-c667-8cc6-4775-02c7de3b8c27@gmail.com>
Date: Sat, 28 Feb 2026 17:13:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <601576c7-970a-4e9d-af5e-c818740be8e8@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221227-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[terraluna977@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8ACB71C96BC
X-Rspamd-Action: no action

Ronald Warsow wrote:
> On 28.02.26 18:18, Sasha Levin wrote:
>>
>> This is the start of the stable review cycle for the 6.19.6 release.
>> There are 844 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Mon Mar  2 05:32:25 PM UTC 2026.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.19.y&id2=v6.19.5
>> or in the git tree and branch at:
>> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git 
>> linux-6.19.y
>> and the diffstat can be found below.
>>
>
> It would be nice to have a download link to an patch-*.gz what Greg 
> usually provides.
>
> ron
>
I second this request. Trying to setup a build for  5.10.252-rc1 was 
tricky...
We need something similar to

https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.251-rc1.gz

Thanks, Woody


