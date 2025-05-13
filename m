Return-Path: <stable+bounces-144201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CD0AB5B34
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4819861E11
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53C92BF3C7;
	Tue, 13 May 2025 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MukKR8ca"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E91E1C3F;
	Tue, 13 May 2025 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157270; cv=none; b=rSa2rXaYTTRZ9yatmVV387s0+qe/qS9NxolccfQuo1oV6ato/iWA4Ev5xQaKhQYgXsRaVP2Shsro0n/IX4EgCZMj2K4Txw9OneeFBY89sci3doE9iHpHm4pUN27tHmSkq21GF8EGe9yBLFGBo7GD9jVA6LSdudOymAw0eTU5quw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157270; c=relaxed/simple;
	bh=FH/Y6BLNrOTT9W7duN+j98E3MgnT28o5K5q/3gQVaYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mMU7ktAHh4ItRi4iqj0TQ35LA1XkqRLhIdXhER9CQpaT5ARbQeApNdUMIHFS8X0+09kaWeiH7dCwRvvGGwL4IYlL/jYBK8aUWZ3vtueji1lcKwdlOxiErBNW72KNgkuEQv1rhhwLREdRxpsk46ixKetrvhxVV46NF1V2GxTFRRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MukKR8ca; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0b7fbdde7so5716273f8f.2;
        Tue, 13 May 2025 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1747157267; x=1747762067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hFHTl3sxSxODJRQX3dUP/vUJz2dgKyxhXi4v/Imnz0w=;
        b=MukKR8ca04P1C8my8Xxt1gL+DEc4/LSfuAvxErVCXrqNi11tNK5jnd7inWapZ4v9s2
         /exyYogFpj/lOGMcmLqkLv8dvNm2COP/wa9x/WZeuyyyHOmSyZ8Ef/2LgV7ciEvWcXt6
         Ycg+DsaHeezqUvuHf+ykkE7WeLLRath0yP/B4kyIBqAH9Kh76mXPAvWtKEMcLASE9ewy
         m6zCWgBD51L+u1Jc7fUmzQklwmbIOsdxWpuny1rYmHI2Yo3zjpMhg6thAHZXL47Ej3P/
         EocPxZAAPFVzeuPilbWOzbR7ZGF/SOjq4wLtlMq3caaCxU5zoIAMLMCJAfuRckH1Qie/
         oaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747157267; x=1747762067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFHTl3sxSxODJRQX3dUP/vUJz2dgKyxhXi4v/Imnz0w=;
        b=K5s6ecyNBiN+jACucHiKGyZa/HTZVTQ9sHGSTTgIwM7877ZLV1ov12eRtLJyfoYE+5
         bkcYKNAU4N9bhm2dZnG9v/k8s0EoriGAaw+3sVKsH+u5/kqkUyPms7DMODZ5Z+y19H4g
         NkjKuCXe8yLUDQzdFzHnU8i+bbjTdybIKpCnuO1xJmGZSrpYy/aAgyzHBrmck9EqxfkC
         vVq2XZa/fMSOanlRec+7Zmcui+LHlg5xHGxJrMkleDeNh1UeSvb90EORhfush32p6NAL
         4BA8PJ4RWdV1sj4ALWSNwMa+Dmiyr5ODIlfakyMPZ4ii0Q0chfEXbdiZ02B8uMg5A7eI
         57YA==
X-Forwarded-Encrypted: i=1; AJvYcCWD3xeQ2cLSn3yXmKQdpm6ygfu48dWOdhEZ8InWcr6iaG7SBGQChNQSuOWUAePbqkO8q4QIJZwlwpKHilc=@vger.kernel.org, AJvYcCWy2nSMRdW41fpQhe4eEHtkBm73+jPl2cTHQCeyxwxynNuEZZDE9VFaBhfN2jHbcK2RBbiqw/lc@vger.kernel.org
X-Gm-Message-State: AOJu0YxDODzyVvoZ1PwL6zVYyjFmn+LJ2VZvfZ6Ef3M2xgBWaq3mCl8b
	ypY6djwpos7dIbvQ6XGFM6rUOopKXlhl5D9idFM9NSKYevZbHkM=
X-Gm-Gg: ASbGncsMavfaZjbZbVIF0tuZ7F0nZM+9Cxe/RD2BRnKg9iVqI533B23soaToZe0bfnC
	aknFy5BK4hUI5wOCKWc9KrBKkOEe9rjCBUhEqM59e0MIgICkCMRPLrQ2ovFOtwx8NgITiS8y/0J
	GYNz8GjzNkkM2CLrd98gUnUtTL2BRCxAf5tEL9/OWzEsqrSCueYhYdLwP2GVq+Ln90HTseD3gWG
	sXob1PU/WZTSQOnsSHupdHTAhXa3wgz/AgwM7tf7BllP3qZTxJHF40pOUPvl1rWkn73RAp7Aa3P
	KxHBhckIlFg/EW2YvLTaBiF4Cl7Uw1WU8HyOqDT2YbPCo+f+GKJOy9qab4HRJF8t2g+TaYDnXgo
	WpPYijvT43Y3luLAgOeRmvaInNdCgP1EvxrTHAg==
X-Google-Smtp-Source: AGHT+IFegG3B9AB/jeEdVB8RF7vW8stTIvGIveMzhDquGXnh/dkqV/LjdBREIB52qYe2+5DtyQurJQ==
X-Received: by 2002:a05:6000:381:b0:3a2:229:2a4d with SMTP id ffacd0b85a97d-3a3496a49fdmr126321f8f.22.1747157267140;
        Tue, 13 May 2025 10:27:47 -0700 (PDT)
Received: from [192.168.1.3] (p5b2ac006.dip0.t-ipconnect.de. [91.42.192.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57dde0esm17197357f8f.18.2025.05.13.10.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 10:27:46 -0700 (PDT)
Message-ID: <7e1d47bc-a30f-45c6-9f14-820e96f144aa@googlemail.com>
Date: Tue, 13 May 2025 19:27:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250512172044.326436266@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.05.2025 um 19:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.14.7 release.
> There are 197 patches in this series, all will be posted as a response
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

