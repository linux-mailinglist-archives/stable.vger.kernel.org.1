Return-Path: <stable+bounces-232594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFc+AoZIzGmmSAYAu9opvQ
	(envelope-from <stable+bounces-232594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:19:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8233725BA
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 00:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C8F53013AA4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 22:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDD3346AD7;
	Tue, 31 Mar 2026 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnObYfhQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F35E45BD67
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 22:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774995504; cv=none; b=gMq9JoNTTD4n9/KvMIuVRxdvHCOPU7Vlv51HIuCSkaipGoLgYKnEAYl7/zPsVsqf6FHL83Q3svbgPYOLUDwXT8DdIrpYfTg3JmBLi3fN2KkMbw+zgThxT2JGxjmaymGJ7qIgX06iN4brugc4udbfwpaPSGZzGCIwaef3j4aVDis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774995504; c=relaxed/simple;
	bh=RqMy7hc4oJQyN/p3kXm3qtwJtVNL3ksJsayaFO/NtSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t8KfmyTY/13plnAxmaCQqiA85Hus9836HLUye81+Csdgm7+avI8i/W/HH+MW+U1DjDvBwY++yaNRzYirzuwJce+CItp2+ApkfgqrWkDvxfxi0kRgHk/pyfGASdrt9IwOLS+dnlaqkbuCEEC6jmCX5nfiTfTN952epng+WQpQA4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnObYfhQ; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c7e5f38b37so1706480eec.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774995502; x=1775600302; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RB8nQ5tFjE9rzgP0R+hOL7agBJY75yKnaHcF1wxXdsk=;
        b=JnObYfhQ+1KWJFjW3rQ7IwMZif6hxF1U2cZ5KXo2T21qCUZ2/D/+TSMF+IgozIrC/a
         kvjBjSC7SuVTt0kGsYrMT8PXQAjnSSfz1/oPRiCcupMHmKuvNW/FAOXQJQxfq1yzviQn
         84SP9FYKUmuyM5u1eXUX/LNlJyD/TOdaumVmaQnm+obNyZgKbUm5aR9Qw/ONaGXyYUku
         1Y8Wm0nh9L02w4cMdY+PrLqTY2+D9OkJMg9xemNSbv0np5CguLXhvOxBzggqzAi7+k+t
         7LXfF3eQy40LeqU5ZMWpEtql+CjYByqf8RbcfU8LTixsPhnEMOYXc1C2ls9NQr0uvCHT
         c5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774995502; x=1775600302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RB8nQ5tFjE9rzgP0R+hOL7agBJY75yKnaHcF1wxXdsk=;
        b=se+MVbEpkNBl8eet7tE/4HhPhdIf06w1/3LIqVeNWoyh0LSML7e8YQPFd09BG76Wh0
         fQjU1PUzz5Ngu3n/rQLQ/Ku3enT0o5dj8TynYTE+8t2mpm11HQQLilMI/so73TyOE6ua
         LeibTjUhipzuBhjDKgrVHLXDfSVMO87Ni0UyrwIo8Le6FB+6xOV+yxsN/3K1rEcJw6KA
         6+NJxAE6R61S9cmGLGjyGNmJ7IJAH6Nz1PLB7z/YInfg7cm9/1dKPkmpsYi4WGR30RJm
         2dk8gEMiMkOQheSDvYhV5DuNVWupXzRg4FpC/1KJyuXJYqa4ms1YHcH5mplk4Oz8mlhc
         UIxg==
X-Forwarded-Encrypted: i=1; AJvYcCXcYVpFl76nofYqxOv0hSWfNyI5QjA/K+uEdwNktLtjcwh95OkUrPK7O2bB3Vb/JZij52LbTNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTF4LcwhCI+DglWGxvj6gDdOcAdrWltJ2bMs7WFDJ8a/P7sw6x
	bI/W0Xe3Row/EsGEygG/s1CNge0NnCQTf0vFanEULcES5XyhKO9qkhVZ
X-Gm-Gg: ATEYQzzEtdPZiFNlv5IGQl/wtnSScGvhRhRrCERp0/Xz+Gp2wCplLPe3Erj7GmuxCbn
	DmH0JvV1c9TLxMo3AwFZv6ovdVMfBmjJ2nDRgdaYD4937vHzFyIruHj+ryjU7J/pdp9/etXqe3Q
	Xn5x31wUeitvTo/3EFs0f1dakf2LmF87R+kdvQI2ErIrS+XehLyXzTTUaieiIiEbbIvZkOeMu1T
	rQXT1A/fszUTcnHMzIRzgQV+IEl/8Dwl1q3RcEHmzmmnqtFnY15OH10YeJLQcIq7m6WCxcp3UXD
	F92lDODpBXO93nUBDiRtD3gDodVXgoIKiXRHg0hwF3jqO1qv5c3bOxAL51vSheyQKzjazPi+zj0
	zbgWL8p4dvSZMrdi1J2W4AWo3Bte2ThlLW9ZcYKsvnPjw9TGzntYxrecSiRMc3QDxXOXhCsp1LO
	dgCWb2owUJhT5L0QdqhNSmcFCdbTH/4E0oFlzu9Jx5Cba9vgUmSA==
X-Received: by 2002:a05:7300:7252:b0:2c1:2706:b41c with SMTP id 5a478bee46e88-2c9307905efmr590526eec.6.1774995502149;
        Tue, 31 Mar 2026 15:18:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b2c57sm11894891eec.16.2026.03.31.15.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 15:18:21 -0700 (PDT)
Message-ID: <200019ee-d40a-414f-9dfb-c3fcbdbed969@gmail.com>
Date: Tue, 31 Mar 2026 15:18:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260331161758.909578033@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232594-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E8233725BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 09:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.11 release.
> There are 342 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf still fails to build for arm64 this was reported bck in 6.19.7. Can 
you revert b56111d7a4642ea7ef776ae97ecb1dd2724a1503 ("perf jevents: 
Handle deleted JSONS in out of source builds")?

Thanks!
-- 
Florian

