Return-Path: <stable+bounces-144105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 754A8AB4BE0
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017E4167014
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 06:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589B01E7C08;
	Tue, 13 May 2025 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egJdDsGq"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF6323D;
	Tue, 13 May 2025 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747117523; cv=none; b=aWP7Da7u1fC6MgSYiuoW8cXEtYFNg2EER/Rg4hrd+wvJauTJfWtLEamm5sAiZcpVOMR7UFvt50puD69hrK70cyuvM81V0aAq7jaCB/H4g6E9By/D1yrS6pm08xaIGMjdtywi9R/WfjRbRMH+sVTb7aweXcwrX9mzFGYSzRSuEWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747117523; c=relaxed/simple;
	bh=AHumA6Yr6/pS8vAr/ck3sCQM3vY1g7wA8pe6gTh3RMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3DG4JIRNozM5+cwABlFCRxm1m/L7uqDgqKiTJTGjAtgPlS4Z+7vnzktv0R/l6KR36EamO3YEEuE7C1bBrVutFTq5HxW73vrm4OiP9ksBhYsF8rqXCHje00BHi3lpIEm4VytkrpMJbs9kR7b5dc7DoRuCQeBbCBrv+WBy89xr2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egJdDsGq; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3fa6c54cc1aso3592756b6e.1;
        Mon, 12 May 2025 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747117520; x=1747722320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+d7AiXMLoB/R6GaZCR9iO4bJ1gIgBKIWJfItI2aaeUM=;
        b=egJdDsGqVpEJTR7UA+Upt4hlblmQ2G70xjKcSR0Ebx8dg5Xkl33K2UO8eBCC16U1Op
         cqRpPRM9DdF8XObVQW6fupAiEmuqxpYgQ/e5BlmNeJvk/Oyx4GQ4sSrBbn+pJigRcMje
         vrlh97kHsQqiMA9hsPS8pyvtTaJF2X09ipm/6w0zpOt9KH9c1XEixfb8GRWjvpt9erZL
         msPKF5wS/Ym+4KsTpGYccmqel6x6vZcm36sb0L2fonDMCsI5PFrSF4K+qhCMLemHOH28
         IChLLRi8mPFqEC5M8VmK7/nJSsMpuS93S3tF1zDsEGZMQooOM1hkqyoaitSzD5YLEScZ
         NjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747117520; x=1747722320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+d7AiXMLoB/R6GaZCR9iO4bJ1gIgBKIWJfItI2aaeUM=;
        b=PcBiXvGjN3GxmWAeACoJRpx1JOd3QbkgZh2BWZPGC3Y17HXe9k/xuXh5UgoXZDrh5s
         C8HonRtEiXLwNt1v6A5+70/2+DwO/Yo+QpXHbGHW2xEKNjpLFNlFR4mgEKXYG+A4EHcK
         FT4Dzr15myGzE1P+tFk2QXUzblHrzNiGJoHTGK9VPosXyuuv8Xrjv7ctK3JN2o4lR63R
         8DgWFNvR3H5yTYd0SZnttWWS8Gm/U848F61Jl6cX+ZJlTr6RMljrGmhDtxeZeCiuiAng
         87LKlN/V4BAGXt7xBPClBCECVjKxcyqulf/v0g/PXwb2CrrSecdleIAqjbZ+T6V1XD8n
         QI9A==
X-Forwarded-Encrypted: i=1; AJvYcCU77wjQM+z/lk+/X5OXRbRhtl81Vft+j0NRySPk6txKesmq+TukXGkD7r52cycLu8tCFI7k4y8P@vger.kernel.org, AJvYcCUh5Gn21l0Kh84xKXCz4AXWyO6Mq2FAln66fqa1yzzBu4za8+h0ccSGabGtOACvguY9MBjIxQs/yNrvQQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWS6VPRWLOgAJPB9xrnKLW8CoOQACqmL0R8apD+p/ebk8MJyM
	FfvNXILLMVKnUHTfRUdfTonosmjYys9HHrr2h/NCP/qVEtDeZLVdFOFNis+pRIBOOBzxSXvJPWH
	IP4zjRriT0ZI92WQUT716h9p9JjDhfxO+gPpofA==
X-Gm-Gg: ASbGncuwQXILZVj2lGkbBDG70fdrcOpTk+SP0maAhcXxwwg5vEcgtaEVwl3Xp0R33fl
	m0BijQAXgEWNlH5UFnlR9CEBsGpsS8876Gq21yVau3Q3wKpCAt53itwu6evd7JPoiuRiH0qDgEK
	aOal0f1u3XPeoBt0LHmaE1+RsIqczQiSaZI6nq5yK3DGhIVH0=
X-Google-Smtp-Source: AGHT+IG0k9n49cOjh73xTLTAVsRne2xlZWGuWDYYRqk0/LfFX1W3pBb5d3DQiusB5b+lH51H0KyvWCzJsuMO6T8mKkc=
X-Received: by 2002:a17:902:cf07:b0:224:24d3:6103 with SMTP id
 d9443c01a7336-22fc8e995a8mr296351835ad.35.1747117509885; Mon, 12 May 2025
 23:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512172044.326436266@linuxfoundation.org> <32c592ea-0afd-4753-a81d-73021b8e193c@heusel.eu>
In-Reply-To: <32c592ea-0afd-4753-a81d-73021b8e193c@heusel.eu>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 13 May 2025 08:24:57 +0200
X-Gm-Features: AX0GCFtNwSVq55Z4HzqwiHR_CnV-BQg0ApDjFN6fcXXXh16PBFZM7YxQnupqCXg
Message-ID: <CADo9pHh6WZruG7XCO74RBbXRcd8d1KktTZAhG4FNXzv6ZpjVHA@mail.gmail.com>
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
To: Christian Heusel <christian@heusel.eu>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Ray Wu <ray.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yeah getting that too


[   21.463202] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.464700] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.466133] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.467631] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.469127] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.470631] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.472127] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.473624] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.475130] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.476631] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.478127] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.479624] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.481126] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.482623] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.484130] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.485630] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.487127] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.488630] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.490125] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.491633] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.493120] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.494642] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.496128] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.497632] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.499128] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.500633] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.502130] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.503631] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.505126] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.506629] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.508127] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   21.509647] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: AUX reply
command not ACK: 0x01.
[   22.259286] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.259935] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.260583] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.261234] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.261883] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.262533] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.263185] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.263835] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.264481] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.265128] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.265771] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.266323] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.266970] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.267616] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.268270] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.268918] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.269567] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.270213] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.270857] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.271506] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.272154] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.272802] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.273450] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.274097] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.274745] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.275393] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.276039] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.276682] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.277274] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.277916] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.278563] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   22.279210] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.335457] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.336103] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.336745] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.337387] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.338029] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.338676] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.339271] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.339922] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.340570] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.341216] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.341864] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.342512] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.343159] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.343806] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.344456] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.345279] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.345929] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.346579] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.347232] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.347878] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.348526] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.349173] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.349816] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.350458] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.351100] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.351743] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.352390] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.353039] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.353685] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.354273] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.354920] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4
[   27.355567] amdgpu 0000:08:00.0: amdgpu: [drm] amdgpu: DP AUX transfer f=
ail:4


but other then that it seems to work

Den tis 13 maj 2025 kl 07:26 skrev Christian Heusel <christian@heusel.eu>:
>
> On 25/05/12 07:37PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.14.7 release.
> > There are 197 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> > Anything received after that time might be too late.
>
> Hello everyone,
>
> I have noticed that the following commit produces a whole bunch of lines
> in my journal, which looks like an error for me:
>
> > Wayne Lin <Wayne.Lin@amd.com>
> >     drm/amd/display: Fix wrong handling for AUX_DEFER case
>
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX reply command not ACK: 0x0=
1.
> amdgpu 0000:04:00.0: amdgpu: [drm] amdgpu: AUX partially written
>
> this does not seem to be serious, i.e. the system otherwise works as
> intended but it's still noteworthy. Is there a dependency commit missing
> maybe? From the code it looks like it was meant to be this way =F0=9F=A4=
=94
>
> You can find a full journal here, with the logspammed parts in
> highlight:
> https://gist.github.com/christian-heusel/e8418bbdca097871489a31d79ed166d6=
#file-dmesg-log-L854-L981
>
> Cheers,
> Chris

