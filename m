Return-Path: <stable+bounces-66116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 360DA94CAAF
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 08:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D77E1C21F43
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 06:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854816C6B0;
	Fri,  9 Aug 2024 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UUY/gQrT"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD0881AD2;
	Fri,  9 Aug 2024 06:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723185309; cv=none; b=DXrvFpIqVA5XSyBfBoJfBMiQmLxIcYIsNlLKk2sesF8G54X3/lVhccMDwYhiGEZ73UiJiJf/6btuPh5SS6wxHf8OiprprDqlXEDsmTjgYhrwBIO51G66kr60bfSU9S+BwSO18ssUWodOTYBc4ln58D2kVR/kRwPNpxs8jqL5l7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723185309; c=relaxed/simple;
	bh=GKtr8nhc37ZChqd/sIw4sToKmVF2fcW2I+SqjRUqOLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XeDOzwGAwFOanpbfNq59XhjH/kJghwSvlAmCZAdnYecYFffMaaFPxqJHsqUqHC1m5TASkSj8aMrctHAiak3QCAtTqlQu4oKbkmgoUNsawLkxMKiqAhCBTL1nV/ec1DSqygEyszKLRzXK0I8o1rIqcJse76yC0zLrsrlk8MYxFmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UUY/gQrT; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa086b077so172568966b.0;
        Thu, 08 Aug 2024 23:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1723185306; x=1723790106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVnfAEiRYm+yWiEHeMZb+Y8q5Y3EB4cYQYvJxe5LXZs=;
        b=UUY/gQrT3QlOHUjSVKjb3UIGlgJcainK9iTrHwo2jPhr2KZuKRMOU4DC7oTgNGAhd+
         wz2neXAb1Ffq0kltnmPyc+aNMTOcjgB/vQfC8+ljVg6kkETRqHVFkLncg80CK72VB/2z
         0GimHVmfA4LOYEhR5UF+aQGl7XG0tGNwFSkYHiqYRhQZe8v0KPJRc2Po0rSD69wzYOB9
         rDVaF6wwj7E4Vj5GbozEWe/QXsQ2TeOCC0tKpzbPDaSfyMs6nNyqIzQ80KBxoFC7uvhq
         N8XgXnAi6FlASlCQ354LLhrtSf/ohhyWRrWiIv1tzR/k6BmxVAjNYCEVZCzj45wwyU/2
         RLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723185306; x=1723790106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVnfAEiRYm+yWiEHeMZb+Y8q5Y3EB4cYQYvJxe5LXZs=;
        b=XQWvngZab/qFSvYwjEeb2SVq/z7g5ZBpvzNqzS0JCwNadj7JWg2iD/JdMh/6BYPw/J
         mkAjcXsnWQhoVFZFrjYoeXpSAU4asYZI1+mem6jLYrlTcDCka65RHNDiCF/3yjE4jtop
         tqYRMmz1Pf/CnmitXIMknnQoXFIn+qx7qsKCMM4r5Bc4dt/qVceDEFNCpxhsB2w+Kyo9
         c+4BxFRZWscRzJY/BFSJKxQaWFtZqTyyOCd9b4jt3IgcK+uUlqu5IDlwuiCrpPZ1eDHY
         J65yFltuuvaP4Fj4nCaafVRlti/R7HuG2JP+jiEOyb/GqruXgWFE0PZ4Rj2PHZ9AD+CP
         TcgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWzQImJeGIOyvHJzSL5vbQhcfUg2M9HbKa2nSosLfKXX0KhkLx9ELnmNoL2sUCndXbh3jpsEZy0ITT9ge6BB8Ywu2SOZyO3KknolTtFPv/pOHJ6KpsChw/REEZ8k8f74nkqkoa
X-Gm-Message-State: AOJu0YxOEItbhNr8zI/pc9TnsClijIAZ3YJ3FgLN44zIkiiAEawd2fM/
	0wyziN96i0hp/gKxZVu5aosXqbMyEmxEisrdwTkXlXyp3sJvjK8=
X-Google-Smtp-Source: AGHT+IHKSd1693e92TOlqx4CfQaMdz0+zR4H5NztzJSB5vHvlFvXKft6DsSez5D7cfNGjAELfeWMrA==
X-Received: by 2002:a17:906:d246:b0:a6f:4f2c:1936 with SMTP id a640c23a62f3a-a80aa660067mr42935766b.44.1723185305842;
        Thu, 08 Aug 2024 23:35:05 -0700 (PDT)
Received: from [192.168.1.3] (p5b05740f.dip0.t-ipconnect.de. [91.5.116.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c6627esm814672766b.95.2024.08.08.23.35.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 23:35:05 -0700 (PDT)
Message-ID: <0735761c-d172-4db6-a211-6f02bf1be342@googlemail.com>
Date: Fri, 9 Aug 2024 08:35:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/121] 6.6.45-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240807150019.412911622@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.08.2024 um 16:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.45 release.
> There are 121 patches in this series, all will be posted as a response
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

