Return-Path: <stable+bounces-80655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8290998F26B
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 17:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47955282D4E
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 15:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDE71A0B1F;
	Thu,  3 Oct 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BhtNWMls"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446851A2C05;
	Thu,  3 Oct 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968795; cv=none; b=t6/ehv/U13YWoTepugZoXXx0akSRUVVMA01GztzeICJjFESRGcuCnytJuagFO0gZMZCVfyjHzFbY9OMQd/B79EhAGjcdKSZ47Qc+TEpRwggvah3zfwOR2lHdxicaxzSdAGuwLIhGrnEHQFiWou4cQIBKqm6LPLxGLfXV0hpM648=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968795; c=relaxed/simple;
	bh=ZbJsTlshJ9ctmYeMqDs9gVt4Uy6L+q3FXxGujtwO6RM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FC1Olx8T5fpRU/04FH5qFr0/iewoWd4Dn+VEkzutMypozDF/XMar/Mw+ZALXPLss70lprnHFs/6kIrVBEhwc8EuGbxUzSGWBRhK3es4YmQZWFX0ffyB108a1PSoHnWvE9EI+p0xaVdwTS0IqrwAO0GLbdZk3YK1aQjhQYVg0wgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BhtNWMls; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37ce8458ae3so979507f8f.1;
        Thu, 03 Oct 2024 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727968792; x=1728573592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFdqUtE9eYCM1IPNkv++3HkROvJMx+gDwOA6w7KfOl4=;
        b=BhtNWMlsfVbDmgdsKtv9UxMKnm1hBitZ4HpA02Ubncb8xvNZuQn5LliRao8ymIUkCk
         rr9o2IfzFB8DQTiVOpp1E8mK8juQGknuQ0uHh9nDsSKhI7Q/YJkBDBA4wjjl1xfSzgRu
         VCHec+r2DlFf46EW+gVccyLiNkRpaFbq0nA0PBmTAQAAPq5kxcgCAnVMRjN7HOe+4FRC
         ZIVZNkaAy5g6VJ9MHqk2jrUdokRFkZdpomedS2HGD3S0JPtPojHPRkf5yPnhGuabAzqR
         jmM5/1RHi4FleZ9kSzCkN6rkXxlT71iNhmuUvGdKM4+aZxQq9ci453YdtG6yZs5CWVf3
         tOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727968792; x=1728573592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFdqUtE9eYCM1IPNkv++3HkROvJMx+gDwOA6w7KfOl4=;
        b=FHtNvD05qGE3ly299L1c1Xcea+OoA8iIe98CKBtrvCzl0d8D04SStAxGoZ7Sz7ECKS
         TYZIGqyaiu5bLG3d+ey1qeBhCU/Ge8GqB4BIcUtVDB8q5pb2Ir1LDEMup0M/mAca7RQ7
         OaSR76cjLSLgw8JJ4H5m2tm5ReXzSvcnf20vgE0pEaOi4n9dvjxnx6FHCYJxBgOVYU3n
         Bl+K/E+/gtz94S+ZqzaP2ywL9LxM5QYz79ZDoyOLM6nM42sYBMzqfIdZevPtD246i8it
         yxkNFQklfoRpZAfsdJ+BD6bixiMPrmUsMfK/2fcVgX/XPuIXe/BqyvFxcGi4tc1wtq5L
         ddKg==
X-Forwarded-Encrypted: i=1; AJvYcCUftNiixR2FZzYwk9yHBxdXkNkin7IxaW3KtrFJNjtsv8Duv/FxIXh6nqeIckiqAHN9EoeWYn8ZoW5gYdk=@vger.kernel.org, AJvYcCWziITdxP1AreKXPVJB6d182GMi6Q/H3LXEG+kk3RXgRYHNia6RWoqQCMMCfFZbRcoUANHDIy4x@vger.kernel.org
X-Gm-Message-State: AOJu0YzsxDfGBsxJ1EcX2z2OzMN8zM5Xmt2eLVzuZGJugQE6QkcMpGQS
	TKpLMdqKc2q5ARNesRSGayJeWwIjIHZe3QulVuBuA4Wvw71mfis=
X-Google-Smtp-Source: AGHT+IFGcq+T4gdND3IbL3l1njNzyKwcGp1Qdw3CdCjkUB+ERAIltHU81L+Tw9wShL9IzFpaSlmHBA==
X-Received: by 2002:a5d:5d85:0:b0:37c:fc25:ef16 with SMTP id ffacd0b85a97d-37cfc25f0d9mr6168251f8f.0.1727968792278;
        Thu, 03 Oct 2024 08:19:52 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4899.dip0.t-ipconnect.de. [91.43.72.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0822b878sm1482269f8f.44.2024.10.03.08.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:19:51 -0700 (PDT)
Message-ID: <9eccf0ca-86e0-4234-b37e-f8b5a0472d05@googlemail.com>
Date: Thu, 3 Oct 2024 17:19:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.11 000/695] 6.11.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241002125822.467776898@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.10.2024 um 14:49 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.11.2 release.
> There are 695 patches in this series, all will be posted as a response
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

