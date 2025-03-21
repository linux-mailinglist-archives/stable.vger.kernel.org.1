Return-Path: <stable+bounces-125729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662E4A6B256
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 01:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A867B167D
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 00:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707D1E48A;
	Fri, 21 Mar 2025 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WBj3XUqm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0C1EA84;
	Fri, 21 Mar 2025 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742517423; cv=none; b=djEwJKYGe4ZEbxX7z2dZO31kmqPSwgED4BQl/C394qq29ZDb02RjT58PbwcNze6/Qb/dTTlyPbIDZl3brlNPk//fvIySlh9GYNji5M2i/mfaRoLPVoaou3ZBbPvugVlJqobj7tGgzkrh3ZPjWziifvkhf93h9lQ7xQ8hcDQjOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742517423; c=relaxed/simple;
	bh=2z2RHDJm+LH1XHYv8vwtILZIc8Ji7eD8BNHKPWzg2vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eduWkBzB7iP9kBFCjUOv6AlZ4B1Cf6YlLL7yUKzxkKPMAtpSrHT69yceLjCT4tvkVCKPQsh6zggmltOKfpVfLGtPj74TxXfa9pxLPF8ciyIZdRahcB8Bc1X7+/KXsHF+m++tYeLiz6l2WCYAOp9XbTm/G/RdwbfR8GFBydgRIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WBj3XUqm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43690d4605dso9625385e9.0;
        Thu, 20 Mar 2025 17:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1742517418; x=1743122218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqUcVj28ADCuEV5WcvgqcjEh/QhHQb8TbIe4WSOMGp8=;
        b=WBj3XUqm4FnbRm0/AjgEkPKuwWWxvwYBekfvqjTMtT/OOMPSQF5zyDwinJ+0JHSvMk
         c+ZOZC+y/pzh6ixTCKsuOPYOMn7gpMZf0xmzcRPGcC3ImWdv0jb8KCPra5LSavAP32ux
         amlINMVMRhky8jZ0Kbm43EVx/KXRA0pFIp2SYOMf2gYyuv2f8TsSAmcVyJseGknp0g6m
         oQt/i972WCRQ939ErFr/0QAyc/FaufIMXGVhAdMxT+3EZRrQu50DECJqZNGsbjM61TvZ
         qJPwO2Ik2G8La/K9f3MSYCAQtFfA2PJ5ZMQ9A2dW2jzACsQCumbdTWf3yC6yGKvc0ORr
         /spQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742517418; x=1743122218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqUcVj28ADCuEV5WcvgqcjEh/QhHQb8TbIe4WSOMGp8=;
        b=GQX+PAEz5+xb3RQzjuFzTwldqV4BXLplbiHGSYp7BI6Uvrkx2H7rdlEaeDnzTBfbAF
         7xRWsQYaQN1hvjoXc7UDX1ow8/IsUn+26cOGBQNCsmMQ5jvBKi6sGSRKxlnILWx8Jwgc
         UOArkTN9aTSeHjOHGtT9gGQc/MENDS+Wg3Smu0TPjhu3AsaoZ6WaIyo1Txt/OEzvxBWD
         2vhavOHTQPdrR/g4PJGosigsfqbLf8vqHINDAbbr2IdXPH5nRbxRrf7TKWM9sECghmka
         U9XIeBmrcW+q1pUtUN2oGE69fgVMjC1onemHlyqXDDIXRkxJjN1epL9OMpmLoo4MKYvz
         BvMw==
X-Forwarded-Encrypted: i=1; AJvYcCW8im8Jzbsf8WqretLLuyxAm037bgWwYgexMcZaYEtepMEa7Z0v/sUFhEScAdRkwlEPZ7AI42rQ@vger.kernel.org, AJvYcCWzHJSAUL1/DLXCgWN6YYENUmreIc03f75zjXGGySv0QdKmrqARRqqipIkRzsAxoatCZzi7gJO67uHxplo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKNFjSAhb2JCfTw3xFFajhLBnZhhNpke4DdsUU4EFanzHS6/8
	x4rL7QkhKLcKzPmGCAQ1/SfxqmGQz1LXQ3YTMk3gsGVQdSjwtuvgB3Jv
X-Gm-Gg: ASbGnctLu6BcRykS2SNAzhP23/BztwIl25gM4NM14i65jH2w7/+UeXQszMIlmdyWfFJ
	63YwEVv2Q4gdPEl6RpIcigslfD2B2vc76BEqpyTpdR7VM9CBCd4fqpbTwkUpcckZOzkoXUJU/ac
	LqTOEcQLm4FIj4WN7GjO82SJhGlgERNChpa8My0iu/JHlJ2RXuGgNaKrd2fJEDcBV0YqC6gY164
	PwLZ4kklSJoweqbvqpbXuN2RwRTUc+g5fySjtpL4ySFnc+iZeOig9KznDsMbe6skTzgBXDsorF+
	f6KC185M+zDOBH/iwInKrmMw7/zNEFNwgI+frDrYvOZguUEMOt8HYUFrmxZJHYwEFhFtdw3KJ7p
	Q6uUXlkqtiT8E5QFmFIvBSw==
X-Google-Smtp-Source: AGHT+IHvGLjMkOgQHJeFISgsZU+mKKIo64KH7v61/RWdA0q63XnnMd2pNMchgRNfh+u1zcQOFJefnw==
X-Received: by 2002:a05:600c:4503:b0:43c:fabf:9146 with SMTP id 5b1f17b1804b1-43d509f5a43mr11075975e9.17.1742517417855;
        Thu, 20 Mar 2025 17:36:57 -0700 (PDT)
Received: from [192.168.1.3] (p5b0579be.dip0.t-ipconnect.de. [91.5.121.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3ae04a94sm45405785e9.0.2025.03.20.17.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 17:36:56 -0700 (PDT)
Message-ID: <d5f238f2-2ffd-4e85-9667-9a7398b42516@googlemail.com>
Date: Fri, 21 Mar 2025 01:36:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/166] 6.6.84-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250319143019.983527953@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250319143019.983527953@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 19.03.2025 um 15:29 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.84 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

