Return-Path: <stable+bounces-178990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C724BB49D21
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 00:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D481B25D93
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 22:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3982EDD41;
	Mon,  8 Sep 2025 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IfDkEkF7"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61902DCF4C
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371981; cv=none; b=Bml5Z6AUY/Jl3T2bo6j9kxZkVLvixCO+GLsUUkUHcnkPU8pdfzL0nu/yDVafOCWRLMjW3OqZ0n7xvQkIWhxBuTdEkbx0lfx1U0VRxWxJN87YqBtTVY+m1IX1bRUikBLmFXzDLo3sLK8lM82JyIMwip0guCPmdfheYmEYNnZk1Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371981; c=relaxed/simple;
	bh=pP64zdSLYuawWGL6M9+/rStQBf+nMDaUB0PCbB3UWLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OniQqnpVp+3utxGS+mlK4gMQ0JSJi5892LhDwlzjTLmqJFWv4/a+7hL2Gxjc1sXOymZwA1do71pA1p/xZbSuss+ATTeVprIfapKSV0uswZdTEB7OLQ0HIfKQZ9rgkNpNgIHYl42CusExvyizZ6yYEGhLVLb11KKn1mpF6lmoW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IfDkEkF7; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3f4d7feef27so31885655ab.3
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 15:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757371979; x=1757976779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x6g2ytjEOuNxZukcRm0gYsVtC6FSF5PRujJ//3LZSz4=;
        b=IfDkEkF7OEll3uY2fGp4T5b6rIe8skiIt3GTTcSV1zdxek/+Gbld8yballygVi+SWV
         LTQ46ZR9pvxhM044uoEvSSfDJ0Dp5NTGzNk2c1Ik5K+8iFCr3Bhzu7ILSJNDE2urTCp+
         YvYgdOWNf5qwbsGIRMHaUgrJANyIT0qvbnvX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757371979; x=1757976779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x6g2ytjEOuNxZukcRm0gYsVtC6FSF5PRujJ//3LZSz4=;
        b=LkQme4oPGh70/ZO7cQ5QKWsLa2jqYWNqaDEm4cCtFoT18diDzsh1nSqWAHFRIfW274
         w9AYLpmwfezMGjmsxsPQD2AnwfyaVBFxoZD8yw6WyRy1W8myTBydCxBzqHTSKPbqxK7w
         MzLYrVvxpHrO/AxpAy02vEzaw0EYOaqWohnD6ORuHKEruxdxKdBFPqrT2b6VLivZ7osB
         JtUqZ5/Msw0+umKGiYFruskUp7trl/t371hddzTY/wQnhQ2ho/IdqVeoedjl4lQ/LeAH
         kdgfejs13vw7qyrYrCxN5mw6pJlBF/DyV+Kp1yeLdg4KFgp0F/vx1GpoMzLQcrxC9W2t
         17vA==
X-Forwarded-Encrypted: i=1; AJvYcCWVc24onW0w73eCe7iA5JpBRG6iUj4pDjgNe3YoYhhd255SkLbSXsLrItqxG/By9PFSC9xHM8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfqPGABX5TIv2iBjyM6kVBomrcP4fpBMqCztAcKEpQx54YD3Cs
	IuOAuaSwJgMgpE7NR6lI/ajM2H/QxpN+y3iw27uOxkidpLYeg3PDHer6T+BAsY/MXSg=
X-Gm-Gg: ASbGncvDFKsNiWycY4/jz6I2izSFmtY6wU4XsKyo0JZ/B3MfQtAbJ7Hae4dvVVmJ7q/
	QxHE2dXkIH4K6i6amXc27RpNog8W9xKV0GHK/58gxmUGheABJ7WPhQKM7m5lROkgVYXb0vOELD1
	Cf88WizUJ9eZhBp5wvLzKnIPWWPeHgN0nJe1NXXeIRVVralxVluwEiSUWdHxtdG5spAW3E1EJJY
	+tf7ljJkl4eNtttLhKHkdiPOQpOl55eVNOMmKAPmNZejdSlzZqgcX5EXta9+vzLrL2Po4i6ku63
	VhzWL1U5DIYWGFbhlqfO5I6MtIFkEdk6dUyY2uZMuExRSYWYtXCHX6ELW34UCjyZ/JnuOh2XCRV
	7SXY3o6BwiXcqp1jc+WnvcdTxwTkLUIwUa5O6BJu277z9XQ==
X-Google-Smtp-Source: AGHT+IGHlfDmvkZr5EsWyqNrB2Jpq9AoMeyzzheU0TqJZfe/YG8cZIrPRn1JB8n7L66+uFRG4iz1qw==
X-Received: by 2002:a05:6e02:f90:b0:3fe:fa06:bfd6 with SMTP id e9e14a558f8ab-3fefa06bfffmr93467105ab.18.1757371978863;
        Mon, 08 Sep 2025 15:52:58 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f0d594fsm9224126173.23.2025.09.08.15.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 15:52:58 -0700 (PDT)
Message-ID: <e413e58b-f09d-415e-891e-832b58be1533@linuxfoundation.org>
Date: Mon, 8 Sep 2025 16:52:57 -0600
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
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250907195603.394640159@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250907195603.394640159@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 13:57, Greg Kroah-Hartman wrote:
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
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

