Return-Path: <stable+bounces-61789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1255E93C8BC
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 21:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43ACD1C21228
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 19:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E24E4CB2B;
	Thu, 25 Jul 2024 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eJKsnREs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FBD6FB8;
	Thu, 25 Jul 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721936050; cv=none; b=iIsfMUyIeucrzJu5he0fWFUf2Xpu+zloQciGZxBYbzd6Gu8a2W+0YvRaPcVF7GtTDd1g4oBPi6SXQwek+mUoteHtHyvA+6GKIKZH2bHmGHnGA636+n027FQraelRQ1fplpwGNax6VluIbJcCAnPU0UMDjx5vzXOkqbcktiXuzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721936050; c=relaxed/simple;
	bh=nuEF+ueY+qCaR3wxBl2p/zP9AodnMWWVUdNGyiE+bZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVp2jtR+jqNBO+ia1RGxXoiQi5C5IDvt7xrXztgfX2P4ObQjlYXh1A7Lob6mroDlb7kYB8UX57OdejJpJ08q8oAHblUSyQtLnn5LOxisuRbRnnQJe4JThyG/y4qpwzQsilE4QJyy3RAwt6VIWsxToBXXAeSjJUei21rTZe9ayKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eJKsnREs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so1850934a12.2;
        Thu, 25 Jul 2024 12:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1721936047; x=1722540847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKzRBcLxbi7v8r8TixMv8QpP93n6qhBc8NhHev7Tm8s=;
        b=eJKsnREsWPctl50xZkqH3qaD8UcN1bqBYvlU36+RwzVJN0B3xlobrbg573xTSP143r
         rPebmmG1rDmpWNEcW1Lu5/rDZD9tBI3gmQwnrKN2RD3EpJ2ul3RUJxRxZsj7oKJONopt
         6IlEL7P29V94zmjx+v80orrwxcLrcpnsQQzy5S9ahJNFoNSAORLLbL+pU92f8/NveN2f
         M8hi2qMEdwXy1KYpmsuPoWy0bY4zt02X+oWNtKclJf0rjQKptCM90PNGev7OnaSher8v
         /pHpMLbh2u2O59O8Al+M88LmaS8KpJaJ6TYvWux4NQYBKI2ZwdBIS2yUjn5/MqC99qBk
         Yleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721936047; x=1722540847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKzRBcLxbi7v8r8TixMv8QpP93n6qhBc8NhHev7Tm8s=;
        b=NwbpJd6zgC2Vn4hP3ZzjkF3ir73dupf9cJop1+Tf0nC7MceihQdl985Jn4WPoKgOEp
         qABpBCUn1BVqxop4JOjZs6v0qL5PVLt7rY4ivuwIJItJqSlabE7agayjMYE3VKrHZI8Z
         sfn6UZcgCnrbMBGeoaL21jL00ZfBw+ZRosPOXAXYyqlYjHGiCCVNAIPHJ2NPEbi0So6Z
         RJW4ovz7bu+mgIy569P2EQ8Hp3oVH0kCjiJePRNfW4sQvcN6htOF76HnhiRvljjDpu+T
         GPfK8K51ur9Em+9gkOaCIa1K9RuUeKadVNbuFghuZyOXQYlLBjfOk5JLPhK6D204vFLP
         JiKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXBUIVYKHGy1oW/zvVwzReK7nYFRJ3TTDC4rLBHxuNRUf7jYjo4d6R1g/G4UF0/NfwjJAgIlSvf1Zg1EwwHhoViqj/nZyQaLljQ4x4HHAA1pYVp0DPv9qUAzb4+WJewYN73lwn
X-Gm-Message-State: AOJu0Yx6/TipQq2BZMslCG7ltWp8PVGnYdCbWmkZO11jQkFvnepctj3s
	binJXPJ4y4QcYK9aiu1z0zFvsM1UuhQgJ7BPCXA9N6qEONpjOuU=
X-Google-Smtp-Source: AGHT+IHQ9DgSVLg0SR11LNVkjXGrRNnTHeo++3Pv7rbWxm28x+Pr+e16khg+pAl2PQKF+OgNJjy+8A==
X-Received: by 2002:a17:907:7b9f:b0:a77:b726:4fc with SMTP id a640c23a62f3a-a7acb39bf39mr289925266b.1.1721936047021;
        Thu, 25 Jul 2024 12:34:07 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac836.dip0.t-ipconnect.de. [91.42.200.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9127esm102302966b.149.2024.07.25.12.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 12:34:06 -0700 (PDT)
Message-ID: <88b9b0be-8c70-4c68-8dbb-a2e1f262b67c@googlemail.com>
Date: Thu, 25 Jul 2024 21:34:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 00/13] 6.1.102-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240725142728.029052310@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240725142728.029052310@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.07.2024 um 16:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.102 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

