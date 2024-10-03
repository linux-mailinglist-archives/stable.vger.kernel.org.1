Return-Path: <stable+bounces-80668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D5198F46D
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 18:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDBC282F42
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 16:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9001A704D;
	Thu,  3 Oct 2024 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dIGbdhL3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF201A7056;
	Thu,  3 Oct 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974072; cv=none; b=kmaKX0YBgEdD89iRzPFjNE9hNDZeWnNI43d3/Zau2bcL4BQJ5oAEeVKOVYmAjfwi04IXqzCHIEv98RG6et4CXHoOTKRn4EHt5dmxKmEK6ncQyFx0GCAB2OQhdDk/c8fdrF+NSCiE3TkU5gCNy9OcafLxsMYddufUxEeykL19Cgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974072; c=relaxed/simple;
	bh=M8f6aS+IByeVtnTPSzuINb48pU+igaxfoJQ9Tcvwxn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZAUX9MNdlCnQsO4wyjs3W+2tM5W/9yFOqYrHLVzcqNe6YYo8nGL+qez5pUkho9DadtXnTelIsTJPtQSPZrooqq8pyE+vp8OTicKiBRA4to0W0M+skeu+3sgScCTO3L9QJQw5XGyNXkfc1DgA9LdVCfnKR2k7KsDbC2bIvpjpfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=dIGbdhL3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so11693035e9.3;
        Thu, 03 Oct 2024 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727974070; x=1728578870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LTMcH4K9v+DoRwb+OflDxoZfRqr/SiTrH+qJdlHOBAI=;
        b=dIGbdhL3VOgzodVkyYKSPhQlxv6Um7QTaIcQyEzUr5dYGfYjBmSQ4TMtFsdjWAEF6X
         Kk605cheKKWP2s9jiP8P8tSKhBRmgAxDgqf0X+W+Cb7vIohiNjS2cRSXT+BBF/vAVVfE
         6pnPJtsR+d9Qmh9wzUdeEOcoWuJi3Y4hSz80EY0fAolBy0tNNfqPBpCpFRC/XCLJjU9m
         AZhCSim2mG4UATrvLcta7yqALzsF5YBRZxBhtzGhWUkD5jrZm8XvQXKOcATqbbDNJzWY
         dwOEk7p7mRLgoBYiLqDL+BCCp9p4Rr8GHwBpf+IIU7ao4ZcqY7TKnLQSNRLpBOKY3gkX
         76zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974070; x=1728578870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LTMcH4K9v+DoRwb+OflDxoZfRqr/SiTrH+qJdlHOBAI=;
        b=b+d5w5gOE/PfIMh1x3PxAN0wNvjcutHh8G3ExtopNO9CYfnsJxqISMJQlsfkth4OjF
         ytmuvBaLKaJxDlDtVFnCJVl7ooHXB07s4heDdBatDLl4ZxX1V4reDJNg2Y4B8wuBwV5Y
         SRWlHVkNGHJWGmYT1/Xs5xw6U8vqtEHt3RGA1SPpHPODR6c8K1p9E62W8LT5I8U7jay8
         165S361ROl11I4gWDwAgmywqvHUxRm1/5bxD963GStWczcglD9ogXeywUfp2iaqJhCt+
         9LdAGUQ1RB/mdNlhlo2fl5UHyboQAHxadsT08Cblqgs5a9wqbcVgVDUqHZQx2Q4njTZZ
         3Tvg==
X-Forwarded-Encrypted: i=1; AJvYcCUMc0Dx9/WZglIzsQva4Lf/hZGAgxUI8WCOLFk9bZ7KxA5VG+gduplm88OVpwsZYVQQIPdh+tm6a6wdqyU=@vger.kernel.org, AJvYcCW/nhytI+Lh+okQ4lY/t800Hqxe6JxFRx3xc+2zgjPxo5AmT3imNaqK++xoCVz3RSRDjWfKvKA5@vger.kernel.org
X-Gm-Message-State: AOJu0YzqfDMVXqPftR1kjjDGSKvHIK/hZuzZsAQXzsoNi5GRP3737iVA
	GZnTHu7XviAwsibmSX+XRCG9S8Wk8NdNeIX2NIUHDQWktjXhHcU=
X-Google-Smtp-Source: AGHT+IGUM8IIlGHJt3TQo8HYw+JN1qzS1zuRiNI3etW98uwknaVKmuQrYw+rNbZnlbOEODJAC0AFow==
X-Received: by 2002:a5d:5850:0:b0:37c:c5fc:5802 with SMTP id ffacd0b85a97d-37d0e7b9b24mr8467f8f.36.1727974069340;
        Thu, 03 Oct 2024 09:47:49 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4899.dip0.t-ipconnect.de. [91.43.72.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a01fc92sm49035985e9.36.2024.10.03.09.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 09:47:48 -0700 (PDT)
Message-ID: <3b058daa-718e-418c-b34a-54e014988461@googlemail.com>
Date: Thu, 3 Oct 2024 18:47:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/533] 6.6.54-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241003103209.857606770@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241003103209.857606770@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.10.2024 um 12:33 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.54 release.
> There are 533 patches in this series, all will be posted as a response
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

