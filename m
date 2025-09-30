Return-Path: <stable+bounces-182878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83093BAE859
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 22:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E3C1717D8
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BB5246335;
	Tue, 30 Sep 2025 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QSJ4ZWIB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47AC22A4F6
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 20:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263537; cv=none; b=R6XmzNT34jfsAcCP3R1slSRMO7JkeoMC0YOECpqcUbPqV/7v6JUtb+Ar1utAgitKEfTymnYIl+d2kN3Pf5oVJOP4KBafoWDh24Liqj802OBsDYJBKMm76GJtsWhq/8MybP+48+UXUQJFQ+nTLkpIpQim2iPRt18bM9hdWeoB/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263537; c=relaxed/simple;
	bh=MmXauHjASPTNlj0mQwEIjT/B/YzKvv+oNcG9uMvXJLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C65raRpaSm2+fCyU3g44P/i9VIvtN9NLH6avLlHdjcLvqYjWadW1SJ2I7WBsvHia6/zO8K/PusekysyrlU1b/bX1YLA0urf43hwWhGCqyH3/BPOwaBXpHda7XuqpM+XdP/M6PvEOocqLwgexS8V77ID8BQ2Pppz/YhleOiTAWXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=QSJ4ZWIB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso4346482f8f.2
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 13:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759263533; x=1759868333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8I6dbvilgE5CwAYRRTgrE+fX48lvio4oI5BZ1CMQAEs=;
        b=QSJ4ZWIBDW2SnjY7CJWIFlctnbrcM4oPlh7TmBDhgZ+1dCgJUyOIr31f2LFWPZMI85
         gG+GMoaDMeh0ABCpg3b6JhVbEYUZEs3INLSmO9nnRJDxR3xZJO0E87Cf6FfH5dlzNdTw
         /NIhaniUMAH1zwcrjVpCLf/nOBQxDFb7K22un1J89ocbbOayVlg4SjxTttpQGI/jE7QP
         xGEJTPK1nm6X2czZUTXIKL/h5NkgOREn0JUzPwGkrcqQAsJ9RcTG3R9eRMEEFhnnPGOe
         qv9JpL8yntVK0DqPsmWnbUH1sLx6kAXew7WZK4uu2OAdXzZjiQQttbCvM+9L//rZdDE3
         48sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263533; x=1759868333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8I6dbvilgE5CwAYRRTgrE+fX48lvio4oI5BZ1CMQAEs=;
        b=Hvk8cPBh+PLYDVxnguCiStf5f+WnF8MLFo5As+tRwwzRWwdWDt3nYqAn/mLE633JJi
         0XfrejF2T5lq8rurS4bTc15uBTMimCP7WOJLwU2KzI6kgoBTw5DWUKSrB2NHqHvB+5j/
         6r7uTCVnkr3cngjFERD/d2Jg8VTiNy9v98ppoJP2dUohqfryIoN1HsOAEb/W/ZrDk845
         o8Mg9ZrMTFQ/zbPccvmRT5Cs23dwXcmzx8cyettYWgO7JdfynCV9qBsR1Lc7FH/1lC3M
         L6/tN7x7/ClWmMbLer5+w/X0dQRivKOn3bs7TyJ2DyjwrWchRxezoIyDsmvgZ/jhkrjB
         k+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWJlYJknDFJxgNd7c54LvqPvZHUl8MeeBNhzrcyTySeTH7qLOLE2oXFNg8eH5J0DGynXqP95UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUpAK0sxV3UGUd2ZG00KBYMJmsa/GViRSgosoyG7nN58NpAa3N
	TFzkH/aHcl/Z4mxc6Q0boc2+UDvqM8B9mMNoN7M14HJevy/lE3ZmTso=
X-Gm-Gg: ASbGncvl1l5TPddX3Q0YSHsWD15zxUgH39Z8HHGbJLIWJ6JtiHbN9NVnyB010wX35iu
	QTRLEUXxxAllvizpu6smkp8Qpa7da9+suquSM9j/hf8HIEg2iGZ4ebFFGD0tpMl+u/GrWtfkN5v
	519XaIWEg0aGPjwEQmStlXnUdrsrOYMimqKkWYdLm9Ii7JUfE8BxhHJB9Aj8sWwsX5JyDhN5q5w
	iMR57Oz3ylbbWFFH1QcPJOSRHldvZLKrfWIVe9YT/9/XiwYuVol2T5CTnazXwtvLR4MEV4QZCYW
	0N2juC8j9/FNuIxqFB5Xub7hKOoOfUlGHXVjr01NLbivkbR83UUlciGgGnLOHCTt1z7Qf3Mskqc
	RUCqdd55y42uVIao5Pq/Yc08UCGBX21So7t9SvHL7nNh27VR6YukAMiureRBcXafJCK+3unlutx
	7eJrbQpTQ1+ex4X4SMENTsaow=
X-Google-Smtp-Source: AGHT+IHVX3QXQRe9EuiPExL8BKNrajYyrxG7WzB4GC1B2EjOUomUTUBpPzTUhvs5y/w6rZHI4Wb2Fg==
X-Received: by 2002:a05:6000:4312:b0:424:211a:4141 with SMTP id ffacd0b85a97d-425577ee1d3mr734255f8f.27.1759263532907;
        Tue, 30 Sep 2025 13:18:52 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4965.dip0.t-ipconnect.de. [91.43.73.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602df0sm24133218f8f.36.2025.09.30.13.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 13:18:52 -0700 (PDT)
Message-ID: <a7b6616d-c5ec-4f11-9c51-48551705d535@googlemail.com>
Date: Tue, 30 Sep 2025 22:18:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143821.852512002@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 30.09.2025 um 16:47 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

