Return-Path: <stable+bounces-241068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLcMOkvu62lHTAAAu9opvQ
	(envelope-from <stable+bounces-241068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:27:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB047463CF5
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 00:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 935013001867
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B7630DD3C;
	Fri, 24 Apr 2026 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y9JgqEeg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126DC27FD4F
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 22:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777069638; cv=none; b=U887x+tEf0+0qI5+dxNe8HEM5fVCFsiU8NS5rknyMe1EZiMD2RLYOrt2bjlGrE1lXOpEk6eO7d6/B2xXTSYzaP9lC2rsanlEYjkmhVoegM2Rv7z8g+ZVeEIs8VRV/xpck+DSBMe8StAdVqdeZncwwXUWxfA35OpTWCd/enuroXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777069638; c=relaxed/simple;
	bh=v2I4Hl5lAjs1x7TF5dc8qZL2larXyObUL1q17wd9CB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJu8YdYbD1SEvKIv3edgq5EV7zcxGgdGl7FnV/Eo9UZxJfYc38ezxM4iKZLy6qBksprwoU4hJn8E8LoNynFbKsegbShLE4H25PLkb4FDzVww8xQrb5rBJUuvInItHHLN/oQ47JZIrUtY051olJQIUX5HAuW/IECKFzHiVSfjJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y9JgqEeg; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7de4e6c5a30so1600040a34.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1777069636; x=1777674436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3q6Y1vm4CQTFoejYPRv0KuV0PQZisrV0IPlAcrZkVoA=;
        b=Y9JgqEeg6MWVdqRnfomctOiETEgYzo99wOc44RvqSEuOuBO2TPtp7aElTFj7KfBnLe
         Blf0ZerE28HAyf18/3x0U7lC/GmJqWGbF6xgaAMMASOowP4i/+pTgBKF+Hi1mJUqOg1E
         M/lEwoJkIRcAnYRxPsV37BLp3+YcsReP45DkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777069636; x=1777674436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3q6Y1vm4CQTFoejYPRv0KuV0PQZisrV0IPlAcrZkVoA=;
        b=lFFmdA1nNZRoRrYpP5yJfLGTMOIcbKT4t1JWWza31BB4E1qF55uST1DJCwIlOQi69D
         2Ev4UkhK6gUx/+Yj1Jfc1Mfzh67LMbCSWh1G3jxB9aGIedCGV436de32+GZxOX5mWjXq
         7QB8wlakLVGnYM8VV4cIEWspuqdz9bb2iWFLBGNZU1wRVzVICy79kEBfQv4BGSDTMA0n
         MJZA9dgxd+YJ7nEQmTolNachrdvDYMPt0X0sUe9K3+emKC9C0c4KUbwlcwIKnxaFyWAC
         pQLmdTmjMzR6m+WwXwkyKnw6FPswZAGiO8hfaQ89/XKv1QtBqOJ0sz2owTA7oX8YZGLj
         yurA==
X-Forwarded-Encrypted: i=1; AFNElJ+blLOv0m6+LwsEicPLp0GInZZSUXLxX3dHuwfSu6XVSLyjIOSQrm2PivdhyjAO57h0L4KIpCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYhrFxNMkIuuBCQlgpruym3fa2Y876C8jokdVqPCypSrlQtovn
	X5gxltKkxWZ4t2t10urayPwsEFdAKsN66qTBo+UI3Iqg2O6vyVT33QqQBPr3T8+1b4c=
X-Gm-Gg: AeBDieupmBiPH+46yLulOJvAxBCgflCSAabRiiNrP10HUfm/2EqiUlbydM4oIWqQiY4
	W3g6dtDF6sugYZMzNzf7xOPVmqoOiwOypvb1zYn7/fdO7E+vSrJYSIw8N/hWRftNHn3g66Jc60Z
	Hn7NMEhfNVGnxeYmCW5wG6CR0LLfMFfVFuoqFbNYpSLWVgwDs1j0xEuiCEMh5uDbA3aU9aY56Xf
	+QEG1wcbBTD88iNz7PKOpA87KG3yxym+qt43v/N9OgrccGFNzHDSVfJF1YFH0t010E7BqB2LTtm
	+K8ghOkWCUFatFIWlnwkVkHep77vm7QSBwakN6IWe4gG/wR+qhObKkZlEByLBgBXDXmgbkQdJrE
	KIgj/2zd1amZSMy3708MxGIr+E2WGgB0g5ceeXjlJzgWYSkdIapSCts+p0tpQev8L5gLKE4ONjS
	BKo3Bl4/qa+rEKzx9iGS5dv5ehpidNiJK6wUCpgRhaEw==
X-Received: by 2002:a05:6820:1f0f:b0:689:dfc8:5e39 with SMTP id 006d021491bc7-69462ef632amr20171514eaf.43.1777069636061;
        Fri, 24 Apr 2026 15:27:16 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-696148cd37dsm4585727eaf.8.2026.04.24.15.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 15:27:15 -0700 (PDT)
Message-ID: <6e384fd4-17d6-42fa-88bf-d11649b3b612@linuxfoundation.org>
Date: Fri, 24 Apr 2026 16:27:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/35] 6.12.84-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260424132411.427029259@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260424132411.427029259@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EB047463CF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-241068-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

On 4/24/26 07:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.84 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Apr 2026 13:23:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.84-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

