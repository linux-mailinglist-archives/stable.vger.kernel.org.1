Return-Path: <stable+bounces-222404-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KE4FX+7o2m1KwUAu9opvQ
	(envelope-from <stable+bounces-222404-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 05:07:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C5D1CE7AD
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 05:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4582E3031CDD
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 04:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55A4316189;
	Sun,  1 Mar 2026 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdKR2dMM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16330B51E
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 04:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772338031; cv=none; b=CCwXCdSaSK1cPabnaoT7sU4JUIjyfo4tpThmFB+rYH2Lf/eEMzY9yGKSFa0vLHuKsXp2L+rn7o+KOBk4SlmrwYwTJ8Df3VotvD0DpkmGK8piLQUGRmLRxwrL5AhD+zEWZVLk9TSM3nQE+7jXsL6gpTiP1/EBmKcQIgaEUrPyJ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772338031; c=relaxed/simple;
	bh=EYxmr8Jbw3kVwqoL+nUT9QWp1jdoclMtq8RqTvzU2H4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F47y2L0zTkRJtIsWq44q9p4wAx/XFv+2R8P0yqXyuQg5e8N6xNGZgzg9Xv+wYwUMYHW+n+CR9RuwIl2queaEWj/oZ5Pg7AhesX0/Iq6ontH8fN6FesZaoE/f+juJzrIh+yrKq0YfPZvpWJqZEUlSfzvoUvrCn+asmPEcwqWoGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdKR2dMM; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5069df1de6fso29855861cf.3
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 20:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772338028; x=1772942828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q28wmCKRqkklbJWozqSDdiGgjBk1Ghyvv66vMEss8aA=;
        b=mdKR2dMMOScqCfmuaIS5pT4iix77e1mOK4RGzgEPnTD9d3R3iHFt8n0OLISvs5vOtu
         TIMYnjlz8+BZPJ0jJLFB/FvrXV+FjJQDnwFXD3QaixEMmfIxPsbGjcSK2dkbLSeY3BF6
         YhHVJs9Wdr2A+pj4zfdusmy60GFYclNcfcLzI5/oaecvjnQoNo7jRTZrzR4CeKmzXC+M
         Us6juawxAneizwfI9YkU2u6YFi3OqzsuiEUNa2rvvLTljW1wau/EVWGGutSc3OpeieOs
         L4M9P2/uI3rDzvmCJBaIFliC+4Zf9tbAQNtCF6D8eiXlPbr4jxSEL59yufVwt7+WFGPC
         9FWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772338028; x=1772942828;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q28wmCKRqkklbJWozqSDdiGgjBk1Ghyvv66vMEss8aA=;
        b=wX0GIMNAViRhaBDCUzQOu0j1jZJFddseaQ3YbZEZGXX3rn8CZ1NqvFJZseqOoaRt0+
         S1ho5MGPv/P0KshcOHnfVpQdd4I74Oe+T0XC10G84v28vo17r/HmOXZo9c8Io9Ytw+o0
         VrWtyhRRQGEEze53LhZlf13XQ7bUxcx+Psw5UvNAyPZJZzX/sytPhxKmZvsxLBfP4TTi
         gr+nIcWZZ8jowiLwm2s87U+B7tb5WlVjMaomO9H/DXAOsyEFoKsuWvLQs5Yc16kdju0U
         5FVvhOqUUIhS/bev0dc6l6ps2uslhLDUYzIAHUb6JTKH4iNrto0BgQjoOz4AcCWfydjj
         KegA==
X-Forwarded-Encrypted: i=1; AJvYcCXgL0b9C4s+VyoeTw2lnOGmQLsGjMxou3OPlYslu8Qr0Fim7m/rxDiXn3F/gyJ5qP9bNLADZSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCPgYzgvscj/cX6vJrgx52QtkWooAt9IamSbVz4GZ7gJkIOM0f
	AkJJsCJ2TCK2kzhx3ubbxD3dk2xyA4QlDjNhUOnPrjzkGXYQSeV08IE=
X-Gm-Gg: ATEYQzwMVR0dbjYBRhd3XsV3Fwh4Q+gz5M4vuBADvm/bJQ+23Cf82oqt7Zs57doOph2
	FzXYD0gX8B+DUNm1CRD6oUzi0F+bncF20HBQQwymrB5rrlnfSMoFPqTw6NO4Le1NVaWQH15GSN0
	HQVawz4rmOBd9vNM7WML7NZdr4oYCCLWhTUEnCvr0Qcmy/gmVb7j1IVzfDilms+kVmxCsT33Yvy
	tnRSZEQDqDv4a0NhTiejtDaM8+XQ5xQmGOfqoiFTlG2Z1kFja0MarEsm8KinOdEU9Z+7yg7xnaT
	U+1jqmic7448SYoxNocdfOt4bm/u7Ra27Yi1EzVILaF4SXzKGbwiTFemn5jdOX/Lw4T6TLYMRVR
	fbOV7Gq9wsl7zuz0b+fyx1zvz1S9Vs46l6BPUvpUhA7oe+651Kl/03BS8Q78fj8GDfDKR4Hituv
	zahwew50ZLTLZ69TlSXNB/IzX8ijerN+PnnOt+6P8WR/LGg4MtJpe9hIMNqY7cwQ==
X-Received: by 2002:a05:622a:3c7:b0:4ee:1dd0:5a47 with SMTP id d75a77b69052e-507528ed5d4mr105292761cf.76.1772338028399;
        Sat, 28 Feb 2026 20:07:08 -0800 (PST)
Received: from [120.7.1.23] (135-23-93-252.cpe.pppoe.ca. [135.23.93.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50744acf0desm78520411cf.23.2026.02.28.20.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 20:07:08 -0800 (PST)
Subject: Re: [PATCH 5.10 000/147] 5.10.252-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260228181731.1605473-1-sashal@kernel.org>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <ec058901-bee9-23d0-f41a-0cb852791c0a@gmail.com>
Date: Sat, 28 Feb 2026 23:07:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260228181731.1605473-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222404-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[terraluna977@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1C5D1CE7AD
X-Rspamd-Action: no action

Sasha Levin wrote:
> This is the start of the stable review cycle for the 5.10.252 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Mar  2 06:17:30 PM UTC 2026.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.10.y&id2=v5.10.251
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
>
Built and booted on an i386 device OK. No problems noticed in dmesg.

Tested-by: Woody Suwalski <terraluna977@gmail.com>

I still vote for a unified patch rather then a series of patches.
The unified patch can be applied to a source tree and then reversed.
With series of patches it will fail if 2 patches are touching the same 
area of a file.

In my setup I first do a dry-run-apply patch, and it has failed with the 
current 5.10.252-rc1 series.

Yes, git would have worked as well, however copying the patch to a build 
machine with a ready src tree is much faster ;-)

Thanks, Woody

