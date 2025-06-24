Return-Path: <stable+bounces-158420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FABAE69E7
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E200D1C24699
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEE82E2EF9;
	Tue, 24 Jun 2025 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gmyDYhfF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229792E3377;
	Tue, 24 Jun 2025 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776206; cv=none; b=Vft7VQ3XzJqfWywYt35i+1hvqhnMh7hsEhC5THPg0P3DorKkFeuqnYcjRilipr2yU0mtY42QAq+CqokEXfQYOeHMtqDkP8IwgVFKvrd74RX3AGilRGYQadQMtD2Gx7RgkO0LPnNtz7zauekFydv8OHKFN9XdXLhO+n26ClWabio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776206; c=relaxed/simple;
	bh=DctmSIX4517I3MA7ZTbTzD2Ov8TWIGaK5Jvg0SDP+i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3VQN4TDx3MqPGGZYQE0mGbAu8otZqyVVfuCmEBBeKpvfr+IqvCYklzs9bJ5arVMS1x2gvz7yk6TnxJem/JxD1iD/m0q6inA0oMHz87sLOqHtBktdJ6GyeF46fCEp4QSHlBZuPm51TqFxC2or3IHMKUsp99pteWO7CcH0fV89Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gmyDYhfF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451d6ade159so40963405e9.1;
        Tue, 24 Jun 2025 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1750776203; x=1751381003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+71XVf5M0IdQ6sdhaRf75cgMjNjt33ZDG+WbL/ULBM=;
        b=gmyDYhfF1mJ+cxohMSmjecQI1IOqIv0mvSQavrD+KSAwdtQsVSP4OQQPRX0RTrY5t7
         6mUGujkmDEytbJgSfUDuvDSnByhUG5ymAD4H3lxkI7mt86SQbjHPEHXM2uI2mGzB6oP8
         c9GruUttt0fuc41xSy9iMrYoe5jUxfqg2rf8tqDmZyp/Z3bMy4sWwKPL0otSc/DHFBlK
         5eYhErjfTivl5yJRQwd85ffPUMUEHwJDtOGHOwvYkWldzOedYNLJRNGM4Y7xtoNYogsf
         lxEAJ+x+/r+kSii5wcEdqlxGOymZBC2J2XVHpI/PeUgqFq2NLaOgB+W8to5jTxjoQUPz
         zUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750776203; x=1751381003;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+71XVf5M0IdQ6sdhaRf75cgMjNjt33ZDG+WbL/ULBM=;
        b=UcKBP3bqx1Xq/aZmp6zLrp8v+jfLjB2I9b9EQTXPMKfyjxKLlfo/vaHdk/IXCllLiW
         y6+VCr30QkqzUIKvkTk0rZvyl4kXS11KIZcDxvRxi8z+ylglZullcCOoq2LLLQZtEnn5
         1QauM0RIdwzh+7S7d4FTLbia7K9/1Gc3qmsASu/9pbg/dOEVX2bxEAG1/C2bl0T6qmf2
         Z2MiLkebXfwlq8+VE0AEesjv4m5O7f3+k0eFX9DY55HoN1vFkkeLLFUzoCgPnWy9ymKo
         LYBnywYn43AF/oCtXbvyAjevJUSuQqIAprwl2+wfhbZu+KJuIkmiSLiets+lz/hLws4U
         09kw==
X-Forwarded-Encrypted: i=1; AJvYcCUkZNtLdksb6oPMv3RSNkv3Kyq85y1+0ZzISWf9bFeAWusWdUWGqGgMkh35qI4jxQFdaAk/srx1@vger.kernel.org, AJvYcCWMDQn9ILOc/3iwxtcK7QsziQ1NGRCN/H2hl0ZMK4ZJMzuAu1Uv5foEUuJefbyW9zTks0XVxpZQR41fMUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3LDJpIluLBXxNyTUgbSPL71BCjpejF7fdh+XwJolYCuciIM1a
	PwbRFRcKLoJyrV8gByNxondjxcE/ySV+nxOXoUL0Aamc2Snjoal9F2E=
X-Gm-Gg: ASbGncuNYKpTX025nB1LtTvi52cU0/dQZYNnv+c6A3+s41XyUMvabks3gctUYdwC06K
	cbjnwjJ2ht9jewgj8rgkBzapJiw0Y6I8w+BZx7SvHd9Lv85OjD/k19kM45+tApuNWCm3/O/jA22
	GwuZ4UYM9AObbbnNXx8T0qy/GKzDX7RZJT2TERGfmUjyhHrrkrMdmA6k/xKfsFwAXvqDCEeZFD/
	Hg1+0UxUu66x1t2C6d5tNAJ72MzS5lujeb3xJBSQdG9NoUYcfGuqOyJxDNm5oYs42uvXnaiirky
	jJhQRhTmQdzTKG5/VmT8gViq0UQq3+N7n9FHoxjU+ep2oc+hf1VdRiY3c32Fz117JuY+HY/aLYD
	qCLtZqfGhOeJQyD5WTJuOjaHfVy+bA/Kx4CoAubM=
X-Google-Smtp-Source: AGHT+IH1AKZv1w2WizAwNPmvpDCWlcbWMt2nr5hpnlM9rZmI0Nmt6pxF2lAWecQ2nj2UxxcruNtEmg==
X-Received: by 2002:a05:600c:34c4:b0:450:d30e:ff96 with SMTP id 5b1f17b1804b1-453647921f8mr191327955e9.0.1750776203409;
        Tue, 24 Jun 2025 07:43:23 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd47.dip0.t-ipconnect.de. [91.42.205.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e811049bsm2112651f8f.88.2025.06.24.07.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 07:43:22 -0700 (PDT)
Message-ID: <5a417344-fa3f-4806-a39a-ae2ce58b19a9@googlemail.com>
Date: Tue, 24 Jun 2025 16:43:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/413] 6.12.35-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250624121426.466976226@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250624121426.466976226@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.06.2025 um 14:29 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.35 release.
> There are 413 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 
server. No dmesg oddities or regressions found.

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

