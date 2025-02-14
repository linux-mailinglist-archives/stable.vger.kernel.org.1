Return-Path: <stable+bounces-116355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ED7A353E9
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 02:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA86D18904E2
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 01:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95432347CC;
	Fri, 14 Feb 2025 01:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="R+dIYQyM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F2B7083A;
	Fri, 14 Feb 2025 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498149; cv=none; b=CcBIcHDancQ9o/HfeKa3frgA2+7ms2pASSKAMht0kvnAeou4sOPCmHFOmCbQInM3fY07iFJncTo+hKWiYwMtKdHaFH8MF+MEV91pwdOd/vsSZQXZnruXhZXZlGQPnDUkUhgGjG2LfgEcU9X6YLcNWzKXnSE/z3spFWNknkgRqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498149; c=relaxed/simple;
	bh=VcjAQ3B4mQjDUypYSd6nbGJXNoRWezJBNsnpycoJKa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rk/yK5D567Uv+Ax5dFmpRswDO3HpzBdWDEDxK/T97lWXem4c9U9JdWbJ3ciTW7sE1nbXOFsS812Cc7hgvRGuXGlrUtyQ7XdtEd6DzZl2z779gqnWb6BW2/TB0oBmWyrSCU27BrsQYZGhfgYRKHz0sBeeq28fZXrjva3Da3e2lhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=R+dIYQyM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4395f66a639so9836305e9.0;
        Thu, 13 Feb 2025 17:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1739498146; x=1740102946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEKId/k+euMe1WkATnBM1ya6ihDrHX3GOG9+SISZlPA=;
        b=R+dIYQyMqjjfl+F4KNPEnWYoWzqC2d6N3nJ0YkBX+VH8bpgH0SUzX2CaGPmgbct+8e
         xjlpnINbeS7RSBZ5aOC78zfN65P6UzXF5Wpm7d7QiQLHqRQqGfDYysb+u6rhguhFU/dW
         9CtS6zyMIfQgxauc/Zn9uLX7mLfkJqq8mydreoJM6x4fI+fS2YxbpdiZUbpmPbyNPO8+
         LCzLPh6L4Z45kff7NcsHZRfnZILzWwbigEYH+7ypvda/OoomXOfTp4k8j8k+ayVPcH1j
         GPu1A3LMuU1LaM2V35no14TUlsq6UzFSF9pJBmAmAjeXTcGzR6ZIyQ/w2w3uTGE4n3IL
         N1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739498146; x=1740102946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEKId/k+euMe1WkATnBM1ya6ihDrHX3GOG9+SISZlPA=;
        b=JnNfYepU90zoIWinfecPSpWtOwVSNQ1OUaePoa/tDA+WZu7cSpZkzyOi3ffwyxSdXK
         fea713Gc3tqth42gQOpO1J4isKBqzqKX4YaGHSLlJNNDLjLBAdJjX4lZYegw29kzadJg
         gHA6Jgd29wWnRf+Q8q1y444zLCIT4Drg5jmwL/Rcp06mJZPs9YNxKfdRw3rdAvdyzF5g
         mur3UrWhrLuUscY6IYEWyEoUfrq8fDSpnUsPC1t8494In6cU0p4ak9qNKENSS72W+nn7
         1ZSEjCLF1qSSsTb8pOHPpcS6Dws92xuGdr9/+kEJXiec7/P8/0rJKvMNZqjHooP8ogf0
         eMlw==
X-Forwarded-Encrypted: i=1; AJvYcCUlL6N5byhBNqTdlMUyZR/HdMVVA7ZoqjAU1624pnXLRaMFGf+YwedHOuf2b3hOm1OFe9Anye+l@vger.kernel.org, AJvYcCWDAvv9HUsTVeKmf+qx1YP4uJvP8PNrR+YL3N9WoPpQmsnpTJv7faXsQwJrUZOAloUW/rf74mc/cKcICz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQcoXpyxit9K3b6LjXJe98jHWZ/dR3iArF/AYLLHcW7Tn6fE6G
	/vMrSpm1TIif+JA16e0c1ePMxypsc9AwjK2oOmxDbNLsjbR3ttY=
X-Gm-Gg: ASbGnctzurZTO8fGZdP0z2KQQ/wmNJDWq0npyXPEgQxDdmAbYl3XPgv3OR2fNGkAZ7B
	alKlt9WXJHHzaYUM94x3iqwkg4CSLMR3hEgt5xbxo0VNgPnP+BEOVo83qPq6XRt++OxOjxYRYaR
	SczUuI/FmQegRvTkDlgY8BWpsd1cK30EoOJzmnF9RadeBtpoumIRIX40+Vg55nGrGKhpFPLkI20
	erDMwE5/DjG9Q31hXWLuie1NYQsR8UzQWJRuITbuTtlf6fqIMGIObR+FWFeLuAknYprH0VNfG18
	mLbUiy2bqbHLJv/m8EI0+CeT7h3S+ZVaKVX9RgrIM15T3WH+CNHdkE52wUOPag3tbe+X
X-Google-Smtp-Source: AGHT+IGAFqLoCM9XcT7iiED4OM3G31gTMLs6si60SuowTMy1yKm8m0Y8Y1g9lSJEe43V1rJv7W6nQA==
X-Received: by 2002:a05:600c:35c9:b0:439:65c3:3310 with SMTP id 5b1f17b1804b1-43965c3365emr30595945e9.28.1739498145653;
        Thu, 13 Feb 2025 17:55:45 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4779.dip0.t-ipconnect.de. [91.43.71.121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06cf2fsm62498165e9.19.2025.02.13.17.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 17:55:43 -0800 (PST)
Message-ID: <66f89945-dd39-466b-a6cb-5f67b2f0940c@googlemail.com>
Date: Fri, 14 Feb 2025 02:55:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/422] 6.12.14-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250213142436.408121546@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 13.02.2025 um 15:22 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.14 release.
> There are 422 patches in this series, all will be posted as a response
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

