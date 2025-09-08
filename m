Return-Path: <stable+bounces-178897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 983D2B48CB1
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 13:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04ED1B279EA
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756592EDD6C;
	Mon,  8 Sep 2025 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lmeVY484"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B462DE71C;
	Mon,  8 Sep 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332738; cv=none; b=jknfEKUQklfATKmOPkfmWM5ILW15V4OUvE3TSHtZ3EEYQrrDpTfsu2dEN/oKoVxl/gKyaCaJRQNymPdAigRhKep9zQ9TKT/70MuH0cvYfV3wHS1aeWInowNX8r3deTlxuLaubRkkdCTtcmm35gbLS9H9YwFGM2y438OvDXcFbWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332738; c=relaxed/simple;
	bh=6QOPQOr+MMPkIBn3rM6zrLTI8GvkuF3KweTHN1ROwhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYXv9pqOFazD/JNkyjh2JbCGYpQlqOlt0S1hVGMyojz0GT8HQShPCOJ1/8CzJ3tjmL5WkqZxDE4HThlswN2IRMEErSbP/QP7rnLpLunslYXc/rHuQVTyctb1criSOcMoYkY0fama2gGOlIY63fcvfg/spyjeDZgOU24WzXRpLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lmeVY484; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45ddddbe31fso11140985e9.1;
        Mon, 08 Sep 2025 04:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1757332735; x=1757937535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eRM+uyebU2Rj5lbvmGYz/DfavkBeN9Z38pQmhJrF7OY=;
        b=lmeVY484HGXcZQ0G64EO2Z3nWZkGneRA80NdcIdEB/6h0WbEjgHFOM72b5Cb1wlK40
         V6EA2CRscC+lhGQ+EFTbsaE0edHKpIo1R1y0S3/SIu0wRdpsNDeVXcyYSZrEAmf42DwI
         EvieD7P6jte7ilqhbvFurCW0elvV8lCM7lIHJN5IO0d1uCwMHpduiZwSNyBnvXn+jyfc
         OVMJ/K/92XgO/4hmD0pazBTL5pbUfEC5WTX63AkXQOJUf+AfQyomjHe2Ut6P4uUzsGA6
         3byVje/5XlT4jlZzx74d2EYItgSDQuG0wQlHd/BvZ+CSgSoFKwJZLLCI8XICGyW84/e8
         Vc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757332735; x=1757937535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRM+uyebU2Rj5lbvmGYz/DfavkBeN9Z38pQmhJrF7OY=;
        b=kMiWqNld08kiJlwIm8fIexBuG0k03GG0JxBIz+o6eSU26FekfmbLr6etifZoK310UY
         RfwrYkkPuP0GtrwDiG+W9LDDPR8SNANpJqUVujjCscA0QTOurylILQi+oDy2uEXe/Aju
         Q5RXlIua4f8/rinta1kTOqsft6Pm9kFIbMgjg2At8U5eow7RiMKzUIzwkmdGnCeS2uPA
         MEuC8YuQuXe8pVbTP0P5K0oOWyX7ITuTXmLK0uXOelnK4sURxd/7E5uuRO3UGoDfPN1B
         KkE8dJ5Q5IJbrV9w8tMmQ4/G/gDWIneJw9zaj/pLGHzx4z6gw+0JkxkvpYdBU6wbuhQk
         HXAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhMlMu27QGNAnMIClsXb9e5FDSN74xwQO7D/caoLxm1Yfdgg5bbI1kCxUtfAss0MLDjePN/FsQ4FwfHKg=@vger.kernel.org, AJvYcCWvAjOcQ/0YCKVnU2/xPf0JRCTlN/MO2MxTMvdFHLRBCNTzV37NnJ/HJHHBAFv5EUTywfSu+TPk@vger.kernel.org
X-Gm-Message-State: AOJu0YyrCNUnT2EPDFpJvkfA9Uaji1aCaGTJ17HuJoSYYwzenpGNgWBA
	cG9FTuazmZBAjRODhllA6s1mzVeUTjtxjhkYxIOuZMWoCeVWJBHQt2o=
X-Gm-Gg: ASbGncv9yotBEhwh7Mzu3r23W/Sf4I+40DHX9Vol3E2eE5XgznpoOWtTOfbFat59qYQ
	XoVALg00zvfKp9fEPeCerHDGXC52G+mWlCnVdDQR2WOXLvH0O38QgPdyLbcfH0ZT7bTeKK234Zh
	hPsgWVgVEt3zKOY/mgghOpjbwaCep29iaUlCOkQJxTNy/DKM3Rm03uvDrTKR28RHXcWRGXwNPMb
	aKWlNM/WAJVug/ZzZYiOoz11dCck3KopxWE+wIZTfzPTyrTeGMCB8RNU6Pqtrc43G2VkClMd8kQ
	1GK8vQAjEjJlnXyu8l//c6Expg3diksuAaqvj21DGY/l+YZg5pTE2ksFiqnRJe7TrXT7KqaPKRF
	/QML+xPCLrXCwDM38K5jLm7Ra/b/q3VhFQLd/USdIpHvUtt3J0OYoaSfF1znsSEB8u/z2AMKEdx
	ahCwqKN9837A==
X-Google-Smtp-Source: AGHT+IFZgWcpxr6NhhjmxZvbiZnvCl/sZZdpHsCBeK240GnMFcxyIzd1XotzPDvdvGrx0kcUWiMGQw==
X-Received: by 2002:a05:600c:1f90:b0:45b:8f11:8e00 with SMTP id 5b1f17b1804b1-45dddee8f49mr54141185e9.37.1757332734483;
        Mon, 08 Sep 2025 04:58:54 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac262.dip0.t-ipconnect.de. [91.42.194.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e12444de96sm16556416f8f.19.2025.09.08.04.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 04:58:54 -0700 (PDT)
Message-ID: <09016717-6ae6-43d8-8985-54562dbbf956@googlemail.com>
Date: Mon, 8 Sep 2025 13:58:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250907195615.802693401@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 07.09.2025 um 21:57 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
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

