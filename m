Return-Path: <stable+bounces-56909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5D8924D68
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 04:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F72284DED
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 02:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A510C20E6;
	Wed,  3 Jul 2024 02:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nEF6TY86"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC71E4A2D;
	Wed,  3 Jul 2024 02:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719972112; cv=none; b=lkZ5TFO9VOQcl5hGITWSvVTq8iEh3m8Wb0DF3q0ljR2oP29yaYP2ufmYP2UH6J8k1TWuFO3jJNZIKNoHwP+xtOw1rPp50oliy/ux4k05ukJiURacXYnnC5O4ce8v5DSLr20hkAxcJ4l0p2XIC0PmNYn43uiggHk0rOQz/HnCDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719972112; c=relaxed/simple;
	bh=GyxW1LSGZfvU4XebzR5XrdIfOtKNClSFJWryvQ2oIUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgWrdY1yxR7eHRwVNDZvayPEvIM4bj+Cn5WkHypdwRYGYzMUO1jBVwWVn0q5ogI6DtsPRQFIqEqeU5R8GajFlhxra2h3nLTdcxBqVUMsucNEoL1XJxwtj+NBqMc9if/pdB0USXqPo58V/lKhAeCX2ppPPpnGioJIHDLzHyvZ57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nEF6TY86; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5295e488248so6309787e87.2;
        Tue, 02 Jul 2024 19:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1719972109; x=1720576909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZimzjAy3hV40iaFntS7nCwCZ/3PORpa1R7y0lBfvhK4=;
        b=nEF6TY86X84ogUM/bx+52YwZ4Mu4Xit4XSs+rWqmhpRVLfZzG9MCPhyDH1D0bLP9WX
         o3eUWX/vqTgMPnw8vtHmzFWD+mB1e6MRAv/pEuqJgMuKjy5qktMaHefXCcg0C86MKfiu
         s+4pPxO5WBfmTMzJ6QVe38cChVeTeQSk5xsq5PxuV97hfqadUWXjc92irzjG5UQhNoV6
         vBjudI1PAYDvFcZq6IMxtETPGNFkWozXgcPXRQsFckhj7WJ6CMdMhPb0dNRorPRLQafo
         2raEfwruBdQ2WFcK0N499YMI9x3d/6yfR3dx3bFnu2Y4Jvrak54e6Jt0bz36MzyRxwvy
         P5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719972109; x=1720576909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZimzjAy3hV40iaFntS7nCwCZ/3PORpa1R7y0lBfvhK4=;
        b=Xd8w+9mxwPKGIN9Y+cv6b/r3R8IxVlQIOANhnkWVdnbdAb3uJI4vuCRMyRBO/P6eFW
         ScP2+ul1C6pfhdftAcihbumk2MLTtLBggin73moPASQmkQLA5kzReHHWxtsMRPcYAVJy
         yDaKXzTO0vifAaTT3PLVaPVraqr0ERDK69HL9GeTbhwK3/pgVwZxwgauHTS3DzE/5IlA
         8f+vBDoxdqM/iVq5oRkHA3qALFPl0Ngnpkrx+NTg2qKkBTIf6ESlg/rnOzPZA4lEZj/Q
         k+nS2u1fzE8gP+PUPSk/f2rq37vjx9BFmwGxljVZcwHxGJn/aMj4htKM6IR/k221TMWV
         gNhg==
X-Forwarded-Encrypted: i=1; AJvYcCUbR9ptK2U0WxDCL951gTvjd7MU7BOlSD35gKVWAYduD5mgRX7/2BWDF9CaW8aJS4f6a7lu2TNjtH8JIt/DpIPlvSrexQSGhUTknSR+t1bqr+sgYvqbJuh1Osmyl4oxzfbPXqRc
X-Gm-Message-State: AOJu0YwZwmDx2dAcrQTsnNoMVlCXVBAqm0NklTkyMpOAnLtHgiz6O0u9
	FOePXAIap8fvMXg1eC02GklGxRAcMsJdXSuvR4kXofqhn4WyH1WIlia8Hok=
X-Google-Smtp-Source: AGHT+IHfhfrPY8oWGWypTj48byXcQCaGINoKBU+zHiwUjmYNFr9TAJEGGv8pRIRMNDJg2zzJWLUbmQ==
X-Received: by 2002:a05:6512:3b81:b0:52c:dc25:d706 with SMTP id 2adb3069b0e04-52e8270172cmr6797187e87.52.1719972108756;
        Tue, 02 Jul 2024 19:01:48 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4fd5.dip0.t-ipconnect.de. [91.43.79.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b061095sm207739955e9.23.2024.07.02.19.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 19:01:47 -0700 (PDT)
Message-ID: <c88b2b98-a1a7-4397-b646-cd75b112dba1@googlemail.com>
Date: Wed, 3 Jul 2024 04:01:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/128] 6.1.97-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240702170226.231899085@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 02.07.2024 um 19:03 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.97 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

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

