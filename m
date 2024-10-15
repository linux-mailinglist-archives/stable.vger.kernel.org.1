Return-Path: <stable+bounces-85084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDAB99DCF3
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 05:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA38E1F2399F
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 03:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD0B38DE9;
	Tue, 15 Oct 2024 03:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aUqfvXbk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E663416B38B;
	Tue, 15 Oct 2024 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728963835; cv=none; b=kH6WDJzRQ1N4pSxYF/aBUTeA2U+tsZMu3XNt2etM9ENZ28EEoem2mAEjzex8veBzS9IvgVN61KRLEpCqHc5/133EzQ+EBCDdNMUp7WvCUQ9HjaPdm3loqjL0tBQG5UoQoI5KZrhAXdpiIeNMugH+FbdR4+YYly6ELOYhEHoWqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728963835; c=relaxed/simple;
	bh=MDTFEqRSbXhDUt9WnX3JMTAbeMrQfEErxj+Sl/NIIKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWW+gHcn6RAaARnWlhy4yT3gRRUiWO81b7fMKvRXdSE/tF1GX7Fv8nOjE3SQH7qmiDYtZ4863vqhUGy/lywsdUKaLcycSJHnzwP4AjZF4EqwLBSDSBAxogV6c5EOppow4ENJQ7gg9VeheK3/3B76iixn8JVwhJAJY4v8IOVbQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=aUqfvXbk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43056d99a5aso38258565e9.0;
        Mon, 14 Oct 2024 20:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728963832; x=1729568632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yefyLQkuMeyl+1oDEeZVpEGjtr1xlgEljSXpgRP1NiI=;
        b=aUqfvXbk3vCUMI3/Yk4IN1OWXdtHBZ1MI0cwHxLYyQSrtcMFpPXenbCD6OHW+ksBA7
         4ct20ufKuveOFPtSoxWiTSRYgxPhO9akGJcdkA9uI80X9DO2LdpDAkM1J/mVnQs+g62e
         8i+Yck4VfQFP45kZ1pDssSfgnFJjRiTSg1sloRVPnyickjM+vMY5lmm1AnvEBrBK6J0N
         +/rd2bNtHg2BhBUTy2bzMxcwgbGlwxl4eTyDtYYAAM73SkV7C3S6xdv0OOt0PZpX8xOt
         uYbF347NAO+LxQJEeY7wc9ytqjhN1RKi2sYmxqDIIA3Qq6DFC+HcK0h5tdfMRIVWtWyx
         coMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728963832; x=1729568632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yefyLQkuMeyl+1oDEeZVpEGjtr1xlgEljSXpgRP1NiI=;
        b=lO800sTFh8AH1WvqYI7GOQUoBHAGWt9GjnHXtvp0iyBemdeR6loc8XnFV16t8p5hMo
         Y6N4tEYIlFAdGc+1bP/dbKlJPzN+sWAndLJ/P5q9/v6tLyjDi3YfhS6ZAvkFzt1WYvLm
         od9WS/iwr3TwDNEYGTZkSu2iC48FJQiRvzVZUVVs46TLTOI0CDJ8o+oMDh9j6iX97ldQ
         IjJfnoFzBq1ZqRySpYaw9I2O9WcqOqh5XsJT/GTM9iman3ujAf4NCUookQYh4JY3b3wS
         vY8dCJgBApIceir0P7uiBHM/QhdC6THod6w5kIn3ceec85ui6N6BgUGnKYL11OY4FqNC
         Y6pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4QoocKb0ZXKHKd9zhTw/Ii26IKTlGqBtZuqVduwG5hRbkNqGgLvXbcXhVbBxOHKuQwg6LORrj@vger.kernel.org, AJvYcCUBiZxyrGTddiDLF3/a2zUWftUOA7vr3IlnLLf92Aw5rwt15EJD3gelpbS5s9oP2jV1OVeft3lQHHCfdRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70cNw2UYHK/CJDa5w+AF1YnE7waaSZW13/jSGUu41rfIUXJgX
	PhvuyfBd6/qAPGEDF2vh2aMW4F3lhA9E4TZsW3AB4OPdLTWFDcs=
X-Google-Smtp-Source: AGHT+IFxBsZCZrESnkFz4ay1tRiYRZmAbCDrKQ/VUt7CP2eD0IUQLYHJ2jsbjR7FUpR8968cDQdNPg==
X-Received: by 2002:a05:600c:168a:b0:431:405a:f94a with SMTP id 5b1f17b1804b1-431405afce9mr3666365e9.6.1728963832035;
        Mon, 14 Oct 2024 20:43:52 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4546.dip0.t-ipconnect.de. [91.43.69.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4304efc442esm171078735e9.1.2024.10.14.20.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 20:43:51 -0700 (PDT)
Message-ID: <e69c39f6-6db7-42be-945e-49bc0a8f7fab@googlemail.com>
Date: Tue, 15 Oct 2024 05:43:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/798] 6.1.113-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241014141217.941104064@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 14.10.2024 um 16:09 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.113 release.
> There are 798 patches in this series, all will be posted as a response
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

