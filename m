Return-Path: <stable+bounces-230019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEZLG8q6wWm/UwQAu9opvQ
	(envelope-from <stable+bounces-230019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:12:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E29852FE1DC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 23:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DACCC3056660
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 22:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7494382294;
	Mon, 23 Mar 2026 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QIO2NDmD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105C37FF64
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303793; cv=none; b=YWxO9qDu4AZkcGcW5oUsuoxlRbvXluu7HGG1Lw2KVREVUoxE84fYqAkaTF7SKUpCFiJmTDGfNb5aA682yJb0JHHz8GQkC+ra9COz3Zbntqb0zmJtw0Nrp8MyRn/QT3WWtclHc69+qtJiTRg71LEUA69mN/5ndYEDaRSgutg0Cxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303793; c=relaxed/simple;
	bh=xtdd+vLrZJR3aJKGHFCK11d8tfWyTb9aPILZwHJZiuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=olmNdOMxbhId/5p2KovOr0PVADWCtXACveVx2aX5Zb6gzmGTVMb1tH/u3zbngBQVko5l/faqRCSJ7WWkohkujo8ebcyCXnK89NHH/43Mj7cxdEHBkkzudWBgvaHU2rAEqbt2xr6MoIdsATw6EVAr2Wd1otiqYhpumljZyOjgITU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QIO2NDmD; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4c383f2fcso3881041a34.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 15:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774303790; x=1774908590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPeRLxGrOuIO8TRxpkoeoYAWzJCSPoOx0rDLujnGo4U=;
        b=QIO2NDmDB7gzMA47r7E+0vfPSBkhNrJxLTfOwqxCRDCBYRr0Zb8ZqYnd4DQOGo8KOF
         oQfAPVJIELvL/zYefcBC7HNlEYIRLwes6vtA1Gr2D9ELzj8QOeFf0eM6MfUHi14XU0c3
         QsVu1dQJPZ38tK2OOn+u4hNKFPFMNTPClSr0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774303790; x=1774908590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPeRLxGrOuIO8TRxpkoeoYAWzJCSPoOx0rDLujnGo4U=;
        b=gTczBosH/TDPT01mcCfcnqbOpR/xvlsLJ+jJt4vQVvdpZnbaCXELd1jlUO+wg2AmBL
         h8R4Ae/QGlkv1ri0CoU/Zy/X9BcFZUFiJop82KGztnzAMDIyEUaHlpI5hSyLSPjg67sE
         YfCCzWrby5bMlf0UabU6rD/SYv0YeRBh/pTV7ZfOU7V8ZKJNeP/ccysg8/SNLVz/O0Gh
         5RMBAKRzjrfTxJcf+SdFdg19as75e0wu0viIwDuvYXl/L9dxevVbbxZTF6JPX2WzP621
         OD2KnolxKzZVwg5wsI5zHivxPsaZln/5E2QTlvex/449X3aPgiSUDS+XjuJf929cGLpl
         wbjA==
X-Forwarded-Encrypted: i=1; AJvYcCVjanaY57MDJm7lA6W4DOrPn3lYnWD3EmOjcmsA3mgK0pM7ZFSRUOj6Cqs+KHKYgkM2L2GXF7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6jzAF/X8ji28CbxF3ch23EaEtlOLnfoiDxZB4ivm/56VRFgBQ
	wQXGGqR8TSzBAlutjhbeKeurV+v+nPaP4yr7xkZAfu42gZ95oqyIm5VgQQrAonfy4rA=
X-Gm-Gg: ATEYQzyLF47Pw33/d8U/Yp8KqgdXyAmk8pJ1Aegc+BRx4bDEk1ybNNAq5RGqYln6lMb
	mJRYIZRWctJLzJ6y1AtI3DKIT7SfsaH2dswny/FOmpc8Stqbc6Pqa/OZoFNC/yFS/G/YvkvOFmz
	JmiHhWM/GIHxdkduhBPR9I4gEoIw3VTnPXnBaZpVo9YMD8usgNax3aIRHIyVN7tS5KSlNQN8HHM
	jduHpVRVte5ZZwZymAVp8MAGN+7BkQXhSwc6+LMz5TUI6MYren9K7/enkxrVvldJkaMGu3XKkgt
	2bAVy1GdJ9OeJzLmouE5zu2tfmRLt2Iil2REDB7aQ6gv2pR2Ox1vDmJqYIp4Hjdnue1Q79baoJc
	tNMapD0IkFjgsxmml4MfttrBip+d36VdhOZRbHWSd+gWCLovPnhzVpchEZw46EAPDURmz37xxw0
	dPPg/oOtm9pnOy1KAfntmgMDn8ZquBhy+jaoo=
X-Received: by 2002:a05:6830:368c:b0:7d7:e57a:bcd with SMTP id 46e09a7af769-7d7eaf765bfmr9193488a34.20.1774303790439;
        Mon, 23 Mar 2026 15:09:50 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7fbee2c6dsm7953910a34.1.2026.03.23.15.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 15:09:49 -0700 (PDT)
Message-ID: <8e78c25f-6125-4574-84db-ce054b36c01a@linuxfoundation.org>
Date: Mon, 23 Mar 2026 16:09:47 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/460] 6.12.78-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-230019-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E29852FE1DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 07:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.78 release.
> There are 460 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.78-rc1.gz
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


