Return-Path: <stable+bounces-125623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD500A6A0B5
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 08:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381FA189F30F
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F061E2611;
	Thu, 20 Mar 2025 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6gOijAM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43511DE2CD
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456954; cv=none; b=uXsSFETIiQ4z8pYOMb+q3IDr9HdVuUCEIngenuLSVRq8JJa7jr6Lc/Gcy9EIjzJx+iAEdUyNnSNap0egWXxHPAKSMTZT7A/sF2rx+JSL7sWd6HF0M308PzEnPDeNJxTIMQWdWSfpgIIa9G371x6QdxcPtgUgYjhy3dREn8qoC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456954; c=relaxed/simple;
	bh=yRlwn33uFCo1WzUWKINkmhf7Do4XLLhrmvg41jjhsxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJkviM57xYSQScUIhyD3H3/SO1VGNMOXpYViHzbFpAcAghig8EbtMhD7tsny6yPHqNO/QfmlEvK+zKvEqy/OaAyX2OKcn86ep5KG3PmARRE6PwkMu7LONQAZ9aD1FRGfo6/KTVKmBJzzQ7VUKOG5e1OkGo1jlxl/nEGzlgCu6gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6gOijAM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394036c0efso2010315e9.2
        for <stable@vger.kernel.org>; Thu, 20 Mar 2025 00:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742456951; x=1743061751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ws2Zy20FmJpDTTN7PoL/aNyEtehNiavqFzYGdZ5kc1k=;
        b=V6gOijAML86EOvLGZiixmekLK0yFQQVD3dtsKP0vtljdMALVOcYTdozjFrnk8TyJwb
         4MIVo14TDZ1hWpUBQWvbwjfEK4DqeThjZfoTntIMlw3xw2iB5KGYPYGUnlqvs6JalcOv
         XbrbG9EaEw2tk6sKkHQgUp6yIpTTp/wHDNfMIylaANJg4ytZp5/TgL9+tLfdJoBohd/Q
         PDcPN+1Rtcrz8HimYJgmt971IWtrK7f4AwYVWASOWDDrenTuMcaGqqR2dTUUYqF1LrfR
         WhTocKYTA/bEi1px+MXkxkzcNTg/2p8TphmXV9dCWKXNLgK7Cn2sO+yyov+pOBVrZxeO
         VBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742456951; x=1743061751;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ws2Zy20FmJpDTTN7PoL/aNyEtehNiavqFzYGdZ5kc1k=;
        b=mtQvGP1MJS+GX/agN2oZXx4AF8UV8aPtS1cnKgG38/itx7cwzGlxmLg2Tjv8zu/RHA
         mQlfp80OEintXyO4yI5wKf9Wwp+OKG24gdRYV19kETAwoD5ivnMLCGwHp5C7QX/05nsb
         IAeLqJ9cw+HCDCBYdoyIRv9zLXFqus5PD5bJd3NK4/AvWsF/jthTwPuCDE7vptGWxWS7
         YGLOE00Xzy4nT9uOr8tq7jFjl2Ay/ei9HIMs/QQuBBjLVT1AjVCcz0UiEAg/Ifc/IP0+
         Ir5QrP94u9zB1acMP8IY1ZvpKCXosoaZTXyA+cVfcLl1ZbsbMYSBZu00nXCH5LMNkit9
         ccFw==
X-Gm-Message-State: AOJu0Yw40HDGtNJi2kuX4ve1hzfexHiDIYJVDqg+tiW5jSTF5XJYI6x9
	CV3i0NajUBcgDJ7hBn5VAn/Cocm0RFgPyrKwdpVf8h0Hu3fjP6xi3bosXA==
X-Gm-Gg: ASbGnctu1uvDsIgh5AsmU9jpV4p9yPeJgZRBsnxSdyoiEfrZETDVNYoTWfWLsc5beiZ
	bBxRoTDAyY2pGRmCY2tekHhPbLIACezxn5Ce2Y3NVpUbzOv0Zuk7FXyoYccjvWGFCs6Cy8pamCW
	i7MqmCl4afA34GpXseyBRfh4wMIZEDM7GqYAbEJrAFdKZasYZkW+XnwyfkCR+kATulcD94QyDld
	gXX/kx9tiD3LRQMHnQ+itLEsvKogA0p+3pNAIUYIYNgUXrH0AZ2j2Et29MQwmCsNKV1V6xuw6Q3
	b4YSnd+cKQCd6tWImPuOxyUf+ZuZgMI9MV/VOgqZO62RRxkq4L9P0lJZfRwS3dsYt4yx7GTcuxT
	1z5v8YzpcH38vt0J8SrEfG+befqQ=
X-Google-Smtp-Source: AGHT+IH+6TOIh3yGIwGiDxScLZLDrt5LEp15vryvXSV/7bzPMR+dyIfoLNFXNIg4iF0tI4JWMv+IJA==
X-Received: by 2002:a05:600c:5248:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-43d495893d4mr15878585e9.23.1742456950735;
        Thu, 20 Mar 2025 00:49:10 -0700 (PDT)
Received: from [192.168.10.194] (net-188-216-175-96.cust.vodafonedsl.it. [188.216.175.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f6befesm39885735e9.25.2025.03.20.00.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 00:49:10 -0700 (PDT)
Message-ID: <5e260035-1f1b-4444-b3b8-1b5757e5ed08@gmail.com>
Date: Thu, 20 Mar 2025 08:49:09 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: mt7921e unable to change power state from d3cold to
 d0 - 6.12.x broken, past LTS 6.6.x works
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Linux Regressions <regressions@lists.linux.dev>
References: <415e7c31-1e8d-499b-911e-33569c29ebe0@gmail.com>
 <2025031923-rocklike-unbitten-9e90@gregkh>
Content-Language: en-US, it-IT
From: Sergio Callegari <sergio.callegari@gmail.com>
In-Reply-To: <2025031923-rocklike-unbitten-9e90@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Might be able to test on the distro built kernels that basically trace 
the releases and stable point releases. This should start helping 
bracketing the problem a bit better as a starter. But it is going to 
take a lot of time, since the issue happens when the machine fails to 
get out of hibernation, that is not always, and obvioulsy I need to try 
avoiding this situation as much as possible.

Incidentally, the machine seems to hibernate-resume just fine. It is 
when I suspend-then-hibernate that I get the failures.

Before contacting the network driver authors, I just wanted to query 
whether the issue is likely in it or in the power-management or pcie 
subsystems.

Thanks,
Sergio

On 20/03/2025 00:54, Greg KH wrote:
> On Wed, Mar 19, 2025 at 08:38:52PM +0100, Sergio Callegari wrote:
>> There is a nasty regression wrt mt7921e in the last LTS series (6.12). If
>> your computer crashes or fails to get out of hibernation, then at the next
>> boot the mt7921e wifi does not work, with dmesg reporting that it is unable
>> to change power state from d3cold to d0.
>>
>> The issue is nasty, because rebooting won't help.
> 
> Can you do a 'git bisect' to track down the issue?  Also, maybe letting
> the network driver authors know about this would be good.
> 
> thanks,
> 
> greg k-h


