Return-Path: <stable+bounces-196590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAEAC7C934
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 08:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB0D334E5FF
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 07:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008202F532F;
	Sat, 22 Nov 2025 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NsYImGrx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316B52F12C8
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 07:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763795527; cv=none; b=D4S3JgIjAKLuL6UMqTX+MaKezxr2Lgu2DhHdMz8weQVqpGipJmIxxnMwBbXb1UPOmzNPd5t88ZcpFlQnmpiYnTeMsBYuh4xZOk4P7K3Lo8Udze0CYpbN/OhFQfqepyRnNE+A+IOczZ2obLKihRapzzsQjsvRO9o5Hwg/HDQ30ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763795527; c=relaxed/simple;
	bh=ectZ6e4VQCoL5T9VJpM/UGLbJ+XWr+oyJ/8TtZUuXs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFJHQKyD1N7xTjCwHVGkDzmaTA362Y+8vg+vz1LGVpNny2RYAspbfym8w6+Gv9DW/WAMkwGahKUVMg5rMnVQXiffAq8N8em/NHV+VHLqPL4hNavz7R/Ek5gzu69pf+yzVRUCnx3P8nVDnE8CqC7ZEqTWohHGx9M9YwZeVEEQT3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NsYImGrx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3108f41fso1659421f8f.3
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 23:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1763795524; x=1764400324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=US4Mpay2gyE8FdY72ARKmQUOFz15hL9jcMS+fDMwc/0=;
        b=NsYImGrxWVfXLJ2vbA909308qrqKVCDQpwNXaGgvG2uFLlJ9JTX400CclJjBb2Gu6/
         I0TWRr9I1mv0Tjr+WFAhAg2MPDyIiIN4U1bdCLFQyZ6vN6R3DziSlZ4aRl8jcelZP8I7
         3cxsQ4QcukSWMfkkGvvvglwNi3I0tcuhzuMjmn3p7Os6iec/C9JcI5nq1NHmBldZq/7r
         5BPUmMzfnVKB3JAG/45tUIXtoYseamTTe7Bn1dls2fnD8iloZKvnszSxYc/vRZ2CR3D4
         ogiBzzcG6+eYXwvZBQTDPShbaAWavEv/U0v52xGc5FduHOf3AII6wm3yNZxTnaJkXNV6
         29ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763795524; x=1764400324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=US4Mpay2gyE8FdY72ARKmQUOFz15hL9jcMS+fDMwc/0=;
        b=WomdKHdkSNDKTRvZHLdQ8QShgoC8fz/2M28L//4Z4eubRRIh9+LtrzeD0C71I5L+ox
         ic66Rtx9xuDS3JH2dLTszueuckVb53VHfibHHI2f5g/QC6HfMI1q1MyejKK0UeywLm9U
         +27vRpDHjKkBZgmD4HMNrnSoDBLViRehuR5X2X8Wpf1uyPxuTFHulXP07ToK1lcbD1lH
         5bSYUIF2kCpQ5cqnWoIJ3y3D+ZiSxaOG2WjNjPNOegQpe1uozXdgA87V8np8f06nF0zh
         e+ztJ00JljYaTWErZom5oTi+nWPP95PyEDz/52807wy+qm1IlcLxaNbkUuvDErDp31Ef
         b4iw==
X-Forwarded-Encrypted: i=1; AJvYcCUGfCuMZ+tBqUBCTXvQbfW4PvJbBRtQqakd6HfecbXZktBQNbqO8439eLj19qAwisJF4KVwJfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8xZvETr7hZThPQX2M4B6MduVJtvCSm/j1wzCcK/xcfk4qnIVq
	UjRXUrwzSH3lJ6/dDwMAuEIpao+GAmjdle/PRG6uw32Sc8vqdtFYyyw=
X-Gm-Gg: ASbGnctLK7V8NGLnSpHffBVWA/ilPywU5qNX9XBXL+tey8/QlMPbAyqh4KwOpurFJLV
	y1DLG7pAciZsBke2tPBWqWiIbXOTfpcKop/2ESni5y4h7m4EPeIUgiHSdhDF7gp9XpiZk2fDzuO
	6V9mn9JNsFRk+2WA2TyNjOIOgDwSNhUciIi5igB3wEBX6xsXg925TsYtMYgTIiAccI8g5fii6ev
	J7EWSmrzIUCdK0mRB4ECURUskePkFFbrDlep9S41NQgH6SnTp4mDDjjCXPt5AIt/gYTtRjoiqSx
	XzDXQ1+w1dxd2sNs97vHM4UxOj+9JnfPh5iLFtoRgVi/hHAppVOR1zVBaJHi45ytsRJrMo1BaTh
	QqIFVa1plzkdGr3uWWYTRTVlTV9AB1iwE9I4YNqmxPMmM/zYKallB8U3o1+HOaTKovUG8KhN9eG
	RxjCLw7RkgHSoUJ4d6QdveIiWgSDcZCI/+K6166kEoal4XHKzQ+IpDoRPO4BQZFA==
X-Google-Smtp-Source: AGHT+IE+1loCPHVNjxUG1NMgfGNWPNXt8w91CYkqgdahYUVagi55K5gXVc8gxXcnUGcXCGgbJClM8w==
X-Received: by 2002:a5d:588b:0:b0:429:d4e1:cbb5 with SMTP id ffacd0b85a97d-42cc1abe044mr5102430f8f.8.1763795524279;
        Fri, 21 Nov 2025 23:12:04 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac108.dip0.t-ipconnect.de. [91.42.193.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3592sm14670912f8f.21.2025.11.21.23.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 23:12:03 -0800 (PST)
Message-ID: <02cb91f9-400a-4b3b-86aa-e8eef9746ce8@googlemail.com>
Date: Sat, 22 Nov 2025 08:12:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/529] 6.6.117-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251121130230.985163914@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251121130230.985163914@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 21.11.2025 um 14:04 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.117 release.
> There are 529 patches in this series, all will be posted as a response
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

