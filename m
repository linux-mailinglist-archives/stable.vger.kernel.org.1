Return-Path: <stable+bounces-178836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498E2B482A2
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 04:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0691617C74A
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 02:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA21D1EA7EC;
	Mon,  8 Sep 2025 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9AfbPG1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338FD1F151C;
	Mon,  8 Sep 2025 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757298926; cv=none; b=oFrYRzXM77aPnyyFXPlvP/8s+2T2xnpuVURlLnLtv2+MR1/1eLaeMVbrxFQjfcza98rCMVPrMqJPR6/bboRtTwn4jxCOmk7wGzJna7ugwhq0S4sbp6B+QsuU+bbE/K2xoTVnwtdwei4SE600Hf8+/7QjxApIUter929NSqI9hLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757298926; c=relaxed/simple;
	bh=VSS6ir5H1rLcgyOKz27cb1Gwqh9thNcgwB96WeHqhIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oXE5jEk6au/kn4WPdqeSI+oZXgOoE8+aQGNGH75tUNaWL8epShNtp+1ZVX1LcSG51G5iwgN5Kxa8gYNJvEAlqdJHt2ZM1TN0Oh/iIEHS9qck+LiQjp6+xdpuW9KuLfC12tqwNdVGn/Ygb21Qji7Yz5YNVmA4qZzHc/6slSqx79Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9AfbPG1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77264a94031so2699333b3a.2;
        Sun, 07 Sep 2025 19:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757298924; x=1757903724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=id+ytg1Zw34+FuI6CdCcR1u66CDbUUTObLJkdajO1hU=;
        b=E9AfbPG19DS/grhCJpq7eYbwj30mktX/1MLk6Bkqb3QiXOdoe7jBDVPhd/sDucjoh8
         ClCJfGptt+7imeiT69WrLi0i3OGj9KaaE2Rvk5Rx0jV41KEwP7GiWbUJdwXo0weCMVxm
         ZLleeVDhlcDU2yxgqO0gUNduqJnNgwD761QRXqH7K10UcCaakTlXPHRmjQbPiS5OxMRj
         v6nUSW6qmaV39SRV/27h2YMsTJR8X9Beqe/V8CcP5P1WPttcO0VYvRRpdOiqDN8wAU/Q
         aBmTPwNRvjiu0VasUV86jAxFAhyf1qwbdtJ8OtEVg0VXulCwzAkaJy6L4EnRDSh1Wzlx
         dD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757298924; x=1757903724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=id+ytg1Zw34+FuI6CdCcR1u66CDbUUTObLJkdajO1hU=;
        b=GvyRTPVbFSrTrWF2YrJwIlMQii6NlGVmTUCSaLTIZGxfIoNlirI+r1G+BTwNw7Zq0F
         GQb+Ym8ciaaePMf8GFzSsXaDbKBSkivEVMUdv+xZVRMsnoTQOzRR1T/wjLJitSxht1sJ
         vejaDfclwfaTpDqaPi5yPDscQlSeWsxFJHr99NN5riXWfezckAZWo5myB7iuUK3Eppvq
         eID8ZY4eudLwnh3lWUyEypH7f5XbCfwgW2tfgYHmciyEzFHU+RdYgQosEWaG0ULR+b57
         BnR8magJd+Ig+5XZtJ4v2ntkceAQ4/2Q+NivQIYYgVwJTg74gfs1uxo8nV1rW77acvMV
         4Cbw==
X-Forwarded-Encrypted: i=1; AJvYcCU3abbCa5YJFb+pyLts3VzixmLSga2cHD88l6ppUNRuYOtHeICymcVV/I6VK4lK4PgscbxqGuyF@vger.kernel.org, AJvYcCVynxOoTZ3B1WxXHaDNb124QeHCzLFU0/0xRraF+5odKyBfpwRnB7qQNwLiRpMz740taGXTnK316EtcTuc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy5gq4VRlUDA35b8i97MVYEFE4HFBgUNDqRjsF8v7cSZB4i4Sl
	dUxChYzLrUfV54WINLFcrS7lR4LEPoLPkiG5i/7XZ2NvUMHRmyfLAe52
X-Gm-Gg: ASbGncs+pBRRdmJWvggLDB4WFovLhVzq4FcRoWJqwxylKVojSem5KsYx7A2KdU1xXTd
	S2545Qf5Dpzu3ptiVZQKA/PBlxBc6QiWWABzomEv5FxWvCe0j1nmkJwCnFK4AIgQiFmrNfvYdoL
	X+LstqLRw1CwNyl1pRRgzqcQ43QY6F+of6NTB2BKnY/f17PnYTOacnKv1ELGl51s+bOJ5cTi8Uz
	3XeR+TxOS2ELDxOGgrrKG1yUHBm8UsNu8ig6eL5UGfL9mI+TTVB3uzk6zhuWXrjd6Y+iadJTXY5
	W9Wr1ENa3jVLf+onGuS9WBP15cc/EHO87Q27Nti1Ou52HOlO93J48VkwidR7GLULQ3qxtVq23Ys
	yFzKOyG7+8+myZZARwqeTVC3U7ZTAweMmGVud2PbZogC2L5P8fdsv84Y2VBeclJpN
X-Google-Smtp-Source: AGHT+IGpdUunw0Gu8o9Wejzox61260OWqaxdo0CyYNFeV00m/Tjhkk84xkW8KDorPix6AVFyzFNvaw==
X-Received: by 2002:a05:6a00:1a8f:b0:771:fab2:83ca with SMTP id d2e1a72fcca58-7742dc9e36fmr7998415b3a.4.1757298924379;
        Sun, 07 Sep 2025 19:35:24 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77267a225e6sm18193577b3a.94.2025.09.07.19.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 19:35:23 -0700 (PDT)
Message-ID: <ea3bafcb-ab3c-460d-9c27-b2d2171912e1@gmail.com>
Date: Sun, 7 Sep 2025 19:35:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/64] 5.15.192-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250907195603.394640159@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250907195603.394640159@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/7/2025 12:57 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.192 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.192-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


