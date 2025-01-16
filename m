Return-Path: <stable+bounces-109274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2446EA13B77
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09813A9864
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFF722A80E;
	Thu, 16 Jan 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BYA8sk+T"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21F2142900;
	Thu, 16 Jan 2025 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035995; cv=none; b=EnvvC1/98rPpgUehd8O7I7DI1GhCtgJU1Sf6EkFzFX2W9VZ8nri7XgpnzNY0c0g5YBEhW3Od90wVjO348QhLmwj02WWOO2eeg7MhYGe6hNMJKhMnQwOlwRYHpM+60DTc8DN+LGnL4Rj+6hflhzBvNx63w7bH1Mksle28yr6kA4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035995; c=relaxed/simple;
	bh=px5Bdgtp2OTF52R0VT2ubJv0O73DimsN43ajQoFJNZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHId8+kd+tzaLdlzAqVp2hGehr9qGO733KaHVV1rWg7Ll+USr3Lq/Z23EJbA48QV1BJd+H2ulWDB4jw1+kl+Lc5NbfCN4nvGqMsfL9UqN0nfsLKTpaX3qbzDm+z67KyHomhFT/mpFwBQvUdaTswY8SsWf8IJbofBFNO2X4LjvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BYA8sk+T; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4363ae65100so9468705e9.0;
        Thu, 16 Jan 2025 05:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1737035992; x=1737640792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jMlvmu7FV/MvmLeJnp4tivJfwp2wZsqjEEGDvDazn7M=;
        b=BYA8sk+TiAGGZ3bltOhvqLh1xMNKfnZIumGGOKgpBKoH4M79AYyw0Zt2+Rkzyj6kI9
         zTmpW9TBTK26gRfKFoSnGW1R1YQuKFudL6V9nATJXHeQgfZ6w14qVdpV/g+6xt0Iktrp
         u6ppuOks34EeHi30k82iSeJDhOmrwnsJKAKoqJdJkZfwICdgpO6FQLessQzKRcbz7Us7
         cm/y2hSXx134ljezqoKLIL6LnViHfdMsy+SQ7sdhe6Y0CrSa7WKwUYfYrj3Usz51vtdP
         2JDzLHPIfqhCuTYbhqs6k/hSqmq75BAMM9CzTsf/PDbly98zYGxIfnA9fVNUdprg9E6q
         yEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737035992; x=1737640792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMlvmu7FV/MvmLeJnp4tivJfwp2wZsqjEEGDvDazn7M=;
        b=MywaCI+fa9b5+Zad2Kf4zVnT6wQs/enQdOQog+z0/Zp6i5LatUnFVgwRL8J8iRy2pt
         kNn4/XodMOH8xEOoLP/JD19hVhUOTjY4GZs3gUci1XOL+uHTsi/BsSAJUwJfHnfWUAB9
         wh6pJm2Mb/Pl2+jKJA6P0X06hbxyMxNxM9RhVfqz4JK2i1MpT7ZP1lJiX9Mdn9nfWxZd
         Q28RDf7A69hblfjWnTllVdpTZq4eHhihmg/TwSgsO2UfN1Lul9whB2nieAAqoX/k7f3d
         5DcfhdQxTIisPKmgulwe+AH0kjo9gMBxa4Zd3pGWG7QvAUGo24A8gbkFHOuTLho+fJ4j
         YzWw==
X-Forwarded-Encrypted: i=1; AJvYcCUggs/XZYLRTv4Us9REvixBALHNl6/jkixlWTcxMAp80XUfzRzLLSbG2KiJAkZo5X2k9xxVJ8k9@vger.kernel.org, AJvYcCUmCFyFlT98B4T19SfQwv44uKvDTA0V+KtCxuYue0bN8JsWmOMy/grF8FzrjwiEZ7JSLkHz464VZLAhKYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3vLdziJxGrIXJMk1nD47irATtQaEEZLbtnAK5nHA6cntHJ4AD
	7jrx0jik62O3vXvRLRJyUGiA67UVeiBVJF1pV0xJ/h0FatIH+lM=
X-Gm-Gg: ASbGnctIgUXAX1DfR60u4ergW/dp8Q3e6bKrcehX/QfvaIYv3FTwch29GWrnvDHFUoR
	+LpiO4BzehIMgpYopydXCj9MlFcea7hlLkjiPwoKm/hCTQQZxGdN2/PsAgT9nA0iPUQ+TV/Hdi4
	92vQ9anbVkna0f44mubTz/MViyQ3TE/die/ak7CpMO354eBKDKtuBIUVGBE8N0VncWe9vqbnLPt
	baqCAU5D7VH4mUM/7zPxC6KdlrGDiVwCKtyW+fsiyAwCmW4U/UpdnrbUTgt+d5O67NnSn+XNIWx
	aRRj/ozx4Hgl2v03jjfeuOasm16fn3I8
X-Google-Smtp-Source: AGHT+IFQVa7sIfMZs7UU7EftapEtYR7s0peJFt5nInyxf/thFRizsBjQuiKWN2f60y1CfSPNwOsH9w==
X-Received: by 2002:a05:600c:3ca4:b0:434:a26c:8291 with SMTP id 5b1f17b1804b1-436e26e203emr282266185e9.24.1737035991790;
        Thu, 16 Jan 2025 05:59:51 -0800 (PST)
Received: from [192.168.1.3] (p5b2acf03.dip0.t-ipconnect.de. [91.42.207.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499942sm60089475e9.6.2025.01.16.05.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 05:59:51 -0800 (PST)
Message-ID: <2067ef97-98e9-4321-a5b3-aa5a61abacd9@googlemail.com>
Date: Thu, 16 Jan 2025 14:59:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/92] 6.1.125-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250115103547.522503305@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250115103547.522503305@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.01.2025 um 11:36 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.125 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

I have CONFIG_PM=Y (and many more dependent config options) in my config, so I'm not 
seeing the build failure reported by others who don't have that set.

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

