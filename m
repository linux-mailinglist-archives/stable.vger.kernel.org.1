Return-Path: <stable+bounces-58954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDFB92C68E
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 01:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8115283C8C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 23:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00BF187846;
	Tue,  9 Jul 2024 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fAaRLOva"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826C13B7BE;
	Tue,  9 Jul 2024 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567502; cv=none; b=qEukS353M8qR2qE4ey/by9O/WrdYaNdEiZR+PMFkXNGeJJSjDyFJ4xabdBhMRwbm7nXXBT6tldaa6wPdqghk/WCuLMv/FBJscrEsuwCxMqFZHcZtGnQK3fnY82gzXUJWUeWttbGrDkrtD4tHwS3Gt+w4TS4gq6TTUGbZI+A0QJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567502; c=relaxed/simple;
	bh=3wd4Qol3aqeCV1nizcM27I0+dRh0M5u2+YrTk6xMtdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qC//KoNZsDlC6SLkwn/GK7RO1byYgPpmyKuQqQTAdY9fIGUbuftFVcj8G1A50WclIJziBfrSawtOpapMCzi837E52eiIclpy3NWOa6NITxQv2qFCbhckiPHTNA/fgqYyY6pmZks6+SwaY0EDerk5/5YuKnik5cUFWYFhgc8d3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fAaRLOva; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3679e9bfb08so131753f8f.1;
        Tue, 09 Jul 2024 16:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1720567499; x=1721172299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCLuNRSdxoCvw7coN+ntMs6AADRM0+szp3T9Yi7LlLo=;
        b=fAaRLOvavXeXNL59WW2ujENHC7qEjEe6CHrSqJ+Zv66eb+oL9KQ0q4Ac5IaNLNl9bu
         y9kY4GR1vG+IiTLbeGy7JHEEogU0fxJffIbG/ogJqP8GUgCSSf4oWLYLuOVdkCoaP/AX
         TTBnZ9CbRa5oqVhlSTat0xQQxFCEjvHUuFPk5R6SnocooZd7+Xu534roQphdZbkekJzM
         BZ3iPSKNNSVBN0qetitenr2RuPLTacvjsgAN4RA/pRtDyqSWBP5foQC3XoS7jFvp5vcR
         JKNwEaRRsJDfnXXJc7hmBwaHsda1ZummbcoRoQSt3cY/SUfTS6FMO0a834CI6DKPIf92
         Q/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720567499; x=1721172299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCLuNRSdxoCvw7coN+ntMs6AADRM0+szp3T9Yi7LlLo=;
        b=bE6P6r1br7OpQQxJeunRuyGPaTdbzk6iAVRsLMbSTbXaeIUDcQHiUJc1eVRgzwGOwN
         f8FP9i7dUEbp6L5dR5jkoWH0AR4rtTuwKiJS9e4jbKIqm+wcLuYOUtx59ezsgHOqbTDE
         0yu53nXOKwSd5jiqTzP7fkdDykgaSnltD73MJiBqHzP+t7XN1ropSFASjXVQV15FzrWq
         thdaavz5SUTyDUZmsnq3w10fsLPuK0ULji4eL7Jbq28sU30yA22j7duSuK1jmxgdThpL
         8OqXWvTQ/NkumqHjU7wTUMRoNT3Y/bD2lMbIVxQbJqMnU9d7qKb7CGt1TVLVT6lxOkDe
         r7fg==
X-Forwarded-Encrypted: i=1; AJvYcCWku9H9It1dnrFQFbgdreMx0C2VfS7cWRRLZFgtcISZvaPJNhm+FImnGKS2k+l2Sld2pGt9CgiqTrapnCQSJyMFkcblxrOzS4ACE3Wb4vcSFAUXdWFU/W92OsXlTNgiHydFA10i
X-Gm-Message-State: AOJu0Yxl05tsxZtL4weeZmM02IsWd0d4PHUnlaTup4uHV+bFQOEbQl+2
	ICmTC6Pl6VjgPi3pCPKiD4cIuDf9ImfZFQidWiOzp0bCgrOaRAo=
X-Google-Smtp-Source: AGHT+IE/yJzrOgxlV7O/VV3pkZx/COzzqyCU+Nj1pbPJYC6Ou/focaDzyDRoxJgvU7kRaumc1e/sUQ==
X-Received: by 2002:a5d:65cb:0:b0:363:b3ea:7290 with SMTP id ffacd0b85a97d-367d2b5484amr2929332f8f.20.1720567498954;
        Tue, 09 Jul 2024 16:24:58 -0700 (PDT)
Received: from [192.168.1.3] (p5b0577f1.dip0.t-ipconnect.de. [91.5.119.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde890ebsm3697113f8f.58.2024.07.09.16.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:24:58 -0700 (PDT)
Message-ID: <c65f79a1-f6fc-4266-b2f4-bef5fa001044@googlemail.com>
Date: Wed, 10 Jul 2024 01:24:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.9 000/197] 6.9.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240709110708.903245467@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.07.2024 um 13:07 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.9.9 release.
> There are 197 patches in this series, all will be posted as a response
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

