Return-Path: <stable+bounces-185562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C0BD6F92
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 03:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C53494FEAB3
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 01:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2883253B58;
	Tue, 14 Oct 2025 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ig1/UQxf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA8B239E91
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404446; cv=none; b=tmFkqROr5QshyHeqHTsdo6ziEBsevqDHPAU9DsXlxduW4d4G3eak1HxVyBL/76isgXs44+ggeXLI+i37CgjTOc06Uv8bv6CWjqFD+6FKDLO/Z5WMyqzmU8iQOFDE3ZpkrbtQ39rYJO/K12vVbhV1vilGM6wEuMRIQVheiaxLDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404446; c=relaxed/simple;
	bh=VLDmeT4V4bMf/s8VcnNmz25fy91luPLGLGwIAeMLYJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8f8STlQoNec6cv65IeK00kNH09hdQVU7x7Nmaqqdgpuer+lTul3LjNVFU2CkbQPJJu+gHB3UAy2iJgucP04JTlXSK+IBxuN/53I9FLmhqszIcR+sawDTtEH/bNOq+gUROldN+lPC6pOH5xAgX2BrzC8kDir10dYNJo37ZMSYnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Ig1/UQxf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so38632615e9.2
        for <stable@vger.kernel.org>; Mon, 13 Oct 2025 18:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760404443; x=1761009243; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BotW9r6xL/UMcoaCPy9Ldu6h3UcOKuy5CPivX5Mz6y0=;
        b=Ig1/UQxfiN5Fk/yO7ZJaSTtwT5JlC5gyQ3uBPDmOgXayMr5Z2naQM68l+Voq1LLoP3
         MyCrf80r59/7qzxlHPs0kpm/9eek0+fnEZQzKDw175M8QI02a6OlE0K2GbyepmtR7jeT
         BFeCNKPT+2wtlAo3Oo7V4svPlQLH3U0YyI1c5d5M9IVpV0EahD0HY/+Hwu9z1gkAR9Sp
         jFD1trNvSkT+tqNvc4IiMcCCJ3R38f5ZKk6zFE0OzRCn6NUu183DH+a2T9vf/z2++eCh
         HcyaFZcILGSnL99yrypSZPA85SvmNq9z4ghoCL1BffF+l+piB5XpCfEdxvHCPxHmm9CQ
         19GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760404443; x=1761009243;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BotW9r6xL/UMcoaCPy9Ldu6h3UcOKuy5CPivX5Mz6y0=;
        b=jUXrvY7mqJyjKw8WzGW7AxQHoRusnBShQDuzwPGQGnG5+gfGMGl3vnMdW4SrlJaIu1
         VuZeCjCghZoEweqHqrdQMdHGzN+ruLJYbe6KeFK7q5TZyNwqZzZLC4Z7OXcBeOWJPzSV
         FBf2ns7gz59MQLlW2F+A/HerLcY9spSBKJwOw9rWMM+HUxnnGE6umlkAhIh+t6CL5ZIH
         cfK54rY690XdjVRnZiR85U2ltHpzdgeJp4DZj9jJiphxFZF6tnj9lYaJjAOJZ10HvtMM
         eTHBrFTs8PMBAw/AXFSHXvYzM/XRk/Eijt8qTY8CR/IV2uILNskHOoy4m6wD4wj75Dos
         SY+w==
X-Forwarded-Encrypted: i=1; AJvYcCWtFq8HzpQDQvRIUehhpPBhtxX1ablv0LFJOWpUZGkabyDh0VSYwEKxYjSDvjUK2JjpyMQSEsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm2JyVwdBFOZNW1SzDqCNzZS+7lIlnKIXQjQYESSeLLw4sSwCN
	5gSK5USp2Giqj5Z8wz86YFIjkPIlVHMsf1/Fjduec/4j76yoa9R4foM=
X-Gm-Gg: ASbGnctnY8WAJciFKW+sQcgXs2aamPpRc6U5EBwDlDrdj2X8wIvmCIYNUx9sx/pMLSh
	nOeWcHeSvBaZciZ61mNb9ARZZOmKrZ8q4CqURzS3W+2GgPko9YJvjqWt/8CsKGNiCTxiVSdCkS3
	owgKh/AlMq5SXk4unLi7LbtAiCQ/4/espeF11eTxcjn9Ezi7yJmhHo6LMTo1LQck6p13hTRS11X
	9vjfaGswyX25X+nOb4E7CQGdeNGBjoM3dCIUDUn4Xn1ATkihsZeKWqtYMCrbqEehuvrTuXsdISH
	sKSTxF3FeFKtSCqQBlqILDJ1zwRmQrk6oYf0ZgsetvaCaf8vblXSaUuFD+sBokcYTYHEaHwedaN
	B0kJ0jYYBRotWTRZdnrZAB5UsuGUkXJiafwWUkmwIt9rnqD3ZLn6URtlAr6qGgpn3qppjSLfzWp
	O8Z2WCZD95cdaNFn+HVU8=
X-Google-Smtp-Source: AGHT+IEn0zN7JJO7ozOpfwGf2FFNELh91wduawTwnU1AdEj1SfIBN2yVJEWWjvkaEB0nGVf1WaDqGQ==
X-Received: by 2002:a05:600c:4688:b0:45c:b540:763d with SMTP id 5b1f17b1804b1-46fa9b18258mr170118175e9.33.1760404443223;
        Mon, 13 Oct 2025 18:14:03 -0700 (PDT)
Received: from [192.168.1.3] (p5b2aca8d.dip0.t-ipconnect.de. [91.42.202.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482ba41sm212307565e9.4.2025.10.13.18.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 18:14:02 -0700 (PDT)
Message-ID: <121e043b-f873-46cc-ab7a-22100c936dea@googlemail.com>
Date: Tue, 14 Oct 2025 03:14:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/262] 6.12.53-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251013144326.116493600@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.10.2025 um 16:42 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.53 release.
> There are 262 patches in this series, all will be posted as a response
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

